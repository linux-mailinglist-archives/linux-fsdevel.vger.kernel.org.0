Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 925D4185948
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Mar 2020 03:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCOCoA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 Mar 2020 22:44:00 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46810 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgCOCoA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:44:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id w16so518144wrv.13;
        Sat, 14 Mar 2020 19:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Jf+RrC6mz5nv84gZ0MzKVxOOXoDeU+y88CTt66LoldU=;
        b=U0yygjl5lv+zcKei2t1sWcD+BUWDAMmKr9iCEAnQVE0fk7Wtgu4P5m6etE17I6XZjI
         xtXo7DbXs3NsHWTZUy/uRdJr/MlZgBS+UbEV6sKqoZYY9iXpfKi/rQCQYqsESVbwU0Ml
         ns61vfMXkveiwOHsDDeQFJEi+zgsZciREasdPaKYfxaYQmzKivCJ8A1H2vryAMVes2Xi
         2RVJ5gfsSv5dg3V5FWauG+MgyCmbztrmI7eun7BHAvGYIIjcQzTwz1QSGSLeBOGfUjVY
         17DxeajvcCm8jA6KuUFhCm1Tq7YQ9YwKfGtU9p2IkUSMitj5mxbkbpmD5WPnshMAi8Te
         +jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jf+RrC6mz5nv84gZ0MzKVxOOXoDeU+y88CTt66LoldU=;
        b=O4EhgIk3DGffey/kWEqZBvMwREY/1ilWaPWKfyoQCH8s5vEpcdO0ZXQlVCoBswwFWy
         UWZQ70YGi8MsxiPF8mQFnmcvEoBdWsr2O21rGDjcCKrSZy2iZ8FJK2nmMrgjTLhm8s0u
         9ufzFUN7dgB8g2iv6e/Iaakca34wtxPEDQNlyrfsJgsBFdGgjOhCIbT27rFOK7kCaLOe
         KglWMdeuTAD8zGOYPo/LPzvlduXx5hZjptMSFJPwHVL0zmdSg0eM5YumHZ9pX/NKtu4c
         q4o9NCOXLRFsL25qNX+WN8NvUbX3gj7Z1aWy5ZIk3uAyX1jYuDdcrGnPcpxrOYw4R8jT
         ugUA==
X-Gm-Message-State: ANhLgQ0SzjBj9PXAzYiexbjvtg5fsrLOhYf8syoSKNOX+CGEkiRG/PIc
        9Zo9sTjEvrGFnxRGZ5wGjBU34B7m
X-Google-Smtp-Source: ADFU+vtOhAEKysrjqj79AasYhiG4LYUcsxu1ei3KOCiBhXnrGHF8BgM7nFE0owH/Xoq+tj06daAGsg==
X-Received: by 2002:a17:906:4001:: with SMTP id v1mr8429ejj.36.1584208240461;
        Sat, 14 Mar 2020 10:50:40 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d83:b000:25e0:954:4866:25e4])
        by smtp.gmail.com with ESMTPSA id b15sm2072157edn.69.2020.03.14.10.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2020 10:50:39 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: adjust to filesystem doc ReST conversion
Date:   Sat, 14 Mar 2020 18:50:30 +0100
Message-Id: <20200314175030.10436-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Mauro's patch series <cover.1581955849.git.mchehab+huawei@kernel.org>
("[PATCH 00/44] Manually convert filesystem FS documents to ReST")
converts many Documentation/filesystems/ files to ReST.

Since then, ./scripts/get_maintainer.pl --self-test complains with 27
warnings on Documentation/filesystems/ of this kind:

  warning: no file matches F: Documentation/filesystems/...

Adjust MAINTAINERS entries to all files converted from .txt to .rst in the
patch series and address the 27 warnings.

Link: https://lore.kernel.org/linux-erofs/cover.1581955849.git.mchehab+huawei@kernel.org
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1 -> v2:
Patch v2 is now based on today's docs-next (now with base-commit below)

Jonathan, pick pick this patch v2 for docs-next.

If still does not apply, let us reduce the churn---you can simply run
this script if you want to produce the changes:

  ./scripts/get_maintainer.pl --self-test > findings
  grep "Documentation\/filesystems/" findings | \
  sed 's#^.*\(Documentation\/filesystems\/.*\.\)txt$#sed -i "s!\1txt!\1rst!" MAINTAINERS#' | sh


 MAINTAINERS | 54 ++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5ddc491bea55..38f58b85eb06 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -214,7 +214,7 @@ Q:	http://patchwork.kernel.org/project/v9fs-devel/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git
 T:	git git://github.com/martinetd/linux.git
 S:	Maintained
-F:	Documentation/filesystems/9p.txt
+F:	Documentation/filesystems/9p.rst
 F:	fs/9p/
 F:	net/9p/
 F:	include/net/9p/
@@ -584,7 +584,7 @@ AFFS FILE SYSTEM
 M:	David Sterba <dsterba@suse.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Odd Fixes
-F:	Documentation/filesystems/affs.txt
+F:	Documentation/filesystems/affs.rst
 F:	fs/affs/
 
 AFS FILESYSTEM
@@ -593,7 +593,7 @@ L:	linux-afs@lists.infradead.org
 S:	Supported
 F:	fs/afs/
 F:	include/trace/events/afs.h
-F:	Documentation/filesystems/afs.txt
+F:	Documentation/filesystems/afs.rst
 W:	https://www.infradead.org/~dhowells/kafs/
 
 AGPGART DRIVER
@@ -3063,7 +3063,7 @@ M:	Luis de Bethencourt <luisbg@kernel.org>
 M:	Salah Triki <salah.triki@gmail.com>
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luisbg/linux-befs.git
-F:	Documentation/filesystems/befs.txt
+F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
 BFQ I/O SCHEDULER
@@ -3077,7 +3077,7 @@ F:	Documentation/block/bfq-iosched.rst
 BFS FILE SYSTEM
 M:	"Tigran A. Aivazian" <aivazian.tigran@gmail.com>
 S:	Maintained
-F:	Documentation/filesystems/bfs.txt
+F:	Documentation/filesystems/bfs.rst
 F:	fs/bfs/
 F:	include/uapi/linux/bfs_fs.h
 
@@ -3610,7 +3610,7 @@ W:	http://btrfs.wiki.kernel.org/
 Q:	http://patchwork.kernel.org/project/linux-btrfs/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs.git
 S:	Maintained
-F:	Documentation/filesystems/btrfs.txt
+F:	Documentation/filesystems/btrfs.rst
 F:	fs/btrfs/
 F:	include/linux/btrfs*
 F:	include/uapi/linux/btrfs*
@@ -3906,7 +3906,7 @@ W:	http://ceph.com/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sage/ceph-client.git
 T:	git git://github.com/ceph/ceph-client.git
 S:	Supported
-F:	Documentation/filesystems/ceph.txt
+F:	Documentation/filesystems/ceph.rst
 F:	fs/ceph/
 
 CERTIFICATE HANDLING:
@@ -4423,7 +4423,7 @@ F:	include/linux/cpuidle.h
 CRAMFS FILESYSTEM
 M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Maintained
-F:	Documentation/filesystems/cramfs.txt
+F:	Documentation/filesystems/cramfs.rst
 F:	fs/cramfs/
 
 CREATIVE SB0540
@@ -5938,7 +5938,7 @@ W:	http://ecryptfs.org
 W:	https://launchpad.net/ecryptfs
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tyhicks/ecryptfs.git
 S:	Supported
-F:	Documentation/filesystems/ecryptfs.txt
+F:	Documentation/filesystems/ecryptfs.rst
 F:	fs/ecryptfs/
 
 EDAC-AMD64
@@ -6254,7 +6254,7 @@ M:	Chao Yu <yuchao0@huawei.com>
 L:	linux-erofs@lists.ozlabs.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
-F:	Documentation/filesystems/erofs.txt
+F:	Documentation/filesystems/erofs.rst
 F:	fs/erofs/
 F:	include/trace/events/erofs.h
 
@@ -6315,7 +6315,7 @@ EXT2 FILE SYSTEM
 M:	Jan Kara <jack@suse.com>
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
-F:	Documentation/filesystems/ext2.txt
+F:	Documentation/filesystems/ext2.rst
 F:	fs/ext2/
 F:	include/linux/ext2*
 
@@ -6389,7 +6389,7 @@ L:	linux-f2fs-devel@lists.sourceforge.net
 W:	https://f2fs.wiki.kernel.org/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
 S:	Maintained
-F:	Documentation/filesystems/f2fs.txt
+F:	Documentation/filesystems/f2fs.rst
 F:	Documentation/ABI/testing/sysfs-fs-f2fs
 F:	fs/f2fs/
 F:	include/linux/f2fs_fs.h
@@ -7431,13 +7431,13 @@ F:	drivers/infiniband/hw/hfi1
 HFS FILESYSTEM
 L:	linux-fsdevel@vger.kernel.org
 S:	Orphan
-F:	Documentation/filesystems/hfs.txt
+F:	Documentation/filesystems/hfs.rst
 F:	fs/hfs/
 
 HFSPLUS FILESYSTEM
 L:	linux-fsdevel@vger.kernel.org
 S:	Orphan
-F:	Documentation/filesystems/hfsplus.txt
+F:	Documentation/filesystems/hfsplus.rst
 F:	fs/hfsplus/
 
 HGA FRAMEBUFFER DRIVER
@@ -8308,7 +8308,7 @@ M:	Jan Kara <jack@suse.cz>
 R:	Amir Goldstein <amir73il@gmail.com>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
-F:	Documentation/filesystems/inotify.txt
+F:	Documentation/filesystems/inotify.rst
 F:	fs/notify/inotify/
 F:	include/linux/inotify.h
 F:	include/uapi/linux/inotify.h
@@ -11791,7 +11791,7 @@ W:	https://nilfs.sourceforge.io/
 W:	https://nilfs.osdn.jp/
 T:	git git://github.com/konis/nilfs2.git
 S:	Supported
-F:	Documentation/filesystems/nilfs2.txt
+F:	Documentation/filesystems/nilfs2.rst
 F:	fs/nilfs2/
 F:	include/trace/events/nilfs2.h
 F:	include/uapi/linux/nilfs2_api.h
@@ -11900,7 +11900,7 @@ L:	linux-ntfs-dev@lists.sourceforge.net
 W:	http://www.tuxera.com/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
 S:	Supported
-F:	Documentation/filesystems/ntfs.txt
+F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
 NUBUS SUBSYSTEM
@@ -12246,7 +12246,7 @@ OMFS FILESYSTEM
 M:	Bob Copeland <me@bobcopeland.com>
 L:	linux-karma-devel@lists.sourceforge.net
 S:	Maintained
-F:	Documentation/filesystems/omfs.txt
+F:	Documentation/filesystems/omfs.rst
 F:	fs/omfs/
 
 OMNIKEY CARDMAN 4000 DRIVER
@@ -12495,8 +12495,8 @@ M:	Joseph Qi <joseph.qi@linux.alibaba.com>
 L:	ocfs2-devel@oss.oracle.com (moderated for non-subscribers)
 W:	http://ocfs2.wiki.kernel.org
 S:	Supported
-F:	Documentation/filesystems/ocfs2.txt
-F:	Documentation/filesystems/dlmfs.txt
+F:	Documentation/filesystems/ocfs2.rst
+F:	Documentation/filesystems/dlmfs.rst
 F:	fs/ocfs2/
 
 ORANGEFS FILESYSTEM
@@ -12506,7 +12506,7 @@ L:	devel@lists.orangefs.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hubcap/linux.git
 S:	Supported
 F:	fs/orangefs/
-F:	Documentation/filesystems/orangefs.txt
+F:	Documentation/filesystems/orangefs.rst
 
 ORINOCO DRIVER
 L:	linux-wireless@vger.kernel.org
@@ -13469,7 +13469,7 @@ S:	Maintained
 F:	fs/proc/
 F:	include/linux/proc_fs.h
 F:	tools/testing/selftests/proc/
-F:	Documentation/filesystems/proc.txt
+F:	Documentation/filesystems/proc.rst
 
 PROC SYSCTL
 M:	Luis Chamberlain <mcgrof@kernel.org>
@@ -15738,7 +15738,7 @@ L:	squashfs-devel@lists.sourceforge.net (subscribers-only)
 W:	http://squashfs.org.uk
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pkl/squashfs-next.git
 S:	Maintained
-F:	Documentation/filesystems/squashfs.txt
+F:	Documentation/filesystems/squashfs.rst
 F:	fs/squashfs/
 
 SRM (Alpha) environment access
@@ -16181,7 +16181,7 @@ F:	drivers/platform/x86/system76_acpi.c
 SYSV FILESYSTEM
 M:	Christoph Hellwig <hch@infradead.org>
 S:	Maintained
-F:	Documentation/filesystems/sysv-fs.txt
+F:	Documentation/filesystems/sysv-fs.rst
 F:	fs/sysv/
 F:	include/linux/sysv_fs.h
 
@@ -17046,7 +17046,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git next
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git fixes
 W:	http://www.linux-mtd.infradead.org/doc/ubifs.html
 S:	Supported
-F:	Documentation/filesystems/ubifs.txt
+F:	Documentation/filesystems/ubifs.rst
 F:	fs/ubifs/
 
 UCLINUX (M68KNOMMU AND COLDFIRE)
@@ -17065,7 +17065,7 @@ F:	arch/m68k/include/asm/*_no.*
 UDF FILESYSTEM
 M:	Jan Kara <jack@suse.com>
 S:	Maintained
-F:	Documentation/filesystems/udf.txt
+F:	Documentation/filesystems/udf.rst
 F:	fs/udf/
 
 UDRAW TABLET
@@ -18504,7 +18504,7 @@ L:	linux-fsdevel@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/zonefs.git
 S:	Maintained
 F:	fs/zonefs/
-F:	Documentation/filesystems/zonefs.txt
+F:	Documentation/filesystems/zonefs.rst
 
 ZPOOL COMPRESSED PAGE STORAGE API
 M:	Dan Streetman <ddstreet@ieee.org>

base-commit: 7d3d3254adaa61cba896f71497f56901deb618e5
-- 
2.17.1

