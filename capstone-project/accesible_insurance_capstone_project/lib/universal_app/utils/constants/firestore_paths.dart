class FireStorePaths {
  static String masterPolicies(String uid) => '/users/$uid/master-policies';
  static String mastePolicy(String uid, String docId) => '/users/$uid/master-policies/$docId';
  static String users(String uid) => '/users';
}
