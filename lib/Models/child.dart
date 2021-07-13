class ChildResponse{
  final String type ,message ;
  final List<Child> childs;

  ChildResponse(this.type, this.message, this.childs);

  ChildResponse.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        message = json['age'],
        childs = json['childs'];

  //List<Child> childList = childs.map((c) => Child.fromJson(c)).toList();
}
class Child {
  final String _id, gender, name, image, imageID, status;
  final int age;
  Child(
    this._id,
    this.age,
    this.gender,
    this.name,
    this.image,
    this.imageID,
    this.status,
  );

  Child.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        age = json['age'],
        gender = json['gender'],
        name = json['name'],
        image = json['image'],
        imageID = json['imageID'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'age': age,
        'gender': gender,
        'name': name,
        'image': image,
        'imageID': imageID,
        'status': status
      };
}
