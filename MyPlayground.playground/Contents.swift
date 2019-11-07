import CreateML
import AppKit

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/domo/Desktop/TrainData.json"))

let (trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)
let sentimentClassifier = try MLTextClassifier(trainingData: trainingData,
textColumn: "SentimentText",
labelColumn: "Sentiment")

// Training accuracy as a percentage
let trainingAccuracy = (1.0 - sentimentClassifier.trainingMetrics.classificationError) * 100

// Validation accuracy as a percentage
let validationAccuracy = (1.0 - sentimentClassifier.validationMetrics.classificationError) * 100
let evaluationMetrics = sentimentClassifier.evaluation(on: testingData, textColumn: "SentimentText", labelColumn: "SentimentText")

// Evaluation accuracy as a percentage
let evaluationAccuracy = (1.0 - evaluationMetrics.classificationError) * 100

let metadata = MLModelMetadata(author: "Domenico Nicoli",
                               shortDescription: "A model trained to classify movie review",
                               version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/domo/Desktop/SentimentClassifier.mlmodel"),
                              metadata: metadata)



