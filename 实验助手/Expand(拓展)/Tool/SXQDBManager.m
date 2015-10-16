//
//  SXQDBManager.m
//  实验助手
//
//  Created by sxq on 15/9/25.
//  Copyright © 2015年 SXQ. All rights reserved.
//
@import UIKit;
#import "SXQExperimentModel.h"
#import "SXQSupplierData.h"
#import "SXQConsumable.h"
#import "SXQConsumableMap.h"
#import "SXQEquipment.h"
#import "SXQEquipmentMap.h"
#import "SXQReagent.h"
#import "SXQReagentMap.h"
#import "SXQSupplier.h"

#import "ExperimentTool.h"
#import "SXQExpInstruction.h"
#import "SXQExpConsumable.h"
#import "SXQExpEquipment.h"
#import "SXQExpReagent.h"
#import "SXQExpStep.h"
#import "SXQMyExperiment.h"

#import "SXQInstructionData.h"
#import <FMDB/FMDB.h>
#import "SXQDBManager.h"
#import "NSString+Date.h"
#import "SXQExpInstruction.h"
#import "SXQInstructionStep.h"
#import "SXQSupplier.h"
#import "SXQCurrentExperimentData.h"
#define InstructionDBName @"instruction.sqlite"

static SXQDBManager *_dbManager = nil;

@interface SXQDBManager ()
@property (nonatomic,strong) FMDatabaseQueue *queue;
@end
@implementation SXQDBManager
+ (instancetype)sharedManager
{
    return [[self alloc] init];
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (_dbManager == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _dbManager = [super allocWithZone:zone];
        });
    }
    return _dbManager;
}
- (instancetype)init
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbManager = [super init];
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [_dbManager setupDataBase];
        });
    });
    return _dbManager;
}
/**
 *  初始化数据库
 */
- (void)setupDataBase
{
    NSString *dbPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask ,YES) lastObject] stringByAppendingPathComponent:InstructionDBName];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        [[self setupMyInstruction] enumerateObjectsUsingBlock:^(NSString *sql, NSUInteger idx, BOOL * _Nonnull stop) {
            [db executeUpdate:sql];
        }];
        
        [[self setupMyExp] enumerateObjectsUsingBlock:^(NSString *sql, NSUInteger idx, BOOL * _Nonnull stop) {
            [db executeUpdate:sql];
        }];
        
    }];
    [_queue close];
    if (![self supplierTableExist]) {
            [self loadSupplierData];
        }
}
- (void)loadSupplierData
{
        [ExperimentTool loadSupplierDataSuccess:^(SXQSupplierData *result) {
            [_queue inDatabase:^(FMDatabase *db) {
                [result.supplier enumerateObjectsUsingBlock:^(SXQSupplier *supplier, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertSupplier:supplier db:db];
                }];
                [result.consumable enumerateObjectsUsingBlock:^(SXQConsumable *consumable, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertConsumable:consumable db:db];
                }];
                [result.consumableMap enumerateObjectsUsingBlock:^(SXQConsumableMap *consumableMap, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertConsumableMap:consumableMap db:db];
                }];
                [result.reagent enumerateObjectsUsingBlock:^(SXQReagent *reagent, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertReagent:reagent db:db];
                }];
                [result.reagentMap enumerateObjectsUsingBlock:^(SXQReagentMap *reagentMap, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertReagentMap:reagentMap db:db];
                }];
                [result.equipment enumerateObjectsUsingBlock:^(SXQEquipment *equipment, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertEquipment:equipment db:db];
                }];
                [result.equipmentMap enumerateObjectsUsingBlock:^(SXQEquipmentMap *equipmentMap, NSUInteger idx, BOOL * _Nonnull stop) {
                    [self insertEquipmentMap:equipmentMap db:db];
                }];    
            }];
            [_queue close];
        } failure:^(NSError *error) {
            
        }];    
    
}

- (BOOL)supplierTableExist
{
    __block BOOL exist = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *query = [NSString stringWithFormat:@"select * from t_supplier"];
        FMResultSet *rs = [db executeQuery:query];
        exist = rs.next;
    }];
    [_queue close];
    return exist;
}
- (NSArray *)setupMyInstruction
{
    //实验说明书主表
    NSString *instuctionMainSQL = @"create table if not exists t_expinstructionsMain(expinstructionid text primary key,experimentname text,experimentdesc text,experimenttheory text,provideuser text,supplierid text,suppliername text,productnum text,expcategoryid text,expsubcategoryid text,createdate numeric,expversion integer,allowdownload integer,filterstr text,reviewcount integer,downloadcount integer,uploadTime text,editTime text);";
    //实验试剂表
    NSString *expReagentSQL = @"create table if not exists t_expreaget (createMethod text,expInstructionID text,expReagentID text primary key,reagentCommonName text,reagentID text,reagentName text,reagentSpec text,useAmount integer);";
    //实验流程表
    NSString *expProcessSQL = @"create table if not exists t_expProcess (expInstructionID text,expStepDesc text,expStepID text primary key,expStepTime integer,stepNum integer);";
    //实验设备表
    NSString *expEquipmetnSQL = @"create table if not exists t_expEquipment (equipmentID text ,equipmentFactory text,equipmentName text,expEquipmentID text primary key,expInstructionID text);";
    //实验耗材表
    NSString *expConsumableSQL = @"create table if not exists t_expConsumable (consumableCount integer,consumableFactory text,consumableID text,consumableType text,expConsumableID text primary key,expInstructionID text,consumableName text);";
    //试剂表
    NSString *reagentSQL = @"create table if not exists t_reagent(reagentID text primary key,reagentName text,reagentCommonName text,levelOneSortID text,levelTwoSortID text,originalPlace text,productNo text,agents text,specification text,price integer,chemicalName text,CASNo text,arriveDate numeric,memo text)";
    //试剂厂商关联表;                 
    NSString *reagentMapSQL = @"create table if not exists t_reagentMap(reagentMapID text primary key,reagentID text,supplierID text,isSuggestion integer)";
    //耗材表;                     
    NSString *consumableSQL = @"create table if not exists t_consumable(consumableID text primary key,consumableName text,consumableType text)";
    //耗材厂商关联表;                 
    NSString *consumableMapSQL = @"create table if not exists t_consumableMap(consumableMapID text primary key,consumableID text,supplierID text,isSuggestion integer)";
    //设备表;                     
    NSString *equipmentSQL = @"create table if not exists t_equipment (equipmentID text primary key,equipmentName text)";
    //设备厂商关联表;                 
    NSString *equipmentMapSQL = @"create table if not exists t_quipmentMap (equipmentMapID text primary key,equipmentID text,supplierID text ,isSuggestion integer)";
    //供应商
    NSString *supplierSQL = @"create table if not exists t_supplier (supplierID text primary key,supplierName text,supplierType integer,contacts text,telNo text,mobilePhone text,email text,address text)";
    return @[instuctionMainSQL,expReagentSQL,expProcessSQL,expEquipmetnSQL,expConsumableSQL,reagentSQL,reagentMapSQL,consumableSQL,consumableMapSQL,equipmentSQL,equipmentMapSQL,supplierSQL];
}
- (NSArray *)setupMyExp
{
    //我的说明书表
    NSString *myExpInstruction = @"create table if not exists t_myExpInstruction (MyExpInstructionID text,ExpInstructionID text,UserID text,DownloadTime numeric);";
    //我的实验主表
    NSString *myExpSQL = @"create table if not exists t_myExp( MyExpID text primary key, ExpInstructionID text, UserID text, CreateTime numeric, CreateYear integer,CreateMonth  integer, FinishTime numeric, ExpVersion integer, IsReviewed integer,IsCreateReport  integer, IsUpload integer, ReportName text, ReportLocation text,ReportServerPath  text,  ExpState integer,ExpMemo  text);";
    //我的实验试剂表
    NSString *myExpReageneSQL = @"create table if not exists t_myExpReagent( MyExpReagentID text primary key, MyExpID text, ExpInstructionID text,ReagentID  text, SupplierID text);";
    //我的实验耗材表
    NSString *myExpConsumableSQL = @"create table if not exists t_myExpConsumable(MyExpConsumableID text primary key,MyExpID text,ExpInstructionID text,ConsumableID text,SupplierID text);";
    //我的实验设备表
    NSString *myExpEquimentSQL = @"create table if not exists t_myExpEquipment(MyExpEquipmentID text primary key,MyExpID text,ExpInstructionID text,EquipmentID text,SupplierID text);";
    //我的实验步骤表
    NSString *myExpProcessSQL = @"create table if not exists t_myExpProcess( MyExpProcessID text primary key,MyExpID text,ExpInstructionID text,ExpStepID text,StepNum integer,ExpStepDesc text,ExpStepTime integer,IsUseTimer integer,ProcessMemo text,IsActiveStep integer,depositReagent text);";
    //我的实验步骤附件表
    NSString *myExpProcessAttchSQL = @"create table if not exists t_myExpProcessAttch(MyExpProcessAttchID text primary key, MyExpID text,ExpInstructionID text,ExpStepID text,AttchmentName text,AttchmentLocation text,AttchmentServerPath text,IsUpload integer,image blob);";
    //我的实验计划表
    NSString *myExpPlanSQL = @"create table if not exists t_myExpPlan (MyExpPlanID text primary key,UserID text,PlanDate numeric,PlanOfYear integer,PlanOfDate integer,ExpInstructionID text,ExperimentName text);";
    NSArray *sqlArr = @[myExpInstruction,myExpSQL,myExpReageneSQL,myExpConsumableSQL,myExpEquimentSQL,myExpProcessSQL,myExpProcessAttchSQL,myExpPlanSQL];
    return sqlArr;
}

- (void)insertInstruciton:(SXQInstructionData *)instructionData completion:(CompletionHandler)completion
{
//     NSDictionary *expMain = instruction[@"expInstructionMain"];
    SXQExpInstruction *instructionMain = instructionData.expInstructionMain;
    if ([self expInstrucitonExist:instructionMain.expInstructionID]) {
        completion(NO,@{@"msg" :@"说明书已下载"});
        return;
    }
    [_queue inDatabase:^(FMDatabase *db) {
#warning changed
        [self insertIntoInstructionMain:instructionData.expInstructionMain db:db];
        
        NSArray *consumableArr = instructionData.expConsumable;
        [consumableArr enumerateObjectsUsingBlock:^(SXQExpConsumable *expConsumable, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertIntoConsumable:expConsumable database:db];
        }];
        
        NSArray *equipmentArr = instructionData.expEquipment;
        [equipmentArr enumerateObjectsUsingBlock:^(SXQExpEquipment *expEquipment, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertIntoExpEquipment:expEquipment database:db];
        }];
        
        NSArray *expProcessArr = instructionData.expProcess;
        [expProcessArr enumerateObjectsUsingBlock:^(SXQExpStep *expProcess, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertIntoProcess:expProcess database:db];
        }];
        
        NSArray *expReagentArr = instructionData.expReagent;
        [expReagentArr enumerateObjectsUsingBlock:^(SXQExpReagent *expReagent, NSUInteger idx, BOOL * _Nonnull stop) {
            [self insertIntoExpReagent:expReagent dataBase:db];
        }];
    }];
    [_queue close];
    completion(YES,@{@"msg" : @"下载成功"});
}

-(NSString*) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    NSString *resultStr = [result stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(puuid);
    CFRelease(uuidString);
    return resultStr;
}


/**
 * 根据说明书ID取一条说明书纪录
 */
- (SXQExpInstruction *)fetchInstructionWithInstructionID:(NSString *)instructionID db:(FMDatabase *)db;
{
    __block SXQExpInstruction *expInstruction = [SXQExpInstruction new];
        FMResultSet *rs = [db executeQuery:@"select * from t_expinstructionsMain where expinstructionid == ?",instructionID];
        while (rs.next) {
            expInstruction.expInstructionID = [rs stringForColumn:@"expinstructionid"];
            expInstruction.expVersion = [rs intForColumn:@"expversion"];
        }
    return expInstruction;
}
/**
 *  根据说明书ID取实验流程
 *
 */
- (NSArray *)fetchExpProcessWithInstructionID:(NSString *)instructionId db:(FMDatabase *)db
{
    NSMutableArray *stepArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_expProcess where  expInstructionID == ?",instructionId];
    while (rs.next) {
        SXQInstructionStep *step = [SXQInstructionStep new];
        step.expInstructionID = instructionId;
        step.expStepID = [rs stringForColumn:@"expStepID"];
        step.expStepDesc = [rs stringForColumn:@"expStepDesc"];
        step.expStepTime = [rs stringForColumn:@"expStepTime"];
        step.stepNum = [rs intForColumn:@"stepNum"];
        [stepArr addObject:step];
    }
    return [stepArr copy];
    
}
#pragma mark - 根据实验ID获取实验步骤：SXQExpStep
- (NSArray *)fetchExpStepsWithInstructionID:(NSString *)instructionId db:(FMDatabase *)db
{
    NSMutableArray *stepArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_expProcess where  expInstructionID == ?",instructionId];
    while (rs.next) {
        SXQExpStep *step = [SXQExpStep new];
        step.expInstructionID = instructionId;
        step.expStepID = [rs stringForColumn:@"expStepID"];
        step.expStepDesc = [rs stringForColumn:@"expStepDesc"];
        step.expStepTime = [rs stringForColumn:@"expStepTime"];
        step.stepNum = [rs intForColumn:@"stepNum"];
        [stepArr addObject:step];
    }
    return [stepArr copy];
}



- (NSArray *)chechAllInstuction
{
    __block NSArray *resultArr = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        NSMutableArray *tmpArr = [NSMutableArray array];
        FMResultSet *rs = [db executeQuery:@"select * from t_expinstructionsMain"];
        while (rs.next) {
            NSString *expinstructionid = [rs stringForColumn:@"expinstructionid"];
            NSString *experimentname = [rs stringForColumn:@"experimentname"];
            NSString *uploadTime = [rs stringForColumn:@"uploadTime"];
            NSString *editTime = [rs stringForColumn:@"editTime"];
            NSDictionary *instruction =  @{@"expInstructionID" : expinstructionid ,@"experimentName" : experimentname ,@"uploadTime" : uploadTime? :@"",@"editTime":editTime ? :@"" };
            [tmpArr addObject:instruction];
        }
        resultArr = [tmpArr copy];
    }];
    [_queue close];
    
    return resultArr;
}

- (NSArray *)querySupplierWithReagetID:(NSString *)reagentID
{
    __block NSMutableArray *tempArr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
        NSString *supplierID = nil;
        FMResultSet *rs = [db executeQuery:@"select * from t_reagentMap  where reagentID == ?", reagentID];
        while (rs.next) {
            supplierID = [rs stringForColumn:@"supplierID"];
            SXQSupplier *supplier = [self fetchSupplierWithSupplierID:supplierID db:db];
            if (supplier) {
                [tempArr addObject:supplier];
            }
        }
    }];
    [_queue close];
    return [tempArr copy];
//    NSString *supplierSQL = @"create table if not exists t_supplier (supplierID text primary key,supplierName text,supplierType integer,contacts text,telNo text,mobilePhone text,email text,address text)";
    
//    NSString *reagentMapSQL = @"create table if not exists t_reagentMap(reagentMapID text primary key,reagentID text,supplierID text,isSuggestion integer)";
}
- (SXQSupplier *)fetchSupplierWithSupplierID:(NSString *)supplierID db:(FMDatabase *)db
{
   SXQSupplier *supplier = [[SXQSupplier alloc] init];
   FMResultSet *rs = [db executeQuery:@"select * from t_supplier where supplierID == ?",supplierID];
    while (rs.next) {
        supplier.supplierID = [rs stringForColumn:@"supplierID"];
        supplier.supplierName = [rs stringForColumn:@"supplierName"];
        supplier.supplierType = [rs intForColumn:@"supplierType"];
        supplier.contacts = [rs stringForColumn:@"contacts"];
        supplier.telNo = [rs stringForColumn:@"telNo"];
        supplier.mobilePhone = [rs stringForColumn:@"mobilePhone"];
        supplier.eMail = [rs stringForColumn:@"email"];
        supplier.address = [rs stringForColumn:@"address"];
    }
    return supplier;
}
- (void)addExpWithInstructionData:(SXQInstructionData *)instructionData completion:(void (^)(BOOL, SXQExperimentModel *))completion
{
    
    NSString *myExpId = [self uuid];
    __block SXQExperimentModel *experiment = [[SXQExperimentModel alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        //1.write data to t_myExp
        [self insertIntoMyExp:instructionData.expInstructionMain myExpId:myExpId db:db];
        
        //2.write expconsumable to t_myexpconsumable
        [instructionData.expConsumable enumerateObjectsUsingBlock:^(SXQExpConsumable *consumable, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *myExpConsumableID = [self uuid];
            [self insertIntoMyExpConsumable:consumable myExpConsumabelId:myExpConsumableID myExpId:myExpId db:db];
        }];
        
        //3.write expequipment to t_myexpequipment
        [instructionData.expEquipment enumerateObjectsUsingBlock:^(SXQExpEquipment *expEquipment, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *myEquipmentId = [self uuid];
            [self insertIntoMyExpEquipment:expEquipment myExpId:myExpId myEquipmentID:myEquipmentId db:db];
        }];
        
        //4.write expprocess to t_myexpprocess
        [instructionData.expProcess enumerateObjectsUsingBlock:^(SXQExpStep *expProcess, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *myExpProcessID = [self uuid];
            [self insertIntoMyExpProcess:expProcess myExpProcessId:myExpProcessID myExpId:myExpId db:db];
        }];
        
        //5.write expreagent to t_myexpreagent
        [instructionData.expReagent enumerateObjectsUsingBlock:^(SXQExpReagent *reagent, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *myExpReagentId = [self uuid];
            [self insertIntoMyExpReagent:reagent myExpReagentId:myExpReagentId myExpId:myExpId db:db];
        }];
        //6
        experiment = [self fetchExperimentWithMyExpId:myExpId db:db];
    }];
    [_queue close];
    completion(YES,experiment);
}
- (SXQExperimentModel *)fetchExperimentWithMyExpId:(NSString *)myExpId db:(FMDatabase *)db
{
    NSString *querySql = [NSString stringWithFormat:@"select * from t_myExp where MyExpID = '%@'",myExpId];
    FMResultSet *rs = [db executeQuery:querySql];
    SXQExperimentModel *experiment = [[SXQExperimentModel alloc] init];
    while (rs.next) {
        experiment.myExpID = [rs stringForColumn:@"MyExpID"];
        experiment.expState = [rs intForColumn:@"ExpState"];
        experiment.expInstructionID =  [rs stringForColumn:@"ExpInstructionID"];
        experiment.experimentName = [self fetchExperimentNameWithInstructionID:experiment.expInstructionID db:db];
    }
    return experiment;
}
#pragma mark 说明书操作
/**
 *  写入一条数据到流程
 */
- (BOOL)insertIntoProcess:(SXQExpStep *)expProcess database:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_expProcess (expInstructionID ,expStepDesc ,expStepID ,expStepTime ,stepNum ) values ('%@','%@','%@','%@','%d')",expProcess.expInstructionID,expProcess.expStepDesc,expProcess.expStepID,expProcess.expStepTime,expProcess.stepNum];
        success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  写入一条数据到设备表
 */
- (BOOL)insertIntoExpEquipment:(SXQExpEquipment *)equipment database:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into  t_expEquipment (equipmentID ,equipmentFactory ,equipmentName ,expEquipmentID ,expInstructionID ) values ('%@','%@','%@','%@','%@')",equipment.equipmentID,equipment.equipmentFactory,equipment.equipmentName,equipment.equipmentID,equipment.expInstructionID];
        success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  写入一条数据到说明书试剂表
 */
- (BOOL)insertIntoExpReagent:(SXQExpReagent *)expReagent dataBase:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_expreaget (createMethod,expInstructionID ,expReagentID ,reagentCommonName,reagentID ,reagentName ,reagentSpec ,useAmount) values ('%@','%@','%@','%@','%@','%@','%@','%d')",expReagent.createMethod,expReagent.expInstructionID,expReagent.expReagentID,expReagent.reagentCommonName,expReagent.reagentID,expReagent.reagentName,expReagent.reagentSpec,expReagent.useAmount   ];
            success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  写入一条数据到耗材表
 */
- (BOOL)insertIntoConsumable:(SXQExpConsumable *)consumable database:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_expConsumable (consumableCount ,consumableFactory ,consumableID,consumableType,expConsumableID,expInstructionID,consumableName) values ('%d','%@','%@','%@','%@','%@','%@')",consumable.consumableCount,consumable.consumableFactory,consumable.consumableID,consumable.consumableType,consumable.expConsumableID,consumable.expInstructionID,consumable.consumableName];
    
    success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  写入一条数据到说明书主表
 */
- (BOOL)insertIntoInstructionMain:(SXQExpInstruction *)expInstruction db:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_expinstructionsMain (expinstructionid ,experimentname ,experimentdesc ,experimenttheory ,provideuser ,supplierid ,suppliername ,productnum ,expcategoryid ,expsubcategoryid ,createdate ,expversion ,allowdownload ,filterstr ,reviewcount ,downloadcount) values('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%d','%@','%@','%@','%@')",expInstruction.expInstructionID,expInstruction.experimentName,expInstruction.experimentDesc,expInstruction.experimentTheory,expInstruction.provideUser,expInstruction.supplierID,expInstruction.supplierName,expInstruction.productNum,expInstruction.expCategoryID,expInstruction.expSubCategoryID,expInstruction.createDate,expInstruction.expVersion,expInstruction.allowDownload,expInstruction.filterStr,expInstruction.reviewCount,expInstruction.downloadCount];
    success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  说明书是否已存在
 *
 */
- (BOOL)expInstrucitonExist:(NSString *)expInstructionID
{
    __block BOOL exist = NO;
    NSString *query = [NSString stringWithFormat:@"SELECT t_expinstructionsMain.expinstructionid FROM t_expinstructionsMain WHERE expinstructionid == '%@'",expInstructionID];
    [_queue  inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:query];
        exist = rs.next;
    }];
    [_queue close];
    return exist;
}
#pragma mark 我的实验操作
/**
 * 写一条纪录到我的实验步骤
 */
- (BOOL)addMyExpProcessInstructionID:(NSString *)instructionID myExpId:(NSString *)expID db:(FMDatabase *)db
{
    NSArray *stepArr = [self fetchExpProcessWithInstructionID:instructionID db:db];
    [stepArr enumerateObjectsUsingBlock:^(SXQInstructionStep *step, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *addExpProcessSql = [NSString stringWithFormat:@"insert into t_myExpProcess (MyExpProcessID ,MyExpID ,ExpInstructionID ,ExpStepID ,StepNum ,ExpStepDesc ,ExpStepTime ,IsUseTimer ,ProcessMemo ,IsActiveStep) values ('%@','%@','%@','%@','%@','%@','%@','%d','%@','%d')",[self uuid],expID,step.expInstructionID,step.expStepID,step.stepNum,step.expStepDesc,@"",0,@"",0];
        [db executeUpdate:addExpProcessSql];
    }];
    return NO;
}
/**
 *  写一条纪录到我的实验主表
 *
 */
- (BOOL)insertIntoMyExp:(SXQExpInstruction *)instruciton myExpId:(NSString *)myExpId db:(FMDatabase *)db;
{
    BOOL success = NO;
#warning userid
     NSString *addMyExpSql = [NSString stringWithFormat:@"insert into t_myExp ( MyExpID , ExpInstructionID , UserID , CreateTime , CreateYear,CreateMonth , FinishTime , ExpVersion , IsReviewed ,IsCreateReport  , IsUpload , ReportName , ReportLocation ,ReportServerPath ,  ExpState ,ExpMemo ) values('%@','%@','%@','%@','%@','%@','%@','%d','%d','%d','%d','%@','%@','%@','%d','%@')",myExpId,instruciton.expInstructionID,@"4028c681494b994701494b99aba50000",[NSString dw_currentDate],[NSString dw_year],[NSString dw_month],@"",instruciton.expVersion,0,0,0,@"",@"",@"",0,@""];
    success = [db executeUpdate:addMyExpSql];
    return success;
}
/**
 *  添加我的实验耗材
 *
 */
- (BOOL)insertIntoMyExpConsumable:(SXQExpConsumable *)consumable myExpConsumabelId:(NSString *)myExpConsumaleId myExpId:(NSString *)myExpId db:(FMDatabase *)db
{
    BOOL success = NO;
#warning supplierID
    NSString *addConsumableSql = [NSString stringWithFormat:@"insert into t_myExpConsumable(MyExpConsumableID ,MyExpID,ExpInstructionID,ConsumableID,SupplierID) values ('%@','%@','%@','%@','%@')",myExpConsumaleId,myExpId,consumable.expInstructionID,consumable.consumableID,consumable.supplierID];
    success = [db executeUpdate:addConsumableSql];
    return success;
}
/**
 *  添加我的实验试剂
 */
- (BOOL)insertIntoMyExpReagent:(SXQExpReagent *)expReagent myExpReagentId:(NSString *)myExpReagentId myExpId:(NSString *)myExpId db:(FMDatabase *)db
{
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_myExpReagent( MyExpReagentID, MyExpID, ExpInstructionID,ReagentID, SupplierID) values ('%@','%@','%@','%@','%@')",myExpReagentId,myExpId,expReagent.expInstructionID,expReagent.reagentID,expReagent.supplierId];
    return [db executeUpdate:insertSql];
}
/**
 *  添加我的实验设备
 *
 */
- (BOOL)insertIntoMyExpEquipment:(SXQExpEquipment *)equipment myExpId:(NSString *)myExpId  myEquipmentID:(NSString *)myEquipmentId db:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *addMyExpEquipmentSql = [NSString stringWithFormat:@"insert into t_myExpEquipment(MyExpEquipmentID ,MyExpID,ExpInstructionID,EquipmentID,SupplierID) values ('%@','%@','%@','%@','%@')",myEquipmentId,myExpId,equipment.expInstructionID,equipment.equipmentID,equipment.supplierId];
    [db executeUpdate:addMyExpEquipmentSql];
    return success;
}
/**
 *  添加我的实验步骤
 */
- (BOOL)insertIntoMyExpProcess:(SXQExpStep *)expProcess myExpProcessId:(NSString *)myExpProcesId myExpId:(NSString *)myExpId db:(FMDatabase *)db
{
    BOOL success = NO;
    NSString *insertSql = [NSString stringWithFormat:@"insert into  t_myExpProcess(MyExpProcessID,MyExpID,ExpInstructionID,ExpStepID,StepNum,ExpStepDesc,ExpStepTime,IsUseTimer,ProcessMemo,IsActiveStep) values ('%@','%@','%@','%@','%d','%@','%@','%d','%@','%d')",myExpProcesId,myExpId,expProcess.expInstructionID,expProcess.expStepID,expProcess.stepNum,expProcess.expStepDesc,expProcess.expStepTime,expProcess.isUserTimer,expProcess.processMemo ? : @"",expProcess.isActiveStep];
    success = [db executeUpdate:insertSql];
    return success;
}
/**
 *  根据实验id,实验步骤ID，写入一条备注
 */
- (BOOL)writeRemark:(NSString *)remark withExpId:(NSString *)expId expProcessID:(NSString *)expProcessId
{
    __block BOOL success = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:@"select * from t_myExpProcess where MyExpID == ?and MyExpProcessID == ?",expId,expProcessId];
        while (rs.next) {
            success = [db executeUpdate:@"update t_myExpProcess set ProcessMemo=? where MyExpID == ?and MyExpProcessID == ?",remark,expId,expProcessId];
        }
    }];
    [_queue close];
    return success;
}
/**
 *  我的实验是否已存在
 *
 */
- (BOOL)myExpExist:(NSString *)expId
{
    __block BOOL exist = NO;
    [_queue inDatabase:^(FMDatabase *db) {
         FMResultSet *rs = [db executeQuery:@"SELECT t_myExp.MyExpID FROM t_myExp WHERE MyExpID == ?",expId];
        exist = rs.next; 
    }];
    [_queue close];
    return exist;
}
- (void)loadCurrentDataWithMyExpId:(NSString *)myExpId completion:(void (^)(SXQCurrentExperimentData *))completioin
{
    [_queue inDatabase:^(FMDatabase *db) {
        
        // 去我的实验表找到实验，创建SXQMyexpEriment
        SXQMyExperiment *myExperiment = [self fetchMyExpWithMyExpId:myExpId db:db];
        //我的实验步骤表找到实验步骤数组
        NSArray *expProcess = [self fetchExpProcessesWithMyExpID:myExpId db:db];
        SXQCurrentExperimentData *currentExprimentData = [SXQCurrentExperimentData currentExprimentDataWith:myExperiment expProcesses:expProcess];
        completioin(currentExprimentData);
    }];
    [_queue close];
}
- (NSArray *)fetchExpProcessesWithMyExpID:(NSString *)myExpId db:(FMDatabase *)db
{
    if (myExpId == nil) {
        return nil;
    }
    NSMutableArray *tmpArr =  [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from  t_myExpProcess where MyExpID = ?",myExpId];
    while (rs.next) {
        SXQExpStep *expProcess = [[SXQExpStep alloc] init];
        expProcess.expInstructionID = [rs stringForColumn:@"ExpInstructionID"];
        expProcess.myExpProcessId = [rs stringForColumn:@"MyExpProcessID"];
        expProcess.expStepID = [rs stringForColumn:@"ExpStepID"];
        expProcess.stepNum = [rs intForColumn:@"StepNum"];
        expProcess.expStepDesc = [rs stringForColumn:@"ExpStepDesc"];
        expProcess.expStepTime = [rs stringForColumn:@"ExpStepTime"];
        expProcess.isUserTimer = [rs boolForColumn:@"IsUseTimer"];
        expProcess.processMemo = [rs stringForColumn:@"ProcessMemo"];
        expProcess.isActiveStep = [rs boolForColumn:@"IsActiveStep"];
        expProcess.depositReagent = [rs stringForColumn:@"depositReagent"];
        expProcess.images = [self fetchImageWithMyExpId:myExpId expStepId:expProcess.expStepID db:db];
        [tmpArr addObject:expProcess];
    }
    return [tmpArr copy];
    
}
- (SXQMyExperiment *)fetchMyExpWithMyExpId:(NSString *)myExpId db:(FMDatabase *)db
{
    if(myExpId == nil)
    {
        return nil;
    }
    SXQMyExperiment *myExperiment = [[SXQMyExperiment alloc] init];
    FMResultSet *rs = [db executeQuery:@"select * from t_myExp where MyExpID = ?",myExpId];
    while (rs.next) {
        myExperiment.myExpId = [rs stringForColumn:@"MyExpID"];
        myExperiment.expInstructionId = [rs stringForColumn:@"ExpInstructionID"];
        myExperiment.userId = [rs stringForColumn:@"UserID"];
        myExperiment.createTime = [rs stringForColumn:@"CreateTime"];
        myExperiment.finishTime = [rs stringForColumn:@"FinishTime"];
        myExperiment.isReviewed = [rs boolForColumn:@"IsReviewed"];
        myExperiment.isCreateReport = [rs boolForColumn:@"IsCreateReport"];
        myExperiment.isUpload = [rs boolForColumn:@"IsUpload"];
        myExperiment.reportName = [rs stringForColumn:@"ReportName"];
        myExperiment.reportLocation = [rs stringForColumn:@"ReportLocation"];
        myExperiment.reportServerPath = [rs stringForColumn:@"ReportServerPath"];
        myExperiment.expState = [rs intForColumn:@"ExpState"];
        myExperiment.expMemo = [rs stringForColumn:@"ExpMemo"];
    }
    return myExperiment;
}
#pragma 写入实验备注
- (void)updateMyExpProcessMemoWithExpProcessID:(NSString *)myExpProcessId processMemo:(NSString *)memo
{
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"update t_myExpProcess set ProcessMemo = ? where MyExpProcessID = ?",memo,myExpProcessId];
    }];
    [_queue close];
}
#pragma mark 添加图片
//    NSString *myExpProcessAttchSQL = @"create table if not exists t_myExpProcessAttch(MyExpProcessAttchID text primary key, MyExpID text,ExpInstructionID text,ExpStepID text,AttchmentName text,AttchmentLocation text,AttchmentServerPath text,IsUpload integer,image blob);";
- (void)addImageWithMyExpId:(NSString *)myExpId expInstructionId:(NSString *)expInstructionId expStepId:(NSString *)expStepId image:(UIImage *)image
{
    NSData *imageData = [NSKeyedArchiver archivedDataWithRootObject:image];
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"insert into t_myExpProcessAttch (image,MyExpID,ExpInstructionID,ExpStepID,MyExpProcessAttchID) values (?,?,?,?,?)",imageData,myExpId,expInstructionId,expStepId,[self uuid]];
    }];
    [_queue close];
}
#pragma mark 获取图片
- (NSMutableArray *)fetchImageWithMyExpId:(NSString *)myExpId expStepId:(NSString *)expStepId db:(FMDatabase *)db
{
    if (myExpId == nil || expStepId == nil) {
        return nil;
    }
    NSMutableArray *imageArr = [NSMutableArray array];
    NSString *querySql = [NSString stringWithFormat:@"select image from t_myExpProcessAttch where MyExpID = '%@' and ExpStepID = '%@'",myExpId,expStepId];
    FMResultSet *rs = [db executeQuery:querySql];
    while (rs.next) {
        NSData *imageData = [rs dataForColumn:@"image"];
        UIImage *image = [NSKeyedUnarchiver unarchiveObjectWithData:imageData];
        [imageArr addObject:image];
    }
    return imageArr;
    
}
#pragma mark Supplier Method
- (void)insertEquipment:(SXQEquipment *)equipment db:(FMDatabase *)db
{
//    NSString *equipmentSQL = @"create table if not exists t_equipment (equipmentID text primary key,equipmentName text)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_equipment (equipmentID ,equipmentName) values ('%@','%@')",equipment.equipmentID,equipment.equipmentName];
    [db executeUpdate:insertSql];
}
- (void)insertEquipmentMap:(SXQEquipmentMap *)equipmentMap db:(FMDatabase *)db
{
//    NSString *equipmentMapSQL = @"create table if not exists t_quipmentMap (quipmentMapID text primary key,equipmentID text,supplierID text ,isSuggestion integer)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_quipmentMap (equipmentMapID,equipmentID,supplierID,isSuggestion) values ('%@','%@','%@','%d')",equipmentMap.equipmentMapID,equipmentMap.equipmentID,equipmentMap.supplierID,equipmentMap.isSuggestion];
    [db executeUpdate:insertSql];
}
- (void)insertConsumable:(SXQConsumable *)consumable db:(FMDatabase *)db
{
//    NSString *consumableSQL = @"create table if not exists t_consumable(consumableID text primary key,consumableName text,consumableType text)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_consumable (consumableID,consumableName,consumableType) values ('%@','%@','%@')",consumable.consumableID,consumable.consumableName,consumable.consumableType];
    [db executeUpdate:insertSql];
}
- (void)insertConsumableMap:(SXQConsumableMap *)consumableMap db:(FMDatabase *)db
{
//    NSString *consumableMapSQL = @"create table if not exists t_consumableMap(consumableMapID text primary key,consumableID text,supplierID text,isSuggestion integer)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_consumableMap(consumableMapID,consumableID,supplierID,isSuggestion) values ('%@','%@','%@','%d')",consumableMap.consumableMapID,consumableMap.consumableID,consumableMap.supplierID,consumableMap.isSuggestion];
    [db executeUpdate:insertSql];
}
- (void)insertReagent:(SXQReagent *)reagent db:(FMDatabase *)db
{
//    NSString *reagentSQL = @"create table if not exists t_reagent(reagentID text primary key,reagentName text,reagentCommonName text,levelOneSortID text,levelTwoSortID text,originalPlace text,productNo text,agents text,specification text,price integer,chemicalName text,CASNo text,arriveDate numeric,memo text)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_reagent (reagentID,reagentName ,reagentCommonName ,levelOneSortID ,levelTwoSortID ,originalPlace ,productNo,agents,specification ,price,chemicalName ,CASNo ,arriveDate ,memo) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",reagent.reagentID,reagent.reagentName,reagent.reagentCommonName,reagent.levelOneSortID,reagent.levelTwoSortID,reagent.originPlace,reagent.productNo,reagent.agents,reagent.specification,reagent.price,reagent.chemicalName,reagent.casNo,reagent.arrivalDate,reagent.memo];
    [db executeUpdate:insertSql];
   
}
- (void)insertReagentMap:(SXQReagentMap *)reagentMap db:(FMDatabase *)db
{
//    NSString *reagentMapSQL = @"create table if not exists t_reagentMap(reagentMapID text primary key,reagentID text,supplierID text,isSuggestion integer)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_reagentMap (reagentMapID ,reagentID ,supplierID,isSuggestion) values ('%@','%@','%@','%d')",reagentMap.reagentMapID,reagentMap.reagentID,reagentMap.supplierID,reagentMap.isSuggestion];
    [db executeUpdate:insertSql];
    
}
- (void)insertSupplier:(SXQSupplier *)supplier db:(FMDatabase *)db
{
//    NSString *supplierSQL = @"create table if not exists t_supplier (supplierID text primary key,supplierName text,supplierType integer,contacts text,telNo text,mobilePhone text,email text,address text)";
    NSString *insertSql = [NSString stringWithFormat:@"insert into t_supplier (supplierID ,supplierName ,supplierType ,contacts ,telNo ,mobilePhone ,email ,address ) values ('%@','%@','%d','%@','%@','%@','%@','%@')",supplier.supplierID,supplier.supplierName,supplier.supplierType,supplier.contacts,supplier.telNo,supplier.mobilePhone,supplier.eMail,supplier.address];
    [db executeUpdate:insertSql];
    
}

#pragma mark 根据试剂ID找到所有对应厂商
- (NSArray *)fetchSuppliersWithReagent:(SXQExpReagent *)reagent db:(FMDatabase *)db
{
    NSString *mapSql = [NSString stringWithFormat:@"select * from t_reagentMap where reagentID = '%@'",reagent.reagentID];
    FMResultSet *mapRs = [db executeQuery:mapSql];
    NSMutableArray *mapArr = [NSMutableArray array];
    while (mapRs.next) {
        SXQReagentMap *reagentMap = [[SXQReagentMap alloc] init];
        reagentMap.reagentMapID = [mapRs stringForColumn:@"reagentMapID"];
        reagentMap.supplierID = [mapRs stringForColumn:@"supplierID"];
        reagentMap.reagentID = [mapRs stringForColumn:@"reagentID"];
        reagentMap.isSuggestion = [mapRs boolForColumn:@"isSuggestion"];
        [mapArr addObject:reagentMap];
    }
    NSMutableArray *supplierArr = [NSMutableArray array];
    [mapArr enumerateObjectsUsingBlock:^(SXQReagentMap *reagentMap, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *supplierSql = [NSString stringWithFormat:@"select * from t_supplier where supplierID = '%@'",reagentMap.supplierID];
        FMResultSet *supplierRs = [db executeQuery:supplierSql];
        while (supplierRs.next) {
            SXQSupplier *supplier = [[SXQSupplier alloc] init];
            supplier.supplierID = reagentMap.supplierID;
            supplier.supplierName = [supplierRs stringForColumn:@"supplierName"];
            supplier.supplierType = [supplierRs intForColumn:@"supplierType"];
            supplier.contacts = [supplierRs stringForColumn:@"contacts"];
            supplier.telNo = [supplierRs stringForColumn:@"telNo"];
            supplier.mobilePhone = [supplierRs stringForColumn:@"mobilePhone"];
            supplier.eMail = [supplierRs stringForColumn:@"email"];
            supplier.address = [supplierRs stringForColumn:@"address"];
            if (reagentMap.isSuggestion) {
                reagent.preferSupplier = supplier;
            }
            [supplierArr addObject:supplier];    
        }
        
    }];
    return [supplierArr copy];
}
#pragma mark 根据设备查找厂商
- (NSArray *)fetchSuppliersWithEquipment:(SXQExpEquipment *)equipment db:(FMDatabase *)db
{
    NSString *mapSql = [NSString stringWithFormat:@"select * from t_quipmentMap where  equipmentID = '%@'",equipment.equipmentID];
    FMResultSet *mapRs = [db executeQuery:mapSql];
    NSMutableArray *mapArr = [NSMutableArray array];
    while (mapRs.next) {
        SXQEquipmentMap *equipMap = [[SXQEquipmentMap alloc] init];
        equipMap.equipmentMapID = [mapRs stringForColumn:@"equipmentMapID"];
        equipMap.equipmentID = [mapRs stringForColumn:@"equipmentID"];
        equipMap.supplierID = [mapRs stringForColumn:@"supplierID"];
        equipMap.isSuggestion = [mapRs boolForColumn:@"isSuggestion"];
        [mapArr addObject:equipMap];
    }
    NSMutableArray *supplierArr = [NSMutableArray array];
    [mapArr enumerateObjectsUsingBlock:^(SXQEquipmentMap *equipmentMap, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *supplierSql = [NSString stringWithFormat:@"select * from t_supplier where supplierID = '%@'",equipmentMap.supplierID];
        FMResultSet *supplierRs = [db executeQuery:supplierSql];
        while (supplierRs.next) {
            SXQSupplier *supplier = [[SXQSupplier alloc] init];
            supplier.supplierID = equipmentMap.supplierID;
            supplier.supplierName = [supplierRs stringForColumn:@"supplierName"];
            supplier.supplierType = [supplierRs intForColumn:@"supplierType"];
            supplier.contacts = [supplierRs stringForColumn:@"contacts"];
            supplier.telNo = [supplierRs stringForColumn:@"telNo"];
            supplier.mobilePhone = [supplierRs stringForColumn:@"mobilePhone"];
            supplier.eMail = [supplierRs stringForColumn:@"email"];
            supplier.address = [supplierRs stringForColumn:@"address"];
            if (equipmentMap.isSuggestion) {
                equipment.preferSupplier = supplier;
            }
            [supplierArr addObject:supplier];
        }
        
    }];
    return [supplierArr copy];
}
#pragma mark 根据耗材找厂商
- (NSArray *)fetchSuppliersWithConsumable:(SXQExpConsumable *)consumable db:(FMDatabase *)db
{
//    create table if not exists t_consumableMap(consumableMapID text primary key,consumableID text,supplierID text,isSuggestion integer)
    NSString *mapSql = [NSString stringWithFormat:@"select * from t_consumableMap where consumableID = '%@'",consumable.consumableID];
    FMResultSet *mapRs = [db executeQuery:mapSql];
    NSMutableArray *mapArr = [NSMutableArray array];
    while (mapRs.next) {
        SXQConsumableMap *consumableMap = [[SXQConsumableMap alloc] init];
        consumableMap.consumableMapID = [mapRs stringForColumn:@"consumableMapID"];
        consumableMap.consumableID = [mapRs stringForColumn:@"consumableID"];
        consumableMap.supplierID = [mapRs stringForColumn:@"supplierID"];
        consumableMap.isSuggestion = [mapRs boolForColumn:@"isSuggestion"];
        [mapArr addObject:consumableMap];
    }
    NSMutableArray *supplierArr = [NSMutableArray array];
    [mapArr enumerateObjectsUsingBlock:^(SXQConsumableMap *consumableMap, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *supplierSql = [NSString stringWithFormat:@"select * from t_supplier where supplierID = '%@'",consumableMap.supplierID];
        FMResultSet *supplierRs = [db executeQuery:supplierSql];
        while (supplierRs.next) {
            SXQSupplier *supplier = [[SXQSupplier alloc] init];
            supplier.supplierID = consumableMap.supplierID;
            supplier.supplierName = [supplierRs stringForColumn:@"supplierName"];
            supplier.supplierType = [supplierRs intForColumn:@"supplierType"];
            supplier.contacts = [supplierRs stringForColumn:@"contacts"];
            supplier.telNo = [supplierRs stringForColumn:@"telNo"];
            supplier.mobilePhone = [supplierRs stringForColumn:@"mobilePhone"];
            supplier.eMail = [supplierRs stringForColumn:@"email"];
            supplier.address = [supplierRs stringForColumn:@"address"];
            if (consumableMap.isSuggestion) {
                consumable.preferSupplier = supplier;
            }
            [supplierArr addObject:supplier];
        }
        
    }];
    return [supplierArr copy];
}
#pragma mark 根据说明书找到试剂
- (NSArray *)fetchReagentsWithExpInstructionID:(NSString *)expInstructionId db:(FMDatabase *)db
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_expreaget where expInstructionID = ?",expInstructionId];
    while (rs.next) {
        SXQExpReagent *expReagent = [[SXQExpReagent alloc] init];
        expReagent.createMethod = [rs stringForColumn:@"createMethod"];
        expReagent.expInstructionID = expInstructionId;
        expReagent.expReagentID = [rs stringForColumn:@"expReagentID"];
        expReagent.reagentCommonName = [rs stringForColumn:@"reagentCommonName"];
        expReagent.reagentID = [rs stringForColumn:@"reagentID"];
        expReagent.reagentName = [rs stringForColumn:@"reagentName"];
        expReagent.reagentSpec = [rs stringForColumn:@"reagentSpec"];
        expReagent.useAmount = [rs intForColumn:@"useAmount"];
        
        expReagent.suppliers = [self fetchSuppliersWithReagent:expReagent db:db];
        
        [tmpArr addObject:expReagent];
    }
    return [tmpArr copy];
}
#pragma mark - 根据说明书找到设备
- (NSArray *)fetchEquipmentWithInstructionID:(NSString *)expInstructionID db:(FMDatabase *)db
{
    NSMutableArray *tmpArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_expEquipment where expInstructionID = ?",expInstructionID];
    while (rs.next) {
//    NSString *expEquipmetnSQL = @"create table if not exists t_expEquipment (equipmentID text ,equipmentFactory text,equipmentName text,expEquipmentID text primary key,expInstructionID text);";
        SXQExpEquipment *equipment = [[SXQExpEquipment alloc] init];
        equipment.equipmentID = [rs stringForColumn:@"equipmentID"];
        equipment.equipmentFactory = [rs stringForColumn:@"equipmentFactory"];
        equipment.equipmentName = [rs stringForColumn:@"equipmentName"];
        equipment.expEquipmentID = [rs stringForColumn:@"expEquipmentID"];
        equipment.expInstructionID = [rs stringForColumn:@"expInstructionID"];
        
        equipment.suppliers = [self fetchSuppliersWithEquipment:equipment db:db];
        [tmpArr addObject:equipment];
    }
    return [tmpArr copy];
}
#pragma mark - 根据说明书找耗材
- (NSArray *)fetchConsumableWithInstructionID:(NSString *)instructionID db:(FMDatabase *)db
{
//    NSString *expConsumableSQL = @"create table if not exists t_expConsumable (consumableCount integer,consumableFactory text,consumableID text,consumableType text,expConsumableID text primary key,expInstructionID text,consumableName text);";
    NSMutableArray *tmpArr = [NSMutableArray array];
    FMResultSet *rs = [db executeQuery:@"select * from t_expConsumable where expInstructionID = ?",instructionID];
    while (rs.next) {
        SXQExpConsumable *consumable = [[SXQExpConsumable alloc] init];
        consumable.consumableCount = [rs intForColumn:@"consumableCount"];
        consumable.consumableFactory = [rs stringForColumn:@"consumableFactory"];
        consumable.consumableID = [rs stringForColumn:@"consumableID"];
        consumable.consumableType = [rs stringForColumn:@"consumableType"];
        consumable.expConsumableID = [rs stringForColumn:@"expConsumableID"];
        consumable.expInstructionID = instructionID;
        consumable.consumableName = [rs stringForColumn:@"consumableName"];
        
        consumable.suppliers = [self fetchSuppliersWithConsumable:consumable db:db];
        [tmpArr addObject:consumable];
    }
    return [tmpArr copy];
}
#pragma mark - 根据说明书找到实验的相关数据
/**
 *   根据说明书着到实验的相关数据
 *
 *
 *  @return (试剂，耗材，设备)
 */
- (SXQInstructionData *)fetchInstuctionDataWithInstructionID:(NSString *)instructionID
{
    __block SXQInstructionData *instructionData = [[SXQInstructionData alloc] init];
    [_queue inDatabase:^(FMDatabase *db) {
        instructionData.expEquipment = [self fetchEquipmentWithInstructionID:instructionID db:db];
        instructionData.expReagent = [self fetchReagentsWithExpInstructionID:instructionID db:db];
        instructionData.expConsumable  = [self fetchConsumableWithInstructionID:instructionID db:db];
        instructionData.expProcess = [self fetchExpStepsWithInstructionID:instructionID db:db];
        instructionData.expInstructionMain = [self fetchInstructionWithInstructionID:instructionID db:db];
    }];
    [_queue close];
    return instructionData;
}
#pragma  mark 获取正在进行的实验
- (NSArray *)fetchOnDoingExperiment
{
    __block NSMutableArray *tmpArr = [NSMutableArray array];
    [_queue inDatabase:^(FMDatabase *db) {
//    NSString *myExpSQL = @"create table if not exists t_myExp( MyExpID text primary key, ExpInstructionID text, UserID text, CreateTime numeric, CreateYear integer,CreateMonth  integer, FinishTime numeric, ExpVersion integer, IsReviewed integer,IsCreateReport  integer, IsUpload integer, ReportName text, ReportLocation text,ReportServerPath  text,  ExpState integer,ExpMemo  text);";
        int state = 0;
        NSString *querySql = [NSString stringWithFormat:@"select * from t_myExp where ExpState = '%d'",state];
        FMResultSet *rs = [db executeQuery:querySql];
        while (rs.next) {
            SXQExperimentModel *experiment = [[SXQExperimentModel alloc] init];
            experiment.myExpID = [rs stringForColumn:@"MyExpID"];
            experiment.expState = [rs intForColumn:@"ExpState"];
            experiment.expInstructionID =  [rs stringForColumn:@"ExpInstructionID"];
            experiment.experimentName = [self fetchExperimentNameWithInstructionID:experiment.expInstructionID db:db];
            [tmpArr addObject:experiment];
        }
    }];
    [_queue close];
    return tmpArr;
}
- (NSString *)fetchExperimentNameWithInstructionID:(NSString *)instructionID db:(FMDatabase *)db
{
    NSString *querySql = [NSString stringWithFormat:@"select experimentname from t_expinstructionsMain where expinstructionid = '%@'",instructionID];
    NSString *experimentName = nil;
    FMResultSet *rs = [db executeQuery:querySql];
    while (rs.next) {
        experimentName = [rs stringForColumn:@"experimentname"];
    }
    return experimentName;
}
@end




