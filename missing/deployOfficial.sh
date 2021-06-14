#! /bin/bash
# this version is for official

env=$1
username=$2

local_path=$3
if [ ! -d "$local_path" ]
then
  echo "local_path not exist"
  exit 1
fi

vloume_num=$4
bucket=$5
ak=$6
sk=$7
fake_quota=$8

# download installation package and extract it to root directory
url="https://gitlab.super.xyz/11119676/juicefs-packages.git"
git clone $url
if [ ! -d "juicefs-packages" ]
then
  echo "download package from gitlab failed"
  #exit 1
  mkdir -p ./juicefs-packages
  cd juicefs-packages || exit 1
  if [ "$env" ==  "2" ]
  then
    wget "http://very-storagetest-bj.very.lan/zwy/juicefs-packages/very-test3-bj2.tar.gz"
  elif [ "$env" ==  "6" ]
  then
    wget "http://very-storagetest-bj.very.lan/zwy/juicefs-packages/ai-volume2.tar.gz"
  else
    echo "download from elsewhere failed, please contact zhangwenyuan"
    cd ../
    exit 1
  fi
  cd ../
fi

# add an option for user here to choose which package is suitable for them
echo -e "\nHi, there are:"
find ./juicefs-packages/*gz | wc -l
echo -e "environments,\nnumber '1' is for baize(shekou_test),"
echo "number '2' is for bifang(beijing_test),"
echo "number '3' is for tianma(India),"
echo "number '4' is for xuanwu(BJ Mix)," 
echo "number '5' is for xingtian(AI tinyFile),"
echo "number '6' is for xingtian(AI tinyFile multi-volume version),"
echo "please choose one by typing 1 or 2 or 3 or 4 or 5 or 6:" 
#read -e envNumber
envNumber=$env

VOLUME_NAME="very-test2"
TAR_NAME="very-test2.tar.gz"
PACKAGE_NAME="very-test2-262"
if [ "$envNumber" ==  "1" ]
then
  VOLUME_NAME="very-test2"
  TAR_NAME="very-test2.tar.gz"
  PACKAGE_NAME="very-test2-262"
elif [ "$envNumber" ==  "2" ]
then
  VOLUME_NAME="very-test-volume$vloume_num"
  TAR_NAME="very-test3-bj2.tar.gz"
  PACKAGE_NAME="ks3-very-test-297"
elif [ "$envNumber" ==  "3" ]
then
  VOLUME_NAME="indian-fs"
  TAR_NAME="indian-fs.tar.gz"
  PACKAGE_NAME="ks3-very-indian-271"
elif [ "$envNumber" ==  "4" ]
then
  VOLUME_NAME="gaia-mix-$vloume_num"
  TAR_NAME="gaia-mix.tar.gz"
  PACKAGE_NAME="ks3-very-1-268"
elif [ "$envNumber" ==  "5" ]
then
  VOLUME_NAME="ai-volume"
  TAR_NAME="ai-volume.tar.gz"
  PACKAGE_NAME="ks3-very-2-284"
elif [ "$envNumber" ==  "6" ]
then
  VOLUME_NAME="ai-volume-$vloume_num"
  TAR_NAME="ai-volume2.tar.gz"
  PACKAGE_NAME="ks3-very-2-284"
else
  echo "please choose 1 or 2 or 3 or 4 or 5 or 6!!!!"
  rm -rf ./juicefs-packages
  exit 0
fi

mv ./juicefs-packages/$TAR_NAME /root/$TAR_NAME
rm -rf juicefs-packages
cd /root/ || exit 1
tar xvf $TAR_NAME

# excute installation
#echo "please input your volume name(very-test2):"
#read -e volumeName
# umount /juicefs/zwy-test/ -l
# umount -l /juicefs/.juicefs/
#if [ "$volumeName" != "very-test2" ]; then
#    echo "only support very-test2 now, please input:very-test2"
#    exit 0
#fi

cd /root/$PACKAGE_NAME/mount || exit 1
chmod 755 ./install.sh
#./install.sh $volumeName
./install.sh $VOLUME_NAME

if [ "$envNumber" ==  "2" ]
then
  echo "BJ test multi volume is chosen"
  ./bin/juicefs auth $VOLUME_NAME --bucket="http://$bucket.very-storagetest-bj.very.lan" --accesskey=$ak --secretkey=$sk --no-update
  ./bin/juicefs mount $VOLUME_NAME $local_path --no-update --max-space $fake_quota
  exit 0
elif [ "$envNumber" ==  "6" ]
then
  echo "AI tiny multi volume is chosen"
  ./bin/juicefs auth $VOLUME_NAME --bucket="http://$bucket.xingtian-prd-bj.very.lan" --accesskey=$ak --secretkey=$sk --no-update
  ./bin/juicefs mount $VOLUME_NAME $local_path --no-update --max-space $fake_quota
  exit 0
elif [ "$envNumber" ==  "4" ]
then
  echo "mix cluster multi volume is chosen"
  ./bin/juicefs auth $VOLUME_NAME --bucket="http://$bucket.gaia-mix-prd.very.lan" --accesskey=$ak --secretkey=$sk --no-update
  ./bin/juicefs mount $VOLUME_NAME $local_path --no-update --max-space $fake_quota
  exit 0
else
  echo "shared volume is ready"
fi

# mount directory
mkdir -p /etc/.juicefs
cd /root/$PACKAGE_NAME/mount/ || exit 1
chmod 755 ./bin/juicefs


if [ $envNumber -le 3 ]
then
  ./bin/juicefs mount $VOLUME_NAME /etc/.juicefs --no-update
  echo "please input a subdirectory name (for example your full name like: zhangsan)"
  #read -e SubDirName
  SubDirName=$username
  cd /etc/.juicefs || exit 1
  mkdir -p ./$SubDirName
  if [ -d "$SubDirName" ]
  then
    echo "OK, your name is legal"
    # mkdir -p $RootDirName/.juicefs/$SubDirName
    # mount --bind $RootDirName/.juicefs/zhangwenyuan $RootDirName/$SubDirName
    echo "please input your working directory name(for example:/data/image_backup):"
    #read -e RootDirName
    RootDirName=$local_path
    #mkdir -p $RootDirName
    mount --bind /etc/.juicefs/$SubDirName $RootDirName
    echo "ok"
  else
    umount /etc/.juicefs -l
    echo "the subdirectory name is wrong, please input the correct name!(envNumber:${envNumber})"
  fi
else
  ./bin/juicefs mount $VOLUME_NAME /etc/.juicefs --no-update
  echo "please input a subdirectory name (for example your full name like: zhangxueyou)"
  #read -e SubDirName
  SubDirName=$username
  cd /etc/.juicefs || exit 1
  mkdir -p ./$SubDirName
  if [ -d "$SubDirName" ]
  then
    umount /etc/.juicefs -l
    echo "please input your working directory name(for example:/data/image_backup):"
    #read -e RootDirName
    RootDirName=$local_path
    #mkdir -p $RootDirName
    cd /root/$PACKAGE_NAME/mount/ || exit 1
    ./bin/juicefs mount --subdir=/$SubDirName $VOLUME_NAME $RootDirName --no-update
  else
    umount /etc/.juicefs -l
    echo "the subdirectory name is wrong, please input the correct name!(envNumber:${envNumber})"
  fi
fi
