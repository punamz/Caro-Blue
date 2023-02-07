import 'package:caro_game/core/assets.dart';
import 'package:caro_game/core/enum_value.dart';
import 'package:caro_game/src/presentation/view/game/game_ctrl.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameBoardWidget extends GetView<GameController> {
  const GameBoardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: context.theme.colorScheme.primary),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: SingleChildScrollView(
            controller: controller.verticalController,
            child: SingleChildScrollView(
              controller: controller.horizontalController,
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: const FixedColumnWidth(50),
                border: TableBorder.all(color: context.theme.colorScheme.primaryContainer),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: List.generate(
                  controller.mapSize,
                  (indexX) => TableRow(
                    children: List.generate(
                      controller.mapSize,
                      (indexY) => GestureDetector(
                        onTap: () => controller.tickPosition(indexX, indexY),
                        child: SizedBox(
                          height: 50,
                          width: 50,
                          child: Obx(
                            () => DecoratedBox(
                              decoration: BoxDecoration(
                                color: controller.lastOpportunityMove.value != null &&
                                        indexX == controller.lastOpportunityMove.value?.corX &&
                                        indexY == controller.lastOpportunityMove.value?.corY
                                    ? context.theme.colorScheme.secondaryContainer
                                    : null,
                              ),
                              child: Obx(
                                () => CellWidget(value: controller.mapData[indexX][indexY]),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  final CellValue value;
  const CellWidget({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (value) {
      case CellValue.xChar:
        return Center(
          child: ExtendedImage.asset(
            IconAssets.xChar,
            color: context.theme.colorScheme.error,
            height: 25,
            fit: BoxFit.cover,
          ),
        );
      case CellValue.oChar:
        return Center(
          child: ExtendedImage.asset(
            IconAssets.oChar,
            color: context.theme.colorScheme.primary,
          ),
        );
      case CellValue.xWinner:
        return DecoratedBox(
          decoration: BoxDecoration(color: context.theme.colorScheme.errorContainer),
          child: Center(
            child: ExtendedImage.asset(
              IconAssets.xChar,
              color: context.theme.colorScheme.onErrorContainer,
            ),
          ),
        );
      case CellValue.oWinner:
        return DecoratedBox(
          decoration: BoxDecoration(color: context.theme.colorScheme.primaryContainer),
          child: Center(
            child: ExtendedImage.asset(
              IconAssets.oChar,
              color: context.theme.colorScheme.onPrimaryContainer,
            ),
          ),
        );
      default:
        return DecoratedBox(
          decoration: BoxDecoration(color: context.theme.colorScheme.background),
        );
    }
  }
}
