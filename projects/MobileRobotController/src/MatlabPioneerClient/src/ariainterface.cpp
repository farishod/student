/*
THE MATLAB-ARIA INTERFACE

Author: Luis Felipe Posada
Created: 02.07.2008

References:
Aria Reference HTML

Copyright (c) 2008 RST, Technische Universität Dortmund, Germany
www-rst.e-technik.tu-dortmund.de
*/


#include "Aria.h"
#include "mex.h"
#include "ActionSetHeading.h"
#include "ActionSetVel.h"
#include "ActionSetRotVel.h"
#include "ActionAvoidFront.h"
#include "ActionStopFront.h"


using namespace std;

ArSerialConnection con;
ArTcpConnection tcpCon,tcpCon2;
ArRobot *robot =  new ArRobot(false);

ArVCC4 *myPTZ;
bool isConnected = false;
ArSensorReading *reading;
int ret;
std::string str;

// Actions
ActionSetHeading actSetHeading(0);
ActionSetVel actSetVel(0);
ActionSetRotVel actSetRotVel(0);
ActionAvoidFront avoidFront("avoid front obstacles",500,100);//avoid obstacles at 500mm, with vel:100mm/sec
ArActionLimiterForwards actLimFowards("limiterForwards",400,1000,100,1.5); //default stopDistance = 250,slowDistance = 1000,slowSpeed = 200,widthRatio = 1
ActionStopFront actStopFront(500,1000,100);//stopDistance = 250,slowDistance = 1000,slowSpeed = 200
ArActionConstantVelocity actConstVel;


// Wander
ArSonarDevice sonar;
ArActionStallRecover recover;
ArActionBumpers bumpers;
ArActionAvoidFront avoidFrontNear("Avoid Front Near", 225, 0);
ArActionAvoidFront avoidFrontFar;
  

//for Reading SIM_STAT from MobilSim
int realX, realY, realTh, realZ;
ArGlobalRetFunctor1<bool, ArRobotPacket*> *mySimStatPacketHandler;
ArSick  *sick  =  new ArSick();
ArSimpleConnector *simpleConnector;


void myRobotInit(int broj_porta){
	robot =  new ArRobot(false);
	ArArgumentBuilder argBuilder;

	char **argV = argBuilder.getArgv();
	int  argC = (int)argBuilder.getArgc();

	// mandatory init
	Aria::init();

	argC=2;
	argV[0]="-robotPort";
	switch(broj_porta){
		case 1:
            argV[1]="COM1";
			break;
		case 2:
            argV[1]="COM2";
			break;
		case 3:
            argV[1]="COM3";
			break;
		case 4:
            argV[1]="COM4";
			break;
		case 5:
            argV[1]="COM5";
			break;
		case 6:
            argV[1]="COM6";
			break;
		case 7:
            argV[1]="COM7";
			break;
		case 8:
            argV[1]="COM8";
			break;
		case 9:
            argV[1]="COM9";
			break;
		case 10:
            argV[1]="COM10";
			break;
	}

	// set up our parser
	ArArgumentParser parser(&argC, argV);
	// set up our simple connector
	simpleConnector = new ArSimpleConnector(&parser);


	// load the default arguments 
	parser.loadDefaultArguments();
	// add our right increments and degrees as a deafult
	parser.addDefaultArgument("-laserDegrees 180 -laserIncrement half");
	// parse the command line... fail and print the help if the parsing fails
	// or if the help was requested
	if (!simpleConnector->parseArgs() || !parser.checkHelpAndWarnUnparsed(1))
	{    
		simpleConnector->logOptions();
		////keyHandler.restore();
		exit(1);
		//return 0;
	}

	// set up the robot for connecting
	if (!simpleConnector->connectRobot(robot))
	{
		printf("Could not connect to robot... exiting\n");
		Aria::shutdown();
		////keyHandler.restore();
		//return 0;
	}

	// run the robot, true here so that the run will exit if connection lost
	robot->runAsync(true);

		// enable the motors, disable amigobot sounds
	robot->comInt(ArCommands::SONAR, 1);
	robot->comInt(ArCommands::ENABLE, 1);
	robot->comInt(ArCommands::SOUNDTOG, 0);
}


// Old version
/*
int myRobotInit(){
	if(!robot->isConnected()){

		robot = new ArRobot("Rolf",false);    
		Aria::init();
		if((ret = con.open()) != 0){
			str = con.getOpenMessage(ret);
			printf("Open failed: %s\n", str.c_str());
			Aria::shutdown();
			return 0;
		}

		robot->setDeviceConnection(&con);
		if(!robot->blockingConnect()){
			printf("Could not connect to robot...exiting\n");
			Aria::shutdown();
			return 0;
		}
		
		robot->comInt(ArCommands::SONAR, 1);
		robot->comInt(ArCommands::ENABLE, 1);
		robot->comInt(ArCommands::SOUNDTOG, 0);
		
		//We run the robot in an asyncronous thread so we can send commands to it.
		robot->runAsync(true);
		return 1;
	}
	else{
		mexErrMsgTxt("The Robot is already connected...");
		return 0;
	}
	
}
*/

void myLaserInit(){
	// attach the laser to the robot
	robot->addRangeDevice(sick);
	simpleConnector->setupLaser(sick);
	sick->runAsync();


	// connect the laser if it was requested
	if (!sick->blockingConnect())
	{
		printf("Could not connect to laser... exiting\n");
		Aria::shutdown();
	}
	printf("Hello\n");
}

// Experimental function
void myLaserRange(){
	//sick.lockDevice();
	std::list<ArSensorReading *>::const_iterator it;
	ArSensorReading *reading;

	//getchar();
	#ifdef WIN32
	printf("Pausing 1 seconds\n");
	ArUtil::sleep(1000);
	#endif

	const std::list<ArSensorReading *> *readings;
	sick->lockDevice();

	int times;

	for (times=0; times<3; times++){
		printf("\n:_____________________________________________________________");
		readings = sick->getRawReadings();
		vector< ArSensorReading > *vect = sick->getRawReadingsAsVector();
		printf("Size: %d",vect->size());


		if (readings == NULL || (it = readings->begin()) == readings->end() )
		{
			sick->unlockDevice();
			//return 1;

		}
		//getchar();
		int k = 1;
		for (it = readings->begin(); it != readings->end(); it++)
		{	
			reading = (*it);
			printf("reading %d = %d \n",k, reading->getRange());
			k++;
		}
	}
}


void myCameraInit(){
	myPTZ = new ArVCC4(robot);
	//ArPTZ *myCam = new ArVCC4(&robot);
	myPTZ->setAuxPort(2);
	myPTZ->init();
	//robot->setPTZ(myPTZ);
	myPTZ->panTilt(0,0);
	myPTZ->zoom(0);
}

void myCameraInitSim(){
	myPTZ = new ArVCC4(robot);
	//ArPTZ *myCam = new ArVCC4(&robot);
	//myPTZ->setAuxPort(1);
	//myPTZ->init();
	//robot->setPTZ(myPTZ);
	myPTZ->panTilt(0,0);
	myPTZ->zoom(0);
}

void myShutdown(){
	// Deactivates and stop all the actions
	robot->deactivateActions();
	robot->clearDirectMotion();
	robot->stopRunning();
	Aria::shutdown();
}

static void mySonarSensorRange(double	output[]){
	for (int i = 0; i < 16; i++){
		reading = robot->getSonarReading(i);
		if (reading != NULL){
			output[i] = reading->getRange();
			//printf("Sonar number: %d  Range: %d \n", i, reading->getRange());
		}
		else{
			printf("Reading = NULL \n");
			output[i] = 0;
		}
	}
}

static void mySonarSensorAngles(double	output[]){
	for (int i = 0; i < 16; i++){
		reading = robot->getSonarReading(i);
		if (reading != NULL){
			output[i] = reading->getSensorTh();
			//printf("Sonar number: %d  Range: %d \n", i, reading->getRange());
		}
		else{
			printf("Reading = NULL \n");
			output[i] = 0;
		}
	}
}

static void mySonarSensorPosition(double output[]){
		for (int i = 0; i < 16; i++){		
			reading = robot->getSonarReading(i);
			if (reading != NULL){
				output[i] = reading->getSensorX();
				output[16+i] = reading->getSensorY();
				output[32+i] = reading->getSensorTh();
			}
			else{
				printf("Reading = NULL \n");
				output[i] = 0;
				output[16+i] = 0;
				output[32+i] = 0;
			}
		}
}


static void myPosition(double	output[]){
//printf("\rx %6.1f  y %6.1f  th  %6.1f", 
	//robot->getX(), robot->getY(), robot->getTh());
	output[0] = robot->getX();
	output[1] = robot->getY();
	output[2] = robot->getTh();
}

void myPositionAndTime(double	output[]){
//printf("\rx %6.1f  y %6.1f  th  %6.1f", 
	//robot->getX(), robot->getY(), robot->getTh());
	output[0] = robot->getX();
	output[1] = robot->getY();
	output[2] = robot->getTh();
	output[3] = robot->getOdometerTime ();
}


static void myGetPan(double	output[]){
	output[0] = myPTZ->getPan();
}

//static void myGetFocus(double	output[]){
//	output[0] = myPTZ->getFocus();
//}

static void myGetTilt(double	output[]){
	output[0] = myPTZ->getTilt();
}
static void myGetZoom(double	output[]){
	output[0] = myPTZ->getZoom();
}
static void myGetPanTiltZoom(double	output[]){

	output[0] = myPTZ->getPan();
	output[1] = myPTZ->getTilt();
	output[2] = myPTZ->getZoom();
}

void myPanTiltZoom(double pan=0, double tilt=0, double zoom=0){
	myPTZ->panTilt((int)pan,(int)tilt);
	myPTZ->zoom((int)zoom);
}

void myActionMove(int inPriority = 50, double distance = 0.0)
{
	// Get the position
	double dPosition[3];
	myPosition(dPosition);
	ArActionGoto gotoPoseAction("goto");
	robot->addAction(&gotoPoseAction, inPriority);

	// turn on the motors, turn off amigobot sounds
	robot->enableMotors();

	double dXGoal = dPosition[0] + distance;
	ArActionGoto *gotoPose = new ArActionGoto("goto", ArPose(dXGoal,dPosition[1],dPosition[2]),10,50,10, 7);
	robot->addAction(gotoPose, 100);
}

void myActionGotoPose(double x = 0, double  y =0, double th = 0, double speed=50){
	
	// limiter for close obstacles
	ArActionLimiterForwards *limiter = new ArActionLimiterForwards ("speed limiter near", 100,500, speed*0.2);
	// limiter for far away obstacles
	ArActionLimiterForwards *limiterFar = new ArActionLimiterForwards("speed limiter far", 300, 1000, speed*0.7);
	// limiter so we don't bump things backwards
	
	// limiter for far away obstacles
	//ArActionLimiterTableSensor *tableLimiter = new ArActionLimiterTableSensor;
	
	// goto the goal
	ArActionGoto *gotoPose = new ArActionGoto("goto", ArPose(x,y,th),10,speed,5,10);
	
	 // add the sonar to the robot
	robot->addRangeDevice(&sonar);
	// add the actions
	//robot->addAction(tableLimiter, 100);
	robot->addAction(limiter, 100);
	robot->addAction(limiterFar, 90);
	robot->addAction(gotoPose, 50);
	//robot->runAsync(true);
}

void myActionGoto(int priority ,double goal[],double closeDist=10, double speed=50, double speedToTurnAt=10, double turnAmount=7){
	ArActionGoto *gotoPose = new ArActionGoto("goto", ArPose(goal[0],goal[1],goal[2]),closeDist,speed,speedToTurnAt, turnAmount);
	robot->addAction(gotoPose, priority);
	//robot->runAsync(true);
}

void myActionLimiterFowards( int priority, double stopDistance=100, double slowDistance=500, double slowSpeed=50, double widthRatio=1){
	//ArActionLimiterForwards *limiter = new ArActionLimiterForwards ("speed limiter",stopDistance,slowDistance,slowSpeed,widthRatio);
	ArActionLimiterForwards *limiter = new ArActionLimiterForwards ("speed limiter near", 100,500, 50);
	robot->addAction(limiter, priority);
}

void myWander(double speed = 100){
  ArActionConstantVelocity *constantVelocity = new ArActionConstantVelocity ("Constant Velocity", speed);	
  // Add the key handler to Aria so other things can find it
  //  Aria::setKeyHandler(&keyHandler);
  // Attach the key handler to a robot now, so that it actually gets
  // some processing time so it can work, this will also make escape
  // exit
  //robot->attachKeyHandler(&keyHandler);
  // add the sonar to the robot
  robot->addRangeDevice(&sonar);
  // turn on the motors, turn off amigobot sounds
  robot->comInt(ArCommands::ENABLE, 1);
  robot->comInt(ArCommands::SOUNDTOG, 0);
  robot->addRangeDevice(&sonar);
  robot->addAction(&recover, 100);
  robot->addAction(&bumpers, 75);
  robot->addAction(&avoidFrontNear, 50);
  robot->addAction(&avoidFrontFar, 49);
  robot->addAction(constantVelocity, 25);
  //robot->runAsync(true);
}

void myActionJoydrive(int priority){
  // the joydrive action
   ArActionJoydrive *joydriveAction = new ArActionJoydrive();
	
  // if we don't have a joystick, let 'em know
  if (!joydriveAction->joystickInited())
  printf("Do not have a joystick, only the arrow keys on the keyboard will work.\n");
  
   // set the joystick so it won't do anything if the button isn't pressed
  //joydriveAction->setStopIfNoButtonPressed(false);
  robot->addAction(joydriveAction, priority);
}

void myActionKeydrive(int priority){
	ArActionKeydrive *keydriveAct = new ArActionKeydrive();
	robot->addAction(keydriveAct, priority);
}


bool handleSimStatPacket(ArRobotPacket* pkt){
	if(pkt->getID() != 0x62){ 
	  printf("Problem receiving Real Positions from MobilSim..");
	  return false;
	}
	//printf("SIMSTAT pkt received:\n");
	char s1[24];
	char s2[24];
	memset(s1, 0, 24);
	memset(s2, 0, 24);
	pkt->bufToStr(s1, 23);
	//printf("\tApplication name=%s\n", s1);
	memset(s1, 0, 24);
	//printf("\tNEXT BYTE='%c'\n", pkt->bufToByte());
	pkt->bufToStr(s1, 23);
	//printf("\tApplication version=%s\n", s1);
	ArTypes::UByte4 flags = pkt->bufToUByte4();
	//printf("\tFlags=0x%x,  GUI?=%d\n", flags, (flags & ArUtil::BIT0));
	unsigned int sim, real, last;
	sim = pkt->bufToUByte2();
	real = pkt->bufToUByte2();
	last = pkt->bufToUByte2();
	//printf("\tSimInterval=%d, RealInterval=%d, LastInterval=%d.\n", sim, real, last);
	//int realX, realY, realTh, realZ;
	realX = pkt->bufToByte4();
	realY = pkt->bufToByte4();
	realZ = pkt->bufToByte4();
	realTh = pkt->bufToByte4();
	//printf("\tTrue Pose = (%d, %d, %d)\n", realX, realY, realTh);
	unsigned int numDevs = pkt->bufToUByte4();
	//printf("\t%d Devices:\n", numDevs);
	for(unsigned int i = 0; i < numDevs; i++)
	{
	  memset(s1, 0, 24);
	  memset(s2, 0, 24);
	  pkt->bufToStr(s1, 23); 
	  pkt->bufToStr(s2, 23); 
	  unsigned int which = (unsigned int) pkt->bufToUByte();
	  unsigned int status = pkt->bufToUByte4();
	  //printf("\t\t%s is %s #%d (status 0x%x)\n", s1, s2, which, status);
	}
	//printf("-------------------------------------------------\n");
	return true;
}




//////////////////////////////// MEX FUNCTION////////////////////////////////////////////////

void mexFunction( int nlhs, mxArray *plhs[], 
		  int nrhs, const mxArray*prhs[] ) 
{ 
    //char *name;
	double *output; 
//	double  **output2 = new double[16][3];
//    double *t,*y; 
	int myRobotFunction; //, buflen;
	double  *firstArg, *secondArg, *thirdArg, *fourthArg, *fifthArg, *sexthArg;
	double speed;
	double rotSpeed;
	double headingAng;
	double distance; 
	double turnAmount;
	double stopDist;
	double slowDist;
	double slowSpeed;
	double widthRatio;
	int priority;
	ArRobotPacket pkt;
	//long X,Y,Th;
    
	ArGlobalRetFunctor1<bool, ArRobotPacket*> mySimStatPacketHandler(&handleSimStatPacket);
	

    /* Check for proper number of arguments */
        
    /*if (nrhs < 2)
		mexErrMsgTxt("Too few input parameters");

	if (mxIsChar(prhs[0]) != 1)
		mexErrMsgTxt("First input must be a string.");
	else{
		if(mxGetM(prhs[0]) != 1)
			mexErrMsgTxt("Input must be a row vector.");
		else{
			buflen = (mxGetM(prhs[0]) * mxGetN(prhs[0])) + 1;
			name = (char*)mxCalloc(buflen, sizeof(char));
			mxGetString(prhs[0], name, buflen);
		}
	}*/

	myRobotFunction = mxGetScalar(prhs[0]);

	if (nrhs >= 2){
		firstArg  = mxGetPr(prhs[1]);
	}
	if (nrhs >= 3){
		secondArg = mxGetPr(prhs[2]);
	}
	if (nrhs >= 4){
		thirdArg = mxGetPr(prhs[3]);
	}
	if (nrhs >= 5){
		fourthArg = mxGetPr(prhs[4]);
	}
	if (nrhs >= 6){
		fifthArg = mxGetPr(prhs[5]);
	}
	if (nrhs == 7){
		sexthArg = mxGetPr(prhs[6]);
	}
	
	//myRobotFunction = mxGetScalar(prhs[0]);
	switch(myRobotFunction){
	case 0:
		myRobotInit(*firstArg);
		break;
	case 1:
		myCameraInit();
		break;
	case 2:
		//printf("myShutdown()\n");
		myShutdown();
		break;
	case 3:
		//This function output a 16 x 1 matrix with  the 16 sonar sensor values
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(16, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 
		output = mxGetPr(plhs[0]);
		mySonarSensorRange(output);
		break;
	case 4:
		//This function output a 3 x 1 matrix with the  x, y , theta position values
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 
		output = mxGetPr(plhs[0]);
		myPosition(output);
		break;
	case 5:
		//if (myPTZ->isInitted()){
			//This function pans, tilts and zooms the PTZ camera
			myPanTiltZoom(*firstArg, *secondArg, *thirdArg);
		//}
		//else
		//	mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 6:
		 //Sets the rotational velocity of the robot in (deg/sec)
		robot->setRotVel(*firstArg);
		break;
	case 7:
		//Sets the desired translational velocity of the robot in (mm/sec)
		robot->setVel(*firstArg);
		break;									
	case 8:
	  // Sets the velocity of each of the wheels on the robot independently
	   robot->setVel2(*firstArg,*secondArg);
	   break;
	case 9:
		// Move the given distance forward/backwards in mm
		robot->move(*firstArg);
		break;
	case 10:
		//Move the robot to a desired position (Not orientation)
		myActionGotoPose(*firstArg, *secondArg, *thirdArg, *fourthArg);
		break;
	case 11:
		// getPan
		//if (myPTZ->isInitted()){
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 		
		output = mxGetPr(plhs[0]);
		myGetPan(output);
		//	}
		//else
		//	mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 13:
		// getTilt
		//if (myPTZ->isInitted()){
			/* Create a matrix for the return argument  */ 
			plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
			/* Assign pointers to the various parameters */ 		
			output = mxGetPr(plhs[0]);
			myGetTilt(output);
			//	}
		//else
		//	mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 12:
		//This function output a 4 x 1 matrix with the  x, y , theta, Time Taken  values
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(4, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 
		output = mxGetPr(plhs[0]);
		myPositionAndTime(output);
		break;
	case 14:
		if (myPTZ->isInitted()){
			/* Create a matrix for the return argument  */ 
			plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
			/* Assign pointers to the various parameters */ 		
			output = mxGetPr(plhs[0]);
			myGetZoom(output);
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 15:
		//if (myPTZ->isInitted()){
			/* Create a matrix for the return argument  */ 
			plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL); 
			/* Assign pointers to the various parameters */ 		
			output = mxGetPr(plhs[0]);
			myGetPanTiltZoom(output);
		//}
		//else
		//	mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 16:
		myWander(*firstArg);
		break;
	case 17:
		robot->stopRunning(false);
		break;
	case 18:
		myActionGoto((int)*firstArg, secondArg, *thirdArg, *fourthArg, *fifthArg, *sexthArg);
		break;
	case 19:
		myActionLimiterFowards( (int) *firstArg,  *secondArg, *thirdArg, *fourthArg, *fifthArg);
		break;
	case 20:
		robot->runAsync(true);
		break;
	case 21:
		//UNUSED //robot->addRangeDevice(&sonar);
		break;
	case 22:
		//UNUSED
		//myRobotInitSim();
		break;
	case 23:
		// Set heading of the robot in (degrees)
		robot->setHeading (*firstArg ); 
		break;
	case 24:
		myActionMove((int)*firstArg,*secondArg);
		break;
	case 25:
		break;
	case 26:	
		//This function output a 16 x 1 matrix with  the 16 sonar sensor angles
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(16, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 
		output = mxGetPr(plhs[0]);
		mySonarSensorAngles(output);
		break;
	case 27:
		robot->clearDirectMotion();
		break;
	case 28:
		robot->stop();
		break;
	case 29:
		// run the robot, true means that the run will exit if connection lost
		robot->run(true);
		Aria::shutdown();
		break;
	case 30:
		myActionJoydrive((int) *firstArg);
		break;
	case 31:
		myActionKeydrive((int) *firstArg);
		break;
	case 32:
		//This function output a 16 x 3 matrix with  the 16 sonar sensor positions: x,y,theta
		/* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(16, 3, mxREAL); 
		/* Assign pointers to the various parameters */ 
		//output2 = mxCreateCellMatrix(16, 3);
		output = mxGetPr(plhs[0]);
		mySonarSensorPosition(output);
		break;
	case 33:
		robot->resetOdometer();
 		break;
	case 34:
		if (myPTZ->isInitted()){
			/* Create a matrix for the return argument  */ 
			plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
			/* Assign pointers to the various parameters */ 		
			output = mxGetPr(plhs[0]);
			//myGetFocus(output);
			output = (double*)myPTZ->canGetFOV();
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 35:
		if (myPTZ->isInitted()){
	    /* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 		
		output = mxGetPr(plhs[0]);
		//myGetFocus(output);
		output = (double*)myPTZ->setFocus(*firstArg);
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 36:
		if (myPTZ->isInitted()){
	    /* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 		
		output = mxGetPr(plhs[0]);
		//myGetFocus(output);
		output[0] = (double)myPTZ->canSetFocus();
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );
		break;
	case 37:
		if (myPTZ->isInitted()){
	    /* Create a matrix for the return argument  */ 
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		/* Assign pointers to the various parameters */ 		
		output = mxGetPr(plhs[0]);
		//myGetFocus(output);
		output[0] = myPTZ->getFocus(*firstArg);
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );
		break;
   	case 38:
		// Check if the camera is initialized
		if (myPTZ->isInitted()){
			/* Create a matrix for the return argument  */ 
			plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
			/* Assign pointers to the various parameters */ 		
			output = mxGetPr(plhs[0]);
			//myGetFocus(output);
			output[0] = myPTZ->autoFocus();
		}
		else
			mexErrMsgTxt("The camera has not  been initialized." );

		break;
	case 39:
		// OK
		// Activates and adds the action AvoidFront		
		priority = (int)*firstArg;
		distance = *secondArg;
		speed = *thirdArg;
		turnAmount = *fourthArg;
		robot->addRangeDevice(&sonar);
		avoidFront.setObsDist(distance);
		avoidFront.setAvoidVel(speed);
		avoidFront.setTurnAmount(turnAmount);
		avoidFront.activate();
		//avoidFront.
		robot->addAction(&avoidFront, priority);		
		break;
	case 40:
		//actionStopFront this action stops the robot if sees something at front
		robot->addRangeDevice(&sonar);
		priority = (int)*firstArg;
		stopDist = *secondArg;
		slowDist = *thirdArg;
		slowSpeed = *fourthArg;
		actStopFront.setStopDist(stopDist);
		actStopFront.setSlowDist(slowDist);
		actStopFront.setSlowSpeed(slowSpeed);
		actStopFront.activate();
		robot->addAction(& actStopFront, 100);
		break;
	case 41:
		// OK
		// Activates and sets the action SetHeading, deactivates actionSetRotVel
		priority = (int)*firstArg;
		headingAng = (int)*secondArg;
		// In order that SetHeading works properly, actSetRotVel should be deactivated
		actSetRotVel.deactivate();
		actSetHeading.activate();
		actSetHeading.setNewHeading(headingAng );
		robot->addAction(&actSetHeading, priority);	
		break;
	case 42:
		// OK
		// Activates and sets ActionSetVel	
		priority= (int)*firstArg;
		speed = *secondArg;		
		actSetVel.activate();
		actSetVel.setNewVel(speed);
		robot->addAction(&actSetVel,priority);		
		//robot->addAction(new ArActionConstantVelocity(),50);

		break;
	case 43:
		//OK
		// Activates and sets ActionSetRotVel deactivates  actSetHeading
		priority = (int)*firstArg;
		rotSpeed = *secondArg;		
		// In order that SetRotVel works, ActSetHeading should be deactivated
		actSetHeading.deactivate();
		actSetRotVel.activate();
		actSetRotVel.setNewRotVel(rotSpeed);
		robot->addAction(&actSetRotVel,priority);
		break;
	case 44:
		//OK
		// Deactivates and stop all the actions
		robot->deactivateActions();
		robot->clearDirectMotion();
		break;
	case 45:
		//OK
		// This function piece sets the position read by getPose() to x,y,th
		robot->moveTo(ArPose(*firstArg,*secondArg,*thirdArg),false);
		break;
	case 46:
		//OK
		robot->addPacketHandler(&mySimStatPacketHandler);
		robot->com(ArCommands::SIM_STAT);
		ArUtil::sleep(25);
		plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
		output[0] = (double)realX;
		output[1] = (double)realY;
		output[2] = (double)realTh;
		break;
	case 47:
		//using built in, ArActionLimiterFowards, different from case 40.
		robot->addRangeDevice(&sonar);
		priority = (int)*firstArg;
		stopDist = *secondArg;
		slowDist = *thirdArg;
		slowSpeed = *fourthArg;
		widthRatio = *fifthArg;

		actLimFowards.activate();
		actLimFowards.setParameters(stopDist,slowDist,slowSpeed,widthRatio);
		robot->addAction(&actLimFowards,priority);	
		break;
	case 48:
		priority = (int)*firstArg;
		actConstVel.activate();
		robot->addAction(&actConstVel,priority);
		break;
	case 49:
		//OK
		// SIM_RESET
		robot->com(ArCommands::SIM_RESET);
		//ArUtil::sleep(25);
		break;
	case 50:
		// simSetPos
		// SIM_SET_POSE
		long X,Y,Th;
		X = (long)*firstArg;
		Y = (long)*secondArg;
		Th =(long)*thirdArg;				
		pkt.setID(ArCommands::SIM_SET_POSE);
		pkt.uByteToBuf(0);
	    pkt.byte4ToBuf(X);
		pkt.byte4ToBuf(Y);
		pkt.byte4ToBuf(Th);
		pkt.finalizePacket();
		robot->getDeviceConnection()->write(pkt.getBuf(), pkt.getLength());
		break;
	case 51:
		robot->com(ArCommands::SIM_EXIT);		
		break;
	case 52:
		//cameraInitSim
		myCameraInitSim();
		break;
	case 53:
		//getVel
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getVel();
		break;
	case 54:
		// getRotVel
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getRotVel();
		break;
	case 55:
		// setPanSlew
			myPTZ->panSlew(*firstArg);
		break;
	case 56:
		// setTiltSlew
			myPTZ->tiltSlew(*firstArg);
		break;
	case 57:
		// getPanSlew
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = myPTZ->getPanSlew();
		break;
	case 58:
		// getTiltSlew
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = myPTZ->getTiltSlew();
		break;
	case 59:
		robot->setRotVelMax (*firstArg);
	    break;
	case 60:
		robot->setTransVelMax(*firstArg);
		break;
	case 61:
		robot->setDeltaHeading(*firstArg);
		break;
	case 62:
		myLaserInit();
		break;
	case 63:
		myLaserRange();
		break;
	case 64:
		//Sets the robot's absolute maximum translational acceleration.
		robot->setTransAccel (*firstArg);
		break;
	case 65:
 		// Sets the robot's absolute maximum translational deceleration. 
		robot->setTransDecel (*firstArg);
		break;
	case 66:
		//Sets the rotational acceleration.	
		robot->setRotAccel (*firstArg); 		
		break;
	case 67:
		//Sets the rotational deceleration. 
		robot->setRotDecel (*firstArg);
		break;
	case 68:
		//getBatteryVoltageNow
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getBatteryVoltageNow();
		break;
	case 69:
		//getChargeState
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getChargeState();
		break;
	case 70:
		//getRealBatteryVoltageNow
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getRealBatteryVoltageNow();
		break;
	case 71:
		//getOdometerDistance
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getOdometerDistance();
		break;
	case 72:
		plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL); 
		output = mxGetPr(plhs[0]);
	    output[0] = robot->getRotVelMax();
		break;
	case 73:
		ArUtil::sleep(*firstArg);
		break;
	case 74:
		sick->lockDevice();
		break;
	case 75:
		sick->unlockDevice();
		break;
	default:
		mexErrMsgTxt("The function you are trying to access is not yet implemented.");
	}
}