//
//  RatingControl.swift
//  AppleTutorial
//
//  Created by Min thu Kyaw on 3/8/17.
//  Copyright © 2017 Min thu Kyaw. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet{
            setUpButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet{
            setUpButtons()
        }
    }

    //MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpButtons()
    }
    
    //MARK: Button Action
    
    func ratingButtonTapped(button: UIButton) {
        print("Button pressed 👍")
        guard let index = ratingButtons.index(of: button) else {
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        
        let selectedButton = index + 1;
        
        if selectedButton == rating {
            rating = 0
        } else {
            rating = selectedButton
        }
    }
    
    //MARK: Private Methods
    
    private func updateButtonSelectionStates() {
        
        for (index,button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            let hintString : String?
            
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
            
            button.accessibilityHint = hintString
            
            let valueString : String?
            switch rating {
            case 0:
                valueString = "No Rating yet"
            default:
                valueString = "\(rating) stars set"
            }
            
            button.accessibilityValue = valueString
            
        }
        
        
    }
    
    private func setUpButtons() {
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)

        for index in 0..<starCount {
            // Create the button
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: [.highlighted,.selected])
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // set up button action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
            
            //add accessibility 
            button.accessibilityLabel = "Set \(index) start"
            
            // Add the button to the stack
            addArrangedSubview(button)
            
            //add button to rating button array
            ratingButtons.append(button)
            
        }
    }

}
