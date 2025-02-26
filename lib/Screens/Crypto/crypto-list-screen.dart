import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Provider/crypto-provider.dart';
import 'crypto-details-screen.dart';

class CryptoListScreen extends StatefulWidget {
  @override
  _CryptoListScreenState createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    // Fetch initial data after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CryptoProvider>(context, listen: false).fetchCryptoData();
    });
  }

  void _onScroll() {
    final provider = Provider.of<CryptoProvider>(context, listen: false);
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      if (provider.hasMore && !provider.isLoading) {
        provider.loadMore();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cryptoProvider = Provider.of<CryptoProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Crypto Prices", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        backgroundColor: Colors.deepPurple,
        onPressed: () => cryptoProvider.resetPagination(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: cryptoProvider.isLoading && cryptoProvider.cryptos.isEmpty
            ? Center(child: CircularProgressIndicator())
            : cryptoProvider.errorMessage.isNotEmpty
            ? Center(child: Text(cryptoProvider.errorMessage, style: TextStyle(color: Colors.red, fontSize: 16)))
            : GridView.builder(
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // ✅ Shows 2 cards per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.85, // ✅ Adjusts card height
          ),
          itemCount: cryptoProvider.cryptos.length + (cryptoProvider.hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == cryptoProvider.cryptos.length) {
              return Center(child: CircularProgressIndicator());
            }
            final crypto = cryptoProvider.cryptos[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CryptoDetailScreen(
                        cryptoId: crypto['id'], cryptoName: crypto['name']),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(crypto['image'], height: 50),
                      SizedBox(height: 10),
                      Text(crypto['name'], style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Text("\$${crypto['current_price']}", style: TextStyle(fontSize: 14, color: Colors.green)),
                      SizedBox(height: 10),
                      Icon(Icons.trending_up, color: Colors.blue, size: 30),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
