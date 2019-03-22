//
//  ViewController.swift
//  notes
//
//  Created by Eugene Teu Chu Wei on 22/3/19.
//  Copyright © 2019 Eugene Teu Chu Wei. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController , NoteViewDelegate{
    
  
    var arrNotes = [[String:String]]()
    
    var selectedIndex = -1;
    
    var strBodytext : String!
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let newNotes = UserDefaults.standard.array(forKey: "notes")   as? [[String:String]] {
            //set the instance variable to the newNotes variable
            arrNotes = newNotes
        }
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the desired # of elements. In this case, 5
        return arrNotes.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")
        cell!.textLabel!.text = arrNotes[indexPath.row]["title"]
        
        return cell!;
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        performSegue(withIdentifier: "GO", sender: nil)
        

    }
    
    @IBAction func newNote(_ sender: Any) {
        
        let newDict = ["title" : "", "body" : ""]
        
        arrNotes.insert(newDict, at: 0)
        self.selectedIndex = 0
        self.tableView.reloadData()
        
        performSegue(withIdentifier: "GO", sender: nil)
        
        saveNotesArray()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let notesEditorVC = segue.destination as! notesViewController
        
        notesEditorVC.navigationItem.title = arrNotes[self.selectedIndex]["title"]
        
        notesEditorVC.strBodyText = arrNotes[self.selectedIndex]["body"]
        notesEditorVC.delegate = self as? NoteViewDelegate
        
    }
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody:
        String) {
        //update the respective values
        self.arrNotes[self.selectedIndex]["title"] = newTitle
        self.arrNotes[self.selectedIndex]["body"] = newBody
        //refresh the view
        self.tableView.reloadData()
        saveNotesArray()
        
    }
    
    func saveNotesArray() {
        //save the newly updated array
        UserDefaults.standard.set(arrNotes,forKey: "notes")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
}

