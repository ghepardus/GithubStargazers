//
//  LoadingTableViewCell.swift
//  GithubStargazers
//
//  Created by Mario Severino on 13/06/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    @IBOutlet var spinner: UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
