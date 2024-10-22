//
//  ViewsFactory.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import TinyConstraints
import UIKit

class ViewsFactory {
    
    class func defaultButton(
        type: UIButton.ButtonType = .system,
        height: CGFloat? = nil,
        color: UIColor = .appSystemBlue,
        radius: CGFloat = 0,
        font: UIFont = .boldSystemFont(ofSize: 20),
        titleColor: UIColor = .appMainTextColor
    ) -> UIButton {
        let button = UIButton(type: type)
        if let height = height {
            button.height(height)
        }
        button.backgroundColor = color
        button.layer.cornerRadius = radius
        button.titleLabel?.font = font
        button.setTitleColor(titleColor, for: .normal)
        return button
    }
    
    class func defaultLabel(
        lines: Int = 1,
        textColor: UIColor = .appMainTextColor,
        font: UIFont = .systemFont(ofSize: 17),
        alignment: NSTextAlignment = .natural,
        adjustFont: Bool = false
    ) -> UILabel {
        let label = UILabel()
        label.numberOfLines = lines
        label.textColor = textColor
        label.font = font
        label.textAlignment = alignment
        if adjustFont {
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 0.5
        }
        return label
    }
    
    class func defaultImageView(
        contentMode: UIView.ContentMode = .scaleAspectFit,
        image: UIImage? = nil
    ) -> UIImageView {
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        return imageView
    }
    
    class func defaultScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        return scrollView
    }
    
    class func defaultStackView(
        axis: NSLayoutConstraint.Axis = .horizontal,
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        margins: TinyEdgeInsets? = nil
    ) -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.alignment = alignment
        if let margins = margins {
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = margins
        }
        return stackView
    }
    
    class func defaultTableView(style: UITableView.Style = .plain) -> UITableView {
        let tableView = UITableView(frame: .zero, style: style)
        tableView.backgroundColor = .appClear
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        tableView.tableHeaderView = UIView()
        tableView.tableFooterView = UIView()
        return tableView
    }

    class func defaultTextView(font: UIFont = .systemFont(ofSize: 15), containerInset: TinyEdgeInsets = .uniform(12)) -> UITextView {
        let textView = UITextView()
        textView.font = font
        textView.textContainerInset = containerInset
        return textView
    }
    
    class func defaultCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .appClear
        collectionView.alwaysBounceVertical = true
        return collectionView
    }
    
}
