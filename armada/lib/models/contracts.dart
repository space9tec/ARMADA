class ContractsModel {
  final String contractId;
  final String userId;
  final String ownerId;
  final String machineId;
  final String rent_start_time;
  final String rent_end_time;
  final String created_at;
  final String updated_at;
  final String status;

  ContractsModel({
    required this.contractId,
    required this.userId,
    required this.ownerId,
    required this.machineId,
    required this.rent_start_time,
    required this.rent_end_time,
    required this.created_at,
    required this.updated_at,
    required this.status,
  });

  factory ContractsModel.fromJson(Map<String, dynamic> json) {
    return ContractsModel(
        contractId: json['_id'],
        userId: json['user_id'],
        ownerId: json['owner_id'],
        machineId: json['machine_id'],
        rent_start_time: json['rent_start_time'].toString(),
        rent_end_time: json['rent_end_time'].toString(),
        created_at: json['createdAt'],
        updated_at: json['updatedAt'],
        status: json['status']);
  }
}
