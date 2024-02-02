Return-Path: <linux-fsdevel+bounces-10094-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9060847A9A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6F6B1C20E1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3979F3A1BA;
	Fri,  2 Feb 2024 20:39:57 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECF77FBBA
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Feb 2024 20:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906396; cv=none; b=DWscBSK7wzuhg/qTyK0/xgUnDu7pQrl+qj9LV0OUXu8wHHO/25Hr7B2d4VbgxpRxMzlqiK8bD9PeGxlDP4i3EmC9UQRdKJjGZBJHZwIOymNN+214LChqv7SFSbOyuAc01Ds4APjuKEhhscFr45uaFALqqrQKIVjt+FJSCRCQDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906396; c=relaxed/simple;
	bh=e3ymkD6zZ+VrSZBKaRGDFyMQBo150T8Ix5MIlSXba7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVdAXsMBm7dr8Ds3UX6umm9sE0h/B8yolmoYWN4sGPyuRubwhLKFs8kX9vEVwuJsZaNgZ2wjXRAn3syJeMxuDnS8RD+pnJJKkEtUl0tlQ72Ow9JQdx7PQz5W5cJQAU34iK1h7VfiwZZjG0K1vi+5CYDD80zNnRzr8yBkI9jP39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d7005ea1d0so887746a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Feb 2024 12:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906394; x=1707511194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW8D9CdFkptVzP2MNKckbivPDn5zWzX1RDd8apJ2rlk=;
        b=U8abE36Ptkb8OjFD1y5t9n4T687ysuam1KRj9fH1DDkS6lanaQsAdEEsbK/Jj2oUtx
         Cd6hY0VvqgaN1nPlKvBcfhiCs2/hcZbLOy9givV6njU4a3aWZNocgYsYSCkdEWNQHCfS
         djA80xfQetaDGKNX/0UamnzT/gCBqDBZW1h6LrQezv1+Fxc080y1AKHM8wneqvLbSA7+
         ukRv8FoQk4t+W8GDDn902bfPrp5dgCSHhCYmz5Ii+zr2NORSct5owGtxq76/0VYgH/CP
         h9iEJVdXgZbpZpZ5O2fn9sIKFlJ9CytNBEm4BtQK3jk8uwIgbAelnaGkrpfYXZHdKLZk
         PPpQ==
X-Gm-Message-State: AOJu0YyTxco4QyQ6Mf4Qg8TzHQZWVG9mA9SvHmL/SN677chR7oHd/j4p
	6ooH2IvZ5mWGT2vQr0GF+Y1MJCxvEURxXSLn67V7W8uZ33VnsniK
X-Google-Smtp-Source: AGHT+IHTyOa0G3KPp3efLJ79Fc7ey0F5KIJ5GGruApV1QRgyJL6tXsRxZm4Rvq/9Ll89oOm1e59w3g==
X-Received: by 2002:a05:6a20:a123:b0:19e:4833:8b73 with SMTP id q35-20020a056a20a12300b0019e48338b73mr352393pzk.12.1706906393593;
        Fri, 02 Feb 2024 12:39:53 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEfh0GqdJGjQmpGeNS2lS5uz56i5mhb+PF0SBQo8BXOWJKcwadiSQ32cZmRxHTGeFq87HLZCTZ5r8atpWYtlMdQD+pHmXP0Wk9FjDIZ5Md1HDU5QPoIU6bSMa6di4fQHITHSHDqwhoRaOfXhZtHIXw6NvT/X+sK3SyV8fxkjhHi/hmioWMTYPZ51G4zA9bgifijqa8qBlrsHHEWadHGnxjwkXlFasxpQieAmSWBqYk5wDERg==
Received: from bvanassche-linux.mtv.corp.google.com ([2620:0:1000:8411:4cc3:4ab5:7d2:ddc7])
        by smtp.gmail.com with ESMTPSA id f8-20020a63de08000000b005d8aef12380sm2239678pgg.73.2024.02.02.12.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:39:53 -0800 (PST)
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
Subject: [PATCH v2 4/6] fs: Move enum rw_hint into a new header file
Date: Fri,  2 Feb 2024 12:39:23 -0800
Message-ID: <20240202203926.2478590-5-bvanassche@acm.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202203926.2478590-1-bvanassche@acm.org>
References: <20240202203926.2478590-1-bvanassche@acm.org>
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
index d2b15351ab8e..00be0a710bba 100644
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
index 3ce900e34f52..4a953eb8b0d1 100644
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

