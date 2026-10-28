


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
    private let loginErrorLabel = ErrorLabel()
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
                loginErrorLabel,
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
        
        loginErrorLabel.text = "Неверный логин или пароль"
        loginErrorLabel.isHidden = true
        
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
            make.top.equalToSuperview().offset(8)
            make.leading.trailing.equalToSuperview()
                .inset(24)
            make.height.equalTo(116)
        }
        loginStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview()
                .inset(24)
            make.height.equalTo(210)
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
    
    func setLoginFieldsError(_ isError: Bool) {
        let borderColor: UIColor = isError ? .systemRed : .clear

        loginTextField.layer.borderWidth = isError ? 0.5 : 0
        loginTextField.layer.borderColor = borderColor.cgColor

        passwordTextField.layer.borderWidth = isError ? 0.5 : 0
        passwordTextField.layer.borderColor = borderColor.cgColor

        loginErrorLabel.isHidden = !isError
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
        setLoginFieldsError(false)
        loginTextField.text = EmptyTextFieldStrings.emptyTextFieldState.rawValue
        passwordTextField.text = EmptyTextFieldStrings.emptyTextFieldState.rawValue
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

        let login = loginTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue
        let password = passwordTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue

        delegate?.authBottomSheetDidTapLoginSubmit(
            login: login,
            password: password
        )
    }
    
    @objc private func registrationSubmitButtonTapped() {
        let firstName = firstNameTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue
        let lastName = lastNameTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue
        let email = emailTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue
        let password = registrationPasswordTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue
        let repeatPassword = repeatPasswordTextField.text ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue

        delegate?.authBottomSheetDidTapRegistrationSubmit(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            repeatPassword: repeatPassword
        )
    }
  
}


protocol ActivityBottomSheetViewDelegate: AnyObject {
    func activityBottomSheetDidTapClose()
}

final class ActivityBottomSheetView: UIView {
    
    weak var delegate: ActivityBottomSheetViewDelegate?

    private let activity: Activity

    private let closeButton = CloseButton()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let createdAtLabel = UILabel()

    init(activity: Activity) {
        self.activity = activity
        super.init(frame: .zero)

        configureUI()
        configureConstraints()
        configureActions()
        configure(with: activity)
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
        clipsToBounds = true

        titleLabel.font = .systemFont(
            ofSize: 24,
            weight: .bold
        )
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 0

        descriptionLabel.font = .systemFont(
            ofSize: 16,
            weight: .regular
        )
        descriptionLabel.textColor = .secondaryLabel
        descriptionLabel.numberOfLines = 0

        createdAtLabel.font = .systemFont(
            ofSize: 14,
            weight: .regular
        )
        createdAtLabel.textColor = .secondaryLabel
        createdAtLabel.numberOfLines = 0

        addSubview(closeButton)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(createdAtLabel)
    }

    private func configureConstraints() {
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(30)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(closeButton.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(24)
        }

        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleLabel)
        }

        createdAtLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalTo(titleLabel)
        }
    }

    private func configureActions() {
        closeButton.addTarget(
            self,
            action: #selector(closeButtonTapped),
            for: .touchUpInside
        )
    }

    private func configure(with activity: Activity) {
        titleLabel.text = activity.title

        descriptionLabel.text = activity.description.isEmpty
            ? "Описание отсутствует"
            : activity.description

        let date = Date(
            timeIntervalSince1970: activity.createdAt
        )

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short

        createdAtLabel.text =
            "Создано: \(formatter.string(from: date))"
    }

    @objc private func closeButtonTapped() {
        delegate?.activityBottomSheetDidTapClose()
    }
}

protocol ActivityEditBottomSheetViewDelegate: AnyObject {
    func activityEditBottomSheet(
        didSaveTitle title: String,
        description: String,
        for activity: Activity
    )
    func activityEditBottomSheetDidCancel()
}

final class ActivityEditBottomSheetView: UIView {

    weak var delegate: ActivityEditBottomSheetViewDelegate?

    private let activity: Activity

    private let titleField = UITextField()
    private let descriptionField = UITextField()
    private let saveButton = UIButton(type: .system)
    private let cancelButton = UIButton(type: .system)

    init(activity: Activity) {
        self.activity = activity
        super.init(frame: .zero)

        configureUI()
        configureConstraints()
        configureFields()
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
        clipsToBounds = true

        titleField.placeholder = "Название задачи"
        titleField.borderStyle = .roundedRect
        titleField.font = .systemFont(ofSize: 16)

        descriptionField.placeholder = "Описание задачи"
        descriptionField.borderStyle = .roundedRect
        descriptionField.font = .systemFont(ofSize: 16)

        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = UIColor(
            red: 57 / 255,
            green: 117 / 255,
            blue: 215 / 255,
            alpha: 1
        )
        saveButton.layer.cornerRadius = 12

        cancelButton.setTitle("Отмена", for: .normal)
        cancelButton.setTitleColor(.secondaryLabel, for: .normal)

        addSubview(titleField)
        addSubview(descriptionField)
        addSubview(saveButton)
        addSubview(cancelButton)
    }

    private func configureConstraints() {
        titleField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(48)
        }

        descriptionField.snp.makeConstraints { make in
            make.top.equalTo(titleField.snp.bottom).offset(16)
            make.leading.trailing.equalTo(titleField)
            make.height.equalTo(48)
        }

        saveButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionField.snp.bottom).offset(24)
            make.leading.trailing.equalTo(titleField)
            make.height.equalTo(50)
        }

        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(24)
            make.height.equalTo(40)
        }
    }

    private func configureFields() {
        titleField.text = activity.title
        descriptionField.text = activity.description
    }

    private func configureActions() {
        saveButton.addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )

        cancelButton.addTarget(
            self,
            action: #selector(cancelButtonTapped),
            for: .touchUpInside
        )
    }

    @objc private func saveButtonTapped() {
        let title = titleField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue

        let description = descriptionField.text?
            .trimmingCharacters(in: .whitespacesAndNewlines) ?? EmptyTextFieldStrings.emptyTextFieldState.rawValue

        guard !title.isEmpty else { return }

        delegate?.activityEditBottomSheet(
            didSaveTitle: title,
            description: description,
            for: activity
        )
    }

    @objc private func cancelButtonTapped() {
        delegate?.activityEditBottomSheetDidCancel()
    }
}
