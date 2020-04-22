import 'package:cryptocurencydemo/models/coin_model.dart';
import 'package:equatable/equatable.dart';

class CryptoState extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

//Initial State
class CryptoEmpty extends CryptoState {}

//Fetching coins

class CryptoLoading extends CryptoState {}

//Retrive coins
class CryptoLoaded extends CryptoState {
  final List<Coin> coins;

  CryptoLoaded({this.coins});
  @override
  // TODO: implement props
  List<Object> get props => [coins];
  @override
  String toString() {
    // TODO: implement toString
    return 'CryptoLoaded {coins: $coins}';
  }
}

//Error with API
class CryptoError extends CryptoState {}
