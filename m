Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 705E1161713
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgBQQMg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:36 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47190 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=2WSAgbalKoJi48MBVBQl1Gh1grIgegQP+YR8aKAMr5s=; b=XOlgfN3TOhu5J/XQ9KvYjTLORg
        TTBpg5jWgVN0KRejF5RHFfofViLs+arf1q+9yOvv/W4au5GQaLZm4JGIpDxPyaaq8pDNoP3sxh3wA
        4vTWuEaYLJrOygTwrn0hiWVR4Hp03TgnMyARupMO70pjk8+BfUOuGi7rKquxm0yc5mw9kLpUMyy8a
        ePA33SsZS+oYHdrQinoWsKoni0a79WBzBBXDukCn6tkVqPki1U7ABYTPFkQ0N/WdGiNpqsRF8HGZi
        Q2qBceWh8WvJ19vwxPh+vO7rZ+hZD8EdV/hryYvp6fIRwGGR8TkP+LW1MS2kG5GoMROFPCbZvATfq
        0K7W1AHQ==;
Received: from tmo-109-126.customers.d1-online.com ([80.187.109.126] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006uN-6k; Mon, 17 Feb 2020 16:12:34 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZC-Ls; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org
Subject: [PATCH 04/44] docs: filesystems: convert afs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:50 +0100
Message-Id: <d77f5afdb5da0f8b0ec3dbe720aef23f1ce73bb5.1581955849.git.mchehab+huawei@kernel.org>
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
- Comment out text-only ToC;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{afs.txt => afs.rst}          | 73 +++++++++----------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 34 insertions(+), 40 deletions(-)
 rename Documentation/filesystems/{afs.txt => afs.rst} (90%)

diff --git a/Documentation/filesystems/afs.txt b/Documentation/filesystems/afs.rst
similarity index 90%
rename from Documentation/filesystems/afs.txt
rename to Documentation/filesystems/afs.rst
index 8c6ea7b41048..c4ec39a5966e 100644
--- a/Documentation/filesystems/afs.txt
+++ b/Documentation/filesystems/afs.rst
@@ -1,8 +1,10 @@
-			     ====================
-			     kAFS: AFS FILESYSTEM
-			     ====================
+.. SPDX-License-Identifier: GPL-2.0
 
-Contents:
+====================
+kAFS: AFS FILESYSTEM
+====================
+
+.. Contents:
 
  - Overview.
  - Usage.
@@ -14,8 +16,7 @@ Contents:
  - The @sys substitution.
 
 
-========
-OVERVIEW
+Overview
 ========
 
 This filesystem provides a fairly simple secure AFS filesystem driver. It is
@@ -35,35 +36,33 @@ It does not yet support the following AFS features:
  (*) pioctl() system call.
 
 
-===========
-COMPILATION
+Compilation
 ===========
 
 The filesystem should be enabled by turning on the kernel configuration
-options:
+options::
 
 	CONFIG_AF_RXRPC		- The RxRPC protocol transport
 	CONFIG_RXKAD		- The RxRPC Kerberos security handler
 	CONFIG_AFS		- The AFS filesystem
 
-Additionally, the following can be turned on to aid debugging:
+Additionally, the following can be turned on to aid debugging::
 
 	CONFIG_AF_RXRPC_DEBUG	- Permit AF_RXRPC debugging to be enabled
 	CONFIG_AFS_DEBUG	- Permit AFS debugging to be enabled
 
 They permit the debugging messages to be turned on dynamically by manipulating
-the masks in the following files:
+the masks in the following files::
 
 	/sys/module/af_rxrpc/parameters/debug
 	/sys/module/kafs/parameters/debug
 
 
-=====
-USAGE
+Usage
 =====
 
 When inserting the driver modules the root cell must be specified along with a
-list of volume location server IP addresses:
+list of volume location server IP addresses::
 
 	modprobe rxrpc
 	modprobe kafs rootcell=cambridge.redhat.com:172.16.18.73:172.16.18.91
@@ -77,14 +76,14 @@ The second module is the kerberos RxRPC security driver, and the third module
 is the actual filesystem driver for the AFS filesystem.
 
 Once the module has been loaded, more modules can be added by the following
-procedure:
+procedure::
 
 	echo add grand.central.org 18.9.48.14:128.2.203.61:130.237.48.87 >/proc/fs/afs/cells
 
 Where the parameters to the "add" command are the name of a cell and a list of
 volume location servers within that cell, with the latter separated by colons.
 
-Filesystems can be mounted anywhere by commands similar to the following:
+Filesystems can be mounted anywhere by commands similar to the following::
 
 	mount -t afs "%cambridge.redhat.com:root.afs." /afs
 	mount -t afs "#cambridge.redhat.com:root.cell." /afs/cambridge
@@ -104,8 +103,7 @@ named volume will be looked up in the cell specified during modprobe.
 Additional cells can be added through /proc (see later section).
 
 
-===========
-MOUNTPOINTS
+Mountpoints
 ===========
 
 AFS has a concept of mountpoints. In AFS terms, these are specially formatted
@@ -123,42 +121,40 @@ culled first.  If all are culled, then the requested volume will also be
 unmounted, otherwise error EBUSY will be returned.
 
 This can be used by the administrator to attempt to unmount the whole AFS tree
-mounted on /afs in one go by doing:
+mounted on /afs in one go by doing::
 
 	umount /afs
 
 
-============
-DYNAMIC ROOT
+Dynamic Root
 ============
 
 A mount option is available to create a serverless mount that is only usable
-for dynamic lookup.  Creating such a mount can be done by, for example:
+for dynamic lookup.  Creating such a mount can be done by, for example::
 
 	mount -t afs none /afs -o dyn
 
 This creates a mount that just has an empty directory at the root.  Attempting
 to look up a name in this directory will cause a mountpoint to be created that
-looks up a cell of the same name, for example:
+looks up a cell of the same name, for example::
 
 	ls /afs/grand.central.org/
 
 
-===============
-PROC FILESYSTEM
+Proc Filesystem
 ===============
 
 The AFS modules creates a "/proc/fs/afs/" directory and populates it:
 
   (*) A "cells" file that lists cells currently known to the afs module and
-      their usage counts:
+      their usage counts::
 
 	[root@andromeda ~]# cat /proc/fs/afs/cells
 	USE NAME
 	  3 cambridge.redhat.com
 
   (*) A directory per cell that contains files that list volume location
-      servers, volumes, and active servers known within that cell.
+      servers, volumes, and active servers known within that cell::
 
 	[root@andromeda ~]# cat /proc/fs/afs/cambridge.redhat.com/servers
 	USE ADDR            STATE
@@ -171,8 +167,7 @@ The AFS modules creates a "/proc/fs/afs/" directory and populates it:
 	  1 Val 20000000 20000001 20000002 root.afs
 
 
-=================
-THE CELL DATABASE
+The Cell Database
 =================
 
 The filesystem maintains an internal database of all the cells it knows and the
@@ -181,7 +176,7 @@ the system belongs is added to the database when modprobe is performed by the
 "rootcell=" argument or, if compiled in, using a "kafs.rootcell=" argument on
 the kernel command line.
 
-Further cells can be added by commands similar to the following:
+Further cells can be added by commands similar to the following::
 
 	echo add CELLNAME VLADDR[:VLADDR][:VLADDR]... >/proc/fs/afs/cells
 	echo add grand.central.org 18.9.48.14:128.2.203.61:130.237.48.87 >/proc/fs/afs/cells
@@ -189,8 +184,7 @@ Further cells can be added by commands similar to the following:
 No other cell database operations are available at this time.
 
 
-========
-SECURITY
+Security
 ========
 
 Secure operations are initiated by acquiring a key using the klog program.  A
@@ -198,17 +192,17 @@ very primitive klog program is available at:
 
 	http://people.redhat.com/~dhowells/rxrpc/klog.c
 
-This should be compiled by:
+This should be compiled by::
 
 	make klog LDLIBS="-lcrypto -lcrypt -lkrb4 -lkeyutils"
 
-And then run as:
+And then run as::
 
 	./klog
 
 Assuming it's successful, this adds a key of type RxRPC, named for the service
 and cell, eg: "afs@<cellname>".  This can be viewed with the keyctl program or
-by cat'ing /proc/keys:
+by cat'ing /proc/keys::
 
 	[root@andromeda ~]# keyctl show
 	Session Keyring
@@ -232,20 +226,19 @@ socket), then the operations on the file will be made with key that was used to
 open the file.
 
 
-=====================
-THE @SYS SUBSTITUTION
+The @sys Substitution
 =====================
 
 The list of up to 16 @sys substitutions for the current network namespace can
-be configured by writing a list to /proc/fs/afs/sysname:
+be configured by writing a list to /proc/fs/afs/sysname::
 
 	[root@andromeda ~]# echo foo amd64_linux_26 >/proc/fs/afs/sysname
 
-or cleared entirely by writing an empty list:
+or cleared entirely by writing an empty list::
 
 	[root@andromeda ~]# echo >/proc/fs/afs/sysname
 
-The current list for current network namespace can be retrieved by:
+The current list for current network namespace can be retrieved by::
 
 	[root@andromeda ~]# cat /proc/fs/afs/sysname
 	foo
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 273d802ad5fb..0598bc52abdc 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -49,6 +49,7 @@ Documentation for filesystem implementations.
    9p
    adfs
    affs
+   afs
    autofs
    fuse
    overlayfs
-- 
2.24.1

