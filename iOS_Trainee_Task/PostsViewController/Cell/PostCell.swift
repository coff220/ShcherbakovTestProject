//
//  PostCell.swift
//  iOS_Trainee_Task
//
//  Created by Slava on 21.07.2022.
//

import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height)
    }
}

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var buttonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    var model: Post?
    var isExpanded = false
    
    var buttonTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func update(_ model: Post, expanded: Bool) {
        self.model = model
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        likeLabel.text = "\(model.like)"
        subtitleLabel.numberOfLines = expanded ? 0 : 2
        let date = Date(timeIntervalSince1970: model.date)
        dateLabel.text = "\(days(from: date)) ago"
        
        configure()
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: Date()).day ?? 0
    }
    
    func configure() {
        guard let subtitle = model?.subtitle else { return }
        
        if ceil(subtitle.height(withConstrainedWidth: subtitleLabel.frame.width,
                                  font: subtitleLabel.font)) > 41 {
            buttonHeightConstraint.constant = 25
        } else {
            buttonHeightConstraint.constant = 0
        }
    }
    
    @IBAction func expandCollapes() {
        isExpanded.toggle()
        if isExpanded {
            button.setTitle("Colapse", for: .normal)
        } else {
            button.setTitle("Expand", for: .normal)
        }
        buttonTapped?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
