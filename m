Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE4745B4E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Jun 2019 13:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfFNLRc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Jun 2019 07:17:32 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:46975 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbfFNLRb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Jun 2019 07:17:31 -0400
Received: by mail-pl1-f180.google.com with SMTP id e5so881976pls.13;
        Fri, 14 Jun 2019 04:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XQFxWKXxZ/vIj/BAKwX0DHchb/pF8RG6PoM/CxBSxY8=;
        b=WINe6qml82EJ9vHBp0EDw8MasCV3EheTs2ltcWT/85JV0M/D25FWcb2+zPcMwiwhhb
         rVWiua5Rw2tWHWZyIr9n7LG0C8ZZDkw53p2PmUbPKOl8TPwLyTtO722MRen6e400kqJ2
         tlEPJKAiEbK3nJwUhKR6ITuxNbUAQitG4zrGtjebVh+gOgWeT+e8UwVIqrECdA9il/+K
         6gHg4kezrS2OASE9F9Od3s7QebDei6LFaSvu8tB3DvajQUH5zs9KmlaV7cf1XTWZenGM
         Pkir/etG/cQLyS4Wc40qjOMVL69vuBbyLEegtLJvNwIFme1LOqkjiIulvLr4h7RTZawH
         fe5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XQFxWKXxZ/vIj/BAKwX0DHchb/pF8RG6PoM/CxBSxY8=;
        b=jsDkjj/WdNZ+r43WzGLIbKqTZs63hF0mjW+J8ro+27yCJMgVQHD9mdfcpcvF+2rx2M
         z75dRMAA7GcsaE1a4uWvfN16E/m6OGU4KYvG8OWF/Y2IyVnnBKyFlhBpMINegbqF2m8h
         zZMbMItNQ8KfNXhZYXRncCJRQitAR3flnQ0W1xf5l6+1taxFw5SNUxxHTf7hsJYdFbNr
         JnU9AqFdQmXpQFvFa87INjOTWlNSjxqYIP4dVau4aMlR7TK2MYNEOgVVz3BmoaMu6m2F
         D3659zf4xv4WyBXW1GKaEVvnkKgZiWWD2Y+ZMhf4Up9PovGy5nEsOWZ9/5CG/6RUBaUe
         5IsA==
X-Gm-Message-State: APjAAAU+A+1LZBKlsvF8q5whg8y5CNnC8AcE/HU5+LdQJXedSz+YKyXh
        cvsn+fMf8vl8gypFmKnx7Q9sGFOTVFsTEQ==
X-Google-Smtp-Source: APXvYqzrHR/firbuM/yRTmFNCZq+AgJn/T0rOmvYzkH3jIXW7YxWpppAx9rB0gOZ8tLHvHQdhBXr/Q==
X-Received: by 2002:a17:902:8489:: with SMTP id c9mr12556145plo.327.1560511049999;
        Fri, 14 Jun 2019 04:17:29 -0700 (PDT)
Received: from Gentoo ([103.231.91.70])
        by smtp.gmail.com with ESMTPSA id 27sm6820273pgl.82.2019.06.14.04.17.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 04:17:29 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:47:18 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.34
Message-ID: <20190614111718.GA18052@Gentoo>
References: <20190614110304.m44hgnlpdmhvoq6t@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline
In-Reply-To: <20190614110304.m44hgnlpdmhvoq6t@ws.net.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks, karel!

On 13:03 Fri 14 Jun , Karel Zak wrote:
>The util-linux release v2.34 is available at
>
>  http://www.kernel.org/pub/linux/utils/util-linux/v2.34/
>
>Feedback and bug reports, as always, are welcomed.
>
>  Karel
>
>
>
>Util-linux 2.34 Release Notes
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
>Release highlights
>------------------
>
>hardlink -- NEW COMMAND to consolidate duplicate files via hardlinks has b=
een
>merged into util-linux. The new command is not enabled by default. The ori=
ginal
>author is Jakub Jelinek.
>
>The command lsblk(8) has been rewritten. Now it keeps all hierarchy of the=
 block
>devices in memory before it's printed. It allows to modify or reorder the =
graph.
>The new features based on this functionality are:
>
> * output de-duplication by --dedup, for example 'lsblk --dedup WWN' to
>   de-duplicate devices by WWN number (e.g. multi-path devices)
>
> * merge repeating parts of the tree by --merge, see for example:
>   http://karelzak.blogspot.com/2018/11/lsblk-merge.html
>
>The command umount(8) now supports user unmount for FUSE mounts. The requi=
rement
>is FUSE specific user_id=3D<uid> in /proc/self/mountinfo for the filesyste=
m.
>
>The command mount(8) now allows to use "--all -o remount". In this case all
>filters (-t and -O) are applied to the table of already mounted filesystem=
s.
>
>The command su(1) now prefers /etc/default/su over /etc/login.defs and
>ENV_SUPATH over ENV_ROOTPATH. The option --pty has been improved and it is=
 not
>marked as experimental anymore.
>
>The command unshare(1) now allows set user ID and group ID by new command =
line
>options -S/--setuid and -G/--setgid; and new options -R/--root and -w/--wd
>allows to set root and working directory (like nsenter(1)).
>
>The command fstrim(8) does not suppress some well known trimming warnings =
by
>default anymore.  It's necessary to explicitly use a new command line opti=
on
>--quiet (recommended for crond or systemd).
>
>The command lscpu(1) now prints 'Frequency boost' and 'Vulnerability' fiel=
ds.
>The caches calculation has been modified to print summary from all system =
caches
>rather than per code numbers; and new command line option --caches lists d=
etails
>about changes.
>
>The command logger(1) merges multiple MESSAGE=3D lines into one journald m=
essage.
>
>The library libblkid now does not depend on libuuid and newly supports DRB=
D9
>detection.
>
>The libsmartcols has been extended to support N:M relationships when print
>tree-like output. This new feature is used by new lsblk --merge output.
>
>The systemd services for fstrim and uuidd now contains hardening settings =
to
>improve security and service isolation.
>
>The command fstrim now trims also root filesystem on --fstab and checks for
>read-only filesystems on --all and --fstab.
>
>The package build-system now accepts --enable-asan to compile commands and
>execute regression tests with addresses sanitizer.
>
>
>Stable maintenance releases between v2.33 and v2.34
>---------------------------------------------------
>
>util-linux 2.33.1 [Jan 1 2019]
>
> * https://www.kernel.org/pub/linux/utils/util-linux/v2.33/v2.33.1-Release=
Notes
>   https://www.kernel.org/pub/linux/utils/util-linux/v2.33/v2.33.1-ChangeL=
og
>
>util-linux 2.33.2 [Apr 4 2019]
>
> * https://www.kernel.org/pub/linux/utils/util-linux/v2.33/v2.33.2-Release=
Notes
>   https://www.kernel.org/pub/linux/utils/util-linux/v2.33/v2.33.2-ChangeL=
og
>
>
>Changes between v2.33 and v2.34
>-------------------------------
>
>agetty:
>   - Fix input of non-ASCII characters in get_logname()  [Stanislav Brabec]
>   - Return old behavior with empty logname  [Stanislav Brabec]
>   - Switch to 8-bit processing in get_logname() for UTF-8 terminals  [Sta=
nislav Brabec]
>   - fix output of escaped characters  [Christian Hesse]
>   - fix portability issues  [Samuel Thibault]
>bash-completion:
>   - add fstrim --quiet  [Karel Zak]
>   - add hardlink completion  [Sami Kerola]
>   - umount support relative path and ~ as home shorthands  [Sami Kerola]
>   - update options before release  [Sami Kerola]
>blkid:
>   - (man) cleanup return code section  [Karel Zak]
>   - fix usage()  [Karel Zak]
>   - improve strcpy() usage [coverity scan]  [Karel Zak]
>   - make PART_ENTRY_* tags optional (add --no-part-details)  [Karel Zak]
>blkzone:
>   - remove never read value  [Karel Zak]
>blockdev:
>   - make =E2=80=93-getbsz less confusing for end-users  [Karel Zak]
>build-sys:
>   - add 'make checklibdoc'  [Karel Zak]
>   - add --with-pkgconfigdir  [Karel Zak]
>   - add ASAN_LDFLAGS  [Karel Zak]
>   - add PKG_INSTALLDIR fallback  [Karel Zak]
>   - add check-programs make target  [Karel Zak]
>   - add devel-non-asan.conf  [Karel Zak]
>   - add info about ASAN  [Karel Zak]
>   - do not require crypt()  [Karel Zak]
>   - do not require dirfd()  [Karel Zak]
>   - don't use ASAN on XOS  [Karel Zak]
>   - enable ASAN on travis-ci  [Karel Zak]
>   - fix crypt() detection without -lcrypt  [Johannes Nixdorf]
>   - improve error message  [Karel Zak]
>   - make fdisk, sfdisk, cfdisk optional (enabled by default)  [Carlos San=
tos]
>   - make sure HAVE_TIMER_CREATE defined  [Karel Zak]
>   - release++ (v2.34-rc1)  [Karel Zak]
>   - release++ (v2.34-rc2)  [Karel Zak]
>   - use REALTIME_LIBS for hwclock due to monotonic.c  [Karel Zak]
>   - use __SANITIZE_ADDRESS__ rather than custom USE_CLOSE_ATEXIT  [Karel =
Zak]
>cal:
>   - fix Sexit and Senter  [Karel Zak]
>   - make sure months_in_row makes sense [coverity scan]  [Karel Zak]
>   - use standout mode on monochrome terminals  [Karel Zak]
>cfdisk:
>   - free libfdisk items  [Karel Zak]
>   - simplify code  [Karel Zak]
>chcpu:
>   - fix memory leak  [Karel Zak]
>chmem:
>   - add initilizer [clang]  [Sami Kerola]
>choom:
>   - fix negative adjust score usage  [Karel Zak]
>col:
>   - improve error message, update regression test  [Karel Zak]
>   - make flush_line() a little bit robust  [Karel Zak]
>column:
>   - Address fill-order confusion in documentation  [dana]
>   - fix "maybe be" duplication  [Austin English]
>   - make code more robust [coverity scan]  [Karel Zak]
>dmesg:
>   - correct "-n, --console-level level" example in manual page  [Jean-Phi=
lippe ROMAIN]
>   - make strtok() use more robust  [Karel Zak]
>docs:
>   - TODO lscpu --list-caches  [Karel Zak]
>   - add col(1) to TODO  [Karel Zak]
>   - add link to mail list archive  [Sami Kerola]
>   - add lsblk --merge to TODO  [Karel Zak]
>   - add lscpu --caches to ReleaseNotes  [Karel Zak]
>   - fix typo  [Jakub Wilk]
>   - fix typos [codespell]  [Sami Kerola]
>   - update AUTHORS file  [Karel Zak]
>   - update TODO  [Karel Zak]
>   - update v2.34-ReleaseNotes  [Karel Zak]
>fallocate:
>   - make posix_fadvise() use more readable for analyzers  [Karel Zak]
>fdisk:
>   - add note about -S and -H  [Karel Zak]
>   - initialize buffers for get_user_reply() [coverity scan]  [Karel Zak]
>   - make partition types uses more robust  [Karel Zak]
>   - support CTRL+C on change-partition-type dialog  [Karel Zak]
>   - use 2 decimal places for size in disk summary  [Karel Zak]
>fincore:
>   - remove unused variable [clang scan]  [Karel Zak]
>findmnt:
>   - (verify) check mnt_table_next_fs() return code [coverity scan]  [Kare=
l Zak]
>   - (verify) ignore passno for XFS  [Karel Zak]
>   - fix filters use on --list  [Karel Zak]
>   - keep it easy for static analyzers  [Karel Zak]
>fsck:
>   - (man) labels are available for all filesystems  [Karel Zak]
>fsck.cramfs:
>   - fix utimes() usage  [Karel Zak]
>   - use utimes() instead of utime() that is obsolete  [Sami Kerola]
>fstrim:
>   - Add Documentation key to fstrim.service  [Andreas Henriksson]
>   - Add hardening settings to fstrim.service  [Andreas Henriksson]
>   - Fix fstrim_all() comment  [Stanislav Brabec]
>   - add --quiet option to suppress error messages  [Sami Kerola]
>   - affect only warnings by --quiet  [Karel Zak]
>   - check for read-only devices on -a/-A  [Karel Zak]
>   - document kernel return minlen explicitly  [Wang Shilong]
>   - fix usage()  [Karel Zak]
>   - get realpath before trim ioctl  [Wang Shilong]
>   - properly de-duplicate fstrim -A  [Stanislav Brabec]
>   - trim also root FS on --fstab  [Karel Zak]
>   - update man page, reuse libmnt_iter  [Karel Zak]
>   - use long options in systemd service file  [Sami Kerola]
>fstrim -a/-A:
>   - Skip read-only volumes  [Stanislav Brabec]
>fstrim.c:
>   - Remove commnet about vfat not supporting fstrim  [Marcos Paulo de Sou=
za]
>hardlink:
>   - (man) add AVAILABILITY  [Karel Zak]
>   - add first simple tests  [Ruediger Meier]
>   - add long options  [Karel Zak]
>   - avoid uninitialized variables [clang scan]  [Karel Zak]
>   - cleanup error messages, use xalloc.h  [Karel Zak]
>   - cleanup global variables  [Karel Zak]
>   - cleanup verbose and warning messages  [Karel Zak]
>   - enable build with and without pcre2  [Ruediger Meier]
>   - fix bad formatting in hardlink.1  [Karel Zak]
>   - fix compiler warnings  [Ruediger Meier]
>   - fix compiler warnings [-Wsign-compare -Wmaybe-uninitialized]]  [Karel=
 Zak]
>   - make code more readable  [Karel Zak]
>   - move global variables to a control structure  [Sami Kerola]
>   - remove \r from output  [Karel Zak]
>   - remove typedefs  [Karel Zak]
>   - rename function  [Karel Zak]
>   - retire NIOBUF in favour of more common BUFSIZ  [Sami Kerola]
>   - style indentations and license header  [Ruediger Meier]
>   - use flexible array member rather than zero-size array  [Sami Kerola]
>   - util-linux usage  [Ruediger Meier]
>hardlink, wall:
>   - fix variable shadowing  [Sami Kerola]
>hexdump:
>   - fix potential null pointer dereference warnings  [Sami Kerola]
>hwclock:
>   - don't use uninitialized value [coverity scan]  [Karel Zak]
>   - use monotonic time to measure how long setting time takes  [Sami Kero=
la]
>include:
>   - add indirect monotonic clock id specifier  [Sami Kerola]
>   - add no return function attribute  [Sami Kerola]
>include/c:
>   - add print_version() macro  [Karel Zak]
>   - check returns_nonnull function attribute with __GNUC_PREREQ  [Sami Ke=
rola]
>   - re-add type checking in container_of()  [Ruediger Meier]
>   - use __has_attribute  [Karel Zak]
>   - use returns_nonnull function attribute in xalloc.h  [Sami Kerola]
>include/closestream:
>   - add close_stdout_atexit()  [Karel Zak]
>include/list:
>   - add list_entry_is_first() and list_count_entries()  [Karel Zak]
>include/path.h:
>   - remove duplicate header inclusion  [Sami Kerola]
>include/strutils:
>   - add functions to replace and remove chars from string  [Karel Zak]
>   - fix potential null pointer dereference  [Sami Kerola]
>ipcs:
>   - check return value when read from /proc [coverity scan]  [Karel Zak]
>last:
>   - do not use non-standard __UT_NAMESIZE  [Patrick Steinhardt]
>   - fix wtmp user name buffer overflow [asan]  [Sami Kerola]
>ldattach:
>   - Check for value of _HAVE_STRUCT_TERMIOS_C_ISPEED  [Khem Raj]
>lib/canonicalize:
>   - do restricted canonicalize in a subprocess  [Rian Hunter, Karel Zak]
>   - fix compiler warning [-Wsign-compare]  [Karel Zak]
>   - fix typo  [Karel Zak]
>   - verify DM paths [coverity scan]  [Karel Zak]
>lib/colors:
>   - fix "maybe be" duplication  [Austin English]
>   - force to "never" mode on non-terminal output  [Karel Zak]
>   - keep static analyzer happy [coverity scan]  [Karel Zak]
>   - remove redundant if statement  [Sami Kerola]
>   - remove unnecessary goto  [Karel Zak]
>lib/fileutils:
>   - add xreaddir()  [Karel Zak]
>lib/ismounted:
>   - use xstrncpy()  [Karel Zak]
>lib/loopdev:
>   - differentiate between setter()s and ioctl calls  [Karel Zak]
>   - set blocksize when create a new device  [Karel Zak]
>lib/loopdev.c:
>   - Inline loopcxt_has_device  [Marcos Paulo de Souza]
>   - Retry LOOP_SET_STATUS64 on EAGAIN  [Romain Izard]
>lib/mangle:
>   - fix possible null pointer dereference [cppcheck]  [Sami Kerola]
>lib/path:
>   - allow to close dirfd  [Karel Zak]
>   - consolidate ul_path_mkpath() usage  [Karel Zak]
>   - fix possible NULL dereferencing [coverity scan]  [Karel Zak]
>   - fix possible NULL pointer dereferencing [coverity scan]  [Karel Zak]
>   - fix resource leak [coverity scan]  [Karel Zak]
>   - fix ul_path_get_dirfd() usage [coverity scan]  [Karel Zak]
>   - remove extra semi-colons  [Karel Zak]
>   - use xstrncpy()  [Karel Zak]
>lib/strutils:
>   - keep static analyzer happy [coverity scan]  [Karel Zak]
>   - parse_size() fix frac digit calculation  [Karel Zak]
>   - parse_size() fix frac with zeros  [Karel Zak]
>   - support two decimal places in size_to_human_string() output  [Karel Z=
ak]
>lib/sysfs:
>   - add function to detect partitioned devices  [Karel Zak]
>   - fix reference counting for parent  [Karel Zak]
>   - use xstrncpy()  [Karel Zak]
>lib/timer:
>   - add fallback if timer_create() not available  [Karel Zak]
>lib/ttyutils:
>   - introduce get_terminal_stdfd()  [Karel Zak]
>libblkid:
>   - (bluestore) terminate magic strings array  [Karel Zak]
>   - (ntfs) fix compiler warning [-Wpedantic]  [Karel Zak]
>   - (silicon raid) improve checksum calculation [-Waddress-of-packed-memb=
er]  [Karel Zak]
>   - Don't check BLKID_PROBE_INTERVAL in blkid_verify  [Nikolay Borisov]
>   - Fix hidding typo  [Andreas Henriksson]
>   - Set BLKID_BID_FL_VERIFIED in case revalidation is not needed  [Nikola=
y Borisov]
>   - add check for DRBD9  [Roland Kammerer]
>   - don't ignore blkid_probe_set_magic() errors [coverity scan]  [Karel Z=
ak]
>   - fix detection of dm-integrity superblock  [Milan Broz]
>   - fix detection of dm-integrity superblock version  [Milan Broz]
>   - fix possible uninitialized value use [coverity scan]  [Karel Zak]
>   - improve whole-disk detection when read /proc/partitions  [Karel Zak]
>   - make partitions reference counting more robust [coverity scan]  [Kare=
l Zak]
>   - remove dependence on libuuid  [Karel Zak]
>   - remove unneeded fields from struct bcache_super_block  [Sami Kerola]
>   - stratis  correct byte order  [Tony Asleson]
>   - tiny code simplification  [Karel Zak]
>libfdisk:
>   - (bsd) improve checksum calculation [-Waddress-of-packed-member]  [Kar=
el Zak]
>   - (docs) add reference to v2.33  [Karel Zak]
>   - (dos) Use strtoul to parse the label-id  [Juerg Haefliger]
>   - (dos) improve first unused sector for logical partitions  [Karel Zak]
>   - (dos) rewrite fist/last free sector functions  [Karel Zak]
>   - (gpt) add HiFive Unleashed bootloader partition UUIDs  [Icenowy Zheng]
>   - (sgi) improve checksum calculation [-Waddress-of-packed-member]  [Kar=
el Zak]
>   - add comment to fdisk_set_first_lba()  [Karel Zak]
>   - assert if self_pte() returns NULL  [Sami Kerola]
>   - avoid division by zero [clang scan]  [Karel Zak]
>   - avoid memory leak [coverity scan]  [Karel Zak]
>   - properly check return code of add_to_partitions_array() [coverity sca=
n]  [Karel Zak]
>   - remove unused code [clang scan]  [Karel Zak]
>   - sanity check, to prevent overlapping partitions from being partly rep=
orted as free  [Fabian.Kirsch@dlr.de]
>   - use list_add_tail() in more robust way  [Karel Zak]
>libmount:
>   - (docs) add reference to v2.33 and v2.34  [Karel Zak]
>   - (fuse) follow only user_id=3D on umount  [Karel Zak]
>   - (tabdiff) use list_add_tail() in more robust way  [Karel Zak]
>   - (umount) make mnt_stat_mountpoin() usable for relative paths  [Karel =
Zak]
>   - Recognize more fuse filesystems as pseudofs and netfs  [Stanislav Bra=
bec]
>   - Support unmount FUSE mounts  [Rian Hunter, Karel Zak]
>   - add bpf between pseudo filesystems  [Karel Zak]
>   - add mnt_table_{find,insert,move}_fs()  [Karel Zak, Tim Hildering]
>   - add selinuxfs between pseudo filesystems  [Karel Zak]
>   - add support for MS_REMOUNT on --all  [Karel Zak]
>   - avoid possible null pointer dereference [cppcheck]  [Sami Kerola]
>   - check table membership before adding entry  [Tim Hildering]
>   - don't use sscanf() for fstab parsing  [Karel Zak]
>   - don't use sscanf() for mountinfo parsing  [Karel Zak]
>   - don't use sscanf() for swaps parsing  [Karel Zak]
>   - export mnt_guess_system_root() by API  [Karel Zak]
>   - fix "maybe be" duplication  [Austin English]
>   - fix compiler warning [-Wsometimes-uninitialized]  [Karel Zak]
>   - fix docs typo  [Karel Zak]
>   - fix memleak on parse errors  [Karel Zak]
>   - fix memory leak on error [coverity scan]  [Karel Zak]
>   - improve fs referencing in tables  [Tim Hildering]
>   - return errno on failed fstab stat()  [Karel Zak]
>libsmartcols:
>   - (docs) add reference to v2.33 and v2.34  [Karel Zak]
>   - (groups) improve debug messages  [Karel Zak]
>   - (groups) improve scols_table_group_lines() args check [coverity scan]=
  [Karel Zak]
>   - (groups) print group childrent after regualr tree  [Karel Zak]
>   - (groups) remove hardcoded const numbers  [Karel Zak]
>   - (groups) use print functions tp calculate grpset  [Karel Zak]
>   - add another UTF symbols  [Karel Zak]
>   - add generic function to walk on tree  [Karel Zak]
>   - add grouping API docs  [Karel Zak]
>   - add grouping samples  [Karel Zak]
>   - add is_last_child(), move is_last_column()  [Karel Zak]
>   - add lines grouping support  [Karel Zak]
>   - cell width calulation cleanup  [Karel Zak]
>   - fix  variable shadowing  [Sami Kerola]
>   - fix docs  [Karel Zak]
>   - fix groups reset, add debugs  [Karel Zak]
>   - move buffer stuff to buffer.c  [Karel Zak]
>   - move width calculation to separate file  [Karel Zak]
>   - print tree also for empty cells  [Karel Zak]
>   - remove extra ';' outside of a function [-Wextra-semi]  [Sami Kerola]
>   - rename table_print.c to print.c  [Karel Zak]
>   - split print.c into print.c, put.c and print-api.c  [Karel Zak]
>   - use list_add_tail() in more robust way  [Karel Zak]
>   - use scols_walk_* for calculations and printing  [Karel Zak]
>libuuid:
>   - fix man page typos  [Seth Girvan]
>logger:
>   - (man) add info about rewrite and authors  [Karel Zak]
>   - (man) make more obvious that --server/socket is required  [Karel Zak]
>   - concatenate multiple lines of MESSAGE into a single field.  [Karel Za=
k]
>   - make code more robust for static analyzer [clang scan]  [Karel Zak]
>login:
>   - add support for login.defs(5) LASTLOG_UID_MAX  [Karel Zak]
>   - retire use of __FUNCTION__ macro  [Karel Zak, Sami Kerola]
>login-utils/logindefs:
>   - clenaup API  [Karel Zak]
>losetup:
>   - keep static analyzer happy [coverity scan]  [Karel Zak]
>   - man page has repeating words [make checkmans]  [Karel Zak]
>   - properly use --sector-size when create a new device  [Karel Zak]
>   - update an error message  [Jeffrey Ferreira]
>   - use offset in warn_size() calculation  [Karel Zak]
>   - use xstrncpy()  [Karel Zak]
>lsblk:
>   - add --dedup <column>  [Karel Zak]
>   - add --merge  [Karel Zak]
>   - add basic function to build devices tree  [Karel Zak]
>   - add comments  [Karel Zak]
>   - add devtree_get_device_or_new()  [Karel Zak]
>   - add lsblk_device_has_dependence()  [Karel Zak]
>   - add more debug messages  [Karel Zak]
>   - add process_all_devices_inverse()  [Karel Zak]
>   - allow to specify tree column  [Karel Zak]
>   - apply --nodeps to partitions too  [Karel Zak]
>   - check stat() return code [coverity scan]  [Karel Zak]
>   - check ul_path_scanf() return value [coverity scan]  [Karel Zak]
>   - cleanup device reference in the tree  [Karel Zak]
>   - don't keep sysfs dirs open  [Karel Zak]
>   - fix "maybe be" duplication  [Austin English]
>   - fix devtree deallocation  [Karel Zak]
>   - fix heap-use-after-free  [Karel Zak]
>   - fix null pointer dereferences  [Sami Kerola]
>   - force tree on --json --tree independently on used columns  [Karel Zak]
>   - keep functions names consistent  [Karel Zak]
>   - make device_get_data() more generic  [Karel Zak]
>   - make devtree dependences more generic  [Karel Zak]
>   - make process_partitions() more readable  [Karel Zak]
>   - make sure __process_one_device() has proper arguments [coverity scan]=
  [Karel Zak]
>   - process_one_device() refactoring  [Karel Zak]
>   - properly initialize structs  [Karel Zak]
>   - read queue/discard_granularity only when necessary  [Karel Zak]
>   - remember whole-disk, remove unused struct member  [Karel Zak]
>   - remove badly named debug interface name  [Karel Zak]
>   - remove unncessary parent pointer  [Karel Zak]
>   - remove unused reset_device()  [Karel Zak]
>   - rename blkdev_cxt to lsblk_device  [Karel Zak]
>   - rename reset_lsblk_device() to reset_device()  [Karel Zak]
>   - rename set_device()  [Karel Zak]
>   - reorder functions  [Karel Zak]
>   - reuse 'removable' flag from parent  [Karel Zak]
>   - split sysfs reading and scols table filling  [Karel Zak]
>   - use ID_SCSI_SERIAL when available  [Sven Wiltink]
>   - use devtree functions  [Karel Zak]
>   - use real rather than hardcoded parent  [Karel Zak]
>lscpu:
>   - (man) make SYNOPSIS compatible with another utils  [Karel Zak]
>   - (man) tiny changes  [Karel Zak]
>   - Add aarch32 detection on aarch64  [Jeremy Linton]
>   - Add additional aarch64 models  [Jeremy Linton]
>   - add 'Frequency boost'  [Karel Zak]
>   - add --bytes  [Karel Zak]
>   - add --caches  [Karel Zak]
>   - check scols_line_set_data() return value [coverity scan]  [Karel Zak]
>   - define libsmartcols flags for -e  [Karel Zak]
>   - document --hex output regression (since v2.30)  [Karel Zak]
>   - fix --caches order  [Karel Zak]
>   - fix and document --output-all  [Karel Zak]
>   - fix excl[] array order  [Karel Zak]
>   - fix floating point exception  [Sami Kerola]
>   - make lookup() use more consistent [coverity scan]  [Karel Zak]
>   - move trailing null after removing characters from a string  [Sami Ker=
ola]
>   - remove extra space from field key name  [Sami Kerola]
>   - remove redundant condition check [cppcheck]  [Sami Kerola]
>   - rename macros and functions  [Karel Zak]
>   - report CPU vulnerabilities  [Karel Zak]
>   - report more usable cache sizes  [Karel Zak]
>   - wrap default output long lines on terminal  [Karel Zak]
>lslogins:
>   - Fix discrepancies of SYS_UID_MIN  [Stanislav Brabec]
>   - make valid_pwd() more robust  [Karel Zak]
>   - remove duplicate NULL check  [Sami Kerola]
>mesg:
>   - avoid 'ttyname failed  Success' message  [Karel Zak]
>misc:
>   - consolidate version printing and close_stdout()  [Karel Zak]
>mkswap:
>   - be more explicit about maximal number of pages  [Karel Zak]
>   - fix page size warning message  [Noel Cragg]
>   - use dd(1) in example rather than fallocate(1)  [Karel Zak]
>mount:
>   - (man) add note about --all to remount desc  [Karel Zak]
>   - Do not call mnt_pretty_path() on net file systems.  [Stanislav Brabec]
>   - fix "maybe be" duplication  [Austin English]
>   - mount.8 clarify (no)suid behavior on file capabilities  [Peter Wu]
>po:
>   - merge changes  [Karel Zak]
>   - update cs.po (from translationproject.org)  [Petr P=C3=ADsa=C5=99]
>   - update da.po (from translationproject.org)  [Joe Hansen]
>   - update de.po (from translationproject.org)  [Mario Bl=C3=A4ttermann]
>   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
>   - update fr.po (from translationproject.org)  [Fr=C3=A9d=C3=A9ric March=
al]
>   - update hr.po (from translationproject.org)  [Bo=C5=BEidar Putanec]
>   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
>   - update pl.po (from translationproject.org)  [Jakub Bogusz]
>   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
>   - update sv.po (from translationproject.org)  [Sebastian Rasmussen]
>   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
>   - update zh_CN.po (from translationproject.org)  [Boyuan Yang]
>readprofile:
>   - be more explicit with used types [cppcheck]  [Karel Zak]
>   - check input file is not empty [asan]  [Sami Kerola]
>renice:
>   - make code more readable for static analyzer [coverity scan]  [Karel Z=
ak]
>rev:
>   - be careful with close()  [Karel Zak]
>rtcwake:
>   - fix "maybe be" duplication  [Austin English]
>   - terminate mode and excl[]  [Karel Zak]
>   - use poweroff if shutdown is not found  [Justin Chen]
>setarch:
>   - add new e2k subarches  [Andrew Savchenko]
>   - avoid NULL dereference [coverity check]  [Karel Zak]
>   - don't return address of automatic variable  [Andreas Schwab]
>   - fix obscure sparc32bash use-case  [Karel Zak]
>setpriv:
>   - fix memory leak in local scope [coverity scan]  [Karel Zak]
>setterm:
>   - disallow "default" for --ulcolor/--hbcolor  [Jakub Wilk]
>   - fix --hbcolor description  [Jakub Wilk]
>   - fix bright colors for --ulcolor/--hbcolor  [Jakub Wilk]
>   - update comments about -ulcolor/-hbcolor syntax  [Jakub Wilk]
>sfdisk:
>   - Avoid out of boundary read with readline  [Tobias Stoeckmann]
>   - fix logical partition resize when start specified  [Karel Zak]
>   - remove unnecessary size check [cppcheck]  [Sami Kerola]
>   - use xstrcpy()  [Karel Zak]
>su:
>   - add note about ECHO on --pty  [Karel Zak]
>   - be sensitive to another SIGCHLD ssi_codes  [Karel Zak]
>   - change error message  [Karel Zak]
>   - fix --pty terminal initialization  [Karel Zak]
>   - make comment more friedly to 'make checkxalloc'  [Karel Zak]
>su-common.c:
>   - prefer /etc/default/su over login.defs  [Stanislav Brabec]
>   - prefer ENV_SUPATH over ENV_ROOTPATH  [Stanislav Brabec]
>su/runuser:
>   - don't mark --pty as experimental, add it to runuser.1 too  [Karel Zak]
>sulogin:
>   - fix variable / function shadowing [cppcheck]  [Sami Kerola]
>swapon:
>   - (man) cleanup note about holes  [Karel Zak]
>   - (man) iomap for swapfile is already supported by kernel  [Karel Zak]
>   - be more explicit about BTRFS  [Karel Zak]
>   - rewrite section about swapfiles  [Karel Zak]
>   - swapon.8 mention btrfs(5)  [Marcos Mello]
>taskset:
>   - fix cpuset list parser  [Karel Zak]
>tastset:
>   - (man) add  N stride for CPU lists  [Karel Zak]
>test:
>   - Adding AMD EPYC 7451 24-Core Processor  [Erwan Velu]
>tests:
>   - (hardlink) update noregex  [Karel Zak]
>   - (hardlink) update summary output  [Karel Zak]
>   - (kill) do not use shell build-in  [Karel Zak]
>   - add --noskip-commands  [Karel Zak]
>   - add --use-system-commands  [Karel Zak]
>   - add /mnt/test/foo^Mbar to mountinfo tests  [Karel Zak]
>   - add asan build-sys test  [Karel Zak]
>   - add fdisk (dos) first sector dialog test  [Karel Zak]
>   - add missing TS_CMD_UMOUNT check  [Karel Zak]
>   - add missing ts_check_test_command call  [Karel Zak]
>   - add missing ts_check_test_command calls  [Karel Zak]
>   - add test images for drbd v08/v09  [Roland Kammerer]
>   - auto-enable ASAN option if necessary  [Karel Zak]
>   - build-sys update  [Karel Zak]
>   - check for tar and {b,g}zip  [Karel Zak]
>   - enlarge backing file for fstab-btrfs  [Karel Zak]
>   - fix TS_ENABLE_ASAN usage  [Karel Zak]
>   - ignore errors with enabled ASAN in python bindings  [Karel Zak]
>   - make lsns-netnsid portable  [Karel Zak]
>   - make sure TS_HELPER_MBSENCODE compiled  [Karel Zak]
>   - run oids test only when uuidgen tool was built  [Thomas Deutschmann]
>   - update build-sys output  [Karel Zak]
>   - update fdisk outputs  [Karel Zak]
>   - update lscpu due to 'Vulnerability' fields  [Karel Zak]
>   - update lscpu output  [Karel Zak]
>   - use TS_ENABLE_ASAN in tests to detect ASAN  [Karel Zak]
>   - use subtests in fdisk/mbr-nondos-mode  [Karel Zak]
>timeutils:
>   - match today day and this year correctly  [Sami Kerola]
>ul:
>   - make sure buffers are zeroized [coverity scan]  [Karel Zak]
>umount:
>   - be more strict about --all  [Karel Zak]
>   - fix --quiet  [Karel Zak]
>unshare:
>   - allow to set a new root  [Laurent Vivier]
>   - allow to set user ID and group ID  [Laurent Vivier]
>utmpdump:
>   - check ftello() return value  [Karel Zak]
>   - fix word swapping in manual page  [Carlos Santos]
>uuidd:
>   - Add Documentation key to uuidd.service  [Andreas Henriksson]
>   - Add hardening settings to uuidd.service  [Andreas Henriksson]
>various:
>   - fix 'uninitialized when used' warnings [clang]  [Sami Kerola]
>vipw:
>   - use xstrncpy()  [Karel Zak]
>wall:
>   - make sure ut_line is not empty  [Karel Zak]
>   - remove unnecessary warning  [Karel Zak]
>whereis:
>   - make subdirs scan more robust  [Karel Zak]
>   - search in /(s)bin before /usr/lib  [Karel Zak]
>   - use xstrncpy()  [Karel Zak]
>wipefs:
>   - fix variable / function shadowing [cppcheck]  [Sami Kerola]
>zramctl:
>   - use xstrncpy()  [Karel Zak]
>
>--=20
> Karel Zak  <kzak@redhat.com>
> http://karelzak.blogspot.com

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl0DgjkACgkQsjqdtxFL
KRUR0wf/RF4rrAkiylxSUyqDJ9nUEy6uPKEZFxoZrRnYrY2VcdV0C7Mj908XorgC
xVhIhCfktpNwY5va7LjSV0M9hBfrIYUlUKpAWJpPIfpsy5ZDGpi3903YfOxQmXXe
5pc0nlCzuG2W0llmIPHFeZPxQM76HOmvbeEqgl68yT9JXKAU8he/qz9FtrR8iDDq
7NRO6/G0tDraULUn2WJ1YuZydwZIL6/vOyhOVUSNi5saPyf/lCJodlXiYTFUKjQk
1w0s6zOt+gBfBanUIhAlsRdYGlhbAxftY8Esq75lEJEcf5dLrrbv+fGGBfxif+46
WyipTChAUPnPSXUPfuCQepKL3vo8JA==
=uWlK
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
