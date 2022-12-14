//
//  BankTaskTableViewCell.swift
//  BankManagerUIApp
//
//  Created by Derrick kim on 2022/12/14.
//

import UIKit

final class BankTaskTableViewCell: UITableViewCell {
    static let identifier = "BankTaskTableViewCell"

    private let clientQueueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupDefalut()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        clientQueueLabel.text = nil
    }

    private func setupDefalut() {
        contentView.addSubview(clientQueueLabel)
        configureLayouts()
    }

    private func configureLayouts() {
        NSLayoutConstraint.activate([
            clientQueueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            clientQueueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            clientQueueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            clientQueueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }

    func configureUI(model: BankRecord) {
        clientQueueLabel.text = model.task
        clientQueueLabel.textColor = model.task.contains("대출") ? .purple : .label
    }
}
