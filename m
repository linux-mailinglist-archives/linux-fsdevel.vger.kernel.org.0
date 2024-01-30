Return-Path: <linux-fsdevel+bounces-9572-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207F7842EF4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A2E1C246C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jan 2024 21:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D8D78B7F;
	Tue, 30 Jan 2024 21:49:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B6078666;
	Tue, 30 Jan 2024 21:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706651381; cv=none; b=KfZFN48imY7OKyRo7Zp5RXvEMGhHEiYrqZUrLT+IfSjUjWzc+VJl7k5OO9dZdvLvbLw+qpkdAhJPRZzUNswnD8AGVUDOuGZDb7gJnU91Xzo1hKDFk8xHwZuVwF/M34hrOeQ75g3Hwz+M5dJeKbfytP45wzNzFizgwQFXqR9S1Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706651381; c=relaxed/simple;
	bh=C6mV3KfDj3Wjbrt+AGCNnge7YG8viX3cFxaZOuvArLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tw361s3cPKFBy693zE3rZ5g0XHxo3VCanSUKwNbnEzE5SHT67sYkETKryXA3uUL8QSAu4tofgvUlm13F49zPN+/bva5grRpNZ8lYCrGgXHZpu4aF8zmUy+ZQ0+1XLYrW65y9EYf7Ru2RKlut5mavSWdmn0slN8uOrBSzZo3LnxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6de0ba30994so186417b3a.1;
        Tue, 30 Jan 2024 13:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706651376; x=1707256176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YzvkWo0KfJnbV5FZqwh8Hi6oyCiJv93P0jXRU5LNY0U=;
        b=WvD6QfZX2PXhJfNW6PvCCqFvfNC2mxo0AuIilHEnVoSEGsS0fRPkT49BEOMZaF3+0v
         mlxcRKogEJkUNoCREdg85ch/y54LjV/K/zmS2UVeeZ/WMSIAk+69rghr4U4aWLc/dPvF
         YVJ7R3i2kgZB6QbwRIyFD7CGaj/XmdpO8B1tuIat1nqOs7gynUCi4ZYiUaS4TKJQ8IcX
         MuKgbxFp8wDsJ5YEum5iRqT3dAxVS6xdFnvUjpqTI8yqwO3eNkBMwx2ano+HkvmzjCR0
         aZH2ue/HRJD2neAunDkoQ6FwvlyUETkrNy0Ql+MsViPdhjeeOYhSrvTCsTFNJI9e0yAC
         Lp6w==
X-Gm-Message-State: AOJu0YxYvjAXIQe1Swn0G2sSuevF9gwQO7uUDuRfgna6EoPyybxGowRa
	tkiEOaU0ctodwWtVRNznDfsKACrgjHDsul2bEJu+kGh0/VbB4RUV
X-Google-Smtp-Source: AGHT+IH74z1/zRmNsf1MzpP0E3VeUDUJBHYOVMZHzg/oXZ4zrsL0yVokVBGHDACpZDCijuwybCK1QQ==
X-Received: by 2002:a05:6a00:810:b0:6dd:a32c:d7ef with SMTP id m16-20020a056a00081000b006dda32cd7efmr2818679pfk.8.1706651376029;
        Tue, 30 Jan 2024 13:49:36 -0800 (PST)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:f45c:fd18:bfa0:e084])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7998e000000b006db87354a8fsm8285597pfh.119.2024.01.30.13.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 13:49:35 -0800 (PST)
From: Bart Van Assche <bvanassche@acm.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Daejun Park <daejun7.park@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v9 04/19] fs: Move enum rw_hint into a new header file
Date: Tue, 30 Jan 2024 13:48:30 -0800
Message-ID: <20240130214911.1863909-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130214911.1863909-1-bvanassche@acm.org>
References: <20240130214911.1863909-1-bvanassche@acm.org>
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
index 65294e3b0bef..01fde6d44bf6 100644
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
index 91048c4c9c9e..1aba6c0bf26a 100644
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
index ed5966a70495..bdabda5dc364 100644
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

