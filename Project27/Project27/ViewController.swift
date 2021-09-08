//
//  ViewController.swift
//  Project27
//
//  Created by JEONGSEOB HONG on 2021/09/07.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var currentDrawType = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        
        drawWordWithLine()
        
    }
    
    @IBAction func redrawTapped(_ sender: Any) {
        currentDrawType += 1
        
        if currentDrawType > 7 {
            currentDrawType = 0
        }
        
        switch currentDrawType {
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquares()
        case 4:
            drawLine()
        case 5:
            drawImagesAndText()
        case 6:
            drawEmoji()
        case 7:
            drawWordWithLine()
        default:
            break
        }
        
    }
    
    func drawRectangle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            // awesome drawing code
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image
    }
    
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            //            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            //            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: rectangle)
            //            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawCheckerboard() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            
            for row in 0 ..< 8 {
                for col in 0 ..< 8 {
                    if (row + col).isMultiple(of: 2) {
                        ctx.cgContext.setFillColor(UIColor.green.cgColor)
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                }
            }
        }
        
        imageView.image = image
    }
    
    func drawRotatedSquares() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotations = 16
            let amount = Double.pi / Double(rotations)
            
            
            for _ in 0 ..< rotations {
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -125, y: -125, width: 256, height: 256))
            }
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawLine() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            for _ in 0 ..< 256 {
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first {
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50 ))
                    first = false
                } else {
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                
                length *= 0.99
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
    
    func drawImagesAndText() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
            
            let string = "The best-laid schemes o'\nmice an' men gang aft agley"
            let attributedString = NSAttributedString(string: string, attributes: attrs)
            attributedString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448),
                                  options: .usesLineFragmentOrigin,
                                  context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
        }
        
        imageView.image = image
        
    }
    
    func drawEmoji() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { ctx in
            
            ctx.cgContext.addEllipse(in: CGRect(x: 0, y: 0, width: 512, height: 512))
            ctx.cgContext.translateBy(x: 256, y: 256)
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: -125 - 50, y: -125, width: 100, height: 100))
            ctx.cgContext.translateBy(x: 50, y: 50)
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: -125 - 50, y: -125, width: 20, height: 20))
            ctx.cgContext.translateBy(x: -50, y: -50)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: 125 - 50, y: -125, width: 100, height: 100))
            ctx.cgContext.translateBy(x: 25, y: 50)
            ctx.cgContext.setFillColor(UIColor.white.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: 125 - 50, y: -125, width: 20, height: 20))
            ctx.cgContext.translateBy(x: -25, y: -50)
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: 0 - 100, y: 50, width: 200, height: 200))
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
            
            ctx.cgContext.addEllipse(in: CGRect(x: -50, y: 150, width: 100, height: 100))
            ctx.cgContext.setFillColor(UIColor.systemPink.cgColor)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = image
    }
    
    func drawWordWithLine() {
        let render = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = render.image { ctx in
            
            // T
            ctx.cgContext.translateBy(x: 100, y: 200)
            ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 0))
            ctx.cgContext.strokePath()
            ctx.cgContext.move(to: CGPoint(x: 55, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 55, y: 100))
            ctx.cgContext.strokePath()
            
            // W
            ctx.cgContext.translateBy(x: 110, y: 0)
            ctx.cgContext.move(to: CGPoint(x: 0, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 33, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 66, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 0))
            ctx.cgContext.strokePath()
            
            // I
            ctx.cgContext.translateBy(x: 110, y: 0)
            ctx.cgContext.move(to: CGPoint(x: 50, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 50, y: 100))
            ctx.cgContext.strokePath()
    
            // N
            ctx.cgContext.translateBy(x: 80, y: 0)
            ctx.cgContext.move(to: CGPoint(x: 0, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 0, y: 0))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 100))
            ctx.cgContext.addLine(to: CGPoint(x: 100, y: 0))
            ctx.cgContext.strokePath()
        }
        
        imageView.image = image
    }
}

