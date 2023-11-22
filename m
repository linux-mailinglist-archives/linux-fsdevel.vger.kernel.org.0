Return-Path: <linux-fsdevel+bounces-3412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CB37F462C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 13:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0061B212AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Nov 2023 12:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637E84D5B2;
	Wed, 22 Nov 2023 12:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abdh+8SS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25907E7
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:32 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b2fa4ec5eso5719215e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Nov 2023 04:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700656050; x=1701260850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNqg+C6s/AWVFWKCvzsE/oOnC/sOHBX/Ed/RO/DqIbE=;
        b=abdh+8SSZ+EW77FDqeTsDnXLtSsFL75Xhuoex0OprHg8vnM9ODsUX6HPcX3P9I+Fyw
         i6+jVpp2UStWONLQ6YcYOucpahnNEpgyxe0h1V7mSoEPJ4YQGk+bJLp+nGsRpnh6y3N7
         hrsgNuX58QrYFKQdw/05GbEnr5kxhAQay6+hcrmKuiRkAS0OQH4mLb44XZ5MQ35ELHVT
         i/OPKl7PiSllElXxg4lgR8laaaVv1E+Jxmc2OCD6VXO5F+lpfa3V2EpAFaQjjp8uwA48
         oUDJ0AGjfBaUbHqhWKLjk2xHcrS0265xiBHr6Mhc/yh8QTJPdKBjwP2WN/NQL858JJZS
         rWvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700656050; x=1701260850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yNqg+C6s/AWVFWKCvzsE/oOnC/sOHBX/Ed/RO/DqIbE=;
        b=j76l4PCfbrVUBjpn+64b0faW1I5uydvNVoy3FRzoveakdyJ93epxgMdQsKk/8lvZ3M
         aZP5RrzfZazULWJoj26tp014mYxhBPCOE615msYnTqFtdyXpcKHtXkX5A2M7mBHwupHL
         Hv+sxvibZ6JGU3fu0El+R65evE5ZK3tyQUA9ZqYs/Jp1c9TJ22nYmw7eewrD4FEwAQ9A
         HMnOztu45K97mNJAkAfPcSseGCLQniMW5P3sWceSdVuTjZxxy9F0KhOUr306wqdgPUr4
         bb3kmvNpiBI5AkUwxrj5b/12WnAcJMCGHoydesY8wpN/nJgbBx+IlnxzNIWyALUQpC1/
         /nEQ==
X-Gm-Message-State: AOJu0Ywb/VZfJPnWA4f6UeXNc7qbr5m+UXuOBha8sNkiwiA5NPuX317H
	uXrUuyo/bo5xLOJRrZyYwI4=
X-Google-Smtp-Source: AGHT+IGrI+gUmYJAAERfPFg/o1eSnqQ12QO0PZM7jmr9BW08V0rGgwSTPn/US8ylKQ/p0bhxfW7Rzw==
X-Received: by 2002:a05:600c:138d:b0:40b:2a85:d7ae with SMTP id u13-20020a05600c138d00b0040b2a85d7aemr1687837wmf.16.1700656050314;
        Wed, 22 Nov 2023 04:27:30 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b0040588d85b3asm2055556wmg.15.2023.11.22.04.27.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 04:27:29 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Josef Bacik <josef@toxicpanda.com>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/16] remap_range: move file_start_write() to after permission hook
Date: Wed, 22 Nov 2023 14:27:06 +0200
Message-Id: <20231122122715.2561213-8-amir73il@gmail.com>
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

In vfs code, file_start_write() is usually called after the permission
hook in rw_verify_area().  vfs_dedupe_file_range_one() is an exception
to this rule.

In vfs_dedupe_file_range_one(), move file_start_write() to after the
the rw_verify_area() checks to make them "start-write-safe".

This is needed for fanotify "pre content" events.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/remap_range.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/remap_range.c b/fs/remap_range.c
index 42f79cb2b1b1..12131f2a6c9e 100644
--- a/fs/remap_range.c
+++ b/fs/remap_range.c
@@ -420,7 +420,7 @@ loff_t vfs_clone_file_range(struct file *file_in, loff_t pos_in,
 EXPORT_SYMBOL(vfs_clone_file_range);
 
 /* Check whether we are allowed to dedupe the destination file */
-static bool allow_file_dedupe(struct file *file)
+static bool may_dedupe_file(struct file *file)
 {
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct inode *inode = file_inode(file);
@@ -445,24 +445,29 @@ loff_t vfs_dedupe_file_range_one(struct file *src_file, loff_t src_pos,
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
+
+	/*
+	 * This needs to be called after remap_verify_area() because of
+	 * sb_start_write() and before may_dedupe_file() because the mount's
+	 * MAY_WRITE need to be checked with mnt_get_write_access_file() held.
+	 */
+	ret = mnt_want_write_file(dst_file);
+	if (ret)
+		return ret;
 
 	ret = -EPERM;
-	if (!allow_file_dedupe(dst_file))
+	if (!may_dedupe_file(dst_file))
 		goto out_drop_write;
 
 	ret = -EXDEV;
-- 
2.34.1


