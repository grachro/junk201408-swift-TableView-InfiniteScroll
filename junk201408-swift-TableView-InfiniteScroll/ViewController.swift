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
                            
    let HEADER_SECTION = 0
    let DETA_SECTION = 1
    let FOTTER_SECTION = 2
    
    var dataArray:[Data] = []
    
    var headerReview = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addDataAfter(5)
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self
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
            case HEADER_SECTION:return 1
            case DETA_SECTION:return self.dataArray.count
            case FOTTER_SECTION:return 1
            default:return 0
        }
  
    }
    
    
    //UITableViewDataSource
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        switch indexPath.section {
        case HEADER_SECTION:
            let cell = tableView.dequeueReusableCellWithIdentifier("headerCell", forIndexPath: indexPath) as UITableViewCell
            return cell
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
        //println("セクション:\(indexPath.section) \(dataArray.count)行中\(indexPath.row + 1)行目")
        
        if indexPath.section == HEADER_SECTION {
            if headerReview {
                addDataBefore(2)
                self.tableView.reloadData()
            }
            
            
            headerReview = !headerReview
        }else  if indexPath.section == FOTTER_SECTION {
            addDataAfter(2)
            self.tableView.reloadData()
        }
    }
    
 
    
    private func addDataAfter(count:Int) {
        for i in 0..<count {
            let last:Data? = self.dataArray.last
            let baseIndex = last == nil ? 0 : last!.index
            
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
    
    @IBAction func tapDebug(sender: AnyObject) {
        println("============")
        for data in dataArray {
            println("\(dataArray.count)/\(data.index)")
        }
        println("============")
    }
    
}

