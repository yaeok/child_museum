class RouterPath {
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String emailVerify = '/email_verify';
  static const String createUser = '/create_user';
  static const String museumList = '/museum_list';

  static const String museumRegImage = 'museum_reg_image';
  static const String museumRegImageRoute = '/museum_list/museum_reg_image';

  static const String museumRegArticle = 'museum_reg_article';
  static const String museumRegArticleRoute =
      '/museum_list/museum_reg_image/museum_reg_article';

  static const String account = 'account';
  static const String accountRoute = '/museum_list/account';

  static const String followList = 'follow_list';
  static const String followListRoute = '/museum_list/account/follow_list';

  static const String search = 'search';
  static const String searchRoute = '/museum_list/account/search';
}
