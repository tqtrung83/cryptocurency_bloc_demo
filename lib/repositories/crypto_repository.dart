import 'dart:convert';

import 'package:cryptocurencydemo/models/coin_model.dart';
import 'package:cryptocurencydemo/repositories/base_crypto_repository.dart';
import 'package:http/http.dart' as http;

class CryptoRepository extends BaseCryptoRepository {
  static const String _baseUrl = 'https://min-api.cryptocompare.com';
  static const int perPage = 20;

  final http.Client _httpClient;

  CryptoRepository({http.Client httpClient})
      : _httpClient = httpClient ?? http.Client();

  @override
  Future<List<Coin>> getTopCoins({int page}) async {
    // TODO: implement getTopCoins
    List<Coin> coins = [];
    // https://min-api.cryptocompare.com/data/top/totalvolfull?limit=10&tsym=USD
    String requestUrl =
        '$_baseUrl/data/top/totalvolfull?limit=$perPage&tsym=USD&page=$page';

    try {
      final response = await _httpClient.get(requestUrl);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        List<dynamic> coinList = data['Data'];
        coinList.forEach((json) => coins.add(Coin.fromJson(json)));

        //   print(coins);
        return coins;
      }
    } catch (error) {
      throw (error);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _httpClient.close();
  }
}
