//
//  ViewController.m
//  HelloWorld
//
//  Created by lpiem on 18/10/2018.
//  Copyright © 2018 lpiem. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *monLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)refrech:(id)sender {
    //NSDate *now = [[NSDate alloc] initWithTimeIntervalSinceNow:0.0];
    NSDate *now = [NSDate date];
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"dd/MM/yyyy HH:mm:ss"];
    NSString *newDateString = [outputFormatter stringFromDate:now];
     
    
    
    
    [_monLabel setText:newDateString];
    //self.monLabel.text = newDateString;
}

@end
