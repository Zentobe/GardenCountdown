//
//  ViewController.m
//  GardenCountdown
//
//  Created by Dabid Nguyen on 11/9/14.
//  Copyright (c) 2014 David Nguyen. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [_pause setEnabled:NO];
    [_reset setEnabled:NO];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)runScheduledTask: (NSTimer *) runningTimer {
    _timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", daysLeft, hoursLeft, minutesLeft];
    total--;
    if (total==0) {
        [_timer invalidate];
        _timerLabel.text = @"Time up!!";
    }
}
- (IBAction)startTimer {
    int hoursSeconds, minutesSeconds, daysSeconds;
    [_pause setTitle:@"Pause" forState:UIControlStateNormal];
    hoursLeft = [_hours.text intValue];
    daysLeft = [_days.text intValue];
    minutesLeft = [_minutes.text intValue];
    hoursSeconds = hoursLeft*3600;
    daysSeconds = daysLeft*86400;
    minutesSeconds = minutesLeft*60;
    total = hoursSeconds+minutesSeconds+daysSeconds;
    if (total >0 ) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:YES];
        [_start setEnabled:NO];
        [_pause setEnabled:YES];
        [_reset setEnabled:YES];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"Please! enter valid timer value" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)stopTimer {
    if ([@"Pause" isEqualToString:[_pause titleForState:UIControlStateNormal]]) {
        NSLog(@"Paused");
        [_pause setTitle:@"Resume" forState:UIControlStateNormal];
        [_start setEnabled:NO];
        [_pause setEnabled:YES];
        [_reset setEnabled:NO];
        if (_timer != nil) {
            [_timer invalidate];
            _timerLabel.text =[NSString stringWithFormat:@"Time Remaining %02d:%02d:%02d", daysLeft, hoursLeft, minutesLeft];
        }
    }
    else{
        NSLog(@"Resumed");
        [_pause setTitle:@"Pause" forState:UIControlStateNormal];
        [_start setEnabled:NO];
        [_pause setEnabled:YES];
        [_reset setEnabled:YES];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(runScheduledTask:) userInfo:nil repeats:YES];
        if (total==0) {
            NSLog(@"Time up!!");
            [_timer invalidate];
            _timerLabel.text = @"Time up!!";
        }
    }
}

- (IBAction)resetTimer {
    [_start setEnabled:YES];
    [_pause setEnabled:NO];
    [_reset setEnabled:NO];
    [_pause setTitle:@"Pause" forState:UIControlStateNormal];
    if (_timer != nil) {
        [_timer invalidate];
        _timerLabel.text = @"Timer got reset!!";
    }
    else{
        NSLog(@"timer is nil");
    }
    _timerLabel.text=@"";
}

@end

