//
//  BankCustomView.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import UIKit

class BankCustomView: UIView, UITableViewDelegate {
    typealias DataSource = UITableViewDiffableDataSource<Section, BankRecord>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, BankRecord>

    enum Section {
        case main
    }

    private lazy var dataSource = self.configureDataSource()
    private let sampleData = BankRecord.sample

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BankTaskTableViewCell.self,
                           forCellReuseIdentifier: BankTaskTableViewCell.identifier)
        return tableView
    }()

    init() {
        super.init(frame: .zero)
        setupDefault()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func setupDefault() {
        addSubview(tableView)

        tableView.delegate = self
        configureLayout()
        updateDataSource(data: sampleData)
    }

    private func configureLayout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    private func configureDataSource() -> DataSource {
        dataSource = DataSource(tableView: tableView, cellProvider: { tableView, indexPath, record -> UITableViewCell? in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BankTaskTableViewCell.identifier, for: indexPath) as? BankTaskTableViewCell else {
                return UITableViewCell()
            }

            cell.configureUI(model: record)

            return cell
        })

        return dataSource
    }

    private func updateDataSource(data: [BankRecord]) {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(data)

        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
}
