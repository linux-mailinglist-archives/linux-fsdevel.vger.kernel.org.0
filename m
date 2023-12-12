Return-Path: <linux-fsdevel+bounces-5644-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B04BA80E806
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AE53281FF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA355915D;
	Tue, 12 Dec 2023 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvQLVKnT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F4BD2
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:51 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-336346769faso183587f8f.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374290; x=1702979090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1H+++gQksXiemDOFj7z8SeueCytHP3rEOoH0sYDYaI=;
        b=GvQLVKnTbibcx/Aoia5B6ENWVgAg5xvg9tTpNYOj98hrj6URYFnfccUkfyTTZWNu2S
         ZnIrNU4GaoeavY+lKlq4CKS9BIszlXhdHyiN9orDwtPc5v9MC3cfjd4xmwanphW8ZFy2
         R+CU1++OX0GCeI8sE8Qlfz3P6T9CJntBdkYCoKhIu08dH9+FkWnGx2MPrItixm3TD9Go
         +0NAf+jFzWV/PDT7R9KCNMf09gYunyBR1xTVaDz4bJ/HRcLn+8U37vcKXxv8vnc1NKy+
         QVzeNJbIQEpInjpW0rxljI1573SJ6AkoYcdazc11SKw+IZxp/2ItDBwrsoPHkRwMBow6
         lv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374290; x=1702979090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1H+++gQksXiemDOFj7z8SeueCytHP3rEOoH0sYDYaI=;
        b=wib+6qxmb+48AofQs5OIg2VHCMUxjXIypbtLuWl2sgEV7/C6m0TyGNvn8asz5NRpwx
         1izjym2Hfq/Qa41I9weiBN5FHQn0PTHBM0PjUpYJlSoYDK9PzqyVEzjvJPBXsYDkCJ5e
         uoGKb41fsA7xkOocWgXJEOEH2kLC9ag3xUAUtxteYwnvQoPbCOvgtEpZLPOOAse9JS2g
         Vp5dZc3aIqQD5FrsdJKVajgWJoJASsnQDgJVOQj0jB1gIjGAfOBkW54TqjC1IdwaEUds
         VPiiO4RoZ8zWM0vZ6Gex2rih8746EFVbSvV+XH4j1DG+QTNKtSZK5m9lxVR3bhjq9SeO
         llBw==
X-Gm-Message-State: AOJu0Yze/kJErhd68bnrrU842MF0FzcgjyPdnULU9pZ56iUX4rmgcfcY
	nByvy0Drkq6A9MmO7fyJVuY=
X-Google-Smtp-Source: AGHT+IEMB4m9hnecMAeBG5DfSFAmdxsyCoe5zRQ7Q4UvCCbF89envqaYWQ+TaOt2Ek6FS8mYdccz8g==
X-Received: by 2002:a05:600c:2154:b0:40c:246c:bd84 with SMTP id v20-20020a05600c215400b0040c246cbd84mr2949512wml.9.1702374289459;
        Tue, 12 Dec 2023 01:44:49 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:49 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 3/5] fsnotify: split fsnotify_perm() into two hooks
Date: Tue, 12 Dec 2023 11:44:38 +0200
Message-Id: <20231212094440.250945-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We would like to make changes to the fsnotify access permission hook -
add file range arguments and add the pre modify event.

In preparation for these changes, split the fsnotify_perm() hook into
fsnotify_open_perm() and fsnotify_file_perm().

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 34 +++++++++++++++++++---------------
 security/security.c      |  4 ++--
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bcb6609b54b3..926bb4461b9e 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -100,29 +100,33 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
 }
 
-/* Simple call site for access decisions */
-static inline int fsnotify_perm(struct file *file, int mask)
+/*
+ * fsnotify_file_perm - permission hook before file access
+ */
+static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
-	int ret;
-	__u32 fsnotify_mask = 0;
+	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
-	if (!(mask & (MAY_READ | MAY_OPEN)))
+	if (!(perm_mask & MAY_READ))
 		return 0;
 
-	if (mask & MAY_OPEN) {
-		fsnotify_mask = FS_OPEN_PERM;
+	return fsnotify_file(file, fsnotify_mask);
+}
 
-		if (file->f_flags & __FMODE_EXEC) {
-			ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
+/*
+ * fsnotify_open_perm - permission hook before file open
+ */
+static inline int fsnotify_open_perm(struct file *file)
+{
+	int ret;
 
-			if (ret)
-				return ret;
-		}
-	} else if (mask & MAY_READ) {
-		fsnotify_mask = FS_ACCESS_PERM;
+	if (file->f_flags & __FMODE_EXEC) {
+		ret = fsnotify_file(file, FS_OPEN_EXEC_PERM);
+		if (ret)
+			return ret;
 	}
 
-	return fsnotify_file(file, fsnotify_mask);
+	return fsnotify_file(file, FS_OPEN_PERM);
 }
 
 /*
diff --git a/security/security.c b/security/security.c
index dcb3e7014f9b..d7f3703c5905 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2586,7 +2586,7 @@ int security_file_permission(struct file *file, int mask)
 	if (ret)
 		return ret;
 
-	return fsnotify_perm(file, mask);
+	return fsnotify_file_perm(file, mask);
 }
 
 /**
@@ -2837,7 +2837,7 @@ int security_file_open(struct file *file)
 	if (ret)
 		return ret;
 
-	return fsnotify_perm(file, MAY_OPEN);
+	return fsnotify_open_perm(file);
 }
 
 /**
-- 
2.34.1


