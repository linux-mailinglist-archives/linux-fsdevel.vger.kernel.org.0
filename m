Return-Path: <linux-fsdevel+bounces-4409-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE7087FF24E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 15:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765B0B21283
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90C751008
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Nov 2023 14:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc5wX1QN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AE0D46
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:35 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50abb83866bso1462193e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Nov 2023 06:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701353794; x=1701958594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4zorHEebWLJdjFEnJ2k5vavEBRd5jukjgWScVFJSG8=;
        b=hc5wX1QN0RWW9it54iI8YkFnzyRtu8lelB48e5/4RZuibvNge7M/yWtIJOMopOG1xW
         FCTIbfgHwMKkorkVzaNkNB+mMe2n3dhITk/L+58qn4KoF3psH1Pjn+1gMitIvE5qNXaL
         x2G1ECwGXteIvJK9GHiAdvobj9MFfI2m8Uo63/i4cwpNbJ2WqYNDuqv1SRv8zd8/a3ug
         5e2LjoqGBvhMuQmwleFaOsQo9ZtZmNUi8R/VWbHb5/RDy6afuxSxP0ouKCsjFAqaonD3
         A53VHIZ9tn+Cpda0GKaeqieIdY6KIdXDbrj+Fm0Ju/cnBFj6qmRBPmf3G7J7hCsT3tLG
         Zw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353794; x=1701958594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4zorHEebWLJdjFEnJ2k5vavEBRd5jukjgWScVFJSG8=;
        b=Qo9iPyabrSDrsVKnrRpmCRzvG52Grf0i3DLKLCL3cwzYDc3sotEb2HnnNUe5RM5A5d
         jzrrnhW9LMV6sKbF6ygPQTnkpsp6CsCs95VvueRTeq2cDldIqC58YKZHAPheTyVeFj8V
         h/dG6MNvXKZvGuNNDYS5zCbw9ru1ZaRW8w0txYU8aW/hkTVBj/Y2RJbg0NugTmsYxlJb
         EGhggCqxtudX8opnlCbAWUdJqGY8iIKIfqhzZluheZkh7D6J9f38JfEq/ux1QF7ZrjsK
         Z/O1BrwabHYgF1GNWPL45kOP9YzJ7UDBsBzuYIC7NfCuIjXYgBFAzj1VK1+WjRMUtrzC
         nqVQ==
X-Gm-Message-State: AOJu0YwLw1rDshIXbnDs4zcd2ewIHvkM3HJfFB9nQku7+amA4lainap/
	B0w+AcJDY+PQntRSvfY/DII=
X-Google-Smtp-Source: AGHT+IE/4NwC609kTh5n+0g6loLI+CEb+e9FdatW4+FWyCbQT+ineWsYHEEEVAdBDfwWKtBWPA2wQg==
X-Received: by 2002:a05:6512:108c:b0:507:9f4c:b72 with SMTP id j12-20020a056512108c00b005079f4c0b72mr17231164lfg.15.1701353793705;
        Thu, 30 Nov 2023 06:16:33 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id g16-20020a05600c4ed000b0040b47c53610sm2170966wmq.14.2023.11.30.06.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:16:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	Jan Kara <jack@suse.cz>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 3/3] fs: use do_splice_direct() for nfsd/ksmbd server-side-copy
Date: Thu, 30 Nov 2023 16:16:24 +0200
Message-Id: <20231130141624.3338942-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231130141624.3338942-1-amir73il@gmail.com>
References: <20231130141624.3338942-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd/ksmbd call vfs_copy_file_range() with flag COPY_FILE_SPLICE to
perform kernel copy between two files on any two filesystems.

Splicing input file, while holding file_start_write() on the output file
which is on a different sb, posses a risk for fanotify related deadlocks.

We only need to call splice_file_range() from within the context of
->copy_file_range() filesystem methods with file_start_write() held.

To avoid the possible deadlocks, always use do_splice_direct() instead of
splice_file_range() for the kernel copy fallback in vfs_copy_file_range()
without holding file_start_write().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/read_write.c | 36 +++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 0bc99f38e623..e0c2c1b5962b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1421,6 +1421,10 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
+	/* May only be called from within ->copy_file_range() methods */
+	if (WARN_ON_ONCE(flags))
+		return -EINVAL;
+
 	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
 				 min_t(size_t, len, MAX_RW_COUNT));
 }
@@ -1541,19 +1545,22 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		ret = file_out->f_op->copy_file_range(file_in, pos_in,
 						      file_out, pos_out,
 						      len, flags);
-		goto done;
-	}
-
-	if (!splice && file_in->f_op->remap_file_range &&
-	    file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
+	} else if (!splice && file_in->f_op->remap_file_range &&
+		   file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
 		ret = file_in->f_op->remap_file_range(file_in, pos_in,
 				file_out, pos_out,
 				min_t(loff_t, MAX_RW_COUNT, len),
 				REMAP_FILE_CAN_SHORTEN);
-		if (ret > 0)
-			goto done;
+		/* fallback to splice */
+		if (ret <= 0)
+			splice = true;
 	}
 
+	file_end_write(file_out);
+
+	if (!splice)
+		goto done;
+
 	/*
 	 * We can get here for same sb copy of filesystems that do not implement
 	 * ->copy_file_range() in case filesystem does not support clone or in
@@ -1565,11 +1572,16 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	 * and which filesystems do not, that will allow userspace tools to
 	 * make consistent desicions w.r.t using copy_file_range().
 	 *
-	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE.
+	 * We also get here if caller (e.g. nfsd) requested COPY_FILE_SPLICE
+	 * for server-side-copy between any two sb.
+	 *
+	 * In any case, we call do_splice_direct() and not splice_file_range(),
+	 * without file_start_write() held, to avoid possible deadlocks related
+	 * to splicing from input file, while file_start_write() is held on
+	 * the output file on a different sb.
 	 */
-	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				      flags);
-
+	ret = do_splice_direct(file_in, &pos_in, file_out, &pos_out,
+			       min_t(size_t, len, MAX_RW_COUNT), 0);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
@@ -1581,8 +1593,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 	inc_syscr(current);
 	inc_syscw(current);
 
-	file_end_write(file_out);
-
 	return ret;
 }
 EXPORT_SYMBOL(vfs_copy_file_range);
-- 
2.34.1


