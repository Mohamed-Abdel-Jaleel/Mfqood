class Child {
  final String _id, age, gender, location, image, imageID, status;

  Child(
    this._id,
    this.age,
    this.gender,
    this.location,
    this.image,
    this.imageID,
    this.status,
  );

  Child.fromJson(Map<String, dynamic> json)
      : _id = json['_id'],
        age = json['age'],
        gender = json['gender'],
        location = json['location'],
        image = json['image'],
        imageID = json['imageID'],
        status = json['status'];

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'age': age,
        'gender': gender,
        'location': location,
        'image': image,
        'imageID': imageID,
        'status': status
      };

}
