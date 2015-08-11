//
//  ViewController.m
//  复杂json解析(视频播放)
//
//  Created by MacBookPro on 15/8/11.
//  Copyright (c) 2015年 sky5156. All rights reserved.
//

#import "ViewController.h"

#import "LGVideo.h"

#import <SDWebImage/UIImageView+WebCache.h>

#import <MediaPlayer/MediaPlayer.h>

#import <MJExtension/MJExtension.h>

@interface ViewController ()<NSXMLParserDelegate>

@property (nonatomic, strong) NSMutableArray *videos;

@end
@implementation ViewController

- (NSMutableArray *)videos
{
    if (!_videos) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
       
    //请求数据
    
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/video?type=XML"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
        //创建xml解析器
        NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
        
        //设置代理
        parser.delegate = self;
        
        //开始解析
        [parser parse];
    }];
    }

#pragma mark - 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.videos.count;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"000000000000");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //设置数据
    LGVideo *video = self.videos[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"时长:%@",video.length];
    cell.textLabel.text = video.name;

    NSString *urlString = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:video.image];
NSLog(@"%@",video.image);
    NSURL *url = [NSURL URLWithString:urlString];
    [cell.imageView sd_setImageWithURL:url placeholderImage:nil];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LGVideo *video = self.videos[indexPath.row];
    
    NSString *urlString = [@"http://120.25.226.186:32812" stringByAppendingPathComponent:video.url];

    NSURL *url = [NSURL URLWithString:urlString];
    
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    
    [self presentViewController:moviePlayer animated:YES completion:nil];
}

#pragma mark - 解析xml用的代理


 -(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
 
    if ([elementName isEqualToString:@"videos"]) {
        return;
    }  //
       LGVideo *video = [LGVideo objectWithKeyValues:attributeDict];
   
    [self.videos addObject:video];
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
   
    [self.tableView reloadData];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
  //  NSLog(@"parserDidStartDocument:");
}

-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    //NSLog(@"parseErrorOccurred:");
}

@end
