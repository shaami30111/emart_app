import 'package:flutter/material.dart';

const Color mainColor = Color(0xFF744BC8);
const Color complColor = Color(0xFF066FE2);
const Color textColorMain = Color(0xFF704CC9);
const Color textColorDark = Color(0xFF3A3E5F);
const Color textColorLight = Color(0xFFB5B5B5);
const Color btnTextColor = Color(0xFF252931);
const Color borderColor = Color(0xFF734BC8);

const Color iconColor = Color(0xFF201F2D);
const Color iconColorSecondary = Color(0xFF161522);
const containerSecondary = Color(0xFFDFDCF5);
const Color btnColor = Color(0xFF292834);
const Color favorite = Color(0xffFFCC00);

const Gradient gradientColor = LinearGradient(
  begin: Alignment(0.00, -1.00),
  end: Alignment(0, 2),
  colors: [mainColor, complColor],
);

const Gradient gradientColorT = LinearGradient(
  begin: Alignment(0.71, -0.71),
  end: Alignment(-0.71, 0.71),
  colors: [
    Color(0xFF744BC8),
    Color(0xFF6C4ECA),
    Color(0xFF6351CC),
    Color(0xFF5A54CE),
    Color(0xFF4B59D2),
    Color(0xFF405CD5),
    Color(0xFF066FE2)
  ],
);

const Gradient gradientColorUn = LinearGradient(
  colors: [
    Color(0xFF101739),
    Color(0xFF101739),
    Color(0xFF101739),
    Color(0xFF101739)
  ],
);

const Gradient butnGradient = LinearGradient(
  begin: Alignment(-1.00, 0.00),
  end: Alignment(1, 0),
  colors: [Color(0xFF76E6A1), Color(0xFF48D9BF), Color(0xFF17CADF)],
);
Gradient lineGradientColor = LinearGradient(
  colors: [
    Colors.white.withOpacity(0.05098039284348488),
    const Color(0x80F5F5F5),
    const Color(0xB3F5F5F5),
    const Color(0x80F5F5F5),
    Colors.white.withOpacity(0.05098039284348488),
  ],
);
