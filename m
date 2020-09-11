Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4F26644C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Sep 2020 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIKQfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Sep 2020 12:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726505AbgIKQfH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:35:07 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC14C061795
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k15so12080864wrn.10
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Sep 2020 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cAL4OTcyj/0ml6b+JkHFlWS0Em3MonHUOVeCONjc4rI=;
        b=ZtbzBk8bKELmpnkjlntpTERvB2zQz6aIgf7rR2VNkvHclg1Cq2DcOyV++kjL4qGHOe
         JCS7oJsrf7z32gxFdLemz6T4V9YxMvyA3RanHtWP0ScySPic50j+7RtA5pIlKk7sEHlO
         Q8iaCWGMoi/IWIh9fW00B6m5BsQmceoze76FlHEky33xgNFlF7KESAhZbpzoxxFSA4Bj
         uOKZCm++pe68kWoJRTg+jhEcP3HIRPG6K3PTSqG1Jw6Ccwc7R20XTiT7gcdUoIM40DP+
         hIwi0NlrzQGMuIWCwEhtsBLiMrbaEho5j+Iw41TGgZNGuUdXIwZinuA0XY1vwc/oApVZ
         LI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cAL4OTcyj/0ml6b+JkHFlWS0Em3MonHUOVeCONjc4rI=;
        b=EQOt2pgNlBzSUeteOwufTwfB4UXIbH+8aydWGo0py3sOuko7N87hfKRN4DlyL1cHyh
         wrlFc/JoOa06B8o8B7b7WiPfVSzIGFJ1PvVVQfdtbtev8dEZuCqzJJ4eRASSSAZrhDro
         0h59zaqJkk6kYmJQsjLcMoZzbOhRM8Qp0VEBD+FQQoQYnw1SxHNpPXjrDaTXnk2ny9v3
         yqKDBvjahjgtqLHOW1zveIRWfErx0R7kV/feM7y63Z4f18+pQLTacGBg7JnvG95Qry0S
         2BW/hKexr3HOCGbWo7XKZj71v3Um+haT7cpvPWjncJ1o6FI563LF+TxeHZz9dIdBd9JU
         N8PA==
X-Gm-Message-State: AOAM531av0iHJS57Tr+dK3S59o7AOofwXr8vM9mbWDX7SDuBjDueJb9K
        VRh0Z0fo55aCZ+LZoovf9T5biQ==
X-Google-Smtp-Source: ABdhPJw+noe7U524pEjlad/hhDxobVKk7S07A7v+e7+1C1aT+pOOmM8kbWk/fzIkocBTBhqoMT/P7g==
X-Received: by 2002:a5d:6cd4:: with SMTP id c20mr2796912wrc.234.1599842091760;
        Fri, 11 Sep 2020 09:34:51 -0700 (PDT)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:7220:84ff:fe09:7d5c])
        by smtp.gmail.com with ESMTPSA id s2sm5739912wrw.96.2020.09.11.09.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 09:34:51 -0700 (PDT)
From:   Alessio Balsini <balsini@android.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        David Anderson <dvander@google.com>,
        Eric Yan <eric.yan@oneplus.com>, Jann Horn <jannh@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <stefanoduo@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 2/3] fuse: Introduce synchronous read and write for passthrough
Date:   Fri, 11 Sep 2020 17:34:02 +0100
Message-Id: <20200911163403.79505-3-balsini@android.com>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
In-Reply-To: <20200911163403.79505-1-balsini@android.com>
References: <20200911163403.79505-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the read and write operations performed on fuse_files which have the
passthrough feature enabled are forwarded to the associated lower file
system file.

Sending the request directly to the lower file system avoids the userspace
round-trip that, because of possible context switches and additional
operations might reduce the overall performance, especially in those cases
where caching doesn't help, for example in reads at random offsets.

If a fuse_file has a lower file system file associated for passthrough can
be verified by checking the validity of its passthrough_filp pointer, which
is not null only passthrough has been successfully enabled via the
appropriate ioctl(). When a read/write operation is requested for a FUSE
file with passthrough enabled, the request is directly forwarded to the
corresponding file_operations of the lower file system file. After the
read/write operation is completed, the file stats change is notified (and
propagated) to the lower file system.

This change only implements synchronous requests in passthrough, returning
an error in the case of ansynchronous operations, yet covering the majority
of the use cases.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/file.c        |  8 +++--
 fs/fuse/fuse_i.h      |  2 ++
 fs/fuse/passthrough.c | 81 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 89 insertions(+), 2 deletions(-)

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
index 6c5166447905..21ba30a6a661 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1106,5 +1106,7 @@ void fuse_free_conn(struct fuse_conn *fc);
 
 int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd);
 void fuse_passthrough_release(struct fuse_file *ff);
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 86ab4eafa7bf..44a78e02f45d 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -2,6 +2,87 @@
 
 #include "fuse_i.h"
 
+#include <linux/fs_stack.h>
+#include <linux/fsnotify.h>
+#include <linux/uio.h>
+
+static void fuse_copyattr(struct file *dst_file, struct file *src_file,
+			  bool write)
+{
+	if (write) {
+		struct inode *dst = file_inode(dst_file);
+		struct inode *src = file_inode(src_file);
+
+		fsnotify_modify(src_file);
+		fsstack_copy_inode_size(dst, src);
+	} else {
+		fsnotify_access(src_file);
+	}
+}
+
+
+ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
+				   struct iov_iter *iter)
+{
+	ssize_t ret;
+	struct file *fuse_filp = iocb_fuse->ki_filp;
+	struct fuse_file *ff = fuse_filp->private_data;
+	struct file *passthrough_filp = ff->passthrough_filp;
+
+	if (!iov_iter_count(iter))
+		return 0;
+
+	if (is_sync_kiocb(iocb_fuse)) {
+		struct kiocb iocb;
+
+		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
+		ret = call_read_iter(passthrough_filp, &iocb, iter);
+		iocb_fuse->ki_pos = iocb.ki_pos;
+		if (ret >= 0)
+			fuse_copyattr(fuse_filp, passthrough_filp, false);
+
+	} else {
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
+				    struct iov_iter *iter)
+{
+	ssize_t ret;
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
+	if (is_sync_kiocb(iocb_fuse)) {
+		struct kiocb iocb;
+
+		kiocb_clone(&iocb, iocb_fuse, passthrough_filp);
+
+		file_start_write(passthrough_filp);
+		ret = call_write_iter(passthrough_filp, &iocb, iter);
+		file_end_write(passthrough_filp);
+
+		iocb_fuse->ki_pos = iocb.ki_pos;
+		if (ret > 0)
+			fuse_copyattr(fuse_filp, passthrough_filp, true);
+	} else {
+		ret = -EIO;
+	}
+
+	inode_unlock(fuse_inode);
+
+	return ret;
+}
+
 int fuse_passthrough_setup(struct fuse_req *req, unsigned int fd)
 {
 	int ret;
-- 
2.28.0.618.gf4bc123cb7-goog

