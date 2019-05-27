import UIKit
import RealmSwift

class NotesViewController: UITableViewController {
    
    let realm = (UIApplication.shared.delegate as! AppDelegate).realm
    
    var notes: Results<Note>?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.uiSearchBar.delegate = self
        
        load()
    }
    
    @IBOutlet weak var uiSearchBar: UISearchBar!
 
    
    //MARK: - ADD NEW NOTE
    
    @IBAction func addNotePressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alertController = UIAlertController(title: "Add item", message: " ", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            if textField.text != "" {
                let note = Note()
                note.title = textField.text!
                self.save(noteToSave: note)
                self.load()
                
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alertController.addAction(cancelAction)
        alertController.addAction(action)
        
        alertController.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    //MARK: - TableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (notes?.count) ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        cell.textLabel?.text = notes?[indexPath.row].title ?? "No notes added yet"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToNote", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ShowNoteViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedNote = notes?[indexPath.row]
            print(destinationVC.selectedNote)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            if let note = notes?[indexPath.row] {
                delete(noteToDelete: note)
            }
        }
    }
    
    
    
    //MARK: - MANAGE DATA WITH REALM
    
    func save(noteToSave: Note){
        
        do{
            try  realm.write {
                realm.add(noteToSave)
            }
        }
        catch let error {
            print("Error: \(error)")
        }
    }
    
    
    func delete(noteToDelete: Note){
        do{
            try realm.write{
                realm.delete(noteToDelete)
                load()
            }
        }
        catch let error {
            print("Error: \(error)")
        }
    }
    
    
    
    func load() {
        notes = realm.objects(Note.self)
        tableView.reloadData()
    }
    
    
    
    
}
    


extension NotesViewController: UISearchBarDelegate {
    
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        notes = notes?.filter("title CONTAINS[cd] %@", searchBar.text!)
        tableView.reloadData()
        
    }
//
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            print("zero")

            load()

            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }


        }
    }
}
