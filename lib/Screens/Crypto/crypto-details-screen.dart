import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:http/http.dart' as http;

class CryptoDetailScreen extends StatefulWidget {
  final String cryptoId;
  final String cryptoName;

  CryptoDetailScreen({required this.cryptoId, required this.cryptoName});

  @override
  _CryptoDetailScreenState createState() => _CryptoDetailScreenState();
}

class _CryptoDetailScreenState extends State<CryptoDetailScreen> {
  List<ChartData> _priceData = [];
  bool _isLoading = true;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    fetchCryptoChartData();
  }

  Future<void> fetchCryptoChartData() async {
    try {
      final url = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/${widget.cryptoId}/market_chart?vs_currency=usd&days=7");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final prices = data['prices'] as List;

        setState(() {
          _priceData = prices.map((entry) {
            return ChartData(
              DateTime.fromMillisecondsSinceEpoch(entry[0]),
              entry[1].toDouble(),
            );
          }).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = "Failed to load chart data";
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        _errorMessage = "Something went wrong!";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cryptoName, style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : _errorMessage.isNotEmpty
            ? Text(_errorMessage, style: TextStyle(color: Colors.red, fontSize: 16))
            : Padding(
          padding: const EdgeInsets.all(16),
          child: SfCartesianChart(
            primaryXAxis: DateTimeAxis(),
            primaryYAxis: NumericAxis(),
            series: <CartesianSeries>[
              LineSeries<ChartData, DateTime>(
                dataSource: _priceData,
                xValueMapper: (ChartData data, _) => data.date,
                yValueMapper: (ChartData data, _) => data.price,
                color: Colors.blue,
                width: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Model for chart data
class ChartData {
  final DateTime date;
  final double price;
  ChartData(this.date, this.price);
}
