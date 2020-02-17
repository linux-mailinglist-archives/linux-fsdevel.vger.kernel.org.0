Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A11161741
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgBQQM4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:56 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47220 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729704AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=gjyL8eLuJQZuqZ+sjw8YA5ApRhPZlYiNSXg74MwCMfo=; b=tP1eYvurp3urepaSJvQz/nNDuz
        1jjNA9zR1Mv4YqBSMkSGO46IRlGrSMg/o57GQPmyJipY/CDm1qjZtCoZe1YVi5T1mawaibi6HIfjC
        2Xo9MFUXoKNWYBaE0XC5rGGBsONume7rEnWUkj+vUZtOznTKUnz7c72jWS2i6r/Xewrx0IEVlxPkm
        3kGwuojIcuiP515TZ/AQ7j40errR90J0jaa2svxIuP7mWx1FizWIx05Kjq1X6VN83oLNxU1sPnTXU
        eeep7ApPKvLcQYN+tkIQCbGRK8Sg6jXcsfrBbKKUoDycGmodU0VFQtRzMctMXZQIpBwTVtzymuLfr
        MxwX60qQ==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ul-Fr; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0a-000fam-JD; Mon, 17 Feb 2020 17:12:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 23/44] docs: filesystems: convert hpfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:09 +0100
Message-Id: <581019c3120938118aa55ba28902b62083c3f37a.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Adjust document and section titles;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{hpfs.txt => hpfs.rst}        | 239 +++++++++++-------
 Documentation/filesystems/index.rst           |   1 +
 2 files changed, 149 insertions(+), 91 deletions(-)
 rename Documentation/filesystems/{hpfs.txt => hpfs.rst} (66%)

diff --git a/Documentation/filesystems/hpfs.txt b/Documentation/filesystems/hpfs.rst
similarity index 66%
rename from Documentation/filesystems/hpfs.txt
rename to Documentation/filesystems/hpfs.rst
index 74630bd504fb..0db152278572 100644
--- a/Documentation/filesystems/hpfs.txt
+++ b/Documentation/filesystems/hpfs.rst
@@ -1,13 +1,21 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
 Read/Write HPFS 2.09
+====================
+
 1998-2004, Mikulas Patocka
 
-email: mikulas@artax.karlin.mff.cuni.cz
-homepage: http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
+:email: mikulas@artax.karlin.mff.cuni.cz
+:homepage: http://artax.karlin.mff.cuni.cz/~mikulas/vyplody/hpfs/index-e.cgi
 
-CREDITS:
+Credits
+=======
 Chris Smith, 1993, original read-only HPFS, some code and hpfs structures file
 	is taken from it
+
 Jacques Gelinas, MSDos mmap, Inspired by fs/nfs/mmap.c (Jon Tombs 15 Aug 1993)
+
 Werner Almesberger, 1992, 1993, MSDos option parser & CR/LF conversion
 
 Mount options
@@ -50,6 +58,7 @@ timeshift=(-)nnn (default 0)
 
 
 File names
+==========
 
 As in OS/2, filenames are case insensitive. However, shell thinks that names
 are case sensitive, so for example when you create a file FOO, you can use
@@ -64,6 +73,7 @@ access it under names 'a.', 'a..', 'a .  . . ' etc.
 
 
 Extended attributes
+===================
 
 On HPFS partitions, OS/2 can associate to each file a special information called
 extended attributes. Extended attributes are pairs of (key,value) where key is
@@ -88,6 +98,7 @@ values doesn't work.
 
 
 Symlinks
+========
 
 You can do symlinks on HPFS partition, symlinks are achieved by setting extended
 attribute named "SYMLINK" with symlink value. Like on ext2, you can chown and
@@ -101,6 +112,7 @@ to analyze or change OS2SYS.INI.
 
 
 Codepages
+=========
 
 HPFS can contain several uppercasing tables for several codepages and each
 file has a pointer to codepage its name is in. However OS/2 was created in
@@ -128,6 +140,7 @@ this codepage - if you don't try to do what I described above :-)
 
 
 Known bugs
+==========
 
 HPFS386 on OS/2 server is not supported. HPFS386 installed on normal OS/2 client
 should work. If you have OS/2 server, use only read-only mode. I don't know how
@@ -152,7 +165,8 @@ would result in directory tree splitting, that takes disk space. Workaround is
 to delete other files that are leaf (probability that the file is non-leaf is
 about 1/50) or to truncate file first to make some space.
 You encounter this problem only if you have many directories so that
-preallocated directory band is full i.e.
+preallocated directory band is full i.e.::
+
 	number_of_directories / size_of_filesystem_in_mb > 4.
 
 You can't delete open directories.
@@ -174,6 +188,7 @@ anybody know what does it mean?
 
 
 What does "unbalanced tree" message mean?
+=========================================
 
 Old versions of this driver created sometimes unbalanced dnode trees. OS/2
 chkdsk doesn't scream if the tree is unbalanced (and sometimes creates
@@ -187,6 +202,7 @@ whole created by this driver, it is BUG - let me know about it.
 
 
 Bugs in OS/2
+============
 
 When you have two (or more) lost directories pointing each to other, chkdsk
 locks up when repairing filesystem.
@@ -199,98 +215,139 @@ File names like "a .b" are marked as 'long' by OS/2 but chkdsk "corrects" it and
 marks them as short (and writes "minor fs error corrected"). This bug is not in
 HPFS386.
 
-Codepage bugs described above.
+Codepage bugs described above
+=============================
 
 If you don't install fixpacks, there are many, many more...
 
 
 History
+=======
 
-0.90 First public release
-0.91 Fixed bug that caused shooting to memory when write_inode was called on
-	open inode (rarely happened)
-0.92 Fixed a little memory leak in freeing directory inodes
-0.93 Fixed bug that locked up the machine when there were too many filenames
-	with first 15 characters same
-     Fixed write_file to zero file when writing behind file end
-0.94 Fixed a little memory leak when trying to delete busy file or directory
-0.95 Fixed a bug that i_hpfs_parent_dir was not updated when moving files
-1.90 First version for 2.1.1xx kernels
-1.91 Fixed a bug that chk_sectors failed when sectors were at the end of disk
-     Fixed a race-condition when write_inode is called while deleting file
-     Fixed a bug that could possibly happen (with very low probability) when
-     	using 0xff in filenames
-     Rewritten locking to avoid race-conditions
-     Mount option 'eas' now works
-     Fsync no longer returns error
-     Files beginning with '.' are marked hidden
-     Remount support added
-     Alloc is not so slow when filesystem becomes full
-     Atimes are no more updated because it slows down operation
-     Code cleanup (removed all commented debug prints)
-1.92 Corrected a bug when sync was called just before closing file
-1.93 Modified, so that it works with kernels >= 2.1.131, I don't know if it
-	works with previous versions
-     Fixed a possible problem with disks > 64G (but I don't have one, so I can't
-     	test it)
-     Fixed a file overflow at 2G
-     Added new option 'timeshift'
-     Changed behaviour on HPFS386: It is now possible to operate on HPFS386 in
-     	read-only mode
-     Fixed a bug that slowed down alloc and prevented allocating 100% space
-     	(this bug was not destructive)
-1.94 Added workaround for one bug in Linux
-     Fixed one buffer leak
-     Fixed some incompatibilities with large extended attributes (but it's still
-	not 100% ok, I have no info on it and OS/2 doesn't want to create them)
-     Rewritten allocation
-     Fixed a bug with i_blocks (du sometimes didn't display correct values)
-     Directories have no longer archive attribute set (some programs don't like
-	it)
-     Fixed a bug that it set badly one flag in large anode tree (it was not
-	destructive)
-1.95 Fixed one buffer leak, that could happen on corrupted filesystem
-     Fixed one bug in allocation in 1.94
-1.96 Added workaround for one bug in OS/2 (HPFS locked up, HPFS386 reported
-	error sometimes when opening directories in PMSHELL)
-     Fixed a possible bitmap race
-     Fixed possible problem on large disks
-     You can now delete open files
-     Fixed a nondestructive race in rename
-1.97 Support for HPFS v3 (on large partitions)
-     Fixed a bug that it didn't allow creation of files > 128M (it should be 2G)
+====== =========================================================================
+0.90   First public release
+0.91   Fixed bug that caused shooting to memory when write_inode was called on
+       open inode (rarely happened)
+0.92   Fixed a little memory leak in freeing directory inodes
+0.93   Fixed bug that locked up the machine when there were too many filenames
+       with first 15 characters same
+       Fixed write_file to zero file when writing behind file end
+0.94   Fixed a little memory leak when trying to delete busy file or directory
+0.95   Fixed a bug that i_hpfs_parent_dir was not updated when moving files
+1.90   First version for 2.1.1xx kernels
+1.91   Fixed a bug that chk_sectors failed when sectors were at the end of disk
+       Fixed a race-condition when write_inode is called while deleting file
+       Fixed a bug that could possibly happen (with very low probability) when
+       using 0xff in filenames.
+
+       Rewritten locking to avoid race-conditions
+
+       Mount option 'eas' now works
+
+       Fsync no longer returns error
+
+       Files beginning with '.' are marked hidden
+
+       Remount support added
+
+       Alloc is not so slow when filesystem becomes full
+
+       Atimes are no more updated because it slows down operation
+
+       Code cleanup (removed all commented debug prints)
+1.92   Corrected a bug when sync was called just before closing file
+1.93   Modified, so that it works with kernels >= 2.1.131, I don't know if it
+       works with previous versions
+
+       Fixed a possible problem with disks > 64G (but I don't have one, so I can't
+       test it)
+
+       Fixed a file overflow at 2G
+
+       Added new option 'timeshift'
+
+       Changed behaviour on HPFS386: It is now possible to operate on HPFS386 in
+       read-only mode
+
+       Fixed a bug that slowed down alloc and prevented allocating 100% space
+       (this bug was not destructive)
+1.94   Added workaround for one bug in Linux
+
+       Fixed one buffer leak
+
+       Fixed some incompatibilities with large extended attributes (but it's still
+       not 100% ok, I have no info on it and OS/2 doesn't want to create them)
+
+       Rewritten allocation
+
+       Fixed a bug with i_blocks (du sometimes didn't display correct values)
+
+       Directories have no longer archive attribute set (some programs don't like
+       it)
+
+       Fixed a bug that it set badly one flag in large anode tree (it was not
+       destructive)
+1.95   Fixed one buffer leak, that could happen on corrupted filesystem
+
+       Fixed one bug in allocation in 1.94
+1.96   Added workaround for one bug in OS/2 (HPFS locked up, HPFS386 reported
+       error sometimes when opening directories in PMSHELL)
+
+       Fixed a possible bitmap race
+
+       Fixed possible problem on large disks
+
+       You can now delete open files
+
+       Fixed a nondestructive race in rename
+1.97   Support for HPFS v3 (on large partitions)
+
+       ZFixed a bug that it didn't allow creation of files > 128M
+       (it should be 2G)
 1.97.1 Changed names of global symbols
+
        Fixed a bug when chmoding or chowning root directory
-1.98 Fixed a deadlock when using old_readdir
-     Better directory handling; workaround for "unbalanced tree" bug in OS/2
-1.99 Corrected a possible problem when there's not enough space while deleting
-	file
-     Now it tries to truncate the file if there's not enough space when deleting
-     Removed a lot of redundant code
-2.00 Fixed a bug in rename (it was there since 1.96)
-     Better anti-fragmentation strategy
-2.01 Fixed problem with directory listing over NFS
-     Directory lseek now checks for proper parameters
-     Fixed race-condition in buffer code - it is in all filesystems in Linux;
-        when reading device (cat /dev/hda) while creating files on it, files
-        could be damaged
-2.02 Workaround for bug in breada in Linux. breada could cause accesses beyond
-        end of partition
-2.03 Char, block devices and pipes are correctly created
-     Fixed non-crashing race in unlink (Alexander Viro)
-     Now it works with Japanese version of OS/2
-2.04 Fixed error when ftruncate used to extend file
-2.05 Fixed crash when got mount parameters without =
-     Fixed crash when allocation of anode failed due to full disk
-     Fixed some crashes when block io or inode allocation failed
-2.06 Fixed some crash on corrupted disk structures
-     Better allocation strategy
-     Reschedule points added so that it doesn't lock CPU long time
-     It should work in read-only mode on Warp Server
-2.07 More fixes for Warp Server. Now it really works
-2.08 Creating new files is not so slow on large disks
-     An attempt to sync deleted file does not generate filesystem error
-2.09 Fixed error on extremely fragmented files
-
-
- vim: set textwidth=80:
+1.98   Fixed a deadlock when using old_readdir
+       Better directory handling; workaround for "unbalanced tree" bug in OS/2
+1.99   Corrected a possible problem when there's not enough space while deleting
+       file
+
+       Now it tries to truncate the file if there's not enough space when
+       deleting
+
+       Removed a lot of redundant code
+2.00   Fixed a bug in rename (it was there since 1.96)
+       Better anti-fragmentation strategy
+2.01   Fixed problem with directory listing over NFS
+
+       Directory lseek now checks for proper parameters
+
+       Fixed race-condition in buffer code - it is in all filesystems in Linux;
+       when reading device (cat /dev/hda) while creating files on it, files
+       could be damaged
+2.02   Workaround for bug in breada in Linux. breada could cause accesses beyond
+       end of partition
+2.03   Char, block devices and pipes are correctly created
+
+       Fixed non-crashing race in unlink (Alexander Viro)
+
+       Now it works with Japanese version of OS/2
+2.04   Fixed error when ftruncate used to extend file
+2.05   Fixed crash when got mount parameters without =
+
+       Fixed crash when allocation of anode failed due to full disk
+
+       Fixed some crashes when block io or inode allocation failed
+2.06   Fixed some crash on corrupted disk structures
+
+       Better allocation strategy
+
+       Reschedule points added so that it doesn't lock CPU long time
+
+       It should work in read-only mode on Warp Server
+2.07   More fixes for Warp Server. Now it really works
+2.08   Creating new files is not so slow on large disks
+
+       An attempt to sync deleted file does not generate filesystem error
+2.09   Fixed error on extremely fragmented files
+====== =========================================================================
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index f776411340cb..3fbe2fa0b5c5 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -69,6 +69,7 @@ Documentation for filesystem implementations.
    gfs2-uevents
    hfs
    hfsplus
+   hpfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

