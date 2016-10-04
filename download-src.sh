#!/bin/sh


JDK8=src/jdk8/jdk-8u91-linux-x64.tar.gz
GEODE=src/geode/apache-geode-1.0.0-incubating.M2.tar.gz

mkdir -p `dirname $JDK8`
mkdir -p `dirname $GEODE`

if [ ! -f $JDK8 ];then
  wget https://download.run.pivotal.io/openjdk-jdk/trusty/x86_64/openjdk-1.8.0_91.tar.gz -O $JDK8
fi

if [ ! -f $GEODE ];then
  wget http://ftp.jaist.ac.jp/pub/apache/incubator/geode/1.0.0-incubating.M2/apache-geode-1.0.0-incubating.M2.tar.gz -O $GEODE
fi
