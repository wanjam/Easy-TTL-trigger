# Easy-TTL-trigger

A high-level Matlab/Python interface for sending TTL triggers via parallel ports

* These files are just wrapper functions. They assure that the syntax within PsychToolbox experiments is the same across OSs.
* __run Install_EEG_trigger() as admin/root after cloning to install the right drivers for your system!__

* Windows functions use Frank Schieber's `Mex-File Plug-in for Fast MATLAB Port I/O`. The original source is http://apps.usd.edu/coglab/psyc770/IO64.html
* Linux functions use Andreas Widmann's `ppdev_mex` (https://github.com/widmann/ppdev-mex).
* On Ubuntu you need to make sure that the port is actually not blocked by other modules:
    * This is copied from Andreas Widmann's post on https://beta.groups.yahoo.com/neo/groups/PSYCHTOOLBOX/conversations/messages/21077:
        In summary, please, check:
        * /etc/modules: lp commented?
        * /etc/modules-load.d/cups-filters.conf: lp commented?
        * Does /etc/default/cups possibly exist? If yes, change "LOAD_LP_MODULE=yes" to "LOAD_LP_MODULE=no“ (actually should not exist as moved to cups-filters in 14.04 but who knows)
        * /etc/modprobe.d/blacklist-psychtoolbox.conf: exists and lp NOT commented?
        * sudo update-initramfs -u -k all
        * reboot
        * lsmod | grep lp
        * lp module still loaded?
