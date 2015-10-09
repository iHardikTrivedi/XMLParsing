//
//  ViewController.m
//  XMLParsingDemo
//
//  Created by Hardik Trivedi on 09/10/2015.
//  Copyright (c) 2015 iHartDevelopers. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <NSXMLParserDelegate, UITableViewDataSource, UITableViewDelegate>

@end

@implementation ViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startParsing];
}

#pragma mark - NSXMLParser Methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict;
{
    if([elementName isEqualToString:@"rss"])
        _marrXMLData = [[NSMutableArray alloc] init];
    
    if([elementName isEqualToString:@"item"])
        _mdictXMLPart = [[NSMutableDictionary alloc] init];
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string;
{
    if(!_mstrXMLString)
        _mstrXMLString = [[NSMutableString alloc] initWithString:string];
    else
        [_mstrXMLString appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName;
{
    if([elementName isEqualToString:@"title"] || [elementName isEqualToString:@"pubDate"]) {
        [_mdictXMLPart setObject:_mstrXMLString forKey:elementName];
    }
    
    if([elementName isEqualToString:@"item"])
        [_marrXMLData addObject:_mdictXMLPart];
    
    _mstrXMLString = nil;
}

#pragma mark - UITableView Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_marrXMLData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [[[_marrXMLData objectAtIndex:indexPath.row] valueForKey:@"title"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    cell.detailTextLabel.text = [[[_marrXMLData objectAtIndex:indexPath.row] valueForKey:@"pubDate"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return cell;
}

#pragma mark - Other Methods

- (void)startParsing
{
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://images.apple.com/main/rss/hotnews/hotnews.rss#sthash.TyhRD7Zy.dpuf"]];
    [xmlparser setDelegate:self];
    [xmlparser parse];
    
    if (_marrXMLData.count != 0) {
        [self.tblNews reloadData];
    }
}

@end
