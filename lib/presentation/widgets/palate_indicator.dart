import 'package:flutter/material.dart';
import 'package:mini_zomato_user/domain/entities/restaurant_menu_item.dart';
import 'package:mini_zomato_user/utils/extensions/responsive_extension.dart';

class PalateIndicator extends StatelessWidget {
  final PalateType palateType;
  const PalateIndicator({super.key, required this.palateType});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.rs(20),
      height: context.rs(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.rs(5)),
        border: Border.all(
          color:
              palateType == PalateType.vegetarian ? Colors.green : Colors.red,
          width: context.rs(1),
        ),
      ),
      padding: EdgeInsets.all(context.rs(5)),
      child: Container(
        decoration: ShapeDecoration(
          color:
              palateType == PalateType.vegetarian ? Colors.green : Colors.red,
          shape: CircleBorder(),
        ),
      ),
    );
  }
}
