@echo off
cls
if %1\ ==     goto pram
if %1\ == a:\ goto ok
if %1\ == A:\ goto ok
if %1\ == b:\ goto ok
if %1\ == B:\ goto ok
goto msg
:ok
if %2\ == c:\ goto copyfiles
if %2\ == C:\ goto copyfiles
if %2\ == d:\ goto copyfiles
if %2\ == D:\ goto copyfiles
if %2\ == a:\ goto copyfiles
if %2\ == A:\ goto copyfiles
if %2\ == b:\ goto copyfiles
if %2\ == B:\ goto copyfiles
goto msg
:copyfiles
echo This will install Pacman to the dir %2\pacman,
echo to run change dir to %2\pacman and type pacman
echo it is just that easy.
echo.
echo Doing stuff here...
md %2\pacman
copy *.* %2\pacman
echo.
echo doing more stuff...
%2
cd\
cd pacman
echo.
echo Check this out...
resetdat
echo.
lev1_10
echo I think that is all...
echo.
echo Please Register this ver of pacman.
echo You get more cool cheat codes and other stuff.
echo It takes nothing but a E-mail.
echo      YNOP@aol.com
echo JTA001@vm.cc.LaTech.edu
echo  The Abstract Company
echo.
echo Well thanks for trying this out.
echo ----------===============----------
echo Copyright 1996(c)
goto end
:msg
echo *************************************
echo * Usage:  install [source:] [dest:] *
echo *   i.e.   install a: c:            *
echo *************************************
goto end
:pram
echo *******************************************
echo * You Must type it in from the Dos Prompt *
echo *    Usage:  install [source:] [dest:]    *
echo *        i.e.   install a: c:             *
echo *******************************************
:end


