Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9EC69D42D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 20:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjBTTil (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 14:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjBTTid (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:38:33 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3179775
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:21 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 459A23F728
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1676921900;
        bh=lM+yJFGNt5sJnKmBqQGtpJTV0lM3y2q0OmfH01aH2Sg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=CiaFcqAPePiakkqxI8JIOongN5eZMC23f0sC+HhM4UKb7qfT9Pv6lokUe/6ueJXfV
         /zEeJ46R/uaB1MuEzyU47ePyMCK5B5dNXGTnb4DvB/6ubQSRUnZsqixjwojl9a3H0u
         VE7qzKPkYzOiGzTpEYeYs3NQMy51R+5+jFGBypGruZKJ6DijL7gw8PnW/s3LvGfz1Q
         YoY7SGljFCHBQwScCXr1JFeI2C8ZixVImuR0Of1W/jYcxPoiNTjK+/qxOJsBXn5Ao1
         d2yfBOaUaIQ3A97VhX3gjlM8PX1oiZziDtF5tabq44d7FZAepgM0UEwEM9ywdEKahj
         KUnCQjGhI9pWA==
Received: by mail-ed1-f71.google.com with SMTP id k12-20020a50c8cc000000b004accf30f6d3so2853012edh.14
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 11:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lM+yJFGNt5sJnKmBqQGtpJTV0lM3y2q0OmfH01aH2Sg=;
        b=Hg93lhMNSUUdYQa2QY91W6PUcGHu6A5crA3c2vJROp1RizYw27UbTrPAfX9RGHj0FD
         7/YXf2dVI08upirjhqmiPULdL0xF1wWkgoOHpTYns+5fRJYDGjHzWmkFvS8jTGj+HrWn
         zxjZ9ij5fkPyH5H462EWmjz3vGFKhS1BVfBVuZUqOrXc4bkI55OcP6FflkoXVzFX0pzw
         9rthDeXuJ/jjk5CNezqWaMqftVU8bGaRFphiQlArT2OxNwH6RqWwiZnUn7f5Urg5PysN
         VFzz5ZFXhpMqHDOelcTxgHEKFiJ5NcwBFC1bsR+Nf55FecRP45Ik6Yv8ZycQ4elnnEVd
         ZRqQ==
X-Gm-Message-State: AO0yUKX4NIMknGhEkgues0zokQjsx9Um9ueyEHxIgK23lfmtZC6XdFI5
        /oDHZVYEfEvdPB6EDPiyUaDQElFLkp0TtbFMxuE1NqmbJMFGklWb8WkWch91nm6i+WlIbOHOqPq
        2T5DPIa+PA/fOfv5dgBWjlDa18Ax78zWaQ9SHfjNAH8Y=
X-Received: by 2002:a17:907:a07:b0:8b1:3483:b825 with SMTP id bb7-20020a1709070a0700b008b13483b825mr14510644ejc.51.1676921899923;
        Mon, 20 Feb 2023 11:38:19 -0800 (PST)
X-Google-Smtp-Source: AK7set/QsqioxxTY2PA9aRH5BD9kocW6ll8oP5UeWLE7Km8LWwG8CuRXlQgmy+ub/umNMsEt1oDOFQ==
X-Received: by 2002:a17:907:a07:b0:8b1:3483:b825 with SMTP id bb7-20020a1709070a0700b008b13483b825mr14510618ejc.51.1676921899560;
        Mon, 20 Feb 2023 11:38:19 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:bd40:1414:bb20:aed2:bb7f:f0cf])
        by smtp.gmail.com with ESMTPSA id a19-20020a17090680d300b008d4df095034sm1526693ejx.195.2023.02.20.11.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 11:38:19 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     mszeredi@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        Seth Forshee <sforshee@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        criu@openvz.org
Subject: [RFC PATCH 5/9] fuse: move fuse connection flags to the separate structure
Date:   Mon, 20 Feb 2023 20:37:50 +0100
Message-Id: <20230220193754.470330-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230220193754.470330-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Let's move all the fuse connection flags that can be safely zeroed
after connection reinitialization to the separate structure fuse_conn_flags.

All of these flags values are calculated dynamically basing on
the userspace daemon capabilities (like no_open, no_flush) or on the
response for FUSE_INIT request.

Cc: Miklos Szeredi <mszeredi@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: criu@openvz.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/fuse/acl.c     |   6 +-
 fs/fuse/dev.c     |   4 +-
 fs/fuse/dir.c     |  26 +++---
 fs/fuse/file.c    |  80 ++++++++---------
 fs/fuse/fuse_i.h  | 225 ++++++++++++++++++++++++----------------------
 fs/fuse/inode.c   |  52 +++++------
 fs/fuse/readdir.c |   8 +-
 fs/fuse/xattr.c   |  18 ++--
 8 files changed, 215 insertions(+), 204 deletions(-)

diff --git a/fs/fuse/acl.c b/fs/fuse/acl.c
index a4850aee2639..b27953739de4 100644
--- a/fs/fuse/acl.c
+++ b/fs/fuse/acl.c
@@ -25,7 +25,7 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	if (fuse_is_bad(inode))
 		return ERR_PTR(-EIO);
 
-	if (!fc->posix_acl || fc->no_getxattr)
+	if (!fc->posix_acl || fc->flags.no_getxattr)
 		return NULL;
 
 	if (type == ACL_TYPE_ACCESS)
@@ -42,7 +42,7 @@ struct posix_acl *fuse_get_acl(struct inode *inode, int type, bool rcu)
 	if (size > 0)
 		acl = posix_acl_from_xattr(fc->user_ns, value, size);
 	else if ((size == 0) || (size == -ENODATA) ||
-		 (size == -EOPNOTSUPP && fc->no_getxattr))
+		 (size == -EOPNOTSUPP && fc->flags.no_getxattr))
 		acl = NULL;
 	else if (size == -ERANGE)
 		acl = ERR_PTR(-E2BIG);
@@ -64,7 +64,7 @@ int fuse_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (!fc->posix_acl || fc->no_setxattr)
+	if (!fc->posix_acl || fc->flags.no_setxattr)
 		return -EOPNOTSUPP;
 
 	if (type == ACL_TYPE_ACCESS)
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 85f69629f34d..737764c2295e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -367,7 +367,7 @@ static void request_wait_answer(struct fuse_req *req)
 	struct fuse_iqueue *fiq = &fc->iq;
 	int err;
 
-	if (!fc->no_interrupt) {
+	if (!fc->flags.no_interrupt) {
 		/* Any signal may interrupt this */
 		err = wait_event_interruptible(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
@@ -1901,7 +1901,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		if (nbytes != sizeof(struct fuse_out_header))
 			err = -EINVAL;
 		else if (oh.error == -ENOSYS)
-			fc->no_interrupt = 1;
+			fc->flags.no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			err = queue_interrupt(req);
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 49d91add08bc..63625c29d6ef 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -707,7 +707,7 @@ static int fuse_create_open(struct inode *dir, struct dentry *entry,
 	} else {
 		file->private_data = ff;
 		fuse_finish_open(inode, file);
-		if (fm->fc->atomic_o_trunc && trunc)
+		if (fm->fc->flags.atomic_o_trunc && trunc)
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
@@ -750,12 +750,12 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	/* Only creates */
 	file->f_mode |= FMODE_CREATED;
 
-	if (fc->no_create)
+	if (fc->flags.no_create)
 		goto mknod;
 
 	err = fuse_create_open(dir, entry, file, flags, mode, FUSE_CREATE);
 	if (err == -ENOSYS) {
-		fc->no_create = 1;
+		fc->flags.no_create = 1;
 		goto mknod;
 	}
 out_dput:
@@ -1080,14 +1080,14 @@ static int fuse_rename2(struct user_namespace *mnt_userns, struct inode *olddir,
 		return -EINVAL;
 
 	if (flags) {
-		if (fc->no_rename2 || fc->minor < 23)
+		if (fc->flags.no_rename2 || fc->minor < 23)
 			return -EINVAL;
 
 		err = fuse_rename_common(olddir, oldent, newdir, newent, flags,
 					 FUSE_RENAME2,
 					 sizeof(struct fuse_rename2_in));
 		if (err == -ENOSYS) {
-			fc->no_rename2 = 1;
+			fc->flags.no_rename2 = 1;
 			err = -EINVAL;
 		}
 	} else {
@@ -1354,7 +1354,7 @@ static int fuse_access(struct inode *inode, int mask)
 
 	BUG_ON(mask & MAY_NOT_BLOCK);
 
-	if (fm->fc->no_access)
+	if (fm->fc->flags.no_access)
 		return 0;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -1366,7 +1366,7 @@ static int fuse_access(struct inode *inode, int mask)
 	args.in_args[0].value = &inarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_access = 1;
+		fm->fc->flags.no_access = 1;
 		err = 0;
 	}
 	return err;
@@ -1503,7 +1503,7 @@ static const char *fuse_get_link(struct dentry *dentry, struct inode *inode,
 	if (fuse_is_bad(inode))
 		goto out_err;
 
-	if (fc->cache_symlinks)
+	if (fc->flags.cache_symlinks)
 		return page_get_link(dentry, inode, callback);
 
 	err = -ECHILD;
@@ -1551,13 +1551,13 @@ static int fuse_dir_fsync(struct file *file, loff_t start, loff_t end,
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (fc->no_fsyncdir)
+	if (fc->flags.no_fsyncdir)
 		return 0;
 
 	inode_lock(inode);
 	err = fuse_fsync_common(file, start, end, datasync, FUSE_FSYNCDIR);
 	if (err == -ENOSYS) {
-		fc->no_fsyncdir = 1;
+		fc->flags.no_fsyncdir = 1;
 		err = 0;
 	}
 	inode_unlock(inode);
@@ -1749,7 +1749,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	struct fuse_setattr_in inarg;
 	struct fuse_attr_out outarg;
 	bool is_truncate = false;
-	bool is_wb = fc->writeback_cache && S_ISREG(inode->i_mode);
+	bool is_wb = fc->flags.writeback_cache && S_ISREG(inode->i_mode);
 	loff_t oldsize;
 	int err;
 	bool trust_local_cmtime = is_wb;
@@ -1782,7 +1782,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		/* This is coming from open(..., ... | O_TRUNC); */
 		WARN_ON(!(attr->ia_valid & ATTR_SIZE));
 		WARN_ON(attr->ia_size != 0);
-		if (fc->atomic_o_trunc) {
+		if (fc->flags.atomic_o_trunc) {
 			/*
 			 * No need to send request to userspace, since actual
 			 * truncation has already been done by OPEN.  But still
@@ -1929,7 +1929,7 @@ static int fuse_setattr(struct user_namespace *mnt_userns, struct dentry *entry,
 		 *
 		 * This should be done on write(), truncate() and chown().
 		 */
-		if (!fc->handle_killpriv && !fc->handle_killpriv_v2) {
+		if (!fc->flags.handle_killpriv && !fc->handle_killpriv_v2) {
 			/*
 			 * ia_mode calculation may have used stale i_mode.
 			 * Refresh and recalculate.
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 6d89d4dd4c55..d5b30faff0b9 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -29,7 +29,7 @@ static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.flags = open_flags & ~(O_CREAT | O_EXCL | O_NOCTTY);
-	if (!fm->fc->atomic_o_trunc)
+	if (!fm->fc->flags.atomic_o_trunc)
 		inarg.flags &= ~O_TRUNC;
 
 	if (fm->fc->handle_killpriv_v2 &&
@@ -110,7 +110,7 @@ static void fuse_file_put(struct fuse_file *ff, bool sync, bool isdir)
 	if (refcount_dec_and_test(&ff->count)) {
 		struct fuse_args *args = &ff->release_args->args;
 
-		if (isdir ? ff->fm->fc->no_opendir : ff->fm->fc->no_open) {
+		if (isdir ? ff->fm->fc->flags.no_opendir : ff->fm->fc->flags.no_open) {
 			/* Do nothing when client does not implement 'open' */
 			fuse_release_end(ff->fm, args, 0);
 		} else if (sync) {
@@ -140,7 +140,7 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 	ff->fh = 0;
 	/* Default for no-open */
 	ff->open_flags = FOPEN_KEEP_CACHE | (isdir ? FOPEN_CACHE_DIR : 0);
-	if (isdir ? !fc->no_opendir : !fc->no_open) {
+	if (isdir ? !fc->flags.no_opendir : !fc->flags.no_open) {
 		struct fuse_open_out outarg;
 		int err;
 
@@ -154,9 +154,9 @@ struct fuse_file *fuse_file_open(struct fuse_mount *fm, u64 nodeid,
 			return ERR_PTR(err);
 		} else {
 			if (isdir)
-				fc->no_opendir = 1;
+				fc->flags.no_opendir = 1;
 			else
-				fc->no_open = 1;
+				fc->flags.no_open = 1;
 		}
 	}
 
@@ -205,7 +205,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 	else if (ff->open_flags & FOPEN_NONSEEKABLE)
 		nonseekable_open(inode, file);
 
-	if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC)) {
+	if (fc->flags.atomic_o_trunc && (file->f_flags & O_TRUNC)) {
 		struct fuse_inode *fi = get_fuse_inode(inode);
 
 		spin_lock(&fi->lock);
@@ -215,7 +215,7 @@ void fuse_finish_open(struct inode *inode, struct file *file)
 		file_update_time(file);
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODSIZE);
 	}
-	if ((file->f_mode & FMODE_WRITE) && fc->writeback_cache)
+	if ((file->f_mode & FMODE_WRITE) && fc->flags.writeback_cache)
 		fuse_link_write_file(file);
 }
 
@@ -225,10 +225,10 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	struct fuse_conn *fc = fm->fc;
 	int err;
 	bool is_wb_truncate = (file->f_flags & O_TRUNC) &&
-			  fc->atomic_o_trunc &&
-			  fc->writeback_cache;
+			  fc->flags.atomic_o_trunc &&
+			  fc->flags.writeback_cache;
 	bool dax_truncate = (file->f_flags & O_TRUNC) &&
-			  fc->atomic_o_trunc && FUSE_IS_DAX(inode);
+			  fc->flags.atomic_o_trunc && FUSE_IS_DAX(inode);
 
 	if (fuse_is_bad(inode))
 		return -EIO;
@@ -259,7 +259,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 	if (!err) {
 		struct fuse_file *ff = file->private_data;
 
-		if (fc->atomic_o_trunc && (file->f_flags & O_TRUNC))
+		if (fc->flags.atomic_o_trunc && (file->f_flags & O_TRUNC))
 			truncate_pagecache(inode, 0);
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
@@ -350,7 +350,7 @@ static int fuse_release(struct inode *inode, struct file *file)
 	 * Dirty pages might remain despite write_inode_now() call from
 	 * fuse_flush() due to writes racing with the close.
 	 */
-	if (fc->writeback_cache)
+	if (fc->flags.writeback_cache)
 		write_inode_now(inode, 1);
 
 	fuse_release_common(file, false);
@@ -505,12 +505,12 @@ static int fuse_do_flush(struct fuse_flush_args *fa)
 		goto out;
 
 	err = 0;
-	if (fm->fc->no_flush)
+	if (fm->fc->flags.no_flush)
 		goto inval_attr_out;
 
 	err = fuse_simple_request(fm, &fa->args);
 	if (err == -ENOSYS) {
-		fm->fc->no_flush = 1;
+		fm->fc->flags.no_flush = 1;
 		err = 0;
 	}
 
@@ -519,7 +519,7 @@ static int fuse_do_flush(struct fuse_flush_args *fa)
 	 * In memory i_blocks is not maintained by fuse, if writeback cache is
 	 * enabled, i_blocks from cached attr may not be accurate.
 	 */
-	if (!err && fm->fc->writeback_cache)
+	if (!err && fm->fc->flags.writeback_cache)
 		fuse_invalidate_attr_mask(inode, STATX_BLOCKS);
 
 out:
@@ -545,7 +545,7 @@ static int fuse_flush(struct file *file, fl_owner_t id)
 	if (fuse_is_bad(inode))
 		return -EIO;
 
-	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->writeback_cache)
+	if (ff->open_flags & FOPEN_NOFLUSH && !fm->fc->flags.writeback_cache)
 		return 0;
 
 	fa = kzalloc(sizeof(*fa), GFP_KERNEL);
@@ -628,12 +628,12 @@ static int fuse_fsync(struct file *file, loff_t start, loff_t end,
 	if (err)
 		goto out;
 
-	if (fc->no_fsync)
+	if (fc->flags.no_fsync)
 		goto out;
 
 	err = fuse_fsync_common(file, start, end, datasync, FUSE_FSYNC);
 	if (err == -ENOSYS) {
-		fc->no_fsync = 1;
+		fc->flags.no_fsync = 1;
 		err = 0;
 	}
 out:
@@ -858,7 +858,7 @@ static void fuse_short_read(struct inode *inode, u64 attr_ver, size_t num_read,
 	 * the file.  Some data after the hole is in page cache, but has not
 	 * reached the client fs yet.  So the hole is not present there.
 	 */
-	if (!fc->writeback_cache) {
+	if (!fc->flags.writeback_cache) {
 		loff_t pos = page_offset(ap->pages[0]) + num_read;
 		fuse_read_update_size(inode, pos, attr_ver);
 	}
@@ -989,7 +989,7 @@ static void fuse_send_readpages(struct fuse_io_args *ia, struct file *file)
 
 	fuse_read_args_fill(ia, file, pos, count, FUSE_READ);
 	ia->read.attr_ver = fuse_get_attr_version(fm->fc);
-	if (fm->fc->async_read) {
+	if (fm->fc->flags.async_read) {
 		ia->ff = fuse_file_get(ff);
 		ap->args.end = fuse_readpages_end;
 		err = fuse_simple_background(fm, &ap->args, GFP_KERNEL);
@@ -1056,7 +1056,7 @@ static ssize_t fuse_cache_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	 * Otherwise, only update if we attempt to read past EOF (to ensure
 	 * i_size is up to date).
 	 */
-	if (fc->auto_inval_data ||
+	if (fc->flags.auto_inval_data ||
 	    (iocb->ki_pos + iov_iter_count(to) > i_size_read(inode))) {
 		int err;
 		err = fuse_update_attributes(inode, iocb->ki_filp, STATX_SIZE);
@@ -1263,7 +1263,7 @@ static ssize_t fuse_fill_write_pages(struct fuse_io_args *ia,
 			ia->write.page_locked = true;
 			break;
 		}
-		if (!fc->big_writes)
+		if (!fc->flags.big_writes)
 			break;
 	} while (iov_iter_count(ii) && count < fc->max_write &&
 		 ap->num_pages < max_pages && offset == 0);
@@ -1343,7 +1343,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	loff_t endbyte = 0;
 
-	if (fc->writeback_cache) {
+	if (fc->flags.writeback_cache) {
 		/* Update size (EOF optimization) and mode (SUID clearing) */
 		err = fuse_update_attributes(mapping->host, file,
 					     STATX_SIZE | STATX_MODE);
@@ -1864,7 +1864,7 @@ static void fuse_writepage_end(struct fuse_mount *fm, struct fuse_args *args,
 	 * Do this only if writeback_cache is not enabled.  If writeback_cache
 	 * is enabled, we trust local ctime/mtime.
 	 */
-	if (!fc->writeback_cache)
+	if (!fc->flags.writeback_cache)
 		fuse_invalidate_attr_mask(inode, FUSE_STATX_MODIFY);
 	spin_lock(&fi->lock);
 	rb_erase(&wpa->writepages_entry, &fi->writepages);
@@ -2368,7 +2368,7 @@ static int fuse_write_begin(struct file *file, struct address_space *mapping,
 	loff_t fsize;
 	int err = -ENOMEM;
 
-	WARN_ON(!fc->writeback_cache);
+	WARN_ON(!fc->flags.writeback_cache);
 
 	page = grab_cache_page_write_begin(mapping, index);
 	if (!page)
@@ -2641,13 +2641,13 @@ static int fuse_file_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (cmd == F_CANCELLK) {
 		err = 0;
 	} else if (cmd == F_GETLK) {
-		if (fc->no_lock) {
+		if (fc->flags.no_lock) {
 			posix_test_lock(file, fl);
 			err = 0;
 		} else
 			err = fuse_getlk(file, fl);
 	} else {
-		if (fc->no_lock)
+		if (fc->flags.no_lock)
 			err = posix_lock_file(file, fl, NULL);
 		else
 			err = fuse_setlk(file, fl, 0);
@@ -2661,7 +2661,7 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 	struct fuse_conn *fc = get_fuse_conn(inode);
 	int err;
 
-	if (fc->no_flock) {
+	if (fc->flags.no_flock) {
 		err = locks_lock_file_wait(file, fl);
 	} else {
 		struct fuse_file *ff = file->private_data;
@@ -2683,7 +2683,7 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	struct fuse_bmap_out outarg;
 	int err;
 
-	if (!inode->i_sb->s_bdev || fm->fc->no_bmap)
+	if (!inode->i_sb->s_bdev || fm->fc->flags.no_bmap)
 		return 0;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -2699,7 +2699,7 @@ static sector_t fuse_bmap(struct address_space *mapping, sector_t block)
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS)
-		fm->fc->no_bmap = 1;
+		fm->fc->flags.no_bmap = 1;
 
 	return err ? 0 : outarg.block;
 }
@@ -2718,7 +2718,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	struct fuse_lseek_out outarg;
 	int err;
 
-	if (fm->fc->no_lseek)
+	if (fm->fc->flags.no_lseek)
 		goto fallback;
 
 	args.opcode = FUSE_LSEEK;
@@ -2732,7 +2732,7 @@ static loff_t fuse_lseek(struct file *file, loff_t offset, int whence)
 	err = fuse_simple_request(fm, &args);
 	if (err) {
 		if (err == -ENOSYS) {
-			fm->fc->no_lseek = 1;
+			fm->fc->flags.no_lseek = 1;
 			goto fallback;
 		}
 		return err;
@@ -2839,7 +2839,7 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	FUSE_ARGS(args);
 	int err;
 
-	if (fm->fc->no_poll)
+	if (fm->fc->flags.no_poll)
 		return DEFAULT_POLLMASK;
 
 	poll_wait(file, &ff->poll_wait, wait);
@@ -2867,7 +2867,7 @@ __poll_t fuse_file_poll(struct file *file, poll_table *wait)
 	if (!err)
 		return demangle_poll(outarg.revents);
 	if (err == -ENOSYS) {
-		fm->fc->no_poll = 1;
+		fm->fc->flags.no_poll = 1;
 		return DEFAULT_POLLMASK;
 	}
 	return EPOLLERR;
@@ -2953,7 +2953,7 @@ fuse_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * By default, we want to optimize all I/Os with async request
 	 * submission to the client filesystem if supported.
 	 */
-	io->async = ff->fm->fc->async_dio;
+	io->async = ff->fm->fc->flags.async_dio;
 	io->iocb = iocb;
 	io->blocking = is_sync_kiocb(iocb);
 
@@ -3046,7 +3046,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 		     FALLOC_FL_ZERO_RANGE))
 		return -EOPNOTSUPP;
 
-	if (fm->fc->no_fallocate)
+	if (fm->fc->flags.no_fallocate)
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
@@ -3086,7 +3086,7 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	args.in_args[0].value = &inarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_fallocate = 1;
+		fm->fc->flags.no_fallocate = 1;
 		err = -EOPNOTSUPP;
 	}
 	if (err)
@@ -3142,10 +3142,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	ssize_t err;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
-	bool is_unstable = (!fc->writeback_cache) &&
+	bool is_unstable = (!fc->flags.writeback_cache) &&
 			   ((pos_out + len) > inode_out->i_size);
 
-	if (fc->no_copy_file_range)
+	if (fc->flags.no_copy_file_range)
 		return -EOPNOTSUPP;
 
 	if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
@@ -3198,7 +3198,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	args.out_args[0].value = &outarg;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fc->no_copy_file_range = 1;
+		fc->flags.no_copy_file_range = 1;
 		err = -EOPNOTSUPP;
 	}
 	if (err)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ce154e7ab715..4f4a6f912c7c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -543,6 +543,122 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+/**
+ * A Fuse connection.
+ *
+ * This structure is created, when the root filesystem is mounted, and
+ * is destroyed, when the client device is closed and the last
+ * fuse_mount is destroyed.
+ */
+struct fuse_conn_flags {
+	/** Do readahead asynchronously?  Only set in INIT */
+	unsigned async_read:1;
+
+	/** Do not send separate SETATTR request before open(O_TRUNC)  */
+	unsigned atomic_o_trunc:1;
+
+	/** Filesystem supports NFS exporting.  Only set in INIT */
+	unsigned export_support:1;
+
+	/** write-back cache policy (default is write-through) */
+	unsigned writeback_cache:1;
+
+	/** allow parallel lookups and readdir (default is serialized) */
+	unsigned parallel_dirops:1;
+
+	/** handle fs handles killing suid/sgid/cap on write/chown/trunc */
+	unsigned handle_killpriv:1;
+
+	/** cache READLINK responses in page cache */
+	unsigned cache_symlinks:1;
+
+	/*
+	 * The following bitfields are only for optimization purposes
+	 * and hence races in setting them will not cause malfunction
+	 */
+
+	/** Is open/release not implemented by fs? */
+	unsigned no_open:1;
+
+	/** Is opendir/releasedir not implemented by fs? */
+	unsigned no_opendir:1;
+
+	/** Is fsync not implemented by fs? */
+	unsigned no_fsync:1;
+
+	/** Is fsyncdir not implemented by fs? */
+	unsigned no_fsyncdir:1;
+
+	/** Is flush not implemented by fs? */
+	unsigned no_flush:1;
+
+	/** Is setxattr not implemented by fs? */
+	unsigned no_setxattr:1;
+
+	/** Does file server support extended setxattr */
+	unsigned setxattr_ext:1;
+
+	/** Is getxattr not implemented by fs? */
+	unsigned no_getxattr:1;
+
+	/** Is listxattr not implemented by fs? */
+	unsigned no_listxattr:1;
+
+	/** Is removexattr not implemented by fs? */
+	unsigned no_removexattr:1;
+
+	/** Are posix file locking primitives not implemented by fs? */
+	unsigned no_lock:1;
+
+	/** Is access not implemented by fs? */
+	unsigned no_access:1;
+
+	/** Is create not implemented by fs? */
+	unsigned no_create:1;
+
+	/** Is interrupt not implemented by fs? */
+	unsigned no_interrupt:1;
+
+	/** Is bmap not implemented by fs? */
+	unsigned no_bmap:1;
+
+	/** Is poll not implemented by fs? */
+	unsigned no_poll:1;
+
+	/** Do multi-page cached writes */
+	unsigned big_writes:1;
+
+	/** Are BSD file locking primitives not implemented by fs? */
+	unsigned no_flock:1;
+
+	/** Is fallocate not implemented by fs? */
+	unsigned no_fallocate:1;
+
+	/** Is rename with flags implemented by fs? */
+	unsigned no_rename2:1;
+
+	/** Use enhanced/automatic page cache invalidation. */
+	unsigned auto_inval_data:1;
+
+	/** Filesystem is fully responsible for page cache invalidation. */
+	unsigned explicit_inval_data:1;
+
+	/** Does the filesystem support readdirplus? */
+	unsigned do_readdirplus:1;
+
+	/** Does the filesystem want adaptive readdirplus? */
+	unsigned readdirplus_auto:1;
+
+	/** Does the filesystem support asynchronous direct-IO submission? */
+	unsigned async_dio:1;
+
+	/** Is lseek not implemented by fs? */
+	unsigned no_lseek:1;
+
+	/** Does the filesystem support copy_file_range? */
+	unsigned no_copy_file_range:1;
+};
+
 /**
  * A Fuse connection.
  *
@@ -641,30 +757,9 @@ struct fuse_conn {
 	/** Connection successful.  Only set in INIT */
 	unsigned conn_init:1;
 
-	/** Do readahead asynchronously?  Only set in INIT */
-	unsigned async_read:1;
-
 	/** Return an unique read error after abort.  Only set in INIT */
 	unsigned abort_err:1;
 
-	/** Do not send separate SETATTR request before open(O_TRUNC)  */
-	unsigned atomic_o_trunc:1;
-
-	/** Filesystem supports NFS exporting.  Only set in INIT */
-	unsigned export_support:1;
-
-	/** write-back cache policy (default is write-through) */
-	unsigned writeback_cache:1;
-
-	/** allow parallel lookups and readdir (default is serialized) */
-	unsigned parallel_dirops:1;
-
-	/** handle fs handles killing suid/sgid/cap on write/chown/trunc */
-	unsigned handle_killpriv:1;
-
-	/** cache READLINK responses in page cache */
-	unsigned cache_symlinks:1;
-
 	/* show legacy mount options */
 	unsigned int legacy_opts_show:1;
 
@@ -676,92 +771,9 @@ struct fuse_conn {
 	 */
 	unsigned handle_killpriv_v2:1;
 
-	/*
-	 * The following bitfields are only for optimization purposes
-	 * and hence races in setting them will not cause malfunction
-	 */
-
-	/** Is open/release not implemented by fs? */
-	unsigned no_open:1;
-
-	/** Is opendir/releasedir not implemented by fs? */
-	unsigned no_opendir:1;
-
-	/** Is fsync not implemented by fs? */
-	unsigned no_fsync:1;
-
-	/** Is fsyncdir not implemented by fs? */
-	unsigned no_fsyncdir:1;
-
-	/** Is flush not implemented by fs? */
-	unsigned no_flush:1;
-
-	/** Is setxattr not implemented by fs? */
-	unsigned no_setxattr:1;
-
-	/** Does file server support extended setxattr */
-	unsigned setxattr_ext:1;
-
-	/** Is getxattr not implemented by fs? */
-	unsigned no_getxattr:1;
-
-	/** Is listxattr not implemented by fs? */
-	unsigned no_listxattr:1;
-
-	/** Is removexattr not implemented by fs? */
-	unsigned no_removexattr:1;
-
-	/** Are posix file locking primitives not implemented by fs? */
-	unsigned no_lock:1;
-
-	/** Is access not implemented by fs? */
-	unsigned no_access:1;
-
-	/** Is create not implemented by fs? */
-	unsigned no_create:1;
-
-	/** Is interrupt not implemented by fs? */
-	unsigned no_interrupt:1;
-
-	/** Is bmap not implemented by fs? */
-	unsigned no_bmap:1;
-
-	/** Is poll not implemented by fs? */
-	unsigned no_poll:1;
-
-	/** Do multi-page cached writes */
-	unsigned big_writes:1;
-
 	/** Don't apply umask to creation modes */
 	unsigned dont_mask:1;
 
-	/** Are BSD file locking primitives not implemented by fs? */
-	unsigned no_flock:1;
-
-	/** Is fallocate not implemented by fs? */
-	unsigned no_fallocate:1;
-
-	/** Is rename with flags implemented by fs? */
-	unsigned no_rename2:1;
-
-	/** Use enhanced/automatic page cache invalidation. */
-	unsigned auto_inval_data:1;
-
-	/** Filesystem is fully responsible for page cache invalidation. */
-	unsigned explicit_inval_data:1;
-
-	/** Does the filesystem support readdirplus? */
-	unsigned do_readdirplus:1;
-
-	/** Does the filesystem want adaptive readdirplus? */
-	unsigned readdirplus_auto:1;
-
-	/** Does the filesystem support asynchronous direct-IO submission? */
-	unsigned async_dio:1;
-
-	/** Is lseek not implemented by fs? */
-	unsigned no_lseek:1;
-
 	/** Does the filesystem support posix acls? */
 	unsigned posix_acl:1;
 
@@ -771,9 +783,6 @@ struct fuse_conn {
 	/** Allow other than the mounter user to access the filesystem ? */
 	unsigned allow_other:1;
 
-	/** Does the filesystem support copy_file_range? */
-	unsigned no_copy_file_range:1;
-
 	/* Send DESTROY request */
 	unsigned int destroy:1;
 
@@ -804,6 +813,8 @@ struct fuse_conn {
 	/* Is tmpfile not implemented by fs? */
 	unsigned int no_tmpfile:1;
 
+	struct fuse_conn_flags flags;
+
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 33a108cfcefe..c3109e016494 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -224,7 +224,7 @@ u32 fuse_get_cache_mask(struct inode *inode)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
 
-	if (!fc->writeback_cache || !S_ISREG(inode->i_mode))
+	if (!fc->flags.writeback_cache || !S_ISREG(inode->i_mode))
 		return 0;
 
 	return STATX_MTIME | STATX_CTIME | STATX_SIZE;
@@ -282,9 +282,9 @@ void fuse_change_attributes(struct inode *inode, struct fuse_attr *attr,
 
 		if (oldsize != attr->size) {
 			truncate_pagecache(inode, attr->size);
-			if (!fc->explicit_inval_data)
+			if (!fc->flags.explicit_inval_data)
 				inval = true;
-		} else if (fc->auto_inval_data) {
+		} else if (fc->flags.auto_inval_data) {
 			struct timespec64 new_mtime = {
 				.tv_sec = attr->mtime,
 				.tv_nsec = attr->mtimensec,
@@ -380,7 +380,7 @@ struct inode *fuse_iget(struct super_block *sb, u64 nodeid,
 
 	if ((inode->i_state & I_NEW)) {
 		inode->i_flags |= S_NOATIME;
-		if (!fc->writeback_cache || !S_ISREG(attr->mode))
+		if (!fc->flags.writeback_cache || !S_ISREG(attr->mode))
 			inode->i_flags |= S_NOCMTIME;
 		inode->i_generation = generation;
 		fuse_init_inode(inode, attr);
@@ -459,7 +459,7 @@ bool fuse_lock_inode(struct inode *inode)
 {
 	bool locked = false;
 
-	if (!get_fuse_conn(inode)->parallel_dirops) {
+	if (!get_fuse_conn(inode)->flags.parallel_dirops) {
 		mutex_lock(&get_fuse_inode(inode)->mutex);
 		locked = true;
 	}
@@ -911,7 +911,7 @@ static struct dentry *fuse_get_dentry(struct super_block *sb,
 		struct fuse_entry_out outarg;
 		const struct qstr name = QSTR_INIT(".", 1);
 
-		if (!fc->export_support)
+		if (!fc->flags.export_support)
 			goto out_err;
 
 		err = fuse_lookup_name(sb, handle->nodeid, &name, &outarg,
@@ -1011,7 +1011,7 @@ static struct dentry *fuse_get_parent(struct dentry *child)
 	struct fuse_entry_out outarg;
 	int err;
 
-	if (!fc->export_support)
+	if (!fc->flags.export_support)
 		return ERR_PTR(-ESTALE);
 
 	err = fuse_lookup_name(child_inode->i_sb, get_node_id(child_inode),
@@ -1127,44 +1127,44 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-				fc->async_read = 1;
+				fc->flags.async_read = 1;
 			if (!(flags & FUSE_POSIX_LOCKS))
-				fc->no_lock = 1;
+				fc->flags.no_lock = 1;
 			if (arg->minor >= 17) {
 				if (!(flags & FUSE_FLOCK_LOCKS))
-					fc->no_flock = 1;
+					fc->flags.no_flock = 1;
 			} else {
 				if (!(flags & FUSE_POSIX_LOCKS))
-					fc->no_flock = 1;
+					fc->flags.no_flock = 1;
 			}
 			if (flags & FUSE_ATOMIC_O_TRUNC)
-				fc->atomic_o_trunc = 1;
+				fc->flags.atomic_o_trunc = 1;
 			if (arg->minor >= 9) {
 				/* LOOKUP has dependency on proto version */
 				if (flags & FUSE_EXPORT_SUPPORT)
-					fc->export_support = 1;
+					fc->flags.export_support = 1;
 			}
 			if (flags & FUSE_BIG_WRITES)
-				fc->big_writes = 1;
+				fc->flags.big_writes = 1;
 			if (flags & FUSE_DONT_MASK)
 				fc->dont_mask = 1;
 			if (flags & FUSE_AUTO_INVAL_DATA)
-				fc->auto_inval_data = 1;
+				fc->flags.auto_inval_data = 1;
 			else if (flags & FUSE_EXPLICIT_INVAL_DATA)
-				fc->explicit_inval_data = 1;
+				fc->flags.explicit_inval_data = 1;
 			if (flags & FUSE_DO_READDIRPLUS) {
-				fc->do_readdirplus = 1;
+				fc->flags.do_readdirplus = 1;
 				if (flags & FUSE_READDIRPLUS_AUTO)
-					fc->readdirplus_auto = 1;
+					fc->flags.readdirplus_auto = 1;
 			}
 			if (flags & FUSE_ASYNC_DIO)
-				fc->async_dio = 1;
+				fc->flags.async_dio = 1;
 			if (flags & FUSE_WRITEBACK_CACHE)
-				fc->writeback_cache = 1;
+				fc->flags.writeback_cache = 1;
 			if (flags & FUSE_PARALLEL_DIROPS)
-				fc->parallel_dirops = 1;
+				fc->flags.parallel_dirops = 1;
 			if (flags & FUSE_HANDLE_KILLPRIV)
-				fc->handle_killpriv = 1;
+				fc->flags.handle_killpriv = 1;
 			if (arg->time_gran && arg->time_gran <= 1000000000)
 				fm->sb->s_time_gran = arg->time_gran;
 			if ((flags & FUSE_POSIX_ACL)) {
@@ -1173,7 +1173,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fm->sb->s_xattr = fuse_acl_xattr_handlers;
 			}
 			if (flags & FUSE_CACHE_SYMLINKS)
-				fc->cache_symlinks = 1;
+				fc->flags.cache_symlinks = 1;
 			if (flags & FUSE_ABORT_ERROR)
 				fc->abort_err = 1;
 			if (flags & FUSE_MAX_PAGES) {
@@ -1194,15 +1194,15 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 				fm->sb->s_flags |= SB_NOSEC;
 			}
 			if (flags & FUSE_SETXATTR_EXT)
-				fc->setxattr_ext = 1;
+				fc->flags.setxattr_ext = 1;
 			if (flags & FUSE_SECURITY_CTX)
 				fc->init_security = 1;
 			if (flags & FUSE_CREATE_SUPP_GROUP)
 				fc->create_supp_group = 1;
 		} else {
 			ra_pages = fc->max_read / PAGE_SIZE;
-			fc->no_lock = 1;
-			fc->no_flock = 1;
+			fc->flags.no_lock = 1;
+			fc->flags.no_flock = 1;
 		}
 
 		fm->sb->s_bdi->ra_pages =
diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index dc603479b30e..2a5bfb52ebf3 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -18,9 +18,9 @@ static bool fuse_use_readdirplus(struct inode *dir, struct dir_context *ctx)
 	struct fuse_conn *fc = get_fuse_conn(dir);
 	struct fuse_inode *fi = get_fuse_inode(dir);
 
-	if (!fc->do_readdirplus)
+	if (!fc->flags.do_readdirplus)
 		return false;
-	if (!fc->readdirplus_auto)
+	if (!fc->flags.readdirplus_auto)
 		return true;
 	if (test_and_clear_bit(FUSE_I_ADVISE_RDPLUS, &fi->state))
 		return true;
@@ -246,7 +246,7 @@ static int fuse_direntplus_link(struct file *file,
 		if (IS_ERR(dentry))
 			return PTR_ERR(dentry);
 	}
-	if (fc->readdirplus_auto)
+	if (fc->flags.readdirplus_auto)
 		set_bit(FUSE_I_INIT_RDPLUS, &get_fuse_inode(inode)->state);
 	fuse_change_entry_timeout(dentry, o);
 
@@ -455,7 +455,7 @@ static int fuse_readdir_cached(struct file *file, struct dir_context *ctx)
 	 * We're just about to start reading into the cache or reading the
 	 * cache; both cases require an up-to-date mtime value.
 	 */
-	if (!ctx->pos && fc->auto_inval_data) {
+	if (!ctx->pos && fc->flags.auto_inval_data) {
 		int err = fuse_update_attributes(inode, file, STATX_MTIME);
 
 		if (err)
diff --git a/fs/fuse/xattr.c b/fs/fuse/xattr.c
index 0d3e7177fce0..13245c11ce25 100644
--- a/fs/fuse/xattr.c
+++ b/fs/fuse/xattr.c
@@ -19,7 +19,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	struct fuse_setxattr_in inarg;
 	int err;
 
-	if (fm->fc->no_setxattr)
+	if (fm->fc->flags.no_setxattr)
 		return -EOPNOTSUPP;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -30,7 +30,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	args.opcode = FUSE_SETXATTR;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 3;
-	args.in_args[0].size = fm->fc->setxattr_ext ?
+	args.in_args[0].size = fm->fc->flags.setxattr_ext ?
 		sizeof(inarg) : FUSE_COMPAT_SETXATTR_IN_SIZE;
 	args.in_args[0].value = &inarg;
 	args.in_args[1].size = strlen(name) + 1;
@@ -39,7 +39,7 @@ int fuse_setxattr(struct inode *inode, const char *name, const void *value,
 	args.in_args[2].value = value;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_setxattr = 1;
+		fm->fc->flags.no_setxattr = 1;
 		err = -EOPNOTSUPP;
 	}
 	if (!err)
@@ -57,7 +57,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	struct fuse_getxattr_out outarg;
 	ssize_t ret;
 
-	if (fm->fc->no_getxattr)
+	if (fm->fc->flags.no_getxattr)
 		return -EOPNOTSUPP;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -83,7 +83,7 @@ ssize_t fuse_getxattr(struct inode *inode, const char *name, void *value,
 	if (!ret && !size)
 		ret = min_t(ssize_t, outarg.size, XATTR_SIZE_MAX);
 	if (ret == -ENOSYS) {
-		fm->fc->no_getxattr = 1;
+		fm->fc->flags.no_getxattr = 1;
 		ret = -EOPNOTSUPP;
 	}
 	return ret;
@@ -121,7 +121,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	if (!fuse_allow_current_process(fm->fc))
 		return -EACCES;
 
-	if (fm->fc->no_listxattr)
+	if (fm->fc->flags.no_listxattr)
 		return -EOPNOTSUPP;
 
 	memset(&inarg, 0, sizeof(inarg));
@@ -147,7 +147,7 @@ ssize_t fuse_listxattr(struct dentry *entry, char *list, size_t size)
 	if (ret > 0 && size)
 		ret = fuse_verify_xattr_list(list, ret);
 	if (ret == -ENOSYS) {
-		fm->fc->no_listxattr = 1;
+		fm->fc->flags.no_listxattr = 1;
 		ret = -EOPNOTSUPP;
 	}
 	return ret;
@@ -159,7 +159,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 	FUSE_ARGS(args);
 	int err;
 
-	if (fm->fc->no_removexattr)
+	if (fm->fc->flags.no_removexattr)
 		return -EOPNOTSUPP;
 
 	args.opcode = FUSE_REMOVEXATTR;
@@ -169,7 +169,7 @@ int fuse_removexattr(struct inode *inode, const char *name)
 	args.in_args[0].value = name;
 	err = fuse_simple_request(fm, &args);
 	if (err == -ENOSYS) {
-		fm->fc->no_removexattr = 1;
+		fm->fc->flags.no_removexattr = 1;
 		err = -EOPNOTSUPP;
 	}
 	if (!err)
-- 
2.34.1

