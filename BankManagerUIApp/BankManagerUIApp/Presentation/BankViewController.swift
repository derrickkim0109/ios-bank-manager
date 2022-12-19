//
//  BankViewController.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import UIKit

final class BankViewController: UIViewController {
    private let bank = Bank()

    private var lastTicketNumber = 1

    private var taskTimer: Timer?
    private var taskTime: Int = 0 {
        didSet {
            let (minute, second, millisecond) = taskTime.detailTime()
            workingTimeLabel.text = Const.workingTimeLabel + minute + Const.colons + second + Const.colons + millisecond
        }
    }

    private lazy var rootStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addAndResetbuttonStackView,
                                                       workingTimeLabel,
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
        button.setTitle(Const.addTenClients, for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.textAlignment = .center
        return button
    }()

    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle(Const.reset, for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    private let workingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = Const.workingTimeLabel + Const.time
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
        label.text = Const.waiting
        label.textColor = .white
        label.backgroundColor = .systemGreen
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title1)
        return label
    }()

    private let workingLabel: UILabel = {
        let label = UILabel()
        label.text = Const.working
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

    private lazy var waitingTableView = BankCustomView()
    private lazy var workingTableView = BankCustomView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
    }

    private func setupDefault() {
        view.backgroundColor = .white
        view.addSubview(rootStackView)
        configureLayouts()
        configureButtons()
        bank.fetchDelegate(self)
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

            workingTimeLabel.heightAnchor.constraint(equalTo: waitingAndWoringLabelStackView.heightAnchor),
            workingTimeLabel.heightAnchor.constraint(equalTo: addAndResetbuttonStackView.heightAnchor, multiplier: 1.5)
        ])
    }

    private func configureButtons() {
        addClientButton.addTarget(self,
                                  action: #selector(didTapAddClients(_:)),
                                  for: .touchUpInside)
        resetButton.addTarget(self,
                              action: #selector(didTapReset(_:)),
                              for: .touchUpInside)
    }

    private enum Const {
        static let addTenClients = "고객 10명 추가"
        static let reset = "초기화"
        static let workingTimeLabel = "업무시간 - "
        static let time = "00:00:000"
        static let waiting = "대기중"
        static let working = "업무중"
        static let colons = ":"
    }
}

extension BankViewController {
    @objc private func didTapAddClients(_ sender: UIButton) {
        run()
    }

    @objc private func didTapReset(_ sender: UIButton) {
        resetTimer()
        resetRecord()
        lastTicketNumber = 1
    }

    @objc private func timeUp() {
        taskTime += 1
    }

    private func run() {
        addClients()
        setupTimer()
    }

    private func addClients() {
        let clientGenerator = ClientQueueGenerator()
        let clients = clientGenerator.generate(lastTicketNumber)

        waitingTableView.model += clientGenerator.setupClientList()
        bank.open(clients: clients)

        lastTicketNumber += 10
    }

    private func setupTimer() {
        taskTimer = Timer.scheduledTimer(timeInterval: 0.001,
                                        target: self,
                                        selector: #selector(timeUp),
                                        userInfo: nil,
                                        repeats: true)
        taskTimer?.fire()

        RunLoop.main.add(taskTimer!, forMode: .common)
    }

    private func stopTimer() {
        taskTimer?.invalidate()
        taskTimer = nil
    }

    private func resetTimer() {
        taskTimer?.invalidate()
        taskTimer = nil
        taskTime = 0
        lastTicketNumber = 1
        bank.stopTask()
    }

    private func resetRecord() {
        waitingTableView.model.removeAll()
        workingTableView.model.removeAll()
    }
}

extension BankViewController: BankManagerable {
    func startTask(for client: Client) {
        OperationQueue.main.addOperation { [weak self] in
            self?.waitingTableView.remove(client.pickedUpTicket)
            self?.workingTableView.update(client.pickedUpTicket)
        }
    }

    func finishTask(for client: Client) {
        OperationQueue.main.addOperation { [weak self] in
            self?.workingTableView.remove(client.pickedUpTicket)
        }
    }

    func terminateTask() {
        stopTimer()
    }
}
}

