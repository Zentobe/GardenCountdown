//
//  ViewController.h
//  GardenCountdown
//
//  Created by Dabid Nguyen on 11/9/14.
//  Copyright (c) 2014 David Nguyen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    int secondsLeft, daysLeft, minutesLeft, hoursLeft;
}

@property (nonatomic, weak) NSTimer *timer;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *timerLabel;
@property (weak, nonatomic) IBOutlet UITextField *daysText;
@property (weak, nonatomic) IBOutlet UITextField *hoursText;
@property (weak, nonatomic) IBOutlet UITextField *minutesText;

@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UIButton *pauseButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

- (IBAction)edit:(id)sender;
- (IBAction)selectPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;

- (IBAction)startTimer:(id)sender;
- (IBAction)stopTimer:(id)sender;
- (IBAction)resetTimer:(id)sender;
- (IBAction)keypadGoBack:(id)sender;
@end
