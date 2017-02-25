//
//  ShowTargetAllTableViewCell.swift
//  targetmoneysaveapp
//
//  Created by Apple Macintosh on 2/25/17.
//  Copyright © 2017 Apple Macintosh. All rights reserved.
//

import UIKit

class ShowTargetAllTableViewCell: UITableViewCell {
    
    @IBOutlet weak var allNameTarget:UILabel!
    @IBOutlet weak var priceTarget:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setValue(moneyData: MoneyData){
        
        allNameTarget.text = moneyData.NameTargetText
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
