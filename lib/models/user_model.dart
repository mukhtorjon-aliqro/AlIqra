/// -----------------------------------------------------------------------
/// UserModel
/// Simple data class representing the fields listed in SRS section 7
/// (Profile). In production this would be populated from your backend /
/// Firestore / REST API after login.
/// -----------------------------------------------------------------------
class UserModel {
  String name;
  String country;
  String languageCode;
  int age;
  String ageGroup; // 'child' or 'adult'
  String knowledgeLevel; // 'beginner' | 'intermediate' | 'advanced'
  String loginMethod; // google | apple | telegram | facebook | email | phone
  int streakDays;
  double dailyGoalProgress; // 0.0 - 1.0
  List<String> achievements;
  List<String> certificates;

  UserModel({
    this.name = '',
    this.country = '',
    this.languageCode = 'en',
    this.age = 0,
    this.ageGroup = 'adult',
    this.knowledgeLevel = 'beginner',
    this.loginMethod = '',
    this.streakDays = 0,
    this.dailyGoalProgress = 0.0,
    List<String>? achievements,
    List<String>? certificates,
  })  : achievements = achievements ?? [],
        certificates = certificates ?? [];
}
