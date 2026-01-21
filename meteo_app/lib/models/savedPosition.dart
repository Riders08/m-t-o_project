class SavedPosition {
  final double latitude;
  final double longitude;

  const SavedPosition({
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toJson() =>{
    "lat": latitude,
    "lon": longitude,
  };
}