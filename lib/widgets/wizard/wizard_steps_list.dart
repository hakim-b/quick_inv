import 'package:flutter/material.dart';

class WizardStepsList extends StatefulWidget {
  const WizardStepsList({super.key});

  @override
  State<StatefulWidget> createState() => _WizardStepsState();
}

class _WizardStepsState extends State<WizardStepsList> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => _onItemTapped(0),
                child: WizardCircleAvatar(
                  isSelected: _selectedIndex == 0,
                ),
              ),
              SizedBox(height: 8),
              Text('Search'),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => _onItemTapped(1),
                child: WizardCircleAvatar(
                  isSelected: _selectedIndex == 1,
                ),
              ),
              SizedBox(height: 8),
              Text('Delete'),
            ],
          ),
          Column(
            children: <Widget>[
              GestureDetector(
                onTap: () => _onItemTapped(2),
                child: WizardCircleAvatar(
                  isSelected: _selectedIndex == 2,
                ),
              ),
              SizedBox(height: 8),
              Text('Confirm'),
            ],
          ),
        ],
      ),
    );
  }
}

class WizardCircleAvatar extends StatelessWidget {
  const WizardCircleAvatar({super.key, required this.isSelected});

  final double radius = 15;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          )),
      child: isSelected
          ? Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Color(0xff06b217),
              ),
            )
          : null,
    );

    // return CircleAvatar(
    //   radius: radius,
    //   backgroundColor: isSelected ? const Color(0xff06b217) : Colors.transparent,
    //   // backgroundColor: isSelected ? const Color(0xff06b217) : Colors.transparent,
    //   foregroundColor: isSelected ? Colors.transparent : Colors.grey,
    //   child: isSelected
    //   ? null
    //   : CircleAvatar(
    //     radius: radius - 3,
    //     backgroundColor: Colors.grey,
    //   ),
    // );
  }
}
