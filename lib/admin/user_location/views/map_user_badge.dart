
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:student_project/utils/colors.dart';

class MapUserBadge extends StatelessWidget {
  
  bool? isSelected;

  MapUserBadge({ this.isSelected });

  @override
  Widget build(BuildContext context) {

   // LoginService loginService = Provider.of<LoginService>(context, listen: false);
    //LoginUserModel? userModel = loginService.loggedInUserModel;
  
   
    
    return Visibility(
      visible: true,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
        decoration: BoxDecoration(
          color: this.isSelected! ? kPrimaryColor : Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset.zero
            )
          ]
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                image: DecorationImage(
                  image: NetworkImage(''),
                  fit: BoxFit.cover
                ),
                border: Border.all(
                  color: this.isSelected! ? Colors.white : kPrimaryColor,
                  width: 1
                )
              )
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('userName',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: this.isSelected! ? Colors.white : Colors.grey
                    )
                  ),
                  Text('Mi Locación',
                    style: TextStyle(
                      color: this.isSelected! ? Colors.white : kPrimaryColor
                    )
                  )
                ],
              )
            ),
            Icon(
              Icons.location_pin,
              color: this.isSelected! ? Colors.white : kPrimaryColor,
              size: 40
            )
          ],
        )
      )
    );
  }
}