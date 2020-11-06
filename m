Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED522A8DB3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 04:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgKFDrw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Nov 2020 22:47:52 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:38722 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFDrw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Nov 2020 22:47:52 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0UEO33AN_1604634469;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEO33AN_1604634469)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 06 Nov 2020 11:47:49 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/hfs: remove unused macro to tame gcc
Date:   Fri,  6 Nov 2020 11:47:36 +0800
Message-Id: <1604634457-3954-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Couple macro are duplicated defined and they are not used. So
to tame gcc, let's remove them.

fs/hfsplus/part_tbl.c:26:0: warning: macro "HFS_DRVR_DESC_MAGIC" is not
used [-Wunused-macros]
fs/hfsplus/part_tbl.c:30:0: warning: macro "HFS_MFS_SUPER_MAGIC" is not
used [-Wunused-macros]
fs/hfsplus/part_tbl.c:21:0: warning: macro "HFS_DD_BLK" is not used
[-Wunused-macros]
net/l2tp/l2tp_core.c:73:0: warning: macro "L2TP_HDRFLAG_P" is not used
[-Wunused-macros]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: linux-fsdevel@vger.kernel.org 
Cc: linux-kernel@vger.kernel.org 
---
 fs/hfs/hfs.h          | 2 --
 fs/hfsplus/part_tbl.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 6f194d0768b6..12a807d9dbc0 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -15,11 +15,9 @@
 #define HFS_MDB_BLK		2 /* Block (w/i partition) of MDB */
 
 /* magic numbers for various disk blocks */
-#define HFS_DRVR_DESC_MAGIC	0x4552 /* "ER": driver descriptor map */
 #define HFS_OLD_PMAP_MAGIC	0x5453 /* "TS": old-type partition map */
 #define HFS_NEW_PMAP_MAGIC	0x504D /* "PM": new-type partition map */
 #define HFS_SUPER_MAGIC		0x4244 /* "BD": HFS MDB (super block) */
-#define HFS_MFS_SUPER_MAGIC	0xD2D7 /* MFS MDB (super block) */
 
 /* various FIXED size parameters */
 #define HFS_SECTOR_SIZE		512    /* size of an HFS sector */
diff --git a/fs/hfsplus/part_tbl.c b/fs/hfsplus/part_tbl.c
index 63164ebc52fa..ecda671d56a8 100644
--- a/fs/hfsplus/part_tbl.c
+++ b/fs/hfsplus/part_tbl.c
@@ -23,11 +23,9 @@
 #define HFS_MDB_BLK		2 /* Block (w/i partition) of MDB */
 
 /* magic numbers for various disk blocks */
-#define HFS_DRVR_DESC_MAGIC	0x4552 /* "ER": driver descriptor map */
 #define HFS_OLD_PMAP_MAGIC	0x5453 /* "TS": old-type partition map */
 #define HFS_NEW_PMAP_MAGIC	0x504D /* "PM": new-type partition map */
 #define HFS_SUPER_MAGIC		0x4244 /* "BD": HFS MDB (super block) */
-#define HFS_MFS_SUPER_MAGIC	0xD2D7 /* MFS MDB (super block) */
 
 /*
  * The new style Mac partition map
-- 
1.8.3.1

