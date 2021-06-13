//
//  StargazerTableViewCell.swift
//  GithubStargazers
//
//  Created by Mario Severino on 12/06/21.
//

import UIKit

class StargazerTableViewCell: UITableViewCell {
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var userNameDescriptionLabel: UILabel!
    @IBOutlet var userImage: UIImageView!
    
    var onReuse: () -> Void = {}

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userImage.image = nil
        userImage.cancelImageLoad()
    }

}
