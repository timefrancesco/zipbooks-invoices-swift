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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "genericCell")

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    func populateSource(value:[String]){
        source = value
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("genericCell", forIndexPath: indexPath) 
        cell.textLabel?.text = source[indexPath.item]
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