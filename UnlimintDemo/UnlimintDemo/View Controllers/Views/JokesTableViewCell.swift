//
//  JokesTableViewCell.swift
//  UnlimintDemo
//
//  Created by Romesh Bansal on 29/06/23.
//

import UIKit

class JokesTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    let lblJoke:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        containerView.addSubview(lblJoke)
        
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
                
        lblJoke.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        lblJoke.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:15).isActive = true
        lblJoke.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-15).isActive = true
        lblJoke.topAnchor.constraint(equalTo:self.containerView.topAnchor, constant:15).isActive = true
        lblJoke.heightAnchor.constraint(greaterThanOrEqualToConstant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
}
