Return-Path: <linux-fsdevel+bounces-3308-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C57F2E3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 14:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0707B21B99
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Nov 2023 13:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3727151C21;
	Tue, 21 Nov 2023 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnPS0dTa"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F05E1BC
	for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 05:25:59 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50aab0ca90aso3439655e87.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Nov 2023 05:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700573157; x=1701177957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFGrAMezllK01D5ucmzgr62w0XgeJ/fCV47eFgAyrF4=;
        b=LnPS0dTaUfFyBO7wqseZduolxlhCN4xaGb1qI5LIfoGO4w3SVSD4qffBRuiYpSzUxJ
         jMvjHZTEkngjPVYnbiEapZfi6gqXoBgRvDG3XvUH0P+ee0/rH3zrWluGpBEId8myx8sd
         z8Pzdo5JDJtgm5Sqd+2JEtWehOcOKPc11nQZf9qTRlyswkoAT7wD3JPb/XCH6IDUd7wq
         pEo9hj9zjM4IvC85g9V/kFz9WRR8vZnHjGsdMI4Ij6qWv/Zz7GLN0AdJMMFutnT5S5Aj
         MijKwIcXru1vx1P9X5U/AGiCv8/JRnIWYqEQiOlp73dc+LDsgDNWsz3ij0cOCaP0h5Xp
         7o7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700573157; x=1701177957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FFGrAMezllK01D5ucmzgr62w0XgeJ/fCV47eFgAyrF4=;
        b=RQemCOX14oF5tpWEfg5D0odM0a5kIk+joquc9CzssEn/IcTb2FHomVXczgWZEKntIo
         9/2Nd0sqciMHfBNt/1uY2sT7Kaax30h1v037nZFcNlp450xjiCeR13793wN0uomqWakn
         lEguXXq+HFW/u/13Y9052bU1zTSb8FVpN6ejZHLl9B452f9Gg4MbX5iOdIMjvkh/ctL1
         aopLSte1jhZEVqfdNMT/aUYhbWMQkqeJ9oFcBlCgOXBzpi7S5ezcK6QNaaEjin6pYlvL
         3TtH8BKMqf7EU7sNTlsCUKDs0brv4YA2jH2euDQRmfWiyJdfVdDJPmDDbl0Jwsuy2K7s
         ioxw==
X-Gm-Message-State: AOJu0YwUk30JDmmDeBzJgr7e1KPYbBt44XHnR0fsrB8SCKuUQF7fQFEw
	91xIxyL+1+We5869g82a++s=
X-Google-Smtp-Source: AGHT+IG5xs+5KHGaAQRCpgX9wJ3yc7nrDwA0wzRgcw+gpQiQyWdP+hVpPR5vJ6VbIjp07huJbCnCDw==
X-Received: by 2002:a05:6512:128d:b0:507:9a00:d6c7 with SMTP id u13-20020a056512128d00b005079a00d6c7mr8595492lfs.33.1700573157154;
        Tue, 21 Nov 2023 05:25:57 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id j7-20020a05600c190700b004064cd71aa8sm17217672wmq.34.2023.11.21.05.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:25:56 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs: allow calling kiocb_end_write() unmatched with kiocb_start_write()
Date: Tue, 21 Nov 2023 15:25:51 +0200
Message-Id: <20231121132551.2337431-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We want to move kiocb_start_write() into vfs_iocb_iter_write(), after
the permission hook, but leave kiocb_end_write() in the write completion
handler of the callers of vfs_iocb_iter_write().

After this change, there will be no way of knowing in completion handler,
if write has failed before or after calling kiocb_start_write().

Add a flag IOCB_WRITE_STARTED, which is set and cleared internally by
kiocb_{start,end}_write(), so that kiocb_end_write() could be called for
cleanup of async write, whether it was successful or whether it failed
before or after calling kiocb_start_write().

This flag must not be copied by stacked filesystems (e.g. overlayfs)
that clone the iocb to another iocb for io request on a backing file.

Link: https://lore.kernel.org/r/CAOQ4uxihfJJRxxUhAmOwtD97Lg8PL8RgXw88rH1UfEeP8AtP+w@mail.gmail.com/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jens,

The kiocb_{start,end}_write() helpers were originally taken out of
an early version of the permission hooks cleanup patches [1].

This early version of the helpers had the IOCB_WRITE_STARTED flag, but
when I posted the helpers independently from the cleanup series, you had
correctly pointed out [2] that IOCB_WRITE_STARTED is not needed for any
of the existing callers of kiocb_{start,end}_write(), so I removed it for
the final version of the helpers that got merged.

When coming back to the permission hook cleanup, I see that the
IOCB_WRITE_STARTED flag is needed to allow the new semantics of calling
kiocb_start_write() inside vfs_iocb_iter_write() and kiocb_end_write()
in completion callback.

I realize these semantics are not great, but the alternative of moving
the permission hook from vfs_iocb_iter_write() into all the callers is
worse IMO.

Can you accept the solution with IOCB_WRITE_STARTED state flag?
Have a better idea for cleaner iocb issue semantics that will allow
calling the permission hook with freeze protection held?

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/20231114153321.1716028-1-amir73il@gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/e6948836-1d9d-4219-9a21-a2ab442a9a34@kernel.dk/

 fs/overlayfs/file.c |  2 +-
 include/linux/fs.h  | 18 ++++++++++++++++--
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 131621daeb13..e4baa4ea5c95 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -455,7 +455,7 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 		aio_req->orig_iocb = iocb;
 		kiocb_clone(&aio_req->iocb, iocb, get_file(real.file));
-		aio_req->iocb.ki_flags = ifl;
+		aio_req->iocb.ki_flags &= ifl;
 		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
 		refcount_set(&aio_req->ref, 2);
 		kiocb_start_write(&aio_req->iocb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 98b7a7a8c42e..64414e146e1e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -352,6 +352,8 @@ enum rw_hint {
  * unrelated IO (like cache flushing, new IO generation, etc).
  */
 #define IOCB_DIO_CALLER_COMP	(1 << 22)
+/* file_start_write() was called */
+#define IOCB_WRITE_STARTED	(1 << 23)
 
 /* for use in trace events */
 #define TRACE_IOCB_STRINGS \
@@ -366,7 +368,8 @@ enum rw_hint {
 	{ IOCB_WAITQ,		"WAITQ" }, \
 	{ IOCB_NOIO,		"NOIO" }, \
 	{ IOCB_ALLOC_CACHE,	"ALLOC_CACHE" }, \
-	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }
+	{ IOCB_DIO_CALLER_COMP,	"CALLER_COMP" }, \
+	{ IOCB_WRITE_STARTED,	"WRITE_STARTED" }
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -2183,12 +2186,15 @@ static inline void init_sync_kiocb(struct kiocb *kiocb, struct file *filp)
 	};
 }
 
+/* IOCB flags associated with ki_filp state must not be cloned */
+#define IOCB_CLONE_FLAGS_MASK	(~IOCB_WRITE_STARTED)
+
 static inline void kiocb_clone(struct kiocb *kiocb, struct kiocb *kiocb_src,
 			       struct file *filp)
 {
 	*kiocb = (struct kiocb) {
 		.ki_filp = filp,
-		.ki_flags = kiocb_src->ki_flags,
+		.ki_flags = kiocb_src->ki_flags & IOCB_CLONE_FLAGS_MASK,
 		.ki_ioprio = kiocb_src->ki_ioprio,
 		.ki_pos = kiocb_src->ki_pos,
 	};
@@ -2744,12 +2750,16 @@ static inline void kiocb_start_write(struct kiocb *iocb)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
+	if (WARN_ON_ONCE(iocb->ki_flags & IOCB_WRITE_STARTED))
+		return;
+
 	sb_start_write(inode->i_sb);
 	/*
 	 * Fool lockdep by telling it the lock got released so that it
 	 * doesn't complain about the held lock when we return to userspace.
 	 */
 	__sb_writers_release(inode->i_sb, SB_FREEZE_WRITE);
+	iocb->ki_flags |= IOCB_WRITE_STARTED;
 }
 
 /**
@@ -2762,11 +2772,15 @@ static inline void kiocb_end_write(struct kiocb *iocb)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
+	if (!(iocb->ki_flags & IOCB_WRITE_STARTED))
+		return;
+
 	/*
 	 * Tell lockdep we inherited freeze protection from submission thread.
 	 */
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 	sb_end_write(inode->i_sb);
+	iocb->ki_flags &= ~IOCB_WRITE_STARTED;
 }
 
 /*
-- 
2.34.1


