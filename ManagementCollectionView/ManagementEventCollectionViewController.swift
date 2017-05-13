//
//  ManagementEventCollectionViewController.swift
//  ManagementCollectionView
//
//  Created by Cntt20 on 5/13/17.
//  Copyright © 2017 Dau Khac Bac. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ManagementEventCollectionViewController: UICollectionViewController {
    
    //
    @IBOutlet var MyCollectionView: UICollectionView!
    
    //
    lazy var eventLines: [EventLine] = {
        return EventLine.eventLines()
    }()
    //

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return eventLines.count
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        let eventLine = eventLines[section]
        return eventLine.events.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Event Cell", for: indexPath) as! EventCollectionViewCell
        
        let eventLine = eventLines[indexPath.section]
        let event = eventLine.events[indexPath.row]
        
        cell.configCellWith(event: event)
        return cell
    }
    
    //
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "Reusable View", for: indexPath) as! ManagementCollectionReusableView
        
        let eventLine = eventLines[indexPath.section]
        
        headerView.dayOfWeeks.text = eventLine.dates
        
        return headerView
    }
    //
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Xoá event
        let questionController = UIAlertController(title: "Option!!!", message: nil, preferredStyle: .alert)
        questionController.addAction(UIAlertAction(title: "Delete Event", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            print("Delete")
            let eventLine = self.eventLines[indexPath.section]
            eventLine.events.remove(at: indexPath.row)
            self.MyCollectionView.deleteItems(at: [indexPath])
        }))
        // Thông tin chi tiết event
        questionController.addAction(UIAlertAction(title: "Event Detail", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            print("Event Detail")
            let eventLine = self.eventLines[indexPath.section]
            let event = eventLine.events[indexPath.row]
            let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Show Detail") as! ViewDetailAndEditViewController
            detailVC.day = eventLine.dates
            detailVC.event = event
            self.navigationController?.pushViewController(detailVC, animated: true)
        }))
        //Reload
        questionController.addAction(UIAlertAction(title: "Reload", style: .default, handler: {
            (action:UIAlertAction!) -> Void in
            print("Reload")
            self.MyCollectionView.reloadData()
        }))
        
        present(questionController, animated: true, completion: nil)
    }
    //
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Detail" {
            //
            //let indexPath = collectionView?.indexPathsForVisibleItems
            let cell = sender as! UICollectionViewCell
            let indexPath = self.collectionView!.indexPath(for: cell)
            let indexPatht = self.collectionView?.indexPath(for: sender as! UICollectionViewCell)
            var event: Event
            var eventLine: EventLine
            //event = eventLines[(indexPath?.row)!]
            let editVC = segue.destination as! ViewDetailAndEditViewController
            editVC.event = event
            editVC.day = eventLine.dates
            editVC.navigationItem.leftItemsSupplementBackButton = true
            //
        }
        }
        /*
        if segue.identifier == "Add Student" {
            let addVC = segue.destination as! AddStudentViewController
            addVC.studentList = studentList
            tableView.reloadData()
        }
 */
 */
}

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
 

    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
 
    }
 */

