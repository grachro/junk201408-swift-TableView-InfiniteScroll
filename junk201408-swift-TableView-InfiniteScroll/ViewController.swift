//
//  ViewController.swift
//  junk201408-swift-TableView-InfiniteScroll
//
//  Created by grachro on 2014/08/24.
//  Copyright (c) 2014年 grachro. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
                            
    let DETA_SECTION = 0
    let FOTTER_SECTION = 1
    
    var dateSize = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 2
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        if section == DETA_SECTION {
            return self.dateSize
        } else if section == FOTTER_SECTION {
            return 1
        }
        return 0
    }
    
    
    //UITableViewDataSource
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        if indexPath.section == DETA_SECTION {
            let cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath) as DataCell
            cell.setCaption("Dataセル セクション:\(indexPath.section)  \(indexPath.row + 1)行目")
            return cell
        } else if indexPath.section == FOTTER_SECTION {
            let cell = tableView.dequeueReusableCellWithIdentifier("fotterCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {
        println("セクション:\(indexPath.section)  \(indexPath.row + 1)行目")
        
        if indexPath.section == FOTTER_SECTION {
            self.dateSize += 10
            tableView.reloadData()
        }
    }
}

