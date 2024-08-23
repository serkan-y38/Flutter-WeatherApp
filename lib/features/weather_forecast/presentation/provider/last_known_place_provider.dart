import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LastKnownPlaceProvider extends ChangeNotifier {

  final SharedPreferences _sharedPreferences;

  LastKnownPlaceProvider(this._sharedPreferences);

  String? _place;
  String? get place => _place;

  Future<void> setPlace(String place) async {
    await _sharedPreferences.setString("last_known_place", place);
    _place = place;
    notifyListeners();
  }

  Future<void> getLastKnownPlace() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (isLocationEnabled) {
        getPlaceFromLocation();
      } else {
        _getPlaceFromSharedPreferences();
      }
    } else {
      _getPlaceFromSharedPreferences();
    }
  }

  Future<void> _getPlaceFromSharedPreferences() async {
    final savedPlace = _sharedPreferences.getString("last_known_place");
    (savedPlace != null && savedPlace != "") ? _place = savedPlace : _place = "London";
    notifyListeners();
  }

  Future<void> getPlaceFromLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
      );
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude
      );
      if (placemarks.isNotEmpty &&
          placemarks.first.administrativeArea != null &&
          placemarks.first.administrativeArea != ""
      ) {
        setPlace(placemarks.first.administrativeArea.toString());
      } else {
        _getPlaceFromSharedPreferences();
      }
    } catch (e) {
      log("Error getting location: $e");
      _getPlaceFromSharedPreferences();
    }
  }
}
