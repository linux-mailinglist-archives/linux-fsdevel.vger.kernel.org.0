Return-Path: <linux-fsdevel+bounces-1254-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9DB7D864B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 17:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3F7AB210DA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9111381A7;
	Thu, 26 Oct 2023 15:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7ob7iBp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAF337C9B
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Oct 2023 15:52:35 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051411AE;
	Thu, 26 Oct 2023 08:52:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-313e742a787so653396f8f.1;
        Thu, 26 Oct 2023 08:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698335552; x=1698940352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLcJhJOyMd7mTn+AJyulJNk/SJAtjQNtLr+zETSmSUk=;
        b=d7ob7iBp+JRdkuSXVjObsjh3gsXWXclyFYBLiY2Ow8eBc4qeXWJtJjZZl12z7i6mj6
         5Raw6UzbCXgrmcWpC5qeATAADhfuH4/6yYY5CnEyG3MPtGDjBK/QqaHY4AXVCheX/WOs
         l76tDoOSys1rbKjj0Ii+6+dOw98oSDCKIUVYhJ5snrBNHgW6bRAuGhdZFpqLqNo3p9SU
         +inUhVY9EfPXLVl7zc127fR9FBVqqSNZ1ZmiY/uKvJ0/3CDk0yEqGD+BjMouvtxNwDDp
         2OgzQQYda61C22ROSZNWhauX6go2qCG3UFeZS0U6VMV/8tYjSUmjPKJNgyrW1bjPX21z
         WEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335552; x=1698940352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLcJhJOyMd7mTn+AJyulJNk/SJAtjQNtLr+zETSmSUk=;
        b=K3iStKvwoQhiyzijONrp7IyC2uv4mRnHwHZxJ64L2/W+aBgZ8XdIJVYzX98s6U/ux/
         dAlcdaCNIuxpjraQQ7kQfggJZgepnB6+AQPxNADBetDODEwZfWrxayQnsshdr1czC1G/
         rrQbeDiV5qEhmsmHbfoHGJxTLYOMQkCuvQTrwTEDvI+4d142UPsnuFzFSOq0uFIyQhCc
         p4LeFyAy1Xj4aW+ZGdXZrZq0DjcI2G7nTCAsr1vtOM0tcy7kWxeAKrqJVvVkuv/jLv+8
         5QMyy20VmiB3M86lQRpMBa5Desg7juR5uwbeIR9nZrzI/T7XUEhD3vypKTaBEkNkGXIu
         C4ng==
X-Gm-Message-State: AOJu0YzOHKEns639tYesmw1XTE901nViaxsgyNUxUoAtMQqaw9KEtJ0k
	80YWa2zsaq5Rxzx7C9iPIr4=
X-Google-Smtp-Source: AGHT+IFT0ZUOtw8KUxdR6Yo9qjK3uM879HbD76Om2xdhFKe3ZI9FI72cGU2xjSDwln8iGsHAEqVCkw==
X-Received: by 2002:a05:6000:1549:b0:32d:980e:ae7 with SMTP id 9-20020a056000154900b0032d980e0ae7mr245707wry.2.1698335552361;
        Thu, 26 Oct 2023 08:52:32 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id n12-20020adfe78c000000b00326f0ca3566sm14609838wrm.50.2023.10.26.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:52:31 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/3] fanotify: report the most specific fsid for btrfs
Date: Thu, 26 Oct 2023 18:52:23 +0300
Message-Id: <20231026155224.129326-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026155224.129326-1-amir73il@gmail.com>
References: <20231026155224.129326-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With btrfs, a marked inode and marked sb may have a different fsid.
If both inode and sb are marked with a specific event type in mask,
report the more specific fsid (i.e. of the inode) in the event.

This is needed to support fanotify marks in btrfs sub-volumes.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 2 ++
 include/linux/fsnotify_backend.h | 5 +++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index aff1ab3c32aa..3053606d7ff5 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -840,6 +840,8 @@ static struct fanotify_event *fanotify_alloc_event(
 /*
  * Get cached fsid of the filesystem containing the object from any mark.
  * All marks are supposed to have the same fsid, but we do not verify that here.
+ * With btrfs, a marked inode and marked sb may have a different fsid.
+ * In this case, we will return the more specific fsid (i.e. of the inode).
  */
 static __kernel_fsid_t fanotify_get_fsid(struct fsnotify_iter_info *iter_info)
 {
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index a80b525ca653..f329375bef22 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -372,13 +372,14 @@ static inline struct fs_error_report *fsnotify_data_error_report(
  * the other way around, because an event can match different watched objects
  * of the same object type.
  * For example, both parent and child are watching an object of type inode.
+ * The order of iteration is from most specific (inode) to most general (sb).
  */
 enum fsnotify_iter_type {
 	FSNOTIFY_ITER_TYPE_INODE,
+	FSNOTIFY_ITER_TYPE_INODE2,
+	FSNOTIFY_ITER_TYPE_PARENT,
 	FSNOTIFY_ITER_TYPE_VFSMOUNT,
 	FSNOTIFY_ITER_TYPE_SB,
-	FSNOTIFY_ITER_TYPE_PARENT,
-	FSNOTIFY_ITER_TYPE_INODE2,
 	FSNOTIFY_ITER_TYPE_COUNT
 };
 
-- 
2.34.1


