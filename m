Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1924690F6B
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfHQIXg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 04:23:36 -0400
Received: from sonic315-8.consmr.mail.gq1.yahoo.com ([98.137.65.32]:38924 "EHLO
        sonic315-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726010AbfHQIXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566030210; bh=dcXWv/xr00uuu1Svcd98Upx96pdeSkAOr52nKZFZO1s=; h=From:To:Cc:Subject:Date:From:Subject; b=mZ1GYqA6WhwkyUox4cb+Xy54C+UV1qeJTvIPpz9d099q1taHPrdTNNkFR0KOCccV8wsvUM1QQkSl9ynClI/Ngy+KNFE1E2d5Mft0Zl9+mvBvfUq+F43NmGlXQGkWIJ8+pHvliIe1jyROZUZt76Zgh3dsV4oPk2VYikCvzfIGZu09JqjrxPvE8/s2O1sSSsCkcY/z90mOzwa4RVodxUU9NBBzDs6cDRqG6DhADcmDZHUzQzWfnyMKskLhbbplZy2TuJGyv5LYsXGsG6jFnQa2cqX6wlgH6GKHdYHkOuezffRo2AZqxBzuj+pw7lUB14iNLWEGbUGdxNmBj07gsHYRwQ==
X-YMail-OSG: lIZP6_wVM1k.nJ2giN.m2dzcEpDlr0KvzPytcOgmJa5HPuooKiQscPJDpSim6WL
 0kKbQzBwBIAACjqbj.WJoTFDrcYkWjbpBLodRkvxRz56gjcsc86Vt88igtbgezn4dflE.WJX8Q7n
 Spz3X9PJpANyTX_atIZ0XgJ1TslwbNv5fM_SZAuWkhpVmeOsVGvgXPJXMSJ9B4LtIcwuiGQTtFJ.
 TXgwerE7JPEMLIE7bX9rijQHfkw_.6VU_yURPPPHEvy38sK1JccnvEnYs4iZ4EGOEDv9G_.aH5is
 C3meGbty6aSZ_7XdhsMAgTVo6IPgO11qu.J19_kX9G3QJxJn_aL9WsmairQuiYbUUAp1_1w_513b
 nkaFD_k0roertizYaKwwHuv0Hj1tyn69SVhvcAUe4iGdX8Wj_kQqtaWCDXJ4s6M37sZUrAD6A2m3
 Yrp.a7XGwPWzFc5JcQ7X2DofwHHo4izLYgd0v.vFMCctPlr0PbnLK0yfIiOOuSDDw4IOxsEWA91G
 hrGtwOGvUNtOYyXbQjDiAviOATaadMsVJcM9x8IZn.uuZmegZcECBa913Y.chWVrau33p061u33V
 5pFqRMF5CPPCfm2H.K1Cxnv3FDzOYQkl4Gn.fy6BUqs1Uqy.EDN24xmyXoL.Nbs555LceLim.LAA
 2q331TRAZkYOdzdTE1Z0G8rSzczM2GEQ4JGPhxJG8LXFkWe0hdOaiXDLVRrtGz6LpGVc9EkpvZe0
 9T4H_WtHA4E_ToCg3nQa9aOeyTgJH9kIvADjVUosPTxYxFgPo.mTmVnh8UpPTpzjKoC6AtWrZlzD
 M4yAbNz0YnUUN_wymV5pqZtneBZXi88VmaNobJiqZfVNa9E6CqG.meOmqZhGE_J9mBVQUHqqXi4S
 M00JacIvlGlbnKQKVYXoqw3rgaF8y5LYXakflWw1UbXyFE8MBxn5d4fXu.NVJTaYt2wguMBS73BG
 FtX5zjY9z3VjH7TOHpSQK.BeNOqaBi_L22JlqAwxf15AUaFjc5KGukoDumF.cDa0HmPdxGS58QHY
 wsaG1PyD4NrZdUWf.6ozJGx2LysfZTZ2OSiuFLc.vrsZWMigD2ROoiCRVYfjtS.3u7TStaRgU0Ox
 Hs5hUHv.g0am8n5WnJzr1ExLJT.HQEJ1n4lb16byCmI6OvcBFaVYB7weDfX3Nak9_TJT.zom1_nt
 _WaCVlmP2r0l6a3MAgrtuBTpuy89GxE91Tw2zolNxeAxRTuJtk.4RDfbbewVYa6YhpQ_dYrWGJKk
 pTTu7zSeRPe2pvkElmHDB3ZAk_1jbFBDW0ABDUKo2_Y6o9_OFnaDjqg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Aug 2019 08:23:30 +0000
Received: by smtp414.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 8351dc6d646f886d8d571aa7fc628ee4;
          Sat, 17 Aug 2019 08:23:30 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Theodore Ts'o <tytso@mit.edu>, Pavel Machek <pavel@denx.de>,
        David Sterba <dsterba@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH] erofs: move erofs out of staging
Date:   Sat, 17 Aug 2019 16:23:13 +0800
Message-Id: <20190817082313.21040-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

EROFS filesystem has been merged into linux-staging for a year.

EROFS is designed to be a better solution of saving extra storage
space with guaranteed end-to-end performance for read-only files
with the help of reduced metadata, fixed-sized output compression
and decompression inplace technologies.

In the past year, EROFS was greatly improved by many people as
a staging driver, self-tested, betaed by a large number of our
internal users, successfully applied to almost all in-service
HUAWEI smartphones as the part of EMUI 9.1 and proven to be stable
enough to be moved out of staging.

EROFS is a self-contained filesystem driver. Although there are
still some TODOs to be more generic, we have a dedicated team
actively keeping on working on EROFS in order to make it better
with the evolution of Linux kernel as the other in-kernel filesystems.

As Pavel suggested, it's better to do as one commit since git
can do moves and all histories will be saved in this way.

Let's promote it from staging and enhance it more actively as
a "real" part of kernel for more wider scenarios!

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Pavel Machek <pavel@denx.de>
Cc: David Sterba <dsterba@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Darrick J . Wong <darrick.wong@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Richard Weinberger <richard@nod.at>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chao Yu <yuchao0@huawei.com>
Cc: Miao Xie <miaoxie@huawei.com>
Cc: Li Guifu <bluce.liguifu@huawei.com>
Cc: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

Hi,

 This is a formal moving patch based on a previous patch for staging tree
 https://lore.kernel.org/r/20190816071142.8633-1-gaoxiang25@huawei.com/

 The previous related topic is
 https://lore.kernel.org/r/20190815044155.88483-1-gaoxiang25@huawei.com/

changelog since RFC:
 - Update commit message for better conclusion;
 - Remove the file names from the comments at the top of the files suggested by Stephen;
 - Update MAINTAINERS reminded by a kind person.

Thank you very much,
Gao Xiang

 .../filesystems/erofs.txt                     |  4 --
 MAINTAINERS                                   | 14 +++---
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 drivers/staging/erofs/TODO                    | 46 -------------------
 fs/Kconfig                                    |  1 +
 fs/Makefile                                   |  1 +
 {drivers/staging => fs}/erofs/Kconfig         |  0
 {drivers/staging => fs}/erofs/Makefile        |  4 +-
 {drivers/staging => fs}/erofs/compress.h      |  2 -
 {drivers/staging => fs}/erofs/data.c          |  2 -
 {drivers/staging => fs}/erofs/decompressor.c  |  2 -
 {drivers/staging => fs}/erofs/dir.c           |  2 -
 {drivers/staging => fs}/erofs/erofs_fs.h      |  3 --
 {drivers/staging => fs}/erofs/inode.c         |  2 -
 {drivers/staging => fs}/erofs/internal.h      |  3 +-
 {drivers/staging => fs}/erofs/namei.c         |  2 -
 {drivers/staging => fs}/erofs/super.c         |  2 -
 {drivers/staging => fs}/erofs/tagptr.h        |  0
 {drivers/staging => fs}/erofs/utils.c         |  2 -
 {drivers/staging => fs}/erofs/xattr.c         |  2 -
 {drivers/staging => fs}/erofs/xattr.h         |  2 -
 {drivers/staging => fs}/erofs/zdata.c         |  2 -
 {drivers/staging => fs}/erofs/zdata.h         |  2 -
 {drivers/staging => fs}/erofs/zmap.c          |  2 -
 {drivers/staging => fs}/erofs/zpvec.h         |  2 -
 .../include => include}/trace/events/erofs.h  |  0
 include/uapi/linux/magic.h                    |  1 +
 28 files changed, 12 insertions(+), 96 deletions(-)
 rename {drivers/staging/erofs/Documentation => Documentation}/filesystems/erofs.txt (98%)
 delete mode 100644 drivers/staging/erofs/TODO
 rename {drivers/staging => fs}/erofs/Kconfig (100%)
 rename {drivers/staging => fs}/erofs/Makefile (68%)
 rename {drivers/staging => fs}/erofs/compress.h (96%)
 rename {drivers/staging => fs}/erofs/data.c (99%)
 rename {drivers/staging => fs}/erofs/decompressor.c (99%)
 rename {drivers/staging => fs}/erofs/dir.c (98%)
 rename {drivers/staging => fs}/erofs/erofs_fs.h (99%)
 rename {drivers/staging => fs}/erofs/inode.c (99%)
 rename {drivers/staging => fs}/erofs/internal.h (99%)
 rename {drivers/staging => fs}/erofs/namei.c (99%)
 rename {drivers/staging => fs}/erofs/super.c (99%)
 rename {drivers/staging => fs}/erofs/tagptr.h (100%)
 rename {drivers/staging => fs}/erofs/utils.c (99%)
 rename {drivers/staging => fs}/erofs/xattr.c (99%)
 rename {drivers/staging => fs}/erofs/xattr.h (98%)
 rename {drivers/staging => fs}/erofs/zdata.c (99%)
 rename {drivers/staging => fs}/erofs/zdata.h (99%)
 rename {drivers/staging => fs}/erofs/zmap.c (99%)
 rename {drivers/staging => fs}/erofs/zpvec.h (98%)
 rename {drivers/staging/erofs/include => include}/trace/events/erofs.h (100%)

diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
similarity index 98%
rename from drivers/staging/erofs/Documentation/filesystems/erofs.txt
rename to Documentation/filesystems/erofs.txt
index 0eab600ca7ca..38aa9126ec98 100644
--- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -49,10 +49,6 @@ Bugs and patches are welcome, please kindly help us and send to the following
 linux-erofs mailing list:
 >> linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
 
-Note that EROFS is still working in progress as a Linux staging driver,
-Cc the staging mailing list as well is highly recommended:
->> Linux Driver Project Developer List <devel@driverdev.osuosl.org>
-
 Mount options
 =============
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 429d61119980..5a8dbcafed00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6046,6 +6046,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kristoffer/linux-hpc.git
 F:	drivers/video/fbdev/s1d13xxxfb.c
 F:	include/video/s1d13xxxfb.h
 
+EROFS FILE SYSTEM
+M:	Gao Xiang <gaoxiang25@huawei.com>
+M:	Chao Yu <yuchao0@huawei.com>
+L:	linux-erofs@lists.ozlabs.org
+S:	Maintained
+F:	fs/erofs/
+
 ERRSEQ ERROR TRACKING INFRASTRUCTURE
 M:	Jeff Layton <jlayton@kernel.org>
 S:	Maintained
@@ -15215,13 +15222,6 @@ M:	H Hartley Sweeten <hsweeten@visionengravers.com>
 S:	Odd Fixes
 F:	drivers/staging/comedi/
 
-STAGING - EROFS FILE SYSTEM
-M:	Gao Xiang <gaoxiang25@huawei.com>
-M:	Chao Yu <yuchao0@huawei.com>
-L:	linux-erofs@lists.ozlabs.org
-S:	Maintained
-F:	drivers/staging/erofs/
-
 STAGING - FIELDBUS SUBSYSTEM
 M:	Sven Van Asbroeck <TheSven73@gmail.com>
 S:	Maintained
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7c96a01eef6c..d972ec8e71fb 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -112,8 +112,6 @@ source "drivers/staging/gasket/Kconfig"
 
 source "drivers/staging/axis-fifo/Kconfig"
 
-source "drivers/staging/erofs/Kconfig"
-
 source "drivers/staging/fieldbus/Kconfig"
 
 source "drivers/staging/kpc2000/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fcaac9693b83..6018b9a4a077 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -46,7 +46,6 @@ obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_EROFS_FS)		+= erofs/
 obj-$(CONFIG_FIELDBUS_DEV)     += fieldbus/
 obj-$(CONFIG_KPC2000)		+= kpc2000/
 obj-$(CONFIG_ISDN_CAPI)		+= isdn/
diff --git a/drivers/staging/erofs/TODO b/drivers/staging/erofs/TODO
deleted file mode 100644
index a8608b2f72bd..000000000000
--- a/drivers/staging/erofs/TODO
+++ /dev/null
@@ -1,46 +0,0 @@
-
-EROFS is still working in progress, thus it is not suitable
-for all productive uses. play at your own risk :)
-
-TODO List:
- - add the missing error handling code
-   (mainly existed in xattr and decompression submodules);
-
- - finalize erofs ondisk format design  (which means that
-   minor on-disk revisions could happen later);
-
- - documentation and detailed technical analysis;
-
- - general code review and clean up
-   (including confusing variable names and code snippets);
-
- - support larger compressed clustersizes for selection
-   (currently erofs only works as expected with the page-sized
-    compressed cluster configuration, usually 4KB);
-
- - support more lossless data compression algorithms
-   in addition to LZ4 algorithms in VLE approach;
-
- - data deduplication and other useful features.
-
-The following git tree provides the file system user-space
-tools under development (ex, formatting tool mkfs.erofs):
->> git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git
-
-The open-source development of erofs-utils is at the early stage.
-Contact the original author Li Guifu <bluce.liguifu@huawei.com> and
-the co-maintainer Fang Wei <fangwei1@huawei.com> for the latest news
-and more details.
-
-Code, suggestions, etc, are welcome. Please feel free to
-ask and send patches,
-
-To:
-  linux-erofs mailing list   <linux-erofs@lists.ozlabs.org>
-  Gao Xiang                  <gaoxiang25@huawei.com>
-  Chao Yu                    <yuchao0@huawei.com>
-
-Cc: (for linux-kernel upstream patches)
-  Greg Kroah-Hartman         <gregkh@linuxfoundation.org>
-  linux-staging mailing list <devel@driverdev.osuosl.org>
-
diff --git a/fs/Kconfig b/fs/Kconfig
index bfb1c6095c7a..669d46550e6d 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -261,6 +261,7 @@ source "fs/romfs/Kconfig"
 source "fs/pstore/Kconfig"
 source "fs/sysv/Kconfig"
 source "fs/ufs/Kconfig"
+source "fs/erofs/Kconfig"
 
 endif # MISC_FILESYSTEMS
 
diff --git a/fs/Makefile b/fs/Makefile
index d60089fd689b..b2e4973a0bea 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -130,3 +130,4 @@ obj-$(CONFIG_F2FS_FS)		+= f2fs/
 obj-$(CONFIG_CEPH_FS)		+= ceph/
 obj-$(CONFIG_PSTORE)		+= pstore/
 obj-$(CONFIG_EFIVAR_FS)		+= efivarfs/
+obj-$(CONFIG_EROFS_FS)		+= erofs/
diff --git a/drivers/staging/erofs/Kconfig b/fs/erofs/Kconfig
similarity index 100%
rename from drivers/staging/erofs/Kconfig
rename to fs/erofs/Kconfig
diff --git a/drivers/staging/erofs/Makefile b/fs/erofs/Makefile
similarity index 68%
rename from drivers/staging/erofs/Makefile
rename to fs/erofs/Makefile
index 5cdae21cb5af..46f2aa4ba46c 100644
--- a/drivers/staging/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,12 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-EROFS_VERSION = "1.0pre1"
+EROFS_VERSION = "1.0"
 
 ccflags-y += -DEROFS_VERSION=\"$(EROFS_VERSION)\"
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-# staging requirement: to be self-contained in its own directory
-ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
diff --git a/drivers/staging/erofs/compress.h b/fs/erofs/compress.h
similarity index 96%
rename from drivers/staging/erofs/compress.h
rename to fs/erofs/compress.h
index 043013f9ef1b..07d279fd5d67 100644
--- a/drivers/staging/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/compress.h
- *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/data.c b/fs/erofs/data.c
similarity index 99%
rename from drivers/staging/erofs/data.c
rename to fs/erofs/data.c
index 72c4b4c5296b..fda16ec8863e 100644
--- a/drivers/staging/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/data.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/decompressor.c b/fs/erofs/decompressor.c
similarity index 99%
rename from drivers/staging/erofs/decompressor.c
rename to fs/erofs/decompressor.c
index 32a811ac704a..5f4b7f302863 100644
--- a/drivers/staging/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/decompressor.c
- *
  * Copyright (C) 2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/dir.c b/fs/erofs/dir.c
similarity index 98%
rename from drivers/staging/erofs/dir.c
rename to fs/erofs/dir.c
index 5f38382637e6..637d70108d59 100644
--- a/drivers/staging/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/dir.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
similarity index 99%
rename from drivers/staging/erofs/erofs_fs.h
rename to fs/erofs/erofs_fs.h
index 6db70f395937..afa7d45ca958 100644
--- a/drivers/staging/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
 /*
- * linux/drivers/staging/erofs/erofs_fs.h
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -10,7 +8,6 @@
 #define __EROFS_FS_H
 
 /* Enhanced(Extended) ROM File System */
-#define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
 #define EROFS_SUPER_OFFSET      1024
 
 /*
diff --git a/drivers/staging/erofs/inode.c b/fs/erofs/inode.c
similarity index 99%
rename from drivers/staging/erofs/inode.c
rename to fs/erofs/inode.c
index cbc2c342a37f..80f4fe919ee7 100644
--- a/drivers/staging/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/inode.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/internal.h b/fs/erofs/internal.h
similarity index 99%
rename from drivers/staging/erofs/internal.h
rename to fs/erofs/internal.h
index 0e8d58546c52..620b73fcc416 100644
--- a/drivers/staging/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/internal.h
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
@@ -15,6 +13,7 @@
 #include <linux/pagemap.h>
 #include <linux/bio.h>
 #include <linux/buffer_head.h>
+#include <linux/magic.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include "erofs_fs.h"
diff --git a/drivers/staging/erofs/namei.c b/fs/erofs/namei.c
similarity index 99%
rename from drivers/staging/erofs/namei.c
rename to fs/erofs/namei.c
index 8334a910acef..8832b5d95d91 100644
--- a/drivers/staging/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/namei.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/super.c b/fs/erofs/super.c
similarity index 99%
rename from drivers/staging/erofs/super.c
rename to fs/erofs/super.c
index f65a1ff9f42f..bd3b1ae05b21 100644
--- a/drivers/staging/erofs/super.c
+++ b/fs/erofs/super.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/super.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/tagptr.h b/fs/erofs/tagptr.h
similarity index 100%
rename from drivers/staging/erofs/tagptr.h
rename to fs/erofs/tagptr.h
diff --git a/drivers/staging/erofs/utils.c b/fs/erofs/utils.c
similarity index 99%
rename from drivers/staging/erofs/utils.c
rename to fs/erofs/utils.c
index 814c2ee037ae..1dd041aa0f5a 100644
--- a/drivers/staging/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/utils.c
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/xattr.c b/fs/erofs/xattr.c
similarity index 99%
rename from drivers/staging/erofs/xattr.c
rename to fs/erofs/xattr.c
index e7e5840e3f9d..a8286998a079 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/xattr.c
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/xattr.h b/fs/erofs/xattr.h
similarity index 98%
rename from drivers/staging/erofs/xattr.h
rename to fs/erofs/xattr.h
index e20249647541..c5ca47d814dd 100644
--- a/drivers/staging/erofs/xattr.h
+++ b/fs/erofs/xattr.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/xattr.h
- *
  * Copyright (C) 2017-2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/zdata.c b/fs/erofs/zdata.c
similarity index 99%
rename from drivers/staging/erofs/zdata.c
rename to fs/erofs/zdata.c
index 2d7aaf98f7de..48251cb2aa39 100644
--- a/drivers/staging/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/zdata.c
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/zdata.h b/fs/erofs/zdata.h
similarity index 99%
rename from drivers/staging/erofs/zdata.h
rename to fs/erofs/zdata.h
index e11fe1959ca2..4fc547bc01f9 100644
--- a/drivers/staging/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/zdata.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/zmap.c b/fs/erofs/zmap.c
similarity index 99%
rename from drivers/staging/erofs/zmap.c
rename to fs/erofs/zmap.c
index b61b9b5950ac..764656151662 100644
--- a/drivers/staging/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * linux/drivers/staging/erofs/zmap.c
- *
  * Copyright (C) 2018-2019 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/zpvec.h b/fs/erofs/zpvec.h
similarity index 98%
rename from drivers/staging/erofs/zpvec.h
rename to fs/erofs/zpvec.h
index 9798f5627786..bd3cee16491c 100644
--- a/drivers/staging/erofs/zpvec.h
+++ b/fs/erofs/zpvec.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * linux/drivers/staging/erofs/zpvec.h
- *
  * Copyright (C) 2018 HUAWEI, Inc.
  *             http://www.huawei.com/
  * Created by Gao Xiang <gaoxiang25@huawei.com>
diff --git a/drivers/staging/erofs/include/trace/events/erofs.h b/include/trace/events/erofs.h
similarity index 100%
rename from drivers/staging/erofs/include/trace/events/erofs.h
rename to include/trace/events/erofs.h
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 1274c692e59c..903cc2d2750b 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -19,6 +19,7 @@
 #define SQUASHFS_MAGIC		0x73717368
 #define ECRYPTFS_SUPER_MAGIC	0xf15f
 #define EFS_SUPER_MAGIC		0x414A53
+#define EROFS_SUPER_MAGIC_V1	0xE0F5E1E2
 #define EXT2_SUPER_MAGIC	0xEF53
 #define EXT3_SUPER_MAGIC	0xEF53
 #define XENFS_SUPER_MAGIC	0xabba1974
-- 
2.17.1

