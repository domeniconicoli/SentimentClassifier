//
//  ViewController.swift
//  SentimentClassifier
//
//  Created by Domo on 24/09/2019.
//  Copyright © 2019 Domo. All rights reserved.
//

import UIKit
import NaturalLanguage
import CoreML

class ViewController: UIViewController {

    @IBOutlet weak var reviewInputTextView: UITextView!
    @IBOutlet weak var predictionResultImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Nascondo la tastiera
       override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
           self.view.endEditing(true)
       }
    
    @IBAction func validateButtonTapped(_ sender: Any) {
        do {
            let sentimentPredictor = try NLModel(mlModel: SentimentClassifier(configuration: MLModelConfiguration()).model)
            let result = sentimentPredictor.predictedLabel(for: reviewInputTextView.text)
            
            if result == "Positive" {
                predictionResultImageView.image = UIImage(systemName: "checkmark.shield.fill")
            } else if result == "Negative" {
                predictionResultImageView.image = UIImage(systemName: "xmark.shield.fill")
            }
            
        } catch {
            print("Error")
        }

    }

}
