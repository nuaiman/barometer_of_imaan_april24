import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../../../models/gps.dart';

class GpsController extends StateNotifier<GpsModel> {
  GpsController()
      : super(
          GpsModel(
            latitude: 0,
            longitude: 0,
            street: '',
            locality: '',
            subAdministrativeArea: '',
            administrativeArea: '',
            country: '',
            isoCountryCode: '',
          ),
        );

  Future<bool> checkAndShowLocationPermissionDialog(
      BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (context.mounted) {
        _showErrorDialog(
          context,
          'Location Permission',
          'Please enable location service and allow location permission from settings.',
        );
      } else {
        // print('context is not mounted');
      }

      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (context.mounted) {
          _showErrorDialog(
            context,
            'Location Permission',
            'Please enable location service and allow location permission from settings.',
          );
        } else {
          // print('context is not mounted');
        }

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      if (context.mounted) {
        _showErrorDialog(
          context,
          'Location Permission',
          'Please enable location service and allow location permission from settings.',
        );
      } else {
        // print('context is not mounted');
      }

      return false;
    }

    return true;
  }

  // Future<void> fetchAndCheckCurrentLocation(BuildContext context) async {
  //   final currentLocation = await Geolocator.getCurrentPosition();
  //   final placemarks = await placemarkFromCoordinates(
  //     currentLocation.latitude,
  //     currentLocation.longitude,
  //   );
  //   final location = GpsModel(
  //     latitude: currentLocation.latitude,
  //     longitude: currentLocation.longitude,
  //     street: placemarks.isNotEmpty ? placemarks[0].street.toString() : '',
  //     locality: placemarks.isNotEmpty ? placemarks[0].locality.toString() : '',
  //     subAdministrativeArea: placemarks.isNotEmpty
  //         ? placemarks[0].subAdministrativeArea.toString()
  //         : '',
  //     administrativeArea: placemarks.isNotEmpty
  //         ? placemarks[0].administrativeArea.toString()
  //         : '',
  //     country: placemarks.isNotEmpty ? placemarks[0].country.toString() : '',
  //     isoCountryCode:
  //         placemarks.isNotEmpty ? placemarks[0].isoCountryCode.toString() : '',
  //   );
  //   if (!_isLocationValid(location)) {
  //     if (context.mounted) {
  //       _showErrorDialog(
  //         context,
  //         'Location Error',
  //         'Couldn\'t get current location details. Please restart..',
  //       );
  //     } else {
  //       // print('context not mounted');
  //     }
  //     return;
  //   }
  //   state = location;
  // }

  // bool _isLocationValid(GpsModel location) {
  //   return location.latitude != 0 &&
  //       location.longitude != 0 &&
  //       location.street.isNotEmpty &&
  //       location.locality.isNotEmpty &&
  //       location.subAdministrativeArea.isNotEmpty &&
  //       location.administrativeArea.isNotEmpty &&
  //       location.country.isNotEmpty &&
  //       location.isoCountryCode.isNotEmpty;
  // }

  void _showErrorDialog(BuildContext context, String title, String content) {
    if (context.mounted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () => exit(0),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  // Future<void> checkPermissionAndFetchLocation(BuildContext context) async {
  //   final permissionGranted =
  //       await checkAndShowLocationPermissionDialog(context);
  //   if (!permissionGranted) {
  //     return;
  //   }
  //   if (context.mounted) {
  //     await fetchAndCheckCurrentLocation(context);
  //   } else {
  //     // print('context is not mounted');
  //   }
  // }

  Future<void> checkPermissionAndFetchOnlyLatLong(BuildContext context) async {
    final permissionGranted =
        await checkAndShowLocationPermissionDialog(context);
    if (!permissionGranted) {
      return;
    }
    if (context.mounted) {
      final currentLocation = await Geolocator.getCurrentPosition();
      state = state.copyWith(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude,
      );
    } else {
      // print('context is not mounted');
    }
  }

  // Future<GpsModel> getCurrentLocation() async {
  //   final currentLocation = await Geolocator.getCurrentPosition();
  //   List<Placemark> placemarks = await placemarkFromCoordinates(
  //       currentLocation.latitude, currentLocation.longitude);
  //   state = GpsModel(
  //     latitude: currentLocation.latitude,
  //     longitude: currentLocation.longitude,
  //     street: placemarks[0].street.toString(),
  //     locality: placemarks[0].locality.toString(),
  //     subAdministrativeArea: placemarks[0].subAdministrativeArea.toString(),
  //     administrativeArea: placemarks[0].administrativeArea.toString(),
  //     country: placemarks[0].country.toString(),
  //     isoCountryCode: placemarks[0].isoCountryCode.toString(),
  //   );
  //   return state;
  // }

  // Future<GpsModel?> getLocationForACordinate(
  //     double latitude, double longitude) async {
  //   List<Placemark> placemarks =
  //       await placemarkFromCoordinates(latitude, longitude);
  //   GpsModel model = GpsModel(
  //     latitude: latitude,
  //     longitude: longitude,
  //     street: placemarks[4].street.toString(),
  //     locality: placemarks[1].locality.toString(),
  //     subAdministrativeArea: placemarks[1].subAdministrativeArea.toString(),
  //     administrativeArea: placemarks[1].administrativeArea.toString(),
  //     country: placemarks[1].country.toString(),
  //     isoCountryCode: placemarks[1].isoCountryCode.toString(),
  //   );
  //   return model;
  // }
}
// -----------------------------------------------------------------------------

final gpsControllerProvider =
    StateNotifierProvider<GpsController, GpsModel>((ref) {
  return GpsController();
});
