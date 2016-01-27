//
//  GenericListViewController.swift
//  zipbooks-ios
//
//  Created by Francesco Pretelli on 20/01/16.
//  Copyright © 2016 Francesco Pretelli. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class GenericListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

    @IBOutlet weak var listTableView: UITableView!
    var source = [String]()
    var listSelectedDelegate: GenericTableSelectionDelegate?
    var insertType:InsertType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "genericCell")
        listTableView.tableFooterView = UIView()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func populateSource(value:[String]){
        source = value
    }
    
    func setViewTitle(val:String){
        title = val
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "InsertSegue" {
            if let destination = segue.destinationViewController as? UINavigationController {
                let insVC = destination.viewControllers[0] as! InsertViewController
                insVC.insertType = insertType
            }
        }
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("genericCell", forIndexPath: indexPath) 
        cell.textLabel?.text = source[indexPath.item]
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        cell.textLabel?.textColor = Utility.getDefaultGrayColor()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        listSelectedDelegate?.selectedRow(indexPath.row, value:source[indexPath.row])
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        navigationController?.popViewControllerAnimated(true)
    }    
}