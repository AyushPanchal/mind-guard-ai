import 'package:flutter/material.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    this.currencySign = "\$",
    required this.price,
    this.isLarge = false,
    this.isLineThrough = false,
    this.maxLines = 1,
  });

  final String currencySign, price;
  final bool isLarge, isLineThrough;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      currencySign + price,
      style: isLarge
          ? Theme.of(context).textTheme.headlineMedium!.apply(
              decoration: isLineThrough ? TextDecoration.lineThrough : null)
          : Theme.of(context).textTheme.titleLarge!.apply(
              decoration: isLineThrough ? TextDecoration.lineThrough : null),
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
