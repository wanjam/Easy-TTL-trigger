function [] = Install_EEG_trigger()
%INSTALL_EEG_TRIGGER retrieves the files necessary to access parallel ports
%
% You only need to run this file once after downloading the repository!
%
% Depending on the OS, this function retrieves the necessary files to
% access the parallel port on Linux & Windows. They are not included in
% the repository to avoid licensing trouble.
%
% On Linux this uses Andreas Widmann & Erik Flister's `ppdev_mex`
% on Windows Frank Schieber's `io64`
%
% Wanja Moessing Nov 29, 2016 (moessing@wwu.de)

%  Copyright (C) 2016 Wanja Mössing
%
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or
%  (at your option) any later version.
%
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with this program. If not, see <http://www.gnu.org/licenses/>.

% check where the files have been cloned to...
curPath = which('Install_EEG_trigger.m');
curPath = [curPath(1:regexp(curPath,'Install_EEG_trigger.m')-1),filesep];

% download files and add to startup.m
if ispc
    websave([curPath,'io64.mexw64'],'http://apps.usd.edu/coglab/psyc770/misc/x64/io64.mexw64');
    websave([curPath,'inpoutx64.dll'],'http://apps.usd.edu/coglab/psyc770/misc/x64/inpoutx64.dll');
    try %...installing it directly
        websave('C:\Windows\System32\inpoutx64.dll','http://apps.usd.edu/coglab/psyc770/misc/x64/inpoutx64.dll');
        try %changes between x64 versions of win10
            websave('C:\Windows\SysWOW\inpoutx64.dll','http://apps.usd.edu/coglab/psyc770/misc/x64/inpoutx64.dll');
        catch
            websave('C:\Windows\SysWOW64\inpoutx64.dll','http://apps.usd.edu/coglab/psyc770/misc/x64/inpoutx64.dll');
        end
    catch
        warning('Couldn''t install driver to system. You can find a file ''inpoutx64.dll'' in %s\n Copy this file to ''C:\Windows\System32'' \& ''C:\Windows\SysWOW64''\n Alternatively, try running Matlab as admin and run this script again.');
    end
    fprintf(2, '\nReboot your computer for the changes to take effect.\n');
end

if isunix
    websave([curPath,'ppdev_mex.mexa64'],'https://github.com/widmann/ppdev-mex/raw/master/ppdev_mex.mexa64');
    websave([curPath,'ppdev_mex.m'],'https://raw.githubusercontent.com/widmann/ppdev-mex/master/ppdev_mex.m');
    fprintf(2, 'You need to make a few manual changes to Ubuntu. Check the readme.md of this folder.')
end

%add this to startup
fid = fopen(fullfile(userpath,'startup.m'),'a');
fprintf(fid, '\n%%Add EEG-Trigger functions\naddpath(''%s'')\n',curPath);
fclose(fid);

end

