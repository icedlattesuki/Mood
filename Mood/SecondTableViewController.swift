//
//  SecondTableViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/25.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var records = [Record]()
    
    //MARK: Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        records = Record.getAllRecords()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMoodTableViewCell", for: indexPath) as! HistoryMoodTableViewCell
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd"
        cell.timeLabel.text = dateFormatter.string(from: records[indexPath.row].createdAt)
        print(cell.timeLabel.text!)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
