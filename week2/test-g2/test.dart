// you function
int calculateDelivery({required int orderPrice, int? deliveryFee, required int freeDeliveryLimit}) {
  if (deliveryFee == null) return 0;
  return (orderPrice >= freeDeliveryLimit) ? deliveryFee = 0 : deliveryFee;
}

void main() {
  Map<String, int> orders = {
    "ORD001": 40,
    "ORD002": 60,
    "ORD003": 25,
    "ORD004": 80,
  };
  int? deliveryFee = 5;
  int freeDeliveryLimit = 50;

  // For each order, compute the delivery price
  // with your function and print it.
  orders.forEach((name, price) {
    int deliveryPrice = calculateDelivery(
      orderPrice: price,
      deliveryFee: deliveryFee,
      freeDeliveryLimit: freeDeliveryLimit,
    );
    print('$name: $deliveryPrice');
  });
}
