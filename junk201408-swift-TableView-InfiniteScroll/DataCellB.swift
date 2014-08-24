//
//  DataCellB.swift
//  junk201408-swift-TableView-InfiniteScroll
//
//  Created by grachro on 2014/08/24.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class DataCellB: UITableViewCell {
    
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
