//========================================================================
//
// File: sanbg.h
//
// Description:
//
// Created:2014.5
//
// Author: TONG Bin  www.wicoolsoft.com
//
//========================================================================


//----------------------------------
//      global  definition
//----------------------------------

#define BGC_OK	0				//正常

//about current
#define BGC_CURRENT_ZERO 		1	//电流为零。电流持续等于或近似零
#define BGC_CURRENT_TOOLOW		2	//电流过低。电流持续小于设定的最小值
#define BGC_CURRENT_TOOHIGH		3	//电流过高。电流持续大于设定的最大值

//about bg
#define BGC_BG_NONE				1	//不能进行转化，尚未输入参比
#define BGC_BG_ERRORCURRENT		2	//当前电流异常
#define BGC_BG_ERRORK			3	//当前K值异常
#define BGC_BG_ROC				4   //血糖ROC异常

//about k
#define BGC_K_TOOLOW			1	//计算后，K值小于设定的最小值
#define BGC_K_TOOHIGH			2	//计算后，K值大于设定的最大值


//about trend
#define BGC_TREND_SHARPRISE		0	//快速上升
#define BGC_TREND_RISE  		1	//上升
#define BGC_TREND_STEADY		3	//稳定
#define BGC_TREND_FALL			4	//下降
#define BGC_TREND_SHARPFALL		5	//快速下降
#define BGC_TREND_UNCLEAR		6	//趋势不明



typedef struct{
    unsigned int state;
    unsigned int bg;
    unsigned int trend;
    unsigned int K;
    unsigned int Backgroud;
}_sConvertResult_t;


//----------------------------------
//      global  function
//----------------------------------
/*
 初始化算法模块
 说  明：在执行其它调用前，必须首先对算法模块进行初始化。
 */
extern void BGC_Init();

/*
 输入原始电流数据，计算血糖值，输出转换结果。转换结果包括：血糖值、变化趋势、K值和背景减差
 
 参  数：
	current	原始电流值，单位0.01nA。即，原始电流值应具有2位小数精度
	result   拷贝转换结果到该地址。由调用者分配空间
 
 返回值：电流状态
	BGC_OK					正常
	BGC_CURRENT_ZERO 		电流为零。电流持续等于或近似零
	BGC_CURRENT_TOOLOW	电流过低。电流持续小于设定的最小值
	BGC_CURRENT_TOOHIGH	电流过高。电流持续大于设定的最大值
 
 说  明：
	按照血糖监测流程，应用程序必须每3分钟，利用该接口，向算法模块传递一个原始电流数据。如果满足转换条件（电流值正常，已输入参比且K值正常）算法会通过参数返回转换结果。
	转换结果中的血糖值和变化趋势，用于显示和记录。K值和背景价，根据需求做相应处理（一般只做记录，且只记录变化）。
	_sConvertResult_t为自定义结构体，用于表示转换结果，定义如下
	typedef struct{
 unsigned int state;
 unsigned int bg;
 unsigned int trend;
 unsigned int K;
 unsigned int Backgroud;
	}_sConvertResult_t
 
	state        本次转换的状态。可能值如下
 BGC_OK						正常
 BGC_BG_NONE				不能进行转化，尚未输入参比
 BGC_BG_ERRORCURRENT		当前电流异常
 BGC_BG_ERRORK				当前K值异常
 当state不是BGC_OK时，转换结果的其他数据项（bg，trend，K，backgroud）全部或部
 分无效
	bg  		血糖值，单位0.001 mmol/L。即，血糖值有3位小数精度
	trend 		变化趋势。可能的变化趋势取值如下
 BGC_TREND_SHARPRISE		快速上升
 BGC_TREND_RISE  		上升
 BGC_TREND_STEADY		稳定
 BGC_TREND_FALL			下降
 BGC_TREND_SHARPFALL	快速下降
 BGC_TREND_UNCLEAR		趋势不明
	K    		放大100倍的K值
 background	背景减差
 */
extern int BGC_InputCurrent(unsigned int current, _sConvertResult_t *result);
/*
 输入参比血糖值
 
 参  数：
	ref	 参比血糖值，单位0.1 mmol/L。如参比血糖为3.9 mmol/L，则ref=39
 type  处理方式。0 一般处理 1 严格处理。
 返回值：K值状态
	BGC_OK				正常
	BGC_K_TOOLOW		计算后，K值小于设定的最小值
	BGC_K_TOOHIGH		计算后，K值大于设定的最大值
 
 说  明：
	根据流程要求，算法对不同时间段的参比血糖，处理方法不一样。一般情况下，前n次（或前n小时内）的参比血糖，采用“一般处理”，其余采用“严格处理”
	如果返回值不为BGC_OK，应用程序需要提示，要求用户重新输入参比血糖或进行其它处理。
	应用程序应保证输入的ref在规定有效范围内，如超出设定范围，计算得到的K值会有严重误差。
 */
extern int BGC_InputReference(unsigned int ref, int type);

/*
 测试是否允许输入参比
 参  数：无
 返回值：
	1允许， 0 禁止
 说  明：
	应用程序在调用BGC_InputReferenc( )前，需要先测试是否允许输入参比。
*/
extern int BGC_PermitRef();

/*
继续转换
 参  数：
K	 		转换使用的K值。放大100倍的
background	转换使用的背景减差
latestcurrent	最近的原始电流值，单位0.01nA
 
返回值：无
说  明：
	正常操作下，K值和背景减差是由算法利用电流值和参比计算得到。某些情况下，如应用重启，但希望继续正在进行中的监测，需要应用将之前的K值、背景减差和最近的电流值告之给算法，算法便可使用上述参数进行转换。
*/
extern void BGC_ContinueConverting(unsigned int K, unsigned int background, unsigned int latestcurrent);

extern int BGC_Verion();
