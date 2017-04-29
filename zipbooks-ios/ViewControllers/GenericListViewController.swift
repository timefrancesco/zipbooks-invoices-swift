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
        listTableView.register(UITableViewCell.self, forCellReuseIdentifier: "genericCell")
        listTableView.tableFooterView = UIView()
        
        navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : UIFont(name: "HelveticaNeue", size: 18)!, NSForegroundColorAttributeName : UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func populateSource(_ value:[String]){
        source = value
    }
    
    func setViewTitle(_ val:String){
        title = val
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InsertSegue" {
            if let destination = segue.destination as? UINavigationController {
                let insVC = destination.viewControllers[0] as! InsertViewController
                insVC.insertType = insertType
            }
        }
    }
    
    //MARK: TableView Delegate Functions
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "genericCell", for: indexPath) 
        cell.textLabel?.text = source[indexPath.item]
        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 15)
        cell.textLabel?.textColor = Utility.getDefaultGrayColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return source.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        listSelectedDelegate?.selectedRow(indexPath.row, value:source[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.popViewController(animated: true)
    }    
}
