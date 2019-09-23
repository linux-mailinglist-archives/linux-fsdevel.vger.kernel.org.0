Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5262ABB85F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728693AbfIWPsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 11:48:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfIWPsQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 11:48:16 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D62205F4;
        Mon, 23 Sep 2019 15:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569253695;
        bh=wzG2zl1ghSK1OwbPID3sQYVBbITXZvGHKVGtVFvr5hg=;
        h=From:To:Cc:Subject:Date:From;
        b=YIgQhg9rE+wtbnOrvjqg+Opx16xDRVZIbV3M5VveMd6+oKZU7f7RfoCuDqUMmrvSl
         ynrLk3mRd9maPLBGNkxetKAgTFDA0dYyR326dK+AFH22SMEkQwSv1VyM4svaFUs6hS
         1c4aEQxwi6iChTzbwrwWGpff9iXvBMFkv9slm3PQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Evgeniy Dushistov <dushistov@mail.ru>,
        Jiri Kosina <trivial@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH trivial] fs: Fix Kconfig indentation
Date:   Mon, 23 Sep 2019 17:48:04 +0200
Message-Id: <20190923154804.6696-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
    $ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 fs/9p/Kconfig     | 20 ++++++++++----------
 fs/Kconfig        |  4 ++--
 fs/Kconfig.binfmt |  4 ++--
 fs/fuse/Kconfig   |  4 ++--
 fs/nfs/Kconfig    |  6 +++---
 fs/proc/Kconfig   |  8 ++++----
 fs/qnx6/Kconfig   |  2 +-
 fs/ufs/Kconfig    |  4 ++--
 8 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/9p/Kconfig b/fs/9p/Kconfig
index ac2ec4543fe1..09fd4a185fd2 100644
--- a/fs/9p/Kconfig
+++ b/fs/9p/Kconfig
@@ -32,13 +32,13 @@ endif
 
 
 config 9P_FS_SECURITY
-        bool "9P Security Labels"
-        depends on 9P_FS
-        help
-          Security labels support alternative access control models
-          implemented by security modules like SELinux.  This option
-          enables an extended attribute handler for file security
-          labels in the 9P filesystem.
-
-          If you are not using a security module that requires using
-          extended attributes for file security labels, say N.
+	bool "9P Security Labels"
+	depends on 9P_FS
+	help
+	  Security labels support alternative access control models
+	  implemented by security modules like SELinux.  This option
+	  enables an extended attribute handler for file security
+	  labels in the 9P filesystem.
+
+	  If you are not using a security module that requires using
+	  extended attributes for file security labels, say N.
diff --git a/fs/Kconfig b/fs/Kconfig
index 2501e6f1f965..e65289487732 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -97,8 +97,8 @@ config FILE_LOCKING
 	default y
 	help
 	  This option enables standard file locking support, required
-          for filesystems like NFS and for the flock() system
-          call. Disabling this option saves about 11k.
+	  for filesystems like NFS and for the flock() system
+	  call. Disabling this option saves about 11k.
 
 config MANDATORY_FILE_LOCKING
 	bool "Enable Mandatory file locking"
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..8d0d16b90039 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -191,9 +191,9 @@ config BINFMT_MISC
 	  <file:Documentation/admin-guide/binfmt-misc.rst> to learn how to use this
 	  feature, <file:Documentation/admin-guide/java.rst> for information about how
 	  to include Java support. and <file:Documentation/admin-guide/mono.rst> for
-          information about how to include Mono-based .NET support.
+	  information about how to include Mono-based .NET support.
 
-          To use binfmt_misc, you will need to mount it:
+	  To use binfmt_misc, you will need to mount it:
 		mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
 
 	  You may say M here for module support and later load the module when
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 0635cba19971..eb2a585572dc 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -34,7 +34,7 @@ config VIRTIO_FS
 	select VIRTIO
 	help
 	  The Virtio Filesystem allows guests to mount file systems from the
-          host.
+	  host.
 
 	  If you want to share files between guests or with the host, answer Y
-          or M.
+	  or M.
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 295a7a21b774..3edf122b8044 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -147,10 +147,10 @@ config NFS_V4_1_MIGRATION
 	default n
 	help
 	  This option makes the NFS client advertise to NFSv4.1 servers that
-          it can support NFSv4 migration.
+	  it can support NFSv4 migration.
 
-          The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
-          still experimental.  If you are not an NFSv4 developer, say N here.
+	  The NFSv4.1 pieces of the Linux NFSv4 migration implementation are
+	  still experimental.  If you are not an NFSv4 developer, say N here.
 
 config NFS_V4_SECURITY_LABEL
 	bool
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index cb5629bd5fff..af2c0af60269 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -42,8 +42,8 @@ config PROC_VMCORE
 	bool "/proc/vmcore support"
 	depends on PROC_FS && CRASH_DUMP
 	default y
-        help
-        Exports the dump image of crashed kernel in ELF format.
+	help
+	Exports the dump image of crashed kernel in ELF format.
 
 config PROC_VMCORE_DEVICE_DUMP
 	bool "Device Hardware/Firmware Log Collection"
@@ -72,7 +72,7 @@ config PROC_SYSCTL
 	  a recompile of the kernel or reboot of the system.  The primary
 	  interface is through /proc/sys.  If you say Y here a tree of
 	  modifiable sysctl entries will be generated beneath the
-          /proc/sys directory. They are explained in the files
+	  /proc/sys directory. They are explained in the files
 	  in <file:Documentation/admin-guide/sysctl/>.  Note that enabling this
 	  option will enlarge the kernel by at least 8 KB.
 
@@ -88,7 +88,7 @@ config PROC_PAGE_MONITOR
 	  Various /proc files exist to monitor process memory utilization:
 	  /proc/pid/smaps, /proc/pid/clear_refs, /proc/pid/pagemap,
 	  /proc/kpagecount, and /proc/kpageflags. Disabling these
-          interfaces will reduce the size of the kernel by approximately 4kb.
+	  interfaces will reduce the size of the kernel by approximately 4kb.
 
 config PROC_CHILDREN
 	bool "Include /proc/<pid>/task/<tid>/children file"
diff --git a/fs/qnx6/Kconfig b/fs/qnx6/Kconfig
index 6a9d6bce1586..5ef679e51ba1 100644
--- a/fs/qnx6/Kconfig
+++ b/fs/qnx6/Kconfig
@@ -7,7 +7,7 @@ config QNX6FS_FS
 	  QNX 6 (also called QNX RTP).
 	  Further information is available at <http://www.qnx.com/>.
 	  Say Y if you intend to mount QNX hard disks or floppies formatted
-          with a mkqnx6fs.
+	  with a mkqnx6fs.
 	  However, keep in mind that this currently is a readonly driver!
 
 	  To compile this file system support as a module, choose M here: the
diff --git a/fs/ufs/Kconfig b/fs/ufs/Kconfig
index 6d30adb6b890..f1f725c5a28c 100644
--- a/fs/ufs/Kconfig
+++ b/fs/ufs/Kconfig
@@ -11,8 +11,8 @@ config UFS_FS
 	  experimental "UFS file system write support", below. Please read the
 	  file <file:Documentation/admin-guide/ufs.rst> for more information.
 
-          The recently released UFS2 variant (used in FreeBSD 5.x) is
-          READ-ONLY supported.
+	  The recently released UFS2 variant (used in FreeBSD 5.x) is
+	  READ-ONLY supported.
 
 	  Note that this option is generally not needed for floppies, since a
 	  good portable way to transport files and directories between unixes
-- 
2.17.1

