Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25750D6DA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 04:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbiDYCNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 22:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240342AbiDYCMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:12:48 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F80A245A0;
        Sun, 24 Apr 2022 19:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650852583; i=@fujitsu.com;
        bh=RWBYLId3RCFClcmAWfKv8545xyB+Ip4xC5W9XQmcaU4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=BJjlssEx1LUQgVfXxf8vc+/i/ZGibc+UV9eCzLKvv71D4+5adEFJ742y6NdYyEpYT
         c3V+86Idu39VWLqHfuNE9lcY4nWf6T3OL7HsQ4EGl+XxG+YVOGMQnlsX4rEjzKvfKk
         /Az0jvs3uhsbSh8/E2mQVRiQ3uSgGN26mlqY/nEDTgL5UlFk7R8QgvCAybYHmcg+6d
         Vfi1OidcibsyciI2vOtBoaXKi3yDJgKZjyNCoSqmO8eAfZTUmHutBs9ShY9pRQmrRE
         /tDw7ejHWHcgCe5hvzEJq/6xe/htr8WA6Vw3+UepL/CtWBVqIcfZ4qvYJrqWtZ8Oao
         0wvJ3C2uxKn/Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGKsWRWlGSWpSXmKPExsViZ8ORqPuUKS3
  J4HKrhcXrw58YLT7cnMRkseXYPUaLy0/4LH4uW8VusWfvSRaL83+Ps1r8/jGHzYHD49QiCY/N
  K7Q8Nq3qZPP4vEnOY9OTt0wBrFGsmXlJ+RUJrBkfev+zFpzxqVi7cAtjA+MGhy5GLg4hgS2ME
  ufnPGaGcBYwSUzZ1MUI4exhlDiwfhJrFyMnB5uApsSzzgXMILaIgKPEi/YZLCA2s8BmRollj8
  O7GDk4hAUSJC5PDAEJswioSiy7sYwdxOYV8JRYeGs1WKuEgILElIfvwWxOAS+JaytOsoHYQkA
  1f3c+Y4KoF5Q4OfMJ1HgJiYMvXkD1Kkpc6vjGCGFXSMya1cYEYatJXD23iXkCo+AsJO2zkLQv
  YGRaxWidVJSZnlGSm5iZo2toYKBraGiqa2yha2RopJdYpZuol1qqW55aXKIL5JYX66UWF+sVV
  +Ym56To5aWWbGIERktKsdqVHYx7Vv3UO8QoycGkJMqbwZiWJMSXlJ9SmZFYnBFfVJqTWnyIUY
  aDQ0mCN+x/apKQYFFqempFWmYOMHJh0hIcPEoivD9+AKV5iwsSc4sz0yFSpxgtOc7v3L+XmWN
  twwEg+ffT373MQix5+XmpUuK8DiC7BEAaMkrz4MbBksslRlkpYV5GBgYGIZ6C1KLczBJU+VeM
  4hyMSsK8VSBTeDLzSuC2vgI6iAnooE+1YAeVJCKkpBqYst9IVBbtYvne/LbwXMuxGcx3f4hfV
  3zbvF1lccG6Z9oBb1tKH202WLCPgy8kmXFKDUNah7XJV55XngmmYRmmZ07wPDy6u+FeoPq/c7
  2BPx95PgnYmHRt5mYDifu3PiueeHLRpObj7sD2i2efHTww7feDR2u7ki8k97mHuXj8qHr+rjF
  MIuTtm5W3w0VZY7NUHkmWfkw8bnqqv/3TChlrzZXvJRnWHHq1LHaRWrSDxv8tXCxl1awCfNxT
  HY5MuyJwte7n/ASVnp5XE+SZQr84Zmp+ydi5u4ffVG7O5eB+508vtmlOO8jmYn1ZtXWlUff/e
  GGbPF+TJ/tnKnm853DXt7KKUPiiVKk8gbf+AkulEktxRqKhFnNRcSIAI6vTy6kDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-22.tower-571.messagelabs.com!1650852581!114958!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19472 invoked from network); 25 Apr 2022 02:09:41 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-22.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2022 02:09:41 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 6290110019B;
        Mon, 25 Apr 2022 03:09:41 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 3FBC8100186;
        Mon, 25 Apr 2022 03:09:41 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 03:09:06 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v6 3/4] fs: strip file's S_ISGID mode on vfs instead of on underlying filesystem
Date:   Mon, 25 Apr 2022 11:09:40 +0800
Message-ID: <1650856181-21350-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
firstly, then posxi acl setup, but xfs uses the contrary order. It will
affect S_ISGID clear especially we filter S_IXGRP by umask or acl.

Regardless of which filesystem is in use, failure to strip the SGID correctly
is considered a security failure that needs to be fixed. The current VFS
infrastructure requires the filesystem to do everything right and not step on
any landmines to strip the SGID bit, when in fact it can easily be done at the
VFS and the filesystems then don't even need to be aware that the SGID needs
to be (or has been stripped) by the operation the user asked to be done.

Vfs has all the info it needs - it doesn't need the filesystems to do everything
correctly with the mode and ensuring that they order things like posix acl setup
functions correctly with inode_init_owner() to strip the SGID bit.

Just strip the SGID bit at the VFS, and then the filesystem can't get it wrong.

Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
this api may change mode.

Only the following places use inode_init_owner
"
arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);
"

They are used in filesystem to init new inode function and these init inode
functions are used by following operations:
mkdir
symlink
mknod
create
tmpfile
rename

We don't care about mkdir because we don't strip SGID bit for directory except
fs.xfs.irix_sgid_inherit. But we even call prepare_mode() in do_mkdirat() since
inode_sgid_strip() will skip directories anyway. This will enforce the same
ordering for all relevant operations and it will make the code more uniform and
easier to understand by using new helper prepare_mode().

symlink and rename only use valid mode that doesn't have SGID bit.

We have added inode_sgid_strip api for the remaining operations.

In addition to the above six operations, four filesystems has a little difference
1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit
   mode and can ignore
2) ocfs2 reflink function should add inode_sgid_strip api manually because this ioctl
   is only useful when backport reflink features to old kernels. ocfs2 still use vfs
   remap_range code to do reflink.
3) spufs which doesn't really go hrough the regular VFS callpath because it has
   separate system call spu_create, but it t only allows the creation of
   directories and only allows bits in 0777 and can ignore
4) bpf use vfs_mkobj in bpf_obj_do_pin with
   "S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask()) mode and
   use bpf_mkobj_ops in bpf_iter_link_pin_kernel with S_IFREG | S_IRUSR mode,
   so bpf is also not affected

This patch also changed grpid behaviour for ext4/xfs because the mode passed to
them may been changed by inode_sgid_strip.

Also as Christian Brauner said"
The patch itself is useful as it would move a security sensitive operation that is
currently burried in individual filesystems into the vfs layer. But it has a decent
regression  potential since it might strip filesystems that have so far relied on
getting the S_ISGID bit with a mode argument. So this needs a lot of testing and
long exposure in -next for at least one full kernel cycle."

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         |  2 --
 fs/namei.c         | 22 +++++++++-------------
 fs/ocfs2/namei.c   |  1 +
 include/linux/fs.h | 11 +++++++++++
 4 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 78e7ef567e04..041c0837f248 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else
-			mode = inode_sgid_strip(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
diff --git a/fs/namei.c b/fs/namei.c
index 73646e28fae0..5b8e6288d503 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3287,8 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		if (!IS_POSIXACL(dir->d_inode))
-			mode &= ~current_umask();
+		mode = prepare_mode(mnt_userns, dir->d_inode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(mnt_userns, &nd->path,
 						    dentry, mode);
@@ -3521,8 +3520,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
+	mode = prepare_mode(mnt_userns, dir, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3850,13 +3848,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
+	mnt_userns = mnt_user_ns(path.mnt);
+	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (error)
 		goto out2;
 
-	mnt_userns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(mnt_userns, path.dentry->d_inode,
@@ -3943,6 +3940,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
+	struct user_namespace *mnt_userns;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -3950,15 +3948,13 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	if (IS_ERR(dentry))
 		goto out_putname;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
+	mnt_userns = mnt_user_ns(path.mnt);
+	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
 	error = security_path_mkdir(&path, dentry, mode);
-	if (!error) {
-		struct user_namespace *mnt_userns;
-		mnt_userns = mnt_user_ns(path.mnt);
+	if (!error)
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
-	}
+
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
 		lookup_flags |= LOOKUP_REVAL;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c75fd54b9185..21f3da2e66c9 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
+	mode = inode_sgid_strip(&init_user_ns, dir, mode);
 	inode_init_owner(&init_user_ns, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 532de76c9b91..ca70cdf9c9e2 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3459,6 +3459,17 @@ static inline bool dir_relax_shared(struct inode *inode)
 	return !IS_DEADDIR(inode);
 }
 
+static inline umode_t prepare_mode(struct user_namespace *mnt_userns,
+				   const struct inode *dir, umode_t mode)
+{
+	mode = inode_sgid_strip(mnt_userns, dir, mode);
+
+	if (!IS_POSIXACL(dir))
+		mode &= ~current_umask();
+
+	return mode;
+}
+
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
-- 
2.27.0

