import 'package:flutter/material.dart';

void main() => runApp(SorunCozApp());

class SorunCozApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HakimEkrani(),
    );
  }
}

class HakimEkrani extends StatefulWidget {
  @override
  _HakimEkraniState createState() => _HakimEkraniState();
}

class _HakimEkraniState extends State<HakimEkrani> {
  int asama = 1; 
  String sorun = "";
  String ad1 = "";
  String ad2 = "";
  String cevap1 = ""; // "Ben" veya "O"
  String cevap2 = ""; // "Ben" veya "O"
  String sonucMesaji = "";

  void kararVer() {
    setState(() {
      if (cevap1 == "O" && cevap2 == "O") {
        sonucMesaji = "Hakim: Biriniz yalan söylüyorsunuz! Kimin yıkadığını dürüstçe söyleyene kadar buradayız.";
        asama = 3; // Sorguya geri dön
      } else if (cevap1 == "O" && cevap2 == "Ben") {
        sonucMesaji = "Hakim: Dün $ad2 yıkamış. Adalet yerini bulsun; bugün bulaşıkları $ad1 yıkayacak!";
        asama = 4;
      } else if (cevap1 == "Ben" && cevap2 == "O") {
        sonucMesaji = "Hakim: Dün $ad1 yıkamış. O halde bugün sıra sende $ad2, bulaşıklar senin!";
        asama = 4;
      } else {
        sonucMesaji = "Hakim: İkiniz de 'ben yıkadım' diyorsunuz... Bu ne fedakarlık! Madem öyle, bugün de beraber yıkayın!";
        asama = 4;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sorunu Çöz Hadi")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(Icons.gavel, size: 80, color: Colors.indigo), // Buraya daha sonra hakim görseli linki eklenebilir
              Text("⚖️ Ciddi Ama Gülümseyen Hakim", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 30),
              
              if (asama == 1) ...[
                Text("Hakim: Hoş geldiniz. Bugün çözmemi istediğiniz sorun nedir?"),
                TextField(decoration: InputDecoration(hintText: "Örn: Bulaşıkları kim yıkayacak?"), onChanged: (v) => sorun = v),
                SizedBox(height: 20),
                ElevatedButton(onPressed: () => setState(() => asama = 2), child: Text("Kişileri Tanıt")),
              ] 
              else if (asama == 2) ...[
                Text("Hakim: Taraflar isimlerini girsin."),
                TextField(decoration: InputDecoration(labelText: "1. Kişinin Adı"), onChanged: (v) => ad1 = v),
                TextField(decoration: InputDecoration(labelText: "2. Kişinin Adı"), onChanged: (v) => ad2 = v),
                SizedBox(height: 20),
                ElevatedButton(onPressed: () => setState(() => asama = 3), child: Text("Sorguya Başla")),
              ]
              else if (asama == 3) ...[
                Text("Hakim: $ad1, dün bu işi kim yaptı?"),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(onPressed: () => cevap1 = "Ben", child: Text("Ben yaptım")),
                  SizedBox(width: 10),
                  ElevatedButton(onPressed: () => cevap1 = "O", child: Text("$ad2 yaptı")),
                ]),
                SizedBox(height: 30),
                Text("Hakim: $ad2, peki ya sen? Dün kim yaptı?"),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  ElevatedButton(onPressed: () => cevap2 = "Ben", child: Text("Ben yaptım")),
                  SizedBox(width: 10),
                  ElevatedButton(onPressed: () => cevap2 = "O", child: Text("$ad1 yaptı")),
                ]),
                SizedBox(height: 30),
                ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), 
                  onPressed: kararVer, child: Text("Hakim Kararını Ver!")),
              ]
              else if (asama == 4) ...[
                Container(
                  padding: EdgeInsets.all(15),
                  color: Colors.amber.shade100,
                  child: Text(sonucMesaji, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
                SizedBox(height: 20),
                ElevatedButton(onPressed: () => setState(() { asama = 1; sorun = ""; }), child: Text("Yeni Sorun")),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
