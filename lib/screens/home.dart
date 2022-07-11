import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;
import 'package:pagamento/screens/results.dart';
import 'package:pagamento/utils/alert.dart';
import 'package:pagamento/widgets/applicationlist.dart';
import 'package:pagamento/widgets/button_calc.dart';
import 'package:pagamento/widgets/textformfield.dart';

var request =
    Uri.parse("https://api.hgbrasil.com/finance?format=json&key=6f301fec");

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final streamController = StreamController<Map>();

Future<Map> getData() async {
  var response = await http.get(request);
  return json.decode(response.body);
}

final price =
    MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
final installmentValue =
    MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');
final installmentNumber = TextEditingController();
final investment =
    MoneyMaskedTextController(decimalSeparator: ',', thousandSeparator: '.');

bool _value = false;
int val = -1;
double? selic;
double? cdi;
double? tr;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    taxas();
  }

  taxas() async {
    Map future = await getData();

    streamController.add(future);
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        title: Text(
          'Vale A pena?',
          style: GoogleFonts.adamina(),
        ),
        actions: [
          IconButton(onPressed: (){
            alerAbout(context, msgAbout());
          }, icon: const Icon(Icons.question_mark_outlined))
        ],
      ),
      body: calculate(),
    );
  }

  calculate() {
    return StreamBuilder<Map>(
      stream: streamController.stream,
      builder: (BuildContext context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                ),
                Center(
                  child: Text(
                    "carregando dados",
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            );

          default:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "erro ao carregar dados",
                  style: TextStyle(color: Colors.green, fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              selic = snapshot.data?["results"]["taxes"][0]["selic"];
              cdi = snapshot.data?["results"]["taxes"][0]["cdi"];
              tr = snapshot.data?["results"]["taxes"][0]["daily_factor"];

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PaymentText('Valor do Produto (com desconto)', price,
                          validate, TextInputType.number),
                      const SizedBox(
                        height: 8,
                      ),
                      PaymentText('Valor das parcelas', installmentValue,
                          validate, TextInputType.number),
                      const SizedBox(
                        height: 8,
                      ),
                      PaymentText(
                        'Número de Parcelas',
                        installmentNumber,
                        validate,
                        TextInputType.number,
                        formType: 1,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Qual sua formas de Investimento?',
                        style: GoogleFonts.adamina(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ApplicationList(
                        "Não aplico meu dinheiro",
                        Radio(
                            value: 1,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 1,
                      ),
                      ApplicationList(
                        "Poupança",
                        Radio(
                            value: 2,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 2,
                      ),
                      ApplicationList(
                        "Tesouro Selic (LFT)",
                        Radio(
                            value: 3,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 3,
                      ),
                      ApplicationList(
                        "CDB de um banco grande (100% CDI)",
                        Radio(
                            value: 4,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 4,
                      ),
                      ApplicationList(
                        "CDB de um banco médio (80% CDI)",
                        Radio(
                            value: 5,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 5,
                      ),
                      ApplicationList(
                        "Investimento Personalizado",
                        Radio(
                            value: 6,
                            groupValue: val,
                            onChanged: (value) => _onChanged(value)),
                        alert: 6,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _value
                          ? PaymentText(
                              'rendimento anual do seu investimento (%)',
                              investment,
                              validate,
                              TextInputType.number,
                              formType: 2,
                            )
                          : const SizedBox(
                              height: 0,
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      ButtonCalc('E ai Vale?', onPressed)
                    ],
                  ),
                ),
              );
            }
        }
      },
    );
  }

  String? validate(String? value) {
    if (value!.isEmpty || value == '0,00') {
      return 'Campo vazio';
    }
    return null;
  }

  _onChanged(int? value) {
    setState(() {
      val = value!;
      _value = false;
    });
    if (value == 6) {
      setState(() {
        _value = true;
      });
    }
  }

  onPressed() {
    if (formkey.currentState!.validate()) {
      double result = 0;
      String priceNewSup = price.text.replaceAll(".", "");
      String priceNew = priceNewSup.replaceAll(",", ".");

      String installmentValueNewSup = installmentValue.text.replaceAll(".", "");
      String installmentValueNew = installmentValueNewSup.replaceAll(",", ".");

      double taxas = int.parse(installmentNumber.text) / 12;
      double finalValue =
          int.parse(installmentNumber.text) * double.parse(installmentValueNew);

      if (val != -1) {
        if (val == 1) {
          result = double.parse(priceNew);
        }
        if (val == 2) {
          if (selic! < 8.5) {
            num jurosMes =
                pow(1 + (((selic! / 100) * 0.7) + (tr!- 1)), taxas);
            result = double.parse(priceNew) * jurosMes;
          }
          if (selic! > 8.5) {
            num jurosMes =
                pow(1 + (((selic! / 100) * 0.5) + (tr!- 1)), taxas);
            result = double.parse(priceNew) * jurosMes;
          }
        }
        if (val == 3) {
          num jurosMes = pow(1 + (selic! / 100), taxas);
          result = double.parse(priceNew) * jurosMes;
        }
        if (val == 4) {
          num jurosMes = pow(1 + (cdi! / 100), taxas);
          result = double.parse(priceNew) * jurosMes;
        }
        if (val == 5) {
          num jurosMes = pow(1 + ((cdi! / 100) * 0.8), taxas);
          result = double.parse(priceNew) * jurosMes;
        }
        if (val == 6) {

            String investmentNew = investment.text.replaceAll(".", "");
            String investmentNew2 = investmentNew.replaceAll(",", ".");

          num meuJuro = double.parse(investmentNew2) / 100;
          num jurosMes = pow(1 + (meuJuro), taxas);
          result = double.parse(priceNew) * jurosMes;
        }

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Results(result, finalValue)));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Você deve escolher algumas das opções de investimento'),
          ),
        );
      }
    }
  }
  
  String msgAbout() {
    return 'Sabe decidir a qual forma de pagamento é mais rentável? Você pode estar perdendo ou economizando dinheiro dependendo o meio de pagamento utilizado. O aplicativo mostra qual meio vai sair mais barato pagando a vista ou parcelado mostrando a melhor opção e o quanto irá economizar na escolha.';
  }
}
