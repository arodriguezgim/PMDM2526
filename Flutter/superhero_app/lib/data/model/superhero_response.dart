class SuperHeroResponse {

  final String response;

  SuperHeroResponse({required this.response});

  // Necesito devolver un objeto SuperHerpResponse con los campos que me interesan
  factory SuperHeroResponse.fromJson( Map<String, dynamic> json ){
    return SuperHeroResponse(
      response: json['response']
    );
  }

}