### Prerequisites
#### System
Make sure your system meets the following requirements:

* Ubuntu 14.04 64 bit
* gcc version 4.8
* ROS version `indigo` ([installation guide](http://wiki.ros.org/indigo/Installation/Ubuntu)).

or 

* Ubuntu 16.04 64 bit
* gcc version 5.4
* ROS version `kinetic` ([installation guide](http://wiki.ros.org/kinetic/Installation/Ubuntu)).

If you have multiple `gcc` installed, make sure the aforementioned version is the default one (use `update-alternatives`).

#### Install catkin tools
We use [catkin tools](https://catkin-tools.readthedocs.io/en/latest/) to build workspace. Use catkin 0.3.1:

    sudo apt-get install python-pip
    sudo pip install catkin-tools==0.3.1

Remember to remove the previous version that you are using.


### Install

#### Create the install workspace
Copy the `svo` install workspace to where you want to install the binaries (e.g., your home folder in this documentation). Then we should have a folder `~/svo_install_ws` with a subfolder named `install`.

Run the script within the workspace to fix some hardcoded paths:

    cd svo_install_ws
    ./fix_path.sh
    
 There may be some warnings with `opengv`, which can be safely ignored.

#### Create an overlay workspace
Now we will create a workspace to use the binaries we just downloaded. Before proceeding, make sure you have already source the setup file from ROS (`/opt/ros/<your ros version>/setup.bash`).

First source the install workspace:

    cd ~
    source svo_install_ws/install/setup.bash

Create a new catkin workspace:

    mkdir svo_install_overlay_ws
    cd svo_install_overlay_ws
    catkin init
    catkin config --cmake-args -DCMAKE_BUILD_TYPE=Release
    mkdir src

Now, this workspace should overlay both the ros installation and the `svo_install_ws`. Typing `catkin config`, you should see:

    Extending:    [env] /home/deploy_user/svo_install_ws/install:/opt/ros/<your ros version>
    
Copy the `rpg_svo_example` folder to the `src` folder and build the `svo_install_overlay_ws`

    catkin build
    
Then you can use SVO via `rpg_svo_example`. See `get_started.md` for running some test bags.