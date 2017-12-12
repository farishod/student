//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include "Aria.h"

class ActionSetRotVel : public ArAction
{
public:
  ActionSetRotVel(double rotVelocity);
  virtual ~ActionSetRotVel(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  void setNewRotVel(double rotVelocity){myRotVelocity = rotVelocity;}
protected:
  ArActionDesired myDesired;
  double myRotVelocity;
};