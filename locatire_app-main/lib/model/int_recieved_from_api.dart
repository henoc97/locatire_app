

class ConvertInIntFromApi{
  int myInt;
  ConvertInIntFromApi(this.myInt);

  factory ConvertInIntFromApi.fromMap(Map<String, dynamic> map)=>ConvertInIntFromApi(map["message"]);
}