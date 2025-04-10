class CarMovie {
  final String id;
  final String carMovieName;
  final String carMovieYear;
  final int duration;

  CarMovie({
    required this.id,
    required this.carMovieName,
    required this.carMovieYear,
    required this.duration,
  });

  factory CarMovie.fromJson(Map<String, dynamic> json) {
    return CarMovie(
      id: json['id'] ?? '', // Provide a default value if 'id' is null
      carMovieName: json['carMovieName'],
      carMovieYear: json['carMovieYear'],
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carMovieName': carMovieName,
      'carMovieYear': carMovieYear,
      'duration': duration,
    };
  }
}