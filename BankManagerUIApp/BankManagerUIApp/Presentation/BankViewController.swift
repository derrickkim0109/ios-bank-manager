//
//  BankViewController.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import UIKit

final class BankViewController: UIViewController {
    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addAndResetbuttonStackView,
                                                       workingTime,
                                                       waitingAndWoringLabelStackView,
                                                       waitingAndWoringTableViewStackView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var addAndResetbuttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addClientButton, resetButton])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let addClientButton: UIButton = {
        let button = UIButton()
        button.setTitle("고객 10명 추가", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let workingTime: UILabel = {
        let label = UILabel()
        label.text = "업무시간 - 04:33:253"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()

    private lazy var waitingAndWoringLabelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [waitingLabel, workingLabel])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let waitingLabel: UILabel = {
        let label = UILabel()
        label.text = "대기중"
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    private let workingLabel: UILabel = {
        let label = UILabel()
        label.text = "업무중"
        label.textColor = .white
        label.backgroundColor = .systemBlue
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    private lazy var waitingAndWoringTableViewStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [waitingTableView, workingTableView])
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let waitingTableView = BankCustomView()
    private let workingTableView = BankCustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
    }

    private func setupDefault() {
        view.backgroundColor = .white
        view.addSubview(rootStackView)

        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            workingTime.heightAnchor.constraint(equalTo: waitingAndWoringLabelStackView.heightAnchor),
            workingTime.heightAnchor.constraint(equalTo: addAndResetbuttonStackView.heightAnchor, multiplier: 1.5)
        ])
    }
}

