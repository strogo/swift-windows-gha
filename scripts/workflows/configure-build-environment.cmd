:: Initializes global build environment

call :sw_normalize_path SW_WORKSPACE "%~dp0\..\.."

echo Initializing logging
call "%SW_WORKSPACE%\scripts\tools\init-log.cmd"
if "%SW_LOG%"=="" (
  echo Logging system initialization failed
  exit /b 1
)

set SW_LOG_BUILD_INFO=%SW_LOG_INFO% --scope build
set SW_LOG_BUILD_WARNING=%SW_LOG_WARNING% --scope build
set SW_LOG_BUILD_ERROR=%SW_LOG_ERROR% --scope build

%SW_LOG_BUILD_INFO% --message="Logging initialized"

set SW_SET_ENV=call "%SW_WORKSPACE%\scripts\tools\set-env.cmd"
set SW_PRE_STEP=call "%SW_WORKSPACE%\scripts\tools\pre-step.cmd"
set SW_PRE_JOB=call "%SW_WORKSPACE%\scripts\tools\pre-job.cmd"
set SW_PLUTIL=powershell -ExecutionPolicy Bypass "%SW_WORKSPACE%\scripts\tools\plutil.ps1"

%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="Workspace:               " --message="%SW_WORKSPACE%"
%SW_LOG_BUILD_INFO%
%SW_LOG_BUILD_INFO% --prefix="pre-step command:        " --message="%SW_PRE_STEP%"
%SW_LOG_BUILD_INFO% --prefix="pre-job command:         " --message="%SW_PRE_JOB%"

%SW_LOG_BUILD_INFO% --message="Initializing Visual Studio environment"
call "%SW_WORKSPACE%\scripts\tools\vs-env.cmd" -arch=x64 -host_arch=x64

exit /b 0



:: ###########################################################################
:sw_normalize_path <output_var> <path>
set "%1=%~f2"
exit /b
