class ApiUtils {
  // ignore: non_constant_identifier_names
  static String BASE_URL = 'https://mygiftc.com/giftcard';
  //static String BASE_URL = 'http://192.168.0.74/giftcard';

  // Auth
  static String urlLogin = '$BASE_URL/admin/main/login';
  static String urlRegister = '$BASE_URL/admin/main/register';
  static String urlUpdateUserInfo = '$BASE_URL/admin/main/update_user_info';
  static String urlPurchaseGift = '$BASE_URL/admin/main/purchase_gift';
  
}
