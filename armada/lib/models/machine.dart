class MachineM {
  final String machineId;
  final String ownerId;
  final String manufacturer;
  final String model;
  final String type;
  final String status;
  final String? region;
  final String? attachmenttype;
  final int? year;
  final String? hourmeter;
  final int? horsepower;
  final int? graintank;
  final String? graintypes;
  final int? workingcapacity;
  final int? requiredpower;
  final String? additionalinformation;
  // final XFile? imageFile;
  final String? imageFile;

  MachineM({
    required this.machineId,
    required this.ownerId,
    required this.manufacturer,
    required this.model,
    required this.type,
    required this.status,
    required this.region,
    required this.attachmenttype,
    required this.year,
    required this.hourmeter,
    required this.horsepower,
    required this.graintank,
    required this.graintypes,
    required this.workingcapacity,
    required this.requiredpower,
    required this.additionalinformation,
    required this.imageFile,
  });

  factory MachineM.fromJson(Map<String, dynamic> json) {
    return MachineM(
      manufacturer: json['manufacturer'],
      ownerId: json['owner_id'],
      machineId: json['_id'],
      model: json['model'],
      type: json['type'],
      status: json['status'],
      region: json['region'],
      attachmenttype: json['attachment_type'],
      year: json['year'],
      hourmeter: json['hour_meter'],
      horsepower: json['horsepower'],
      graintank: json['grain_tank_capacity'],
      graintypes: json['grain_types'],
      workingcapacity: json['working_capacity'],
      requiredpower: json['required_power'],
      additionalinformation: json['additional_info'],
      imageFile: json['image'],
    );
  }
  factory MachineM.empty() {
    return MachineM(
      machineId: "",
      ownerId: "",
      manufacturer: "",
      model: "",
      type: "",
      status: "",
      region: "",
      attachmenttype: "",
      year: 0,
      hourmeter: "",
      horsepower: 0,
      graintank: 0,
      graintypes: "",
      workingcapacity: 0,
      requiredpower: 0,
      additionalinformation: "",
      imageFile: "",
    );
  }
}

///////////////////
///       "model": _model.text,
                // "manufacturer": _manufacturer.text,
                // "type": _currentCarType,
                // "owner_id": usermode.useid,
                // "status": _selectedmachinestatus,
                // "year": _year.text,
                // "region": _selectedregion,
                // "hour_meter": _hourmeter.text,
                // "horsepower": _horsepower.text,
                // "grain_tank_capacity": _graintank.text,
                // "grain_types": _graintypes.text,
                // "working_capacity": _workingcapacity.text,
                // "required_power": _requiredpower.text,
                // "additional_info": _additionalinformation.text,