import 'package:flutter/material.dart';

class Trackter {
  final String Manufacturer;
  final String Model;
  final int Year;
  final int Horsepower;
  final String Hourmeter;
  final String Region;

  Trackter({
    required this.Manufacturer,
    required this.Model,
    required this.Year,
    required this.Horsepower,
    required this.Hourmeter,
    required this.Region,
  });
}

class CombineHarvester {
  final String Manufacturer;
  final String Model;
  final int Year;
  final int GrainTankCapacity;
  final String GrainTypes;
  final String Region;

  CombineHarvester({
    required this.Manufacturer,
    required this.Model,
    required this.Year,
    required this.GrainTankCapacity,
    required this.GrainTypes,
    required this.Region,
  });
}

class Thresher {
  final String Manufacturer;
  final String Model;
  final int Requiredpower;
  final int WorkingCapacity;
  final String Region;

  Thresher({
    required this.Manufacturer,
    required this.Model,
    required this.Requiredpower,
    required this.WorkingCapacity,
    required this.Region,
  });
}

class Other {
  final String Manufacturer;
  final String Model;
  final String AdditionalInformation;
  final String Region;

  Other({
    required this.Manufacturer,
    required this.Model,
    required this.AdditionalInformation,
    required this.Region,
  });
}

class Tractorattachments {}
