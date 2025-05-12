@echo off
setlocal

REM ----- Configuration -----
set APP_NAME=api-tutorial
set DOCKER_USERNAME=ersaurabhsharmamca
set IMAGE_TAG=latest
set CONTAINER_NAME=springboot-container

echo Building Spring Boot Application...

echo Building Docker Image...
docker build -t %DOCKER_USERNAME%/%APP_NAME%:%IMAGE_TAG% .
IF %ERRORLEVEL% NEQ 0 (
    echo Docker build failed. Exiting...
    exit /b %ERRORLEVEL%
)

echo Pushing Image to Docker Hub...
docker push %DOCKER_USERNAME%/%APP_NAME%:%IMAGE_TAG%
IF %ERRORLEVEL% NEQ 0 (
    echo Docker push failed. Exiting...
    exit /b %ERRORLEVEL%
)

echo Stopping and Removing Previous Container (if any)...
docker stop %CONTAINER_NAME% 2>nul
docker rm %CONTAINER_NAME% 2>nul

echo Running Docker Container Locally...
REM docker run -d -p 8082:8082 --name %CONTAINER_NAME% %DOCKER_USERNAME%/%APP_NAME%:%IMAGE_TAG%

echo Deployment Complete! Application running at http://localhost:8082
endlocal
pause
