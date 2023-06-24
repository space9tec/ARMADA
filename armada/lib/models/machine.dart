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
      imageFile: "",
    );
  }
}
