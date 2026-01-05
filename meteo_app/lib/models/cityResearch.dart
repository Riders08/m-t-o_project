class CityResearch {
  final String name;
  final double latitude;
  final double longitude;
  final String? state;
  final String country;

  const CityResearch({
    required this.name,
    required this.latitude,
    required this.longitude,
    this.state,
    required this.country,
  });

  factory CityResearch.fromJson(Map<String,dynamic> json){
    return CityResearch(
      name: json['name'], 
      latitude: json['lat'], 
      longitude: json['lon'], 
      state: json['state'],
      country: json['country']
    );
  }

  String get displayName{
    if(state == null){
      return "$name ($country)";
    }else{
      return "$name ($country - $state)";
    }
  }
}