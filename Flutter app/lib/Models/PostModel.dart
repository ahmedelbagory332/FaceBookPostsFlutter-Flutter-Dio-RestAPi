

class PostModel{

   String _name ;
   String _post ;
   String _time ;
   String _image;

   PostModel(this._name, this._post, this._time, this._image);

   factory PostModel.fromJson(Map<String, dynamic> json) {
     return PostModel(
        json['name'],
         json['post'],
        json['time'],
         json['image'],
     );
   }




   String get image => _image;

   String get time => _time;

   String get post => _post;

   String get name => _name;


}