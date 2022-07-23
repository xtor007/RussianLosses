//
//  DayCell.swift
//  RussianLosses
//
//  Created by Anatoliy Khramchenko on 23.07.2022.
//

import UIKit

class DayCell: UITableViewCell {
    
    static let cellId = "DayCellId"
    static let nibName = "DayCell"
    
    @IBOutlet weak var equipmentLabel: UILabel!
    @IBOutlet weak var personnelLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    ///Upload data to cell
    func uploadData(_ data: LossesData) {
        dateLabel.text = data.date
        personnelLabel.text = String(data.personnel.personnel)
        equipmentLabel.text = String(data.equipment.getAllLossesCount())
    }
    
}
