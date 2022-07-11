import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pagamento/utils/alert.dart';

class ApplicationList extends StatefulWidget {
  ApplicationList(this.title, this.leading, {Key? key, this.alert})
      : super(key: key);

  String title;
  Radio leading;
  int? alert;

  @override
  State<ApplicationList> createState() => _ApplicationListState();
}

class _ApplicationListState extends State<ApplicationList> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.title, style: GoogleFonts.unna(),),
      leading: widget.leading,
      trailing: Wrap(
        children: [
          IconButton(
            onPressed: () => aletInfo(widget.alert),
            icon: const Icon(Icons.info_outline, color: Colors.redAccent),
          )
        ],
      ),
    );
  }

  void aletInfo(int? alert) {
    if (alert == 1) {
      alertInfos(context,
          'Como assim você ainda NÃO aplica seu dinheiro? bem sem problemas, bora recuperar esse tempo e ter uma renda passiva para a felecidade da sua carteira',
          alertType: 1);
    }
    if (alert == 2) {
      alertInfos(context,
          'Bem, a poupança pode não ser o melhor metodo de aplicar seu dinheiro mas ainda sim é melhor que deixar ele pegando poeira não é? e também pode ser um belo metodo motivação para aplicações mais rentaveis!!',
          alertType: 2);
    }
    if (alert == 3) {
      alertInfos(context,
          'Taxa Selic é a taxa base da economia. A taxa é definida pelo COPOM em reunião a cada 45 dias e é usada como referência para as taxas de juros em empréstimos e investimentos, influenciando também na inflação, câmbio e mercado de credito. O retorno dos títulos do governo de Tesouro Direto é diretamente afetado por mudanças na Selic.');
    }
    if (alert == 4) {
      alertInfos(context,
          'CDB é o investimento quando se "empresta" dinheiro para a instituição bancária realizar suas operações de credito. Em troca o investidor recebe juros com base na DI, taxa de deposito interbancario. Um CDB que paga 100% da CDI significa que o investidor terá rendimentos iguais a essa taxa no tempo.');
    }
    if (alert == 5) {
      alertInfos(context,
          'CDB é o investimento quando se "empresta" dinheiro para a instituição bancária realizar suas operações de credito. Em troca o investidor recebe juros com base na DI, taxa de deposito interbancario. Um CDB que paga 80% da CDI significa que o investidor terá rendimentos equivalentes a 80% dessa taxa no tempo. Geralmente, os grandes bancos acabam pagando menos que 100% da CDI por ter menor risco de credito e ser considerado investimento mais seguro.');
    }
    if (alert == 6) {
      alertInfos(context,
          'Parabéns por buscar sua propria maneira de investir, o show deve continuar',
          alertType: 6);
    }
  }
}
