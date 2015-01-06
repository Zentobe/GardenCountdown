//
//  ViewController.h
//  GardenCountdown
//
//  Created by Dabid Nguyen on 11/9/14.
//  Copyright (c) 2014 David Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int hoursLeft, minutesLeft, daysLeft, seconds, total;
}
@property (weak, nonatomic) IBOutlet NSTimer *timer;
@property (weak, nonatomic) IBOutlet UITextField *minutes;
@property (weak, nonatomic) IBOutlet UITextField *hours;
@property (weak, nonatomic) IBOutlet UITextField *days;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UIButton *reset;
@property (weak, nonatomic) IBOutlet UIButton *pause;
@property (weak, nonatomic) IBOutlet UIButton *start;
- (IBAction)startTimer:(id)sender;
- (IBAction)stopTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;
- (IBAction)keypadGoBack:(id)sender;


@end

