import 'package:flutter/material.dart';

class UploadBannerScreen extends StatelessWidget {
  // const UploadBannerScreen({super.key});
  static const String routeName = '\UploadBannerScreen';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Banners',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 36,
              ),
            ),
          ),

          const Divider(color: Colors.grey,),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  height: 140,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    border: Border.all(color: Colors.grey.shade800,),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Banners'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}