//
//  GistListTableViewCell.swift
//  IOS-Test-Task
//
//  Created by Сергей Бекезин on 22.10.2024.
//

import UIKit
import TinyConstraints

class GistListTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        selectionStyle = .default
        textLabel?.font = .systemFont(ofSize: 17)
        textLabel?.textColor = .appMainTextColor
        
        detailTextLabel?.font = .systemFont(ofSize: 13)
        detailTextLabel?.textColor = .appMainTextColor
        
        separatorInset = .left(64)
        
        if let imageView = imageView {
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 7).isActive = true
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -7).isActive = true
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        }
        
        let accessoryImageView = ViewsFactory.defaultImageView(image: AppImage.sfChevronRight.uiImageWith(tint: UIColor.appSystemGray))
        accessoryImageView.sizeToFit()
        accessoryView = accessoryImageView
        
        backgroundColor = .appMainTableCell
    }
    
    func configure(with item: GistListItemModel) {
        textLabel?.text = item.authorNickname
        imageView?.image = item.authorAvatar
        detailTextLabel?.text = item.gistName
    }

}
