//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include "Aria.h"

class ActionStopFront : public ArAction
{
public:
  // constructor
  ActionStopFront( double stopDistance = 250,double slowDistance = 500, double slowSpeed = 100);
  virtual ~ActionStopFront(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  virtual void setRobot(ArRobot *robot);
  void setSlowSpeed(double slowSpeed){mySlowSpeed = slowSpeed;}
  void setSlowDist(double slowDist){mySlowDistance = slowDist;}
  void setStopDist(double stopDist){myStopDistance = stopDist;}
  

protected:
  ArActionDesired myDesired;
  ArRangeDevice *mySonar;
  double myStopDistance;
  double mySlowDistance;
  double mySlowSpeed;
};
