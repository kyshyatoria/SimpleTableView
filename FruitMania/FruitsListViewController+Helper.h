//
//  FruitsListViewController+Helper.h
//  FruitMania
//
//  Created by Kanchan Yadav on 18/06/16.
//  Copyright © 2016 Kanchan Yadav. All rights reserved.
//

#import "FruitsListViewController.h"

@interface FruitsListViewController (Helper)

-(NSDictionary *)sortFruitsArrayAlphabatically:(NSArray *)fruitsArray;

-(UIColor *)generateRandomColorForSectionBackground;

-(NSAttributedString *)generateAttributedString:(NSString *)text andHeaderText:(NSString *)headerText;

-(CGFloat)getStringSize:(NSAttributedString *)attrString;

@end
