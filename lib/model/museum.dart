class Museum {
  final String id;
  final String title;
  final String description;
  final String location;
  final double lat;
  final double lon;
  final String image;
  final String address;
  final String url;
  final String email;
  final String phone;
  final String schedule;
  final bool completed;
  bool read;

  Museum(
      {this.id,
      this.title,
      this.description,
      this.location,
      this.lat,
      this.lon,
      this.image,
      this.address,
      this.url,
      this.email,
      this.phone,
      this.schedule,
      this.read = false,
      this.completed});

  factory Museum.fromJson(Map<String, dynamic> json) {
    var loc = json['localitzacio'].split(',');
    return Museum(
        id: json['punt_id'],
        title: json['adreca_nom'],
        description: json['descripcio'],
        location: json['localitzacio'],
        lat: double.parse(loc[0]),
        lon: double.parse(loc[1]),
        image: json['imatge'][0],
        address: json['grup_adreca']['adreca_completa'],
        url: "json['url_general'].toString()",
        email: (json['email'][0]).toString(),
        phone: (json['telefon_contacte'][0]).toString(),
        schedule: json['horaris'],
        completed: json['completed']);
  }

  Map<String, dynamic> toJson() => {
        'punt_id': id,
        'adreca_nom': title,
        'descripcio': description,
        'localitzacio': location,
        'imatge': image,
        'grup_adreca': address,
        'url_general': url,
        'email': email,
        'telefon_contacte': phone,
        'horaris': schedule,
        'completed': completed,
      };
}
