import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:suitmedia/viewmodels/second_screen_viewmodel.dart';
import 'package:suitmedia/widgets/button_widget.dart';
import '../viewmodels/first_screen_viewmodel.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<FirstScreenViewModel>(context);
    final secondviewModel = Provider.of<SecondScreenViewModel>(context);
    final nameController = TextEditingController();
    final sentenceController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage('assets/images/first_screen_background.jpg'),
                  fit: BoxFit.cover)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 116,
                  height: 116,
                  decoration: BoxDecoration(
                      color: Colors.white.withAlpha(90),
                      borderRadius: BorderRadius.circular(100)),
                  child: const Center(
                    child: Icon(
                      IconlyBold.add_user,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 58,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: TextFormField(
                    controller: sentenceController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Palindrome',
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 45),
                ButtonWidget(
                    onTap: () {
                      if (sentenceController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please Fill in the Palindrome form')));
                      } else {
                        final isPalindrome =
                            viewModel.isPalindrome(sentenceController.text);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Palindrome Word Check',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            content: Text(isPalindrome
                                ? '${sentenceController.text} is Palindrome'
                                : '${sentenceController.text} is not Palindrome'),
                          ),
                        );
                      }
                    },
                    title: 'CHECK'),
                const SizedBox(
                  height: 15,
                ),
                ButtonWidget(
                    onTap: () {
                      if (nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Please Fill in the Name form')));
                      } else {
                        secondviewModel.setName(nameController.text);
                        Navigator.pushNamed(context, '/second');
                      }
                    },
                    title: 'NEXT'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
