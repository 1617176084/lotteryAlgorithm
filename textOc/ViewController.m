//
//  ViewController.m
//  textOc
//
//  Created by 黄燕 on 16/3/23.
//  Copyright © 2016年 kenneth. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
  NSMutableArray *_allPool;
  int _indexSeeds; //种子数量
  NSArray *cellArr;
}
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  _allPool = [NSMutableArray new];

  cellArr = @[
    [[NSString stringWithFormat:@"0"] copy],
    [[NSString stringWithFormat:@"1"] copy],
    [[NSString stringWithFormat:@"2"] copy],
    [[NSString stringWithFormat:@"3"] copy],
    [[NSString stringWithFormat:@"4"] copy],
    [[NSString stringWithFormat:@"5"] copy],
    [[NSString stringWithFormat:@"6"] copy],
    [[NSString stringWithFormat:@"7"] copy],
    [[NSString stringWithFormat:@"8"] copy],
    [[NSString stringWithFormat:@"9"] copy]
  ];
  _indexSeeds = (int)cellArr.count;
  //真实取值
  int number[cellArr.count];
  for (int i = 0; i < cellArr.count; i++) {
    number[i] = 0;
  }
  //模拟取值
  int numberSimulation[cellArr.count];
  for (int i = 0; i < cellArr.count; i++) {
    numberSimulation[i] = 0;
  }
  for (int i = 0; i < 2000; i++) {

    //真实取到的值 位置
    int index = [self begginRunLoopTwo:cellArr];
    //模拟取值 位置
    int indexSimulation = [self getOneOBjectWithIndex];
    //取到的值内容
    NSString *cellObj = [_allPool objectAtIndex:index];
    ;
    //模拟取到的值内容
    NSString *cellObjSimulation = [_allPool objectAtIndex:indexSimulation];
    //[self getOneSmartOBjectWithIndex]; //
    ;

    //插入取到的值
    int indeCellArr = (int)[cellArr indexOfObject:cellObj];
    number[indeCellArr] = number[indeCellArr] + 1;
    //从概率池删除这条数据
    [_allPool removeObjectAtIndex:index];
    //插入到模拟取值的概率运算池中
    if ([cellObj isEqualToString:cellObjSimulation]) {
      numberSimulation[indeCellArr] = numberSimulation[indeCellArr] + 1;
    }
  }
  for (int i = 0; i < cellArr.count; i++) {
    NSLog(@"数据为[%@]=出现的次数%d", cellArr[i], number[i]);
    NSLog(@"模拟数据[%@]= 蒙对的概率为出现的次数%d", cellArr[i],
          numberSimulation[i]);
  }
}
//开始一个循环  本次循环的值
- (NSString *)begginRunLoop:(NSArray *)_cellArrCell {

  [_allPool addObjectsFromArray:_cellArrCell];
  int index = arc4random() % _allPool.count;
  NSString *cellObj = [_allPool objectAtIndex:index];
  ;
  NSLog(@"获得随机数 %@", cellObj);
  [_allPool removeObjectAtIndex:index];
  return cellObj;
}
//开始一个循环  本次循环的值
- (int)begginRunLoopTwo:(NSArray *)_cellArrCell {

  [self insertArr:_cellArrCell];
  //真实取到的值
  int index = [self getOneOBjectWithIndex];

  return index;
}
//获得一条数据的位置  用来模拟  和 真实取数据
- (int)getOneOBjectWithIndex {
  return arc4random() % _allPool.count;
}
//获得一条数据内容 智能运算
- (NSString *)getOneSmartOBjectWithIndex {
  //划分出每个数据拥有的个数
  int numberSimulation[cellArr.count];
  for (int i = 0; i < cellArr.count; i++) {
    numberSimulation[i] = 0;
  }
  for (int i = 0; i < _allPool.count; i++) {
    NSString *poolCell = _allPool[i];
    for (int j = 0; j < cellArr.count; j++) {
      NSString *cellArCell = cellArr[j];
      //插入到当前数据池中
      if ([poolCell isEqualToString:cellArCell]) {
        numberSimulation[j] = numberSimulation[j] + 1;
      }
    }
  }
  //找出最大数据概率 内容
  int index = 0;
  for (int i = 0; i < cellArr.count; i++) {
    if (numberSimulation[i] > numberSimulation[index]) {
      index = i;
    }
  }

  return cellArr[index];
}
//插入一条原始数据
- (void)insertArr:(NSArray *)_cellArr {
  [_allPool addObjectsFromArray:_cellArr];
}
//获得一条数据
- (id)getOneObject {
  return [_allPool objectAtIndex:arc4random() % _allPool.count];
}
//获得一条数据
- (void)deleteOneObject:(id)_cell {
  [_allPool removeObject:_cell];
}
- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
