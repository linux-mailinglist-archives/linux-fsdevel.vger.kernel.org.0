Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE2C2771F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Sep 2020 15:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgIXNNk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Sep 2020 09:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbgIXNN1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:13:27 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC39DC0613CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z4so3784284wrr.4
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2020 06:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sZZlks3iSx8s9lDyxs+csuRoO2CrDNiUR/cHMJe+SwI=;
        b=E8qt9biXDu4ZdSAEs5GUe2aO7q54VUVhM0P1BmTOJAm3tD9KdSwYME2DhFbsXBPnB+
         skXPmvnOOCmdEJi46WORrGtsiNXzdPCs2zeg+hQ9RoOxA8a203tRl6r8fVgx2Mfu4bvS
         w7YYX3EFnRHoahvfhZGayGTwavSsCLPTis1qf+gexSfHtwM59xkvveX5a6ztWw5XAEd6
         UVY1nA4fmcjim2G9dX25m6yyTwTumbkDtbJ5mO7v0FC9DnQJuKajp2TTlq2p8WJHHiTI
         Ww/A4DvFG6900AA7f+FGDYBn9XaFcTZjIe91GJTfNbYPe5kHDoxXlPewJ31aJgQDIH+L
         xvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sZZlks3iSx8s9lDyxs+csuRoO2CrDNiUR/cHMJe+SwI=;
        b=kWcJqQr1LzdLTjK27S04Fa/Z/xaDafqznAOUaARUziLWxptbIuf2vKS4qVpjg6wrgC
         RNCCx2tn+Trm/wEX359juD+kDNDPwsg5q9oV/6pSXC2HeOlMgFJOa0BrPYH36rWnHfsx
         yAlL20umUex5J7EFO+/7MK7isn7s7+tExIecdJIi83sCBODAgScS+wNoqGkLER+NjBo7
         EmlEDFOfQuuyAa1C7wAXa6oSLPWlejomKrqAIoowIaWPjSk6YQT3UxlrjXSd+SP/qWYW
         zrstBYIovJg5vK+elfK/Izvdo13D3l9Bz5PftAhMaRiu+Seew8IkjbeZrN/hBBbPz6X5
         t7uA==
X-Gm-Message-State: AOAM53219sQccoJaSTlcded+KZTrzrTEHlsY7Z0b/LlmpR5M2m8E7q1+
        rlo97rhXSwcrAmg0pyssDjktGg==
X-Google-Smtp-Source: ABdhPJw36n6GgKPH4j0DYfUuTobv8Z6hBaPcKQAuxiE2b2hTjyQ4XL4FjapbfpSV/bkAXI9GEzJcxg==
X-Received: by 2002:adf:fc0a:: with SMTP id i10mr5034984wrr.111.1600953205562;
        Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id k22sm3805044wrd.29.2020.09.24.06.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 06:13:25 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V9 3/4] fuse: Introduce synchronous read and write for passthrough
Date:   Thu, 24 Sep 2020 14:13:17 +0100
Message-Id: <20200924131318.2654747-4-balsini@android.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
In-Reply-To: <20200924131318.2654747-1-balsini@android.com>
References: <20200924131318.2654747-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated lower file
system file via VFS.

Sending the request directly to the lower file system avoids the userspace
round-trip that, because of possible context switches and additional
operations might reduce the overall performance, especially in those cases
where caching doesn't help, for example in reads at random offsets.

Verifying if a fuse_file has a lower file system file associated for
passthrough can be done by checking the validity of its passthrough_filp
pointer. This pointer is not NULL only if passthrough has been successfully
enabled via the appropriate ioctl().
When a read/write operation is requested for a FUSE file with passthrough
enabled, a new equivalent VFS request is generated, which instead targets
the lower file system file.
The VFS layer performs additional checks that allows for safer operations,
but may cause the operation to fail if the process accessing the FUSE file
system does not have access to the lower file system. This often happens in
passthrough file systems, where the FUSE daemon is responsible for the
enforcement of the lower file system access policies. In order to preserve
this behavior, the current process accessing the FUSE file with passthrough
enabled receives the privileges of the FUSE daemon while performing the
read/write operation, emulating a behavior used in overlayfs. These
privileges will be reverted as soon as the IO operation completes. This
feature does not provide any higher security privileges to those processes
accessing the FUSE file system with passthrough enabled. This because it is
still the FUSE daemon responsible for enabling or not the passthrough
feature at file open time, and should enable the feature only after
appropriate access policy checks.

This change only implements synchronous requests in passthrough, returning
an error in the case of ansynchronous operations, yet covering the majority
of the use cases.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/file.c        |  8 +++-
 fs/fuse/fuse_i.h      |  2 +
 fs/fuse/passthrough.c | 93 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6c0ec742ce74..c3289ff0cd33 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1552,7 +1552,9 @@ static ssize_t fuse_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough_filp)
+		return fuse_passthrough_read_iter(iocb, to);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_read_iter(iocb, to);
 	else
 		return fuse_direct_read_iter(iocb, to);
@@ -1566,7 +1568,9 @@ static ssize_t fuse_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (is_bad_inode(file_inode(file)))
 		return -EIO;
 
-	if (!(ff->open_flags & FOPEN_DIRECT_IO))
+	if (ff->passthrough_filp)
+		return fuse_passthrough_write_iter(iocb, from);
+	else if (!(ff->open_flags & FOPEN_DIRECT_IO))
 		return fuse_cache_write_iter(iocb, from);
 	else
 		return fuse_direct_write_iter(iocb, from);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 67bf5919f8d6..b0764ca4c4fd 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1109,5 +1109,7 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd);
 void fuse_passthrough_release(struct fuse_file *ff);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 86ab4eafa7bf..f70c0ef6945b 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -2,6 +2,99 @@
 
 #include "fuse_i.h"
 
+#include <linux/uio.h>
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file)
+{
+	struct inode *dst = file_inode(dst_file);
+	struct inode *src = file_inode(src_file);
+
+	i_size_write(dst, i_size_read(src));
+}
+
+static rwf_t iocbflags_to_rwf(int ifl)
+{
+	rwf_t flags = 0;
+
+	if (ifl & IOCB_APPEND)
+		flags |= RWF_APPEND;
+	if (ifl & IOCB_DSYNC)
+		flags |= RWF_DSYNC;
+	if (ifl & IOCB_HIPRI)
+		flags |= RWF_HIPRI;
+	if (ifl & IOCB_NOWAIT)
+		flags |= RWF_NOWAIT;
+	if (ifl & IOCB_SYNC)
+		flags |= RWF_SYNC;
+
+	return flags;
+}
+
+static const struct cred *
+fuse_passthrough_override_creds(const struct file *fuse_filp)
+{
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	struct fuse_conn *fc = fuse_inode->i_sb->s_fs_info;
+
+	return override_creds(fc->creator_cred);
+}
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	ssize_t ret;
+	const struct cred *old_cred;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough_filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	old_cred = fuse_passthrough_override_creds(fuse_filp);
+	if (is_sync_kiocb(iocb_fuse)) {
+		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				    iocbflags_to_rwf(iocb_fuse->ki_flags));
+	} else {
+		ret = -EIO;
+	}
+	revert_creds(old_cred);
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	ssize_t ret;
+	const struct cred *old_cred;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct inode *fuse_inode = file_inode(fuse_filp);
+	struct file *passthrough_filp = ff->passthrough_filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	inode_lock(fuse_inode);
+
+	old_cred = fuse_passthrough_override_creds(fuse_filp);
+	if (is_sync_kiocb(iocb_fuse)) {
+		file_start_write(passthrough_filp);
+		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
+				    iocbflags_to_rwf(iocb_fuse->ki_flags));
+		file_end_write(passthrough_filp);
+		if (ret > 0)
+			fuse_copyattr(fuse_filp, passthrough_filp);
+	} else {
+		ret = -EIO;
+	}
+	revert_creds(old_cred);
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
+
 int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
 {
 	int ret;
-- 
2.28.0.681.g6f77f65b4e-goog

