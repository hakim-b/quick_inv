import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quick_inv/widgets/wizard/wizard_steps_list.dart';

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<StatefulWidget> createState() => _DeleteItemPageState();
}

class _DeleteItemPageState extends State<DeletePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: WizardStepsList()),
    );
  }
}
 