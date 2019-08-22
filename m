Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9692E9A245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2019 23:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390836AbfHVVhX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Aug 2019 17:37:23 -0400
Received: from sonic304-23.consmr.mail.ir2.yahoo.com ([77.238.179.148]:37072
        "EHLO sonic304-23.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730759AbfHVVhX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1566509839; bh=AMzztvm17nZtdHndpsmaBlDG/86Ut6Cq7R/Tswit+D4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=iAI1BQ1eJCH26DFTUiR5Lrf2E0e91Ukux/BU4jnlDPVMGYxV1kS1055cWaPh1gfAF9UuESRqLUIZ+t4IYqPLOzPZO+hQYmUMj8bDn3ajUuiZOclhg+4dd0HqBDXN/MSaEdLK00azCPCB9UjGs1wDlfxDvgjGS1YMEjZ1aiYVh3VyFP/sErtqKZSH765cSU4aUyurmVYfU7dABq/QWR3Up7xRol5SOw7TLQrXYqfYOU6Fufm73G5BbptmN6ZWeeqvRQi8IZMYTl0GWslOPXFWVnZylT91qXZDoyDIa9Db5hyG6M9P9/JIAkVPPWRbO5M9eScTMnxjBFDu22dkrkAwkg==
X-YMail-OSG: up98J1EVM1lC_wx6Z47N2ee5GT7Lo91LPBZvLjwXz.Fxlie9zJ2QYduYfaTVhzI
 0cAbyFOhR.7kDL3fsF_BWvCoKs_8LmApLXXiC..hsFKOFEER9592VjHaeIuBGlkxMe2Y8dtwt9pK
 QlUeJjsOKObqDdaIw9Aehf.empS5cSiz9dByNoUhIZNuALFJsypisWMCzq3pVIF91nYOAeddwWzz
 IM92jUq7dDvUEns7xZScaAn2hX.jY2SRynMePO.AT2vDTX0DLCXYC8krft6gXZ3y6u2BPHnONO4O
 ay.VemEGwgC4BuyfV8Sb2BXzwpjcb9s9ILEcN.TxXFkdQrBxoGN22eLq1foNr_o5Ex58YlTVy20L
 cZhiL2gQIf2t.BOFusDvfJ4jvn0BZl5XvDQipa4xb0pRdSGS1_IY2GurD0UAY5jzfSBcfFqnI5JH
 Hvshi_cOWBGMXCreaa8Wc0uWEvqtVawDBP6gJByhO4vWaqyVtiZvBaxaL7HWxml56XxCFW0DWnOV
 us1bDVeCwcwxq0fVWSeefVCDfPR1GTbApwbO79N8rR9XaPVBAeSni2wtSTYwj_DLj7sItKy2o9YM
 O9zjUz6z4VWD_Oq54T_WnbI56HTS8XFmzKng4KfdD1KaW8XmBYzNWDSddU1JzGL3.MBEvc29bmSG
 PxjFWc7Rz7yFJkwA3.Y..ShlYC.RQ8t9J9Kf0sZ04tVtoRlBMHOcnqIptSIHOFmzaWQ3c0DjM717
 he.SFJobKrbPts3Vf7VgxnzB9FHn4m3lVw5S1fqpizMZkVafWj9k51babzxRNlY.EeZxtHablcge
 MmgWTTWdmGc1TzwGsclWJ7RfABcI4FywWmVAT6XRpWRNJGD_SLfZ1aQzmneHoOa1p3DgF60vuDHZ
 Z4SOlWU.GfarUEudHwvqgydRGkWwH7YyCUKuA_LWT4qK_TWN9a.AuLPPARVApULVZX.fH2SUhosb
 J99GivbNwt83M3dzwIaHj7G90dX2BQgf3tWY8FSQdJCko0YnVYzpf9fQTxfnOUuCn8twdJtTb4aM
 FYfJ.Ckoa1LaOIFR9Qi6ykJUrv0gdAyM9sT1B5VHV3sHt.Ii4mSb6oTY7BT.3gISmhkWIerz2i1y
 gMrScTszq8ws2MXIZdVtwaLuqIoqzIoVmnHfz71eJyXTSgFIou7.1yP4wj.pXqUtOA5piABMov.u
 E_X2Gf.W59sQ0gnHFD2fkQiTIo37STSnepPI6MCX1p3nA.R5t_VsvemUSt.8g2Le3z2s1nNB6itp
 YAQ9Cn3NPBrP4.YzDyGwSB3IJJihFbUA9G80b2CbBFmMN56Y4
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ir2.yahoo.com with HTTP; Thu, 22 Aug 2019 21:37:19 +0000
Received: by smtp430.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 4ca1c1f46c4507a8df5ebe7f56c1c968;
          Thu, 22 Aug 2019 21:37:15 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@aol.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [PATCH v2] erofs: move erofs out of staging
Date:   Fri, 23 Aug 2019 05:36:59 +0800
Message-Id: <20190822213659.5501-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190822141641.GA195034@architecture4>
References: <20190822141641.GA195034@architecture4>
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
change log from v1:
 - rebase on the latest staging-next

Hi Greg,
 if something wrong of that patch v1, please apply this one
 based on the latest staging-next.

Thanks,
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
index 6847372cfab8..0f38cba2c581 100644
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
@@ -15229,13 +15236,6 @@ M:	H Hartley Sweeten <hsweeten@visionengravers.com>
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
index 77ef856df9f3..1976e60e5174 100644
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
index 2da471010a86..6d3a9bcb8daa 100644
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
index 60d7c20db87d..b32ad585237c 100644
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
index 774dacbc5b32..4dc9cec01297 100644
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

