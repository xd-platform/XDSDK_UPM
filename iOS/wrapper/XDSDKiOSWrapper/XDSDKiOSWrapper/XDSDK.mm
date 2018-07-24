

#import "XDSDK.h"

#import <XdComPlatform/XDCore.h>

#import <XdComPlatform/XDWXShare.h>

@interface XDSDK ()<XDCallback,XDWXShareCallback>

@property (nonatomic,copy,nonnull)NSString* gameObjectName;

@end

@implementation XDSDK

static XDSDK * instance;

# pragma mark - XDSDKWrapperSettings

/**
 Instacne

 @return XDSDK
 */
+ (instancetype)defaultInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[XDSDK alloc] init];
    });
    
    return instance;
}


/**
 设置GameObject

 @param gameObject GameObjectName
 */
+ (void)setGameObject:(nonnull NSString*)gameObject{
    
    if (!gameObject ||![gameObject isKindOfClass:[NSString class]]) {
        
        return;
    }
    
    [[XDSDK defaultInstance] setGameObjectName:gameObject];
}

+ (int)getShareType:(NSString*)shareType{
    
    if ([shareType isEqualToString:@"TEXT"]) {
        
        return 0;
    
    }else if ([shareType isEqualToString:@"IMAGE"]){
        
        return 1;
    
    }else if ([shareType isEqualToString:@"MUSIC"]){
        
        return 2;
    
    }else if ([shareType isEqualToString:@"VIDEO"]){
        
        return 3;
    
    }else if ([shareType isEqualToString:@"WEB"]){
        
        return 4;
    }
    
    return 0;
}

+ (int)getShareScene:(NSString*)shareScene{
    
    if ([shareScene isEqualToString:@"SESSION"]) {
        
        return 0;
    
    }else if ([shareScene isEqualToString:@"TIMELINE"]){
        
        return 1;
    
    }else if ([shareScene isEqualToString:@"FAVOURITE"]){
        
        return 2;
    }

    return 0;
}

#if defined(__cplusplus)
extern "C"{
#endif
    extern void UnitySendMessage(const char *, const char *, const char *);
#if defined(__cplusplus)
}
#endif

# pragma mark - XDSDKWrapper

#if __cplusplus
    extern "C" {
#endif
        
        void initXDSDK(const char* appid,int orientation,const char* channel, const char* version, bool enableTapdb){
            
            XDSDK * sdk = [XDSDK defaultInstance];
            
            [XDSDK setGameObject:@"XDSDK"];
            
            [XDCore setCallBack:sdk];
            
            [XDCore init:[NSString stringWithUTF8String:appid] orientation:orientation channel:[NSString stringWithUTF8String:channel] version:[NSString stringWithUTF8String:version] enableTapdb:enableTapdb];
        }
        
        void initSDK(const char* appid,int orientation){
            
            XDSDK * sdk = [XDSDK defaultInstance];
            
            [XDSDK setGameObject:@"XDSDK"];
            
            [XDCore setCallBack:sdk];
            
            [XDCore init:[NSString stringWithUTF8String:appid] orientation:orientation];
        }
        
        void xdLogin(){
            
            [XDCore login];
        }
        
        void xdLogout(){
            
            [XDCore logout];
        }
        
        bool openUserCenter(){
            
            return [XDCore openUserCenter];
        }
        
        void setServer (const char* server){
            [XDCore setServer:[NSString stringWithUTF8String:server]];
        }
        
        void setLevel (int level) {
            [XDCore setLevel:level];
        }
        
        void openRealName () {
            [XDCore openRealName];
        }
        
        bool isXdLoggedIn(){
            return [XDCore isLoggedIn];
        }
        
        void xdPay(const char* product_name, const char* product_id, const char* product_price,const char* sid,const char* role_id,const char* orderid,const char* ext){
            
            [XDCore requestProduct:@{
                          @"Product_Name":[NSString stringWithUTF8String:product_name?product_name:"Product_Name"],
                          @"Product_Id":[NSString stringWithUTF8String:product_id?product_id:"Product_Id"],
                          @"Product_Price":[NSString stringWithUTF8String:product_price?product_price:"Product_Price"],
                          @"Sid":[NSString stringWithUTF8String:sid?sid:"Sid"],
                          @"Role_Id":[NSString stringWithUTF8String:role_id?role_id:"Role_Id"],
                          @"Order_Id":[NSString stringWithUTF8String:orderid?orderid:"Order_Id"],
                          @"EXT":[NSString stringWithUTF8String:ext?ext:"EXT"],
                          }];
        }
        
        const char* getXDSDKVersion(){
            
            const char* version = [XDCore getSDKVersion].UTF8String;
            
            return strdup(version);
        }
        
        const char* getXDAccessToken(){
            
            const char* token = [XDCore getAccessToken].UTF8String;
            
            if(!token){
                
                return strdup("");
            }
            
            return strdup(token);
        }
        
        void hideGuest(){
            
            NSLog(@"隐藏游客");
            
            [XDCore hideGuest];
        }
        
        void userFeedback(){
            
            NSLog(@"用户反馈");
            
            [XDCore userFeedback];
        }
        
        void hideTapTap(){
            
            NSLog(@"隐藏TapTap");
            
            [XDCore hideTapTap];
        }
        
        void hideQQ(){
            
            NSLog(@"隐藏QQ");

            [XDCore hideQQ];
        }
        
        void setLoginEntries(const char* entries[],int length){
            
            NSLog(@"设置登录按钮顺序");
            
            NSMutableArray *loginEntries = [NSMutableArray array];
            for(int  index = 0;index < length; index++){
                NSString *loginName = [NSString stringWithUTF8String:entries[index]];
                [loginEntries addObject:loginName];
            }

            [XDCore setLoginEntries:loginEntries];
        }
        
        void hideWeiChat(){
            
            NSLog(@"隐藏微信");

            [XDCore hideWX];
        }
        
        void showVC(){
            
            NSLog(@"显示VC");
            
            [XDCore showVC];
        }
        
        void setQQWeb(){
            
            NSLog(@"QQ Web");
            
            [XDCore setQQWeb];
        }
        
        void setWXWeb(){
            
            NSLog(@"微信Web");

            [XDCore setWXWeb];
        }
        
        void xdShare(const char* text, const char* bText, const char* scene, const char* shareType, const char* title, const char* description, const char* thumbPath, const char* imageUrl,const char*musicUrl, const char* musicLowBandUrl, const char* musicDataUrl, const char* musicLowBandDataUrl, const char* videoUrl, const char* videoLowBandUrl, const char* webpageUrl){
            
            NSLog(@"微信分享");
            
            NSString * oc_text = [NSString stringWithUTF8String:text];
            NSString * oc_bText = [NSString stringWithUTF8String:bText];
            NSString * oc_scene = [NSString stringWithUTF8String:scene];
            NSString * oc_shareType = [NSString stringWithUTF8String:shareType];
            NSString * oc_title = [NSString stringWithUTF8String:title];
            NSString * oc_description = [NSString stringWithUTF8String:description];
            NSString * oc_thumbPath = [NSString stringWithUTF8String:thumbPath];
            
            NSString * oc_imageUrl = [NSString stringWithUTF8String:imageUrl];
           
            NSString * oc_musicUrl = [NSString stringWithUTF8String:musicUrl];
            NSString * oc_musicLowBandUrl = [NSString stringWithUTF8String:musicLowBandUrl];
            NSString * oc_musicDataUrl = [NSString stringWithUTF8String:musicDataUrl];
            NSString * oc_musicLowBandDataUrl = [NSString stringWithUTF8String:musicLowBandDataUrl];
            
            NSString * oc_videoUrl = [NSString stringWithUTF8String:videoUrl];
            NSString * oc_videoLowBandUrl = [NSString stringWithUTF8String:videoLowBandUrl];
            
            NSString * oc_webpageUrl = [NSString stringWithUTF8String:webpageUrl];
            
            [XDWXShare setWXShareCallBack:[XDSDK defaultInstance]];
            
            XDWXShareObject * shareObject = [XDWXShareObject shareObject];
            shareObject.text = oc_text?oc_text:@"";
            shareObject.bText = [oc_bText boolValue];
            shareObject.scene = [XDSDK getShareScene:oc_scene];
            shareObject.type = (XDWXShareType)[XDSDK getShareType:oc_shareType];
            shareObject.title = oc_title?oc_title:@"";
            shareObject.descriptionStr = oc_description?oc_description:@"";
            shareObject.thumbPath = oc_thumbPath?oc_thumbPath:@"";
            
            switch (shareObject.type) {
                    
                case XDWXShareTypeText:{
                    
                }
                    break;
                    
                case XDWXShareTypeImage:{
                    
                    shareObject.imageUrl = oc_imageUrl?oc_imageUrl:@"";
                }
                    break;
                    
                case XDWXShareTypeMusic:{
                    
                    shareObject.musicUrl = oc_musicUrl?oc_musicUrl:@"";
                    shareObject.musicDataUrl = oc_musicDataUrl?oc_musicDataUrl:@"";
                    
                    shareObject.musicLowBandUrl = oc_musicLowBandUrl?oc_musicLowBandUrl:@"";
                    shareObject.musicLowBandDataUrl = oc_musicLowBandDataUrl?oc_musicLowBandDataUrl:@"";
                }
                    break;
                    
                case XDWXShareTypeVideo:{
                    
                    shareObject.videoUrl = oc_videoUrl?oc_videoUrl:@"";
                    shareObject.videoLowBandUrl = oc_videoLowBandUrl?oc_videoLowBandUrl:@"";
                }
                    break;
                    
                    
                case XDWXShareTypeWebPage:{
                    
                    shareObject.webpageUrl = oc_webpageUrl?oc_webpageUrl:@"";
                }
                    break;
                    
                default:
                    break;
            }
            
            [XDWXShare WXShareWithObject:shareObject];
        
        }
        
        void sdk_debug_msg(const char* msg){
            
            UIAlertView * debugAlter = [[UIAlertView alloc] initWithTitle:nil message:[NSString stringWithUTF8String:msg] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"ok", nil];
            
            [debugAlter show];
        }
        
#if __cplusplus
    }
#endif


# pragma mark - XDSDKCallBack

    
/**
 初始化成功
 */
- (void)onInitSucceed{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnInitSucceed", "");
}

/**
 初始化失败
 
 @param error_msg 错误信息
 */
- (void)onInitFailed:(nullable NSString*)error_msg{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnInitFailed", error_msg?error_msg.UTF8String:"");
}

/**
 登录成功
 
 @param access_token Token
 */
- (void)onLoginSucceed:(nonnull NSString*)access_token{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnLoginSucceed", access_token?access_token.UTF8String:"");
}

/**
 登录取消
 */
- (void)onLoginCanceled{

    UnitySendMessage(self.gameObjectName.UTF8String, "OnLoginCanceled", "");
}


/**
 登录失败
 
 @param error_msg 错误信息
 */
- (void)onLoginFailed:(nullable NSString*)error_msg{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnLoginFailed", error_msg? error_msg.UTF8String:"");
}


/**
 游客账号升级成功
 */
- (void)onGuestBindSucceed:(nonnull NSString*)access_token{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnGuestBindSucceed", access_token?access_token.UTF8String:"");
}

/**
 登出成功
 */
- (void)onLogoutSucceed{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnLogoutSucceed", "");
}


/**
 支付完成
 */
- (void)onPayCompleted{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnPayCompleted", "");
}

/**
 支付失败
 
 @param error_msg 错误信息
 */
- (void)onPayFailed:(nullable NSString*)error_msg{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnPayFailed", error_msg?error_msg.UTF8String:"");
}

/**
 支付取消
 */
- (void)onPayCanceled{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "OnPayCanceled", "");
}

/**
 分享成功
 */
- (void)onWXShareSucceed{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "onWXShareSucceed", "");
}


/**
 分享失败
 
 @param error_msg 错误信息(0成功,-1普通错误,-2用户取消,-3发送失败,-4授权失败，-5微信不支持,)未知错误(error_msg:"")详情见微信官方API
 */
- (void)onWXShareFailed:(NSString*)error_msg{
    
    UnitySendMessage(self.gameObjectName.UTF8String, "onWXShareFailed", error_msg?error_msg.UTF8String:"");
}

@end

