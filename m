Return-Path: <linux-fsdevel+bounces-2835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3DA7EB3CD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D848B20BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF25F41AA2;
	Tue, 14 Nov 2023 15:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RrHJ3Soo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6F41A96
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:45 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D55182
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:43 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-408425c7c10so46870575e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976022; x=1700580822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkFHZx+vlTxfUH8YeTgoGB/M3KXXCxOMDvqz9lQaF+E=;
        b=RrHJ3SooGDCZYtLS50W9ysYhrSK4cmfPtKFuzSrWs+kr8MnjVkWhLnCDliaakKBPgs
         SuakNevZmjukXpAbPr8INXR5wLGwmu2mIpPx4ztWAZ8ESqa3fDlHpqHNSej/P3ntOrcx
         +ha2698CnNu6EfMGqdfmhdZiWykuQnGuHYnbGTlbPLo5MhWIi2VuMC+ngCO0nBR+aA7t
         JVtGp0MrvDPKMi+Iw/bcymWEo5XUy591+QexXitjulJxWoS8WH0ECDSro2nTzS6AKiS2
         Gp6x2nCMnqt6KNugVrDmBxnOkcMeoGiOW79UyAsqDuhNvvs6UUA10qAHa2JKWNOR1eWy
         chmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976022; x=1700580822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkFHZx+vlTxfUH8YeTgoGB/M3KXXCxOMDvqz9lQaF+E=;
        b=ZFx0yVPYUxssbWteTcOmwzbcA8fbunQyUMptUxuLV+rHL1sCxlh0gnMWAtGCjusAkD
         03xYaJYbMs++PPItRgNRzLYerrdv0jI5ztzDq7/j3qJdmKrB2fchP/U5+LJ+a5xHOSUw
         /4fBuC/AnuuvVzIgjrErE0y/oae+RK83MnmLRKLTRy6WwYWD/jolb85YetedmMrryOPJ
         Ky5PI8lU9qpS0JKUy5vQwXSHUnQogp56i6X3V8YpdeL1s49AtaAstv6AxfnYKtv6AOkx
         wIK3mYhxHnHbKnAItaq4DJLaLFs0sgy/gTJHt8H7HZYapz8bia+z4gNBBSs2vIYgdu9r
         4vFw==
X-Gm-Message-State: AOJu0Ywl7K26Kvms41AnNbHCWBjRfjPafFVoyLQjhupqRAu6XzEnPc73
	6+XQAC2Zyn8o0saZbn4km6CJthSfEuo=
X-Google-Smtp-Source: AGHT+IHpj2wUKyfifMigenv3FXtIY1AlBI2ZPubgC+6V16eBEwMGtobjEJGaWnA/c48nAdFfuos23g==
X-Received: by 2002:a05:600c:3b8d:b0:408:3c8a:65ec with SMTP id n13-20020a05600c3b8d00b004083c8a65ecmr8002386wms.8.1699976022454;
        Tue, 14 Nov 2023 07:33:42 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:42 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/15] fs: move kiocb_start_write() into vfs_iocb_iter_write()
Date: Tue, 14 Nov 2023 17:33:18 +0200
Message-Id: <20231114153321.1716028-13-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231114153321.1716028-1-amir73il@gmail.com>
References: <20231114153321.1716028-1-amir73il@gmail.com>
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

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/cachefiles/io.c  | 2 --
 fs/overlayfs/file.c | 1 -
 fs/read_write.c     | 2 ++
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 009d23cd435b..3d3667807636 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -319,8 +319,6 @@ int __cachefiles_write(struct cachefiles_object *object,
 		ki->iocb.ki_complete = cachefiles_write_complete;
 	atomic_long_add(ki->b_writing, &cache->b_writing);
 
-	kiocb_start_write(&ki->iocb);
-
 	get_file(ki->iocb.ki_filp);
 	cachefiles_grab_object(object, cachefiles_obj_get_ioreq);
 
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 690b173f34fc..2adf3a5641cd 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -456,7 +456,6 @@ static ssize_t ovl_write_iter(struct kiocb *iocb, struct iov_iter *iter)
 		aio_req->iocb.ki_flags = ifl;
 		aio_req->iocb.ki_complete = ovl_aio_queue_completion;
 		refcount_set(&aio_req->ref, 2);
-		kiocb_start_write(&aio_req->iocb);
 		ret = vfs_iocb_iter_write(real.file, &aio_req->iocb, iter);
 		ovl_aio_put(aio_req);
 		if (ret != -EIOCBQUEUED)
diff --git a/fs/read_write.c b/fs/read_write.c
index 5b18e13c2620..8d381929701c 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -854,6 +854,7 @@ static ssize_t do_iter_write(struct file *file, struct iov_iter *iter,
 		return do_loop_readv_writev(file, iter, pos, WRITE, flags);
 }
 
+/* Caller is responsible for calling kiocb_end_write() on completion */
 ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 			    struct iov_iter *iter)
 {
@@ -874,6 +875,7 @@ ssize_t vfs_iocb_iter_write(struct file *file, struct kiocb *iocb,
 	if (ret < 0)
 		return ret;
 
+	kiocb_start_write(iocb);
 	ret = call_write_iter(file, iocb, iter);
 	if (ret > 0)
 		fsnotify_modify(file);
-- 
2.34.1


