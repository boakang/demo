class ValidateProjectRequest {
  final String projectCode;

  ValidateProjectRequest({required this.projectCode});

  Map<String, dynamic> toJson() => {'projectCode': projectCode};
}
