Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622F85F0C85
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 15:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiI3NhK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiI3NhI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:37:08 -0400
X-Greylist: delayed 7800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 06:37:05 PDT
Received: from 20.mo561.mail-out.ovh.net (20.mo561.mail-out.ovh.net [178.33.47.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABEF1397F7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 06:37:04 -0700 (PDT)
Received: from player157.ha.ovh.net (unknown [10.108.20.214])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 9813327694
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Sep 2022 10:30:41 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player157.ha.ovh.net (Postfix) with ESMTPSA id 3FEA52F302B96;
        Fri, 30 Sep 2022 10:30:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-104R00516987032-5e24-441b-af8b-5804b343c3c6,
                    C05B2F2BD13FA39C9993548B485976379164E02D) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH v2 5/5] docs: sysctl/fs: re-order, prettify
Date:   Fri, 30 Sep 2022 12:29:37 +0200
Message-Id: <20220930102937.135841-6-steve@sk2.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220930102937.135841-1-steve@sk2.org>
References: <20220930102937.135841-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 14218145502854809222
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgvdekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepgefhhfeliefghfetieffleevfefhieduheektdeghfegvdelfffgjefgtdevieegnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiud
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This brings the text markup in line with sysctl/abi and
sysctl/kernel:

* the entries are ordered alphabetically
* the table of contents is automatically generated
* markup is used as appropriate for constants etc.

The content isn't fully up-to-date but the obsolete entries are gone,
so remove the kernel version mention.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 Documentation/admin-guide/sysctl/fs.rst     | 188 ++++++++++----------
 Documentation/admin-guide/sysctl/kernel.rst |   2 +
 2 files changed, 92 insertions(+), 98 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
index df683c15b098..a321b84eccaa 100644
--- a/Documentation/admin-guide/sysctl/fs.rst
+++ b/Documentation/admin-guide/sysctl/fs.rst
@@ -2,8 +2,6 @@
 Documentation for /proc/sys/fs/
 ===============================
 
-kernel version 2.2.10
-
 Copyright (c) 1998, 1999,  Rik van Riel <riel@nl.linux.org>
 
 Copyright (c) 2009,        Shen Feng<shen@cn.fujitsu.com>
@@ -12,55 +10,40 @@ For general info and legal blurb, please look in intro.rst.
 
 ------------------------------------------------------------------------------
 
-This file contains documentation for the sysctl files in
-/proc/sys/fs/ and is valid for Linux kernel version 2.2.
+This file contains documentation for the sysctl files and directories
+in ``/proc/sys/fs/``.
 
 The files in this directory can be used to tune and monitor
 miscellaneous and general things in the operation of the Linux
-kernel. Since some of the files _can_ be used to screw up your
+kernel. Since some of the files *can* be used to screw up your
 system, it is advisable to read both documentation and source
 before actually making adjustments.
 
 1. /proc/sys/fs
 ===============
 
-Currently, these files are in /proc/sys/fs:
-
-- aio-max-nr
-- aio-nr
-- dentry-state
-- file-max
-- file-nr
-- inode-nr
-- inode-state
-- nr_open
-- overflowuid
-- overflowgid
-- pipe-user-pages-hard
-- pipe-user-pages-soft
-- protected_fifos
-- protected_hardlinks
-- protected_regular
-- protected_symlinks
-- suid_dumpable
-- super-max
-- super-nr
+Currently, these files might (depending on your configuration)
+show up in ``/proc/sys/fs``:
+
+.. contents:: :local:
 
 
 aio-nr & aio-max-nr
 -------------------
 
-aio-nr shows the current system-wide number of asynchronous io
-requests.  aio-max-nr allows you to change the maximum value
-aio-nr can grow to.  If aio-nr reaches aio-nr-max then io_setup will
-fail with EAGAIN.  Note that raising aio-max-nr does not result in the
+``aio-nr`` shows the current system-wide number of asynchronous io
+requests.  ``aio-max-nr`` allows you to change the maximum value
+``aio-nr`` can grow to.  If ``aio-nr`` reaches ``aio-nr-max`` then
+``io_setup`` will fail with ``EAGAIN``.  Note that raising
+``aio-max-nr`` does not result in the
 pre-allocation or re-sizing of any kernel data structures.
 
 
 dentry-state
 ------------
 
-From linux/include/linux/dcache.h::
+This file shows the values in ``struct dentry_stat``, as defined in
+``linux/include/linux/dcache.h``::
 
   struct dentry_stat_t dentry_stat {
         int nr_dentry;
@@ -73,16 +56,16 @@ From linux/include/linux/dcache.h::
 
 Dentries are dynamically allocated and deallocated.
 
-nr_dentry shows the total number of dentries allocated (active
-+ unused). nr_unused shows the number of dentries that are not
+``nr_dentry`` shows the total number of dentries allocated (active
++ unused). ``nr_unused shows`` the number of dentries that are not
 actively used, but are saved in the LRU list for future reuse.
 
-Age_limit is the age in seconds after which dcache entries
-can be reclaimed when memory is short and want_pages is
-nonzero when shrink_dcache_pages() has been called and the
+``age_limit`` is the age in seconds after which dcache entries
+can be reclaimed when memory is short and ``want_pages`` is
+nonzero when ``shrink_dcache_pages()`` has been called and the
 dcache isn't pruned yet.
 
-nr_negative shows the number of unused dentries that are also
+``nr_negative`` shows the number of unused dentries that are also
 negative dentries which do not map to any files. Instead,
 they help speeding up rejection of non-existing files provided
 by the users.
@@ -91,32 +74,26 @@ by the users.
 file-max & file-nr
 ------------------
 
-The value in file-max denotes the maximum number of file-
+The value in ``file-max`` denotes the maximum number of file-
 handles that the Linux kernel will allocate. When you get lots
 of error messages about running out of file handles, you might
 want to increase this limit.
 
 Historically,the kernel was able to allocate file handles
 dynamically, but not to free them again. The three values in
-file-nr denote the number of allocated file handles, the number
+``file-nr`` denote the number of allocated file handles, the number
 of allocated but unused file handles, and the maximum number of
-file handles. Linux 2.6 always reports 0 as the number of free
+file handles. Linux 2.6 and later always reports 0 as the number of free
 file handles -- this is not an error, it just means that the
 number of allocated file handles exactly matches the number of
 used file handles.
 
-Attempts to allocate more file descriptors than file-max are
-reported with printk, look for "VFS: file-max limit <number>
-reached".
+Attempts to allocate more file descriptors than ``file-max`` are
+reported with ``printk``, look for::
 
+  VFS: file-max limit <number> reached
 
-nr_open
--------
-
-This denotes the maximum number of file-handles a process can
-allocate. Default value is 1024*1024 (1048576) which should be
-enough for most machines. Actual limit depends on RLIMIT_NOFILE
-resource limit.
+in the kernel logs.
 
 
 inode-nr & inode-state
@@ -125,22 +102,38 @@ inode-nr & inode-state
 As with file handles, the kernel allocates the inode structures
 dynamically, but can't free them yet.
 
-The file inode-nr contains the first two items from
-inode-state, so we'll skip to that file...
+The file ``inode-nr`` contains the first two items from
+``inode-state``, so we'll skip to that file...
 
-Inode-state contains three actual numbers and four dummies.
-The actual numbers are, in order of appearance, nr_inodes,
-nr_free_inodes and preshrink.
+``inode-state`` contains three actual numbers and four dummies.
+The actual numbers are, in order of appearance, ``nr_inodes``,
+``nr_free_inodes`` and ``preshrink``.
 
-Nr_inodes stands for the number of inodes the system has
+``nr_inodes`` stands for the number of inodes the system has
 allocated.
 
-Nr_free_inodes represents the number of free inodes (?) and
+``nr_free_inodes`` represents the number of free inodes (?) and
 preshrink is nonzero when the
 system needs to prune the inode list instead of allocating
 more.
 
 
+mount-max
+---------
+
+This denotes the maximum number of mounts that may exist
+in a mount namespace.
+
+
+nr_open
+-------
+
+This denotes the maximum number of file-handles a process can
+allocate. Default value is 1024*1024 (1048576) which should be
+enough for most machines. Actual limit depends on ``RLIMIT_NOFILE``
+resource limit.
+
+
 overflowgid & overflowuid
 -------------------------
 
@@ -168,7 +161,7 @@ pipe-user-pages-soft
 Maximum total number of pages a non-privileged user may allocate for pipes
 before the pipe size gets limited to a single page. Once this limit is reached,
 new pipes will be limited to a single page in size for this user in order to
-limit total memory usage, and trying to increase them using fcntl() will be
+limit total memory usage, and trying to increase them using ``fcntl()`` will be
 denied until usage goes below the limit again. The default value allows to
 allocate up to 1024 pipes at their default size. When set to 0, no limit is
 applied.
@@ -183,7 +176,7 @@ file.
 
 When set to "0", writing to FIFOs is unrestricted.
 
-When set to "1" don't allow O_CREAT open on FIFOs that we don't own
+When set to "1" don't allow ``O_CREAT`` open on FIFOs that we don't own
 in world writable sticky directories, unless they are owned by the
 owner of the directory.
 
@@ -197,7 +190,7 @@ protected_hardlinks
 
 A long-standing class of security issues is the hardlink-based
 time-of-check-time-of-use race, most commonly seen in world-writable
-directories like /tmp. The common method of exploitation of this flaw
+directories like ``/tmp``. The common method of exploitation of this flaw
 is to cross privilege boundaries when following a given hardlink (i.e. a
 root process follows a hardlink created by another user). Additionally,
 on systems without separated partitions, this stops unauthorized users
@@ -215,13 +208,13 @@ This protection is based on the restrictions in Openwall and grsecurity.
 protected_regular
 -----------------
 
-This protection is similar to protected_fifos, but it
+This protection is similar to `protected_fifos`_, but it
 avoids writes to an attacker-controlled regular file, where a program
 expected to create one.
 
 When set to "0", writing to regular files is unrestricted.
 
-When set to "1" don't allow O_CREAT open on regular files that we
+When set to "1" don't allow ``O_CREAT`` open on regular files that we
 don't own in world writable sticky directories, unless they are
 owned by the owner of the directory.
 
@@ -233,7 +226,7 @@ protected_symlinks
 
 A long-standing class of security issues is the symlink-based
 time-of-check-time-of-use race, most commonly seen in world-writable
-directories like /tmp. The common method of exploitation of this flaw
+directories like ``/tmp``. The common method of exploitation of this flaw
 is to cross privilege boundaries when following a given symlink (i.e. a
 root process follows a symlink belonging to another user). For a likely
 incomplete list of hundreds of examples across the years, please see:
@@ -248,23 +241,25 @@ follower match, or when the directory owner matches the symlink's owner.
 This protection is based on the restrictions in Openwall and grsecurity.
 
 
-suid_dumpable:
---------------
+suid_dumpable
+-------------
 
 This value can be used to query and set the core dump mode for setuid
 or otherwise protected/tainted binaries. The modes are
 
 =   ==========  ===============================================================
-0   (default)	traditional behaviour. Any process which has changed
+0   (default)	Traditional behaviour. Any process which has changed
 		privilege levels or is execute only will not be dumped.
-1   (debug)	all processes dump core when possible. The core dump is
+1   (debug)	All processes dump core when possible. The core dump is
 		owned by the current user and no security is applied. This is
 		intended for system debugging situations only.
 		Ptrace is unchecked.
 		This is insecure as it allows regular users to examine the
 		memory contents of privileged processes.
-2   (suidsafe)	any binary which normally would not be dumped is dumped
-		anyway, but only if the "core_pattern" kernel sysctl is set to
+2   (suidsafe)	Any binary which normally would not be dumped is dumped
+		anyway, but only if the ``core_pattern`` kernel sysctl (see
+		:ref:`Documentation/admin-guide/sysctl/kernel.rst <core_pattern>`)
+		is set to
 		either a pipe handler or a fully qualified path. (For more
 		details on this limitation, see CVE-2006-2451.) This mode is
 		appropriate when administrators are attempting to debug
@@ -277,18 +272,11 @@ or otherwise protected/tainted binaries. The modes are
 =   ==========  ===============================================================
 
 
-mount-max
----------
-
-This denotes the maximum number of mounts that may exist
-in a mount namespace.
-
-
 
 2. /proc/sys/fs/binfmt_misc
 ===========================
 
-Documentation for the files in /proc/sys/fs/binfmt_misc is
+Documentation for the files in ``/proc/sys/fs/binfmt_misc`` is
 in Documentation/admin-guide/binfmt-misc.rst.
 
 
@@ -301,28 +289,32 @@ creation of a  user space  library that  implements  the  POSIX message queues
 API (as noted by the  MSG tag in the  POSIX 1003.1-2001 version  of the System
 Interfaces specification.)
 
-The "mqueue" filesystem contains values for determining/setting  the amount of
-resources used by the file system.
+The "mqueue" filesystem contains values for determining/setting the
+amount of resources used by the file system.
 
-/proc/sys/fs/mqueue/queues_max is a read/write  file for  setting/getting  the
-maximum number of message queues allowed on the system.
+``/proc/sys/fs/mqueue/queues_max`` is a read/write file for
+setting/getting the maximum number of message queues allowed on the
+system.
 
-/proc/sys/fs/mqueue/msg_max  is  a  read/write file  for  setting/getting  the
-maximum number of messages in a queue value.  In fact it is the limiting value
-for another (user) limit which is set in mq_open invocation. This attribute of
-a queue must be less or equal then msg_max.
+``/proc/sys/fs/mqueue/msg_max`` is a read/write file for
+setting/getting the maximum number of messages in a queue value.  In
+fact it is the limiting value for another (user) limit which is set in
+``mq_open`` invocation.  This attribute of a queue must be less than
+or equal to ``msg_max``.
 
-/proc/sys/fs/mqueue/msgsize_max is  a read/write  file for setting/getting the
-maximum  message size value (it is every  message queue's attribute set during
-its creation).
+``/proc/sys/fs/mqueue/msgsize_max`` is a read/write file for
+setting/getting the maximum message size value (it is an attribute of
+every message queue, set during its creation).
 
-/proc/sys/fs/mqueue/msg_default is  a read/write  file for setting/getting the
-default number of messages in a queue value if attr parameter of mq_open(2) is
-NULL. If it exceed msg_max, the default value is initialized msg_max.
+``/proc/sys/fs/mqueue/msg_default`` is a read/write file for
+setting/getting the default number of messages in a queue value if the
+``attr`` parameter of ``mq_open(2)`` is ``NULL``. If it exceeds
+``msg_max``, the default value is initialized to ``msg_max``.
 
-/proc/sys/fs/mqueue/msgsize_default is a read/write file for setting/getting
-the default message size value if attr parameter of mq_open(2) is NULL. If it
-exceed msgsize_max, the default value is initialized msgsize_max.
+``/proc/sys/fs/mqueue/msgsize_default`` is a read/write file for
+setting/getting the default message size value if the ``attr``
+parameter of ``mq_open(2)`` is ``NULL``. If it exceeds
+``msgsize_max``, the default value is initialized to ``msgsize_max``.
 
 4. /proc/sys/fs/epoll - Configuration options for the epoll interface
 =====================================================================
@@ -336,7 +328,7 @@ Every epoll file descriptor can store a number of files to be monitored
 for event readiness. Each one of these monitored files constitutes a "watch".
 This configuration option sets the maximum number of "watches" that are
 allowed for each user.
-Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
-on a 64bit one.
-The current default value for  max_user_watches  is the 1/25 (4%) of the
-available low memory, divided for the "watch" cost in bytes.
+Each "watch" costs roughly 90 bytes on a 32-bit kernel, and roughly 160 bytes
+on a 64-bit one.
+The current default value for ``max_user_watches`` is 4% of the
+available low memory, divided by the "watch" cost in bytes.
diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ee6572b1edad..9b474bc1a4b4 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -134,6 +134,8 @@ Highest valid capability of the running kernel.  Exports
 ``CAP_LAST_CAP`` from the kernel.
 
 
+.. _core_pattern:
+
 core_pattern
 ============
 
-- 
2.31.1

