import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CryptoProvider extends ChangeNotifier {
  List<dynamic> _cryptos = [];
  Set<String> _favorites = {};
  bool _isLoading = false;
  String _errorMessage = "";
  int _page = 1;
  final int _perPage = 10;
  bool _hasMore = true;

  List<dynamic> get cryptos => _cryptos;
  Set<String> get favorites => _favorites;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get hasMore => _hasMore;

  Future<void> fetchCryptoData({int page = 1}) async {
    if (_isLoading) return;

    try {
      _isLoading = true;
      _errorMessage = "";
      notifyListeners();

      final url = Uri.parse(
          "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&per_page=$_perPage&page=$page");
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> newData = json.decode(response.body);
        if (newData.isEmpty) {
          _hasMore = false; // No more data to load
        } else {
          if (page == 1) {
            _cryptos = newData;
          } else {
            _cryptos.addAll(newData);
          }
        }
      } else if (response.statusCode == 429) {
        _errorMessage = "Too many requests. Please wait...";
      } else {
        _errorMessage = "Failed to load data: ${response.statusCode}";
      }
    } catch (error) {
      _errorMessage = "Something went wrong! Check your connection.";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void resetPagination() {
    _page = 1;
    _hasMore = true;
    _cryptos.clear();
    fetchCryptoData(page: _page);
  }

  Future<void> loadMore() async {
    if (_isLoading || !_hasMore) return;
    _page++;
    await fetchCryptoData(page: _page);
  }
}
