import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Coin extends Equatable {
  final String name;
  final String fullName;
  final double price;
  final String urlImage;

  Coin(
      {@required this.name,
      @required this.fullName,
      @required this.price,
      this.urlImage});

  @override
  // TODO: implement props
  List<Object> get props => [name, fullName, price, urlImage];

  //when we compare coin1 and coin2 we don't need to compare
// coin1.name == coin2.name & coin1.fullName == coin2.fullName ....

  //using for printing coin object.
  @override
  String toString() {
    // TODO: implement toString
    return 'Coin {name: $name, fullName: $fullName, price: $price, urlImage: $urlImage}';
  }

  String get getImageUrl {
    return "https://www.cryptocompare.com" + this.urlImage;
  }

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        name: json['CoinInfo']['Name'] as String,
        fullName: json['CoinInfo']['FullName'] as String,
        price: (json['RAW']['USD']['PRICE'] as num).toDouble(),
        urlImage: json['RAW']['USD']['IMAGEURL']);
  }
}
