Return-Path: <linux-fsdevel+bounces-2831-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201397EB3C8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429821C20AD3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1441A93;
	Tue, 14 Nov 2023 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSWHdgjK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B241A82
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:38 +0000 (UTC)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EF6D40
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:37 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32da9ef390fso3684517f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976015; x=1700580815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iUDFGsO/+8YjOBlEcGZTYITE7ntldQEt+ZaUoKpjOc=;
        b=CSWHdgjKnbuSwcS9rQOYakZ/pvYqBL7wYm/S2DTyS5yZZxmnZplNDNUGZlPFKCSSDA
         4nDgXA0FAcn2V8uKgD/WpXSq8QagxfngPZZjTIfIHaqHyk8TxV0Cbw5j6Cm6fDr+bBes
         gBYYkBzsxeTlExMEnOMC1LAbDanZCAunUUKSdt0aTKqK1/Ryz8mrN8ZpQbCwlYimbs68
         U/UozNaFnVzvhRycqySi9vuP3TwK2wg8nMZUSgDOuys6g6y+0AoRIoaFAkT+VWx9IaLu
         Cx9jFEK6eI301z0InA8XBMcHl5cs66x064MpYGI/gtugRPGPD/TAp3/+tvD6jpfHY8LD
         Ak+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976015; x=1700580815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iUDFGsO/+8YjOBlEcGZTYITE7ntldQEt+ZaUoKpjOc=;
        b=UDhIeCSGy1N7uQ7evP6Ycm3s/Joyaf5qrl6m6qe0c1Ctxz5Sg88BR/YUtgKtUnRUCw
         SU8RrcEKX7WnILb+UfE3zzi/u7gdtfmLSvHbrbrIL5rqWQCKS7S/K6+AWJPLy5XtFxuW
         tf9/tOK3xTnRMUa98YMj/Yl695/V7X5N9VB88ViJadGMGfNjfkAe80Oj9M4BX++5Rpxa
         xaGSfAXLRwZjrb2Co+pr1jTzv83xG6tkCodC2MsLOHhHWqbFxF+jab19zGTc9WNABRKP
         An6NOGPtB523JuClmVzf/Q7f94/aJAgbjUAg2A7RPbXla37lJhI8wNt6yyw5ZofZU1M3
         7wTw==
X-Gm-Message-State: AOJu0YzuJaxB2ZlhFrhVwyp5ktyFnW/nmTRfcVa0MSBY/EOfwiqxKp62
	Hh0eElR/ay2Kl3w2UVzKKJEnGJ0Q9w0=
X-Google-Smtp-Source: AGHT+IHxpld7SgoEEJ9lycz0UhiH9UAOUCT6NXWUm0BX06pwWtPKQzf2QmIQTKAgMkir3Q4AI9aqLw==
X-Received: by 2002:adf:f0ce:0:b0:32f:7c6c:aa18 with SMTP id x14-20020adff0ce000000b0032f7c6caa18mr7233461wro.38.1699976015675;
        Tue, 14 Nov 2023 07:33:35 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:35 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/15] remap_range: move file_start_write() to after permission hook
Date: Tue, 14 Nov 2023 17:33:13 +0200
Message-Id: <20231114153321.1716028-8-amir73il@gmail.com>
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

In vfs code, file_start_write() is usually called after the permission
hook in rw_verify_area().  vfs_dedupe_file_range_one() is an exception
to this rule.

In vfs_dedupe_file_range_one(), move file_start_write() to after the
the rw_verify_area() checks to make them "start-write-safe".

This is needed for fanotify "pre content" events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/remap_range.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 42f79cb2b1b1..de4b09d0ba1d 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -445,46 +445,40 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
 	WARN_ON_ONCE(remap_flags & ~(REMAP_FILE_DEDUP |
 				     REMAP_FILE_CAN_SHORTEN));
 
-	ret = mnt_want_write_file(dst_file);
-	if (ret)
-		return ret;
-
 	/*
 	 * This is redundant if called from vfs_dedupe_file_range(), but other
 	 * callers need it and it's not performance sesitive...
 	 */
 	ret = remap_verify_area(src_file, src_pos, len, false);
 	if (ret)
-		goto out_drop_write;
+		return ret;
 
 	ret = remap_verify_area(dst_file, dst_pos, len, true);
 	if (ret)
-		goto out_drop_write;
+		return ret;
 
-	ret = -EPERM;
 	if (!allow_file_dedupe(dst_file))
-		goto out_drop_write;
+		return -EPERM;
 
-	ret = -EXDEV;
 	if (file_inode(src_file)->i_sb != file_inode(dst_file)->i_sb)
-		goto out_drop_write;
+		return -EXDEV;
 
-	ret = -EISDIR;
 	if (S_ISDIR(file_inode(dst_file)->i_mode))
-		goto out_drop_write;
+		return -EISDIR;
 
-	ret = -EINVAL;
 	if (!dst_file->f_op->remap_file_range)
-		goto out_drop_write;
+		return -EINVAL;
 
-	if (len == 0) {
-		ret = 0;
-		goto out_drop_write;
-	}
+	if (len == 0)
+		return 0;
+
+	ret = mnt_want_write_file(dst_file);
+	if (ret)
+		return ret;
 
 	ret = dst_file->f_op->remap_file_range(src_file, src_pos, dst_file,
 			dst_pos, len, remap_flags | REMAP_FILE_DEDUP);
-out_drop_write:
+
 	mnt_drop_write_file(dst_file);
 
 	return ret;
-- 
2.34.1


