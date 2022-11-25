//
//  ViewController.swift
//  ExSelfSizing
//
//  Created by 김종권 on 2022/11/25.
//

import UIKit

class ViewController: UIViewController {
  private var items = (0...2).map { String($0) }
  private let scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
  }()
  private let stackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.translatesAutoresizingMaskIntoConstraints = false
    return stackView
  }()
  private let tableView: SelfSizingTableView = {
    let view = SelfSizingTableView()
    view.allowsSelection = false
    view.backgroundColor = .clear
    view.separatorStyle = .none
    view.bounces = true
    view.showsVerticalScrollIndicator = true
    view.contentInset = .zero
    view.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    view.estimatedRowHeight = 120
    view.translatesAutoresizingMaskIntoConstraints = false
    view.isScrollEnabled = false
    return view
  }()
  private let button: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("데이터 추가", for: .normal)
    button.addTarget(self, action: #selector(tap), for: .touchUpInside)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  private let label: UILabel = {
    let label = UILabel()
    label.text = "테이블뷰 밑에 있는 Label"
    label.font = .systemFont(ofSize: 24)
    label.numberOfLines = 1
    label.textColor = .black
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(scrollView) // <-
    scrollView.addSubview(stackView) // <-
    view.addSubview(button)
    view.addSubview(label)
    
    stackView.addArrangedSubview(tableView)
    tableView.dataSource = self
    
    NSLayoutConstraint.activate([
      scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
      scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      
      stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
      stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // 주의
      
      label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      label.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
      
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -120)
    ])
  }
  
  @objc private func tap() {
    let array = (Int(items.last!)!+1...Int(items.last!)!+2).map { String($0) }
    items.append(contentsOf: array)
    tableView.reloadData()
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    cell.textLabel?.textColor = .white
    cell.backgroundColor = .random()
    return cell
  }
}

extension CGFloat {
  static func random() -> CGFloat {
    return CGFloat(arc4random()) / CGFloat(UInt32.max)
  }
}

extension UIColor {
  static func random() -> UIColor {
    return UIColor(
      red:   .random(),
      green: .random(),
      blue:  .random(),
      alpha: 1.0
    )
  }
}
