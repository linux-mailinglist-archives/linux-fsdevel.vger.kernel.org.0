Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 317C216173B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgBQQMy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:54 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47300 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729719AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=KPt7qVo1+xEzYE120ubz82lJQ4hiA9QwOcTJQY1LUAs=; b=agVR2So/NOOApV6WEzr7CCpX5R
        lTbYeXoFJfSRCccEIwcNa93e4YgEhLTqDTwkDDerKMA7JJZ0e5xzkSznHAIlCTO0qq+9gU7Vnh9r5
        cUc2FYmU+c4coZgUE0sciPOsHTFdSNXx2pAF0XOBqQyB8Mo9bz9huy7y3RHHBJycoDMTKBo5QP5wb
        6nIvOS3CNtG4zWP4jHBLabLeFXhk74WZkkM5xKNBKUg441xvSUeBd2w9I4goCNTeYQDEhGK3vFawk
        5vFwwUyat4pmuomrdBcPfALvW/WsbI0fFKWjQvY7ZhWGtZYTzhsigGLdPFa1eZwnGInzXDhu91FDL
        BIN8mmzw==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0c-0006ut-Uc; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fbQ-00; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Subject: [PATCH 31/44] docs: filesystems: convert orangefs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:17 +0100
Message-Id: <6f438eeff5b029d229197a602bd9b74004fe9b63.1581955849.git.mchehab+huawei@kernel.org>
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
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |   1 +
 .../{orangefs.txt => orangefs.rst}            | 187 ++++++++++--------
 2 files changed, 107 insertions(+), 81 deletions(-)
 rename Documentation/filesystems/{orangefs.txt => orangefs.rst} (83%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index fbee77175840..fed53f831192 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -79,6 +79,7 @@ Documentation for filesystem implementations.
    ocfs2
    ocfs2-online-filecheck
    omfs
+   orangefs
    overlayfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/orangefs.txt b/Documentation/filesystems/orangefs.rst
similarity index 83%
rename from Documentation/filesystems/orangefs.txt
rename to Documentation/filesystems/orangefs.rst
index f4ba94950e3f..7d6d4cad73c4 100644
--- a/Documentation/filesystems/orangefs.txt
+++ b/Documentation/filesystems/orangefs.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========
 ORANGEFS
 ========
 
@@ -21,25 +24,25 @@ Orangefs features include:
   * Stateless
 
 
-MAILING LIST ARCHIVES
+Mailing List Archives
 =====================
 
 http://lists.orangefs.org/pipermail/devel_lists.orangefs.org/
 
 
-MAILING LIST SUBMISSIONS
+Mailing List Submissions
 ========================
 
 devel@lists.orangefs.org
 
 
-DOCUMENTATION
+Documentation
 =============
 
 http://www.orangefs.org/documentation/
 
 
-USERSPACE FILESYSTEM SOURCE
+Userspace Filesystem Source
 ===========================
 
 http://www.orangefs.org/download
@@ -48,16 +51,16 @@ Orangefs versions prior to 2.9.3 would not be compatible with the
 upstream version of the kernel client.
 
 
-RUNNING ORANGEFS ON A SINGLE SERVER
+Running ORANGEFS On a Single Server
 ===================================
 
 OrangeFS is usually run in large installations with multiple servers and
 clients, but a complete filesystem can be run on a single machine for
 development and testing.
 
-On Fedora, install orangefs and orangefs-server.
+On Fedora, install orangefs and orangefs-server::
 
-dnf -y install orangefs orangefs-server
+    dnf -y install orangefs orangefs-server
 
 There is an example server configuration file in
 /etc/orangefs/orangefs.conf.  Change localhost to your hostname if
@@ -70,29 +73,29 @@ single line.  Uncomment it and change the hostname if necessary.  This
 controls clients which use libpvfs2.  This does not control the
 pvfs2-client-core.
 
-Create the filesystem.
+Create the filesystem::
 
-pvfs2-server -f /etc/orangefs/orangefs.conf
+    pvfs2-server -f /etc/orangefs/orangefs.conf
 
-Start the server.
+Start the server::
 
-systemctl start orangefs-server
+    systemctl start orangefs-server
 
-Test the server.
+Test the server::
 
-pvfs2-ping -m /pvfsmnt
+    pvfs2-ping -m /pvfsmnt
 
 Start the client.  The module must be compiled in or loaded before this
-point.
+point::
 
-systemctl start orangefs-client
+    systemctl start orangefs-client
 
-Mount the filesystem.
+Mount the filesystem::
 
-mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
+    mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
 
 
-BUILDING ORANGEFS ON A SINGLE SERVER
+Building ORANGEFS on a Single Server
 ====================================
 
 Where OrangeFS cannot be installed from distribution packages, it may be
@@ -102,49 +105,51 @@ You can omit --prefix if you don't care that things are sprinkled around
 in /usr/local.  As of version 2.9.6, OrangeFS uses Berkeley DB by
 default, we will probably be changing the default to LMDB soon.
 
-./configure --prefix=/opt/ofs --with-db-backend=lmdb
+::
 
-make
+    ./configure --prefix=/opt/ofs --with-db-backend=lmdb
 
-make install
+    make
 
-Create an orangefs config file.
+    make install
 
-/opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
+Create an orangefs config file::
 
-Create an /etc/pvfs2tab file.
+    /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
 
-echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
-    /etc/pvfs2tab
+Create an /etc/pvfs2tab file::
 
-Create the mount point you specified in the tab file if needed.
+    echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
+	/etc/pvfs2tab
 
-mkdir /pvfsmnt
+Create the mount point you specified in the tab file if needed::
 
-Bootstrap the server.
+    mkdir /pvfsmnt
 
-/opt/ofs/sbin/pvfs2-server -f /etc/pvfs2.conf
+Bootstrap the server::
 
-Start the server.
+    /opt/ofs/sbin/pvfs2-server -f /etc/pvfs2.conf
 
-/opt/osf/sbin/pvfs2-server /etc/pvfs2.conf
+Start the server::
+
+    /opt/osf/sbin/pvfs2-server /etc/pvfs2.conf
 
 Now the server should be running. Pvfs2-ls is a simple
-test to verify that the server is running.
+test to verify that the server is running::
 
-/opt/ofs/bin/pvfs2-ls /pvfsmnt
+    /opt/ofs/bin/pvfs2-ls /pvfsmnt
 
 If stuff seems to be working, load the kernel module and
-turn on the client core.
+turn on the client core::
 
-/opt/ofs/sbin/pvfs2-client -p /opt/osf/sbin/pvfs2-client-core
+    /opt/ofs/sbin/pvfs2-client -p /opt/osf/sbin/pvfs2-client-core
 
-Mount your filesystem.
+Mount your filesystem::
 
-mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
+    mount -t pvfs2 tcp://localhost:3334/orangefs /pvfsmnt
 
 
-RUNNING XFSTESTS
+Running xfstests
 ================
 
 It is useful to use a scratch filesystem with xfstests.  This can be
@@ -159,21 +164,23 @@ Then there are two FileSystem sections: orangefs and scratch.
 
 This change should be made before creating the filesystem.
 
-pvfs2-server -f /etc/orangefs/orangefs.conf
+::
 
-To run xfstests, create /etc/xfsqa.config.
+    pvfs2-server -f /etc/orangefs/orangefs.conf
 
-TEST_DIR=/orangefs
-TEST_DEV=tcp://localhost:3334/orangefs
-SCRATCH_MNT=/scratch
-SCRATCH_DEV=tcp://localhost:3334/scratch
+To run xfstests, create /etc/xfsqa.config::
 
-Then xfstests can be run
+    TEST_DIR=/orangefs
+    TEST_DEV=tcp://localhost:3334/orangefs
+    SCRATCH_MNT=/scratch
+    SCRATCH_DEV=tcp://localhost:3334/scratch
 
-./check -pvfs2
+Then xfstests can be run::
 
+    ./check -pvfs2
 
-OPTIONS
+
+Options
 =======
 
 The following mount options are accepted:
@@ -193,32 +200,32 @@ The following mount options are accepted:
     Distributed locking is being worked on for the future.
 
 
-DEBUGGING
+Debugging
 =========
 
 If you want the debug (GOSSIP) statements in a particular
-source file (inode.c for example) go to syslog:
+source file (inode.c for example) go to syslog::
 
   echo inode > /sys/kernel/debug/orangefs/kernel-debug
 
-No debugging (the default):
+No debugging (the default)::
 
   echo none > /sys/kernel/debug/orangefs/kernel-debug
 
-Debugging from several source files:
+Debugging from several source files::
 
   echo inode,dir > /sys/kernel/debug/orangefs/kernel-debug
 
-All debugging:
+All debugging::
 
   echo all > /sys/kernel/debug/orangefs/kernel-debug
 
-Get a list of all debugging keywords:
+Get a list of all debugging keywords::
 
   cat /sys/kernel/debug/orangefs/debug-help
 
 
-PROTOCOL BETWEEN KERNEL MODULE AND USERSPACE
+Protocol between Kernel Module and Userspace
 ============================================
 
 Orangefs is a user space filesystem and an associated kernel module.
@@ -234,7 +241,8 @@ The kernel module implements a pseudo device that userspace
 can read from and write to. Userspace can also manipulate the
 kernel module through the pseudo device with ioctl.
 
-THE BUFMAP:
+The Bufmap
+----------
 
 At startup userspace allocates two page-size-aligned (posix_memalign)
 mlocked memory buffers, one is used for IO and one is used for readdir
@@ -250,7 +258,8 @@ copied from user space to kernel space with copy_from_user and is used
 to initialize the kernel module's "bufmap" (struct orangefs_bufmap), which
 then contains:
 
-  * refcnt - a reference counter
+  * refcnt
+    - a reference counter
   * desc_size - PVFS2_BUFMAP_DEFAULT_DESC_SIZE (4194304) - the IO buffer's
     partition size, which represents the filesystem's block size and
     is used for s_blocksize in super blocks.
@@ -259,17 +268,19 @@ then contains:
   * desc_shift - log2(desc_size), used for s_blocksize_bits in super blocks.
   * total_size - the total size of the IO buffer.
   * page_count - the number of 4096 byte pages in the IO buffer.
-  * page_array - a pointer to page_count * (sizeof(struct page*)) bytes
+  * page_array - a pointer to ``page_count * (sizeof(struct page*))`` bytes
     of kcalloced memory. This memory is used as an array of pointers
     to each of the pages in the IO buffer through a call to get_user_pages.
-  * desc_array - a pointer to desc_count * (sizeof(struct orangefs_bufmap_desc))
+  * desc_array - a pointer to ``desc_count * (sizeof(struct orangefs_bufmap_desc))``
     bytes of kcalloced memory. This memory is further intialized:
 
       user_desc is the kernel's copy of the IO buffer's ORANGEFS_dev_map_desc
       structure. user_desc->ptr points to the IO buffer.
 
-      pages_per_desc = bufmap->desc_size / PAGE_SIZE
-      offset = 0
+      ::
+
+	pages_per_desc = bufmap->desc_size / PAGE_SIZE
+	offset = 0
 
         bufmap->desc_array[0].page_array = &bufmap->page_array[offset]
         bufmap->desc_array[0].array_count = pages_per_desc = 1024
@@ -293,7 +304,8 @@ then contains:
   * readdir_index_lock - a spinlock to protect readdir_index_array during
     update.
 
-OPERATIONS:
+Operations
+----------
 
 The kernel module builds an "op" (struct orangefs_kernel_op_s) when it
 needs to communicate with userspace. Part of the op contains the "upcall"
@@ -308,13 +320,19 @@ in flight at any given time.
 
 Ops are stateful:
 
- * unknown  - op was just initialized
- * waiting  - op is on request_list (upward bound)
- * inprogr  - op is in progress (waiting for downcall)
- * serviced - op has matching downcall; ok
- * purged   - op has to start a timer since client-core
+ * unknown
+	    - op was just initialized
+ * waiting
+	    - op is on request_list (upward bound)
+ * inprogr
+	    - op is in progress (waiting for downcall)
+ * serviced
+	    - op has matching downcall; ok
+ * purged
+	    - op has to start a timer since client-core
               exited uncleanly before servicing op
- * given up - submitter has given up waiting for it
+ * given up
+	    - submitter has given up waiting for it
 
 When some arbitrary userspace program needs to perform a
 filesystem operation on Orangefs (readdir, I/O, create, whatever)
@@ -389,10 +407,15 @@ union of structs, each of which is associated with a particular
 response type.
 
 The several members outside of the union are:
- - int32_t type - type of operation.
- - int32_t status - return code for the operation.
- - int64_t trailer_size - 0 unless readdir operation.
- - char *trailer_buf - initialized to NULL, used during readdir operations.
+
+ ``int32_t type``
+    - type of operation.
+ ``int32_t status``
+    - return code for the operation.
+ ``int64_t trailer_size``
+    - 0 unless readdir operation.
+ ``char *trailer_buf``
+    - initialized to NULL, used during readdir operations.
 
 The appropriate member inside the union is filled out for any
 particular response.
@@ -449,18 +472,20 @@ Userspace uses writev() on /dev/pvfs2-req to pass responses to the requests
 made by the kernel side.
 
 A buffer_list containing:
+
   - a pointer to the prepared response to the request from the
     kernel (struct pvfs2_downcall_t).
   - and also, in the case of a readdir request, a pointer to a
     buffer containing descriptors for the objects in the target
     directory.
+
 ... is sent to the function (PINT_dev_write_list) which performs
 the writev.
 
 PINT_dev_write_list has a local iovec array: struct iovec io_array[10];
 
 The first four elements of io_array are initialized like this for all
-responses:
+responses::
 
   io_array[0].iov_base = address of local variable "proto_ver" (int32_t)
   io_array[0].iov_len = sizeof(int32_t)
@@ -475,7 +500,7 @@ responses:
                          of global variable vfs_request (vfs_request_t)
   io_array[3].iov_len = sizeof(pvfs2_downcall_t)
 
-Readdir responses initialize the fifth element io_array like this:
+Readdir responses initialize the fifth element io_array like this::
 
   io_array[4].iov_base = contents of member trailer_buf (char *)
                          from out_downcall member of global variable
@@ -517,13 +542,13 @@ from a dentry is cheap, obtaining it from userspace is relatively expensive,
 hence the motivation to use the dentry when possible.
 
 The timeout values d_time and getattr_time are jiffy based, and the
-code is designed to avoid the jiffy-wrap problem:
+code is designed to avoid the jiffy-wrap problem::
 
-"In general, if the clock may have wrapped around more than once, there
-is no way to tell how much time has elapsed. However, if the times t1
-and t2 are known to be fairly close, we can reliably compute the
-difference in a way that takes into account the possibility that the
-clock may have wrapped between times."
+    "In general, if the clock may have wrapped around more than once, there
+    is no way to tell how much time has elapsed. However, if the times t1
+    and t2 are known to be fairly close, we can reliably compute the
+    difference in a way that takes into account the possibility that the
+    clock may have wrapped between times."
 
-                      from course notes by instructor Andy Wang
+from course notes by instructor Andy Wang
 
-- 
2.24.1

