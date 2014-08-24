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

    let refreshControl = UIRefreshControl()
    
    let DETA_SECTION = 0
    let FOTTER_SECTION = 1
    
    var dataArray:[Data] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addDataAfter(10)
        
        self.refreshControl.addTarget(self, action: "callbackRefreshControl", forControlEvents: UIControlEvents.ValueChanged)
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self
        self.tableView.addSubview(self.refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return 3
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case DETA_SECTION:return self.dataArray.count
            case FOTTER_SECTION:return 1
            default:return 0
        }
  
    }

    //UITableViewDataSource
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        switch indexPath.section {
        case DETA_SECTION:
            let cell = tableView.dequeueReusableCellWithIdentifier("dataCell", forIndexPath: indexPath) as DataCell
            
            let data = self.dataArray[indexPath.row]
            cell.setCaption("Dataセル セクション:\(data.index)  \(data.caption)")
            
            return cell
        case FOTTER_SECTION:
            let cell = tableView.dequeueReusableCellWithIdentifier("fotterCell", forIndexPath: indexPath) as UITableViewCell
            return cell
        default:return UITableViewCell()
        }

    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 40
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView!, willDisplayCell cell: UITableViewCell!, forRowAtIndexPath indexPath: NSIndexPath!) {

        if indexPath.section == FOTTER_SECTION {
            addDataAfter(2)
            self.tableView.reloadData()
        }
    }

    private func addDataAfter(count:Int) {
        for i in 0..<count {
            let last:Data? = self.dataArray.last
            let baseIndex = last == nil ? -1 : last!.index
            
            let newIndex = baseIndex + 1
            let newData = Data(index: newIndex,caption: "\(newIndex)行目")
            self.dataArray.append(newData)
        }
    }
    
    private func addDataBefore(count:Int) {
        for i in 0..<count {
            let first:Data = self.dataArray.first!
            let baseIndex = first.index
            
            let newIndex = baseIndex - 1
            let newData = Data(index: newIndex,caption: "\(newIndex)行目")
            self.dataArray.insert(newData, atIndex: 0)
        }
    }
    
    //UIRefreshControl
    func callbackRefreshControl(){
        addDataBefore(2)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    @IBAction func tapDebug(sender: AnyObject) {
        println("============")
        for data in dataArray {
            println("\(dataArray.count)/\(data.index)")
        }
        println("============")
    }
    


}

