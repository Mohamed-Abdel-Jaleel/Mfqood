import 'package:flutter/material.dart';

import 'clip_path_class.dart';

class CusomActionBar extends StatelessWidget {


  CusomActionBar({required this.hasBackground, required this.openDrawer, required this.hasIconButtons});

  final bool? hasBackground;
  final VoidCallback openDrawer ;
  final bool? hasIconButtons;

  @override
  Widget build(BuildContext context) {
    bool _hasBackground = hasBackground ?? false;
    bool _hasIconButtons = hasIconButtons ?? false;
    return _hasBackground?
    ClipPath(
        clipper: ClipPathClass(),
        child: Container(
          height: 120,
          width: double.infinity,
          color: Theme.of(context).primaryColor,
          child: Row(
             mainAxisAlignment: _hasIconButtons? MainAxisAlignment.spaceBetween
                                       :MainAxisAlignment.center ,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               if(_hasIconButtons)
                 IconButton(
                 icon: Image.asset(
                   'images/icons/drawer.png',
                 ),
                 onPressed: openDrawer,
               ),

               Image.asset(
                    'images/textLogo.png',
                    fit: BoxFit.scaleDown,
                  ),
                  if(_hasIconButtons)
                 IconButton(
                 onPressed: () {
                 },
                 icon: Image.asset(
                   'images/icons/notification.png',
                 ),
               ),
             ],
           ),

        ),
      )
    :Container(
      padding: EdgeInsets.fromLTRB(12, 12, 12, 0),

      width: double.infinity,
      //color: Theme.of(context).primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              icon: Image.asset(
                'images/icons/drawer.png',
                color: Theme.of(context).primaryColor,
              ),
              onPressed: openDrawer,
            ),
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/icons/notification_colored.png',
              ),
            ),
        ],
      ),

    );

  }

}
