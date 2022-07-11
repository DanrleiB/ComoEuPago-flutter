import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Results extends StatefulWidget {
  Results(this.result, this.finalValue, {Key? key}) : super(key: key);

  double result;
  double finalValue;
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  String getResult() {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(widget.result);
  }

  String getFinalValue() {
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(widget.finalValue);
  }

  String economize() {
    double economize = widget.result - widget.finalValue;
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return formatter.format(economize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Text('Resultado'),
            SizedBox(
              width: 5,
            ),
            Icon(Icons.monetization_on, size: 30,)
          ],
        ),
      ),
      body: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                'Se você utilizar o Valor da compra a Vista no modelo de seu investimeto, ao final do tempo da opção de pagamento parcelado, o valor final do investimento sera:',
                style: GoogleFonts.adamina(),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                getResult(),
                style: GoogleFonts.adamina(fontSize: 16, color: Colors.blue),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'O valor final da compra parcelada é de:',
                style: GoogleFonts.adamina(),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                getFinalValue(),
                style: GoogleFonts.adamina(fontSize: 16, color: Colors.green),
              ),
              const SizedBox(
                height: 15,
              ),
              widget.result > widget.finalValue
                  ? Text(
                      'Como o valor da aplicação é maior que o valor da compra, para essa compra é mais vantajoso a compra parcelada, pois voce estaria economizando ${economize()}',
                      style: GoogleFonts.adamina(),
                    )
                  : widget.result < widget.finalValue
                      ? Text(
                          'Como o valor da compra é maior que o valor investido, é mais vantajoso a compra a vista do produto',
                          style: GoogleFonts.adamina(),
                        )
                      : Text(
                          'Como ambos os valores sao iguais, nenhum dos modelos de compra aprensenta vantagem, o indicado é o que mais se encaixa na economia do usuário',
                          style: GoogleFonts.adamina(),
                        ),
              const SizedBox(
                height: 15,
              ),
              // widget.result == widget.finalValue
              //     ? Text(
              //         'Como ambos os valores sao iguais, nenhum dos modelos de compra aprensenta vantagem, o indicado é o que mais se encaixa na economia do usuárik',
              //         style: GoogleFonts.adamina(),
              //       )
              //     : const Text(''),
            ],
          ),
        ),
      ),
    );
  }
}
