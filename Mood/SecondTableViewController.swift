//
//  SecondTableViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/25.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import SCLAlertView

class SecondTableViewController: UITableViewController{
    
    //MARK: Properties
    
    var records = [Record]()
    var heights = [IndexPath: CGFloat]()
    var showLatestData = false
    var timeSort = false
    var numOfToShowRecords = 0
    
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
        numOfToShowRecords = showLatestData && records.count > 7 ? 7 : records.count
        return numOfToShowRecords
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMoodTableViewCell", for: indexPath) as! HistoryMoodTableViewCell
        let card = Card()
        
        for view in cell.customView.subviews {
            view.removeFromSuperview()
        }
        
        self.setupcard(card: card, indexPath: indexPath)
        cell.customView.layout(card).horizontally(left: 8, right: 8).top(30)
        heights[indexPath] = CGFloat(cell.height)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heights[indexPath] ?? 210
    }
    
    //MARK: Methods
    
    func loadData() {
        self.records = Record.getAllRecords()
        
        //更新设置
        if let setting = Setting.getSetting() {
            showLatestData = setting.0
            timeSort = setting.1
        }
        
        self.tableView.reloadData()
        
        self.title = "心情卡片(\(numOfToShowRecords))"

        self.refreshControl!.endRefreshing()
    }
    
    func deleteRecord(_ sender: UIButton) {
        let index = sender.tag
        let row = timeSort ? index - records.count + numOfToShowRecords : records.count - 1 - index
        
        if records[index].remove().success {
            let indexPath = IndexPath(row: row, section: 0)
            
            records.remove(at: index)
            
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            self.title = "心情卡片(\(numOfToShowRecords))"
        }
    }
    
    private func setupcard(card: Card, indexPath: IndexPath) {
        let index = timeSort ? records.count - numOfToShowRecords + indexPath.row : records.count - 1 - indexPath.row
        let record = records[index]
        
        let toolbar = Toolbar()
        
        toolbar.title = "Mood"
        toolbar.titleLabel.textAlignment = .left
        
        toolbar.detail = "记录•心情"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.blueGrey.base
        
        let button = UIButton()
        button.setImage(setupImage(record), for: .normal)
        
        toolbar.rightViews = [button]
        
        card.toolbar = toolbar
        
        let contentView = UILabel()
        
        contentView.numberOfLines = 0
        contentView.text = record.sentence
        contentView.font = RobotoFont.regular(with: 14)
        
        card.contentView = contentView
        
        let bottombar = Bar()
        let dateLabel = UILabel()
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        dateLabel.textColor = Color.blueGrey.base
        dateLabel.font = RobotoFont.regular(with: 12)
        dateLabel.text = dateFormatter.string(from: record.createdAt)
        
        bottombar.leftViews = [dateLabel]
        
        let deleteButton = UIButton()
        
        deleteButton.setImage(UIImage(named: "删除") , for: .normal)
        deleteButton.addTarget(self, action: .deleteRecord, for: .touchUpInside)
        deleteButton.tag = index
        
        bottombar.rightViews = [deleteButton]
        
        card.bottomBar = bottombar
        
        card.toolbarEdgeInsetsPreset = .wideRectangle2
        card.contentViewEdgeInsetsPreset = .wideRectangle2
        card.contentViewEdgeInsets.left = 12
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        card.bottomBarEdgeInsets.right = 8
        
        card.borderWidth = 0.1
    }
    
    private func setupImage(_ record: Record) -> UIImage {
        var image: UIImage
        
        switch record.moodScore {
        case 5:
            image = UIImage(named: "开心1")!
        case 4:
            image = UIImage(named: "愉快1")!
        case 3:
            image = UIImage(named: "一般1")!
        case 2:
            image = UIImage(named: "难过1")!
        case 1:
            image = UIImage(named: "悲伤1")!
        case 0:
            image = UIImage(named: "想哭1")!
        default:
            image = UIImage()
        }
        
        return image
    }
    
    //MARK: Actions
    
    @IBAction func addMood(_ sender: UIBarButtonItem) {
        if Record.isAdded() {
            let alert = SCLAlertView()
            alert.showWarning("今天已经记录过啦!", subTitle: "")
        } else {
            performSegue(withIdentifier: "addMood", sender: nil)
        }
    }
}

private extension Selector {
    static let loadData = #selector(SecondTableViewController.loadData)
    static let deleteRecord = #selector(SecondTableViewController.deleteRecord(_:))
}

