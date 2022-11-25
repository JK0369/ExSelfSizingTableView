//
//  SelfSizingTableView.swift
//  ExSelfSizing
//
//  Created by 김종권 on 2022/11/25.
//

import UIKit

class SelfSizingTableView: UITableView {
  override var intrinsicContentSize: CGSize {
    contentSize
  }
  
  override func layoutSubviews() {
    invalidateIntrinsicContentSize()
    super.layoutSubviews()
  }
}
