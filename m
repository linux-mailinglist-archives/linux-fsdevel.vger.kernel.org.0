Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC181290A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 02:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfLWBXC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 20:23:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36040 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfLWBXB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:23:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so8376330pfb.3;
        Sun, 22 Dec 2019 17:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL01XVEbluQLIV+Em/VgivS7olxE7tMQamBuebDTV4I=;
        b=tKFcLQjo0vhJOOJb2TwIeZ3gQJ/Ru34pN5a7bH1EH7D4z+Ts8ZHEBU/kqYzPt1JPSC
         TZH+mxUmAb4L3JopkVxbeO1szttiQSkkbJp0HYXLyVi/TFYNxlWbmNwzyxlTX/YdkKRi
         aRVD0blQ3xnAq/tPPVJh0ehp7uvZvi5eCyqH8vP6pYDS2KInYMxYBrYf6Myvc4ZbeFqA
         3DjxX5QelSx936kQOR65oRgCheYtyq9PDVjOs09nkQkdOWjYBZMrTtaxeT0kpZZw+qIu
         GM0zmufb04jQVKbicrJ3rCzX/1iOxAFiHZ9nkAsXlQuNm2zcP5DLoFrKcQbQwHol/vKw
         6wEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QL01XVEbluQLIV+Em/VgivS7olxE7tMQamBuebDTV4I=;
        b=bPNXcBrjogdEdnJuyNxIMhIkgnlH2HwoDNnpqoddxr0QTxOEKg4Xcrm/nqZcvxAYYr
         yPcMe3iRxwlf72V3k7F6IpV3ZwsBGeJ6deN2IbwO7g1XaPOzdVkPo1/vXFjdnRDn+N8K
         YLK9k349pb/ylLJZGOEI6J5/LsbL6WPu434sLr+MWZr1fA/C7OrUQpeHmzVgFo3gdtQR
         Cf+aSbLb2h4V/D1t0AycfTBNpOdC0OTfUSmt5dcbNJ2R0Trg9ECNydH+QRVLHCelZZGM
         uvWqzSAZHqwbkSXzL2nV2Ioo+AhIkzgWEVooe8tWZ9HU66ppr1H1ftVy5i4IAKBZO8Jj
         8fnA==
X-Gm-Message-State: APjAAAW+mdSuZY/6Rf6po95UJ9fKTqGuU2sLi4sNxGNV6PM1NHaPBFbR
        uH3Y8kdk0P6rDQ8v7CC2QiQ=
X-Google-Smtp-Source: APXvYqxnP0EP/8MszDILRaWBQcelGpwOB4CLU1UVuWgQX/jDMfa3HIbmoiRqpGZYRilGJB6kiEcibQ==
X-Received: by 2002:a63:d406:: with SMTP id a6mr28931615pgh.264.1577064180465;
        Sun, 22 Dec 2019 17:23:00 -0800 (PST)
Received: from localhost.localdomain ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id s7sm22048728pfb.60.2019.12.22.17.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 17:22:59 -0800 (PST)
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
X-Google-Original-From: Daniel W. S. Almeida
To:     corbet@lwn.net, miklos@szeredi.hu
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] Documentation: filesystems: convert fuse to RST
Date:   Sun, 22 Dec 2019 22:22:48 -0300
Message-Id: <20191223012248.606168-1-dwlsalmeida@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

Converts fuse.txt to reStructuredText format, improving the presentation
without changing much of the underlying content.

Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
-----------------------------------------------------------
Changes in v3:
Removed unnecessary markup.
Moved document back to Documentation/filesystems as per request from the
maintainer.

Changes in v2:
-Copied FUSE maintainer (Miklos Szeredi)
-Fixed the reference in the MAINTAINERS file
-Removed some of the excessive markup in fuse.rst
-Moved fuse.rst into admin-guide
-Updated index.rst
---
 .../filesystems/{fuse.txt => fuse.rst}        | 174 ++++++++----------
 Documentation/filesystems/index.rst           |   1 +
 MAINTAINERS                                   |   2 +-
 3 files changed, 82 insertions(+), 95 deletions(-)
 rename Documentation/filesystems/{fuse.txt => fuse.rst} (79%)

diff --git a/Documentation/filesystems/fuse.txt b/Documentation/filesystems/fuse.rst
similarity index 79%
rename from Documentation/filesystems/fuse.txt
rename to Documentation/filesystems/fuse.rst
index 13af4a49e7db..1ca3aac04606 100644
--- a/Documentation/filesystems/fuse.txt
+++ b/Documentation/filesystems/fuse.rst
@@ -1,41 +1,39 @@
-Definitions
-~~~~~~~~~~~
+==============
+FUSE
+==============
 
-Userspace filesystem:
+Definitions
+===========
 
+**Userspace filesystem:**
   A filesystem in which data and metadata are provided by an ordinary
   userspace process.  The filesystem can be accessed normally through
   the kernel interface.
 
-Filesystem daemon:
-
+**Filesystem daemon:**
   The process(es) providing the data and metadata of the filesystem.
 
-Non-privileged mount (or user mount):
-
+**Non-privileged mount (or user mount):**
   A userspace filesystem mounted by a non-privileged (non-root) user.
   The filesystem daemon is running with the privileges of the mounting
   user.  NOTE: this is not the same as mounts allowed with the "user"
   option in /etc/fstab, which is not discussed here.
 
-Filesystem connection:
-
+**Filesystem connection:**
   A connection between the filesystem daemon and the kernel.  The
   connection exists until either the daemon dies, or the filesystem is
   umounted.  Note that detaching (or lazy umounting) the filesystem
-  does _not_ break the connection, in this case it will exist until
+  does *not* break the connection, in this case it will exist until
   the last reference to the filesystem is released.
 
-Mount owner:
-
+**Mount owner:**
   The user who does the mounting.
 
-User:
-
+**User:**
   The user who is performing filesystem operations.
 
 What is FUSE?
-~~~~~~~~~~~~~
+=============
 
 FUSE is a userspace filesystem framework.  It consists of a kernel
 module (fuse.ko), a userspace library (libfuse.*) and a mount utility
@@ -46,50 +44,43 @@ non-privileged mounts.  This opens up new possibilities for the use of
 filesystems.  A good example is sshfs: a secure network filesystem
 using the sftp protocol.
 
-The userspace library and utilities are available from the FUSE
-homepage:
-
-  http://fuse.sourceforge.net/
+The userspace library and utilities are available from the
+`FUSE homepage: <http://fuse.sourceforge.net/>`_
 
 Filesystem type
-~~~~~~~~~~~~~~~
+===============
 
 The filesystem type given to mount(2) can be one of the following:
 
-'fuse'
+    **fuse**
 
-  This is the usual way to mount a FUSE filesystem.  The first
-  argument of the mount system call may contain an arbitrary string,
-  which is not interpreted by the kernel.
+    This is the usual way to mount a FUSE filesystem.  The first
+    argument of the mount system call may contain an arbitrary string,
+    which is not interpreted by the kernel.
 
-'fuseblk'
+    **fuseblk**
 
-  The filesystem is block device based.  The first argument of the
-  mount system call is interpreted as the name of the device.
+    The filesystem is block device based.  The first argument of the
+    mount system call is interpreted as the name of the device.
 
 Mount options
-~~~~~~~~~~~~~
-
-'fd=N'
+=============
 
+**fd=N**
   The file descriptor to use for communication between the userspace
   filesystem and the kernel.  The file descriptor must have been
   obtained by opening the FUSE device ('/dev/fuse').
 
-'rootmode=M'
-
+**rootmode=M**
   The file mode of the filesystem's root in octal representation.
 
-'user_id=N'
-
+**user_id=N**
   The numeric user id of the mount owner.
 
-'group_id=N'
-
+**group_id=N**
   The numeric group id of the mount owner.
 
-'default_permissions'
-
+**default_permissions**
   By default FUSE doesn't check file access permissions, the
   filesystem is free to implement its access policy or leave it to
   the underlying file access mechanism (e.g. in case of network
@@ -97,28 +88,25 @@ Mount options
   access based on file mode.  It is usually useful together with the
   'allow_other' mount option.
 
-'allow_other'
-
+**allow_other**
   This option overrides the security measure restricting file access
   to the user mounting the filesystem.  This option is by default only
   allowed to root, but this restriction can be removed with a
   (userspace) configuration option.
 
-'max_read=N'
-
+**max_read=N**
   With this option the maximum size of read operations can be set.
   The default is infinite.  Note that the size of read requests is
   limited anyway to 32 pages (which is 128kbyte on i386).
 
-'blksize=N'
-
+**blksize=N**
   Set the block size for the filesystem.  The default is 512.  This
   option is only valid for 'fuseblk' type mounts.
 
 Control filesystem
-~~~~~~~~~~~~~~~~~~
+==================
 
-There's a control filesystem for FUSE, which can be mounted by:
+There's a control filesystem for FUSE, which can be mounted by::
 
   mount -t fusectl none /sys/fs/fuse/connections
 
@@ -130,53 +118,51 @@ named by a unique number.
 
 For each connection the following files exist within this directory:
 
- 'waiting'
+	**waiting**
+	  The number of requests which are waiting to be transferred to
+	  userspace or being processed by the filesystem daemon.  If there is
+	  no filesystem activity and 'waiting' is non-zero, then the
+	  filesystem is hung or deadlocked.
 
-  The number of requests which are waiting to be transferred to
-  userspace or being processed by the filesystem daemon.  If there is
-  no filesystem activity and 'waiting' is non-zero, then the
-  filesystem is hung or deadlocked.
-
- 'abort'
-
-  Writing anything into this file will abort the filesystem
-  connection.  This means that all waiting requests will be aborted an
-  error returned for all aborted and new requests.
+ 	**abort**
+	  Writing anything into this file will abort the filesystem
+	  connection.  This means that all waiting requests will be aborted an
+	  error returned for all aborted and new requests.
 
 Only the owner of the mount may read or write these files.
 
 Interrupting filesystem operations
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+##################################
 
 If a process issuing a FUSE filesystem request is interrupted, the
 following will happen:
 
-  1) If the request is not yet sent to userspace AND the signal is
+  #. If the request is not yet sent to userspace AND the signal is
      fatal (SIGKILL or unhandled fatal signal), then the request is
      dequeued and returns immediately.
 
-  2) If the request is not yet sent to userspace AND the signal is not
-     fatal, then an 'interrupted' flag is set for the request.  When
+  #. If the request is not yet sent to userspace AND the signal is not
+     fatal, then an interrupted flag is set for the request.  When
      the request has been successfully transferred to userspace and
      this flag is set, an INTERRUPT request is queued.
 
-  3) If the request is already sent to userspace, then an INTERRUPT
+  #. If the request is already sent to userspace, then an INTERRUPT
      request is queued.
 
 INTERRUPT requests take precedence over other requests, so the
 userspace filesystem will receive queued INTERRUPTs before any others.
 
 The userspace filesystem may ignore the INTERRUPT requests entirely,
-or may honor them by sending a reply to the _original_ request, with
+or may honor them by sending a reply to the *original* request, with
 the error set to EINTR.
 
 It is also possible that there's a race between processing the
 original request and its INTERRUPT request.  There are two possibilities:
 
-  1) The INTERRUPT request is processed before the original request is
+  #. The INTERRUPT request is processed before the original request is
      processed
 
-  2) The INTERRUPT request is processed after the original request has
+  #. The INTERRUPT request is processed after the original request has
      been answered
 
 If the filesystem cannot find the original request, it should wait for
@@ -186,7 +172,7 @@ should reply to the INTERRUPT request with an EAGAIN error.  In case
 reply will be ignored.
 
 Aborting a filesystem connection
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+================================
 
 It is possible to get into certain situations where the filesystem is
 not responding.  Reasons for this may be:
@@ -216,7 +202,7 @@ the filesystem.  There are several ways to do this:
     powerful method, always works.
 
 How do non-privileged mounts work?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+==================================
 
 Since the mount() system call is a privileged operation, a helper
 program (fusermount) is needed, which is installed setuid root.
@@ -235,15 +221,13 @@ system.  Obvious requirements arising from this are:
     other users' or the super user's processes
 
 How are requirements fulfilled?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+===============================
 
  A) The mount owner could gain elevated privileges by either:
 
-     1) creating a filesystem containing a device file, then opening
-	this device
+    1. creating a filesystem containing a device file, then opening this device
 
-     2) creating a filesystem containing a suid or sgid application,
-	then executing this application
+    2. creating a filesystem containing a suid or sgid application, then executing this application
 
     The solution is not to allow opening device files and ignore
     setuid and setgid bits when executing programs.  To ensure this
@@ -275,16 +259,16 @@ How are requirements fulfilled?
         of other users' processes.
 
          i) It can slow down or indefinitely delay the execution of a
-           filesystem operation creating a DoS against the user or the
-           whole system.  For example a suid application locking a
-           system file, and then accessing a file on the mount owner's
-           filesystem could be stopped, and thus causing the system
-           file to be locked forever.
+            filesystem operation creating a DoS against the user or the
+            whole system.  For example a suid application locking a
+            system file, and then accessing a file on the mount owner's
+            filesystem could be stopped, and thus causing the system
+            file to be locked forever.
 
          ii) It can present files or directories of unlimited length, or
-           directory structures of unlimited depth, possibly causing a
-           system process to eat up diskspace, memory or other
-           resources, again causing DoS.
+             directory structures of unlimited depth, possibly causing a
+             system process to eat up diskspace, memory or other
+             resources, again causing *DoS*.
 
 	The solution to this as well as B) is not to allow processes
 	to access the filesystem, which could otherwise not be
@@ -294,28 +278,27 @@ How are requirements fulfilled?
 	ptrace can be used to check if a process is allowed to access
 	the filesystem or not.
 
-	Note that the ptrace check is not strictly necessary to
+	Note that the *ptrace* check is not strictly necessary to
 	prevent B/2/i, it is enough to check if mount owner has enough
 	privilege to send signal to the process accessing the
-	filesystem, since SIGSTOP can be used to get a similar effect.
+	filesystem, since *SIGSTOP* can be used to get a similar effect.
 
 I think these limitations are unacceptable?
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+===========================================
 
 If a sysadmin trusts the users enough, or can ensure through other
 measures, that system processes will never enter non-privileged
-mounts, it can relax the last limitation with a "user_allow_other"
+mounts, it can relax the last limitation with a 'user_allow_other'
 config option.  If this config option is set, the mounting user can
-add the "allow_other" mount option which disables the check for other
+add the 'allow_other' mount option which disables the check for other
 users' processes.
 
 Kernel - userspace interface
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+============================
 
 The following diagram shows how a filesystem operation (in this
-example unlink) is performed in FUSE.
+example unlink) is performed in FUSE. ::
 
-NOTE: everything in this description is greatly simplified
 
  |  "rm /mnt/fuse/file"               |  FUSE filesystem daemon
  |                                    |
@@ -357,12 +340,15 @@ NOTE: everything in this description is greatly simplified
  |    <fuse_unlink()                  |
  |  <sys_unlink()                     |
 
+.. note:: Everything in the description above is greatly simplified
+
 There are a couple of ways in which to deadlock a FUSE filesystem.
 Since we are talking about unprivileged userspace programs,
 something must be done about these.
 
-Scenario 1 -  Simple deadlock
------------------------------
+**Scenario 1 -  Simple deadlock**
+
+::
 
  |  "rm /mnt/fuse/file"               |  FUSE filesystem daemon
  |                                    |
@@ -379,12 +365,12 @@ Scenario 1 -  Simple deadlock
 
 The solution for this is to allow the filesystem to be aborted.
 
-Scenario 2 - Tricky deadlock
-----------------------------
+**Scenario 2 - Tricky deadlock**
+
 
 This one needs a carefully crafted filesystem.  It's a variation on
 the above, only the call back to the filesystem is not explicit,
-but is caused by a pagefault.
+but is caused by a pagefault. ::
 
  |  Kamikaze filesystem thread 1      |  Kamikaze filesystem thread 2
  |                                    |
@@ -410,7 +396,7 @@ but is caused by a pagefault.
  |                                    |           [lock page]
  |                                    |           * DEADLOCK *
 
-Solution is basically the same as above.
+The solution is basically the same as above.
 
 An additional problem is that while the write buffer is being copied
 to the request, the request must not be interrupted/aborted.  This is
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 2c3a9f761205..03a7c4ed7f15 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -46,4 +46,5 @@ Documentation for filesystem implementations.
 .. toctree::
    :maxdepth: 2
 
+   fuse
    virtiofs
diff --git a/MAINTAINERS b/MAINTAINERS
index 2a427d1e9f01..b17a079dff8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6758,7 +6758,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/fuse.git
 S:	Maintained
 F:	fs/fuse/
 F:	include/uapi/linux/fuse.h
-F:	Documentation/filesystems/fuse.txt
+F:	Documentation/filesystems/fuse.rst
 
 FUTEX SUBSYSTEM
 M:	Thomas Gleixner <tglx@linutronix.de>
-- 
2.24.1

