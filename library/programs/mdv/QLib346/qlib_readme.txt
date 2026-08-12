
                       Q_Liberator V3.4 User Disk
                            ================

This is the Q-Liberator User Disk. What you find here is all that you need
to compile and run your S*BASIC programs. The various components may have
different file dates and version numbers, but if they are found on this disk
they belong - and work - together. There is no need for components from any
previous version, such as patched versions of toolkits and the like.

If you are not familiar with the Q_Liberator compiler you should read the
manual! This can be found separately at

                http://www.dilwyn.me.uk/qlib/index.html

There have been a few changes to Q_Liberator (Qlib) that will impact on
its use on older systems. Qlib now expects Qjump's Toolkit II (TK2) to be
installed to be able to compile programs (but not necessarily to run any
programs compiled with it!) TK2 is regarded as an essential extension to
QL systems. Therefore the command set that came with the original Qlib
distro, and which provided similar functionality to the equivalent TK2
commands, have been deprecated. They are still to be found in the Qlib_ext
toolkit for use with legacy software. TK2 is widely available on various
hardware extensions, or as a separate dongle. Otherwise it is now freely
available from your favourite download sites. TK2 is integrated with SMSQ/E.

(For "purists", without extended systems: Qlib V3.36 is still available.
(Use the link above to find it.) It works as well as it always has. Use
that!)

You will also need to load the ENV_BIN toolkit, which is required by Qlib.
This is included in this distro, and will be loaded for you by the BOOT
program, only if needed.

The style and organisation of this distro is based on the original
V3.35/V3.36. However, some things have changed so you should take some
time to familiarise yourself. The history_txt file lists recent changes
to the workings of the compiler. Toolkits_txt describes the new toolkit
arrangements; the deprecated commands have all been hived off into a
single toolkit for use with legacy programs when needed.

The demo programs have been slightly reworked as some of them were just
too fast for many current platforms. They also now use TK2 were possible
rather than the Qlib_ext commands.

Any programs found in the flp1_old_ directory are not maintained and are
unlikely to work without alteration. This includes CLONE.


Quick Start
-----------

Boot off flp1_ or LRUN flp1_BOOT and off you go!


Program Status
--------------

Copyright holders are still Liberation Software, 1993++

To get from there to here many people were involved:

Michael Bulford, Martin Head, Marcel Kilgus, and Per Witte (If anyone
has been missed, please shout!)

This version:

Qlib V3.46, March 2024, put together by pjw
