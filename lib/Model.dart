class Item {
  final String imageUrl;
  final String name;
  final String price;
  final double rating;
  final DateTime packedTime;
  final int noOfOrders;
  final int stockValue;

  Item(this.imageUrl, this.name, this.price, this.rating, this.packedTime,
      this.noOfOrders, this.stockValue);

  // Map toMap() {
  //   return {
  //     'imageUrl': imageUrl,
  //     'name': name,
  //     'price': price,
  //     'rating': rating,
  //     'packedTime': packedTime,
  //     'noOfOrders': noOfOrders,
  //     'stockValue': stockValue
  //   };
  // }
}

class UserRating {
  final String userName;
  final double rating;
  final DateTime date;
  final String description;

  UserRating(this.userName, this.rating, this.date, this.description);
}
