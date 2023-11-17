class RoomCategory {
  final String name;
  final String image;

  RoomCategory({required this.name, required this.image});
  static List<RoomCategory> categories = [
    RoomCategory(name: "Movies", image: "assets/images/movies.png"),
    RoomCategory(name: "Sports", image: "assets/images/sports.png"),
    RoomCategory(name: "Music", image: "assets/images/music.png"),
  ];
}
