Return-Path: <linux-fsdevel+bounces-3411-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C667F462B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FEA3B20DEA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B916054BC6;
	Wed, 22 Nov 2023 12:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFNJ6kjA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4065392
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:40 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40859c464daso32515715e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656058; x=1701260858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rq/epNnQwlHfqFRrcdPyAqTuEwGawgUhoK0qjSLejTY=;
        b=JFNJ6kjA89Guf+TltHG45J6vAyPeYEZT2QXnt3/skMzgWTT9lDb/OTBUWYKWp/A9/T
         tpxHF7BEWRLT/6pFqJxRTYUSu03hN+7qDdR5y+RGqe4DMADT3zn3ERh6+hUWTRwIl9+I
         siZW/vMdm2NJ5dpZlF4ABtX10QDfyI4toLLxc/UC/uaURy6vq/A6LO1ZH0WN7W1/r/wM
         7Jf5DPhNXlIkhX8TGj6uX7egPdCJk3Y0B8vzqJv39hSck9rhMP0uQL+3F2gTEiuESvox
         wXRI0XZ8oKwBynl6t5zk4VX4tEtXX8KNi1VIf+kr9MdwUGouvmY1tt4ezNhxJNrV/Nck
         ImFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656058; x=1701260858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rq/epNnQwlHfqFRrcdPyAqTuEwGawgUhoK0qjSLejTY=;
        b=ETGWWwKOdEwHLRAO3JvwNPYivuhsaXCjDtltBOAFQwi7jO1LooxX9l78D7LrN2C3w+
         61vfFgDPZDd16n57egbbJ9SETdIFscSfeGcU1Yua2xqt95fVQ6jEMqmchxUVQH26R6Ak
         a8BDc8jidJngThF+635/hr0r2enQmeOymOlmgS4mcucyi8/+unio8//yCVXM4/581EiP
         7xVBRudhgxWd1gRg24uNRHYfipM1XpfZc8p6WE2Xz7Ee1J5tBIn2lu0eEuNcxP0+hneD
         RUfLhbCV/MAWrN7b600CniaPoFYe//MJmFjen1Tp8TmrAs2c8ffOju2SMlocCMmWdTff
         UKRA==
X-Gm-Message-State: AOJu0YzSqvhiWCtZOKajpWk6awJRZcRGmkzrcgwdErNeF0Nbl1NfIMSE
	yGNFBQj6lOpEBdcQgx8aCfE=
X-Google-Smtp-Source: AGHT+IGEXNxoY0fG9bhMMi9ZFOM+LW8SGzJkXDyF8TfqWHNldODOACrfQorMycLNy3SZQGFkSu2uGA==
X-Received: by 2002:a05:600c:1d0f:b0:409:c1e:7fe8 with SMTP id l15-20020a05600c1d0f00b004090c1e7fe8mr1697974wms.19.1700656058668;
        Wed, 22 Nov 2023 04:27:38 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:38 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/16] fs: move kiocb_start_write() into vfs_iocb_iter_write()
Date: Wed, 22 Nov 2023 14:27:12 +0200
Message-Id: <20231122122715.2561213-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122122715.2561213-1-amir73il@gmail.com>
References: <20231122122715.2561213-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vfs code, sb_start_write() is usually called after the permission hook
in rw_verify_area().  vfs_iocb_iter_write() is an exception to this rule,
where kiocb_start_write() is called by its callers.

Move kiocb_start_write() from the callers into vfs_iocb_iter_write()
after the rw_verify_area() checks, to make them "start-write-safe".

The semantics of vfs_iocb_iter_write() is changed, so that the caller is
responsible for calling kiocb_end_write() on completion only if async
iocb was queued.  The completion handlers of both callers were adapted
to this semantic change.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Suggested-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/io.c  | 5 ++---
 fs/overlayfs/file.c | 8 ++++----
 fs/read_write.c     | 7 +++++++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..5857241c5918 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -259,7 +259,8 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	_enter("%ld", ret);
 
-	kiocb_end_write(iocb);
+	if (ki->was_async)
+		kiocb_end_write(iocb);
 
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
@@ -319,8 +320,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	kiocb_start_write(&ki->iocb);
-
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 690b173f34fc..4e46420c8fdd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -295,10 +295,8 @@ static void ovl_aio_cleanup_handler(struct ovl_aio_req *aio_req)
 	struct kiocb *iocb = &aio_req->iocb;
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
-	if (iocb->ki_flags & IOCB_WRITE) {
-		kiocb_end_write(iocb);
+	if (iocb->ki_flags & IOCB_WRITE)
 		ovl_file_modified(orig_iocb->ki_filp);
-	}
 
 	orig_iocb->ki_pos = iocb->ki_pos;
 	ovl_aio_put(aio_req);
@@ -310,6 +308,9 @@ static void ovl_aio_rw_complete(struct kiocb *iocb, long res)
 						   struct ovl_aio_req, iocb);
 	struct kiocb *orig_iocb = aio_req->orig_iocb;
 
+	if (iocb->ki_flags & IOCB_WRITE)
+		kiocb_end_write(iocb);
+
 	ovl_aio_cleanup_handler(aio_req);
 	orig_iocb->ki_complete(orig_iocb, res);
 }
@@ -456,7 +457,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
 		refcount_set(&aio_req->ref, 2);
-		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
 		ovl_aio_put(aio_req);
 		if (ret != -EIOCBQUEUED)
diff --git a/fs/read_write.c b/fs/read_write.c
index 9410c3e6a04e..ed0ea1132cee 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -862,6 +862,10 @@ static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
 	return do_loop_readv_writev(file, iter, pos, WRITE, flags);
 }
 
+/*
+ * Caller is responsible for calling kiocb_end_write() on completion
+ * if async iocb was queued.
+ */
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter)
 {
@@ -882,7 +886,10 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
+	kiocb_start_write(iocb);
 	ret = call_write_iter(file, iocb, iter);
+	if (ret != -EIOCBQUEUED)
+		kiocb_end_write(iocb);
 	if (ret > 0)
 		fsnotify_modify(file);
 
-- 
2.34.1


