//
//  DataCellA.swift
//  jUnkLoop
//
//  Created by grachro on 2014/08/24.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class DataCellA: UITableViewCell {

    @IBOutlet weak var cellCaption: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setCaption(text:String){
        self.cellCaption.text = text
    }
}
