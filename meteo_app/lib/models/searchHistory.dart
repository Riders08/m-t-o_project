class SearchHistory {
  final String cityName;
  final double lat;
  final double lon;
  final DateTime searchTime;

  const SearchHistory({
    required this.cityName,
    required this.lat,
    required this.lon,
    required this.searchTime,
  });

  Map<String,dynamic> toJson() => {
    'cityName' : cityName,
    'lat' : lat,
    'lon' : lon,
    'searchTime' : searchTime.toIso8601String(),
  };

  factory SearchHistory.fromJson(Map<String,dynamic> json){
    return SearchHistory(
      cityName: json['cityName'], 
      lat: json['lat'], 
      lon: json['lon'], 
      searchTime: DateTime.parse(json['searchTime']),
    );
  }

}
