import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:planet_verse/models/planet_model.dart';

import '/screens/planet_screen.dart';
import '/services/game.dart';
import '/utility/utility.dart';
import '/widgets/static_stars_bg.dart';

class SolarSystem extends StatelessWidget {
  Widget get _animatedStars {
    return Lottie.asset('assets/animations/stars.json');
  }

  @override
  Widget build(BuildContext context) {
    const _planets = PlanetName.values;
    return LayoutBuilder(builder: (context, constraints) {
      final size = Size(constraints.maxWidth, constraints.maxHeight);
      final Orientation orientation = MediaQuery.of(context).orientation;

      final double cellSize = size.width / 4;

      final spaceLeft =
          orientation == Orientation.landscape ? (size.height - (2 * cellSize)) : (size.height - (6 * cellSize));
      final double mainAxisPadding = orientation == Orientation.landscape ? spaceLeft / 2 : spaceLeft / 6;

      // crossAxisPadding = (crossAxisCount*(spaceLeft/mainAxisCount))/2
      final double crossAxisPadding =
          spaceLeft < 0 ? (orientation == Orientation.landscape ? spaceLeft.abs() : (4 * spaceLeft.abs() / 6) / 2) : 0;

      final List<StaggeredGridTile> _portraitTilesLayout = [
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
      ];

      final List<StaggeredGridTile> _landscapeTilesLayout = [
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
        StaggeredGridTile.count(
          mainAxisCellCount: 1,
          child: SizedBox(),
          crossAxisCellCount: 2,
        ),
      ];
      return Container(
        alignment: Alignment.center,
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            StaticStarsBackGround(),
            _animatedStars,
            StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: mainAxisPadding > 0 ? mainAxisPadding : 0,
              children: List.generate(_planets.length, (index) => _PlanetCard(_planets[index])),
            ),
          ],
        ),
      );
    });
  }
}

class _PlanetCard extends StatelessWidget {
  final PlanetName planetName;
  const _PlanetCard(this.planetName);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, PlanetScreen.route, arguments: planetName);
      },
      child: Column(
        children: [
          Flexible(
              child: Hero(
                  tag: describeEnum(planetName),
                  child: Image.asset('assets/img/planets/${describeEnum(planetName)}.png'))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Consumer<Game>(
                builder: (_, _gameData, ___) {
                  final _ruler = _gameData.playerForPlanet(planetName).ruler;
                  return Container(
                    height: 16.sp,
                    width: 16.sp,
                    margin: const EdgeInsets.only(right: 4),
                    child: FittedBox(
                      child: Image.asset(
                        'assets/img/ruler/${describeEnum(_ruler)}.png',
                      ),
                    ),
                  );
                },
              ),
              Flexible(
                  child: Text(
                describeEnum(planetName).inCaps,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
