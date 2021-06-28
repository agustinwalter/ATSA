class AtsaForm {
  AtsaForm({
    this.personalPhone,
    this.personalAddress,
    this.personalCity,
    this.dateOfBirth,
    this.civilStatus,
    this.work,
    this.profession,
    this.file,
    this.workPhone,
    this.workAddress,
    this.workCity,
    this.month,
  });

  int personalPhone;
  String personalAddress;
  String personalCity;
  String dateOfBirth;
  String civilStatus;
  String work;
  String profession;
  String file;
  int workPhone;
  String workAddress;
  String workCity;
  String month;

  Map<String, Object> toJson() => <String, Object>{
        'personalPhone': personalPhone,
        'personalAddress': personalAddress,
        'personalCity': personalCity,
        'dateOfBirth': dateOfBirth,
        'civilStatus': civilStatus,
        'work': work,
        'profession': profession,
        'file': file,
        'workPhone': workPhone,
        'workAddress': workAddress,
        'workCity': workCity,
        'month': month,
      };
}
