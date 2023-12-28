Return-Path: <linux-fsdevel+bounces-6999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA00E81F7EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 12:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A061F23328
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Dec 2023 11:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7D6FDA;
	Thu, 28 Dec 2023 11:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMcCdNaj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39E66FCB
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 11:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a26f3e98619so290977166b.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Dec 2023 03:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703763973; x=1704368773; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zr55fPoyPsywZ+YmZQbBw3erx8d0AoGV3VvNdCfQZuY=;
        b=bMcCdNajv6YVMTlIOscPzAmD5jF738+gnreBjWf+9ZjWbtjxbIog1UTU8ss2ghFcto
         9pd/ba+270glvuZYrqNEHY94OTKrCkgzDahbMZYfUBdv8E6PRR1yxxI5zgqNgmp5A/c6
         7Vt6pBerh8ZXADLzzaeXTGzaeRfHkJGfYPXPJDcTMAxiplOUaN8p9qBzwbgisS4iJVvO
         HWGYfyxpDXFonVlTeo24fEvfvBlmdhjq4MgkOT/lI0RLSYxgRN1Z9+3QBcLjE4jmHqtO
         udDKop3g1yn2CQGd+p0o8dElLFw1D44++DHBYUwLLTZQT56skKDH0lxq7494TrYf4r9n
         Zplg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703763973; x=1704368773;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zr55fPoyPsywZ+YmZQbBw3erx8d0AoGV3VvNdCfQZuY=;
        b=VNBxNQmG9qDsZxKokTgy3lp4lGVF0R2ouCHzB/R4rmcQ8ytcVePTx1Ftn/tR/6zueB
         nfrFqwZiDHpebAUggHiHLCW6W0vxMngGNmSZuX33LmjGGhvB0Se/fDkCdHzmGta00KLS
         GExMmu2E5T9jq9LoRx2T+CSMsxldCVfRF0Qdc6yc9WCLpk5qIF9tqBt1NCNI6TufAAPV
         LbefckYns5CHzQnH2YqE/KKxwW5PhxRB9nia51B5HBAdH1AfxbVwpZAwcRZG47cTNQnW
         2RVkfPwa3hGjtbjBiR3xqsv15Nb3JmqRbjRuDpJR2evf2KdFb9sx2m5/+7g9S1w7/oPZ
         VudQ==
X-Gm-Message-State: AOJu0YzLuxEae5kfUYMtK/vpk3pGAZpAlcYOvTdB0e2NJRFR+LA/Kwzm
	W539lzv7S3EiSrn4kYsix+tvdIVTxA==
X-Google-Smtp-Source: AGHT+IHrKMc3TS8sjuecWb0rXcfr2UlMHM0K/EGSRx14evNYnqYFDUTfypwsDqz/hkaVnlbiZeQFSA==
X-Received: by 2002:a17:906:4745:b0:a27:5a41:7e8 with SMTP id j5-20020a170906474500b00a275a4107e8mr934837ejs.149.1703763972535;
        Thu, 28 Dec 2023 03:46:12 -0800 (PST)
Received: from p183 ([46.53.248.146])
        by smtp.gmail.com with ESMTPSA id n16-20020a170906b31000b00a235e5139d2sm7425720ejz.150.2023.12.28.03.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 03:46:12 -0800 (PST)
Date: Thu, 28 Dec 2023 14:46:10 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: extract include/linux/fs_type.h
Message-ID: <1c70c171-a0e4-457e-af34-229d5a56951e@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

struct file_system_type is one of the things which could be extracted
out of include/linux/fs.h easily.

Drop some useless forward declarations and externs too.

I remember sched.h was bloated but

	#include <linux/fs.h>

on x86_64 allmodconfig somehow includes x86 segment descriptor stuff,
MSR, something about irq numbers, all low level page stuff, memory
zones, cpufreq, and task_struct definition with all sched.h the pieces.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/filesystems/vfs.rst         |    6 +--
 arch/powerpc/platforms/cell/spufs/inode.c |    1 
 arch/s390/hypfs/inode.c                   |    2 -
 arch/um/drivers/mconsole_kern.c           |    1 
 arch/x86/kernel/cpu/resctrl/rdtgroup.c    |    1 
 block/bdev.c                              |    1 
 drivers/android/binderfs.c                |    1 
 drivers/base/devtmpfs.c                   |    1 
 drivers/dax/super.c                       |    1 
 drivers/dma-buf/dma-buf.c                 |    1 
 drivers/gpu/drm/drm_drv.c                 |    1 
 drivers/gpu/drm/i915/gem/i915_gemfs.c     |    1 
 drivers/infiniband/hw/qib/qib_fs.c        |    1 
 drivers/misc/cxl/api.c                    |    1 
 drivers/misc/ibmasm/ibmasmfs.c            |    1 
 drivers/scsi/cxlflash/ocxl_hw.c           |    1 
 drivers/usb/gadget/function/f_fs.c        |    1 
 drivers/usb/gadget/legacy/inode.c         |    1 
 drivers/xen/xenfs/super.c                 |    1 
 fs/9p/v9fs.c                              |    1 
 fs/9p/vfs_super.c                         |    1 
 fs/adfs/super.c                           |    1 
 fs/affs/super.c                           |    1 
 fs/afs/internal.h                         |    1 
 fs/afs/super.c                            |    1 
 fs/aio.c                                  |    1 
 fs/anon_inodes.c                          |    1 
 fs/autofs/autofs_i.h                      |    1 
 fs/bcachefs/fs.c                          |    1 
 fs/befs/linuxvfs.c                        |    1 
 fs/bfs/inode.c                            |    1 
 fs/binfmt_misc.c                          |    3 -
 fs/btrfs/super.c                          |    1 
 fs/btrfs/tests/btrfs-tests.c              |    1 
 fs/ceph/super.c                           |    1 
 fs/coda/inode.c                           |    1 
 fs/configfs/mount.c                       |    1 
 fs/cramfs/inode.c                         |    1 
 fs/dcache.c                               |    1 
 fs/debugfs/inode.c                        |    1 
 fs/devpts/inode.c                         |    1 
 fs/ecryptfs/main.c                        |    1 
 fs/efivarfs/super.c                       |    1 
 fs/efs/super.c                            |    1 
 fs/erofs/internal.h                       |    1 
 fs/erofs/super.c                          |    1 
 fs/exfat/super.c                          |    1 
 fs/ext2/super.c                           |    1 
 fs/ext4/super.c                           |    1 
 fs/f2fs/super.c                           |    1 
 fs/fat/namei_msdos.c                      |    1 
 fs/fat/namei_vfat.c                       |    1 
 fs/filesystems.c                          |    1 
 fs/freevxfs/vxfs_super.c                  |    1 
 fs/fs_context.c                           |    1 
 fs/fsopen.c                               |    1 
 fs/fuse/control.c                         |    1 
 fs/fuse/inode.c                           |    1 
 fs/fuse/virtio_fs.c                       |    1 
 fs/gfs2/ops_fstype.c                      |    1 
 fs/gfs2/super.h                           |    1 
 fs/hfs/super.c                            |    1 
 fs/hfsplus/super.c                        |    1 
 fs/hostfs/hostfs_kern.c                   |    1 
 fs/hpfs/super.c                           |    1 
 fs/hugetlbfs/inode.c                      |    1 
 fs/inode.c                                |    1 
 fs/internal.h                             |    1 
 fs/isofs/inode.c                          |    1 
 fs/jffs2/super.c                          |    1 
 fs/jfs/super.c                            |    2 -
 fs/libfs.c                                |    1 
 fs/minix/inode.c                          |    1 
 fs/namespace.c                            |    1 
 fs/nfs/fs_context.c                       |    1 
 fs/nfs/internal.h                         |    1 
 fs/nfs/nfs.h                              |    1 
 fs/nfsd/nfs4proc.c                        |    1 
 fs/nfsd/nfsctl.c                          |    1 
 fs/nilfs2/super.c                         |    1 
 fs/nsfs.c                                 |    1 
 fs/ntfs/super.c                           |    1 
 fs/ntfs3/super.c                          |    1 
 fs/ocfs2/dlmfs/dlmfs.c                    |    1 
 fs/ocfs2/super.c                          |    1 
 fs/omfs/inode.c                           |    1 
 fs/openpromfs/inode.c                     |    1 
 fs/orangefs/orangefs-kernel.h             |    1 
 fs/overlayfs/super.c                      |    1 
 fs/pipe.c                                 |    1 
 fs/proc/proc_sysctl.c                     |    1 
 fs/proc/root.c                            |    1 
 fs/proc_namespace.c                       |    1 
 fs/pstore/inode.c                         |    1 
 fs/qnx4/inode.c                           |    1 
 fs/qnx6/inode.c                           |    1 
 fs/ramfs/inode.c                          |    1 
 fs/reiserfs/reiserfs.h                    |    1 
 fs/reiserfs/super.c                       |    1 
 fs/romfs/super.c                          |    1 
 fs/smb/client/cifsfs.c                    |    1 
 fs/smb/client/misc.c                      |    1 
 fs/squashfs/super.c                       |    1 
 fs/super.c                                |    1 
 fs/sysfs/mount.c                          |    1 
 fs/sysv/super.c                           |    1 
 fs/tracefs/inode.c                        |    1 
 fs/ubifs/super.c                          |    1 
 fs/udf/super.c                            |    1 
 fs/ufs/super.c                            |    1 
 fs/vboxsf/super.c                         |    1 
 fs/xfs/xfs_super.c                        |    1 
 fs/zonefs/super.c                         |    1 
 include/linux/cgroup.h                    |    1 
 include/linux/fs.h                        |   50 +-----------------------------
 include/linux/fs_type.h                   |   50 ++++++++++++++++++++++++++++++
 include/linux/init.h                      |    2 -
 include/linux/kernfs.h                    |    1 
 include/linux/sb_freeze.h                 |   17 ++++++++++
 init/do_mounts.c                          |    1 
 ipc/mqueue.c                              |    1 
 kernel/bpf/inode.c                        |    1 
 kernel/cgroup/cgroup.c                    |    1 
 kernel/resource.c                         |    1 
 kernel/trace/trace.c                      |    1 
 kernel/usermode_driver.c                  |    1 
 lib/test_kmod.c                           |    1 
 mm/secretmem.c                            |    1 
 mm/shmem.c                                |    2 -
 net/socket.c                              |    1 
 net/sunrpc/rpc_pipe.c                     |    1 
 security/apparmor/apparmorfs.c            |    1 
 security/apparmor/mount.c                 |    1 
 security/inode.c                          |    1 
 security/integrity/ima/ima_policy.c       |    1 
 security/selinux/selinuxfs.c              |    1 
 security/smack/smackfs.c                  |    1 
 security/tomoyo/mount.c                   |    1 
 138 files changed, 202 insertions(+), 61 deletions(-)

--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -87,10 +87,10 @@ functions:
 
 .. code-block:: c
 
-	#include <linux/fs.h>
+	#include <linux/fs_type.h>
 
-	extern int register_filesystem(struct file_system_type *);
-	extern int unregister_filesystem(struct file_system_type *);
+	int register_filesystem(struct file_system_type *);
+	int unregister_filesystem(struct file_system_type *);
 
 The passed struct file_system_type describes your filesystem.  When a
 request is made to mount a filesystem onto a directory in your
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/fsnotify.h>
 #include <linux/backing-dev.h>
 #include <linux/init.h>
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/namei.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
@@ -41,7 +42,6 @@ struct hypfs_sb_info {
 };
 
 static const struct file_operations hypfs_file_ops;
-static struct file_system_type hypfs_type;
 static const struct super_operations hypfs_s_ops;
 
 /* start of list of all dentries, which have to be deleted on update */
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -24,6 +24,7 @@
 #include <linux/workqueue.h>
 #include <linux/mutex.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/file.h>
 #include <linux/uaccess.h>
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -17,6 +17,7 @@
 #include <linux/debugfs.h>
 #include <linux/fs.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/sysfs.h>
 #include <linux/kernfs.h>
 #include <linux/seq_buf.h>
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -5,6 +5,7 @@
  *  Copyright (C) 2016 - 2020 Christoph Hellwig
  */
 
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -19,6 +19,7 @@
 #include <linux/mutex.h>
 #include <linux/mount.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -22,6 +22,7 @@
 #include <linux/blkdev.h>
 #include <linux/namei.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/shmem_fs.h>
 #include <linux/ramfs.h>
 #include <linux/sched.h>
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -13,6 +13,7 @@
 #include <linux/uio.h>
 #include <linux/dax.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include "dax-private.h"
 
 /**
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/dma-buf.h>
 #include <linux/dma-fence.h>
--- a/drivers/gpu/drm/drm_drv.c
+++ b/drivers/gpu/drm/drm_drv.c
@@ -28,6 +28,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mount.h>
--- a/drivers/gpu/drm/i915/gem/i915_gemfs.c
+++ b/drivers/gpu/drm/i915/gem/i915_gemfs.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 
 #include "i915_drv.h"
--- a/drivers/infiniband/hw/qib/qib_fs.c
+++ b/drivers/infiniband/hw/qib/qib_fs.c
@@ -34,6 +34,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -3,6 +3,7 @@
  * Copyright 2014 IBM Corp.
  */
 
+#include <linux/fs_type.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/file.h>
--- a/drivers/misc/ibmasm/ibmasmfs.c
+++ b/drivers/misc/ibmasm/ibmasmfs.c
@@ -61,6 +61,7 @@
 
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
--- a/drivers/scsi/cxlflash/ocxl_hw.c
+++ b/drivers/scsi/cxlflash/ocxl_hw.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/file.h>
+#include <linux/fs_type.h>
 #include <linux/idr.h>
 #include <linux/module.h>
 #include <linux/mount.h>
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -18,6 +18,7 @@
 #include <linux/pagemap.h>
 #include <linux/export.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/hid.h>
 #include <linux/mm.h>
 #include <linux/module.h>
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/uts.h>
 #include <linux/wait.h>
--- a/drivers/xen/xenfs/super.c
+++ b/drivers/xen/xenfs/super.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/magic.h>
 
 #include <xen/xen.h>
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/sched.h>
 #include <linux/cred.h>
 #include <linux/parser.h>
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/file.h>
 #include <linux/stat.h>
 #include <linux/string.h>
--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -4,6 +4,7 @@
  *
  *  Copyright (C) 1997-1999 Russell King
  */
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/parser.h>
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -11,6 +11,7 @@
  *  (C) 1991  Linus Torvalds - minix filesystem
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/statfs.h>
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/ktime.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/filelock.h>
 #include <linux/pagemap.h>
 #include <linux/rxrpc.h>
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -22,6 +22,7 @@
 #include <linux/fs.h>
 #include <linux/pagemap.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/statfs.h>
 #include <linux/sched.h>
 #include <linux/nsproxy.h>
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -24,6 +24,7 @@
 
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/file.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
--- a/fs/anon_inodes.c
+++ b/fs/anon_inodes.c
@@ -15,6 +15,7 @@
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -27,6 +27,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 
 /* This is the range of ioctl() numbers we claim as ours */
 #define AUTOFS_IOC_FIRST     AUTOFS_IOC_READY
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -31,6 +31,7 @@
 #include <linux/backing-dev.h>
 #include <linux/exportfs.h>
 #include <linux/fiemap.h>
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/posix_acl.h>
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/errno.h>
 #include <linux/stat.h>
 #include <linux/nls.h>
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/buffer_head.h>
 #include <linux/vfs.h>
 #include <linux/writeback.h>
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -24,6 +24,7 @@
 #include <linux/namei.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/uaccess.h>
@@ -60,8 +61,6 @@ typedef struct {
 	refcount_t users;		/* sync removal with load_misc_binary() */
 } Node;
 
-static struct file_system_type bm_fs_type;
-
 /*
  * Max length of the register string.  Determined by:
  *  - 7 delimiters
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -6,6 +6,7 @@
 #include <linux/blkdev.h>
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
--- a/fs/btrfs/tests/btrfs-tests.c
+++ b/fs/btrfs/tests/btrfs-tests.c
@@ -4,6 +4,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/magic.h>
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -5,6 +5,7 @@
 #include <linux/backing-dev.h>
 #include <linux/ctype.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/inet.h>
 #include <linux/in6.h>
 #include <linux/module.h>
--- a/fs/coda/inode.c
+++ b/fs/coda/inode.c
@@ -24,6 +24,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/uaccess.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/vmalloc.h>
 
 #include <linux/coda.h>
--- a/fs/configfs/mount.c
+++ b/fs/configfs/mount.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -25,6 +25,7 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/super.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/vfs.h>
 #include <linux/mutex.h>
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/fscrypt.h>
 #include <linux/fsnotify.h>
 #include <linux/slab.h>
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -14,6 +14,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/sched.h>
 #include <linux/namei.h>
 #include <linux/slab.h>
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -20,6 +20,7 @@
 #include <linux/key.h>
 #include <linux/parser.h>
 #include <linux/fs_stack.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/magic.h>
 #include "ecryptfs_kernel.h"
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -9,6 +9,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/ucs2_string.h>
--- a/fs/efs/super.c
+++ b/fs/efs/super.c
@@ -7,6 +7,7 @@
  * Portions derived from work (c) 1995,1996 Christian Vogelgsang.
  */
 
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/exportfs.h>
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -8,6 +8,7 @@
 #define __EROFS_INTERNAL_H
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/dax.h>
 #include <linux/dcache.h>
 #include <linux/mm.h>
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -9,6 +9,7 @@
 #include <linux/crc32c.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/exportfs.h>
 #include "xattr.h"
 
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -14,6 +14,7 @@
 #include <linux/seq_file.h>
 #include <linux/blkdev.h>
 #include <linux/fs_struct.h>
+#include <linux/fs_type.h>
 #include <linux/iversion.h>
 #include <linux/nls.h>
 #include <linux/buffer_head.h>
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -9,6 +9,7 @@
 #include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/sched/mm.h>
 #include <linux/statfs.h>
 #include <linux/buffer_head.h>
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -7,6 +7,7 @@
  *  Rewritten for constant inumbers 1999 by Al Viro
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/iversion.h>
 #include "fat.h"
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -16,6 +16,7 @@
  *				OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 
 /*
  * Handling of filesystem drivers list.
--- a/fs/freevxfs/vxfs_super.c
+++ b/fs/freevxfs/vxfs_super.c
@@ -12,6 +12,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/buffer_head.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/fs.h>
 #include <linux/mount.h>
 #include <linux/nsproxy.h>
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -7,6 +7,7 @@
 
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -11,6 +11,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 
 #define FUSE_CTL_SUPER_MAGIC 0x65735543
 
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -17,6 +17,7 @@
 #include <linux/moduleparam.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/statfs.h>
 #include <linux/random.h>
 #include <linux/sched.h>
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/highmem.h>
 #include <linux/uio.h>
 #include "fuse_i.h"
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/backing-dev.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 
 #include "gfs2.h"
 #include "incore.h"
--- a/fs/gfs2/super.h
+++ b/fs/gfs2/super.h
@@ -8,6 +8,7 @@
 #define __SUPER_DOT_H__
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/dcache.h>
 #include "incore.h"
 
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -12,6 +12,7 @@
  * Based on the minix file system code, (C) 1991, 1992 by Linus Torvalds
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -14,6 +14,7 @@
 #include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/vfs.h>
 #include <linux/nls.h>
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/magic.h>
 #include <linux/module.h>
 #include <linux/mm.h>
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -8,6 +8,7 @@
  */
 
 #include "hpfs_fn.h"
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/init.h>
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -27,6 +27,7 @@
 #include <linux/hugetlb.h>
 #include <linux/pagevec.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
 #include <linux/dnotify.h>
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -5,6 +5,7 @@
  */
 #include <linux/export.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/filelock.h>
 #include <linux/mm.h>
 #include <linux/backing-dev.h>
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -6,7 +6,6 @@
  */
 
 struct super_block;
-struct file_system_type;
 struct iomap;
 struct iomap_ops;
 struct linux_binprm;
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
 #include <linux/nls.h>
--- a/fs/jffs2/super.c
+++ b/fs/jffs2/super.c
@@ -17,6 +17,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/err.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/parser.h>
 #include <linux/completion.h>
@@ -42,7 +43,6 @@ static struct kmem_cache *jfs_inode_cachep;
 
 static const struct super_operations jfs_super_operations;
 static const struct export_operations jfs_export_operations;
-static struct file_system_type jfs_fs_type;
 
 #define MAX_COMMIT_THREADS 64
 static int commit_threads;
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -6,6 +6,7 @@
 
 #include <linux/blkdev.h>
 #include <linux/export.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/cred.h>
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -15,6 +15,7 @@
 #include "minix.h"
 #include <linux/buffer_head.h>
 #include <linux/slab.h>
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/highuid.h>
 #include <linux/vfs.h>
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -19,6 +19,7 @@
 #include <linux/idr.h>
 #include <linux/init.h>		/* init_rootfs */
 #include <linux/fs_struct.h>	/* get_fs_root et.al. */
+#include <linux/fs_type.h>
 #include <linux/fsnotify.h>	/* fsnotify_vfsmount_delete */
 #include <linux/file.h>
 #include <linux/uaccess.h>
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -15,6 +15,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_mount.h>
 #include <linux/nfs4_mount.h>
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -5,6 +5,7 @@
 
 #include "nfs4_fs.h"
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/security.h>
 #include <linux/crc32.h>
 #include <linux/sunrpc/addr.h>
--- a/fs/nfs/nfs.h
+++ b/fs/nfs/nfs.h
@@ -8,7 +8,6 @@
 #ifndef __LINUX_INTERNAL_NFS_H
 #define __LINUX_INTERNAL_NFS_H
 
-#include <linux/fs.h>
 #include <linux/sunrpc/sched.h>
 #include <linux/nfs_xdr.h>
 
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -33,6 +33,7 @@
  *  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
 #include <linux/fs_struct.h>
+#include <linux/fs_type.h>
 #include <linux/file.h>
 #include <linux/falloc.h>
 #include <linux/slab.h>
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -9,6 +9,7 @@
 #include <linux/namei.h>
 #include <linux/ctype.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 
 #include <linux/sunrpc/svcsock.h>
 #include <linux/lockd/lockd.h>
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/blkdev.h>
 #include <linux/parser.h>
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -3,6 +3,7 @@
 #include <linux/pseudo_fs.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/proc_fs.h>
 #include <linux/proc_ns.h>
 #include <linux/magic.h>
--- a/fs/ntfs/super.c
+++ b/fs/ntfs/super.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/stddef.h>
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/string.h>
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -53,6 +53,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/log2.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -20,6 +20,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/types.h>
 #include <linux/slab.h>
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/highmem.h>
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -7,6 +7,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/vfs.h>
 #include <linux/cred.h>
 #include <linux/parser.h>
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -10,6 +10,7 @@
 #include <linux/string.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/seq_file.h>
--- a/fs/orangefs/orangefs-kernel.h
+++ b/fs/orangefs/orangefs-kernel.h
@@ -32,6 +32,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/vmalloc.h>
 
 #include <linux/aio.h>
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -18,6 +18,7 @@
 #include <linux/file.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include "overlayfs.h"
 #include "params.h"
 
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/log2.h>
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -2,6 +2,7 @@
 /*
  * /proc/sys support
  */
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/sysctl.h>
 #include <linux/poll.h>
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -20,6 +20,7 @@
 #include <linux/mount.h>
 #include <linux/pid_namespace.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/cred.h>
 #include <linux/magic.h>
 #include <linux/slab.h>
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -11,6 +11,7 @@
 #include <linux/nsproxy.h>
 #include <linux/security.h>
 #include <linux/fs_struct.h>
+#include <linux/fs_type.h>
 #include <linux/sched/task.h>
 
 #include "proc/internal.h" /* only for get_proc_task() in ->open() */
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -7,6 +7,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/fsnotify.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -13,6 +13,7 @@
  * 30-06-1998 by Frank Denis : first step to write inodes.
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
--- a/fs/qnx6/inode.c
+++ b/fs/qnx6/inode.c
@@ -11,6 +11,7 @@
  *
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/pagemap.h>
 #include <linux/highmem.h>
 #include <linux/time.h>
--- a/fs/reiserfs/reiserfs.h
+++ b/fs/reiserfs/reiserfs.h
@@ -6,6 +6,7 @@
 
 #include <linux/reiserfs_fs.h>
 
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/interrupt.h>
 #include <linux/sched.h>
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -11,6 +11,7 @@
  * NO WARRANTY
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
--- a/fs/romfs/super.c
+++ b/fs/romfs/super.c
@@ -61,6 +61,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/time.h>
 #include <linux/slab.h>
 #include <linux/init.h>
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -12,6 +12,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/filelock.h>
 #include <linux/mount.h>
 #include <linux/slab.h>
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/ctype.h>
 #include <linux/mempool.h>
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -20,6 +20,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/vfs.h>
 #include <linux/slab.h>
 #include <linux/mutex.h>
--- a/fs/super.c
+++ b/fs/super.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/export.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/blkdev.h>
 #include <linux/mount.h>
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/init.h>
--- a/fs/sysv/super.c
+++ b/fs/sysv/super.c
@@ -21,6 +21,7 @@
  *  This file contains code for read/parsing the superblock.
  */
 
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/kobject.h>
 #include <linux/namei.h>
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -14,6 +14,7 @@
  * corresponding subsystems, but most of it is here.
  */
 
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -37,6 +37,7 @@
 #include "udfdecl.h"
 
 #include <linux/blkdev.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -76,6 +76,7 @@
 
 #include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/stat.h>
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -12,6 +12,7 @@
 
 #include <linux/idr.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/magic.h>
 #include <linux/module.h>
 #include <linux/nls.h>
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -48,6 +48,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 
 static const struct super_operations xfs_super_operations;
 
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2019 Western Digital Corporation or its affiliates.
  */
+#include <linux/fs_type.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/magic.h>
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -15,6 +15,7 @@
 #include <linux/rculist.h>
 #include <linux/cgroupstats.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/seq_file.h>
 #include <linux/kernfs.h>
 #include <linux/jump_label.h>
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -53,6 +53,7 @@ struct bio;
 struct io_comp_batch;
 struct export_operations;
 struct fiemap_extent_info;
+struct file_system_type;
 struct hd_geometry;
 struct iovec;
 struct kiocb;
@@ -1168,17 +1169,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 
-/* Possible states of 'frozen' field */
-enum {
-	SB_UNFROZEN = 0,		/* FS is unfrozen */
-	SB_FREEZE_WRITE	= 1,		/* Writes, dir ops, ioctls frozen */
-	SB_FREEZE_PAGEFAULT = 2,	/* Page faults stopped as well */
-	SB_FREEZE_FS = 3,		/* For internal FS use (e.g. to stop
-					 * internal threads if needed) */
-	SB_FREEZE_COMPLETE = 4,		/* ->freeze_fs finished successfully */
-};
-
-#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
+#include <linux/sb_freeze.h>
 
 struct sb_writers {
 	unsigned short			frozen;		/* Is sb frozen? */
@@ -2362,38 +2353,6 @@ int kiocb_modified(struct kiocb *iocb);
 
 int sync_inode_metadata(struct inode *inode, int wait);
 
-struct file_system_type {
-	const char *name;
-	int fs_flags;
-#define FS_REQUIRES_DEV		1 
-#define FS_BINARY_MOUNTDATA	2
-#define FS_HAS_SUBTYPE		4
-#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
-#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
-#define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
-#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
-	int (*init_fs_context)(struct fs_context *);
-	const struct fs_parameter_spec *parameters;
-	struct dentry *(*mount) (struct file_system_type *, int,
-		       const char *, void *);
-	void (*kill_sb) (struct super_block *);
-	struct module *owner;
-	struct file_system_type * next;
-	struct hlist_head fs_supers;
-
-	struct lock_class_key s_lock_key;
-	struct lock_class_key s_umount_key;
-	struct lock_class_key s_vfs_rename_key;
-	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
-
-	struct lock_class_key i_lock_key;
-	struct lock_class_key i_mutex_key;
-	struct lock_class_key invalidate_lock_key;
-	struct lock_class_key i_mutex_dir_key;
-};
-
-#define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
-
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data,
 	int (*fill_super)(struct super_block *, void *, int));
@@ -2441,8 +2400,6 @@ struct super_block *sget_dev(struct fs_context *fc, dev_t dev);
 		BUG_ON(!(__file->f_op = (fops))); \
 	} while(0)
 
-extern int register_filesystem(struct file_system_type *);
-extern int unregister_filesystem(struct file_system_type *);
 extern int vfs_statfs(const struct path *, struct kstatfs *);
 extern int user_statfs(const char __user *, struct kstatfs *);
 extern int fd_statfs(int, struct kstatfs *);
@@ -3115,9 +3072,6 @@ static inline int vfs_lstat(const char __user *name, struct kstat *stat)
 extern const char *vfs_get_link(struct dentry *, struct delayed_call *);
 extern int vfs_readlink(struct dentry *, char __user *, int);
 
-extern struct file_system_type *get_filesystem(struct file_system_type *fs);
-extern void put_filesystem(struct file_system_type *fs);
-extern struct file_system_type *get_fs_type(const char *name);
 extern struct super_block *get_active_super(struct block_device *bdev);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
new file mode 100644
--- /dev/null
+++ b/include/linux/fs_type.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_FS_TYPE_H
+#define _LINUX_FS_TYPE_H
+#include <linux/types.h>
+#include <linux/lockdep_types.h>
+#include <linux/sb_freeze.h>
+
+struct dentry;
+struct fs_context;
+struct fs_parameter_spec;
+struct module;
+struct super_block;
+
+struct file_system_type {
+	const char *name;
+	int fs_flags;
+#define FS_REQUIRES_DEV		1
+#define FS_BINARY_MOUNTDATA	2
+#define FS_HAS_SUBTYPE		4
+#define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
+#define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
+#define FS_ALLOW_IDMAP		32	/* FS has been updated to handle vfs idmappings. */
+#define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
+	int (*init_fs_context)(struct fs_context *);
+	const struct fs_parameter_spec *parameters;
+	struct dentry *(*mount) (struct file_system_type *, int, const char *, void *);
+	void (*kill_sb) (struct super_block *);
+	struct module *owner;
+	struct file_system_type *next;
+	struct hlist_head fs_supers;
+
+	struct lock_class_key s_lock_key;
+	struct lock_class_key s_umount_key;
+	struct lock_class_key s_vfs_rename_key;
+	struct lock_class_key s_writers_key[SB_FREEZE_LEVELS];
+
+	struct lock_class_key i_lock_key;
+	struct lock_class_key i_mutex_key;
+	struct lock_class_key invalidate_lock_key;
+	struct lock_class_key i_mutex_dir_key;
+};
+
+#define MODULE_ALIAS_FS(NAME) MODULE_ALIAS("fs-" NAME)
+
+int register_filesystem(struct file_system_type *);
+int unregister_filesystem(struct file_system_type *);
+struct file_system_type *get_filesystem(struct file_system_type *);
+void put_filesystem(struct file_system_type *);
+struct file_system_type *get_fs_type(const char *);
+#endif
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -136,8 +136,6 @@ extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
 /* Used for constructor calls. */
 typedef void (*ctor_fn_t)(void);
 
-struct file_system_type;
-
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
 extern char __initdata boot_command_line[];
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -27,7 +27,6 @@ struct seq_file;
 struct vm_area_struct;
 struct vm_operations_struct;
 struct super_block;
-struct file_system_type;
 struct poll_table_struct;
 struct fs_context;
 
new file mode 100644
--- /dev/null
+++ b/include/linux/sb_freeze.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SB_FREEZE_H
+#define _LINUX_SB_FREEZE_H
+
+/* Possible states of 'frozen' field */
+enum {
+	SB_UNFROZEN = 0,		/* FS is unfrozen */
+	SB_FREEZE_WRITE	= 1,		/* Writes, dir ops, ioctls frozen */
+	SB_FREEZE_PAGEFAULT = 2,	/* Page faults stopped as well */
+	SB_FREEZE_FS = 3,		/* For internal FS use (e.g. to stop
+					 * internal threads if needed) */
+	SB_FREEZE_COMPLETE = 4,		/* ->freeze_fs finished successfully */
+};
+
+#define SB_FREEZE_LEVELS (SB_FREEZE_COMPLETE - 1)
+
+#endif
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -15,6 +15,7 @@
 #include <linux/initrd.h>
 #include <linux/async.h>
 #include <linux/fs_struct.h>
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -19,6 +19,7 @@
 #include <linux/file.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/namei.h>
 #include <linux/sysctl.h>
 #include <linux/poll.h>
--- a/kernel/bpf/inode.c
+++ b/kernel/bpf/inode.c
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/kdev_t.h>
 #include <linux/filter.h>
 #include <linux/bpf.h>
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -56,6 +56,7 @@
 #include <linux/nsproxy.h>
 #include <linux/file.h>
 #include <linux/fs_parser.h>
+#include <linux/fs_type.h>
 #include <linux/sched/cputime.h>
 #include <linux/sched/deadline.h>
 #include <linux/psi.h>
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -17,6 +17,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/proc_fs.h>
 #include <linux/pseudo_fs.h>
 #include <linux/sched.h>
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -42,6 +42,7 @@
 #include <linux/poll.h>
 #include <linux/nmi.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/trace.h>
 #include <linux/sched/clock.h>
 #include <linux/sched/rt.h>
--- a/kernel/usermode_driver.c
+++ b/kernel/usermode_driver.c
@@ -6,6 +6,7 @@
 #include <linux/pipe_fs_i.h>
 #include <linux/mount.h>
 #include <linux/fs_struct.h>
+#include <linux/fs_type.h>
 #include <linux/task_work.h>
 #include <linux/usermode_driver.h>
 
--- a/lib/test_kmod.c
+++ b/lib/test_kmod.c
@@ -21,6 +21,7 @@
 #include <linux/kthread.h>
 #include <linux/sched.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/miscdevice.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -7,6 +7,7 @@
 
 #include <linux/mm.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/swap.h>
 #include <linux/mount.h>
 #include <linux/memfd.h>
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -22,6 +22,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/init.h>
 #include <linux/vfs.h>
 #include <linux/mount.h>
@@ -260,7 +261,6 @@ static const struct inode_operations shmem_dir_inode_operations;
 static const struct inode_operations shmem_special_inode_operations;
 static const struct vm_operations_struct shmem_vm_ops;
 static const struct vm_operations_struct shmem_anon_vm_ops;
-static struct file_system_type shmem_fs_type;
 
 bool vma_is_anon_shmem(struct vm_area_struct *vma)
 {
--- a/net/socket.c
+++ b/net/socket.c
@@ -57,6 +57,7 @@
 #include <linux/mm.h>
 #include <linux/socket.h>
 #include <linux/file.h>
+#include <linux/fs_type.h>
 #include <linux/splice.h>
 #include <linux/net.h>
 #include <linux/interrupt.h>
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -15,6 +15,7 @@
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/namei.h>
 #include <linux/fsnotify.h>
 #include <linux/kernel.h>
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -20,6 +20,7 @@
 #include <linux/rcupdate.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/poll.h>
 #include <linux/zstd.h>
 #include <uapi/linux/major.h>
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/namei.h>
 #include <uapi/linux/mount.h>
--- a/security/inode.c
+++ b/security/inode.c
@@ -14,6 +14,7 @@
 #include <linux/kobject.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/pagemap.h>
 #include <linux/init.h>
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/kernel_read_file.h>
 #include <linux/fs.h>
+#include <linux/fs_type.h>
 #include <linux/security.h>
 #include <linux/magic.h>
 #include <linux/parser.h>
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -18,6 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include <linux/mount.h>
 #include <linux/mutex.h>
 #include <linux/namei.h>
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -25,6 +25,7 @@
 #include <linux/magic.h>
 #include <linux/mount.h>
 #include <linux/fs_context.h>
+#include <linux/fs_type.h>
 #include "smack.h"
 
 #define BEBITS	(sizeof(__be32) * 8)
--- a/security/tomoyo/mount.c
+++ b/security/tomoyo/mount.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2005-2011  NTT DATA CORPORATION
  */
 
+#include <linux/fs_type.h>
 #include <linux/slab.h>
 #include <uapi/linux/mount.h>
 #include "common.h"

