import 'dart:math';

import 'package:cryptocurencydemo/blocs/crypto/crypto_event.dart';
import 'package:cryptocurencydemo/blocs/crypto/crypto_state.dart';
import 'package:cryptocurencydemo/models/coin_model.dart';
import 'package:cryptocurencydemo/repositories/crypto_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CryptoBloc extends Bloc<CryptoEvent, CryptoState> {
  final CryptoRepository _cryptoRepository;
//Make sure that we pass cryptoRepository and it's not null
  CryptoBloc({@required CryptoRepository cryptoRepository})
      : assert(cryptoRepository != null),
        _cryptoRepository = cryptoRepository;

  @override
  // TODO: implement initialState
  CryptoState get initialState => CryptoEmpty();

  @override
  Stream<CryptoState> mapEventToState(CryptoEvent event) async* {
    if (event is AppStarted) {
      //Create function and call here. Using yeild* to call the function
      yield* _mapAppStartedToState();
    } else if (event is RefreshCoins) {
      yield* _getCoins(coins: []);
    } else if (event is LoadMoreCoins) {
      yield* _mapLoadMoreCoinsToState(event);
    }
  }

  //If not put into the method parameter page, then by default it will be 0
  Stream<CryptoState> _getCoins({List<Coin> coins, int page = 0}) async* {
    //Request coins
    try {
      List<Coin> _coins;
      _coins = coins + await _cryptoRepository.getTopCoins(page: page);
      yield CryptoLoaded(coins: _coins);
    } catch (error) {
      yield CryptoError();
    }
  }

  Stream<CryptoState> _mapAppStartedToState() async* {
    yield CryptoLoading();
    yield* _getCoins(coins: []); //Call function
  }

  Stream<CryptoState> _mapLoadMoreCoinsToState(LoadMoreCoins event) async* {
    //perPage is static, so it can called directly from Class. We don't need to create instance of class
    final int nextPage = event.coins.length ~/ CryptoRepository.perPage;
    //In this case: page start from 0, so we can do this way
    yield* _getCoins(coins: event.coins, page: nextPage);
  }
}
