//
//  ScreenCell.swift
//  UIKitTest
//
//  Created by 紹郁 on 2025/2/6.
//

import UIKit

class ScreenCell: UITableViewCell {

    var itemText: String = "" {
        didSet {
            itemLabel.text = itemText
        }
    }
    
    private let itemLabel: MyLabel = {
        let label = MyLabel()
        label.font = UIFont.boldTitle3
        label.textAlignment = .left
        label.padding(to: 0, left: 10)
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let itemImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: SFSymbol.arrow_right.rawValue)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let itemView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableItem()
    }
    
    private func setupTableItem() {
        itemView.addArrangedSubview(itemLabel)
        itemView.addArrangedSubview(itemImage)
        contentView.addSubview(itemView)
        
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            itemView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            itemLabel.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 10),
            itemLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 10),
            itemLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -10),
            itemLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -10),
            
            itemImage.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 15),
            itemImage.leadingAnchor.constraint(equalTo: itemLabel.trailingAnchor, constant: 15),
            itemImage.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -15),
            itemImage.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -15),
            
            itemLabel.widthAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: 0.8),
            itemImage.widthAnchor.constraint(equalTo: itemView.widthAnchor, multiplier: 0.2),
            itemView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
