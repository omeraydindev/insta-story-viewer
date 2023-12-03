enum MediaType {
  image,
  video,
}

class Story {
  final MediaType mediaType;
  final String source;
  final String thumbnail;
  final String takenAt;

  Story({
    required this.mediaType,
    required this.source,
    required this.thumbnail,
    required this.takenAt,
  });
}
