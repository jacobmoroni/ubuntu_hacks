#!/usr/bin/env bash

function ros_leo() 
{
    export ROS_MASTER_URI=http://192.168.0.2:11311
    export ROS_IP=$(hostname -I)
    export ROS_NAMESPACE=leo/rtabmap

    env | grep ROS_MASTER_URI
    env | grep ROS_IP
    env | grep ROS_NAMESPACE
}
function ros_kbcar() 
{
    export ROS_MASTER_URI=http://192.168.0.102:11311
    export ROS_IP=$(hostname -I)
    export ROS_NAMESPACE=leo/rtabmap

    env | grep ROS_MASTER_URI
    env | grep ROS_IP
    env | grep ROS_NAMESPACE
}

function rtab_leo() 
{
    export ROS_MASTER_URI=http://192.168.0.2:11311
    export ROS_IP=$(hostname -I)
    export ROS_NAMESPACE=leo/rtabmap

    env | grep ROS_MASTER_URI
    env | grep ROS_IP
    env | grep ROS_NAMESPACE

    rosrun rtabmap_ros rtabmapviz
}

function rtab_nvidia() 
{
    export ROS_MASTER_URI=http://kbcar2.local:11311
    export ROS_IP=$(hostname -I)
    export ROS_NAMESPACE=rtabmap

    env | grep ROS_MASTER_URI
    env | grep ROS_IP
    env | grep ROS_NAMESPACE

    rosrun rtabmap_ros rtabmapviz
}

function ros_local() 
{
    export ROS_MASTER_URI=http://localhost:11311
    export ROS_IP=$(hostname -I)

    env | grep ROS_MASTER_URI
    env | grep ROS_IP
}

function ssh_leo()
{
    ssh leo@leo
    hex
}

function ssh_kbcar()
{
    ssh nvidia@kbcar2.local
}
function qt()
{
  /opt/Qt/Tools/QtCreator/bin/qtcreator 
}

function qtsh()
{
  /opt/Qt/Tools/QtCreator/bin/qtcreator.sh 
}

function push()
{
  git push origin master
}

function vbashrc()
{
  vim ~/.bashrc
}

function sbashrc()
{
  source ~/.bashrc
}

function sl()
{
  ls
}
