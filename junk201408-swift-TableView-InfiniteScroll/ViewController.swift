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
    
    var dataArray:[Data] = [] //モデルのリスト
    let INIT_DATA_COUNT = 10 //初期表示データ
    let ADD_DATA_COUNT = 5 ///最後尾が表示された時に追加するデータ数
    let REFLESH_DATA_COUNT = 3 ///引っ張られた時に上に追加するデータ数
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDataAfter(INIT_DATA_COUNT)
        
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
        return 2
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
            
            let data = self.dataArray[indexPath.row]
            
            
            if data.index % 2 == 0 {
                let cell = tableView.dequeueReusableCellWithIdentifier("dataCellA", forIndexPath: indexPath) as DataCellA
                cell.setCaption("a Dataセル セクション:\(data.index)  \(data.caption)")
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCellWithIdentifier("dataCellB", forIndexPath: indexPath) as DataCellB
                cell.setCaption("b Dataセル セクション:\(data.index)  \(data.caption)")
                
                return cell
            }
            

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

        //2つ目のセクションが表示されたら、モデルにデータ追加
        if indexPath.section == FOTTER_SECTION {
            addDataAfter(ADD_DATA_COUNT)
            self.tableView.reloadData()
        }
    }

    //モデル操作
    private func addDataAfter(count:Int) {
        for i in 0..<count {
            let last:Data? = self.dataArray.last
            let baseIndex = last == nil ? -1 : last!.index
            
            let newIndex = baseIndex + 1
            let newData = Data(index: newIndex,caption: "\(newIndex)行目")
            self.dataArray.append(newData)
        }
    }
    
    //UIRefreshControl
    func callbackRefreshControl(){
        addDataBefore(REFLESH_DATA_COUNT)
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    //モデル操作
    private func addDataBefore(count:Int) {
        for i in 0..<count {
            let first:Data = self.dataArray.first!
            let baseIndex = first.index
            
            let newIndex = baseIndex - 1
            let newData = Data(index: newIndex,caption: "\(newIndex)行目")
            self.dataArray.insert(newData, atIndex: 0)
        }
    }

    //モデルのデバッグ表示
    @IBAction func tapDebug(sender: AnyObject) {
        println("============")
        for data in dataArray {
            println("\(dataArray.count)/\(data.index)")
        }
        println("============")
    }
    


}

