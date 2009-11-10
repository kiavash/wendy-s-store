package com.mattstine.wendysstore.domain

/**
 * Created by IntelliJ IDEA.
 * User: mstine
 * Date: Apr 13, 2009
 * Time: 10:19:03 PM
 * To change this template use File | Settings | File Templates.
 */
public enum USState {
  AL('Alabama'),
  AK('Alaska'),
  AZ('Arizona'),
  AR('Arkansas'),
  CA('California'),
  CO('Colorado'),
  CT('Connecticut'),
  DE('Delaware'),
  DC('D.C.'),
  FL('Florida'),
  GA('Georgia'),
  HI('Hawaii'),
  ID('Idaho'),
  IL('Illinois'),
  IN('Indiana'),
  IA('Iowa'),
  KS('Kansas'),
  KY('Kentucky'),
  LA('Louisiana'),
  ME('Maine'),
  MD('Maryland'),
  MA('Massachusetts'),
  MI('Michigan'),
  MN('Minnesota'),
  MS('Mississippi'),
  MO('Missouri'),
  MT('Montana'),
  NE('Nebraska'),
  NV('Nevada'),
  NH('New Hampshire'),
  NJ('New Jersey'),
  NM('New Mexico'),
  NY('New York'),
  NC('North Carolina'),
  ND('North Dakota'),
  OH('Ohio'),
  OK('Oklahoma'),
  OR('Oregon'),
  PA('Pennsylvania'),
  RI('Rhode Island'),
  SC('South Carolina'),
  SD('South Dakota'),
  TN('Tennessee'),
  TX('Texas'),
  UT('Utah'),
  VT('Vermont'),
  VA('Virginia'),
  WA('Washington'),
  WV('West Virginia'),
  WI('Wisconsin'),
  WY('Wyoming')

  USState(String longName) {
    this.longName = longName
  }

  String longName

}