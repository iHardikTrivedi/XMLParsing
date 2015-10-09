//
//  ViewController.h
//  XMLParsingDemo
//
//  Created by Hardik Trivedi on 09/10/2015.
//  Copyright (c) 2015 iHartDevelopers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, strong) NSMutableDictionary *mdictXMLPart;
@property (nonatomic,strong) NSMutableArray *marrXMLData;
@property (nonatomic,strong) NSMutableString *mstrXMLString;

@property (weak, nonatomic) IBOutlet UITableView *tblNews;

@end

