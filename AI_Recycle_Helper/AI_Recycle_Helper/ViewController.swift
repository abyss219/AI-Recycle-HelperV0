//
//  ViewController.swift
//  AI_Recycle_Helper
//
//  Created by R L on 2021-12-11.
//


import UIKit
import CoreML
import Vision
import Social

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var myResult: UILabel!
    
    @IBOutlet weak var nextButton: UIButton!
    
    var r = ["","","","",""]

    
    
    
    var glassBin=["beer bottle","beer glass","coffee mug","red wine","wine bottle","perfume, essence","plate","cup","beaker"]
    var containerBin=["pop bottle, soda bottle"]
    var paperBin=["comic book","space bar"]
    var depot=["toilet tissue, toilet paper, bathroom tissue","bath towel","cellular telephone, cellular phone, cellphone, cell, mobile phone","paper towel","nail","worm fence, snake fence, snake-rail fence, Virginia fence","notebook, notebook computer","balloon"]
    var food=["pizza, pizza pie","meat loaf, meatloaf","hotdog, hot dog, red hot","mashed potato","broccoli","bell pepper","mushroom","banana","pineapple, ananas","strawberry","orange","lemon","jackfruit, jak, jack","custard apple","pomegranate","fig"]
    var furniture=["desk"]
    
    @IBOutlet weak var photoImageView: UIImageView!

    var classificationResults : [VNClassificationObservation] = []
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        myResult.text=""
        imagePicker.delegate = self
        self.nextButton.alpha=0

    }
    
    func detect(image: CIImage) {

        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }

        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                  let topResult = results.first
                 
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            self.nextButton.isEnabled=true
            self.nextButton.alpha=1
           
            
            //print("first: \(results[0].identifier)")
            //print("sec: \(results[1].identifier)")
            //print("third \(results[2].identifier)")
            for i in 0...4{
                self.r[i] = results[i].identifier
            }
          
            
            self.defineCatagories(nthResult:self.r[0]);
           // print(topResult) //results
           // print(topResult.identifier)
            //print(type(of:results[1]))
           // print(type(of:topResult))
    
        }

        let handler = VNImageRequestHandler(ciImage: image)

        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[.originalImage] as? UIImage {

            self.photoImageView.image = image
            self.imagePicker.dismiss(animated: true, completion: nil)
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            self.detect(image: ciImage)
        }
    }

    
    // parameters: nthResult garbagesCatas
    func defineCatagories(nthResult:String){
        self.myResult.text=nthResult
        if self.glassBin.contains(nthResult){
            DispatchQueue.main.async {
                self.navigationItem.title = "Result \(self.count%5+1): Glass"
                //self.navigationItem.titleTextAttributes=
                self.navigationController?.navigationBar.barTintColor = UIColor(red:176, green:176, blue:176, alpha: 1)
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(red:176, green:176, blue:176, alpha: 1)]
                self.navigationController?.navigationBar.isTranslucent = false
            }
        }
        else if self.containerBin.contains(nthResult){
            DispatchQueue.main.async {
                self.navigationItem.title = "Result \(self.count%5+1): Container"
                //self.navigationController?.navigationBar.barTintColor = UIColor.blue
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.blue]
                self.navigationController?.navigationBar.isTranslucent = false
            }
        }
        else if self.paperBin.contains(nthResult){
            
            DispatchQueue.main.async {
                self.navigationItem.title = "Result \(self.count%5+1): Paper"
                //self.navigationController?.navigationBar.barTintColor = UIColor.yellow
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.orange]
                self.navigationController?.navigationBar.isTranslucent = false
            }
        }
        else if self.food.contains(nthResult){
            DispatchQueue.main.async {
            self.navigationItem.title = "Result \(self.count%5+1): Food"
            //self.navigationController?.navigationBar.barTintColor = UIColor.green
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.green]
            self.navigationController?.navigationBar.isTranslucent = false
            }
        }else if self.furniture.contains(nthResult){
            DispatchQueue.main.async {
                self.navigationItem.title = "Result \(self.count%5+1): Furniture"
            //self.navigationController?.navigationBar.barTintColor = UIColor.green
            self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.purple]
            self.navigationController?.navigationBar.isTranslucent = false
            }
        }
        else{
            DispatchQueue.main.async {
                self.navigationItem.title = "Result \(self.count%5+1): Trash"
                //self.navigationController?.navigationBar.backgroundColor = UIColor.black
                self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
                self.navigationController?.navigationBar.isTranslucent = false
            }
        }
        
    }
    
    
    
    
    
    var count=0
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        
    /*
        print("1: \(self.r1).")
        print("2: \(self.r2).")
        print("3: \(self.r3).")
     */
        count+=1
        self.defineCatagories(nthResult:self.r[count%5])
        
        
        
    }
    
    @IBAction func cameraIsTapped(_ sender: UIBarButtonItem) {
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}



