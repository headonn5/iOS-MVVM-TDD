//
//  PostTableViewCell.swift
//  MvvmByTddApp
//
//  Created by Paul, Nishant on 17/02/21.
//

import UIKit

class PostTableViewCell: UITableViewCell {

  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var bodyLabel: UILabel!
  
  static let reuseIdentifier = String(describing: PostTableViewCell.self)
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
