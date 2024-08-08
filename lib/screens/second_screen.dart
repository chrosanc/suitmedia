import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/widgets/button_widget.dart';
import '../viewmodels/second_screen_viewmodel.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SecondScreenViewModel>(context);
    return PopScope(
      onPopInvoked: (onPop){
        viewModel.setSelectedUserName('');
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Second Screen')),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Welcome,'),
                      Text(
                        viewModel.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            viewModel.selectedUserName.isEmpty
                                ? 'Select User First'
                                : viewModel.selectedUserName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 24),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                right: 20,
                left: 20,
                bottom: 20,
                child: ButtonWidget(
                  onTap: () {
                    Navigator.pushNamed(context, '/third');
                  },
                  title: 'Choose an User',
                ))
          ],
        ),
      ),
    );
  }
}
