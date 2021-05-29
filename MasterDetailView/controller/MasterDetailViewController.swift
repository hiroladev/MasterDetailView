/*

MasterDetailViewController.swift
MasterDetailView
 
MIT License

Copyright (c) 2021 Michael Schmidt

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 */

import Cocoa

internal class MasterDetailViewController: NSViewController {

    //  class variables
    //  view variables
    @IBOutlet weak var contentView: NSView!
    //  table view
    @IBOutlet weak var navigationTableView: NSTableView!
    //  label
    @IBOutlet weak var appLogLabel: NSTextField!
    
    //  log messages
    private var logMessages: [String] = []
    private var logMessageIndex: Int = -1
    
    //  app delegate
    private var app = NSApplication.shared.delegate as! AppDelegate
    
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
            
            //  add the subview
            let detailView = subViewController.view
            detailView.frame.size.width = self.contentView.frame.size.width
            detailView.frame.size.height = self.contentView.frame.size.height

            self.contentView.addSubview(detailView)
            
        }
        
    }
    
    //  misc views initializes
    private func initializeView() {
        
        //  size of view
        self.view.setFrameSize(NSSize(width: Global.AppSettings.viewWidth, height: Global.AppSettings.viewHeight))
        
        //  load navigation items from json
        do {
            
            self.navigationItems = try NavigationItemsLoader.loadNavigationItems()
            
        } catch (let error) {
            
            //  log in view
            self.logMessages.append(error.localizedDescription)
            self.appLogLabel.stringValue = error.localizedDescription
            
        }
        
        //  navigations table: datasource and delegate
        self.navigationTableView.dataSource = self
        self.navigationTableView.delegate = self
        
        //  register the custom tableviewcell
        self.navigationTableView.register(NSNib(nibNamed: "NavigationTableCellView", bundle: nil), forIdentifier: NSUserInterfaceItemIdentifier(rawValue: "NavigationTableCellView"))
        
        
    }
    
    //  app logs
    private func addAppLogEntry(_ entry: String) {
        
        self.logMessages.append(entry)
        self.logMessageIndex += 1
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //  misc initialize
        self.initializeView()
        
    }
    
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
                
                self.appLogLabel.stringValue = "Select ... ".appending(navigationItem.title)
                
            }
            
        }
        
    }
    
}
