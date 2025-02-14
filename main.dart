import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(
  home: HomePage(),
  debugShowCheckedModeBanner: false,
));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();
  TextEditingController _controller3 = TextEditingController();
  String result = '';

  void calculateFixedDeposit() {
    double depositAmount = double.tryParse(_controller1.text) ?? 0;
    double interestRate = double.tryParse(_controller2.text.replaceAll('%', '').trim()) ?? 0;
    int periods = int.tryParse(_controller3.text) ?? 0;

    if (depositAmount > 0 && interestRate > 0 && periods > 0) {
      // Simple formula: A = P(1 + rt)
      double interest = depositAmount * interestRate * periods / 100;
      double totalAmount = depositAmount + interest;

      setState(() {
        result = 'Maturity Amount: ₹${totalAmount.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        result = 'Please fill in all fields correctly.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.notes,
          size: 30,
          color: Colors.white,
        ),
        toolbarHeight: 80,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Fixed Deposit",
                      style: GoogleFonts.robotoMono(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Calculator",
                      style: GoogleFonts.robotoMono(
                        fontSize: 35,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 10, 40, 0),
            child: Column(
              children: [
                inputField(
                  title: "Deposit Amount: ",
                  controller: _controller1,
                  hintText: "e.g 20000",
                  keyboardType: TextInputType.number,
                ),
                inputField(
                  title: "Annual Interest Rate: ",
                  controller: _controller2,
                  hintText: "e.g 3%",
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
                inputField(
                  title: "Periods in months: ",
                  controller: _controller3,
                  hintText: "e.g 3 months",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: calculateFixedDeposit,
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        "Calculate",
                        style: GoogleFonts.robotoMono(
                          fontSize: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                if (result.isNotEmpty)
                  Text(
                    result,
                    style: GoogleFonts.robotoMono(
                      fontSize: 18,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField({
    required String title,
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.robotoMono(
            fontSize: 20,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: hintText,
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}