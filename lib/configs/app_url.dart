class AppUrl {
  AppUrl._();

  // static var baseUrl = 'http://172.21.80.111:8000/v1';
  static var baseUrl = 'http://localhost:3000/api/v1';

  static var loginApiEndPoint = '$baseUrl/auth/login';
  static var signupApiEndPoint = '$baseUrl/auth/signup';
  static var forgotPasswordApiEndPoint = '$baseUrl/auth/forgot-password';
  static var resetPasswordApiEndPoint = '$baseUrl/auth/reset-password';
  static var firebaseSocialLoginApiEndPoint =
      '$baseUrl/auth/firebase-solical-login';
  static var changePasswordApiEndPoint = '$baseUrl/user/change-password';
  static var verifyEmailEndPoint = '$baseUrl/auth/verify-email?token=';
  static var googleSigninEndPoint = '$baseUrl/auth/google/login';
  static var facebookSigninEndPoint = '$baseUrl/auth/facebook/login';
  static var appleSigninEndPoint = '$baseUrl/auth/apple/login';
  static var updateProfileEndPoint = '$baseUrl/user/profile';
  static var travelPreferencesEndPoint = '$baseUrl/user/travel-preferences';
  static var getUserDataEndPoint = '$baseUrl/users/me';
  static var scanAndCreateContactEndPoint = '$baseUrl/contacts/create-contact';
  static var addNewContactEndPoint = '$baseUrl/contacts/addNewContact';
  static var getAllContactsEndPoint = '$baseUrl/contacts/contacts';
  static var deleteContactEndPoint = '$baseUrl/contacts/deleteContacts/';
  static var updateUserDataEndPoint = '$baseUrl/users/update-me';
  static var getUserDataByIdEndPoint = '$baseUrl/users/getOneUser/';
  static var addVehicleEndPoint = '$baseUrl/vehicles/';
  static var getVehiclesEndPoint = '$baseUrl/vehicles/';
  static var deleteVehiclesEndPoint = '$baseUrl/vehicles/';
  static var updateVehiclesEndPoint = '$baseUrl/vehicles/';
  static var findOneVehicleEndPoint = '$baseUrl/vehicles/';
  static var makeEndPoint = '$baseUrl/vehicles/make';
  static var createRideEndPoint = '$baseUrl/user/rides';
  static var cancelRideEndPoint = '$baseUrl/user/rides/';
  static var getRidesEndPoint = '$baseUrl/user/rides?status=';
  static var searchAndFileterEndPoint = '$baseUrl/rides/search?';
  static var recentSearchEndPoint = '$baseUrl/rides/search-history';
  static var addCardEndPoint = '$baseUrl/user/card';
  static var getAllCardsEndPoint = '$baseUrl/user/cards';
  static var setDefaultCardEndPoint = '$baseUrl/user/card/default';
  static var createBookingEndPoint = '$baseUrl/user/ride/booking';
  static var getBookingDetailsEndPoint = '$baseUrl/user/ride/bookings';
  static var cancelBookingEndPoint = '$baseUrl/user/ride-booking-cancel';
  static var listRideBookingRequestEndPoint = '$baseUrl/user/ride/';
  static var rideBookingConfirmEndPoint = '$baseUrl/user/ride/booking/confirm';
  static var rideBookingRejectEndPoint = '$baseUrl/user/ride/booking/reject';
  static var createRideRequestEndPoint = '$baseUrl/user/ride/ride-request';
  static var rideRequestDetailsEndPoint = '$baseUrl/user/ride/ride-request/';
}
