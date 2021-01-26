Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E688305D03
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 14:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313108AbhAZWhY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:37:24 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:6065 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390419AbhAZUWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:22:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611692556; x=1643228556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K6PazQ3tbaJ1mgKNse097Yog4Wc0TOxrCugWKVD9TQA=;
  b=bEN3u5qOsK0Ef3IcypwiUcE+DHAOMC32cx4F/jR45xrhwlWe/FNR7UGW
   bfB9ic0rY842dWMrhhXSlzyaCY7ukJQCGNdXJStPjwj2Bdjhcsx/PSx9j
   LKoCM0qtas9L2cewkWkYplWusHzMbDRcVx9WFQIURE1LANXTZUrHh/JZu
   z6wC/T3EjsgllsXoqeQ87b5RAoThzgY+e5FtqKUsG6QA3gLRbsnb0KTa6
   FmHNMXghat0MIc7UQ3xnTVa/6mKFB+uhLiWW02GtWLuXQ0OPWRWHQjOOx
   sY71+mz7zF4tudckcvlWpB+dK2zCNCT3kTuJi1RN2beULL1tHrbkd04Dv
   Q==;
IronPort-SDR: NaDEIs9zPZ++CWXVYY7Au1/IpnFMzmApY7gB+sxkpArTgH62qgTtn/WZjZj1TpDNKnxGChRbH7
 q5UPEP5arUOUbzbqLqrwF+g5E0NgjLIdofp0QsCsDXAVMfVgB6+1cMn6IGph/vKvpVHVexvcfY
 7WrayE1RTf4616M3qcoRpklUzzc68zfps9c2phGNlCzY6tVA6ov6o2uqpkNyse4UVPxX/6i0pB
 Ui00fJvELdV331wbjNQi2J3jyUv6rSfFCzc5cocfdYhIa1gtuMH3WDtRtqgN24hkGcynZfSnLO
 sww=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="159558207"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 04:21:29 +0800
IronPort-SDR: 1O59wsT2t6bK+U+yjKIVYJIWXgF6eBZn8zcYqKtoBjUQSziCudTv/EPGTCMr4Vu87s3O2uuI59
 I11+iL0KHu6EgY/LHW38zxvcznCqxxalm/Ivea+XIwO0sk4gM6q4U/1jJ67MkGVkcXZJxEBE2a
 R960F0dVehIEp4NkJHkuT6ZIu0OKNtsuJ51hRq5vmc1FYSZud70IIbxE2rGi5gqaDnHJpZOeIU
 usPqxXHYGY8NKWyl9VbcXX6NjEb8408kBcxsLLhnkapLb09T35PypWBuLjjM6lnmPNrr+TA1gC
 thhbyRkIRu3h/ZHDxxVYz4gz
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 12:05:54 -0800
IronPort-SDR: JVU4fMNwMXQFmCAtTjmrNEU/Vlcb6hp0VeSkyNIAtkWX+9IP86xERki05KNqA9L5X3U1lv02bC
 ZIhapvo/yWRCz5kYe/+BHWNBs6+3y1RN30w9QZ80laIISAMJ5eMYw11dBrxTycW2HUjkOclYLP
 ykj1/omVRxPvQZL5qUhXiEe6FFXN4KjVgRrdyCDByXi0EdPBp6oZRbxQbgnI+AerCCVs+n5dY7
 d2N64f8lNB1s6K4orzHZ7O8dOPWvbGSLyxNeugAlnzyiIOrx3xglSfwpp/T9TY93RcrDqrZEDo
 xuo=
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 26 Jan 2021 12:21:29 -0800
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] zonefs: add tracepoints for file operations
Date:   Wed, 27 Jan 2021 05:21:15 +0900
Message-Id: <7395c37618a567d71adc14951658007bc985d072.1611692445.git.johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tracepoints for file I/O operations to aid in debugging of I/O errors
with zonefs.

The added tracepoints are in:
- zonefs_zone_mgmt() for tracing zone management operations
- zonefs_iomap_begin() for tracing regular file I/O
- zonefs_file_dio_append() for tracing zone-append operations

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 fs/zonefs/Makefile |   2 +
 fs/zonefs/super.c  |   7 +++
 fs/zonefs/trace.h  | 103 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)
 create mode 100644 fs/zonefs/trace.h

diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile
index 75a380aa1ae1..33c1a4f1132e 100644
--- a/fs/zonefs/Makefile
+++ b/fs/zonefs/Makefile
@@ -1,4 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
+ccflags-y				+= -I$(src)
+
 obj-$(CONFIG_ZONEFS_FS) += zonefs.o
 
 zonefs-y	:= super.o
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index bec47f2d074b..96f0cb0c29aa 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -24,6 +24,9 @@
 
 #include "zonefs.h"
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 static inline int zonefs_zone_mgmt(struct inode *inode,
 				   enum req_opf op)
 {
@@ -32,6 +35,7 @@ static inline int zonefs_zone_mgmt(struct inode *inode,
 
 	lockdep_assert_held(&zi->i_truncate_mutex);
 
+	trace_zonefs_zone_mgmt(inode, op);
 	ret = blkdev_zone_mgmt(inode->i_sb->s_bdev, op, zi->i_zsector,
 			       zi->i_zone_size >> SECTOR_SHIFT, GFP_NOFS);
 	if (ret) {
@@ -100,6 +104,8 @@ static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	iomap->bdev = inode->i_sb->s_bdev;
 	iomap->addr = (zi->i_zsector << SECTOR_SHIFT) + iomap->offset;
 
+	trace_zonefs_iomap_begin(inode, iomap);
+
 	return 0;
 }
 
@@ -703,6 +709,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 	ret = submit_bio_wait(bio);
 
 	zonefs_file_write_dio_end_io(iocb, size, ret, 0);
+	trace_zonefs_file_dio_append(inode, size, ret);
 
 out_release:
 	bio_release_pages(bio, false);
diff --git a/fs/zonefs/trace.h b/fs/zonefs/trace.h
new file mode 100644
index 000000000000..d86f66c28e50
--- /dev/null
+++ b/fs/zonefs/trace.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * zonefs filesystem driver tracepoints.
+ *
+ * Copyright (C) 2020 Western Digital Corporation or its affiliates.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM zonefs
+
+#if !defined(_TRACE_ZONEFS_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_ZONEFS_H
+
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+#include <linux/blkdev.h>
+
+#include "zonefs.h"
+
+#define show_dev(dev) MAJOR(dev), MINOR(dev)
+
+TRACE_EVENT(zonefs_zone_mgmt,
+	    TP_PROTO(struct inode *inode, enum req_opf op),
+	    TP_ARGS(inode, op),
+	    TP_STRUCT__entry(
+			     __field(dev_t, dev)
+			     __field(ino_t, ino)
+			     __field(int, op)
+			     __field(sector_t, sector)
+			     __field(sector_t, nr_sectors)
+	    ),
+	    TP_fast_assign(
+			   __entry->dev = inode->i_sb->s_dev;
+			   __entry->ino = inode->i_ino;
+			   __entry->op = op;
+			   __entry->sector = ZONEFS_I(inode)->i_zsector;
+			   __entry->nr_sectors =
+				   ZONEFS_I(inode)->i_zone_size >> SECTOR_SHIFT;
+	    ),
+	    TP_printk("bdev=(%d,%d), ino=%lu op=%s, sector=%llu, nr_sectors=%llu",
+		      show_dev(__entry->dev), __entry->ino,
+		      blk_op_str(__entry->op), __entry->sector,
+		      __entry->nr_sectors
+	    )
+);
+
+TRACE_EVENT(zonefs_file_dio_append,
+	    TP_PROTO(struct inode *inode, ssize_t size, ssize_t ret),
+	    TP_ARGS(inode, size, ret),
+	    TP_STRUCT__entry(
+			     __field(dev_t, dev)
+			     __field(ino_t, ino)
+			     __field(sector_t, sector)
+			     __field(ssize_t, size)
+			     __field(loff_t, wpoffset)
+			     __field(ssize_t, ret)
+	    ),
+	    TP_fast_assign(
+			   __entry->dev = inode->i_sb->s_dev;
+			   __entry->ino = inode->i_ino;
+			   __entry->sector = ZONEFS_I(inode)->i_zsector;
+			   __entry->size = size;
+			   __entry->wpoffset = ZONEFS_I(inode)->i_wpoffset;
+			   __entry->ret = ret;
+	    ),
+	    TP_printk("bdev=(%d, %d), ino=%lu, sector=%llu, size=%zu, wpoffset=%llu, ret=%zu",
+		      show_dev(__entry->dev), __entry->ino, __entry->sector,
+		      __entry->size, __entry->wpoffset, __entry->ret
+	    )
+);
+
+TRACE_EVENT(zonefs_iomap_begin,
+	    TP_PROTO(struct inode *inode, struct iomap *iomap),
+	    TP_ARGS(inode, iomap),
+	    TP_STRUCT__entry(
+			     __field(dev_t, dev)
+			     __field(ino_t, ino)
+			     __field(u64, addr)
+			     __field(loff_t, offset)
+			     __field(u64, length)
+	    ),
+	    TP_fast_assign(
+			   __entry->dev = inode->i_sb->s_dev;
+			   __entry->ino = inode->i_ino;
+			   __entry->addr = iomap->addr;
+			   __entry->offset = iomap->offset;
+			   __entry->length = iomap->length;
+	    ),
+	    TP_printk("bdev=(%d,%d), ino=%lu, addr=%llu, offset=%llu, length=%llu",
+		      show_dev(__entry->dev), __entry->ino, __entry->addr,
+		      __entry->offset, __entry->length
+	    )
+);
+
+#endif /* _TRACE_ZONEFS_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.26.2

