Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA711F3CC9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 15:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgFINkE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 09:40:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53667 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729076AbgFINkD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:40:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591709998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=yj+SzDCGQlxh5s1JSMzm4Z2Cnj/Nz8HY9+/B/TH5FgE=;
        b=ccq7OM3LL+1bsQZu07nmZwsofPobMmL8QklcAjH25p3C73GDqdkSOyCgu2psFmY5uWypZW
        AviyHJS14PNrFvME6FVvwDji1lYniIg/DREONUBnUBjhqnMkpBR6nwz3jCFbN67PUc6ivZ
        YIQNlQCkKNry18Xh4Tret34N6RkhPZM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-qHCIXZKcO62FkkUkpAZ2hQ-1; Tue, 09 Jun 2020 09:39:54 -0400
X-MC-Unique: qHCIXZKcO62FkkUkpAZ2hQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D9DE835B41;
        Tue,  9 Jun 2020 13:39:51 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CE3B4768C1;
        Tue,  9 Jun 2020 13:39:49 +0000 (UTC)
Date:   Tue, 9 Jun 2020 15:39:47 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.36-rc1
Message-ID: <20200609133947.6cxfznml6ldddhnx@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The util-linux release v2.36-rc1 available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.36/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


Util-linux 2.36 Release Notes
=============================
 
Release highlights
------------------

irqtop(1) and lsirq(1) are NEW COMMANDS to monitor kernel interrupts.

cal(1) provides a new --vertical command line option to output calendar
in vertical mode.

blkzone(8) implements open/close/finish commands now.

unshare(1) and nsenter(1) commands support the time namespace now.

agetty(8) now supports multiple paths in the option --issue-file.

The commands fdisk(8), sfdisk(8), cfdisk(8), mkswap(8) and wipefs(8) now
support block devices locking by flock(2) to better behave with udevd or other
tools. Ffor more details see https://systemd.io/BLOCK_DEVICE_LOCKING/.  This
feature is controlled by a new command line option --lock and
$LOCK_BLOCK_DEVICE environmental variable.

dmesg(1) supports a new command line option --follow-new to wait and print only
new kernel messages.

fdisk(8) provides a new command line option --list-details to print more
information about partition table. Another new command line option is
--noauto-pt. It's usable to don't automatically create default partition table
on empty devices.

The command fdisk(8) and sfdisk(8) support user-friendly aliases for partition
types. For example "echo 'size=10M type=uefi' | sfdisk /dev/sda" creates EFI 
system partition on sda.

fstrim(8) supports new command line option --listed-in to specify alternatives 
where to read list of the filesystems. This option makes fstrim systemd service
file more portable between distributions.

libfdisk provides API to relocate GPT backup header. This feature is usable to 
generate small, but still valid images for containers and resize the image later.
This new feature is exported to command line by "sfdisk --relocate".

mount(8) now supports mount by ID= tag. The tag is a block device identifier as
used by udevd in /dev/disk/by-id. It's usually WWN or another HW related
identifier.  This feature is designed for users who need to avoid filesystem or
partition table dependence in fstab. The udevd is required for this tag.

login(1) supports list of "message of the day" files and directories in the
option MOTD_FILE= in /etc/login.defs now. The default value is
/usr/share/misc/motd:/run/motd:/etc/motd.

All tools which read /etc/login.defs is possible to compile with libeconf now.

The build system provides a new option --disable-hwclock-gplv3 to avoid optional 
GPLv3 code in the command hwclock(8).

more(1) has been refactored to meet 21st century codding standards. Thanks to
Sami Kerola.

Thanks to Michael Kerrisk for massive man pages cleanup.


Changes between v2.35 and v2.36
-------------------------------

Manual pages:
   - Standardize on AUTHORS as section title  [Michael Kerrisk (man-pages)]
   - Standardize on CONFORMING TO as section title  [Michael Kerrisk (man-pages)]
   - Standardize on ENVIRONMENT as section title  [Michael Kerrisk (man-pages)]
   - Standardize on EXAMPLE as section title  [Michael Kerrisk (man-pages)]
   - Standardize on EXIT STATUS as section title  [Michael Kerrisk (man-pages)]
   - Standardize on OPTIONS as section title  [Michael Kerrisk (man-pages)]
   - ipcmk.1, ipcrm.1, ipcs.1, lsipc.1  SEE ALSO  add sysvipc(7)  [Michael Kerrisk (man-pages)]
   - kill.1  improve the description of the --timout option  [Michael Kerrisk (man-pages)]
   - kill.1  various language, spelling, and formatting fixes  [Michael Kerrisk (man-pages)]
   - mount.8  Miscellaneous wording, grammar, and formatting fixes  [Michael Kerrisk (man-pages)]
   - mount.8  Rewrite FILESYSTEM-SPECIFIC MOUNT OPTIONS intro  [Michael Kerrisk (man-pages)]
   - mount.8  SEE ALSO  add some obvious references  [Michael Kerrisk (man-pages)]
   - mount.8  Typo fix (remove an accidental paragraph break)  [Michael Kerrisk (man-pages)]
   - mount.8, umount.8  Clarify that "namespace" means "mount namespace"  [Michael Kerrisk (man-pages)]
   - mount.8, umount.8  Consistently format pathnames with italic  [Michael Kerrisk (man-pages)]
   - nsenter.1  clarify the intro discussion  [Michael Kerrisk]
   - nsenter.1  note that 'file' can be a bind mount  [Michael Kerrisk]
   - nsenter.1, unshare.1  add a reference to time_namespaces(7)  [Michael Kerrisk]
   - nsenter.1, unshare.1  remove repeated references to clone(2)  [Michael Kerrisk]
   - nsenter.1, unshare.1  update references to *_namespaces(7) pages  [Michael Kerrisk]
   - order AUTHORS / COPYRIGHT / SEE ALSO / AVAILABILITY consistently  [Michael Kerrisk (man-pages)]
   - order ENVIRONMENT / FILES / CONFORMING TO consistently  [Michael Kerrisk (man-pages)]
   - order NOTES / HISTORY / BUGS / EXAMPLE consistently  [Michael Kerrisk (man-pages)]
   - rename EXAMPLE section to EXAMPLES  [Michael Kerrisk (man-pages)]
   - rename RETURN VALUES to RETURN VALUE  [Michael Kerrisk (man-pages)]
   - setpriv.1  Minor formatting and typo fixes  [Michael Kerrisk (man-pages)]
   - umount.8  use "filesystem" consistently  [Michael Kerrisk (man-pages)]
   - unshare.1  EXAMPLES  improve persistent mount namespace example  [Michael Kerrisk (man-pages)]
   - unshare.1  clarify description and example for --mount=<path>  [Michael Kerrisk (man-pages)]
   - unshare.1  clarify that --pid=<file> requires --fork  [Michael Kerrisk (man-pages)]
   - unshare.1  fix examples, part 1  [Michael Kerrisk]
   - unshare.1  fix examples, part 2  [Michael Kerrisk]
   - unshare.1  fix examples, part 3  [Michael Kerrisk]
   - unshare.1  improve intro paragraphs  [Michael Kerrisk]
   - unshare.1  typo fix  [Michael Kerrisk (man-pages)]
   - use the term "exit status"  [Michael Kerrisk (man-pages)]
   - wording fix  "another" ==> "other"  [Michael Kerrisk (man-pages)]
   - aliast -> alias  [Yuri Chornoivan]
   - ussuported -> unsupported  [Yuri Chornoivan]
   - ipcmk.1, ipcs.1, lsipc.1  explicitly mention "System V"  [Michael Kerrisk (man-pages)]
agetty:
   - (man) add "white" color name  [Karel Zak]
   - (man) fix typo  [Karel Zak]
   - extend --issue-file to support multiple paths  [Karel Zak]
   - ignore ^C  [Karel Zak]
   - save the original speed on --keep-baud  [Karel Zak]
bash-completion:
   - chmod -x  [Karel Zak]
   - umount explicitly needs gawk  [Wolfram Sang]
   - update irqtop and lsirq completions  [Sami Kerola]
bash-completion/umount:
   - shell charaters escape  [Etienne Mollier]
blkdiscard:
   - (man) offset and length must be sector aligned  [Lukas Czerner]
   - use O_EXCL, add --force  [Karel Zak]
blkzone:
   - Add --force option  [Shin'ichiro Kawasaki]
   - add open/close/finish commands  [Aravind Ramesh]
   - deny destructive ioctls on busy blockdev  [Johannes Thumshirn]
   - ioctl related code refactoring  [Damien Le Moal]
   - remove unnecessary initializations  [Karel Zak]
blockdev:
   - Don't fail on missing start sector  [Stanislav Brabec]
build-sys:
   - Fix autogenerated URL in ChangeLog  [Chris Hofstaedtler]
   - add $LDADD and libcommon to test_logindefs_LDADD  [Karel Zak]
   - add --disable-hwclock-gplv3  [Karel Zak]
   - add missing LDADD to blkid test  [Karel Zak]
   - cleanup $vendordir use  [Karel Zak]
   - fix chfn-chsh configure help text  [Karel Zak]
   - fix irqtop compilation with -lslang  [Karel Zak]
   - make lsirq and irqtop optional  [Karel Zak]
   - remove redundard includes  [Karel Zak]
   - remove unneeded include of generated file  [Zbigniew Jędrzejewski-Szmek]
   - rename automake variable to match define name  [Zbigniew Jędrzejewski-Szmek]
cal:
   - Add column mode  [Aurelien LAJOIE]
   - Add helper functions for left align  [Aurelien LAJOIE]
   - Add test, all are checked against ncal  [Aurelien LAJOIE]
   - Add weekdays into cal_control  [Aurelien LAJOIE]
   - Correctly center the year  [Aurelien LAJOIE]
   - Remove todo  [Aurelien LAJOIE]
   - Update man page  [Aurelien LAJOIE]
   - correctly set the week width  [Aurelien LAJOIE]
   - use a const char*  [Aurelien LAJOIE]
cfdisk:
   - add --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
chrt:
   - Use sched_setscheduler system call directly  [jonnyh64]
chsh:
   - (man) fix default behavior description  [Karel Zak]
ctrlaltdel:
   - display error message indicated by errno  [Sami Kerola]
dmesg:
   - add --follow-new  [Konstantin Khlebnikov]
   - adjust timestamps according to suspended time  [Konstantin Khlebnikov]
docs:
   - (man) remove double quotes (") in .SH lines  [Michael Kerrisk (man-pages)]
   - Correct ChangeLog URL to history log.  [Anatoly Pugachev]
   - Fix dead references to kernel documentation  [Yannick Le Pennec]
   - Improve grammar  [Ben Frankel]
   - Some minor fixes in some manuals  [Bjarni Ingi Gislason]
   - add note about AsciiDocs  [Karel Zak]
   - add rev(1) to TODO  [Karel Zak]
   - add swap to 1st fstab field  [Karel Zak]
   - fix spacing in irqtop and lsirq manual pages  [Sami Kerola]
   - improve size arguments description in --help output  [Karel Zak, ed]
   - kill.1 add note about shell-internal kill implementations  [Sami Kerola]
   - nsenter(1)  fix further details in PID namespace section  [Stephen Kitt]
   - remove irqtop TODO item  [Sami Kerola]
   - renice(1)  Add chrt(1) to SEE ALSO  [Jann Horn]
   - update AUTHORS file  [Karel Zak]
eject:
   - fix compiler warning [-Wformat-overflow]  [Karel Zak]
exfat:
   - Fix parsing exfat label  [Pali Rohár]
fdisk:
   - add --list-details  [Karel Zak]
   - add --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
   - add --noauto-pt  [Karel Zak]
   - add support for parttype aliases  [Karel Zak]
   - better wording for '-B' in the man page  [Wolfram Sang]
   - improve list-types readability  [Karel Zak]
   - make sure label defined for some menu entries  [Karel Zak]
   - specify in '--help' that we can have multiple devices with '-l'  [Wolfram Sang]
   - update expected test outputs with command outputs  [Sami Kerola]
findmnt:
   - make xalloc use mroe robust  [Karel Zak]
flock:
   - Add new example using shell IO redirection  [Jookia]
   - make examples in man page more readable  [Karel Zak]
fsck.cramfs:
   - fix macro usage  [Zbigniew Jędrzejewski-Szmek]
fstrim:
   - add --listed-in <file[ file ..]>  [Karel Zak]
   - do not use Protect setting in systemd service  [Karel Zak]
   - randomize timer start time across 100 minutes  [Sami Kerola]
   - rename --quite to --quite-unsupported  [Karel Zak]
   - run service and timer only if /etc/fstab is present  [Luca BRUNO]
getopt:
   - use examples installation directory in man page  [Sami Kerola]
hexdump:
   - fix typo, dcl instead of dc1  [Karel Zak]
hwclock:
   - fix audit exit status  [Karel Zak]
   - improve use of settimeofday() portability  [Karel Zak]
   - make glibc 2.31 compatible  [J William Piggott, Karel Zak]
   - update yacc file  [Sami Kerola]
ilib/strutils:
   - fix rounding in size_to_human_string()  [Karel Zak]
include:
   - add remove_entry() to env.h  [Sami Kerola]
   - cleanup pidfd inckudes  [Karel Zak]
include/c:
   - add USAGE_ARGUMENT  [Karel Zak]
include/nls:
   - remove unnecessary declaration  [Karel Zak]
ipcs:
   - ipcs.1 ipcs no longer needs read permission on IPC resources  [Michael Kerrisk]
iqrtop:
   - cleanup header  [Karel Zak]
irctop:
   - move source code to sys-utils/ directory  [Sami Kerola]
irqtop:
   - add bash-completion  [Sami Kerola]
   - add manual page  [Sami Kerola]
   - add struct irq_output  [Karel Zak]
   - add total and delta as own columns  [Sami Kerola]
   - avoid function like pre-processor definitions  [Sami Kerola]
   - change the update delay to use struct timeval  [Sami Kerola]
   - cleanup command line options  [Karel Zak]
   - cleanup man page  [Karel Zak]
   - cleanup sort stuff  [Karel Zak]
   - cleanup struct irq_stat use  [Karel Zak]
   - display number of new interupts in-between updates  [Sami Kerola]
   - do not use fixed size /proc/interrupts line buffer  [Sami Kerola]
   - don't print header for --once  [Karel Zak]
   - fix all warnings  [zhenwei pi]
   - fix open file descriptor leak  [Sami Kerola]
   - hide cursor when in interactive mode  [Sami Kerola]
   - implement a new utility to display kernel interrupt  [zhenwei pi]
   - improve header  [Sami Kerola]
   - include hostname and timestamp to output header  [Sami Kerola]
   - init README  [zhenwei pi]
   - keep WINDOW pointer in functions only  [Karel Zak]
   - keep table in functions only  [Karel Zak]
   - make util-linux build-system to build the command  [Sami Kerola]
   - minor cleanup  [Karel Zak]
   - move WINDOW back to control struct  [Karel Zak]
   - move independent code to irq-common.c  [Karel Zak]
   - move screen update to a separate function  [Sami Kerola]
   - remove dead code  [Karel Zak]
   - remove unnecessary code  [Karel Zak]
   - reorder function  [Karel Zak]
   - separate normal and ncurses way  [Karel Zak]
   - separate screen and scols code  [Karel Zak]
   - simplify terminal resizing  [Karel Zak]
   - small cleanup in main()  [Karel Zak]
   - tidy coding style and update usage() text  [Sami Kerola]
   - trim white spaces from end of name field  [Sami Kerola]
   - use -J for JSON  [Karel Zak]
   - use epoll event loop  [Sami Kerola]
   - use lib/monotonic.c to determine uptime  [Sami Kerola]
   - use libsmartcols  [Sami Kerola]
   - use memory allocation that check errors  [Sami Kerola]
   - use name instead of desc as irq name field referal  [Sami Kerola]
   - use runtime control structure  [Sami Kerola]
   - use util-linux libcommon facilities  [Sami Kerola]
kill:
   - include sys/types.h before checking SYS_pidfd_send_signal  [Sami Kerola]
lib/blkdev:
   - add support for --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
lib/color-names:
   - add "white" between human-readable  [Karel Zak]
lib/mangle:
   - check for the NULL string argument  [Gaël PORTAY]
lib/mbsalign:
   - add function to calculate width  [Karel Zak]
lib/pwdutils:
   - add xgetgrnam  [Matthew Harm Bekkema]
lib/randutils:
   - use explicit data types for bit ops  [Karel Zak]
lib/strutils:
   - add test for strdup_to_struct_member()  [Karel Zak]
   - fix floating point exception  [Karel Zak]
   - fix parse_size() for large numbers  [Karel Zak]
   - fix uint64_t overflow  [Karel Zak]
   - remove unnecessary include  [Karel Zak]
   - use directly err()  [Karel Zak]
libblkid:
   - (docs) document new function  [Karel Zak]
   - Add support for zonefs  [Damien Le Moal]
   - Fix UTF-16 support in function blkid_encode_to_utf8()  [Pali Rohár]
   - add dax capability detection in topology probing  [Anthony Iliopoulos]
   - fix compiler warning [-Wsign-compare]  [Karel Zak]
   - fix fstatat() use in blkid__scan_dir()  [Karel Zak]
   - move UTF encoding function to lib/  [Karel Zak]
   - remove unnecessary uuid.h  [Karel Zak]
libfdisk:
   - (docs) document new functions  [Karel Zak]
   - (docs) fix typos  [Karel Zak]
   - (dos) be more explicit in fdisk_verify_disklabel() output  [Karel Zak]
   - (dos) be more robust about max number of partitions  [Karel Zak]
   - (dos) fix default partition start  [Karel Zak]
   - (gpt) add GPT debug mask  [Karel Zak]
   - (gpt) add functionality to move backup header  [Karel Zak]
   - (gpt) cleanup and consolidate write code  [Karel Zak]
   - (gpt) cleanup entries array size calculations  [Karel Zak]
   - (gpt) partition name default to empty string  [Karel Zak]
   - (script) accept sector-size, ignore unknown headers  [Karel Zak]
   - (script) fix memory leak  [Karel Zak]
   - (script) fix partno_from_devname()  [Karel Zak]
   - (script) fix segmentation fault  [Gaël PORTAY]
   - add Linux /var, /var/tmp and root verity GPT partition types  [nl6720]
   - add fdisk_set_disklabel_id_from_string()  [Karel Zak]
   - add missing comments  [Karel Zak]
   - add partition type aliases and shortcuts  [Karel Zak]
   - fix __copy_partition()  [Karel Zak]
   - fix alignment logic for tiny partitions  [Karel Zak]
   - fix const char mess  [Karel Zak]
   - fix partition calculation for BLKPG_* ioctls  [Karel Zak]
   - fix pointer wraparound warning  [Sami Kerola]
   - make sure we check for maximal number of partitions  [Karel Zak]
   - make sure we use NULL after free  [Karel Zak]
   - remove unwanted assert()  [Karel Zak]
   - use ul_encode_to_utf8()  [Karel Zak]
libmount:
   - (umount) FS lookup refactoring  [Karel Zak]
   - (umount) fix FD leak  [Karel Zak]
   - Avoid triggering autofs in lookup_umount_fs_by_statfs  [Fabian Vogt]
   - add support for ID=  [Karel Zak]
   - add support for signed verity devices  [Luca Boccassi]
   - do not unnecessarily chmod utab.lock  [Tycho Andersen]
   - fix mount -a EBUSY for cifs  [Roberto Bergantinos Corpas]
   - fix x- options use for non-root users  [Karel Zak]
   - improve smb{2,3} support  [Karel Zak]
   - make mnt_context_find_umount_fs() more extendable  [Karel Zak]
   - move "already mounted" code to separate function  [Karel Zak]
   - smb2 is unsupported alias  [Karel Zak]
   - try read-only mount on write-protected superblock too  [Karel Zak]
   - use mnt_stat_mountpoint() on more places  [Karel Zak]
libsmartcols:
   - don't calculate with encoding on scols_table_enable_noencoding()  [Karel Zak]
libuuid:
   - add uuid_parse_range()  [Zane van Iperen]
   - add uuid_parse_range() to man page and symbol-table  [Karel Zak]
   - ensure variable is initialized [cppcheck]  [Sami Kerola]
   - improve uuid_unparse() performance  [Aurelien LAJOIE]
   - remove function alias  [Karel Zak]
login:
   - add MOTD_FIRSTONLY=  [Karel Zak]
   - add support for directories in MOTD_FILE=  [Karel Zak]
   - avoid lseek() with pread() and pwrite()  [Sami Kerola]
   - cleanup -f in usage() and comments  [Karel Zak]
   - fix -f description in the man-page  [Karel Zak]
   - keep default MOTD_FILE= backwardly compatible  [Karel Zak]
logindefs:
   - use xalloc.h, code cleanup  [Karel Zak]
lsblk:
   - Fall back to ID_SERIAL  [Sven Wiltink]
   - Ignore hidden devices  [Ritika Srivastava]
   - add dax (direct access) capability column  [Anthony Iliopoulos]
   - fix -P regression from v2.34  [Karel Zak]
lscpu:
   - Adapt MIPS cpuinfo  [Jiaxun Yang]
   - Add shared cached info for s390 lscpu -C  [Sumanth Korikkar]
   - cleanup caches code  [Karel Zak]
   - fix SIGSEGV on archs without drawers & books  [Karel Zak]
   - use official name for HiSilicon tsv110  [Karel Zak]
lsirq:
   - add -P option  [Karel Zak]
   - add -n option  [Karel Zak]
   - add new command  [Karel Zak]
   - mark --json and --pairs options mutually exclusive  [Sami Kerola]
lslogins:
   - remove unnecessary brackets  [Karel Zak]
   - use lastlog as wtmp fallback  [Sami Kerola]
lsns:
   - add time namespace support  [Adrian Reber]
mkswap:
   - add --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
more:
   - add display_file() to show files and stdin  [Sami Kerola]
   - avoid defining special characters locally  [Sami Kerola]
   - avoid libmagic telling an empty file is binary  [Sami Kerola]
   - do not allocate shell command buffer from stack  [Sami Kerola]
   - do not reset parent process terminal in execute()  [Sami Kerola]
   - drop setuid permissions before executing anything  [Sami Kerola]
   - fix SIGSTOP and SIGCONT handling  [Sami Kerola]
   - fix moving backwards so that it can reach begining of the file  [Sami Kerola]
   - make execute() more robust and timely  [Sami Kerola]
   - make page and arrow up/down to update view  [Sami Kerola]
   - move code blocks from more_key_command() to functions  [Sami Kerola]
   - move currently open file to control structure  [Sami Kerola]
   - move runtime usage output to a function  [Sami Kerola]
   - refactor and clarify code  [Sami Kerola]
   - remove kill_line() in favor of erase_prompt()  [Sami Kerola]
   - remove underlining related code  [Sami Kerola]
   - replace siglongjmp() and signal() calls with signalfd()  [Sami Kerola]
   - restructure print_buf() if-else with continue  [Sami Kerola]
   - simplify initterm()  [Sami Kerola]
   - target all standard streams when calling fflush()  [Sami Kerola]
   - tell in run time help what the 'v' will execute as editor  [Sami Kerola]
   - use getopt_long() to parse options  [Sami Kerola]
   - use libmagic to identify binary files  [Sami Kerola]
   - use off_t and cc_t to clarify what variables attempt to represent  [Sami Kerola]
   - use single exit path to ensure resource freeing is unified  [Sami Kerola]
mount:
   - (man) cleanup devices identifiers section  [Karel Zak]
   - Update man page Synopsis  [Marcel Waldvogel]
   - support "-o move" on command line  [Karel Zak]
nsenter:
   - add support for the time namespace  [Adrian Reber]
po:
   - merge changes  [Karel Zak]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
pylibmount:
   - cleanup and sync UL_RaiseExc  [Karel Zak]
rev:
   - (man) add note about limitations  [Karel Zak]
   - report line on error  [Karel Zak]
script:
   - fix minor warning  [Sami Kerola]
scriptlive:
   - fix man page formatting  [Jakub Wilk]
   - fix typo  [Jakub Wilk]
scriptlive, scriptreplay:
   - cleanup --maxdelay man page description  [Karel Zak]
setarch:
   - fix stderr handling in uname26 tests  [Helge Deller]
sfdisk:
   - (man) add note about type and shortcuts collision  [Karel Zak]
   - (man) fix typo  [Gaël PORTAY]
   - add --disk-id to change disk UUID/ID  [Karel Zak]
   - add --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
   - add --relocate command  [Karel Zak]
   - avoid unneeded empty lines with '--list-free'  [Wolfram Sang]
   - extend --part-type, support aliases  [Karel Zak]
   - fix --append to PT with gaps  [Karel Zak]
   - fix previous --append patch, improve man page  [Karel Zak]
   - fix ref-counting for the script  [Karel Zak]
   - make sure we do not overlap on --move  [Karel Zak]
   - only report I/O errors on --move-data  [Karel Zak]
   - remove broken step alignment for --move  [Karel Zak]
   - avoid unneeded empty lines with '--list'  [Wolfram Sang]
su, runuser:
   - (man) add more info about PATH and PAM  [Karel Zak]
swapoff:
   - cleanup EXIT STATUS  [Karel Zak]
   - do not use 1 exist status at all  [Karel Zak]
tests:
   - Add UDF hdd image with emoji label created by mkudffs 2.2  [Pali Rohár]
   - Fix for misc/fallocate test build failure.  [Mark Hindley]
   - add STATIC binaries to build-sys tests  [Karel Zak]
   - add sanitize_env() check  [Sami Kerola]
   - add sfdisk --dump test  [Karel Zak]
   - add zonefs blkid test  [Karel Zak]
   - cleanup fdisk based stuff  [Karel Zak]
   - don't use ASAN in build tests  [Karel Zak]
   - fixes eject/umount on SPARC  [Anatoly Pugachev]
   - fixes fdisk/align-512-* tests  [Anatoly Pugachev]
   - fixes libmount/ on SPARC  [Anatoly Pugachev]
   - fixes mount tests on SPARC  [Anatoly Pugachev]
   - sfdisk fill correctly gaps if default start requested  [Karel Zak]
   - update build-sys tests  [Karel Zak]
   - update fdisk outputs due to sizes rounding change  [Karel Zak]
umount:
   - don't try it as non-suid if not found mountinfo entry  [Karel Zak]
unshare:
   - Fix PID and TIME namespace persistence  [michael-dev]
   - Support names for map-user/group options  [Matthew Harm Bekkema]
   - allow custom uid/gid mappings in userns  [Matthew Harm Bekkema]
   - fix help message indentation  [Adrian Reber]
   - support the time namespace  [Adrian Reber]
   - use '-T' for time namespace instead of '-t'  [Adrian Reber]
various:
   - fix more lgtm scan warnings  [Sami Kerola]
   - use threadsafe versions of time functions [lgtm scan]  [Sami Kerola]
wipefs:
   - add --lock and LOCK_BLOCK_DEVICE  [Karel Zak]
   - fix man page --no-headings short option  [Karel Zak]
write:
   - fix potential string overflow  [Sami Kerola]

