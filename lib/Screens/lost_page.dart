import 'package:flutter/material.dart';
import 'package:mfqood/Widgets/const_style.dart';
import 'package:mfqood/Widgets/custom_action_bar.dart';
import 'package:mfqood/Widgets/custom_button.dart';

class LostPage extends StatelessWidget {
  const LostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldKey,
      resizeToAvoidBottomInset: false, //new line
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CusomActionBar(
              hasBackground: false,
              hasIconButtons: true,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: SizedBox(
                height: 100,
                child: Image.asset(
                  'images/lost_logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Image.asset('images/icons/notification_colored.png'),
            Text(
              'Add Photo',
              style: ConstStyle.semiBoldedColoredText,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name : ',
                  style: ConstStyle.semiBoldedColoredText,
                ),
                Text(
                  'Mohamed Ateya ',
                  style: ConstStyle.DefaultText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name : ',
                  style: ConstStyle.semiBoldedColoredText,
                ),
                Text(
                  'Mohamed Ateya ',
                  style: ConstStyle.DefaultText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name : ',
                  style: ConstStyle.semiBoldedColoredText,
                ),
                Text(
                  'Mohamed Ateya ',
                  style: ConstStyle.DefaultText,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Name : ',
                  style: ConstStyle.semiBoldedColoredText,
                ),
                Text(
                  'Mohamed Ateya ',
                  style: ConstStyle.DefaultText,
                ),
              ],
            ),
            CustomButton(
              isLoading: false,
              text: '.  Add  .',
              onPressed: () {},
              height: 40,
              padding: 16,
              radius: 20,
              backgroundColor: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
