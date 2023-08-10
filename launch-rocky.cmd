cmd /k &^

@REM REM set a variable for the rocky directory
set ROCKY_DIR=%USERPROFILE%\rocky &^
echo %ROCKY_DIR% &^

REM activate the rocky environment
%ROCKY_DIR%\rocky-env\Scripts\activate &^

@REM change directory to source folder
cd %ROCKY_DIR%\rocky-src &^

@REM turn the prompt back on
@REM @echo on &^

@REM launch the app
R -e "shiny::runApp('port=3838, launch.browser=T)" &^

@REM open http://localhost:3838/ in a browser
start "" http://localhost:3838 &^

@REM pause before exiting
pause