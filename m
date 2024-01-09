Return-Path: <linux-fsdevel+bounces-7630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36128289B7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 17:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B3B1F256F5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jan 2024 16:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66339FFD;
	Tue,  9 Jan 2024 16:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WO1iXOJK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2407439FF5
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jan 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7bed82030faso4954339f.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jan 2024 08:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1704816522; x=1705421322; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dto5dKPBkhAZHfrtKkeN1Jtug3TkkLBkKMTv1f7JbmQ=;
        b=WO1iXOJK2Rg9E1rdrV/2CrEJXBEQYTiq2cle4I4iCSvh/mdISv/tpvVVGijOXEfKMU
         jztEG8u2ng7EyH+7Rcd702Ir4RJIp5WA2M95MCnKNeY5aeZjiOrkNy6EDpMs8gFf7Fuj
         HsryUL9i7cTXqvySQAAdns28L10r1ZTRH/Nc7MKISPKF50Vr8zhXAR5xOHmNlnQt8Aqy
         dVOUAN5+REiOXiVnaKvUpLfEu8f8ezhRlEcN4EzQv5mkQmOv9gEYH++dUc7OTAHLtq9O
         cDbjSLXSd5faL0B3Q4TBAy4MZXNZI34o9d/90ezHfB7lL+EtaPhLC1pfpf7WsheauY/2
         7xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704816522; x=1705421322;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dto5dKPBkhAZHfrtKkeN1Jtug3TkkLBkKMTv1f7JbmQ=;
        b=jxsTCLTXb94lE24btWRz42vVYO8j+RsjlDPqdhf94wKyiKNIWbLnOqvEQBG17GAZCK
         wZdVjxBvtPCwBC6onTp6wW4wymyPYFEy1RvCnHEA5jkEnbD9pmdF/yUoxAaamdswZNFl
         qHPt298Hk17nAGNhchgio0hiMvoLSS/PiPRdVF/s5+mRB6rgiuzaGu2mcn/wAy9/RyMc
         XsZ9T/gepr6jRH+6Aa1pTGYJbIx6lwZrgwx7cW0UKq51JKQdhZjno8EuQIurEh9cLPPg
         RB68NJiRoCeFwK8OnEi1r9EGjPFHnPcfmDLvGfwCD0qgJCrSQwB/DLiZ8GOtJzvSd8s3
         ICnw==
X-Gm-Message-State: AOJu0YygmlvJi4Kxn3VffyAip0KaKlpq9fiKzSEsfextji2LHvt6mOVT
	3YbrjoEiM4jS8ReiY2E+NF1br5/4KvjuNqs3jC0yo8GFR5DJEg==
X-Google-Smtp-Source: AGHT+IGiEDIousSDmrQ9aUB599j7OKMRB59G2Xc4NCaX45cSac0080fq3ZHkjnmJlzQlPAtVAfEazA==
X-Received: by 2002:a5e:da4b:0:b0:7be:d855:4893 with SMTP id o11-20020a5eda4b000000b007bed8554893mr2980531iop.2.1704816522121;
        Tue, 09 Jan 2024 08:08:42 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id w18-20020a029692000000b0046933b23d11sm706534jai.51.2024.01.09.08.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 08:08:41 -0800 (PST)
Message-ID: <53682ece-f0e7-48de-9a1c-879ee34b0449@kernel.dk>
Date: Tue, 9 Jan 2024 09:08:40 -0700
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christian Brauner <brauner@kernel.org>,
 Amir Goldstein <amir73il@gmail.com>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] Revert "fsnotify: optionally pass access range in file
 permission hooks"
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This reverts commit d9e5d31084b024734e64307521414ef0ae1d5333.

This commit added an extra fsnotify call from rw_verify_area(), which
can be a very hot path. In my testing, this adds roughly 5-6% extra
overhead per IO, which is quite a lot. As a result, throughput of
said test also drops by 5-6%, as it is CPU bound. Looking at perf,
it's apparent why:

     3.36%             [kernel.vmlinux]  [k] fsnotify
     2.32%             [kernel.vmlinux]  [k] __fsnotify_paren

which directly correlates with performance lost.

As the rationale for this patch isn't very strong, revert this commit
for now and reclaim the performance.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/open.c                |  4 ----
 fs/read_write.c          | 10 ++--------
 fs/readdir.c             |  4 ----
 fs/remap_range.c         |  8 +-------
 include/linux/fsnotify.h | 13 ++-----------
 security/security.c      |  8 +++++++-
 6 files changed, 12 insertions(+), 35 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index a84d21e55c39..f4f157405d1e 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -304,10 +304,6 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		return ret;
 
-	ret = fsnotify_file_area_perm(file, MAY_WRITE, &offset, len);
-	if (ret)
-		return ret;
-
 	if (S_ISFIFO(inode->i_mode))
 		return -ESPIPE;
 
diff --git a/fs/read_write.c b/fs/read_write.c
index d4c036e82b6c..e3abf603eaaf 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -354,9 +354,6 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 
 int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
 {
-	int mask = read_write == READ ? MAY_READ : MAY_WRITE;
-	int ret;
-
 	if (unlikely((ssize_t) count < 0))
 		return -EINVAL;
 
@@ -374,11 +371,8 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
 		}
 	}
 
-	ret = security_file_permission(file, mask);
-	if (ret)
-		return ret;
-
-	return fsnotify_file_area_perm(file, mask, ppos, count);
+	return security_file_permission(file,
+				read_write == READ ? MAY_READ : MAY_WRITE);
 }
 EXPORT_SYMBOL(rw_verify_area);
 
diff --git a/fs/readdir.c b/fs/readdir.c
index 278bc0254732..c8c46e294431 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -96,10 +96,6 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
-	res = fsnotify_file_perm(file, MAY_READ);
-	if (res)
-		goto out;
-
 	res = down_read_killable(&inode->i_rwsem);
 	if (res)
 		goto out;
diff --git a/fs/remap_range.c b/fs/remap_range.c
index f8c1120b8311..12131f2a6c9e 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -102,9 +102,7 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
 static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 			     bool write)
 {
-	int mask = write ? MAY_WRITE : MAY_READ;
 	loff_t tmp;
-	int ret;
 
 	if (unlikely(pos < 0 || len < 0))
 		return -EINVAL;
@@ -112,11 +110,7 @@ static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
 	if (unlikely(check_add_overflow(pos, len, &tmp)))
 		return -EINVAL;
 
-	ret = security_file_permission(file, mask);
-	if (ret)
-		return ret;
-
-	return fsnotify_file_area_perm(file, mask, &pos, len);
+	return security_file_permission(file, write ? MAY_WRITE : MAY_READ);
 }
 
 /*
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 11e6434b8e71..0a9d6a8a747a 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -101,10 +101,9 @@ static inline int fsnotify_file(struct file *file, __u32 mask)
 }
 
 /*
- * fsnotify_file_area_perm - permission hook before access to file range
+ * fsnotify_file_perm - permission hook before file access
  */
-static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
-					  const loff_t *ppos, size_t count)
+static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	__u32 fsnotify_mask = FS_ACCESS_PERM;
 
@@ -121,14 +120,6 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_file(file, fsnotify_mask);
 }
 
-/*
- * fsnotify_file_perm - permission hook before file access
- */
-static inline int fsnotify_file_perm(struct file *file, int perm_mask)
-{
-	return fsnotify_file_area_perm(file, perm_mask, NULL, 0);
-}
-
 /*
  * fsnotify_open_perm - permission hook before file open
  */
diff --git a/security/security.c b/security/security.c
index 2a7fc7881cbc..d7f3703c5905 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2580,7 +2580,13 @@ int security_kernfs_init_security(struct kernfs_node *kn_dir,
  */
 int security_file_permission(struct file *file, int mask)
 {
-	return call_int_hook(file_permission, 0, file, mask);
+	int ret;
+
+	ret = call_int_hook(file_permission, 0, file, mask);
+	if (ret)
+		return ret;
+
+	return fsnotify_file_perm(file, mask);
 }
 
 /**
-- 
2.43.0

-- 
Jens Axboe


