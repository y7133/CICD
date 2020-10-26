LD_PATH=$(ls /home/ec2-user/build/*.jar)
JAR_NAME=$(basename $BUILD_PATH)
echo "> build ���ϸ�: $JAR_NAME"

echo "> build ���� ����"
DEPLOY_PATH=/home/ec2-user/
cp $BUILD_PATH $DEPLOY_PATH

echo "> springboot-deploy.jar ��ü"
CP_JAR_PATH=$DEPLOY_PATH$JAR_NAME
APPLICATION_JAR_NAME=springboot-deploy.jar
APPLICATION_JAR=$DEPLOY_PATH$APPLICATION_JAR_NAME

ln -Tfs $CP_JAR_PATH $APPLICATION_JAR

echo "> ���� �������� ���ø����̼� pid Ȯ��"
CURRENT_PID=$(pgrep -f $APPLICATION_JAR_NAME)

if [ -z $CURRENT_PID ]
then
  echo "> ���� �������� ���ø����̼��� �����Ƿ� �������� �ʽ��ϴ�."
  else
    echo "> kill -15 $CURRENT_PID"
      kill -15 $CURRENT_PID
        sleep 5
	fi

	echo "> $APPLICATION_JAR ����"
	nohup java -jar $APPLICATION_JAR > /dev/null 2> /dev/null < /dev/null &
