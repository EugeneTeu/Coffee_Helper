//
//  notesViewController.swift
//  notes
//
//  Created by Eugene Teu Chu Wei on 22/3/19.
//  Copyright © 2019 Eugene Teu Chu Wei. All rights reserved.
//

import UIKit

protocol NoteViewDelegate {
    func didUpdateNoteWithTitle(newTitle : String, andBody newBody : String)
    
}
class notesViewController: UIViewController, UITextViewDelegate {
    var delegate : NoteViewDelegate?
    var strBodyText : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.txtbody.text = self.strBodyText
        
        self.txtbody.becomeFirstResponder()
        
        self.txtbody.delegate = self
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so we give it
        //the exact RGB values
        self.btnDoneEditing.tintColor = UIColor(red: 0, green:
            122.0/255.0, blue: 1, alpha: 1)
    }

    
    @IBOutlet weak var btnDoneEditing: UIBarButtonItem!
    
    @IBAction func doneEditingBody() {
        
        self.txtbody.resignFirstResponder()
        
        self.btnDoneEditing.tintColor = UIColor.clear
        
        //tell the main view controller that we're going to update the
        //selected item
        //but only if the delegate is NOT nil
        if self.delegate != nil {
            
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.txtbody.text)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.txtbody.text)
        }
    }

    
    @IBOutlet weak var txtbody : UITextView!
    
    func textViewDidChange(_ textView: UITextView) {
        //separate the body into multiple sections
        let components = self.txtbody.text.components(separatedBy: "\n")
            //reset the title to blank (in case there are no componentswith valid text)
        self.navigationItem.title = ""
        //loop through each item in the components array (each item is  auto-detected as a String)
        for item in components {
            //if the number of letters in the item (AFTER getting rid of extra white space) is greater than 0...
            if item.trimmingCharacters(in: .whitespacesAndNewlines).characters.count > 0 {
            //then set the title to the item itself, and break out ofthe for loop
                self.navigationItem.title = item
                break
                
            }
        } }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
