//
//  MainSplitViewController.swift
//  MasterDetailView
//
//  Created by mis on 24.05.21.
//

import Cocoa

internal class MasterDetailViewController: NSViewController {

    //  class variables
    //  view variables
    @IBOutlet weak var splitView: NSSplitView!
    @IBOutlet weak var navigationView: NSView!
    @IBOutlet weak var contentView: NSView!
    @IBOutlet weak var navigationTableView: NSTableView!
    
    //  list of navigation items
    private var navigationItems: [NavigationItem] = []
    
    //  shows the selected view in content (detail) view
    private func addContentView(asChildViewController withStoryboardID: String) {
            
        //  remove the previously view controller
        let subviews = self.contentView.subviews
        if subviews.count > 0 {
            
            for subview in subviews {
            
                subview.removeFromSuperview()
                
            }
            
        }
        
        //  create the viewcontroller form classname
        if let subViewController = NSStoryboard(name: "Content", bundle: nil).instantiateController(withIdentifier: withStoryboardID) as? NSViewController {
            
            //  position of subview in center of contentview
            //  from: https://stackoverflow.com/questions/4681176/how-to-align-a-subview-to-the-center-of-a-parent-nsview
            let subViewWidth = subViewController.view.frame.width
            let subViewHeight = subViewController.view.frame.height
            let x = (self.contentView.bounds.width - subViewWidth) * 0.5
            let y = (self.contentView.bounds.height - subViewHeight) * 0.5
            let subViewRect = CGRect(x: x, y: y, width: subViewWidth, height: subViewHeight)
            subViewController.view.frame = subViewRect
            subViewController.view.autoresizingMask = [.minXMargin, .maxXMargin, .minYMargin, .maxYMargin]
            self.contentView.addSubview(subViewController.view)
            
        }
        
    }
    

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //  size of view
        self.view.setFrameSize(NSSize(width: Global.AppSettings.viewWidth, height: Global.AppSettings.viewHeight))
        
        //  load navigation items from json
        do {
            
            self.navigationItems = try NavigationItemsLoader.loadNavigationItems()
            
        } catch (let error) {
            
            //  log in view
            print(error.localizedDescription)
            
        }
        
        self.splitView.setPosition(250, ofDividerAt: 0)
        
        //  splitview delegate
        self.splitView.delegate = self
        
        //  navigations table: datasource and delegate
        self.navigationTableView.dataSource = self
        self.navigationTableView.delegate = self
        
        //  register the custom tableviewcell
        self.navigationTableView.register(NSNib(nibNamed: "NavigationTableCellView", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NavigationTableCellView"))
        
    }
    
}

extension MasterDetailViewController: NSSplitViewDelegate {
    
    
}

extension MasterDetailViewController: NSTableViewDataSource, NSTableViewDelegate {
    
    //  number of table rows
    func numberOfRows(in tableView: NSTableView) -> Int {
        
        return navigationItems.count
    }
    
    //  height of table row
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        
        return Global.AppSettings.defaultTableRowHeight
        
    }
    
    //  custom table cell view
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        if tableColumn?.identifier.rawValue == "NavigationTableCellView" {
            
            let tableViewCell: NavigationTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("NavigationTableCellView"),
                                                                            owner: self) as! NavigationTableCellView
            if row < self.navigationItems.count {
                
                let navigationItem = self.navigationItems[row]
                tableViewCell.titleLabel.stringValue = navigationItem.title
                
            }

            return tableViewCell
        }

        return NSView()
    }
    
    //  user select a row in table (navigation item)
    func tableViewSelectionDidChange(_ notification: Notification) {
        
        let row = self.navigationTableView.selectedRow
        if row > -1 {
        
            if row < self.navigationItems.count {
                
                let navigationItem = self.navigationItems[row]
                self.addContentView(asChildViewController: navigationItem.storyboardID)
                
            }
            
        }
        
    }
    
}
