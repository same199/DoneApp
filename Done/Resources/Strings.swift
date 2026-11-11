//
//  Strings.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



public enum LoginAndRegistrationViewStrings: String {
    case loginButtonTittle = "Sign in"
    case registrationButtoTittle = "Registration"
}

public enum LogoutAlertStrings: String {
    case logoutAlertButtonTittle = "Logout"
    case logoutAlertCancelButtonTittle = "Cancel"
    case logoutAlertTitle = "Log out of your account?"
    case logoutAlertMessage = "You will be able to log in again using your details"
}

public enum GoBackStrings: String {
    case goBackButtonTittle = "Back"

}

public enum NavigationButtonsStrings: String {
    case addTaskButtonTitle = "Tasks"
    case settingsButtonTitle = "Settings"
    case statisticsButtonTitle = "Statistics"
}

public enum ScreenNamesTitleStrings: String {
    case loginScreenTitle = "Login"
    case registrationScreenTitle = "Registration"
    case settingsScreenTitle = "Settings"
    case statisticsScreenTitle = "Statistics"
    case taskListScreenTitle = "Tasks"
    case mainScreenTitle = "DoneApp"
}

public enum DeleteAlertStrings: String {
    case deleteAlertButtonTitle = "Delete all information"
    case deleteAlertTitle = "Are you sure?"
    case deleteAlertMessage = "Deleting this task will erase all its progress."
    case deleteAlertCancelButtonTitle = "Cancel"
    case deleteAlertDeleteButtonTitle = "Delete"
}

public enum EmptyTextFieldStrings: String {
    case emptyTextFieldState = ""
    case emptuActivityListState = "List with activities is empty"
}

public enum ErrorLabelStrings: String {
    case loginErrorLabelState = "Incorrect email or password"
    case emailErrorLabelState = "Incorrect email format"
    case passwordAndConfirmPasswordErrorLabelState = "Passwords do not match"
}

public enum AboutAppString: String {
    case aboutAppTitleState = "About"
    case aboutAppState = "DoneApp is a simple app for tracking your progress in completing tasks."
    case aboutAppButtonTitleState = "OK"
    case appVersionState = "App version:"
    case versionOSState = "OS version:"
    case developerNameState = "Developer:"
    case developerInfo = "Artsiom Stulba"
    case iOSstringsState = "iOS"
}

public enum UserInfoString: String {
    case userInfoTitleState = "User info"
    case userInfoLogoutButtonTitleState = "Logout"
}
