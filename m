Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD03330271A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Jan 2021 16:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbhAYPna (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Jan 2021 10:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730273AbhAYPnB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Jan 2021 10:43:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668F3C061D7F
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:16 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a1so13062504wrq.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Jan 2021 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bO1o95yEacxJCi6anL6VGLU0D9m8E1qC04Zr1YukLIY=;
        b=ZTJkmBtNvj+HaYd99yGGaGslCoSskPBt4H7l7Hk5qHb2OnXsuo+Dhoo+EFFsfD6JRu
         JTmgHLcpu21RVZAAYl3fnJF3ueXF+96EV/yA3ocS784tVf2+2daHcyNs8fLEeEG3OfPP
         TS6oFJAoYqmjxoPh/KNH5UN7r87b9yUMjxcnv2Z+JuvmysnIhIYKj99Sao0k3p709nIw
         b/3vldccwOQED9RavZ+r4Ip6qeV14H43+xB2oI2RjnTAhg3sbulT8odCQBX2BENwidl8
         JrPx8Y7YyYrBUivhBUdFamIUb7KcT4AavuKxnMJ4V687huqvVsyESxpTfeJOaTrczksv
         AMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bO1o95yEacxJCi6anL6VGLU0D9m8E1qC04Zr1YukLIY=;
        b=GR27UpzZMMHC2PMnHWBDbKp+rcGISu4I+u36B45T3PQiKATmJyDyIcNNSHeobRgABA
         AzxLod1j0njykjQ7PJFmm/CBPFnIPk6yBMirroK5gyDan5Rd3Fjp/EQ3S7XFQl0oHarS
         R7uEudcd64cqInQ93Nshr0Uki6PviRtGbvvtciiyFYyBV38Cc8eVwIziechxwXDjFc9K
         dxvOEeFD790tcD7xS9o5EPH55G2oLIPhLJjOQQ6w9/rTRwaxfnF0zmuNa1eTID4MW36j
         jJMJ1f0KKSOCUQx+eRQrmaICDiIcdbYUxgtwvRmy37Y/45az9DBqu6y8D+8gxR9hNMDH
         nMuA==
X-Gm-Message-State: AOAM530DrSjL+K7Jwrry07x3NhWEXMX4jfVBD0/2IkraVobk8UjYd7vD
        lTPWCg9HowmVeHYAmvdRBcIe9w==
X-Google-Smtp-Source: ABdhPJyg30IKJU9/J4/I2YRuP1Ce3mIuk2elXW5qp0wKyXt4pQb1HkUGdhTt0pKKcDa8nSqNfdxxxg==
X-Received: by 2002:adf:f606:: with SMTP id t6mr1611833wrp.360.1611588675183;
        Mon, 25 Jan 2021 07:31:15 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:4cd4:5994:40fe:253d])
        by smtp.gmail.com with ESMTPSA id o14sm22611965wri.48.2021.01.25.07.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 07:31:14 -0800 (PST)
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
        Peng Tao <bergwolf@gmail.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel@lists.sourceforge.net, kernel-team@android.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND V12 8/8] fuse: Introduce passthrough for mmap
Date:   Mon, 25 Jan 2021 15:30:57 +0000
Message-Id: <20210125153057.3623715-9-balsini@android.com>
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
In-Reply-To: <20210125153057.3623715-1-balsini@android.com>
References: <20210125153057.3623715-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Enabling FUSE passthrough for mmap-ed operations not only affects
performance, but has also been shown as mandatory for the correct
functioning of FUSE passthrough.
yanwu noticed [1] that a FUSE file with passthrough enabled may suffer
data inconsistencies if the same file is also accessed with mmap. What
happens is that read/write operations are directly applied to the lower
file system (and its cache), while mmap-ed operations are affecting the
FUSE cache.

Extend the FUSE passthrough implementation to also handle memory-mapped
FUSE file, to both fix the cache inconsistencies and extend the
passthrough performance benefits to mmap-ed operations.

[1] https://lore.kernel.org/lkml/20210119110654.11817-1-wu-yan@tcl.com/

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/file.c        |  3 +++
 fs/fuse/fuse_i.h      |  1 +
 fs/fuse/passthrough.c | 41 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index cddada1e8bd9..e3741a94c1f9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2370,6 +2370,9 @@ static int fuse_file_mmap(struct file *file, struct vm_area_struct *vma)
 	if (FUSE_IS_DAX(file_inode(file)))
 		return fuse_dax_mmap(file, vma);
 
+	if (ff->passthrough.filp)
+		return fuse_passthrough_mmap(file, vma);
+
 	if (ff->open_flags & FOPEN_DIRECT_IO) {
 		/* Can't provide the coherency needed for MAP_SHARED */
 		if (vma->vm_flags & VM_MAYSHARE)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 815af1845b16..7b0d65984608 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1244,5 +1244,6 @@ int fuse_passthrough_setup(struct fuse_conn *fc, struct fuse_file *ff,
 void fuse_passthrough_release(struct fuse_passthrough *passthrough);
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *to);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *from);
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma);
 
 #endif /* _FS_FUSE_I_H */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index 24866c5fe7e2..284979f87747 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -135,6 +135,47 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 	return ret;
 }
 
+ssize_t fuse_passthrough_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	int ret;
+	const struct cred *old_cred;
+	struct fuse_file *ff = file->private_data;
+	struct inode *fuse_inode = file_inode(file);
+	struct file *passthrough_filp = ff->passthrough.filp;
+	struct inode *passthrough_inode = file_inode(passthrough_filp);
+
+	if (!passthrough_filp->f_op->mmap)
+		return -ENODEV;
+
+	if (WARN_ON(file != vma->vm_file))
+		return -EIO;
+
+	vma->vm_file = get_file(passthrough_filp);
+
+	old_cred = override_creds(ff->passthrough.cred);
+	ret = call_mmap(vma->vm_file, vma);
+	revert_creds(old_cred);
+
+	if (ret)
+		fput(passthrough_filp);
+	else
+		fput(file);
+
+	if (file->f_flags & O_NOATIME)
+		return ret;
+
+	if ((!timespec64_equal(&fuse_inode->i_mtime,
+			       &passthrough_inode->i_mtime) ||
+	     !timespec64_equal(&fuse_inode->i_ctime,
+			       &passthrough_inode->i_ctime))) {
+		fuse_inode->i_mtime = passthrough_inode->i_mtime;
+		fuse_inode->i_ctime = passthrough_inode->i_ctime;
+	}
+	touch_atime(&file->f_path);
+
+	return ret;
+}
+
 int fuse_passthrough_open(struct fuse_dev *fud,
 			  struct fuse_passthrough_out *pto)
 {
-- 
2.30.0.280.ga3ce27912f-goog

