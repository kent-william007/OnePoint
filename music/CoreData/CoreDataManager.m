//
//  CoreDataManager.m
//  music
//
//  Created by kent on 2017/9/8.
//  Copyright © 2017年 肖金兴. All rights reserved.
//

#import "CoreDataManager.h"
#import <CoreData/CoreData.h>
#import "SongsModel.h"
#import "FavoriteModel.h"
#import "DestinationModel.h"

/**数据库存储的最大数量*/
static NSInteger maxSotre = 200;

@interface CoreDataManager()

/**托管对象上下文*/
@property(strong,nonatomic)NSManagedObjectContext *managedObjectContext;
@property(nonatomic,copy)NSString *dataSource;

@end

@implementation CoreDataManager


- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
-(void)setSourceType:(DataSourceType)sourceType{
    _sourceType = sourceType;
    if (sourceType == DataSourceHistory) {
        _dataSource = @"SongsModel";
    }else if(sourceType == DataSourceFavorite){
        _dataSource = @"FavoriteModel";
    }
}

/**
 创建上下文对象
 */
- (NSManagedObjectContext *)contextWithModelName:(NSString *)modelName {
    // 创建上下文对象，并发队列设置为主队列
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    // 创建托管对象模型，并使用Company.momd路径当做初始化参数
    NSURL *modelPath = [[NSBundle mainBundle] URLForResource:modelName withExtension:@"momd"];
    NSManagedObjectModel *model = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelPath];
    
    // 创建持久化存储调度器
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
    
    // 创建并关联SQLite数据库文件，如果已经存在则不会重复创建
    NSString *dataPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath = [dataPath stringByAppendingFormat:@"/%@.sqlite", modelName];
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataPath] options:nil error:nil];
    NSLog(@"coreDataPath:%@",dataPath);
    // 上下文对象设置属性为持久化存储器
    context.persistentStoreCoordinator = coordinator;
    
    return context;
}


- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [self contextWithModelName:@"CoreDataModel"];
    }
    return _managedObjectContext;
}

- (void)coreDatWithDList:(DList*)songContent{
    
    if ([self getCoreData].count >= maxSotre) {
        [self deleteItem:[[self getCoreData] objectAtIndex:0]];
    }
    
    [self deleteItem:songContent];
    if (_sourceType == DataSourceHistory) {
        // 创建托管对象，并指明创建的托管对象所属实体名
        SongsModel *song = [NSEntityDescription insertNewObjectForEntityForName:_dataSource inManagedObjectContext:self.managedObjectContext];
        [[song getAllProperties] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([[songContent valueForKey:obj] isKindOfClass:[NSString class]]) {
                [song setValue:[songContent valueForKey:obj] forKey:obj];
            }else{
                NSInteger valueInt = [[songContent valueForKey:obj] integerValue];
                [song setValue:[NSNumber numberWithInteger:valueInt] forKey:obj];
            }
        }];

    }else if (_sourceType == DataSourceFavorite){
        // 创建托管对象，并指明创建的托管对象所属实体名
        FavoriteModel *song = [NSEntityDescription insertNewObjectForEntityForName:_dataSource inManagedObjectContext:self.managedObjectContext];
        [[song getAllProperties] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([[songContent valueForKey:obj] isKindOfClass:[NSString class]]) {
                [song setValue:[songContent valueForKey:obj] forKey:obj];
            }else{
                NSInteger valueInt = [[songContent valueForKey:obj] integerValue];
                [song setValue:[NSNumber numberWithInteger:valueInt] forKey:obj];
            }
        }];

    }
    
    // 通过上下文保存对象，并在保存前判断是否有更改
    NSError *error = nil;
    if (self.managedObjectContext.hasChanges) {
        [self.managedObjectContext save:&error];
    }
    
    // 错误处理，可以在这实现自己的错误处理逻辑
    if (error) {
        NSLog(@"CoreData Insert Data Error : %@", error);
    }
}
- (NSArray<DList *> *)getCoreData{
    
    // 建立获取数据的请求对象，指明操作的实体为Student
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:_dataSource];
    
    // 执行获取操作，获取所有Student托管对象
    NSError *error = nil;
    __block NSMutableArray *list = [NSMutableArray array];
    if (_sourceType == DataSourceHistory) {
        NSArray<SongsModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];

        // 遍历输出查询结果
        [songs enumerateObjectsUsingBlock:^(SongsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DList *listModel = [[DList alloc]init];
            [[obj getAllProperties] enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                [listModel setValue:[obj valueForKey:key] forKey:key];
            }];
            [list addObject:listModel];
            
        }];
    }else if (_sourceType == DataSourceFavorite){
        NSArray<FavoriteModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];
        // 遍历输出查询结果
        [songs enumerateObjectsUsingBlock:^(FavoriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            DList *listModel = [[DList alloc]init];
            [[obj getAllProperties] enumerateObjectsUsingBlock:^(NSString * _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                [listModel setValue:[obj valueForKey:key] forKey:key];
            }];
            [list addObject:listModel];
            
        }];
    }
    
    
    
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Ergodic Data Error : %@", error);
    }
    return list;

}

- (void)deleteItem:(DList *)songContent{
    // 建立获取数据的请求对象，指明对Student实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:_dataSource];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackId = %li", songContent.trackId];
    request.predicate      = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    
    if (_sourceType == DataSourceHistory ) {
        NSArray<SongsModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        // 遍历符合删除要求的对象数组，执行删除操作
        [songs enumerateObjectsUsingBlock:^(SongsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.managedObjectContext deleteObject:obj];
        }];
    }else if (_sourceType == DataSourceFavorite){
        NSArray<FavoriteModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];
        
        // 遍历符合删除要求的对象数组，执行删除操作
        [songs enumerateObjectsUsingBlock:^(FavoriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.managedObjectContext deleteObject:obj];
        }];
    }
    
    
    
    // 保存上下文，并判断当前上下文是否有改动
    if (self.managedObjectContext.hasChanges) {
        [self.managedObjectContext save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }

}

- (BOOL)checkItem:(DList *)songContent{
    // 建立获取数据的请求对象，指明对Student实体进行删除操作
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:_dataSource];
    
    // 创建谓词对象，过滤出符合要求的对象，也就是要删除的对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"trackId = %li", songContent.trackId];
    request.predicate      = predicate;
    
    // 执行获取操作，找到要删除的对象
    NSError *error = nil;
    if (_sourceType == DataSourceHistory) {
        NSArray<SongsModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];
        if (songs.count > 0) {
            return YES;
        }
        // 遍历符合删除要求的对象数组，执行删除操作
//        [songs enumerateObjectsUsingBlock:^(SongsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self.managedObjectContext deleteObject:obj];
//        }];

    }else{
        NSArray<FavoriteModel *> *songs = [self.managedObjectContext executeFetchRequest:request error:&error];
        if (songs.count > 0) {
            return YES;
        }

        // 遍历符合删除要求的对象数组，执行删除操作
//        [songs enumerateObjectsUsingBlock:^(FavoriteModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            [self.managedObjectContext deleteObject:obj];
//        }];

    }
    
    // 保存上下文，并判断当前上下文是否有改动
    if (self.managedObjectContext.hasChanges) {
        [self.managedObjectContext save:nil];
    }
    
    // 错误处理
    if (error) {
        NSLog(@"CoreData Delete Data Error : %@", error);
    }
    return NO;
}

@end
