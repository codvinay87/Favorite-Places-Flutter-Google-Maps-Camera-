import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  // Location? _pickedLocation;
  var _isGettingLocation = false;
  void _getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      print("permission denied");
      LocationPermission ask = await Geolocator.requestPermission();
    } else {
      setState(() {
        _isGettingLocation = true;
      });
      Position currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      setState(() {
        _isGettingLocation = false;
      });

      print("Latitude  ${currentPosition.latitude.toString()}");
      print("Longitude  ${currentPosition.longitude.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      "No Location Chosen",
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );

    if (_isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1,
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.2))),
          child: previewContent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: _getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text("Get Current Location")),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text("Select On Map"))
          ],
        )
      ],
    );
  }
}
