import 'package:flutter/material.dart';

void main() {
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  const FinanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Finance Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FinanceHomePage(),
    );
  }
}

class FinanceHomePage extends StatefulWidget {
  const FinanceHomePage({super.key});

  @override
  _FinanceHomePageState createState() => _FinanceHomePageState();
}

class _FinanceHomePageState extends State<FinanceHomePage> {
  final List<Map<String, dynamic>> transactions = [];
  double totalBalance = 0.0;

  void _addTransaction(String title, double amount) {
    setState(() {
      transactions.add({"title": title, "amount": amount});
      totalBalance += amount;
    });
  }

  void _showAddTransactionDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text("Add Transaction"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: "Amount"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                String title = titleController.text;
                double amount = double.tryParse(amountController.text) ?? 0;
                if (title.isNotEmpty && amount != 0) {
                  _addTransaction(title, amount);
                }
                Navigator.of(ctx).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Finance Tracker")),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Total Balance: \$${totalBalance.toStringAsFixed(2)}",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(transactions[index]['title']),
                    subtitle: Text("Rs{transactions[index]['amount']}"),
                    trailing: Icon(
                      transactions[index]['amount'] >= 0
                          ? Icons.arrow_upward
                          : Icons.arrow_downward,
                      color: transactions[index]['amount'] >= 0
                          ? Colors.green
                          : const Color.fromARGB(255, 14, 1, 0),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTransactionDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
   










