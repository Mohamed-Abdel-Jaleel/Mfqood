import 'package:flutter/material.dart';

import 'const_style.dart';

class ChildCard extends StatelessWidget {
  final String image , name , age , status ;

  ChildCard({required this.image, required this.name, required this.age, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100.withOpacity(.5),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(
              20), // use instead of BorderRadius.all(Radius.circular(20))
        ),
        child: ListTile(
          trailing: Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.network(
             image,
            ),
          ),

          title: Text(
            name,
            style: ConstStyle.semiBoldedText,
          ),
          // dense: true,
          subtitle: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$age years',
                style: ConstStyle.HintTextField,
              ),
              SizedBox(
                width: 20,
              ),
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: 15,
                    color: status=="found"? Colors.green: Colors.red,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  status=="found"? Text(
                    'Found',
                    style: ConstStyle.greenHint,
                  ): Text(
                    'Lost',
                    style: ConstStyle.redHint,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
