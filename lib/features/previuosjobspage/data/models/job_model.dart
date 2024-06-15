class Job {
  final int id;
  final String title;
  final String disc;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ImageModel> images;

  Job({
    required this.id,
    required this.title,
    required this.disc,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.images,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      title: json['title'],
      disc: json['disc'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      images: (json['images'] as List)
          .map((image) => ImageModel.fromJson(image))
          .toList(),
    );
  }
}

class ImageModel {
  final int id;
  final String image;
  final int previousJobId;

  ImageModel({
    required this.id,
    required this.image,
    required this.previousJobId,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      image: json['image'],
      previousJobId: json['previous_job_id'],
    );
  }
}
