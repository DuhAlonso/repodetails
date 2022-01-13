class RepoUser {
  String? nameRepo;
  String? descriptionRepo;
  String? createdAt;
  String? updatedAt;
  String? urlRepo;
  int? forksCount;
  int? starCount;
  String? language;
  List? topics;

  RepoUser({
    this.nameRepo,
    this.descriptionRepo,
    this.createdAt,
    this.updatedAt,
    this.urlRepo,
    this.forksCount,
    this.starCount,
    this.language,
    this.topics,
  });

  factory RepoUser.fromJson(Map<String, dynamic> json) {
    return RepoUser(
      nameRepo: json['name'],
      descriptionRepo: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      urlRepo: json['svn_url'],
      forksCount: json['forks_count'],
      starCount: json['stargazers_count'],
      language: json['language'],
      topics: json['topics'],
    );
  }
}
