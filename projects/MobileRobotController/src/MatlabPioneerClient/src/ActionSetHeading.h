//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include "Aria.h"

class ActionSetHeading : public ArAction
{
public:
  ActionSetHeading(double heading);
  virtual ~ActionSetHeading(void) {};
  virtual ArActionDesired *fire(ArActionDesired currentDesired);
  void setNewHeading(double heading){myHeading = heading;}
protected:
  ArActionDesired myDesired;
  double myMaxSpeed;
  double myHeading;

};