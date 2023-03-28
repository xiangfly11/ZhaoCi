//
//  MarkdownInputAccessoryView.swift
//  ZhaoCi
//
//  Created by Jiaxiang Li on 2022/8/3.
//

import Foundation
import UIKit
import SnapKit

class MarkdownInputAccessoryView: UIView {
    open var cellForItemAt:((UICollectionView, CMToolBarItem, Int) -> UICollectionViewCell)?
    open var didSelected:((CMToolBarItem, Int) -> Void)?
    
    open var rightToolBar: UIStackView = .init()
    open var closeBtn = UIButton.init(type: .custom) // 关闭按钮
    open var leftBtn = RZRTButton.init(type: .custom) // 回退
    open var rightBtn = RZRTButton.init(type: .custom) // 恢复
    
    open var collectionView: UICollectionView = .init(frame: .zero, collectionViewLayout: .init())

    open var options: CMRichTextViewOptions
    public init(frame: CGRect, options: CMRichTextViewOptions) {
        self.options = options
        super.init(frame: frame)
        self.backgroundColor = .white
        self.addSubview(collectionView)
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.4).cgColor
        self.layer.borderWidth = 1.0
    
        let layout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        let itemWidth = kScreenWidth / 8
        layout.itemSize = .init(width: itemWidth, height: 44)
        layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(RZRichTextAccessoryViewTextCell.self, forCellWithReuseIdentifier: "RZRichTextAccessoryViewTextCell")
        options.willRegisterAccessoryViewCell?(collectionView)

        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func reloadData() {
        self.collectionView.reloadData()
    }
    open override func layoutSubviews() {
        super.layoutSubviews()

        collectionView.snp.updateConstraints { make in
            make.left.equalToSuperview()
        }
        self.reloadData()
    }
    @objc open func closeBtnAction() {
        self.didSelected?(.init(type: CMTextViewToolbarItem.endEdit.rawValue), -1)
    }
}

extension MarkdownInputAccessoryView: UICollectionViewDataSource, UICollectionViewDelegate {
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.options.toolbarItems.count
    }
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = self.options.toolbarItems[indexPath.row]
        if let cell = self.options.accessoryViewCellFor?(collectionView, item, indexPath) {
            return cell
        }
        guard let cell: RZRichTextAccessoryViewTextCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RZRichTextAccessoryViewTextCell", for: indexPath) as? RZRichTextAccessoryViewTextCell else { return .init(frame: .zero) }
        cell.label.text = item.textSymbol
        return cell
    }
    open func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = self.options.toolbarItems[indexPath.row]
        self.didSelected?(item, indexPath.row)
    }
}


public class RZRichTextAccessoryViewCell: UICollectionViewCell {
    public lazy var imageView: UIImageView = .init()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(22)
        }
        imageView.contentMode = .scaleAspectFill
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public class RZRichTextAccessoryViewTextCell: UICollectionViewCell {
    public lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.WenKaiMonoBold(size: 16)
        label.textAlignment = .center
        return label
    }()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(label)
        self.contentView.backgroundColor = .white
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




public class RZRTButton: UIButton {
    public var noSelectedAlpha: CGFloat = 0.4
    public override var isSelected: Bool {
        didSet {
            if isSelected {
                self.alpha = 1
            } else {
                self.alpha = noSelectedAlpha
            }
        }
    }
}
