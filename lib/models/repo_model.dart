class RepoUser {
  String? nameRepo;
  String? descriptionRepo;
  String? createdAt;
  String? pushed_at;
  String? urlRepo;
  int? forksCount;
  int? starCount;
  String? language;
  List? topics;

  RepoUser({
    this.nameRepo,
    this.descriptionRepo,
    this.createdAt,
    this.pushed_at,
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
      pushed_at: json['pushed_at'],
      urlRepo: json['svn_url'],
      forksCount: json['forks_count'],
      starCount: json['stargazers_count'],
      language: json['language'],
      topics: json['topics'],
    );
  }
}
