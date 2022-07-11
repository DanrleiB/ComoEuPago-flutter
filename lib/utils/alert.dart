import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

alertInfos(BuildContext context, String msg, {int? alertType}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: alertType == 1
              ? const Icon(
                  Icons.sentiment_dissatisfied_outlined,
                  size: 50,
                  color: Colors.red,
                )
              : alertType == 2
                  ? const Icon(
                      Icons.sentiment_neutral_outlined,
                      size: 50,
                      color: Colors.amber,
                    )
                  : alertType == 6
                      ? const Icon(
                          Icons.sentiment_satisfied_outlined,
                          size: 50,
                          color: Colors.blue,
                        )
                      : const Icon(
                          Icons.moving,
                          size: 50,
                          color: Colors.green,
                        ),
          content: Text(
            msg,
            style: GoogleFonts.acme(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}

alerAbout(BuildContext context, String msg, {int? alertType}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text('Sobre o App', style: GoogleFonts.acme(color: Colors.green, fontSize: 20)),
          content: Text(
            msg,
            style: GoogleFonts.acme(),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    },
  );
}






