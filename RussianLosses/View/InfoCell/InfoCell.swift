//
//  InfoCell.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class InfoCell: UITableViewCell {
    
    static let cellId = "InfoCellId"
    static let nibName = "InfoCell"
    
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func uploadData(cellType: String, cellValue: Int) {
        countLabel.text = String(cellValue)
        if let pickture = UIImage(named: cellType) {
            pictureImageView.image = pickture
        }
    }
    
}
