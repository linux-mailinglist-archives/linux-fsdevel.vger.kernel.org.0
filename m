Return-Path: <linux-fsdevel+bounces-2829-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C11F7EB3C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 16:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF111C20A74
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 15:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7D041767;
	Tue, 14 Nov 2023 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNQzwJPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6289E4176E
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 15:33:36 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A3B18A
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:34 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32f737deedfso3563304f8f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 07:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699976013; x=1700580813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y/W0FbMcXpJV0p21IBOzpdokgFQvpWnRV6Ba5vkiZs=;
        b=CNQzwJPAUtMTUeCyfosxql1NuK1e4+60TKy+5NVNdicBg0pC4i1Z2W8XUKu1GTkc21
         EY52/Up/F6/cedNGGOrx8Iq4imjQM4mwR1QOjcEfepRuWs2uUeYkFTVqgGimJ+dhv9jf
         FwNOkaMRQSInlSIZ5CV6k04jrZIvJWsg71qRIi7O9HMmP9Cnu2/vzHRaHW96GscTXhoP
         F3tlwA0E8/BWnuI8n4ApRO6/8kd8Q8kXiESz7TRdYajkC5Yz7v65/sSqzrOF/i073SD+
         ilOqhm7sbrb0wzu/qjaT8IWsUdwC6hXNFioAOg0HHJvt2Ln/c5sYx5zF1/VnE0HSLCsX
         EjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699976013; x=1700580813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Y/W0FbMcXpJV0p21IBOzpdokgFQvpWnRV6Ba5vkiZs=;
        b=DahdzsOSZc6Tz7zR1Na4LECi2yGFhXboX/wa3CxQTRFckvBDEFpN+KyfL/n1pX9y2W
         YeRRdkJDZds9r0sVoMf2EXMmh+5ZSvxoQE+YeBgzE2ZjM2VdA+tI/adjzITi74MwWNy7
         KqjNwtxNFetfc3+GCGegTBhvaiHGnZUNWavPVuty2THtPCwqfFePzMcAYeyUoVPJrU7d
         BOG45vth9kbfKnE2mXEW3uqQXHoL1Q3zQguJ+PieFX3u92Rgn0nFN5LRtjoVYWgFqVRi
         d5g2tO44zePLoH+giwq2N+xGP3lkYFSHYJWIK0mAOFJ49Ou8Rnh+4tnOqpLHXthkH5im
         0xDA==
X-Gm-Message-State: AOJu0YyMkglcmnGVN5vA5kC42Ke41lE5kwbx/i3vaI/eispjdzyZkDLt
	3z7rLNshT8wMYwClV50KsgI=
X-Google-Smtp-Source: AGHT+IG5aQSlmnv2rCn34Bv/aQkg7hdZc3H1juYmMf4sTk363vHkAkLrEgxwebabBLfDQDkH1izcBA==
X-Received: by 2002:adf:e582:0:b0:32f:7c24:e049 with SMTP id l2-20020adfe582000000b0032f7c24e049mr6045676wrm.71.1699976012911;
        Tue, 14 Nov 2023 07:33:32 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id o9-20020a5d58c9000000b0032d9caeab0fsm8146527wrf.77.2023.11.14.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 07:33:32 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	David Howells <dhowells@redhat.com>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/15] splice: remove permission hook from iter_file_splice_write()
Date: Tue, 14 Nov 2023 17:33:11 +0200
Message-Id: <20231114153321.1716028-6-amir73il@gmail.com>
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

All the callers of ->splice_write(), (e.g. do_splice_direct() and
do_splice()) already check rw_verify_area() for the entire range
and perform all the other checks that are in vfs_write_iter().

Create a helper do_iter_writev(), that performs the write without the
checks and use it in iter_file_splice_write() to avoid the redundant
rw_verify_area() checks.

This is needed for fanotify "pre content" events.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/internal.h   | 8 +++++++-
 fs/read_write.c | 7 +++++++
 fs/splice.c     | 9 ++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 58e43341aebf..c114b85e27a7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -298,7 +298,13 @@ static inline ssize_t do_get_acl(struct mnt_idmap *idmap,
 }
 #endif
 
-ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from, loff_t *pos);
+/*
+ * fs/read_write.c
+ */
+ssize_t __kernel_write_iter(struct file *file, struct iov_iter *from,
+			    loff_t *pos);
+ssize_t do_iter_writev(struct file *file, struct iov_iter *iter, loff_t *ppos,
+		       rwf_t flags);
 
 /*
  * fs/attr.c
diff --git a/fs/read_write.c b/fs/read_write.c
index 4771701c896b..590ab228fa98 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -739,6 +739,13 @@ static ssize_t do_iter_readv_writev(struct file *filp, struct iov_iter *iter,
 	return ret;
 }
 
+ssize_t do_iter_writev(struct file *filp, struct iov_iter *iter, loff_t *ppos,
+		       rwf_t flags)
+{
+	return do_iter_readv_writev(filp, iter, ppos, WRITE, flags);
+}
+
+
 /* Do it by hand, with file-ops */
 static ssize_t do_loop_readv_writev(struct file *filp, struct iov_iter *iter,
 		loff_t *ppos, int type, rwf_t flags)
diff --git a/fs/splice.c b/fs/splice.c
index d4fdd44c0b32..decbace5d812 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -673,10 +673,13 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		.u.file = out,
 	};
 	int nbufs = pipe->max_usage;
-	struct bio_vec *array = kcalloc(nbufs, sizeof(struct bio_vec),
-					GFP_KERNEL);
+	struct bio_vec *array;
 	ssize_t ret;
 
+	if (!out->f_op->write_iter)
+		return -EINVAL;
+
+	array = kcalloc(nbufs, sizeof(struct bio_vec), GFP_KERNEL);
 	if (unlikely(!array))
 		return -ENOMEM;
 
@@ -733,7 +736,7 @@ iter_file_splice_write(struct pipe_inode_info *pipe, struct file *out,
 		}
 
 		iov_iter_bvec(&from, ITER_SOURCE, array, n, sd.total_len - left);
-		ret = vfs_iter_write(out, &from, &sd.pos, 0);
+		ret = do_iter_writev(out, &from, &sd.pos, 0);
 		if (ret <= 0)
 			break;
 
-- 
2.34.1


