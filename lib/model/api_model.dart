class InternshipModel {
  String title;
  String employmentType;
  String companyName;
  String startDate;
  String duration;
  String stipend;
  String postedOn;
  List<String> locationNames;

  InternshipModel({
    required this.title,
    required this.employmentType,
    required this.companyName,
    required this.startDate,
    required this.duration,
    required this.stipend,
    required this.postedOn,
    required this.locationNames,
  });

  factory InternshipModel.fromJson(Map<String, dynamic> json) {
    //  json.forEach((key, value) {
    //     print('$key: $value');
    //   });
    return InternshipModel(
      title: json['title'],
      employmentType: json['employment_type'],
      companyName: json['company_name'],
      startDate: json['start_date'],
      duration: json['duration'],
      stipend:
        json['stipend'] != null && json['stipend']['salary'] != null ? json['stipend']['salary'] : '',
      postedOn: json['posted_on'],
      locationNames: List<String>.from(json['location_names']),
    );
  }
}
