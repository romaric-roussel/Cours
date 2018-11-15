//: ## Images dans les playgrounds
//:
//: Un certain nombre d'objets standards disposent de représentations graphiques utilisables directement dans les playgrounds ou comme aperçu dans le debugger
//:
import UIKit

let c = UIColor(red: 0.2, green: 0.6, blue: 0.78, alpha: 0.9)

let point = CGPoint(x: 30, y: 70)
let size = CGSize(width: 40, height: 20)
let rect = CGRect(origin: point, size: size)
let path = UIBezierPath()
path.move(to: CGPoint(x: 30,y: 60))
path.addLine(to: CGPoint(x: 40,y: 40))
path.addCurve(to: CGPoint(x: 160,y: 170), controlPoint1: CGPoint(x: 60,y: 40), controlPoint2: CGPoint(x: 30,y: 60))

let roundRect = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 80, height: 40), cornerRadius: 5.0)

let attributedString = NSMutableAttributedString(string: "Ceci est un essai", attributes: [NSAttributedString.Key.font: UIFont(name: "Chalkduster", size: 18.0)! ])

attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: NSRange(location: 5, length: 3))
attributedString

let img = UIImage(named: "FutureProgrammer.jpg")


//: Il est possible de représenter graphiquement l'évolution d'une variable
//:
for count in 0...100 {
    sin(1000.0 / Double(count))
}

//: ## Dessiner
//:

let drawingView = UIView(frame: CGRect(x: 0, y: 0, width: 640, height: 400))

let xCoord: CGFloat = 10
let yCoord: CGFloat = 20
let radius: CGFloat = 50

let dotPath = UIBezierPath(ovalIn: CGRect(x: xCoord, y: yCoord, width: radius, height: radius))

let layer = CAShapeLayer()
layer.path = dotPath.cgPath
layer.strokeColor = UIColor.blue.cgColor

drawingView.layer.addSublayer(layer)

drawingView

class MyView: UIView {
    override func draw(_ rect: CGRect) {
        
        // fill
        let fillColor = UIColor.red
        fillColor.setFill()
        
        // stroke
        let strokeColor = UIColor.blue
        strokeColor.setStroke()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 30,y: 60))
        path.addLine(to: CGPoint(x: 40,y: 40))
        path.addCurve(to: CGPoint(x: 160,y: 170), controlPoint1: CGPoint(x: 60,y: 40), controlPoint2: CGPoint(x: 30,y: 60))
        
        path.lineWidth = 1.0
        path.stroke()
        
        let roundRect = UIBezierPath(roundedRect: CGRect(x: 10, y: 100, width: 80, height: 40), cornerRadius: 5.0)
        
        roundRect.lineWidth = 1.0
        roundRect.stroke()
        roundRect.fill()

    }
}

let mydrawingView = MyView(frame: CGRect(x: 0, y: 0, width: 640, height: 400))
mydrawingView.backgroundColor = UIColor.white

//: Animation des changements de vue
import PlaygroundSupport

let containerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 375.0, height: 667.0))

//: Afficher l'éditeur assistant pour voir la vue
PlaygroundPage.current.liveView = containerView

let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
circle.center = containerView.center
circle.layer.cornerRadius = 25.0

let startingColor = UIColor(red: (253.0/255.0), green: (159.0/255.0), blue: (47.0/255.0), alpha: 1.0)
circle.backgroundColor = startingColor

containerView.addSubview(circle);

let rectangle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
rectangle.center = containerView.center
rectangle.layer.cornerRadius = 5.0

rectangle.backgroundColor = UIColor.white

containerView.addSubview(rectangle)

UIView.animate(withDuration: 2.0, animations: { () -> Void in
    let endingColor = UIColor(red: (255.0/255.0), green: (61.0/255.0), blue: (24.0/255.0), alpha: 1.0)
    circle.backgroundColor = endingColor
    
    let scaleTransform = CGAffineTransform(scaleX: 5.0, y: 5.0)
    
    circle.transform = scaleTransform
    
    let rotationTransform = CGAffineTransform(rotationAngle: 3.14)
    
    rectangle.transform = rotationTransform
})

//: Exemple d'utilisation d'un playground pour la mise au point *"interactive"* d'un traitement d'image
//:

import PlaygroundSupport

// Chargement d'une image située dans le dossier Resources du playground
// Utilisation de guard lors du déballage des optionnels nécessaires à la suite des traitements afin de stopper l'exécution du playground.
guard let path = Bundle.main.path(forResource: "Tortolla", ofType: "jpg") else {
    print("Impossible de créer le chemin de l'image")
    PlaygroundPage.current.finishExecution()
}

let imageUrl = URL(fileURLWithPath: path)

guard let data = try? Data.init(contentsOf: imageUrl) else {
    print("Unable to load image data")
    PlaygroundPage.current.finishExecution()
}

guard let img = UIImage(data: data) else {
    print("Unable to convert data to UIImage")
    PlaygroundPage.current.finishExecution()
}

guard let inputCIImage = CIImage.init(image: img) else {
    print("Impossible de créer l'image")
    PlaygroundPage.current.finishExecution()
}
inputCIImage

//: Ensuite on crée un filtre à appliquer à l'image. Pour un listing complet des filtres [aller ici](https://developer.apple.com/library/mac/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#).

let filterParameters = [
    kCIInputImageKey: inputCIImage,
    kCIInputColorKey: CIColor(red: 0.5, green: 0.5, blue: 0.5),
    kCIInputIntensityKey: 1.0
] as [String : Any]

let monochromeFilter: CIFilter! = CIFilter(name:"CIColorMonochrome", parameters: filterParameters)

let outputCIImage = monochromeFilter.outputImage

//let processedImage = UIImage(ciImage: outputCIImage!)

//: ## Explorer les réglages des filtres
//:
//: On pourrait se demander ce qui se passe lorsqu'on joue sur la couleur utilisée pour désaturer l'image. Dans la boucle ci-dessous, on peut voir ce qui se passe lorsque l'on modifie la valeur associée à kCIInputColorKey de 0 à 1.
let numImagesToGenerate = 3
for i in 1...numImagesToGenerate {
    
    let colorChannelValue: CGFloat = (CGFloat(i)/CGFloat(numImagesToGenerate))
    let ciColor = CIColor(red: 0, green: colorChannelValue, blue: colorChannelValue)
    monochromeFilter.setValue(ciColor, forKey:kCIInputColorKey)
    monochromeFilter.setValue(0.6, forKey:kCIInputIntensityKey)
    
    let outputImage = monochromeFilter.outputImage
}

let filters = CIFilter.filterNames(inCategory: kCICategoryColorEffect)
filters

//: [Previous](@previous)
