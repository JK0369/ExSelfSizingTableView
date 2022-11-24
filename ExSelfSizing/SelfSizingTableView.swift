//
//  SelfSizingTableView.swift
//  ExSelfSizing
//
//  Created by 김종권 on 2022/11/25.
//

import UIKit

class SelfSizingTableView: UITableView {
  var maxHeight = UIScreen.main.bounds.size.height
  
  override var intrinsicContentSize: CGSize {
    let height = min(
      contentSize.height + contentInset.top + contentInset.bottom,
      maxHeight
    )
    return CGSize(width: contentSize.width, height: height)
  }
  
  override func layoutSubviews() {
    invalidateIntrinsicContentSize()
    super.layoutSubviews()
  }
}

class SelfSizingCollectionView: UICollectionView {
  override var intrinsicContentSize: CGSize {
    contentSize
  }
  
  override func layoutSubviews() {
    guard !bounds.size.equalTo(intrinsicContentSize) else { return }
    invalidateIntrinsicContentSize()
    super.layoutSubviews()
  }
}
