Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA9EE11A8BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 11:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbfLKKSn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 05:18:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728821AbfLKKSn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 05:18:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576059520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=1ZZwFR9dPl/aJ5Qc8lniitVZYWS9ipwRQdUPMhgi4Tg=;
        b=NY493pOft5xuNp9n5NkwIpNt3+qbe7OJldzxBOP8eP1JOLkAqfObeZaGxxt7/Be45tRmj8
        2szwU4/bdMHiKvH6kACSZbMxdKOS54IjwDx9+xkKrRvO7RTBlV8JbYL+bXqSt5xWJUFwfV
        XlcvMtFHolyVGHoiFjRbZTWQGSeKeGg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-1krzkYYPOTWogM0dzG0rmQ-1; Wed, 11 Dec 2019 05:18:36 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A98A3477;
        Wed, 11 Dec 2019 10:18:35 +0000 (UTC)
Received: from 10.255.255.10 (ovpn-205-135.brq.redhat.com [10.40.205.135])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C2C163647;
        Wed, 11 Dec 2019 10:18:33 +0000 (UTC)
Date:   Wed, 11 Dec 2019 11:18:31 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.35-rc1
Message-ID: <20191211101831.ei3qksv6c2qk4aii@10.255.255.10>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 1krzkYYPOTWogM0dzG0rmQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.35-rc1 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.35

Feedback and bug reports, as always, are welcomed.

  Karel



Util-linux 2.35 Release Notes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D

Release highlights
------------------

agetty(8) now provides a new command-line option --show-issue to print issu=
e
file(s) on the current terminal in the same way how it will be printed when
agetty(8) executed regularly.
                            =20
agetty(8) supports /run/issue and /usr/lib/issue files and directrories now=
.
                            =20
dmesg(1) escapes unprintable and potentially unsafe characters by default. =
The
new command-line option --noescape disables this feature.
                            =20
kill(1) now uses pidfd kernel feature to implement a new command-line optio=
n
--timeout. The option allows sending a sequence of follow-up signals with
defined timeouts without the possibility of race.      =20
                            =20
script(1) now used the same PTY code as su(1) --pty. script(1) has also bee=
n
massively extended to support new logging features like log signals, stdin =
or
additional session information. The new features are implemented by the new
timing file format. The changes are backwardly compatible, and the original
timing file format is still the default.=20
                            =20
scriptreplay(1) now allows to extract stdin or session summary from script(=
1)
logs.
                            =20
scriptlive(1) this NEW COMMAND re-execute stdin log by a shell in PTY sessi=
on.=20
                            =20
mount(8) and libmount now provides built-in dm-verity support if linked wit=
h
libcryptsetup. This new feature is EXPERIMENTAL and disabled by default; us=
e
--with-cryptsetup to enable.=20
                            =20
libmount now uses poll() syscall to verify /proc/self/mountinfo file consis=
tence
and it re-read the file if modified during previous read call. =20
                            =20
mount(8) now provides a new command-line option --target-prefix to mount, f=
or
example, fstab to an alternative location. This feature is usable, for exam=
ple,
for chroots or containers.              =20
                            =20
mount(8) now allows to use -o together with --all, for example, "mount --al=
l
-o ro --target-prefix /foo" will mount real-only all filesystems from fstab=
 to
/foo.             =20
                            =20
lsblk(8) provides new columns FSVER (filesystem version) and PARTTYPENAME
(human-readable partition type).
                            =20
lsblk(8) reads device properties from /dev/<devname> text file when execute=
d
with --sysroot. This is usable for tests and dumps.
                            =20
sfdisk(8) uses progress bar for --move-data and data move is now significan=
tly
faster than in previous versions as it does not use fsync during the data m=
ove
(use --move-use-fsync to disable this feature).



Changes between v2.34 and v2.35
-------------------------------

agetty:
   - Remove superfluous fflush()  [Stanislav Brabec]
   - add --show-issue to review issue output  [Karel Zak]
   - add support for /run/issue and /usr/lib/issue  [Karel Zak]
   - simplify code in dolog() preprocessor blocks  [Sami Kerola]
bash-completion:
   - (unshare) add --map-current-user  [Karel Zak]
   - Add fallback for symlinks/images  [Kevin Locke]
   - Add non-canonical device fallback  [Kevin Locke]
   - Standardize fsck/mkfs file/device  [Kevin Locke]
   - update for new script tools  [Karel Zak]
   - update options  [Sami Kerola]
blkid:
   - (man) add note about udev to --list-one  [Karel Zak]
   - retport block size of a filesystem  [Mikulas Patocka]
build-sys:
   - .gitignore hwclock-parse-date.c  [Karel Zak]
   - Include <stdlib.h> in ./configure wchar_t test  [Florian Weimer]
   - add --with-cryptsetup to config-gen.d/all.conf  [Karel Zak]
   - add UL_REQUIRES_ARCH()  [Karel Zak]
   - add missing NR underscore to UL_CHECK_SYSCALL()  [Sami Kerola]
   - add missing header  [Karel Zak]
   - check for linux/capability.h  [Karel Zak]
   - cleanup prefixed used for tests  [Karel Zak]
   - fix UTIL_LINUX_PT_SGI_H macro [lgtm scan]  [Karel Zak]
   - fix build  with pty  [Karel Zak]
   - fix out-of-tree build for hwclock  [Karel Zak]
   - fix typo  [Karel Zak]
   - improve hwclock CMOS dependences  [Karel Zak]
   - introduce $sysconfstaticdir  [Karel Zak]
   - remove duplicate includes  [Karel Zak]
   - support 'none' for parallel tests  [Karel Zak]
   - use parse-date() only for hwclock  [Karel Zak]
chfn:
   - don't append extra tailing commas  [Karel Zak]
choom:
   - improve docs  [Karel Zak]
chsh:
   - replace getpw unsafe functions with xgetpw  [Quentin Rameau]
cleanup:
   - Remove some spurious spaces  [Elliott Mitchell]
colcrt:
   - make seek to \n more robust  [Karel Zak]
column:
   - fix outputing empty column at the end of line  [Yousong Zhou]
   - pass control struct to local_wcstok()  [Sami Kerola]
cript:
   - always use decimal point numbers in logs  [Karel Zak]
disk-utils:
   - docs  fix sfdisk(8) man page typo  [Matthew Krupcale]
dmesg:
   - add --noescape  [Karel Zak]
   - do not stop on \0  [Karel Zak]
   - fix output hex encoding  [Karel Zak]
docs:
   - Fix adjtime documentation  [Pierre Labastie]
   - add GPLv3 text  [Karel Zak]
   - add sfdisk --dump and --backup improvements to TODO  [Karel Zak]
   - correct su.1 runuser reference from section 8 to 1  [Sami Kerola]
   - fix mixtyped constant.  [Andrius =C5=A0tikonas]
   - remove implemented TODO items  [Karel Zak]
   - try to find broken man references and fix them  [Sami Kerola]
   - update AUTHORS file  [Karel Zak]
   - update howto-tests.txt  [Karel Zak]
   - we have 2019 already  [Karel Zak]
   - fix typo  [Sanchit Saini]
eject:
   - use O_EXCL on default  [Karel Zak]
fallocate:
   - fallocate.1 List gfs2 as supporting punch-hole  [Andrew Price]
fdformat:
   - cast before lseek [lgtm scan]  [Karel Zak]
fdisk:
   - Correct handling of hybrid MBR  [Elliott Mitchell]
   - add hint about --wipe to warning  [Karel Zak]
   - cleanup wipe warning  [Karel Zak]
   - fix quit dialog for non-libreadline version  [Karel Zak]
   - make quit question more usable  [Karel Zak]
   - use 'r' to return from MBR to GPT  [Karel Zak]
fsfreeze:
   - remove unnecessary condition [lgtm scan]  [Karel Zak]
fstrim:
   - fix systemd service protection  [Karel Zak]
   - ignore non-directory mountpoints  [Karel Zak]
hexdump:
   - add header file guards [lgtm scan]  [Karel Zak]
hwclock:
   - add SPDX-License-Identifier(s)  [Karel Zak]
   - report rtc open() errors on --verbose  [Karel Zak]
   - use CMOS clock only if available  [Carlos Santos]
include/all-io:
   - remove unnecessary condition [lgtm scan]  [Karel Zak]
include/closestream:
   - avoid close more than once  [Karel Zak]
   - fix assignment to read-only standard streams  [Patrick Steinhardt]
include/pidfd-utils:
   - small cleanup  [Karel Zak]
include/strutils:
   - add strdup_between_structs()  [Karel Zak]
   - add strrealloc()  [Karel Zak]
include/xalloc:
   - ensure xstrdup() and xstrndup() returns nonnull attribute  [Sami Kerol=
a]
   - reindent function bodies to unify indentation  [Sami Kerola]
   - use multiline function declarations  [Sami Kerola]
kill:
   - add another ifdef  [Karel Zak]
   - add missing ifdefs  [Karel Zak]
   - deallocate follow_ups [assan]  [Karel Zak]
   - make man page more informative about --timeout  [Karel Zak]
   - report features on -V, add lish_header initialization  [Karel Zak]
   - use pidfd system calls to implement --timeout option  [Sami Kerola]
last:
   - replace strncat() with more robust mem2strcpy()  [Sami Kerola]
lib:
   - add missing license headers  [Karel Zak]
lib/fileutils:
   - add close_all_fds()  [Karel Zak]
lib/loopdev.c:
lib/path:
   - add ul_path_stat(), fix absolute paths  [Karel Zak]
   - fix missing header for `struct stat`  [Patrick Steinhardt]
   - make sure ul_path_read_buffer() derminate result  [Karel Zak]
lib/pty:
   - allow use callback from mainloop  [Karel Zak]
   - make sure we not use closed FD  [Karel Zak]
   - reset mainloop timeout on signal  [Karel Zak]
   - save sigmask, add API to free all resources  [Karel Zak]
lib/pty-session:
   - add generic PTY container code  [Karel Zak]
   - add log callbacks  [Karel Zak]
   - add loggin callback to code, follow return codes  [Karel Zak]
   - fix compilation  [Karel Zak]
   - improve debug messages  [Karel Zak]
   - make wait_child callback optional  [Karel Zak]
   - simplify example/test code  [Karel Zak]
lib/pwdutils:
   - add xgetpwuid  [Quentin Rameau]
lib/randutils:
   - re-licensing back to BSD  [Karel Zak]
lib/timeutils:
   - add %Y-%m-%dT%H %M %S to parse_timestamp()  [Karel Zak]
lib/ttyutils:
   - avoid checking same thing twice  [Sami Kerola]
libblkid:
   - (drbd) fix comment formatting  [Karel Zak]
   - (drbd) simplify padding  [Karel Zak]
   - (xfs) fix sector size calculation  [Karel Zak]
   - check number of test_blkid_save arguments correctly  [Sami Kerola]
   - do not interpret NTFS as MBR  [Karel Zak]
   - fix address sanitizer issues  [Sami Kerola]
   - fix file descriptor leak in blkid_verify()  [Karel Zak]
   - improve MD I/O size calculation [lgtm scan]  [Karel Zak]
   - improve handling of ISO files with partition tables  [Daniel Drake]
   - improve vfat entries calculation [lgtm scan]  [Karel Zak]
   - open device in nonblock mode.  [Michal Suchanek]
   - remove unnecessary condition [lgtm scan]  [Karel Zak]
libdisk:
   - write sample output to stdout  [Karel Zak]
libfdisk:
   - (bsd) cast before ask [lgtm scan]  [Karel Zak]
   - (docs) add notes about fdisk_enable_wipe()  [Karel Zak]
   - (gpt) add GUID for APFS containers  [Ernesto A. Fern=C3=A1ndez]
   - (gpt) cast number of entries [lgtm scan]  [Karel Zak]
   - (gpt) fix hybrid MBR detection, fix 'w'  [Karel Zak]
   - (script) support shortcuts in the type=3D field  [Karel Zak]
   - Fix double free of *_chs strings in fdisk_partition  [Vojtech Trefny]
   - Space before first partition may not be aligned  [Evan Green]
   - add fdisk_assign_device_by_fd()  [Karel Zak]
   - add fdisk_script_set_table()  [Karel Zak]
   - add sector-size to dump  [Karel Zak]
   - cleanup fdisk_deassign_device() docs  [Karel Zak]
   - consolidate strdup() use  [Karel Zak]
   - don't use FAT as MBR  [Karel Zak]
   - don't use NTFS as MBR  [Karel Zak]
   - fix fdisk_script_get_table()  [Karel Zak]
   - fix typos  [Marcos Mello]
   - fix variable shadowing  [Sami Kerola]
   - improve Sun partitions calculation [lgtm scan]  [Karel Zak]
   - improve partition copy on resize  [Karel Zak]
   - move GPT partition types to include/  [Karel Zak]
   - refer to partx(8) rather than to kpartx(8)  [Karel Zak]
   - use grain as small as possible  [Karel Zak]
libfidk:
   - (dos) fix tiny partitions calculation  [Karel Zak]
libmount:
   - Add libselinux dependency to pkgconfig file  [Masami Hiramatsu]
   - Keep the mnt_tab info for the existent dest in mnt_copy_fs()  [Kevin H=
ao]
   - Recognize more FUSE pseudofs (avfsd, lxcfs, vmware-vmblock)  [Darsey L=
itzenberger]
   - add support for verity devices via libcryptsetup  [Luca Boccassi]
   - add target prefix support  [Karel Zak]
   - add verity to mount -V output  [Karel Zak]
   - allow use -o together with --all  [Karel Zak]
   - cleanup strdup() use in context, add reg.test  [Karel Zak]
   - don't access struct member, use API  [Karel Zak]
   - don't use /proc/mounts fallback if filename specified  [Karel Zak]
   - fix comment referring to passno field  [Patrick Steinhardt]
   - fix free() call on error  [Karel Zak]
   - fix mnt_context_next_remount()  [Karel Zak]
   - fix potential null pointer dereference  [Sami Kerola]
   - fix typo  [Karel Zak]
   - fix typo in mnt_context_prepare_helper() [lgtm scan]  [Karel Zak]
   - improve mountinfo reliability  [Karel Zak]
   - make sure optsmode is initialized  [Karel Zak]
   - move context fs merge to separate function  [Karel Zak]
   - save current FS setting as template  [Karel Zak]
   - use fmemopen() in more robust way [coverity scan]  [Karel Zak]
   - use strdup_between_structs()  [Karel Zak]
libsmartcols:
   - cleanup and extend padding functionality  [Karel Zak]
libuuid:
   - add header file guard [lgtm scan]  [Karel Zak]
login:
   - reduce file-descriptors cleanup overhead  [Karel Zak]
   - simplify string handling  [Sami Kerola]
login-utils:
   - add header file guards [lgtm scan]  [Karel Zak]
losetup:
   - Typo fix  [Stanislav Brabec]
lsblk:
   - add FSVER (filesystem version) column  [Karel Zak]
   - add FSVER to --fs  [Karel Zak]
   - add PARTTYPENAME column  [Karel Zak]
   - fix -E segfault  [Karel Zak]
   - force to print PKNAME for partition  [Karel Zak]
   - never fallback to udev/blkid on --sysroot  [Karel Zak]
   - on --sysroot read attributes from /dev/<devname> text file  [Karel Zak=
]
   - read also GROUP,OWNER and MODE from dumps  [Karel Zak]
   - update man description of -f / --fs for current columns  [Vladimir Sla=
vik]
lscpu:
   - (man) add note about cache sizes  [Karel Zak]
   - Add HiSilicon aarch64 tsv110 cpupart  [John Garry]
   - add a new columns to --cache  [Karel Zak]
   - make code more readable [lgtm scan]  [Karel Zak]
   - prefer memcpy() to manual pointer arithmetic  [Sami Kerola]
   - top-level DMI function refactoring  [Karel Zak]
misc:
   - fix typos [codespell]  [Sami Kerola]
   - replaces atexit(close_stdout) with new close_stdout_atexit()  [Karel Z=
ak]
mkswap:
   - cast before lseek [lgtm scan]  [Karel Zak]
mount:
   - (dm-verity) update man page  [Karel Zak]
   - (man) document --target-prefix  [Karel Zak]
   - (man) small typo fixes  [Merlin B=C3=BCge]
   - add --target-prefix  [Karel Zak]
   - add verity example to man page  [Karel Zak]
   - no exit on EPERM, continue without suid  [Karel Zak]
mountpoint:
   - add --nofollow option  [Sami Kerola]
nologin:
   - Prevent error from su -c  [Stanislav Brabec]
   - silently ignore well known shell command-line options  [Sami Kerola]
partx:
   - document -d vs. --nr and fix test  [Karel Zak]
   - don't report ENXIO as error on -d  [Karel Zak]
po:
   - add pt.po (from translationproject.org)  [Pedro Albuquerque]
   - merge changes  [Karel Zak]
   - remove possibility to translate static option arguments  [Sami Kerola]
   - update de.po (from translationproject.org)  [Mario Bl=C3=A4ttermann]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update zh_CN.po (from translationproject.org)  [Boyuan Yang]
po/update-potfiles:
   - fallback to `find` when git doesn't work  [Jan Chren (rindeal)]
renice:
   - fix --help text  [Karel Zak]
   - fix arguments description in --help  [Karel Zak]
script:
   - add --echo  [Karel Zak]
   - add --log-in  [Karel Zak]
   - add --logging-format  [Karel Zak]
   - add debug messages around waitpid()  [Karel Zak]
   - add missing exit()  [Karel Zak]
   - add more information to timing log  [Karel Zak]
   - add multistream timing file initialization  [Karel Zak]
   - add note about --log-in and passwords  [Karel Zak]
   - add option --log-out  [Karel Zak]
   - add option --log-timing  [Karel Zak]
   - allow to use the same log for more streams  [Karel Zak]
   - cleanup info logging  [Karel Zak]
   - cleanup logs freeing  [Karel Zak]
   - cleanup usage  [Karel Zak]
   - default to new format when new features expected  [Karel Zak]
   - document SIGUSR1  [Karel Zak]
   - fix ECHO use, improve shell exec  [Karel Zak]
   - fix man page on --logging-format  [Karel Zak]
   - fix signalfd use  [Karel Zak]
   - listen to SIGUSR1, flush logs on the signal  [Karel Zak]
   - log additional information  [Karel Zak]
   - log file usage refactoring  [Karel Zak]
   - make --help more readable  [Karel Zak]
   - make optional argument more robust  [Karel Zak]
   - remove unused variable  [Karel Zak]
   - report also timing file, do it only once  [Karel Zak]
   - support multi-stream logging  [Karel Zak]
   - use lib/pty-session  [Karel Zak]
   - write signals to timing file  [Karel Zak]
scriptlive:
   - add --command, cleanup shell exec  [Karel Zak]
   - add man page  [Karel Zak]
   - add new command to re-execute script(1) typescript  [Karel Zak]
   - free resource at the and  [Karel Zak]
   - keep ECHO flag, improve welcome message  [Karel Zak]
   - remove unnecessary variables  [Karel Zak]
   - run shell in PTY  [Karel Zak]
   - terminate session at end of the log  [Karel Zak]
   - translate error messages too  [Karel Zak]
scriptreplay:
   - (man) add missing --log-* oprions  [Karel Zak]
   - (utils) detect empty steps  [Karel Zak]
   - add --cr-mode  [Karel Zak]
   - add --log-{in,out,io} options  [Karel Zak]
   - add --stream  [Karel Zak]
   - add --stream to the man page  [Karel Zak]
   - add --summary  [Karel Zak]
   - add -T, --log-timing  [Karel Zak]
   - check for EOF  [Karel Zak]
   - cleanup usage()  [Karel Zak]
   - fix error path  [Karel Zak]
   - fix io data log use  [Karel Zak]
   - fix typo  [Karel Zak]
   - make data log file optional for --summary  [Karel Zak]
   - make sure timing file specified  [Karel Zak]
   - move all utils to script-playutils.{c,h}  [Karel Zak]
   - print info and signals  [Karel Zak]
   - rewrite to support new timing file format  [Karel Zak]
   - skip unwanted steps  [Karel Zak]
   - use struct timeval for delay  [Karel Zak]
setpwnam:
   - use more appropriate allocation size types  [Sami Kerola]
setterm:
   - cleanup usage() and man page  [Karel Zak]
   - fix --clear  [Karel Zak]
sfdisk:
   - (--move-data) add simple progress bar  [Karel Zak]
   - (--move-data) add speed to progress bar, don't use POSIX_FADV_DONTNEED=
  [Karel Zak]
   - (--move-data) keep step size based on optimal I/O  [Karel Zak]
   - (--move-data) make log optional  [Karel Zak]
   - (man) add note about interactive mode)  [Karel Zak]
   - (move-data) improve MiB/s progress bar  [Karel Zak]
   - add --move-use-fsync, disable fsync() by default  [Karel Zak]
   - add -J between mutually exclusive options  [Karel Zak]
   - make --no-act usable for --move-data too  [Karel Zak]
   - mark --dump and --list-free as mutually exclusive  [Karel Zak]
   - write all message to stdout  [Karel Zak]
su:
   - (pty) remove unnecessary call  [Karel Zak]
   - More descriptive error message on malformed user entry  [Jakub Hrozek]
   - fix error message  [Karel Zak]
   - silence a useless warning  [Jouke Witteveen]
   - use lib/pty-session.c code for --pty  [Karel Zak]
sys-utils/manuals:
   - Make the number of the paired macros ".RS" and ".RE" equal  [Bjarni In=
gi Gislason]
term-utils:
   - add header file guards [lgtm scan]  [Karel Zak]
tests:
   - (blkid) update regression tests (due to BLOCK_SIZE)  [Karel Zak]
   - (col) avoid hardcoding of errno string  [Patrick Steinhardt]
   - (colcrt) fix reliance on EILSEQ in POSIX locale  [Patrick Steinhardt]
   - (colcrt) use env to set locale  [Karel Zak]
   - (column) use actually invalid multibytes to test encoding  [Patrick St=
einhardt]
   - (fdisk) avoid hardcoding of errno string  [Patrick Steinhardt]
   - (fdisk) update padding in output  [Karel Zak]
   - (getopt) remove unwanted paths from error output  [Karel Zak]
   - (libfdisk) remove reliance on buffer behaviour of standard streams  [P=
atrick Steinhardt]
   - (libmount) make X-* and x-* more robust  [Karel Zak]
   - (libsmartcols) add padding tests  [Karel Zak]
   - (lsblk) gather also udev attributes for new dumps  [Karel Zak]
   - (sfdisk) update move output  [Karel Zak]
   - Add test for current version (v5) of XFS filesystem  [Anatoly Pugachev=
]
   - Skip fdisk/mbr-nondos-mode on Sparc as unsupported  [Karel Zak, Anatol=
y Pugachev]
   - add --parsable, remove TS_OPT_parsable  [Karel Zak]
   - add missing 'ts_check_prog xz'  [Karel Zak]
   - add mount --all tests  [Karel Zak]
   - add remaining stderr outputs  [Karel Zak]
   - add script and scriptlive replay  [Karel Zak]
   - another prompt fix  [Karel Zak]
   - commit add missing file  [Karel Zak]
   - don't show diff for TS_KNOWN_FAIL  [Karel Zak]
   - fix --unbuffered mode with ASAN  [Karel Zak]
   - fixes blkid/md-raidX-whole on Sparc  [Anatoly Pugachev]
   - improve unbuffer check  [Karel Zak]
   - lscpu s390 nested virtualization  [Radka Skvarilova]
   - make scriptlive output more portable  [Karel Zak]
   - mark scriptlive as KNOWN_FAILED  [Karel Zak]
   - remove device name from blkdiscard output  [Karel Zak]
   - remove option --posix  [Karel Zak]
   - remove reliance on buffer behaviour of stderr/stdout streams  [Patrick=
 Steinhardt]
   - remove unbuffered ts_run feature  [Karel Zak]
   - split stdout and stderr  [Karel Zak]
   - upadet scriptlive output  [Karel Zak]
   - update fdisk output  [Karel Zak]
   - update sfdisk dumps  [Karel Zak]
   - update sfdisk wipe output  [Karel Zak]
   - use env and support both unbuffer/stdbuf  [Patrick Steinhardt]
   - use subtests for mountpoint(1)  [Karel Zak]
travis:
   - don't call tests in parallel for root  [Karel Zak]
   - force non-parallel for root  [Karel Zak]
unshare:
   - add --keep-caps option  [James Peach]
   - add --map-current-user option  [James Peach]
   - cleanup capabilities code [lgtm scan]  [Karel Zak]
wdctl:
   - add control struct  [Karel Zak]
   - default to /dev/watchdog0  [Karel Zak]
   - remove duplicate include of <unistd.h>  [Patrick Steinhardt]
   - remove printing from main()  [Karel Zak]
   - rename watch dog info struct  [Karel Zak]
wipefs:
   - Allow explicitly enable/disablement  [Sam Voss]

--=20
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

