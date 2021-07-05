import 'package:flutter/material.dart';

import '../clip_path_class.dart';

class CusomActionBar extends StatelessWidget {
  const CusomActionBar(
      {Key? key, required this.hasBackground, required this.hasIconButtons})
      : super(key: key);
  final bool? hasBackground;
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
                 onPressed: () {
                 },
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
              onPressed: () {
              },
            ),
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(0,40,0,0),
          //   child: Image.asset(
          //     'images/lost_logo.png',
          //     fit: BoxFit.fill,
          //   ),
          // ),
          IconButton(
              onPressed: () {
              },
              icon: Image.asset(
                'images/icons/notification_colored.png',
              ),
            ),
        ],
      ),

    );

  }
}
