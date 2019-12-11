Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E49711BE83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 21:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbfLKUtg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 15:49:36 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34925 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbfLKUtf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:49:35 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MKsf5-1iQVNa1LfJ-00LCmO; Wed, 11 Dec 2019 21:49:19 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 16/24] compat_ioctl: move sys_compat_ioctl() to ioctl.c
Date:   Wed, 11 Dec 2019 21:42:50 +0100
Message-Id: <20191211204306.1207817-17-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Ttcjs3bklKjAtbzKwLkyQ9fvJEHsZYNVFkShl5ifO6FRmOUyrr3
 gCYrhvrhvqv4mlaj0onteSi+IqOGUBJj7QPfX9GV6O2n7cY9/EVp2PBaa5JCidBiWsxbn88
 yX1p0Ty1MFO6aynL+E5lj9evWqN8jg8+fhaPvrm3GsDqNSuJYp5HZjfFfNSiNm2ZQ2aroBQ
 3rxR/jmm8sw1GfQrxnjlg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0aiEZj2EOyc=:okEOF1/ZeXe1YiM/rGRtfI
 jhoeyCCtZd3trf1XPcPkRuNDo7eeM3PeLkllWdgHsvUfJMd8vvEVsOPTf3nyZkR3ZvGX6tD2J
 mdcNR8atHeSFnmim8ubtInawJon4PetrUjL+swA3ZensR0loFfBgLrn63fPhMfLk47zjVf9Nw
 9L8l7Ahv8HfJzmz6fyyOc1tULJfMG7kD19sFU+4WR/j3TwehoOsfy+sUejChDPqgexdzCPqbx
 uNTl1eYPyRxM5Vq5M+EuH0C+h21KkEL8N4St/0+ktE1pVd20JhD9L3TXgUSgKRXsvPm4IKtpY
 qdlAwsyErH5snTICdMShdJlrrocYTjTGC1JjREr89NNhq1oT5TfP1Jyw3DlUMMJ6CZfBpqCKb
 qPYp9NglInkmcX6Wg1avMpztbJsyKoWL5R83llQh1WkT/BmByLjp8+Avz+RkatfysBAkcSqTR
 jG21BNiRHvexLdaKQGAkeooHbk6LJA8gqEFUUO3wxckiinNqdpwZynH0HkKmS67I4HicGErR3
 RK7zudBSQYVb4N+8f4J2WEtXCxQohIzwM94q9EMVdDKM2OBv4WywAyvO0ugnHgV07Ljse0uqI
 AtLym8e7cr7nhkbZC6ZKwoXiuaqcR+TtQ9VUyCaGzkXmnt64xwRtstuU8a9O7F4g+LTLwoAxW
 TbWeEMUk0mlkuxkRfA1GXTxpOGNLlWwU+u+haFsc3vEFY/+F7ol2EcKS9/eYUAuUIJ/wFyzIi
 CSdG6K5jtS9nqBFuF+nt+DhE87QbZcshJXoy3THeNt5+eHP/XPVOkfgp9eyJFkrPdrdMJrZNV
 tpDrahct0QSssjIAlRem5kQsQ5mEyG3itpbsp/8rDyFK1lLto3jgGhCVWr0KOcK1DyjVsYyWx
 dgNY6VU1Y/oW2m+2CVpw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The rest of the fs/compat_ioctl.c file is no longer useful now,
so move the actual syscall as planned.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/Makefile       |   2 +-
 fs/compat_ioctl.c | 133 ----------------------------------------------
 fs/ioctl.c        |  90 +++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 134 deletions(-)
 delete mode 100644 fs/compat_ioctl.c

diff --git a/fs/Makefile b/fs/Makefile
index 1148c555c4d3..98be354fdb61 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -37,7 +37,7 @@ obj-$(CONFIG_FS_DAX)		+= dax.o
 obj-$(CONFIG_FS_ENCRYPTION)	+= crypto/
 obj-$(CONFIG_FS_VERITY)		+= verity/
 obj-$(CONFIG_FILE_LOCKING)      += locks.o
-obj-$(CONFIG_COMPAT)		+= compat.o compat_ioctl.o
+obj-$(CONFIG_COMPAT)		+= compat.o
 obj-$(CONFIG_BINFMT_AOUT)	+= binfmt_aout.o
 obj-$(CONFIG_BINFMT_EM86)	+= binfmt_em86.o
 obj-$(CONFIG_BINFMT_MISC)	+= binfmt_misc.o
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
deleted file mode 100644
index ab4471f469e6..000000000000
--- a/fs/compat_ioctl.c
+++ /dev/null
@@ -1,133 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * ioctl32.c: Conversion between 32bit and 64bit native ioctls.
- *
- * Copyright (C) 1997-2000  Jakub Jelinek  (jakub@redhat.com)
- * Copyright (C) 1998  Eddie C. Dost  (ecd@skynet.be)
- * Copyright (C) 2001,2002  Andi Kleen, SuSE Labs 
- * Copyright (C) 2003       Pavel Machek (pavel@ucw.cz)
- *
- * These routines maintain argument size conversion between 32bit and 64bit
- * ioctls.
- */
-
-#include <linux/types.h>
-#include <linux/compat.h>
-#include <linux/kernel.h>
-#include <linux/capability.h>
-#include <linux/compiler.h>
-#include <linux/sched.h>
-#include <linux/smp.h>
-#include <linux/ioctl.h>
-#include <linux/if.h>
-#include <linux/raid/md_u.h>
-#include <linux/falloc.h>
-#include <linux/file.h>
-#include <linux/ppp-ioctl.h>
-#include <linux/if_pppox.h>
-#include <linux/tty.h>
-#include <linux/vt_kern.h>
-#include <linux/blkdev.h>
-#include <linux/serial.h>
-#include <linux/ctype.h>
-#include <linux/syscalls.h>
-#include <linux/gfp.h>
-#include <linux/cec.h>
-
-#include "internal.h"
-
-#include <linux/uaccess.h>
-#include <linux/watchdog.h>
-
-#include <linux/hiddev.h>
-
-COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
-		       compat_ulong_t, arg32)
-{
-	unsigned long arg = arg32;
-	struct fd f = fdget(fd);
-	int error = -EBADF;
-	if (!f.file)
-		goto out;
-
-	/* RED-PEN how should LSM module know it's handling 32bit? */
-	error = security_file_ioctl(f.file, cmd, arg);
-	if (error)
-		goto out_fput;
-
-	switch (cmd) {
-	/* these are never seen by ->ioctl(), no argument or int argument */
-	case FIOCLEX:
-	case FIONCLEX:
-	case FIFREEZE:
-	case FITHAW:
-	case FICLONE:
-		goto do_ioctl;
-	/* these are never seen by ->ioctl(), pointer argument */
-	case FIONBIO:
-	case FIOASYNC:
-	case FIOQSIZE:
-	case FS_IOC_FIEMAP:
-	case FIGETBSZ:
-	case FICLONERANGE:
-	case FIDEDUPERANGE:
-		goto found_handler;
-	/*
-	 * The next group is the stuff handled inside file_ioctl().
-	 * For regular files these never reach ->ioctl(); for
-	 * devices, sockets, etc. they do and one (FIONREAD) is
-	 * even accepted in some cases.  In all those cases
-	 * argument has the same type, so we can handle these
-	 * here, shunting them towards do_vfs_ioctl().
-	 * ->compat_ioctl() will never see any of those.
-	 */
-	/* pointer argument, never actually handled by ->ioctl() */
-	case FIBMAP:
-		goto found_handler;
-	/* handled by some ->ioctl(); always a pointer to int */
-	case FIONREAD:
-		goto found_handler;
-	/* these get messy on amd64 due to alignment differences */
-#if defined(CONFIG_X86_64)
-	case FS_IOC_RESVSP_32:
-	case FS_IOC_RESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
-		goto out_fput;
-	case FS_IOC_UNRESVSP_32:
-	case FS_IOC_UNRESVSP64_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
-				compat_ptr(arg));
-		goto out_fput;
-	case FS_IOC_ZERO_RANGE_32:
-		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
-				compat_ptr(arg));
-		goto out_fput;
-#else
-	case FS_IOC_RESVSP:
-	case FS_IOC_RESVSP64:
-	case FS_IOC_UNRESVSP:
-	case FS_IOC_UNRESVSP64:
-	case FS_IOC_ZERO_RANGE:
-		goto found_handler;
-#endif
-
-	default:
-		if (f.file->f_op->compat_ioctl) {
-			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
-			if (error != -ENOIOCTLCMD)
-				goto out_fput;
-		}
-
-		error = -ENOTTY;
-		goto out_fput;
-	}
-
- found_handler:
-	arg = (unsigned long)compat_ptr(arg);
- do_ioctl:
-	error = do_vfs_ioctl(f.file, fd, cmd, arg);
- out_fput:
-	fdput(f);
- out:
-	return error;
-}
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 2f5e4e5b97e1..8f22f7817edb 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -788,4 +788,94 @@ long compat_ptr_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return file->f_op->unlocked_ioctl(file, cmd, (unsigned long)compat_ptr(arg));
 }
 EXPORT_SYMBOL(compat_ptr_ioctl);
+
+COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
+		       compat_ulong_t, arg32)
+{
+	unsigned long arg = arg32;
+	struct fd f = fdget(fd);
+	int error = -EBADF;
+	if (!f.file)
+		goto out;
+
+	/* RED-PEN how should LSM module know it's handling 32bit? */
+	error = security_file_ioctl(f.file, cmd, arg);
+	if (error)
+		goto out_fput;
+
+	switch (cmd) {
+	/* these are never seen by ->ioctl(), no argument or int argument */
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIFREEZE:
+	case FITHAW:
+	case FICLONE:
+		goto do_ioctl;
+	/* these are never seen by ->ioctl(), pointer argument */
+	case FIONBIO:
+	case FIOASYNC:
+	case FIOQSIZE:
+	case FS_IOC_FIEMAP:
+	case FIGETBSZ:
+	case FICLONERANGE:
+	case FIDEDUPERANGE:
+		goto found_handler;
+	/*
+	 * The next group is the stuff handled inside file_ioctl().
+	 * For regular files these never reach ->ioctl(); for
+	 * devices, sockets, etc. they do and one (FIONREAD) is
+	 * even accepted in some cases.  In all those cases
+	 * argument has the same type, so we can handle these
+	 * here, shunting them towards do_vfs_ioctl().
+	 * ->compat_ioctl() will never see any of those.
+	 */
+	/* pointer argument, never actually handled by ->ioctl() */
+	case FIBMAP:
+		goto found_handler;
+	/* handled by some ->ioctl(); always a pointer to int */
+	case FIONREAD:
+		goto found_handler;
+	/* these get messy on amd64 due to alignment differences */
+#if defined(CONFIG_X86_64)
+	case FS_IOC_RESVSP_32:
+	case FS_IOC_RESVSP64_32:
+		error = compat_ioctl_preallocate(f.file, 0, compat_ptr(arg));
+		goto out_fput;
+	case FS_IOC_UNRESVSP_32:
+	case FS_IOC_UNRESVSP64_32:
+		error = compat_ioctl_preallocate(f.file, FALLOC_FL_PUNCH_HOLE,
+				compat_ptr(arg));
+		goto out_fput;
+	case FS_IOC_ZERO_RANGE_32:
+		error = compat_ioctl_preallocate(f.file, FALLOC_FL_ZERO_RANGE,
+				compat_ptr(arg));
+		goto out_fput;
+#else
+	case FS_IOC_RESVSP:
+	case FS_IOC_RESVSP64:
+	case FS_IOC_UNRESVSP:
+	case FS_IOC_UNRESVSP64:
+	case FS_IOC_ZERO_RANGE:
+		goto found_handler;
+#endif
+
+	default:
+		if (f.file->f_op->compat_ioctl) {
+			error = f.file->f_op->compat_ioctl(f.file, cmd, arg);
+			if (error != -ENOIOCTLCMD)
+				goto out_fput;
+		}
+		error = -ENOTTY;
+		goto out_fput;
+	}
+
+ found_handler:
+	arg = (unsigned long)compat_ptr(arg);
+ do_ioctl:
+	error = do_vfs_ioctl(f.file, fd, cmd, arg);
+ out_fput:
+	fdput(f);
+ out:
+	return error;
+}
 #endif
-- 
2.20.0

