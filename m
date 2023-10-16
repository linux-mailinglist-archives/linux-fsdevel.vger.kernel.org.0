Return-Path: <linux-fsdevel+bounces-432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9045B7CAE85
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 18:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1DE31C20A92
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Oct 2023 16:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F60D30FAF;
	Mon, 16 Oct 2023 16:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IuAzld/6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB230F97
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 16:09:27 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6999183
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3226cc3e324so4468793f8f.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Oct 2023 09:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697472564; x=1698077364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7aLldRf8TWnW6rPWZ0LSM6zp/RKl6UZA7O17zE+A/g=;
        b=IuAzld/62rAilyeRIZqgmAxG1bt4nk21UDWYKZYLzv3Isl3ONHMdY7L5R/kLlGbn1D
         F7rNZFRzNjPuSfohd2BWYkmjK962gA8ZeToW5FRzJ+rZIkRWOuqj0ZiN7plAlZVDBn4k
         Friwht2Ql27ti3fVRRngd1/pc6EzbliePHezsQQsS1tiPCUCLz9MbUqg4MiEJ12qYKq+
         ZSgDU+GXD35LMrgPQHElcGOk93FbqV9qKk6k2c0xJHFIHgL3U5341XixWAAna5T4oo7O
         lM2JSsSAWCGkEnlAI6hAxp2M8TL7Ytf30W3J3GlUzV5P8r0xaapCSEnnKmxPGghhbtR1
         SoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697472564; x=1698077364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7aLldRf8TWnW6rPWZ0LSM6zp/RKl6UZA7O17zE+A/g=;
        b=JuvacrkMdpB4V0oo3a5diIWPEyrGAuMSoo8M35sCHYsSaXEeI4mPkQB+Tmpm4q2h3a
         h2cYacOSSxskAp7HnakBPqBh/P7yjUgIC/2yk0ALkzu3ww0g4X6NLCU2Or6ZwXxTLEvl
         SdKIH68D+KkPhAz1gb8RbqAOM5sZ74AOraQBtaAT9TMtwzE/W8zomm2MBc4V6LxM6sRw
         sanN71eOHZuNrrEaR5WJRgZIPK43qgpUTTlH8E1J4df5yC0NUAD5ZurfltoIOqGg+6TQ
         YTbrZaT0ndw2B1qQ8Dkmm5yojDlA10vRPsRE7S96MQ/t8/Vx+0S85VW7qy57SqJdhPvV
         RcAA==
X-Gm-Message-State: AOJu0Yyoxs1QPcb6x2TdwlVee8bsWpdfpgKH/xMxleCww9sgCwcrTefV
	OyOUCTqpcfErUoE8hdA+aJA=
X-Google-Smtp-Source: AGHT+IHiOfe8PmpTW4NdzEEqjjbQ2saS7aBGEeW+cJd7DIa6nIIHZ07UDb8ycDj6Ii0s5D2+IOnDqQ==
X-Received: by 2002:a5d:664a:0:b0:31f:fa38:425f with SMTP id f10-20020a5d664a000000b0031ffa38425fmr33299558wrw.9.1697472563860;
        Mon, 16 Oct 2023 09:09:23 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id p8-20020adfce08000000b003271be8440csm27379935wrn.101.2023.10.16.09.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:09:23 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Bernd Schubert <bernd.schubert@fastmail.fm>,
	Daniel Rosenberg <drosen@google.com>,
	Paul Lawrence <paullawrence@google.com>,
	Alessio Balsini <balsini@android.com>,
	Christian Brauner <brauner@kernel.org>,
	fuse-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 10/12] fuse: implement splice_{read/write} passthrough
Date: Mon, 16 Oct 2023 19:09:00 +0300
Message-Id: <20231016160902.2316986-11-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016160902.2316986-1-amir73il@gmail.com>
References: <20231016160902.2316986-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This allows passing fstests generic/249 and generic/591.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/fuse/file.c        | 27 ++++++++++++++++++++--
 fs/fuse/fuse_i.h      |  6 +++++
 fs/fuse/passthrough.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 17964486ba80..d6fc99245a61 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1664,6 +1664,29 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return fuse_direct_write_iter(iocb, from);
 }
 
+static ssize_t fuse_splice_read(struct file *in, loff_t *ppos,
+				struct pipe_inode_info *pipe, size_t len,
+				unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_splice_read(in, ppos, pipe, len, flags);
+	else
+		return filemap_splice_read(in, ppos, pipe, len, flags);
+}
+
+static ssize_t fuse_splice_write(struct pipe_inode_info *pipe, struct file *out,
+				 loff_t *ppos, size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = out->private_data;
+
+	if (fuse_file_passthrough(ff))
+		return fuse_passthrough_splice_write(pipe, out, ppos, len, flags);
+	else
+		return iter_file_splice_write(pipe, out, ppos, len, flags);
+}
+
 static void fuse_writepage_free(struct fuse_writepage_args *wpa)
 {
 	struct fuse_args_pages *ap = &wpa->ia.ap;
@@ -3222,8 +3245,8 @@ static const struct file_operations fuse_file_operations = {
 	.lock		= fuse_file_lock,
 	.get_unmapped_area = thp_get_unmapped_area,
 	.flock		= fuse_file_flock,
-	.splice_read	= filemap_splice_read,
-	.splice_write	= iter_file_splice_write,
+	.splice_read	= fuse_splice_read,
+	.splice_write	= fuse_splice_write,
 	.unlocked_ioctl	= fuse_file_ioctl,
 	.compat_ioctl	= fuse_file_compat_ioctl,
 	.poll		= fuse_file_poll,
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0a43dc93e376..7dd770efceba 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1397,5 +1397,11 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
+ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags);
+ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out, loff_t *ppos,
+				      size_t len, unsigned int flags);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 0224f63f8cdf..fa5b41a4cdc1 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -9,6 +9,7 @@
 
 #include <linux/file.h>
 #include <linux/backing-file.h>
+#include <linux/splice.h>
 
 static void fuse_file_start_write(struct file *file, loff_t pos, size_t count)
 {
@@ -96,6 +97,57 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
+				     struct pipe_inode_info *pipe,
+				     size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = in->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = in,
+		.accessed = fuse_file_accessed,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
+		 backing_file, ppos ? *ppos : 0, len, flags);
+
+	return backing_file_splice_read(backing_file, ppos, pipe, len, flags,
+					&ctx);
+}
+
+ssize_t fuse_passthrough_splice_write(struct pipe_inode_info *pipe,
+				      struct file *out, loff_t *ppos,
+				      size_t len, unsigned int flags)
+{
+	struct fuse_file *ff = out->private_data;
+	struct file *backing_file = fuse_file_passthrough(ff);
+	struct inode *inode = file_inode(out);
+	ssize_t ret;
+	struct backing_file_ctx ctx = {
+		.cred = ff->cred,
+		.user_file = out,
+		.end_write = fuse_file_end_write,
+	};
+
+	pr_debug("%s: backing_file=0x%p, pos=%lld, len=%zu, flags=0x%x\n", __func__,
+		 backing_file, ppos ? *ppos : 0, len, flags);
+
+	inode_lock(inode);
+	fuse_file_start_write(out, ppos ? *ppos : 0, len);
+	ret = file_remove_privs(out);
+	if (ret)
+		goto out_unlock;
+
+	ret = backing_file_splice_write(pipe, backing_file, ppos, len, flags,
+					&ctx);
+
+out_unlock:
+	inode_unlock(inode);
+
+	return ret;
+}
+
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
 {
 	if (fb && refcount_inc_not_zero(&fb->count))
-- 
2.34.1


