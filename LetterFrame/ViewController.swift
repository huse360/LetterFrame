//
//  ViewController.swift
//  CoreTextWrapperTest
//
//  Created by huse on 11/08/20.
//  Copyright © 2020 huse. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let ctView = TextBoxesView()
  

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(ctView)
    }
 
}




///Todo: Put this on a separate file:

class TextBoxesView: UIView {


    let font = UIFont.systemFont(ofSize: 50)
          
    override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
       
        
       context.textMatrix = .identity
       context.translateBy(x: 0, y: self.bounds.size.height)
       context.scaleBy(x: 1.0, y: -1.0)
       
        
       let string = "｜優勝《ゆうしょう》の｜懸《か》かった｜試合《しあい》。｜Test《テスト》.\nThe quick brown fox jumps over the lazy dog. 12354567890 @#-+"
  
        
       let attributedString = Utility.sharedInstance.furigana(String: string)
       
       let range = attributedString.mutableString.range(of: attributedString.string)

       attributedString.addAttribute(.font, value: font, range: range)

       
       let framesetter = attributedString.framesetter()
       
       let textBounds = self.bounds.insetBy(dx: 20, dy: 20)
       let frame = framesetter.createFrame(textBounds)
        
//Draw the frame text:
       
       frame.draw(in: context)
               
       let origins = frame.lineOrigins()
       
       let lines = frame.lines()

        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(0.7)

        for i in 0 ..< origins.count {

            let line = lines[i]
             
            for run in line.glyphRuns() {
                
                let font = run.font
                let glyphPositions = run.glyphPositions()
                let glyphs = run.glyphs()
                
                let glyphsBoundingRects =  font.boundingRects(of: glyphs)
                
//DRAW the bounding box for each glyph:
                
                for k in 0 ..< glyphPositions.count {
                    let point = glyphPositions[k]
                    let gRect = glyphsBoundingRects [k]
                
                    var box = gRect
                    box.origin +=  point + origins[i] + textBounds.origin
                    context.stroke(box)
                            
                }// for k
            
            }//for run
            
       }//for i
        
    }//func draw

}//class


extension TextBoxesView : Autosizable {

    override func didMoveToSuperview() {
        setupConstrains()
    }

}



