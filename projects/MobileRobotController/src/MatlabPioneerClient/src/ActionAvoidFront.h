//Author: Luis Felipe Posada
//Created: 02.07.2008
//
//Institute of Electrical Control Systems Engineering 
//Univerity of Dortmund
//
//Changelog:
//<DATE>    <AUTHOR>        <DESCRIPTION>

#include "ArAction.h"
 
class ActionAvoidFront : public ArAction
{
public:
ActionAvoidFront(const char *name = "avoid front obstacles", 
double obstacleDistance = 500, double avoidVelocity = 100,
double turnAmount = 15, bool useTableIRIfAvail = true);
virtual ~ActionAvoidFront();
virtual ArActionDesired *fire(ArActionDesired currentDesired);
virtual ArActionDesired *getDesired(void) { return &myDesired; }
void setObsDist(double obsDist){myObsDist = obsDist;}
void setAvoidVel(double avoidVel){myAvoidVel = avoidVel;}
void setTurnAmount(double turnAmount){myTurnAmount = turnAmount;}

virtual const ArActionDesired *getDesired(void) const { return &myDesired; }

protected:
double myTurnAmount;
double myObsDist;
double myAvoidVel;
double myTurnAmountParam;
bool myUseTableIRIfAvail;
int myTurning; // 1 for turning left, 0 for not turning, -1 for turning right
ArActionDesired myDesired;
ArSectors myQuadrants;
ArFunctorC<ActionAvoidFront> myConnectCB;
};