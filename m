Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C29421A25F7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Apr 2020 17:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgDHPrN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Apr 2020 11:47:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:49214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbgDHPqd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 386D120B1F;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=3JHCbMwWMX67tOKneW0yvzX2Zu1X6W2Q1eBoePr96kc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UddsOp4Mqc8eyECBjmZxHynSjFNDlVY5lSANa+4Yq68NcALn2dL6S7fKwQMLgIyGj
         /Hkij665HyIQ/5/n/18eozhuHs9kFGKCg+xZlJcJsh6LT/05aHA41HSRaNNd3RrVC/
         S4+FaMgpePCxMcFepAli4btrqzHEcr5rYurEixKg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cAe-8N; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Sterba <dsterba@suse.com>,
        David Howells <dhowells@redhat.com>,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Tyler Hicks <code@tyhicks.com>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>,
        Anton Altaparmakov <anton@tuxera.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-afs@lists.infradead.org,
        ecryptfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
        ocfs2-devel@oss.oracle.com
Subject: [PATCH 05/35] docs: filesystems: fix renamed references
Date:   Wed,  8 Apr 2020 17:45:57 +0200
Message-Id: <bcfddf36f60d928c78473af4e6a0b29904213c44.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Some filesystem references got broken by a previous patch
series I submitted. Address those.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/ABI/stable/sysfs-devices-node                 | 2 +-
 Documentation/ABI/testing/procfs-smaps_rollup               | 2 +-
 Documentation/admin-guide/cpu-load.rst                      | 2 +-
 Documentation/admin-guide/nfs/nfsroot.rst                   | 2 +-
 Documentation/driver-api/driver-model/device.rst            | 4 ++--
 Documentation/driver-api/driver-model/overview.rst          | 2 +-
 Documentation/filesystems/dax.txt                           | 2 +-
 Documentation/filesystems/dnotify.txt                       | 2 +-
 Documentation/filesystems/ramfs-rootfs-initramfs.rst        | 2 +-
 Documentation/filesystems/sysfs.rst                         | 2 +-
 Documentation/powerpc/firmware-assisted-dump.rst            | 2 +-
 Documentation/process/adding-syscalls.rst                   | 2 +-
 .../translations/it_IT/process/adding-syscalls.rst          | 2 +-
 Documentation/translations/zh_CN/filesystems/sysfs.txt      | 6 +++---
 drivers/base/core.c                                         | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h                     | 2 +-
 fs/Kconfig                                                  | 2 +-
 fs/Kconfig.binfmt                                           | 2 +-
 fs/adfs/Kconfig                                             | 2 +-
 fs/affs/Kconfig                                             | 2 +-
 fs/afs/Kconfig                                              | 6 +++---
 fs/bfs/Kconfig                                              | 2 +-
 fs/cramfs/Kconfig                                           | 2 +-
 fs/ecryptfs/Kconfig                                         | 2 +-
 fs/hfs/Kconfig                                              | 2 +-
 fs/hpfs/Kconfig                                             | 2 +-
 fs/isofs/Kconfig                                            | 2 +-
 fs/namespace.c                                              | 2 +-
 fs/notify/inotify/Kconfig                                   | 2 +-
 fs/ntfs/Kconfig                                             | 2 +-
 fs/ocfs2/Kconfig                                            | 2 +-
 fs/proc/Kconfig                                             | 4 ++--
 fs/romfs/Kconfig                                            | 2 +-
 fs/sysfs/dir.c                                              | 2 +-
 fs/sysfs/file.c                                             | 2 +-
 fs/sysfs/mount.c                                            | 2 +-
 fs/sysfs/symlink.c                                          | 2 +-
 fs/sysv/Kconfig                                             | 2 +-
 fs/udf/Kconfig                                              | 2 +-
 include/linux/kobject.h                                     | 2 +-
 include/linux/kobject_ns.h                                  | 2 +-
 include/linux/relay.h                                       | 2 +-
 include/linux/sysfs.h                                       | 2 +-
 kernel/relay.c                                              | 2 +-
 lib/kobject.c                                               | 4 ++--
 45 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-devices-node b/Documentation/ABI/stable/sysfs-devices-node
index df8413cf1468..484fc04bcc25 100644
--- a/Documentation/ABI/stable/sysfs-devices-node
+++ b/Documentation/ABI/stable/sysfs-devices-node
@@ -54,7 +54,7 @@ Date:		October 2002
 Contact:	Linux Memory Management list <linux-mm@kvack.org>
 Description:
 		Provides information about the node's distribution and memory
-		utilization. Similar to /proc/meminfo, see Documentation/filesystems/proc.txt
+		utilization. Similar to /proc/meminfo, see Documentation/filesystems/proc.rst
 
 What:		/sys/devices/system/node/nodeX/numastat
 Date:		October 2002
diff --git a/Documentation/ABI/testing/procfs-smaps_rollup b/Documentation/ABI/testing/procfs-smaps_rollup
index 274df44d8b1b..046978193368 100644
--- a/Documentation/ABI/testing/procfs-smaps_rollup
+++ b/Documentation/ABI/testing/procfs-smaps_rollup
@@ -11,7 +11,7 @@ Description:
 		Additionally, the fields Pss_Anon, Pss_File and Pss_Shmem
 		are not present in /proc/pid/smaps.  These fields represent
 		the sum of the Pss field of each type (anon, file, shmem).
-		For more details, see Documentation/filesystems/proc.txt
+		For more details, see Documentation/filesystems/proc.rst
 		and the procfs man page.
 
 		Typical output looks like this:
diff --git a/Documentation/admin-guide/cpu-load.rst b/Documentation/admin-guide/cpu-load.rst
index 2d01ce43d2a2..ebdecf864080 100644
--- a/Documentation/admin-guide/cpu-load.rst
+++ b/Documentation/admin-guide/cpu-load.rst
@@ -105,7 +105,7 @@ References
 ----------
 
 - http://lkml.org/lkml/2007/2/12/6
-- Documentation/filesystems/proc.txt (1.8)
+- Documentation/filesystems/proc.rst (1.8)
 
 
 Thanks
diff --git a/Documentation/admin-guide/nfs/nfsroot.rst b/Documentation/admin-guide/nfs/nfsroot.rst
index 82a4fda057f9..c6772075c80c 100644
--- a/Documentation/admin-guide/nfs/nfsroot.rst
+++ b/Documentation/admin-guide/nfs/nfsroot.rst
@@ -18,7 +18,7 @@ Mounting the root filesystem via NFS (nfsroot)
 In order to use a diskless system, such as an X-terminal or printer server for
 example, it is necessary for the root filesystem to be present on a non-disk
 device. This may be an initramfs (see
-Documentation/filesystems/ramfs-rootfs-initramfs.txt), a ramdisk (see
+Documentation/filesystems/ramfs-rootfs-initramfs.rst), a ramdisk (see
 Documentation/admin-guide/initrd.rst) or a filesystem mounted via NFS. The
 following text describes on how to use NFS for the root filesystem. For the rest
 of this text 'client' means the diskless system, and 'server' means the NFS
diff --git a/Documentation/driver-api/driver-model/device.rst b/Documentation/driver-api/driver-model/device.rst
index 2b868d49d349..b9b022371e85 100644
--- a/Documentation/driver-api/driver-model/device.rst
+++ b/Documentation/driver-api/driver-model/device.rst
@@ -50,10 +50,10 @@ Attributes
 
 Attributes of devices can be exported by a device driver through sysfs.
 
-Please see Documentation/filesystems/sysfs.txt for more information
+Please see Documentation/filesystems/sysfs.rst for more information
 on how sysfs works.
 
-As explained in Documentation/kobject.txt, device attributes must be
+As explained in Documentation/core-api/kobject.rst, device attributes must be
 created before the KOBJ_ADD uevent is generated. The only way to realize
 that is by defining an attribute group.
 
diff --git a/Documentation/driver-api/driver-model/overview.rst b/Documentation/driver-api/driver-model/overview.rst
index d4d1e9b40e0c..e98d0ab4a9b6 100644
--- a/Documentation/driver-api/driver-model/overview.rst
+++ b/Documentation/driver-api/driver-model/overview.rst
@@ -121,4 +121,4 @@ device-specific data or tunable interfaces.
 
 More information about the sysfs directory layout can be found in
 the other documents in this directory and in the file
-Documentation/filesystems/sysfs.txt.
+Documentation/filesystems/sysfs.rst.
diff --git a/Documentation/filesystems/dax.txt b/Documentation/filesystems/dax.txt
index 679729442fd2..735f3859b19f 100644
--- a/Documentation/filesystems/dax.txt
+++ b/Documentation/filesystems/dax.txt
@@ -74,7 +74,7 @@ are zeroed out and converted to written extents before being returned to avoid
 exposure of uninitialized data through mmap.
 
 These filesystems may be used for inspiration:
-- ext2: see Documentation/filesystems/ext2.txt
+- ext2: see Documentation/filesystems/ext2.rst
 - ext4: see Documentation/filesystems/ext4/
 - xfs:  see Documentation/admin-guide/xfs.rst
 
diff --git a/Documentation/filesystems/dnotify.txt b/Documentation/filesystems/dnotify.txt
index 15156883d321..08d575ece45d 100644
--- a/Documentation/filesystems/dnotify.txt
+++ b/Documentation/filesystems/dnotify.txt
@@ -67,4 +67,4 @@ See tools/testing/selftests/filesystems/dnotify_test.c for an example.
 NOTE
 ----
 Beginning with Linux 2.6.13, dnotify has been replaced by inotify.
-See Documentation/filesystems/inotify.txt for more information on it.
+See Documentation/filesystems/inotify.rst for more information on it.
diff --git a/Documentation/filesystems/ramfs-rootfs-initramfs.rst b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
index 6c576e241d86..3fddacc6bf14 100644
--- a/Documentation/filesystems/ramfs-rootfs-initramfs.rst
+++ b/Documentation/filesystems/ramfs-rootfs-initramfs.rst
@@ -71,7 +71,7 @@ be allowed write access to a ramfs mount.
 
 A ramfs derivative called tmpfs was created to add size limits, and the ability
 to write the data to swap space.  Normal users can be allowed write access to
-tmpfs mounts.  See Documentation/filesystems/tmpfs.txt for more information.
+tmpfs mounts.  See Documentation/filesystems/tmpfs.rst for more information.
 
 What is rootfs?
 ---------------
diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 290891c3fecb..ab0f7795792b 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -20,7 +20,7 @@ a means to export kernel data structures, their attributes, and the
 linkages between them to userspace.
 
 sysfs is tied inherently to the kobject infrastructure. Please read
-Documentation/kobject.txt for more information concerning the kobject
+Documentation/core-api/kobject.rst for more information concerning the kobject
 interface.
 
 
diff --git a/Documentation/powerpc/firmware-assisted-dump.rst b/Documentation/powerpc/firmware-assisted-dump.rst
index b3f3ee135dbe..20ea8cdee0aa 100644
--- a/Documentation/powerpc/firmware-assisted-dump.rst
+++ b/Documentation/powerpc/firmware-assisted-dump.rst
@@ -344,7 +344,7 @@ Here is the list of files under powerpc debugfs:
 
 
 NOTE:
-      Please refer to Documentation/filesystems/debugfs.txt on
+      Please refer to Documentation/filesystems/debugfs.rst on
       how to mount the debugfs filesystem.
 
 
diff --git a/Documentation/process/adding-syscalls.rst b/Documentation/process/adding-syscalls.rst
index 1c3a840d06b9..a6b4a3a5bf3f 100644
--- a/Documentation/process/adding-syscalls.rst
+++ b/Documentation/process/adding-syscalls.rst
@@ -33,7 +33,7 @@ interface.
        to a somewhat opaque API.
 
  - If you're just exposing runtime system information, a new node in sysfs
-   (see ``Documentation/filesystems/sysfs.txt``) or the ``/proc`` filesystem may
+   (see ``Documentation/filesystems/sysfs.rst``) or the ``/proc`` filesystem may
    be more appropriate.  However, access to these mechanisms requires that the
    relevant filesystem is mounted, which might not always be the case (e.g.
    in a namespaced/sandboxed/chrooted environment).  Avoid adding any API to
diff --git a/Documentation/translations/it_IT/process/adding-syscalls.rst b/Documentation/translations/it_IT/process/adding-syscalls.rst
index c3a3439595a6..bff0a82bf127 100644
--- a/Documentation/translations/it_IT/process/adding-syscalls.rst
+++ b/Documentation/translations/it_IT/process/adding-syscalls.rst
@@ -39,7 +39,7 @@ vostra interfaccia.
        un qualche modo opaca.
 
  - Se dovete esporre solo delle informazioni sul sistema, un nuovo nodo in
-   sysfs (vedere ``Documentation/filesystems/sysfs.txt``) o
+   sysfs (vedere ``Documentation/filesystems/sysfs.rst``) o
    in procfs potrebbe essere sufficiente.  Tuttavia, l'accesso a questi
    meccanismi richiede che il filesystem sia montato, il che potrebbe non
    essere sempre vero (per esempio, in ambienti come namespace/sandbox/chroot).
diff --git a/Documentation/translations/zh_CN/filesystems/sysfs.txt b/Documentation/translations/zh_CN/filesystems/sysfs.txt
index a15c3ebdfa82..fcf620049d11 100644
--- a/Documentation/translations/zh_CN/filesystems/sysfs.txt
+++ b/Documentation/translations/zh_CN/filesystems/sysfs.txt
@@ -1,4 +1,4 @@
-Chinese translated version of Documentation/filesystems/sysfs.txt
+Chinese translated version of Documentation/filesystems/sysfs.rst
 
 If you have any comment or update to the content, please contact the
 original document maintainer directly.  However, if you have a problem
@@ -10,7 +10,7 @@ Maintainer: Patrick Mochel	<mochel@osdl.org>
 		Mike Murphy <mamurph@cs.clemson.edu>
 Chinese maintainer: Fu Wei <tekkamanninja@gmail.com>
 ---------------------------------------------------------------------
-Documentation/filesystems/sysfs.txt 的中文翻译
+Documentation/filesystems/sysfs.rst 的中文翻译
 
 如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
 交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
@@ -40,7 +40,7 @@ sysfs 是一个最初基于 ramfs 且位于内存的文件系统。它提供导
 数据结构及其属性，以及它们之间的关联到用户空间的方法。
 
 sysfs 始终与 kobject 的底层结构紧密相关。请阅读
-Documentation/kobject.txt 文档以获得更多关于 kobject 接口的
+Documentation/core-api/kobject.rst 文档以获得更多关于 kobject 接口的
 信息。
 
 
diff --git a/drivers/base/core.c b/drivers/base/core.c
index 139cdf7e7327..89fcc0a09f94 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1374,7 +1374,7 @@ static void device_release(struct kobject *kobj)
 	else if (dev->class && dev->class->dev_release)
 		dev->class->dev_release(dev);
 	else
-		WARN(1, KERN_ERR "Device '%s' does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
+		WARN(1, KERN_ERR "Device '%s' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
 			dev_name(dev));
 	kfree(p);
 }
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
index 211f5de99a44..9aba2910d83a 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
@@ -170,7 +170,7 @@ struct dpu_global_state
  *
  * Main debugfs documentation is located at,
  *
- * Documentation/filesystems/debugfs.txt
+ * Documentation/filesystems/debugfs.rst
  *
  * @dpu_debugfs_setup_regset32: Initialize data for dpu_debugfs_create_regset32
  * @dpu_debugfs_create_regset32: Create 32-bit register dump file
diff --git a/fs/Kconfig b/fs/Kconfig
index f08fbbfafd9a..d1ad3935fb85 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -166,7 +166,7 @@ config TMPFS
 	  space. If you unmount a tmpfs instance, everything stored therein is
 	  lost.
 
-	  See <file:Documentation/filesystems/tmpfs.txt> for details.
+	  See <file:Documentation/filesystems/tmpfs.rst> for details.
 
 config TMPFS_POSIX_ACL
 	bool "Tmpfs POSIX Access Control Lists"
diff --git a/fs/Kconfig.binfmt b/fs/Kconfig.binfmt
index 62dc4f577ba1..3fbbd54f50fd 100644
--- a/fs/Kconfig.binfmt
+++ b/fs/Kconfig.binfmt
@@ -72,7 +72,7 @@ config CORE_DUMP_DEFAULT_ELF_HEADERS
 
 	  The core dump behavior can be controlled per process using
 	  the /proc/PID/coredump_filter pseudo-file; this setting is
-	  inherited.  See Documentation/filesystems/proc.txt for details.
+	  inherited.  See Documentation/filesystems/proc.rst for details.
 
 	  This config option changes the default setting of coredump_filter
 	  seen at boot time.  If unsure, say Y.
diff --git a/fs/adfs/Kconfig b/fs/adfs/Kconfig
index df4650dccf68..44738fed6625 100644
--- a/fs/adfs/Kconfig
+++ b/fs/adfs/Kconfig
@@ -12,7 +12,7 @@ config ADFS_FS
 
 	  The ADFS partition should be the first partition (i.e.,
 	  /dev/[hs]d?1) on each of your drives. Please read the file
-	  <file:Documentation/filesystems/adfs.txt> for further details.
+	  <file:Documentation/filesystems/adfs.rst> for further details.
 
 	  To compile this code as a module, choose M here: the module will be
 	  called adfs.
diff --git a/fs/affs/Kconfig b/fs/affs/Kconfig
index 84c46b9025c5..eb9d0ab850cb 100644
--- a/fs/affs/Kconfig
+++ b/fs/affs/Kconfig
@@ -9,7 +9,7 @@ config AFFS_FS
 	  FFS partition on your hard drive.  Amiga floppies however cannot be
 	  read with this driver due to an incompatibility of the floppy
 	  controller used in an Amiga and the standard floppy controller in
-	  PCs and workstations. Read <file:Documentation/filesystems/affs.txt>
+	  PCs and workstations. Read <file:Documentation/filesystems/affs.rst>
 	  and <file:fs/affs/Changes>.
 
 	  With this driver you can also mount disk files used by Bernd
diff --git a/fs/afs/Kconfig b/fs/afs/Kconfig
index 3fb1f559e317..1ad211d72b3b 100644
--- a/fs/afs/Kconfig
+++ b/fs/afs/Kconfig
@@ -8,7 +8,7 @@ config AFS_FS
 	  If you say Y here, you will get an experimental Andrew File System
 	  driver. It currently only supports unsecured read-only AFS access.
 
-	  See <file:Documentation/filesystems/afs.txt> for more information.
+	  See <file:Documentation/filesystems/afs.rst> for more information.
 
 	  If unsure, say N.
 
@@ -18,7 +18,7 @@ config AFS_DEBUG
 	help
 	  Say Y here to make runtime controllable debugging messages appear.
 
-	  See <file:Documentation/filesystems/afs.txt> for more information.
+	  See <file:Documentation/filesystems/afs.rst> for more information.
 
 	  If unsure, say N.
 
@@ -37,6 +37,6 @@ config AFS_DEBUG_CURSOR
 	  the dmesg log if the server rotation algorithm fails to successfully
 	  contact a server.
 
-	  See <file:Documentation/filesystems/afs.txt> for more information.
+	  See <file:Documentation/filesystems/afs.rst> for more information.
 
 	  If unsure, say N.
diff --git a/fs/bfs/Kconfig b/fs/bfs/Kconfig
index 3e1247f07913..3a757805b585 100644
--- a/fs/bfs/Kconfig
+++ b/fs/bfs/Kconfig
@@ -11,7 +11,7 @@ config BFS_FS
 	  on your /stand slice from within Linux.  You then also need to say Y
 	  to "UnixWare slices support", below.  More information about the BFS
 	  file system is contained in the file
-	  <file:Documentation/filesystems/bfs.txt>.
+	  <file:Documentation/filesystems/bfs.rst>.
 
 	  If you don't know what this is about, say N.
 
diff --git a/fs/cramfs/Kconfig b/fs/cramfs/Kconfig
index c8bebb70a971..d98cef0dbb6b 100644
--- a/fs/cramfs/Kconfig
+++ b/fs/cramfs/Kconfig
@@ -9,7 +9,7 @@ config CRAMFS
 	  limited to 256MB file systems (with 16MB files), and doesn't support
 	  16/32 bits uid/gid, hard links and timestamps.
 
-	  See <file:Documentation/filesystems/cramfs.txt> and
+	  See <file:Documentation/filesystems/cramfs.rst> and
 	  <file:fs/cramfs/README> for further information.
 
 	  To compile this as a module, choose M here: the module will be called
diff --git a/fs/ecryptfs/Kconfig b/fs/ecryptfs/Kconfig
index 522c35d5292b..1bdeaa6d5790 100644
--- a/fs/ecryptfs/Kconfig
+++ b/fs/ecryptfs/Kconfig
@@ -7,7 +7,7 @@ config ECRYPT_FS
 	select CRYPTO_MD5
 	help
 	  Encrypted filesystem that operates on the VFS layer.  See
-	  <file:Documentation/filesystems/ecryptfs.txt> to learn more about
+	  <file:Documentation/filesystems/ecryptfs.rst> to learn more about
 	  eCryptfs.  Userspace components are required and can be
 	  obtained from <http://ecryptfs.sf.net>.
 
diff --git a/fs/hfs/Kconfig b/fs/hfs/Kconfig
index 44f6e89bcb75..129926b5142d 100644
--- a/fs/hfs/Kconfig
+++ b/fs/hfs/Kconfig
@@ -6,7 +6,7 @@ config HFS_FS
 	help
 	  If you say Y here, you will be able to mount Macintosh-formatted
 	  floppy disks and hard drive partitions with full read-write access.
-	  Please read <file:Documentation/filesystems/hfs.txt> to learn about
+	  Please read <file:Documentation/filesystems/hfs.rst> to learn about
 	  the available mount options.
 
 	  To compile this file system support as a module, choose M here: the
diff --git a/fs/hpfs/Kconfig b/fs/hpfs/Kconfig
index 56aa0336254a..2b36dc6f0a10 100644
--- a/fs/hpfs/Kconfig
+++ b/fs/hpfs/Kconfig
@@ -9,7 +9,7 @@ config HPFS_FS
 	  write files to an OS/2 HPFS partition on your hard drive. OS/2
 	  floppies however are in regular MSDOS format, so you don't need this
 	  option in order to be able to read them. Read
-	  <file:Documentation/filesystems/hpfs.txt>.
+	  <file:Documentation/filesystems/hpfs.rst>.
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called hpfs.  If unsure, say N.
diff --git a/fs/isofs/Kconfig b/fs/isofs/Kconfig
index 5e7419599f50..08ffd37b9bb8 100644
--- a/fs/isofs/Kconfig
+++ b/fs/isofs/Kconfig
@@ -8,7 +8,7 @@ config ISO9660_FS
 	  long Unix filenames and symbolic links are also supported by this
 	  driver.  If you have a CD-ROM drive and want to do more with it than
 	  just listen to audio CDs and watch its LEDs, say Y (and read
-	  <file:Documentation/filesystems/isofs.txt> and the CD-ROM-HOWTO,
+	  <file:Documentation/filesystems/isofs.rst> and the CD-ROM-HOWTO,
 	  available from <http://www.tldp.org/docs.html#howto>), thereby
 	  enlarging your kernel by about 27 KB; otherwise say N.
 
diff --git a/fs/namespace.c b/fs/namespace.c
index e6aed405611d..894a1d12fe5f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3592,7 +3592,7 @@ EXPORT_SYMBOL(path_is_under);
  * file system may be mounted on put_old. After all, new_root is a mountpoint.
  *
  * Also, the current root cannot be on the 'rootfs' (initial ramfs) filesystem.
- * See Documentation/filesystems/ramfs-rootfs-initramfs.txt for alternatives
+ * See Documentation/filesystems/ramfs-rootfs-initramfs.rst for alternatives
  * in this situation.
  *
  * Notes:
diff --git a/fs/notify/inotify/Kconfig b/fs/notify/inotify/Kconfig
index 6736e47d94d8..7715fadd5fff 100644
--- a/fs/notify/inotify/Kconfig
+++ b/fs/notify/inotify/Kconfig
@@ -12,6 +12,6 @@ config INOTIFY_USER
 	  new features including multiple file events, one-shot support, and
 	  unmount notification.
 
-	  For more information, see <file:Documentation/filesystems/inotify.txt>
+	  For more information, see <file:Documentation/filesystems/inotify.rst>
 
 	  If unsure, say Y.
diff --git a/fs/ntfs/Kconfig b/fs/ntfs/Kconfig
index de9fb5cff226..1667a7e590d8 100644
--- a/fs/ntfs/Kconfig
+++ b/fs/ntfs/Kconfig
@@ -18,7 +18,7 @@ config NTFS_FS
 	  the Linux 2.4 kernel series is separately available as a patch
 	  from the project web site.
 
-	  For more information see <file:Documentation/filesystems/ntfs.txt>
+	  For more information see <file:Documentation/filesystems/ntfs.rst>
 	  and <http://www.linux-ntfs.org/>.
 
 	  To compile this file system support as a module, choose M here: the
diff --git a/fs/ocfs2/Kconfig b/fs/ocfs2/Kconfig
index 46bba20da6b5..1177c33df895 100644
--- a/fs/ocfs2/Kconfig
+++ b/fs/ocfs2/Kconfig
@@ -21,7 +21,7 @@ config OCFS2_FS
 	  OCFS2 mailing lists: http://oss.oracle.com/projects/ocfs2/mailman/
 
 	  For more information on OCFS2, see the file
-	  <file:Documentation/filesystems/ocfs2.txt>.
+	  <file:Documentation/filesystems/ocfs2.rst>.
 
 config OCFS2_FS_O2CB
 	tristate "O2CB Kernelspace Clustering"
diff --git a/fs/proc/Kconfig b/fs/proc/Kconfig
index 27ef84d99f59..971a42f6357d 100644
--- a/fs/proc/Kconfig
+++ b/fs/proc/Kconfig
@@ -23,7 +23,7 @@ config PROC_FS
 	  /proc" or the equivalent line in /etc/fstab does the job.
 
 	  The /proc file system is explained in the file
-	  <file:Documentation/filesystems/proc.txt> and on the proc(5) manpage
+	  <file:Documentation/filesystems/proc.rst> and on the proc(5) manpage
 	  ("man 5 proc").
 
 	  This option will enlarge your kernel by about 67 KB. Several
@@ -95,7 +95,7 @@ config PROC_CHILDREN
 	default n
 	help
 	  Provides a fast way to retrieve first level children pids of a task. See
-	  <file:Documentation/filesystems/proc.txt> for more information.
+	  <file:Documentation/filesystems/proc.rst> for more information.
 
 	  Say Y if you are running any user-space software which takes benefit from
 	  this interface. For example, rkt is such a piece of software.
diff --git a/fs/romfs/Kconfig b/fs/romfs/Kconfig
index ad4c45788896..9737b8e68878 100644
--- a/fs/romfs/Kconfig
+++ b/fs/romfs/Kconfig
@@ -6,7 +6,7 @@ config ROMFS_FS
 	  This is a very small read-only file system mainly intended for
 	  initial ram disks of installation disks, but it could be used for
 	  other read-only media as well.  Read
-	  <file:Documentation/filesystems/romfs.txt> for details.
+	  <file:Documentation/filesystems/romfs.rst> for details.
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called romfs.  Note that the file system of your
diff --git a/fs/sysfs/dir.c b/fs/sysfs/dir.c
index aa85f2874a9f..59dffd5ca517 100644
--- a/fs/sysfs/dir.c
+++ b/fs/sysfs/dir.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2007 SUSE Linux Products GmbH
  * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
  *
- * Please see Documentation/filesystems/sysfs.txt for more information.
+ * Please see Documentation/filesystems/sysfs.rst for more information.
  */
 
 #define pr_fmt(fmt)	"sysfs: " fmt
diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
index 26bbf960e2a2..f275fcda62fb 100644
--- a/fs/sysfs/file.c
+++ b/fs/sysfs/file.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2007 SUSE Linux Products GmbH
  * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
  *
- * Please see Documentation/filesystems/sysfs.txt for more information.
+ * Please see Documentation/filesystems/sysfs.rst for more information.
  */
 
 #include <linux/module.h>
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index db81cfbab9d6..e747c135c1d1 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2007 SUSE Linux Products GmbH
  * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
  *
- * Please see Documentation/filesystems/sysfs.txt for more information.
+ * Please see Documentation/filesystems/sysfs.rst for more information.
  */
 
 #include <linux/fs.h>
diff --git a/fs/sysfs/symlink.c b/fs/sysfs/symlink.c
index c4deecc80f67..5603530a1a52 100644
--- a/fs/sysfs/symlink.c
+++ b/fs/sysfs/symlink.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2007 SUSE Linux Products GmbH
  * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
  *
- * Please see Documentation/filesystems/sysfs.txt for more information.
+ * Please see Documentation/filesystems/sysfs.rst for more information.
  */
 
 #include <linux/fs.h>
diff --git a/fs/sysv/Kconfig b/fs/sysv/Kconfig
index d4edf7d9ae10..b4e23e03fbeb 100644
--- a/fs/sysv/Kconfig
+++ b/fs/sysv/Kconfig
@@ -28,7 +28,7 @@ config SYSV_FS
 	  tar" or preferably "info tar").  Note also that this option has
 	  nothing whatsoever to do with the option "System V IPC". Read about
 	  the System V file system in
-	  <file:Documentation/filesystems/sysv-fs.txt>.
+	  <file:Documentation/filesystems/sysv-fs.rst>.
 	  Saying Y here will enlarge your kernel by about 27 KB.
 
 	  To compile this as a module, choose M here: the module will be called
diff --git a/fs/udf/Kconfig b/fs/udf/Kconfig
index 6848de581ce1..26e1a49f3ba7 100644
--- a/fs/udf/Kconfig
+++ b/fs/udf/Kconfig
@@ -9,7 +9,7 @@ config UDF_FS
 	  compatible with standard unix file systems, it is also suitable for
 	  removable USB disks. Say Y if you intend to mount DVD discs or CDRW's
 	  written in packet mode, or if you want to use UDF for removable USB
-	  disks. Please read <file:Documentation/filesystems/udf.txt>.
+	  disks. Please read <file:Documentation/filesystems/udf.rst>.
 
 	  To compile this file system support as a module, choose M here: the
 	  module will be called udf.
diff --git a/include/linux/kobject.h b/include/linux/kobject.h
index e2ca0a292e21..fc8d83e91379 100644
--- a/include/linux/kobject.h
+++ b/include/linux/kobject.h
@@ -7,7 +7,7 @@
  * Copyright (c) 2006-2008 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (c) 2006-2008 Novell Inc.
  *
- * Please read Documentation/kobject.txt before using the kobject
+ * Please read Documentation/core-api/kobject.rst before using the kobject
  * interface, ESPECIALLY the parts about reference counts and object
  * destructors.
  */
diff --git a/include/linux/kobject_ns.h b/include/linux/kobject_ns.h
index 069aa2ebef90..2b5b64256cf4 100644
--- a/include/linux/kobject_ns.h
+++ b/include/linux/kobject_ns.h
@@ -8,7 +8,7 @@
  *
  * Split from kobject.h by David Howells (dhowells@redhat.com)
  *
- * Please read Documentation/kobject.txt before using the kobject
+ * Please read Documentation/core-api/kobject.rst before using the kobject
  * interface, ESPECIALLY the parts about reference counts and object
  * destructors.
  */
diff --git a/include/linux/relay.h b/include/linux/relay.h
index c759f96e39c1..e13a333e7c37 100644
--- a/include/linux/relay.h
+++ b/include/linux/relay.h
@@ -141,7 +141,7 @@ struct rchan_callbacks
 	 * cause relay_open() to create a single global buffer rather
 	 * than the default set of per-cpu buffers.
 	 *
-	 * See Documentation/filesystems/relay.txt for more info.
+	 * See Documentation/filesystems/relay.rst for more info.
 	 */
 	struct dentry *(*create_buf_file)(const char *filename,
 					  struct dentry *parent,
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 80bb865b3a33..86067dbe7745 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -7,7 +7,7 @@
  * Copyright (c) 2007 SUSE Linux Products GmbH
  * Copyright (c) 2007 Tejun Heo <teheo@suse.de>
  *
- * Please see Documentation/filesystems/sysfs.txt for more information.
+ * Please see Documentation/filesystems/sysfs.rst for more information.
  */
 
 #ifndef _SYSFS_H_
diff --git a/kernel/relay.c b/kernel/relay.c
index 07ee1a791d85..628f570ca678 100644
--- a/kernel/relay.c
+++ b/kernel/relay.c
@@ -1,7 +1,7 @@
 /*
  * Public API and common code for kernel->userspace relay file support.
  *
- * See Documentation/filesystems/relay.txt for an overview.
+ * See Documentation/filesystems/relay.rst for an overview.
  *
  * Copyright (C) 2002-2005 - Tom Zanussi (zanussi@us.ibm.com), IBM Corp
  * Copyright (C) 1999-2005 - Karim Yaghmour (karim@opersys.com)
diff --git a/lib/kobject.c b/lib/kobject.c
index 83198cb37d8d..65fa7bf70c57 100644
--- a/lib/kobject.c
+++ b/lib/kobject.c
@@ -6,7 +6,7 @@
  * Copyright (c) 2006-2007 Greg Kroah-Hartman <greg@kroah.com>
  * Copyright (c) 2006-2007 Novell Inc.
  *
- * Please see the file Documentation/kobject.txt for critical information
+ * Please see the file Documentation/core-api/kobject.rst for critical information
  * about using the kobject interface.
  */
 
@@ -670,7 +670,7 @@ static void kobject_cleanup(struct kobject *kobj)
 		 kobject_name(kobj), kobj, __func__, kobj->parent);
 
 	if (t && !t->release)
-		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/kobject.txt.\n",
+		pr_debug("kobject: '%s' (%p): does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.\n",
 			 kobject_name(kobj), kobj);
 
 	/* send "remove" if the caller did not do it but sent "add" */
-- 
2.25.2

