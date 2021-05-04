get-current-version:
	# mvn org.apache.maven.plugins:maven-help-plugin:3.1.0:evaluate -Dexpression=project.version -q -DforceStdout
	mvn help:evaluate -Dexpression=project.version -q -DforceStdout

get-next-version:
	python jenkins/scripts/bump-version.py --current-version=`mvn help:evaluate -Dexpression=project.version -q -DforceStdout` --prefixes=MYAPP- --suffixes="-SNAPSHOT"