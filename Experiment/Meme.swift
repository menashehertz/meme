//
//  Meme.swift
//  Experiment
//
//  Created by Steven Hertz on 6/16/15.
//  Copyright (c) 2015 Steven Hertz. All rights reserved.
//

import Foundation
import UIKit


struct MeMe {
  
  var topText : String
  var bottomText : String
  var image : UIImage
  var memImage : UIImage
  
  init(topText : String, bottomText : String, image : UIImage, memImage : UIImage) {
    self.topText = topText
    self.bottomText = bottomText
    self.image = image
    self.memImage = memImage
  }


}