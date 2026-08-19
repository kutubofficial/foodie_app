class RestaurantData {
  const RestaurantData({
    required this.name,
    required this.imagePath,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    required this.cuisines,
    required this.location,
    required this.priceForTwo,
    required this.deliveryTime,
    this.discountTag,
  });

  final String name;
  final String imagePath;
  final double rating;
  final String reviewCount;
  final double distanceKm;
  final String cuisines;
  final String location;
  final int priceForTwo;
  final String deliveryTime;
  final String? discountTag;
}