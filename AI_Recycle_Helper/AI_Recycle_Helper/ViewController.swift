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


    @IBOutlet weak var Result1: UILabel!
    
    
    @IBOutlet weak var photoImageView: UIImageView!

    var classificationResults : [VNClassificationObservation] = []
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        Result1.text=""
        imagePicker.delegate = self

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
            self.Result1.text=results[0].identifier
            
            print("first: \(results[0].identifier)")
            print("sec: \(results[1].identifier)")
            print("third \(results[2].identifier)")
             
            
         //   print(topResult) //results
           // print(topResult.identifier)
            
            print("=================================================")
            //print(type(of:results[1]))
           // print(type(of:topResult))
            
            
            print("***********8")
            
            /*
            var glassBin=['beer bottle','beer glass','coffee mug']
            var containerBin=['pop bottle, soda bottle','bottlecap']
            var paperBin=["newspaper",]
            var depot=['toilet tissue, toilet paper, bathroom tissue','bath towel','cellular telephone, cellular phone, cellphone, cell, mobile phone']
            
            */
            
            
            
            
            
            if topResult.identifier.contains("plastic bag") || topResult.identifier.contains("tissue") {
                DispatchQueue.main.async {
                    self.navigationItem.title = results[0].identifier+results[1].identifier
                    self.navigationController?.navigationBar.barTintColor = UIColor.green
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
            else if (topResult.identifier.contains("paper") ){
                DispatchQueue.main.async {
                    self.navigationItem.title = "paper!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
            else{
                
                DispatchQueue.main.async {
                    self.navigationItem.title = "i dont know!"
                    self.navigationController?.navigationBar.barTintColor = UIColor.yellow
                    self.navigationController?.navigationBar.isTranslucent = false
                }
            }
            
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

    
    
    @IBAction func cameraIsTapped(_ sender: UIBarButtonItem) {
        self.imagePicker.sourceType = .camera
        self.imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
    }
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}


