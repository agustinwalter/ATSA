/// This class lists the different states in which the login process could be found.
enum LoginStatus {
  /// He has just entered the app.
  /// A welcome message and a screen to enter email or join should be displayed.
  NOT_LOGGED,

  /// He entered his email but has not yet created an account.
  /// A screen to create a new password should appear.
  EMAIL_ENTERED_NOT_USER,

  /// He entered his email and has already created an account.
  /// A screen to enter his password should appear.
  EMAIL_ENTERED_YES_USER,

  /// He has not yet verified his email.
  /// A message and button should be displayed to resend the verification email.
  EMAIL_NOT_VERIFIED,

  /// He verified his email.
  /// A screen should be displayed for him to update his name, surname and DNI.
  EMAIL_VERIFIED,

  /// Verification status
  /// A message should be displayed informing the status of your verification.
  PENDING_VERIFICATION,

  /// Verification status
  /// A message should be displayed informing the status of your verification.
  BLOCKED,

  /// Verification status
  /// A button must be displayed to join.
  NOT_AFFILIATED,

  /// Verification status
  /// Discount list should be displayed.
  AFFILIATED,

  /// He has applied to join from the app.
  /// The affiliation form must be shown.
  AFFILIATION_FORM,

  /// Administrators are reviewing the affiliation form.
  /// A message should be displayed informing the status of your affiliation.
  AFFILIATION_FORM_PENDING
}
