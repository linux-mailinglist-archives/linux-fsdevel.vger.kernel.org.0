Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D2AA324ABB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Feb 2021 08:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbhBYHE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Feb 2021 02:04:58 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13049 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232471AbhBYHE1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Feb 2021 02:04:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614237151; x=1645773151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EiTEA8rJ+zvTS8aqZsBQxKesJgcmxfVC6VzIj84hvAg=;
  b=FOynYpEZFv5VH73EX8VthfMXWxbbLVmHHdRzZ86Q4b4IKvQVGceAUOgJ
   CI9VWDbC+/hKry154PbPi7vEodn7u200WdKdJndbw8bhG8emCLcTiuB9O
   FKbJa0XI2DtGjhq2AnX5LdtIXR9hIpLCJ1bi4nGU8Yfgl+MWmYe2ue5kT
   PgAeiMmR0hzpCOJ19iwIcdRz1ryddsn7o16tRyXFSA7PLam99y1MItPD5
   tdhHoumsCFldMtQLyg4Dddp12DHe8Hwhxfx6f9UzeP4tft/eUGj1P54cT
   3K17bde+8YrXhPWExBxwYS/4gxzkUH+Pc0n/G1qZd7xaQR+gFGN2N8a2y
   w==;
IronPort-SDR: gZ25v9M7mI62mr5idEYVUi5V7S4lBlxia8YN3PX/Dw7JWqjPwm6ckiqo4sOUJBRJ5i5YuvHVLg
 ZPiPM4xCk7J7HwL8FpkMRexnvaFx/zqiCqtSoDdtaiCyyS+hOId57K07qd6X/ImHVugtwRLuJX
 CAvy+y/gNlb1moTKLJP6CStYKNi0qpmbTonR7BQpLVmzYmf6jFnDaOGIyhC+m6MLkfHB3eZypB
 FnpdbjvYxsr7eskApzuCrzOUZeQPMkJlXv9ETvcPh6rGjeKW20rGFRI3bQ5cXHE7ml8OavS57f
 NF8=
X-IronPort-AV: E=Sophos;i="5.81,205,1610380800"; 
   d="scan'208";a="264978745"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 15:10:11 +0800
IronPort-SDR: 8CaMf0F2w5QaKLxAa8Il9wVovreEuAwf/YFhNObbETqHgmkNK7dfr+hJpWLSXkbq6eB7smKw+J
 mdrrQDGilv08PPz+F6cyMb0mqLfXiDCVULYVxVRzNu25cm90jOJXrUiMB+8SYXapH0xW8c2NkO
 ulSxMrH5G/BEVqA7O+AR6zDzK6ifyY25naZ68u/e9PiS30tUULSfQIXpw9NVLJFBWZPrsZVVE2
 MwKJXDjVKgRc7XGzSVessK2tD6HOg3ekzsji/0HswTo9ITyAk4YYdnYOuzy/eOr2955ABhYKx5
 Qn2AG+Qqzp7Gg54O/L1LAbHs
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2021 22:44:15 -0800
IronPort-SDR: 3XQYXge+QisbPCejLdBFccnJRWKymYEXC/6SYM+GtSuop1vUOQyDChD+eIqYWQOUXFnz24g3tT
 Kxc65b/1w7Px+bKEBNVhhbEjXKXcWzVfxejEtyIS+CHIq+6U4ykF8ZE3PedQ+/B8zG4fYjKaEh
 jfJerGeuCGZY4X14c77d6qsTnADp2DPkJf5UQiGqRADEOQGyh6vLFQfTfGvuZEEd0OGmTGenb+
 BSfklIiP8EW4dEfBdK94hgTePEqtjhIUoxVEfsQEl+WWZYfrsPneGhXcJ34fZIId6RD/Pj1Zil
 43I=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 23:02:53 -0800
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk, rostedt@goodmis.org,
        mingo@redhat.com, chaitanya.kulkarni@wdc.com,
        johannes.thumshirn@wdc.com, damien.lemoal@wdc.com,
        bvanassche@acm.org, dongli.zhang@oracle.com,
        aravind.ramesh@wdc.com, joshi.k@samsung.com, niklas.cassel@wdc.com,
        hch@lst.de, osandov@fb.com, martin.petersen@oracle.com
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH 01/39] blktrace_api: add new trace definitions
Date:   Wed, 24 Feb 2021 23:01:53 -0800
Message-Id: <20210225070231.21136-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
References: <20210225070231.21136-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds a new trace categories, trace actions adds a new
version number for the trace extentions, adds new trace extension
structure to hold actual trace along with structure nedded to execute
various IOCTLs to configure trace from user space.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 include/uapi/linux/blktrace_api.h | 110 ++++++++++++++++++++++++------
 1 file changed, 89 insertions(+), 21 deletions(-)

diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktrace_api.h
index 690621b610e5..fdb3a5cdfa22 100644
--- a/include/uapi/linux/blktrace_api.h
+++ b/include/uapi/linux/blktrace_api.h
@@ -8,30 +8,41 @@
  * Trace categories
  */
 enum blktrace_cat {
-	BLK_TC_READ	= 1 << 0,	/* reads */
-	BLK_TC_WRITE	= 1 << 1,	/* writes */
-	BLK_TC_FLUSH	= 1 << 2,	/* flush */
-	BLK_TC_SYNC	= 1 << 3,	/* sync IO */
-	BLK_TC_SYNCIO	= BLK_TC_SYNC,
-	BLK_TC_QUEUE	= 1 << 4,	/* queueing/merging */
-	BLK_TC_REQUEUE	= 1 << 5,	/* requeueing */
-	BLK_TC_ISSUE	= 1 << 6,	/* issue */
-	BLK_TC_COMPLETE	= 1 << 7,	/* completions */
-	BLK_TC_FS	= 1 << 8,	/* fs requests */
-	BLK_TC_PC	= 1 << 9,	/* pc requests */
-	BLK_TC_NOTIFY	= 1 << 10,	/* special message */
-	BLK_TC_AHEAD	= 1 << 11,	/* readahead */
-	BLK_TC_META	= 1 << 12,	/* metadata */
-	BLK_TC_DISCARD	= 1 << 13,	/* discard requests */
-	BLK_TC_DRV_DATA	= 1 << 14,	/* binary per-driver data */
-	BLK_TC_FUA	= 1 << 15,	/* fua requests */
-
-	BLK_TC_END	= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_READ		= 1 << 0,	/* reads */
+	BLK_TC_WRITE		= 1 << 1,	/* writes */
+	BLK_TC_FLUSH		= 1 << 2,	/* flush */
+	BLK_TC_SYNC		= 1 << 3,	/* sync IO */
+	BLK_TC_SYNCIO		= BLK_TC_SYNC,
+	BLK_TC_QUEUE		= 1 << 4,	/* queueing/merging */
+	BLK_TC_REQUEUE		= 1 << 5,	/* requeueing */
+	BLK_TC_ISSUE		= 1 << 6,	/* issue */
+	BLK_TC_COMPLETE		= 1 << 7,	/* completions */
+	BLK_TC_FS		= 1 << 8,	/* fs requests */
+	BLK_TC_PC		= 1 << 9,	/* pc requests */
+	BLK_TC_NOTIFY		= 1 << 10,	/* special message */
+	BLK_TC_AHEAD		= 1 << 11,	/* readahead */
+	BLK_TC_META		= 1 << 12,	/* metadata */
+	BLK_TC_DISCARD		= 1 << 13,	/* discard requests */
+	BLK_TC_DRV_DATA		= 1 << 14,	/* binary per-driver data */
+	BLK_TC_FUA		= 1 << 15,	/* fua requests */
+	BLK_TC_WRITE_ZEROES	= 1 << 16,	/* write-zeores */
+	BLK_TC_ZONE_RESET	= 1 << 17,	/* zone-reset */
+	BLK_TC_ZONE_RESET_ALL	= 1 << 18,	/* zone-reset-all */
+	BLK_TC_ZONE_APPEND	= 1 << 19,	/* zone-append */
+	BLK_TC_ZONE_OPEN	= 1 << 20,	/* zone-open */
+	BLK_TC_ZONE_CLOSE	= 1 << 21,	/* zone-close */
+	BLK_TC_ZONE_FINISH	= 1 << 22,	/* zone-finish */
+
+	BLK_TC_END		= 1 << 15,	/* we've run out of bits! */
+	BLK_TC_END_EXT		= 1 << 31,	/* we've run out of bits! */
 };
 
 #define BLK_TC_SHIFT		(16)
 #define BLK_TC_ACT(act)		((act) << BLK_TC_SHIFT)
 
+#define BLK_TC_SHIFT_EXT   	(32)
+#define BLK_TC_ACT_EXT(act)		(((u64)act) << BLK_TC_SHIFT_EXT)
+
 /*
  * Basic trace actions
  */
@@ -88,12 +99,38 @@ enum blktrace_notify {
 #define BLK_TA_ABORT		(__BLK_TA_ABORT | BLK_TC_ACT(BLK_TC_QUEUE))
 #define BLK_TA_DRV_DATA	(__BLK_TA_DRV_DATA | BLK_TC_ACT(BLK_TC_DRV_DATA))
 
+#define BLK_TA_QUEUE_EXT	(__BLK_TA_QUEUE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_BACKMERGE_EXT	(__BLK_TA_BACKMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_FRONTMERGE_EXT	(__BLK_TA_FRONTMERGE | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_GETRQ_EXT	(__BLK_TA_GETRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SLEEPRQ_EXT	(__BLK_TA_SLEEPRQ | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_REQUEUE_EXT	(__BLK_TA_REQUEUE | BLK_TC_ACT_EXT(BLK_TC_REQUEUE))
+#define BLK_TA_ISSUE_EXT	(__BLK_TA_ISSUE | BLK_TC_ACT_EXT(BLK_TC_ISSUE))
+#define BLK_TA_COMPLETE_EXT	(__BLK_TA_COMPLETE | BLK_TC_ACT_EXT(BLK_TC_COMPLETE))
+#define BLK_TA_PLUG_EXT		(__BLK_TA_PLUG | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_IO_EXT	(__BLK_TA_UNPLUG_IO | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_UNPLUG_TIMER_EXT		\
+	(__BLK_TA_UNPLUG_TIMER | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_INSERT_EXT	(__BLK_TA_INSERT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_SPLIT_EXT	(__BLK_TA_SPLIT)
+#define BLK_TA_BOUNCE_EXT	(__BLK_TA_BOUNCE)
+#define BLK_TA_REMAP_EXT	(__BLK_TA_REMAP | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_ABORT_EXT	(__BLK_TA_ABORT | BLK_TC_ACT_EXT(BLK_TC_QUEUE))
+#define BLK_TA_DRV_DATA_EXT	\
+	(__BLK_TA_DRV_DATA | BLK_TC_ACT_EXT(BLK_TC_DRV_DATA))
+
 #define BLK_TN_PROCESS		(__BLK_TN_PROCESS | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_TIMESTAMP	(__BLK_TN_TIMESTAMP | BLK_TC_ACT(BLK_TC_NOTIFY))
 #define BLK_TN_MESSAGE		(__BLK_TN_MESSAGE | BLK_TC_ACT(BLK_TC_NOTIFY))
 
-#define BLK_IO_TRACE_MAGIC	0x65617400
-#define BLK_IO_TRACE_VERSION	0x07
+#define BLK_TN_PROCESS_EXT	(__BLK_TN_PROCESS | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_TIMESTAMP_EXT	(__BLK_TN_TIMESTAMP | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+#define BLK_TN_MESSAGE_EXT	(__BLK_TN_MESSAGE | BLK_TC_ACT_EXT(BLK_TC_NOTIFY))
+
+#define BLK_IO_TRACE_MAGIC             0x65617400
+#define BLK_IO_TRACE_VERSION           0x07
+#define BLK_IO_TRACE_VERSION_EXT       0x08
+
 
 /*
  * The trace itself
@@ -113,6 +150,23 @@ struct blk_io_trace {
 	/* cgroup id will be stored here if exists */
 };
 
+struct blk_io_trace_ext {
+	__u32 magic;		/* MAGIC << 8 | version */
+	__u32 sequence;		/* event number */
+	__u64 time;		/* in nanoseconds */
+	__u64 sector;		/* disk offset */
+	__u32 bytes;		/* transfer length */
+	__u64 action;		/* what happened */
+	__u32 ioprio;		/* I/O priority */
+	__u32 pid;		/* who did it */
+	__u32 device;		/* device number */
+	__u32 cpu;		/* on what cpu did it happen */
+	__u16 error;		/* completion error */
+	__u16 pdu_len;		/* length of data after this trace */
+	/* cgroup id will be stored here if exists */
+};
+
+
 /*
  * The remap event
  */
@@ -143,4 +197,18 @@ struct blk_user_trace_setup {
 	__u32 pid;
 };
 
+/*
+ * User setup structure passed with BLKTRACESETUP_EXT
+ */
+struct blk_user_trace_setup_ext {
+	char name[BLKTRACE_BDEV_SIZE];	/* output */
+	__u64 act_mask;			/* input */
+	__u32 prio_mask;		/* input */
+	__u32 buf_size;			/* input */
+	__u32 buf_nr;			/* input */
+	__u64 start_lba;
+	__u64 end_lba;
+	__u32 pid;
+};
+
 #endif /* _UAPIBLKTRACE_H */
-- 
2.22.1

