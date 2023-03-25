import 'package:flutter/material.dart';
import 'disease_data.dart';
import 'package:url_launcher/url_launcher.dart';

class HalamanDetail extends StatefulWidget {
  final Diseases plant;

  const HalamanDetail({super.key, required this.plant});

  @override
  _HalamanDetailState createState() => _HalamanDetailState();
}

class _HalamanDetailState extends State<HalamanDetail> {
  bool isWishlist = false;

  Future<void> _launchUniversalLinkIos(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        backgroundColor: isWishlist ? Colors.green : Colors.red,
      ),
    );
  }

  void _addToWishlist(BuildContext context) {
    setState(() {
      isWishlist = true;
    });
    _showSnackBar(context, "Added to wishlist");
  }

  void _removeFromWishlist(BuildContext context) {
    setState(() {
      isWishlist = false;
    });
    _showSnackBar(context, "Removed from wishlist");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.plant.name),
        actions: [
          IconButton(
            icon: Icon(
              isWishlist ? Icons.favorite : Icons.favorite_border,
              color: Colors.white,
            ),
            onPressed: () {
              if (isWishlist) {
                _removeFromWishlist(context);
              } else {
                _addToWishlist(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.plant.imgUrls),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // name
              Text(
                textAlign: TextAlign.center,
                widget.plant.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),
              const Text(
                "ID Tanaman",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.plant.id),

              const SizedBox(height: 8),
              const Text(
                "Nama Tanaman",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.plant.plantName),

              const SizedBox(height: 16),
              const Text(
                'Symptom',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(widget.plant.symptom),
              const SizedBox(height: 16),
              const Text(
                'Ciri Ciri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),

              // for (var i = 0; i < widget.disease.nutshell.length; i++)
              //   Text(
              //     widget.disease.nutshell[i],
              //     style: const TextStyle(
              //       fontSize: 16,
              //     ),
              //   ),

              for (var i = 0; i < widget.plant.nutshell.length; i++)
                Text(
                  widget.plant.nutshell[i],
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (Theme.of(context).platform == TargetPlatform.iOS) {
            await _launchUniversalLinkIos(Uri.parse(widget.plant.imgUrls));
          } else {
            throw 'Unsupported platform';
          }
        },
        child: const Icon(Icons.open_in_browser),
      ),
    );
  }
}
