//
//  ViewController.swift
//  ConvertNumber
//
//  Created by Vien Vu on 9/28/18.
//  Copyright © 2018 Vien Vu. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    
    var contacsts = [CNContact]()
    var viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let contactStore = CNContactStore()
        contactStore.requestAccess(for: CNEntityType.contacts) { (allow, error) in
            if let error = error {
                print(error)
            }
        }
        loadConctact()
        showInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadConctact() {
        let keys = [CNContactPhoneNumbersKey, CNContactFormatter.descriptorForRequiredKeys(for: .phoneticFullName)] as! [CNKeyDescriptor]
        let request = CNContactFetchRequest(keysToFetch: keys)
        let contactStore = CNContactStore()
        do {
            try contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                self.contacsts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
    }

    func showInfo() {
        print("I have \(contacsts.count) contacts")
        tableView.reloadData()
    }
    
    
    @IBAction func convertIsTapped(_ sender: Any) {
        contacsts.enumerated().forEach { (i, contact) in
            let contact = updatePhoneNumber(contact: contact)
            self.updateContact(contact: contact)
        }
    }
    
    func updatePhoneNumber(contact: CNContact) -> CNMutableContact {
        let mutableContact = contact.mutableCopy() as! CNMutableContact
        let arrayPhone = contact.phoneNumbers.map { phoneNumber -> CNLabeledValue<CNPhoneNumber> in
            let phone = CNLabeledValue(label: phoneNumber.label ?? CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: self.viewModel.converNumber(number: phoneNumber.value.stringValue)))
            
            return phone
        }
        mutableContact.phoneNumbers = arrayPhone
        
        return mutableContact
    }
    
    func updateContact(contact: CNMutableContact) {
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.update(contact)
        try! store.execute(saveRequest)
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contacsts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let contact = self.contacsts[indexPath.row]
        cell.textLabel?.text  = contact.familyName + " " + contact.givenName
        
        var numbers = ""
        contact.phoneNumbers.enumerated().forEach { (arg) in
            let (_, number) = arg
            numbers += " " +  number.value.stringValue
        }
        cell.detailTextLabel?.text = numbers
        
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("fuck you la")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

