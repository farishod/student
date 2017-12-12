//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include "Aria.h"

class ActionSetVel : public ArAction
{
public:
  ActionSetVel(double velocity);
  virtual ~ActionSetVel(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  void setNewVel(double velocity){myVelocity = velocity;}
protected:
  ArActionDesired myDesired;
  double myVelocity;
};