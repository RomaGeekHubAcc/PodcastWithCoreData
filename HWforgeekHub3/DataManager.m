//
//  DataManager.m
//  HWforgeekHub3
//
//  Created by Roma on 28.12.13.
//  Copyright (c) 2013 Roma. All rights reserved.
//

#import "DataManager.h"
#import <CoreData/CoreData.h>
#import "Podcast.h"
#import "PodcastItem.h"
#import "CDPodcast.h"
#import "CDPodcastItem.h"
#import "CDAudioFile.h"




@interface DataManager ()
{
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}
@end

@implementation DataManager

+ (DataManager*)sharedDataManager {
    static DataManager *__sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[DataManager alloc]init];
    });
    
    return __sharedInstance;
}

- (NSArray*)getAllPodcasts {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"CDPodcast" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    NSError *error;
    NSArray *fetchedPodcast = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    return fetchedPodcast;
} 

- (void)insertNewObject:(Podcast*)podcast {
    
    NSError *error;
    
    _managedObjectContext = [self managedObjectContext];
    
    CDPodcast *newPodcast = [CDPodcast podcastWithLink:podcast.link context:_managedObjectContext];
    
    newPodcast.podcastTitle = podcast.podcastTitle;
    newPodcast.podcastDescription = podcast.podcastDescription;
    newPodcast.podcastImage = podcast.podcastImage;
    
    for (PodcastItem *podcastItem in podcast.arrayPodcastItems) {
        CDPodcastItem *newItem = [CDPodcastItem podcastItemWith_guid:podcastItem.guid context:_managedObjectContext];
        
        newItem.itemTitle = podcastItem.title;
        newItem.itemDescription = podcastItem.itemDescription;
        newItem.itemAuthhor = podcastItem.autor;
        newItem.itemImage = podcastItem.imageStr;
        newItem.itemPubDate = nil;
        newItem.podcast = newPodcast;
        
        for (NSString *audioFile in podcastItem.audioFilePathArray) {
            CDAudioFile *cdAudioFile = [CDAudioFile cdAudioFileWithAudioFileURL:audioFile context:_managedObjectContext];
            cdAudioFile.podcastItem = newItem;
            
            [_managedObjectContext save:&error];
            if (![_managedObjectContext save:&error]) {
                NSLog(@" --  insertNewAudioFile error — %@", error);
            }
        }
        
        [_managedObjectContext save:&error];
        if (![_managedObjectContext save:&error]) {
            NSLog(@"--  insertNewItem error — %@", error);
        }
    }
    
    [_managedObjectContext save:&error];
    if (![_managedObjectContext save:&error]) {
        NSLog(@"--  insertNewObj error — %@", error);
    }
    else NSLog(@"  -----  New Object added");
}

#pragma mark - Core Data stack
// Returns the managed object context for the application.
// If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
        
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _managedObjectContext = [[NSManagedObjectContext alloc] init];
        [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _managedObjectContext;
}
                               
// Returns the managed object model for the application.
// If the model doesn't already exist, it is created from the application's model.
- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"CDModel" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}
                               
// Returns the persistent store coordinator for the application.
 // If the coordinator doesn't already exist, it is created and the application's store added to it.
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
        
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"HWforgeekHub3.sqlite"];
        
    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
             
             Typical reasons for an error here include:
             * The persistent store is not accessible;
             * The schema for the persistent store is incompatible with current managed object model.
             Check the error message to determine what the actual problem was.
             
             
             If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
             
             If you encounter schema incompatibility errors during development, you can reduce their frequency by:
             * Simply deleting the existing store:
             [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
             
             * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
             @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
             
             Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
             
             */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
       }    
        
    return _persistentStoreCoordinator;
}
                               
#pragma mark - Application's Documents directory
                               
// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}
                               

@end
