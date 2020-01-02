//
//  ViewController.swift
//  tavleview
//
//  Created by A RAJU on 12/23/19.
//  Copyright © 2019 A RAJU. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var tabelview:UITableView!

  //  var array:[String] = ["A RAJU","A RAJU","A RAJU","A RAJU","A RAJU","A RAJU"]
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
           var managedObject:NSManagedObjectContext!
           var appDelegate:AppDelegate!
           var perosonDetailsEntity:NSEntityDescription!

//        var buttonTApped:Int!
//        var buttonTAppedForDElete:Int!


        var images = [UIImage]()
        

        var delete = [UIButton]()
    
        

        var name1 = [String]()
        var age = [Int64]()
        var email = [String]()
        var imagview:UIImageView!
        var imagesapend = [UIImageView]()
        var data = [String]()
        var studntDtls = [UIButton]()
    
        override func viewDidLoad() {
        
        super.viewDidLoad()
    
        coreDataCreate()
       tableview()
    }
    func tableview()
    {
        
        tabelview = UITableView(frame: view.frame, style: UITableView.Style.grouped)
       // tabelview.heightAnchor.constraint(equalToConstant: 80).isActive =  true
       // tabelview.widthAnchor.constraint(equalToConstant: 80).isActive = true
            tabelview.delegate = self
          tabelview.dataSource = self

        view.addSubview(tabelview)

    }
   
        
            func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                
                return name1.count
    }
            
            func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
                
                let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "A RAJU")
                    
               // cell.textLabel!.text = "\(indexPath.row).\(images[indexPath.row])"
            
                cell.textLabel!.text = data[indexPath.row]
                
                    //+ "\n" + email[indexPath.row] + "\n" + "\(age[indexPath.row])"
                cell.widthAnchor.constraint(equalToConstant: 80).isActive =  true
                cell.heightAnchor.constraint(equalToConstant: 80).isActive = true
                cell.imageView!.image = images[indexPath.row]
                cell.textLabel!.numberOfLines = 0
                
                print(cell)
                
                return cell
            }
            
            func coreDataCreate(){

               appDelegate = (UIApplication.shared.delegate as! AppDelegate)

               managedObject = appDelegate.persistentContainer.viewContext

               perosonDetailsEntity = NSEntityDescription.entity(forEntityName: "PersonDetails", in: managedObject)
            
     }
    // creating the add button
        
         @IBAction func addButton(_ sender: Any) {

                      for i in studntDtls{

                           i.removeFromSuperview()
                       }
                       for i in delete{

                           i.removeFromSuperview()
                       }

        
                let target = storyboard?.instantiateViewController(identifier: "fv") as! FirstViewController

                       navigationController?.pushViewController(target, animated: true)
            
            }
        

    // displaying the data
            override func viewWillAppear(_ animated: Bool) {



                let fetchingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonDetails")

                do{

                    let fetchManagedObject = try managedObject.fetch(fetchingRequest)

                    var text:String!

                    for i in 0..<fetchManagedObject.count
                    {

                        let currentMO = fetchManagedObject[i] as! NSManagedObject

                        let name = (currentMO.value(forKey: "name") as? String) ?? ""
                        print(name)
                        name1.append(name)
                        text = name

                        let aged = currentMO.value(forKey: "age") as? Int64 ?? 0
                        //print(aged)
                        age.append(aged)

                        text += "\n" + "\(aged)"

                        let emails = currentMO.value(forKey: "email") as? String ?? ""
                        //print(emails)
                         text += "\n" + emails

                        email.append(emails)

                        let defImage = UIImage(named: "defaultProfile")
                        let imagedata = defImage?.pngData() as! NSData
                        let imaged = currentMO.value(forKey: "imageData") as? NSData ?? imagedata

                        let uiImage = UIImage(data: ((imaged  as Data?)!))

                        if let c = uiImage
                        {
                            images.append(c)
                        }
                        data.append(text)
                        
                        
//                        // creating the image view
////
////                           let imagevw = UIImageView()
////                            imagevw.frame  = CGRect(x: 0, y: 0, width: 80, height: 80)
////                           imagevw.image = images[i]
////                            imagevw.layer.cornerRadius = imagevw.frame.size.width/3
////                            imagevw.clipsToBounds = true
////                            imagevw.heightAnchor.constraint(equalToConstant: 80).isActive = true
////                            imagesapend.append(imagevw)
////                        tabelview.addSubview(imagevw)
//
//                        // creating the text data
//
//                            let button1 = UIButton()
//                            button1.frame  = CGRect(x: 0, y: 0, width: 0, height: 0)
//                            button1.tag = i
//                            button1.titleLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//                            button1.titleLabel!.numberOfLines = 0
//                            button1.setTitle(text, for: UIControl.State.normal)
//                            button1.heightAnchor.constraint(equalToConstant: 80).isActive = true
//                            studntDtls.append(button1)
//                        tabelview.addSubview(button1)
//                         print("sucess")
                    }

                }catch
                {

                    print("unable to data")
       }
                return tabelview.reloadData()
    }
    // creating the delete button
    @IBAction func deleteBtn(_ sender: Any) {
        
       // Addtargets to The Delete button
        
            
            let fectchingRqst = NSFetchRequest<NSFetchRequestResult>(entityName: "PersonDetails")
                    let  result = try? managedObject.fetch(fectchingRqst)
                    for object in result as! [NSManagedObject]{
               managedObject.delete(object as! NSManagedObject)
                do{
                 print("deleted")
                try managedObject.save()
                  }catch{
                  print("Not Delteted")
                }
                }
              }
            
        
        
    
   

}

