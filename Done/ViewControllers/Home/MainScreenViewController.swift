//
//  MainScreenViewController.swift
//  Done
//
//  Created by LizOk&Same on 23.08.26.
//



import UIKit
import SnapKit


class MainScreenViewController: UIViewController {
    
    private let goBackButton = BackButtons()
    private let goToSettingsButton = AppButtons()
    private let goToAddTaskButton = AppButtons()
    private let goToStatisticsButton = AppButtons()
    private let navigationBar = AppNavigationBar()
    private let screenNameLabel = ScreenTitleLabel()
    private let navigationButtonBlock = UIView()
    private let logoutButton = LogoutButton()
    
    override func viewDidLoad() {
        configureUI()
        super.viewDidLoad()
        }
    
    func configureUI() {
        view.backgroundColor = UIColor(
            red: 244.0 / 255.0,
            green: 245.0 / 255.0,
            blue: 247.0 / 255.0,
            alpha: 1
        )
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(60)
        }
        navigationBar.addSubview(goBackButton)
        goBackButton.setTitleColor(.black, for: .normal)
        goBackButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(4)
            make.bottom.equalToSuperview().offset(-4)
            make.width.equalTo(50)
        }
        goBackButton.addTarget(self, action: #selector(backButtonTapped( _:)), for: .touchUpInside)
        navigationBar.addSubview(screenNameLabel)
        screenNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        screenNameLabel.text = ScreenNamesTitleStrings.mainScreenTitle.rawValue
        
        
        view.addSubview(navigationButtonBlock)
        navigationButtonBlock.backgroundColor = .white
        navigationButtonBlock.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(Offsets.leftAndRightOffset.rawValue)
            make.right.equalToSuperview().offset(-(Offsets.leftAndRightOffset.rawValue))
            make.top.equalTo(navigationBar.snp.bottom).offset(16)
            make.bottom.equalToSuperview()
        }
        navigationButtonBlock.layer.cornerRadius = 16
        navigationButtonBlock.addSubview(goToAddTaskButton)
        navigationButtonBlock.addSubview(goToStatisticsButton)
        navigationButtonBlock.addSubview(goToSettingsButton)
        navigationButtonBlock.addSubview(logoutButton)
        
        
        goToStatisticsButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(Offsets.leftAndRightOffset.rawValue)
            make.right.equalToSuperview().inset(Offsets.leftAndRightOffset.rawValue)
            make.height.equalTo(64)
        }
        goToStatisticsButton.setTitle(NavigationButtonsStrings.statisticsButtonTitle.rawValue, for: .normal)
        goToStatisticsButton.setTitleColor(.black, for: .normal)
        goToStatisticsButton.addTarget(self, action: #selector(statisticButtonTapped (_:)), for: .touchUpInside)
        
        goToAddTaskButton.snp.makeConstraints { make in
            make.centerX.equalTo(goToStatisticsButton)
            make.width.equalTo(goToStatisticsButton)
            make.height.equalTo(goToStatisticsButton)
            make.bottom.equalTo(goToStatisticsButton.snp.top).offset(-16)
        }
        goToAddTaskButton.setTitle(NavigationButtonsStrings.addTaskButtonTitle.rawValue, for: .normal)
        goToAddTaskButton.setTitleColor(.black, for: .normal)
        goToAddTaskButton.addTarget(self, action: #selector(addButtonTapped(_:)), for: .touchUpInside)
        
        goToSettingsButton.snp.makeConstraints { make in
            make.centerX.equalTo(goToStatisticsButton)
            make.top.equalTo(goToStatisticsButton.snp.bottom).offset(16)
            make.width.equalTo(goToStatisticsButton)
            make.height.equalTo(goToStatisticsButton)
        }
        goToSettingsButton.setTitle(NavigationButtonsStrings.settingsButtonTitle.rawValue, for: .normal)
        goToSettingsButton.setTitleColor(.black, for: .normal)
        goToSettingsButton.addTarget(self, action: #selector(settingsButtonTapped( _:)), for: .touchUpInside)
        
        logoutButton.snp.makeConstraints { make in
            make.left.equalTo(goToStatisticsButton)
            make.right.equalTo(goToStatisticsButton)
            make.bottom.equalToSuperview().offset(-24)
            make.height.equalTo(goToStatisticsButton)
        }

        logoutButton.addTarget(
            self,
            action: #selector(logoutButtonTapped(_:)),
            for: .touchUpInside
        )
    }
    
    private func goBack() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func backButtonTapped(_ Sender: UIButton ) {
        goBack()
    }
    
    private func goToSettings() {
        let controller = SettingsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc private func settingsButtonTapped(_ Sender: UIButton ) {
        goToSettings()
    }
    
    private func goToStatistic() {
        let controller = StatisticsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    func logout() {
        AuthAndRegistrationManager.shared.logout()

        navigationController?.setViewControllers(
            [RegistrationAndLoginViewController()],
            animated: true
        )
    }
    @objc private func statisticButtonTapped(_ Sender: UIButton ) {
        goToStatistic()
    }
    
    private func goToAddTask() {
        let controller = ActivityFormViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    @objc private func addButtonTapped(_ Sender: UIButton ) {
        goToAddTask()
    }
    @objc private func logoutButtonTapped(_ sender: UIButton) {
        logout()
    }
    
    
}
