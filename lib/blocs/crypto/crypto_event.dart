import 'package:cryptocurencydemo/models/coin_model.dart';
import 'package:equatable/equatable.dart';

class CryptoEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AppStarted extends CryptoEvent {}

class RefreshCoins extends CryptoEvent {}

class LoadMoreCoins extends CryptoEvent {
  //We must to keep track the coins already in app

  final List<Coin> coins;

  LoadMoreCoins({this.coins});
  @override
  // TODO: implement props
  List<Object> get props => [coins];

  @override
  String toString() {
    // TODO: implement toString
    return 'LoadMoreCoins {coins: $coins}';
  }
}
