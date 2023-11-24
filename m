Return-Path: <linux-fsdevel+bounces-3671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324B67F774B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA8B9B21133
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7F32E645;
	Fri, 24 Nov 2023 15:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M28KiDy+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72CC19AB
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:08:30 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so112385e9.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 07:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700838509; x=1701443309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sqTacIZkBM4KL/AdYl8Dw+FA4agHV2/BkPGKt7BAcWM=;
        b=M28KiDy+Gby9+MAELZx3i67BI8fbKN1i5jrZjikNUjK4egRWX2whxykkuR+XaEaiNW
         emUVRGD5lOkgSEFtwHCD+MJxHSTw2NaIyEjHTJgq1KbrtxOE0zxBpaPCIY76EV8kWPJr
         fTtXMJ/JwGGJFWWJUr4/xCJbnUW56yvRIfKA+llF4Gdq0eD5AyBwMJgVHoqntTaEdSCS
         L0ElBKSXJEon3/DYfqDzXDvr/W4n3o0yEjcomEPf27aVjv1WDAE4ojrTvcqV5V5XsJiO
         TFwokQl9H2k/i+r8s76n3VLYDqg27RGB8Jgs595PmU7zSOFqyiAozUj4ls1XjGmON65V
         C1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838509; x=1701443309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqTacIZkBM4KL/AdYl8Dw+FA4agHV2/BkPGKt7BAcWM=;
        b=h+vRem9783fpyikzx+qBw7dOMRgyzO1Hx2C+87Zy0NakcUlrFlvUwxuRhoxobvQkpq
         bzChp6BUOPgL1rwY04sqUta26KItX+exjVc2IYMS81osiOVTt2L0/2Qp2lqbSUY9Oo2h
         ttsFMwHhlavrXpF9pph1Kp4vkvRHgpQgFDomylOpM7QcQyWk1yeLPn3dPpuezofxf4lz
         Xl8f09pMoDNhzcJYKTeq0r+ouRyqgwg4rhqWRNrguas5f9Zl4MUlHLyyu5GZ+NZwq2CC
         UJnUcnSbqu08ay9i19N+A0exYY95+BM91+FfUz7aZIAcMAWtIbxY4n/021G0/hHDG1x1
         CcjQ==
X-Gm-Message-State: AOJu0YydClOt6N/hM4Gh5Ket/KsAHDpTz+Oiiw7UPruuiKSRe9v5Yupn
	WHubP9P5wSw248R+O+HsCYWCrg==
X-Google-Smtp-Source: AGHT+IF+FaE0f+1RaM3ScXVe37yW5lWvWTtr3oVmLcYalt6bWltPID1hS8v0DF7lznj6zKE+jtInbA==
X-Received: by 2002:a7b:c047:0:b0:408:3725:b96a with SMTP id u7-20020a7bc047000000b004083725b96amr388616wmc.0.1700838508765;
        Fri, 24 Nov 2023 07:08:28 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:4ea2:a7ce:d5d3:86af])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c1d9000b0040b3e3eaad0sm197283wms.41.2023.11.24.07.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:08:27 -0800 (PST)
From: Jann Horn <jannh@google.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/pipe: Fix lockdep false-positive in watchqueue pipe_write()
Date: Fri, 24 Nov 2023 16:08:22 +0100
Message-ID: <20231124150822.2121798-1-jannh@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When you try to splice between a normal pipe and a notification pipe,
get_pipe_info(..., true) fails, so splice() falls back to treating the
notification pipe like a normal pipe - so we end up in
iter_file_splice_write(), which first locks the input pipe, then calls
vfs_iter_write(), which locks the output pipe.

Lockdep complains about that, because we're taking a pipe lock while
already holding another pipe lock.

I think this probably (?) can't actually lead to deadlocks, since you'd
need another way to nest locking a normal pipe into locking a
watch_queue pipe, but the lockdep annotations don't make that clear.

Bail out earlier in pipe_write() for notification pipes, before taking
the pipe lock.

Reported-and-tested-by: syzbot+011e4ea1da6692cf881c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
Fixes: c73be61cede5 ("pipe: Add general notification queue support")
Signed-off-by: Jann Horn <jannh@google.com>
---
 fs/pipe.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 804a7d789452..226e7f66b590 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -446,6 +446,18 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 	bool was_empty = false;
 	bool wake_next_writer = false;
 
+	/*
+	 * Reject writing to watch queue pipes before the point where we lock
+	 * the pipe.
+	 * Otherwise, lockdep would be unhappy if the caller already has another
+	 * pipe locked.
+	 * If we had to support locking a normal pipe and a notification pipe at
+	 * the same time, we could set up lockdep annotations for that, but
+	 * since we don't actually need that, it's simpler to just bail here.
+	 */
+	if (pipe_has_watch_queue(pipe))
+		return -EXDEV;
+
 	/* Null write succeeds. */
 	if (unlikely(total_len == 0))
 		return 0;
@@ -458,11 +470,6 @@ pipe_write(struct kiocb *iocb, struct iov_iter *from)
 		goto out;
 	}
 
-	if (pipe_has_watch_queue(pipe)) {
-		ret = -EXDEV;
-		goto out;
-	}
-
 	/*
 	 * If it wasn't empty we try to merge new data into
 	 * the last buffer.

base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.43.0.rc1.413.gea7ed67945-goog


