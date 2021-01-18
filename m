Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C942A2FAA7F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437149AbhARTrL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 14:47:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437175AbhARTaE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 14:30:04 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EB7C06179A
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:09 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a9so14084644wrt.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Jan 2021 11:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D0TtzT5oB1JEkBdPQkzoSBTusBPLGHpi8nIxnizrixo=;
        b=IIGBAvfXDxspwEiRR3IgidZB22bh5AQq0S6eUdIRqJf2kopmI2qawJ9FAHnLyMCJqG
         zjOVPHaMPpymaMFbj9Meu9z8Fn7u0a0CsNVQPbJBRsuhVqSReS45mjxn3ceIGjGph2/G
         9ZRfiRpmO+lLeXBzlf58PHTPNoiwWpEjG5jiitII0IGU46WYJXUt6FF2ZtK2dn+yujYH
         zr7I4Rh81BiadmdZZd2vd5kZKypmlMINAHBVaxWnalLIoj0kNRxB8HkHI369NlKjWcs6
         VuwWbQravjxW2GuKBFmSrWDs5XYHU4sLUCPc05pWNp+gstwJEO80GralzsLiQwL3Z3tv
         6MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D0TtzT5oB1JEkBdPQkzoSBTusBPLGHpi8nIxnizrixo=;
        b=qqsHVXbivri3t6EVBzIgrD50UD30Eb13uzmAjrwUPlT3b1dIus6sYzB22BPe4VbUXr
         zO31kuTDSpfEq5yvCugWfM3VhK7+rCK4eDNnitQza6xWRvxcMtgJz89wbjRYUPCyKnnH
         U8UssyxWPR9rw3m/5oHtVddcusoEbhc6Su5OPAYBatt+5iZg2588ktrHS1bxUHcABHKQ
         imWL7gloznNpN+Oct3so3bUNY8RYwAIuJz6N4uDZP01LffaV4ZIGrnXdcwTP6w6LZMDS
         zsppO6LZNbhbOUwRcML+9paGckgT26AtNOiG/awVrlT+LZnEwbzUlxh51IvXf/TMzRyY
         kgew==
X-Gm-Message-State: AOAM532R1WyUESgkwO6j/4TQQKbGShFp8DPo67h+5kF8+YPU1ONjkWsF
        ddoAKsykKZGyL+yyY/rCjD3NfA==
X-Google-Smtp-Source: ABdhPJxzO9/BM5RDWS3fkxXJpgnK2SxS+e4tneV+eDb/v3HvEMdH+q0EHsvBHPFb6tJHR3x+9PHJKQ==
X-Received: by 2002:adf:e704:: with SMTP id c4mr914880wrm.355.1610998148306;
        Mon, 18 Jan 2021 11:29:08 -0800 (PST)
Received: from balsini.lon.corp.google.com ([2a00:79e0:d:210:41d4:8c90:d38:455d])
        by smtp.gmail.com with ESMTPSA id h5sm33583299wrp.56.2021.01.18.11.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 11:29:07 -0800 (PST)
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
Subject: [PATCH RESEND V11 7/7] fuse: Use daemon creds in passthrough mode
Date:   Mon, 18 Jan 2021 19:27:48 +0000
Message-Id: <20210118192748.584213-8-balsini@android.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
In-Reply-To: <20210118192748.584213-1-balsini@android.com>
References: <20210118192748.584213-1-balsini@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When using FUSE passthrough, read/write operations are directly forwarded
to the lower file system file through VFS, but there is no guarantee that
the process that is triggering the request has the right permissions to
access the lower file system. This would cause the read/write access to
fail.

In passthrough file systems, where the FUSE daemon is responsible for the
enforcement of the lower file system access policies, often happens that
the process dealing with the FUSE file system doesn't have access to the
lower file system.
Being the FUSE daemon in charge of implementing the FUSE file operations,
that in the case of read/write operations usually simply results in the
copy of memory buffers from/to the lower file system respectively, these
operations are executed with the FUSE daemon privileges.

This patch adds a reference to the FUSE daemon credentials, referenced at
FUSE_DEV_IOC_PASSTHROUGH_OPEN ioctl() time so that they can be used to
temporarily raise the user credentials when accessing lower file system
files in passthrough.
The process accessing the FUSE file with passthrough enabled temporarily
receives the privileges of the FUSE daemon while performing read/write
operations. Similar behavior is implemented in overlayfs.
These privileges will be reverted as soon as the IO operation completes.
This feature does not provide any higher security privileges to those
processes accessing the FUSE file system with passthrough enabled. This is
because it is still the FUSE daemon responsible for enabling or not the
passthrough feature at file open time, and should enable the feature only
after appropriate access policy checks.

Signed-off-by: Alessio Balsini <balsini@android.com>
---
 fs/fuse/fuse_i.h      |  5 ++++-
 fs/fuse/passthrough.c | 11 +++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index c4730d893324..815af1845b16 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -182,10 +182,13 @@ struct fuse_release_args;
 
 /**
  * Reference to lower filesystem file for read/write operations handled in
- * passthrough mode
+ * passthrough mode.
+ * This struct also tracks the credentials to be used for handling read/write
+ * operations.
  */
 struct fuse_passthrough {
 	struct file *filp;
+	struct cred *cred;
 };
 
 /** FUSE specific file data */
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index da71a74014d7..d81e3960b097 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -52,6 +52,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 				   struct iov_iter *iter)
 {
 	ssize_t ret;
+	const struct cred *old_cred;
 	struct file *fuse_filp = iocb_fuse->ki_filp;
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct file *passthrough_filp = ff->passthrough.filp;
@@ -59,6 +60,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 	if (!iov_iter_count(iter))
 		return 0;
 
+	old_cred = override_creds(ff->passthrough.cred);
 	if (is_sync_kiocb(iocb_fuse)) {
 		ret = vfs_iter_read(passthrough_filp, iter, &iocb_fuse->ki_pos,
 				    iocb_to_rw_flags(iocb_fuse->ki_flags,
@@ -77,6 +79,7 @@ ssize_t fuse_passthrough_read_iter(struct kiocb *iocb_fuse,
 		if (ret != -EIOCBQUEUED)
 			fuse_aio_cleanup_handler(aio_req);
 	}
+	revert_creds(old_cred);
 
 	return ret;
 }
@@ -85,6 +88,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 				    struct iov_iter *iter)
 {
 	ssize_t ret;
+	const struct cred *old_cred;
 	struct file *fuse_filp = iocb_fuse->ki_filp;
 	struct fuse_file *ff = fuse_filp->private_data;
 	struct inode *fuse_inode = file_inode(fuse_filp);
@@ -96,6 +100,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 
 	inode_lock(fuse_inode);
 
+	old_cred = override_creds(ff->passthrough.cred);
 	if (is_sync_kiocb(iocb_fuse)) {
 		file_start_write(passthrough_filp);
 		ret = vfs_iter_write(passthrough_filp, iter, &iocb_fuse->ki_pos,
@@ -124,6 +129,7 @@ ssize_t fuse_passthrough_write_iter(struct kiocb *iocb_fuse,
 			fuse_aio_cleanup_handler(aio_req);
 	}
 out:
+	revert_creds(old_cred);
 	inode_unlock(fuse_inode);
 
 	return ret;
@@ -174,6 +180,7 @@ int fuse_passthrough_open(struct fuse_dev *fud,
 	}
 
 	passthrough->filp = passthrough_filp;
+	passthrough->cred = prepare_creds();
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->passthrough_req_lock);
@@ -225,4 +232,8 @@ void fuse_passthrough_release(struct fuse_passthrough *passthrough)
 		fput(passthrough->filp);
 		passthrough->filp = NULL;
 	}
+	if (passthrough->cred) {
+		put_cred(passthrough->cred);
+		passthrough->cred = NULL;
+	}
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

