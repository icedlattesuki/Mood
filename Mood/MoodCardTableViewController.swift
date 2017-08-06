//
//  MoodCardTableViewController.swift
//  Mood
//
//  Created by Hys on 2017/7/25.
//  Copyright © 2017年 Hys. All rights reserved.
//

import UIKit
import Material
import SCLAlertView

class MoodCardTableViewController: UITableViewController{
    
    //MARK: Properties
    
    var records = [Record]()
    //记录各个cell对应的高度，便于tableview的调整
    var heights = [IndexPath: CGFloat]()
    //是否显示最近7天数据(随设置变动)
    var showLatestData = false
    //是否按时间升序排列(随设置变动)
    var timeSort = false
    //显示的记录数量(根据设置变动)
    var numOfToShowRecords = 0
    
    //MARK: Override functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加刷新功能
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "下拉刷新")
        self.refreshControl!.addTarget(self, action: .loadData, for: .valueChanged)

        //载入数据
        self.loadData()
    }

    // MARK: Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //根据设置更新需要显示的记录数量
        self.numOfToShowRecords = showLatestData && records.count > 7 ? 7 : records.count
        
        return self.numOfToShowRecords
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryMoodTableViewCell", for: indexPath) as! MoodCardTableViewCell
        
        //将多余的子视图从cell的customview中移除(这是由于IOS会复用cell，以减少内存的消耗，而之前的cell中已经存在很多子视图，因此需要先移除)
        for view in cell.customView.subviews {
            view.removeFromSuperview()
        }
        
        //设置card
        let card = self.setupcard(indexPath: indexPath)
        //将card放置在合适的位置
        cell.customView.layout(card).horizontally(left: 8, right: 8).top(30)
        //记录cell的高度
        self.heights[indexPath] = CGFloat(cell.height)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.heights[indexPath] ?? 210
    }
    
    //MARK: Public Methods
    
    func loadData() {
        //获取所有记录
        self.records = Record.getAllRecords()
        
        //更新设置
        if let setting = Setting.getSetting() {
            self.showLatestData = setting.0
            self.timeSort = setting.1
        }
        
        //更新tableview
        self.tableView.reloadData()
        
        //更新title
        self.title = "心情卡片(\(numOfToShowRecords))"

        //结束刷新
        self.refreshControl!.endRefreshing()
    }
    
    func deleteRecord(_ sender: UIButton) {
        let index = sender.tag
        let row = self.timeSort ? index - self.records.count + self.numOfToShowRecords : self.records.count - 1 - index
        
        //删除远程数据库中的记录
        if self.records[index].remove().success {
            let indexPath = IndexPath(row: row, section: 0)
            
            //删除records数组中的记录(该操作必须在deleteRows之前，否则程序会崩溃)
            self.records.remove(at: index)
            
            //删除tableview中的记录
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            
            //更新title
            self.title = "心情卡片(\(numOfToShowRecords))"
        }
    }
    
    //MARK: Private Methods
    
    private func setupcard(indexPath: IndexPath) -> Card {
        let card = Card()
        let index = self.timeSort ? self.records.count - self.numOfToShowRecords + indexPath.row : self.records.count - 1 - indexPath.row
        let record = self.records[index]
        let toolbar = Toolbar()
        
        //设置toolbar的标题和子标题
        toolbar.title = "Mood"
        toolbar.titleLabel.textAlignment = .left
        toolbar.detail = "记录•心情"
        toolbar.detailLabel.textAlignment = .left
        toolbar.detailLabel.textColor = Color.blueGrey.base
        
        //设置toolbar上的button
        let button = UIButton()
        
        button.setImage(setupImage(record), for: .normal)
        toolbar.rightViews = [button]
        
        //设置contentview
        let contentView = UILabel()
        
        contentView.numberOfLines = 0
        contentView.text = record.sentence
        contentView.font = RobotoFont.regular(with: 14)
        
        //设置bottombar
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
        
        //构造card
        card.toolbar = toolbar
        card.contentView = contentView
        card.bottomBar = bottombar
        
        //设置card的外观
        card.toolbarEdgeInsetsPreset = .wideRectangle2
        card.contentViewEdgeInsetsPreset = .wideRectangle2
        card.contentViewEdgeInsets.left = 12
        card.bottomBarEdgeInsetsPreset = .wideRectangle2
        card.bottomBarEdgeInsets.right = 13
        card.borderWidth = 0.1
        
        return card
    }
    
    private func setupImage(_ record: Record) -> UIImage {
        var image: UIImage
        
        switch record.moodScore {
        case 5:
            image = UIImage(named: "开心")!
        case 4:
            image = UIImage(named: "愉快")!
        case 3:
            image = UIImage(named: "一般")!
        case 2:
            image = UIImage(named: "难过")!
        case 1:
            image = UIImage(named: "悲伤")!
        case 0:
            image = UIImage(named: "想哭")!
        default:
            image = UIImage()
        }
        
        return image
    }
    
    //MARK: Actions
    
    @IBAction func addMood(_ sender: UIBarButtonItem) {
//        判断今日是否已经记录
        if Record.isAdded() {
            let alert = SCLAlertView()
            alert.showWarning("今天已经记录过啦!", subTitle: "")
        } else {
            performSegue(withIdentifier: "addMood", sender: nil)
        }
    }
}

private extension Selector {
    static let loadData = #selector(MoodCardTableViewController.loadData)
    static let deleteRecord = #selector(MoodCardTableViewController.deleteRecord(_:))
}

