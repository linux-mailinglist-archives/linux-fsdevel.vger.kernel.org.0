Return-Path: <linux-fsdevel+bounces-5432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBD280BB96
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 15:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71978280EB1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Dec 2023 14:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0367215ACF;
	Sun, 10 Dec 2023 14:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+SWHWHd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460AF5
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:12 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-33338c47134so3452396f8f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 10 Dec 2023 06:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702217951; x=1702822751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1H+++gQksXiemDOFj7z8SeueCytHP3rEOoH0sYDYaI=;
        b=K+SWHWHdoTXScmkaL1yMqW26SXI6HdnA2pjEow2rca47WGVGLt2UeyUnf+IkQLDD7q
         O1VjnsKzJIuY4/yZAkvZ8HCr/fBkRy9q4GvT4fyI2EentujlMiMIFNuO+bnyc3/ukybT
         5bimlDtybMzfxuDTSek0lFNop2TGu4sW6XlWBxuIUFV4cHfB0mif3oFmrmrEfnCrJgKE
         HVXzXIquhH4+tT9gW3eM6P80kfRUUpw6nfyFPRA0jiXyX5jkB25ciz4+MQFWRohI0LKF
         i2SflPjXEeptGgOxIhjZnh9aQ6xYP4+gNuNxHIHaBdbjJSpsjBBH/neoRd68pp/AXxOa
         TF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702217951; x=1702822751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1H+++gQksXiemDOFj7z8SeueCytHP3rEOoH0sYDYaI=;
        b=NXiaZGltDyYtVVEfXWNS+b9ZVoFuiTbCPb1G8edt0gLxsxrRvaKr+vKr8uvB5KKiph
         Z/bC2JnB8Sqbb/M01IKEq17sAhffcoLRQ6aMDjy5Ba+mnSH9KLO+2q6ixE0U+sNTz0RQ
         yR5NX0jdhj6j26l+qmsC8Zh4X5Btp+97faCDlMT8XyZ6FWkyuIscOpXQaqFh7G1DaoDe
         JyAgzS0G9jO9HjzEmyZfDSBh8VDUXSGxQ5F94NWKQav6IajezmERYa2PQNMYSkNf/6ZZ
         XphrlewjP62b/ygSYlhlt0OPmXOJRIu99FB+x52vN3ac8R5hm3DxKGtBHIZF6K2Rzov0
         Xkzw==
X-Gm-Message-State: AOJu0Yx5QpSxvzQ1ForIa047F6Cwv2hFOvwf12ScI/sn3yGxB7VTmJZc
	Mlg9kYV5AozWVsfOSDCgsDc=
X-Google-Smtp-Source: AGHT+IEpsHdE/W8xJRSEcl/UW9f5gr+mk7qJX1wkwBJ/5EjcjCBZdxvbl0Ib6hkkvFXn0KzoYs3w8A==
X-Received: by 2002:a7b:c7cd:0:b0:40c:2a82:fee5 with SMTP id z13-20020a7bc7cd000000b0040c2a82fee5mr1572470wmk.114.1702217950612;
        Sun, 10 Dec 2023 06:19:10 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b004094d4292aesm9644164wmq.18.2023.12.10.06.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Dec 2023 06:19:10 -0800 (PST)
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
Subject: [PATCH v2 3/5] fsnotify: split fsnotify_perm() into two hooks
Date: Sun, 10 Dec 2023 16:18:59 +0200
Message-Id: <20231210141901.47092-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210141901.47092-1-amir73il@gmail.com>
References: <20231210141901.47092-1-amir73il@gmail.com>
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


