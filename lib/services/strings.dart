class Strings {
  static const String base_url = "https://api.unsplash.com/search/photos?";
  static const String per_page = "per_page=30";
  static const String client_id = "it1PXzVQRnxgz8v8hazcst7G9rNfXk1qiS8FgHTTMMk"; 

  static String fullUrl(String search) {
    return "$base_url$per_page&client_id=$client_id&query=$search";
  } 
}