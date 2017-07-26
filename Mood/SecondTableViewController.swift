//
//  SecondTableViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/25.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

private extension Selector {
    static let loadData = #selector(SecondTableViewController.loadData)
}

class SecondTableViewController: UITableViewController{
    
    //MARK: Properties
    
    var records = [Record]()
    
    //MARK: Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControl!.addTarget(self, action: .loadData, for: .valueChanged)
        
        self.loadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMoodTableViewCell", for: indexPath) as! HistoryMoodTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        cell.timeLabel.text = dateFormatter.string(from: records[indexPath.row].createdAt)
        cell.sentenceLabel.text = records[indexPath.row].sentence
        
        var image: UIImage
        
        switch records[indexPath.row].moodScore {
        case 0:
            image = UIImage(named: "想哭")!
        case 1:
            image = UIImage(named: "悲伤")!
        case 2:
            image = UIImage(named: "难过")!
        case 3:
            image = UIImage(named: "一般")!
        case 4:
            image = UIImage(named: "愉快")!
        case 5:
            image = UIImage(named: "开心")!
        default:
            image = UIImage()
        }
        
        cell.imageView!.image = image
        
        return cell
    }
    
    //MARK: Methods
    
    func loadData() {
        self.records = Record.getAllRecords()
        self.tableView.reloadData()
        self.refreshControl!.endRefreshing()
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let moodDetailViewController = segue.destination as! MoodDetailViewController
        let cell = self.tableView.cellForRow(at: self.tableView.indexPathForSelectedRow!) as! HistoryMoodTableViewCell
        moodDetailViewController.text = cell.sentenceLabel.text!
    }
}
