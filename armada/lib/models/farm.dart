class FarmM {
  final String farmname;
  final String croptype;
  final String soiltype;
  final String? imagename;
  final int farmsize;
  final int latitud;
  final int longtude;

  FarmM({
    required this.farmname,
    required this.croptype,
    required this.soiltype,
    required this.imagename,
    required this.farmsize,
    required this.latitud,
    required this.longtude,
  });

  factory FarmM.fromJson(Map<String, dynamic> json) {
    return FarmM(
        farmname: json['farm_name'],
        croptype: json['crops_grown'],
        soiltype: json['soil_type'],
        imagename: json['image'],
        farmsize: json['farm_size'],
        latitud: json['latitude'],
        longtude: json['longitude']);
  }
}
