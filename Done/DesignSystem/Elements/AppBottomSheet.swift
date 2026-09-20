


import UIKit
import SnapKit


protocol AuthBottomSheetViewDelegate: AnyObject {
    func authBottomSheetDidTapLogin()
    func authBottomSheetDidTapRegistration()
    func authBottomSheetDidTapClose()
    func authBottomSheetDidTapLoginSubmit(
        login: String,
        password: String
    )
    func authBottomSheetDidTapRegistrationSubmit(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        repeatPassword: String
    )
}

final class AuthBottomSheetView: UIView {
    
    weak var delegate: AuthBottomSheetViewDelegate?
    private let closeButton = CloseButton()
    private let registrationButton: AppButtons = {
        let button = AppButtons()
        button.setTitle("Регистрация", for: .normal)
        return button
    }()
    private let loginButton: AppButtons = {
        let button = AppButtons()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    private let loginSubmitButton: AppButtons = {
        let button = AppButtons()
        button.setTitle("Войти", for: .normal)
        return button
    }()
    private let registrationSubmitButton: AppButtons = {
        let button = AppButtons()
        button.setTitle("Зарегистрироваться", for: .normal)
        return button
    }()
    
    
    private let loginTextField: AppTextField = {
        let textField = AppTextField()
        textField.placeholder = "Логин"
        return textField
    }()
    private let passwordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "Пароль"
        return textField
    }()
    private let firstNameTextField: AppTextField = {
        let textField = AppTextField()
        textField.placeholder = "Имя"
        return textField
    }()
    private let lastNameTextField: AppTextField = {
        let textField = AppTextField()
        textField.placeholder = "Фамилия"
        return textField
    }()
    private let emailTextField: EmailTextField = {
        let textField = EmailTextField()
        textField.placeholder = "Почта"
        return textField
    }()
    private let registrationPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "Пароль"
        return textField
    }()

    private let repeatPasswordTextField: PasswordTextField = {
        let textField = PasswordTextField()
        textField.placeholder = "Повторите пароль"
        return textField
    }()
    
    
    private lazy var startStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                registrationButton,
                loginButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                loginTextField,
                passwordTextField,
                loginSubmitButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    private lazy var registrationStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                firstNameTextField,
                lastNameTextField,
                emailTextField,
                registrationPasswordTextField,
                repeatPasswordTextField,
                registrationSubmitButton
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 24
        layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        addSubview(closeButton)
        addSubview(startStackView)
        addSubview(loginStackView)
        addSubview(registrationStackView)
        startStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
                .inset(24)
            make.height.equalTo(116)
        }
        loginStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
                .inset(24)
            make.height.equalTo(182)
        }
        registrationStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
                .inset(24)
            make.height.equalTo(360)
        }

        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(30)
        }
        closeButton.isHidden = true
        closeButton.alpha = 0
        loginStackView.isHidden = true
        loginStackView.alpha = 0
        registrationStackView.isHidden = true
        registrationStackView.alpha = 0
    }
    
    
    private func configureActions() {
        registrationButton.addTarget(
            self,
            action: #selector(registrationButtonTapped),
            for: .touchUpInside
        )
        loginButton.addTarget(
            self,
            action: #selector(loginButtonTapped),
            for: .touchUpInside
        )
        loginSubmitButton.addTarget(
            self,
            action: #selector(loginSubmitButtonTapped),
            for: .touchUpInside
        )
        registrationSubmitButton.addTarget(
            self,
            action: #selector(registrationSubmitButtonTapped),
            for: .touchUpInside
        )
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }
    
    
    @objc private func loginButtonTapped() {
        delegate?.authBottomSheetDidTapLogin()
    }
    
    @objc private func registrationButtonTapped() {
        delegate?.authBottomSheetDidTapRegistration()
    }
    
    @objc private func closeButtonTapped() {
        delegate?.authBottomSheetDidTapClose()
    }
    
    
    func showLogin() {
        self.snp.updateConstraints { make in
            make.height.equalTo(300)
        }
        loginStackView.isHidden = false
        closeButton.isHidden = false
        closeButton.alpha = 1
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            options: .curveEaseInOut
        ) {
            self.startStackView.alpha = 0
            self.loginStackView.alpha = 1
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            self.startStackView.isHidden = true
        }
    }
    
    
    func showRegistration() {
        self.snp.updateConstraints { make in
            make.height.equalTo(520)
        }
        registrationStackView.isHidden = false
        closeButton.isHidden = false
        closeButton.alpha = 1
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            options: .curveEaseInOut
        ) {
            self.startStackView.alpha = 0
            self.registrationStackView.alpha = 1
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            self.startStackView.isHidden = true
        }
    }
    
    func showStart() {
        self.snp.updateConstraints { make in
            make.height.equalTo(150)
        }
        startStackView.isHidden = false
        UIView.animate(
            withDuration: 0.4,
            delay: 0,
            options: .curveEaseInOut
        ) {
            self.startStackView.alpha = 1
            self.loginStackView.alpha = 0
            self.registrationStackView.alpha = 0
            self.closeButton.alpha = 0
            self.superview?.layoutIfNeeded()
        } completion: { _ in
            self.loginStackView.isHidden = true
            self.registrationStackView.isHidden = true
            self.closeButton.isHidden = true
        }
    }
    
    
    @objc private func loginSubmitButtonTapped() {
        let login = loginTextField.text ?? ""
        let password = passwordTextField.text ?? ""

        delegate?.authBottomSheetDidTapLoginSubmit(
            login: login,
            password: password
        )
    }
    
    @objc private func registrationSubmitButtonTapped() {
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        let password = registrationPasswordTextField.text ?? ""
        let repeatPassword = repeatPasswordTextField.text ?? ""

        delegate?.authBottomSheetDidTapRegistrationSubmit(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            repeatPassword: repeatPassword
        )
    }
  
}
