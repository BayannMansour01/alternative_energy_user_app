class Job {
  final int id;
  final String title;
  final String disc;
  final int userId;
  final String createdAt;
  final String updatedAt;
  final List<JobImage> images;

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
    try {
      return Job(
        id: json['id'] as int,
        title: json['title'] as String,
        disc: json['disc'] as String,
        userId: json['user_id'] as int,
        createdAt: json['created_at'] as String,
        updatedAt: json['updated_at'] as String,
        images: (json['images'] as List).map((image) => JobImage.fromJson(image)).toList(),
      );
    } catch (e) {
      print('Error parsing job: $e');
      throw StateError('Error parsing job: $e');
    }
  }
}

class JobImage {
  final int id;
  final String image;
  final int previousJobId;

  JobImage({
    required this.id,
    required this.image,
    required this.previousJobId,
  });

  factory JobImage.fromJson(Map<String, dynamic> json) {
    return JobImage(
      id: json['id'] as int,
      image: json['image'] as String,
      previousJobId: json['previous_job_id'] as int,
    );
  }
}
