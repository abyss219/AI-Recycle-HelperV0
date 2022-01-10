//
//  QuizViewController.swift
//  AI_Recycle_Helper
//
//  Created by R L on 2022-01-09.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    var count=0
    var questions=["1+2=5","2+6=7","3+1=4"]
    override func viewDidLoad() {
        super.viewDidLoad()
        questionText.text=questions[0]
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerButtonIsPressed(_ sender: UIButton) {
        
        questionText.text=questions[(count%(questions.count))]
        count+=1
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
