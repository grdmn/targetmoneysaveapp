//
//  StatusMoneyTableViewCell.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit

class StatusMoneyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var TextStatusLbl:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(moneyData: MoneyData){
        
        TextStatusLbl.text = moneyData.MoneyText
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
