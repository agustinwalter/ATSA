/// This class lists the different states in which the login process could be found.
/// Some of them are stored in the [status] field in the database.
/// The rest are calculated based on certain variables.
enum LoginStatus {
  /// The user has only opened the app.
  /// It is the default value.
  /// A welcome screen should be displayed with the option to login or join.
  /// This value is not saved in the database.
  NOT_LOGGED,

  /// The user has entered his email in the app but does not yet have an account created.
  /// A screen should be displayed for him to create a password for his new account.
  /// This value is not saved in the database.
  EMAIL_ENTERED_NOT_USER,

  /// The user has entered his email in the app and already has an account created.
  /// A screen should be displayed for him to enter his password.
  /// This value is not saved in the database.
  EMAIL_ENTERED_YES_USER,

  /// The user has created their account (or has just logged in) but has not yet verified their account via email.
  /// A message and button should be displayed to resend the verification email.
  /// This value is not saved in the database, but is obtained from the [emailVerified] parameter of the Firebase [user] object.
  EMAIL_NOT_VERIFIED,

  /// The user has logged into the app. You have not yet submitted your personal data.
  /// A screen should be displayed for you to load your data.
  /// This value is saved in the database.
  SEND_USER_DATA,

  /// The user has sent his data, an administrator must verify if he is affiliated or not.
  /// A message should be displayed informing the status of his verification.
  /// This value is saved in the database.
  PENDING_VERIFICATION,

  /// The user has been blocked by an administrator.
  /// A message should be displayed informing the status of his verification.
  /// This value is saved in the database.
  BLOCKED,

  /// An administrator has marked the user as unaffiliated.
  /// A message should be displayed informing the status of his verification.
  /// This value is saved in the database.
  NOT_AFFILIATED,

  /// An administrator has marked the user as an affiliate.
  /// Discount list should be displayed.
  /// This value is saved in the database.
  AFFILIATED,

  /// The user has submitted the affiliation form, an administrator is reviewing it.
  /// A message should be displayed informing the status of his affiliation.
  /// This value is saved in the database.
  AFFILIATION_FORM_PENDING
}
