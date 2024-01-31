Return-Path: <linux-fsdevel+bounces-9717-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A4844931
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 21:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23354B23ED5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jan 2024 20:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673623984F;
	Wed, 31 Jan 2024 20:53:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8938FBC
	for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 20:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734393; cv=none; b=B4nlBSkl/ifTFtReBPOZ0EHy50BShwiMm5RZwju/EMoeW2QcqD6eGpH1uEAbs/nHYya6pn+/raYGK5szS9546lHo+pM3bw5PsxOmwtqY7/E+uZpC/wxNqyJ8cXCbvTSkK2dVvvPX4v+4YNvqA8W6anlzLZlozIf9nD4eFOgjJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734393; c=relaxed/simple;
	bh=vPA84qeWmp0cURAGPENkY/uMQdtl/36qkCAmo3eJr48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGGCXPykm8EGP8fJmsQcsgpCvTsX/YMfx9wX3uraEIRVBqnzrQU8vq9rLNqnOwkZEfUE5m94S9LFf/H+aNG6TdQ9uEa6RlkX4Icku8KQXl21xrbWIO+GJYlcG5l7z4xNP+oa/JFu0ScTjuo5FEpD2gUI0vKn377/dBVvJGAq1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bd72353d9fso168836b6e.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jan 2024 12:53:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734390; x=1707339190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MO1tFiQajMsYAq4KiTOhGu2FSOc6j8yOraYVWH9sMws=;
        b=uCCx6CN0Mb09lT5aPlvDnRvrb+onrOGDkGH0+aCy6ymD6g748VpuqtDkE8iJCLqiZJ
         FK4MvkRuVYqBiZSbA2TElou8j2RvBm47yVyHc6YTp9TnTCc1ixrs/FJ8ynFvQBFbEe4q
         tQG+7bfKVxDfBXklGH4cx1AruTixrEkx05CmZYKjy1rT0Amujy1PM+OAMnGYyb+K6rrB
         UVsIguPQAIakjQU4Jhycpc05BBxTCGBtxmRzZWm7Na2fbDzxO1H5DB9T2we3jwMyNIN0
         ltLxMW/xatMS972rD63g2JhmpQ9zMGvO5uhIxKtwenniC0GmLILcff0SP4bKKo1Eazo5
         03cA==
X-Gm-Message-State: AOJu0YymVcXu2WdYR2SanJbUWNIpRWBqhuIOYw21dvY9m1jf8DuMIRbo
	0CTmdZ6QRz6DIQYQi4i4p84y1mBIRxhuO7H212Tf40N4g6YFoIdB
X-Google-Smtp-Source: AGHT+IEbdvgI/zqfU0PZUlq8QPFqsu7eZX+yJCAxgMhfEMuBrf2JBINCHGoRqH51pP0jeZfmAlAJCQ==
X-Received: by 2002:a05:6358:7f0a:b0:175:67e3:f9be with SMTP id p10-20020a0563587f0a00b0017567e3f9bemr1880461rwn.31.1706734390351;
        Wed, 31 Jan 2024 12:53:10 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:1d95:ca94:1cbe:1409])
        by smtp.gmail.com with ESMTPSA id g3-20020a17090ace8300b00295fb7e7b87sm855977pju.27.2024.01.31.12.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:53:09 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Chao Yu <chao@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 4/6] fs: Move enum rw_hint into a new header file
Date: Wed, 31 Jan 2024 12:52:35 -0800
Message-ID: <20240131205237.3540210-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240131205237.3540210-1-bvanassche@acm.org>
References: <20240131205237.3540210-1-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move enum rw_hint into a new header file to prepare for using this data
type in the block layer. Add the attribute __packed to reduce the space
occupied by instances of this data type from four bytes to one byte.
Change the data type of i_write_hint from u8 into enum rw_hint.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Chao Yu <chao@kernel.org> # for the F2FS part
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/f2fs.h          |  1 +
 fs/fcntl.c              |  1 +
 fs/inode.c              |  1 +
 include/linux/fs.h      | 16 ++--------------
 include/linux/rw_hint.h | 24 ++++++++++++++++++++++++
 5 files changed, 29 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/rw_hint.h

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index dda0aed95464..4a4e60cdac4e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -24,6 +24,7 @@
 #include <linux/blkdev.h>
 #include <linux/quotaops.h>
 #include <linux/part_stat.h>
+#include <linux/rw_hint.h>
 #include <crypto/hash.h>
 
 #include <linux/fscrypt.h>
diff --git a/fs/fcntl.c b/fs/fcntl.c
index 5fa2d95114bf..fc73c5fae43c 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -27,6 +27,7 @@
 #include <linux/memfd.h>
 #include <linux/compat.h>
 #include <linux/mount.h>
+#include <linux/rw_hint.h>
 
 #include <linux/poll.h>
 #include <asm/siginfo.h>
diff --git a/fs/inode.c b/fs/inode.c
index 6d0d54230363..585d79d40158 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -20,6 +20,7 @@
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
 #include <linux/iversion.h>
+#include <linux/rw_hint.h>
 #include <trace/events/writeback.h>
 #include "internal.h"
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ebce4763b4bb..f3ba0895bcd7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -43,6 +43,7 @@
 #include <linux/cred.h>
 #include <linux/mnt_idmapping.h>
 #include <linux/slab.h>
+#include <linux/rw_hint.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -309,19 +310,6 @@ struct address_space;
 struct writeback_control;
 struct readahead_control;
 
-/*
- * Write life time hint values.
- * Stored in struct inode as u8.
- */
-enum rw_hint {
-	WRITE_LIFE_NOT_SET	= 0,
-	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
-	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
-	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
-	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
-	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
-};
-
 /* Match RWF_* bits to IOCB bits */
 #define IOCB_HIPRI		(__force int) RWF_HIPRI
 #define IOCB_DSYNC		(__force int) RWF_DSYNC
@@ -677,7 +665,7 @@ struct inode {
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
 	u8			i_blkbits;
-	u8			i_write_hint;
+	enum rw_hint		i_write_hint;
 	blkcnt_t		i_blocks;
 
 #ifdef __NEED_I_SIZE_ORDERED
diff --git a/include/linux/rw_hint.h b/include/linux/rw_hint.h
new file mode 100644
index 000000000000..309ca72f2dfb
--- /dev/null
+++ b/include/linux/rw_hint.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RW_HINT_H
+#define _LINUX_RW_HINT_H
+
+#include <linux/build_bug.h>
+#include <linux/compiler_attributes.h>
+#include <uapi/linux/fcntl.h>
+
+/* Block storage write lifetime hint values. */
+enum rw_hint {
+	WRITE_LIFE_NOT_SET	= RWH_WRITE_LIFE_NOT_SET,
+	WRITE_LIFE_NONE		= RWH_WRITE_LIFE_NONE,
+	WRITE_LIFE_SHORT	= RWH_WRITE_LIFE_SHORT,
+	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
+	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
+	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+} __packed;
+
+/* Sparse ignores __packed annotations on enums, hence the #ifndef below. */
+#ifndef __CHECKER__
+static_assert(sizeof(enum rw_hint) == 1);
+#endif
+
+#endif /* _LINUX_RW_HINT_H */

