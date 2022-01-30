//
//  QuizViewController.swi
//  AI_Recycle_Helper
//
//  Created by R L on 2022-01-09.
//

import UIKit

class QuizViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    
    @IBOutlet weak var questionImage: UIImageView!
    
    @IBOutlet weak var questionExp: UILabel!
    
    @IBOutlet weak var b1: UIButton!
    
    @IBOutlet weak var b2: UIButton!
    
    @IBOutlet weak var b3: UIButton!
    
    @IBOutlet weak var b4: UIButton!
    
  /*
    
    init(){
        buttonList=[];
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    var quiz = Quiz();
    
    
    
    
    var count=0
   
    //var questions=["1+2=5","2+6=7","3+1=4"]
    override func viewDidLoad() {
        super.viewDidLoad();
        updateUI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func answerButtonIsPressed(_ sender: UIButton) {
        let questions = quiz.questions;
        questionText.text=questions[(count%(questions.count))].questionText
        count+=1
        quiz.currentQustionNum=count
        updateUI();
        
        
    }
    
    func updateUI(){
        quiz.getQuestion();
        questionText.text = quiz.getQuestionText();
        let questionsOption = quiz.questions[quiz.currentQustionNum].options;
        let buttonList=[self.b1,self.b2,self.b3,self.b4];
        for i in 0...3{
            buttonList[i]?.setTitle(" ", for: .normal);
            buttonList[i]?.isEnabled=false;
            buttonList[i]?.alpha=0;
        }
        
        
        
        for index in 0...(questionsOption.count-1){
             buttonList[4-questionsOption.count+index]?.setTitle(questionsOption[index], for: .normal);
            buttonList[4-questionsOption.count+index]?.isEnabled=true;
            buttonList[4-questionsOption.count+index]?.alpha=1
        }
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
