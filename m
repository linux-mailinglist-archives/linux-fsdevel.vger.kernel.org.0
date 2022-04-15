Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A7A5027F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352108AbiDOKGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350085AbiDOKGW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:06:22 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE8CBB90D;
        Fri, 15 Apr 2022 03:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650017031; i=@fujitsu.com;
        bh=JYxOrOmzPww5e/cvLOKV4C/Tg6MwUBO/ELdaoQEDCRM=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=IIzAzF0BB4MtWZCaiEmit0gw0RqVsGWaxuI0H11xR4nY6K5uy5tPRIx1SC0ahqSup
         na5S5F/Iu4/EMnA6m5Y8fhwQrKJ6qA0Glk4jS4MkKZpf+cvSMeML/0Ddh5OeQsu/EZ
         thfd2FlziGwcQbMq9/OVH6uOQVvfnvMV7dBIeowHkJ2n9aUE7UnO9Ax+2+FU3Zu2mk
         61C+IdSc1B6lOj9veXrmzP126GKMeV7La5E0xhCTWb4IPnYzYU7c4E21Jr77ZSGKgs
         jwL4ej5AoyL0wFmxzU8uLD82SJtaYDSG2IUxSiIAYDmjzb7MUkVfqxmVXRomfu2fNz
         y8h/SdS0M7hUg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRWlGSWpSXmKPExsViZ8MxRZfdOTL
  J4EuoxevDnxgtPtycxGSx5dg9RovLT/gsfi5bxW6xZ+9JFosLB06zWuz6s4Pd4vzf46wOnB6n
  Fkl4bFrVyebxeZOcx6Ynb5kCWKJYM/OS8isSWDPu3LzDVHDftuLmo/1sDYwvjbsYuTiEBF4zS
  nyfeYoJwtnDKPH10C/GLkZODjYBTYlnnQuYQWwRAReJhRPWM4IUMQu8YpSYvncGC0hCWCBB4l
  XXTNYuRg4OFgFVidVLCkHCvAKeEse3n2QHsSUEFCSmPHzPDFLCKeAl8f9sLUhYCKhk6qTLbBD
  lghInZz4Bm8gsICFx8MULZohWRYlLHd8YIewKiVmz2pgmMPLPQtIyC0nLAkamVYxWSUWZ6Rkl
  uYmZObqGBga6hoamukDS1EQvsUo3US+1VLc8tbhE11AvsbxYL7W4WK+4Mjc5J0UvL7VkEyMw8
  FOKGWbtYJzV91PvEKMkB5OSKO9b0cgkIb6k/JTKjMTijPii0pzU4kOMMhwcShK8f+2BcoJFqe
  mpFWmZOcAohElLcPAoifCGWgOleYsLEnOLM9MhUqcYLTnO79y/l5ljbcMBIPn309+9zEIsefl
  5qVLivMJOQA0CIA0ZpXlw42CJ4hKjrJQwLyMDA4MQT0FqUW5mCar8K0ZxDkYlYV5jkCk8mXkl
  cFuBUQb0iwjvt1WhIAeVJCKkpBqYLiip7KyNCzlQZ5NT/kv0v8HO639E+i8YvitlZ2XrM7r4P
  a30f95U7+Yt8e5eNbeevji0dc2yS5FH9z76+jGuhNU3YdXGvTX8bo9Kn/wqrGBOuX3DK3Fl4a
  /XtdIWG5b2HNDx9Jsht/z7nnccHQKxZ1tFpP80hM76Jrg2pLD2uMBR+bVrVq7/+yoq7Kf7jBo
  5vo0TFP7lmDRv+HrvQaPTwb6iqmxBb4V/XSyr1WvdixeKTd4+S/zl/1N8jkzKjw7cMvt9IPyS
  tmfaK1+P0qNrGI1nSR44xJFdxbzHfFNNoU7g68bl2yzuf+RPu9LGH+V1+43d4pZlF29M2mfgb
  HdtrZiCR9TLnyz3Ihyff4iLVWIpzkg01GIuKk4EALd1ZbiPAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1650017030!56429!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18592 invoked from network); 15 Apr 2022 10:03:50 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:03:50 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23FA3obE003897
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 15 Apr 2022 11:03:50 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:03:46 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 6/7] fs: strip file's S_ISGID mode on vfs instead of on underlying filesystem
Date:   Fri, 15 Apr 2022 19:02:22 +0800
Message-ID: <1650020543-24908-6-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
S_ISGID clear especially we filter S_IXGRP by umask or acl.

Regardless of which filesystem is in use, failure to strip the SGID correctly is
considered a security failure that needs to be fixed. The current VFS infrastructure
requires the filesystem to do everything right and not step on any landmines to
strip the SGID bit, when in fact it can easily be done at the VFS and the filesystems
then don't even need to be aware that the SGID needs to be (or has been stripped) by
the operation the user asked to be done.

Vfs has all the info it needs - it doesn't need the filesystems to do everything
correctly with the mode and ensuring that they order things like posix acl setup
functions correctly with inode_init_owner() to strip the SGID bit.

Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.

Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
this api may change mode.

Only the following places use inode_init_owner
"hugetlbfs/inode.c:846:          inode_init_owner(&init_user_ns, inode, dir, mode);
 nilfs2/inode.c:354:     inode_init_owner(&init_user_ns, inode, dir, mode);
 zonefs/super.c:1289:    inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
 reiserfs/namei.c:619:   inode_init_owner(&init_user_ns, inode, dir, mode);
 jfs/jfs_inode.c:67:     inode_init_owner(&init_user_ns, inode, parent, mode);
 f2fs/namei.c:50:        inode_init_owner(mnt_userns, inode, dir, mode);
 ext2/ialloc.c:549:              inode_init_owner(&init_user_ns, inode, dir, mode);
 overlayfs/dir.c:643:    inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
 ufs/ialloc.c:292:       inode_init_owner(&init_user_ns, inode, dir, mode);
 ntfs3/inode.c:1283:     inode_init_owner(mnt_userns, inode, dir, mode);
 ramfs/inode.c:64:               inode_init_owner(&init_user_ns, inode, dir, mode);
 9p/vfs_inode.c:263:     inode_init_owner(&init_user_ns, inode, NULL, mode);
 btrfs/tests/btrfs-tests.c:65:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
 btrfs/inode.c:6215:     inode_init_owner(mnt_userns, inode, dir, mode);
 sysv/ialloc.c:166:      inode_init_owner(&init_user_ns, inode, dir, mode);
 omfs/inode.c:51:        inode_init_owner(&init_user_ns, inode, NULL, mode);
 ubifs/dir.c:97: inode_init_owner(&init_user_ns, inode, dir, mode);
 udf/ialloc.c:108:       inode_init_owner(&init_user_ns, inode, dir, mode);
 ext4/ialloc.c:979:              inode_init_owner(mnt_userns, inode, dir, mode);
 hfsplus/inode.c:393:    inode_init_owner(&init_user_ns, inode, dir, mode);
 xfs/xfs_inode.c:840:            inode_init_owner(mnt_userns, inode, dir, mode);
 ocfs2/dlmfs/dlmfs.c:331:                inode_init_owner(&init_user_ns, inode, NULL, mode);
 ocfs2/dlmfs/dlmfs.c:354:        inode_init_owner(&init_user_ns, inode, parent, mode);
 ocfs2/namei.c:200:      inode_init_owner(&init_user_ns, inode, dir, mode);
 minix/bitmap.c:255:     inode_init_owner(&init_user_ns, inode, dir, mode);
 bfs/dir.c:99:   inode_init_owner(&init_user_ns, inode, dir, mode);
"

They are used in filesystem init new inode function and these init inode functions are used
by following operations:
mkdir
symlink
mknod
create
tmpfile
rename

We don't care about mkdir because we don't strip SGID bit for directory except fs.xfs.irix_sgid_inherit.
But we even call it in do_mkdirat() since inode_sgid_strip() will skip directories anyway. This will
enforce the  same ordering for all relevant operations and it will make the code more uniform and
easier to understand by using prepare_mode().

symlink and rename only use valid mode that doesn't have SGID bit.

We have added inode_sgid_strip api for the remaining operations.

In addition to the above six operations, two filesystems has a little difference
1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit mode and can ignore
2) ocfs2 reflink function should add inode_sgid_strip api manually because we don't add it in vfs

This patch also changed grpid behaviour for ext4/xfs because the mode passed to them may been
changed by inode_sgid_strip.

Also as Christian Brauner said"
The patch itself is useful as it would move a security sensitive operation that is currently burried in
individual filesystems into the vfs layer. But it has a decent regression  potential since it might strip
filesystems that have so far relied on getting the S_ISGID bit with a mode argument. So this needs a lot
of testing and long exposure in -next for at least one full kernel cycle."

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v2->v3:
1.use new helper prepare_mode to do inode sgid strip and umask strip
2.also use prepare_mode() for mkdirat
 fs/inode.c       |  2 --
 fs/namei.c       | 14 +++++---------
 fs/ocfs2/namei.c |  1 +
 3 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1b569ad882ce..a250aa01d3c3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else
-			inode_sgid_strip(mnt_userns, dir, &mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
diff --git a/fs/namei.c b/fs/namei.c
index bbc7c950bbdc..0fadc884af7f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3287,8 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		if (!IS_POSIXACL(dir->d_inode))
-			mode &= ~current_umask();
+		prepare_mode(mnt_userns, dir->d_inode, &mode);
 		if (likely(got_write))
 			create_error = may_o_create(mnt_userns, &nd->path,
 						    dentry, mode);
@@ -3521,8 +3520,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
+	prepare_mode(mnt_userns, dir, &mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3852,13 +3850,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
+	mnt_userns = mnt_user_ns(path.mnt);
+	prepare_mode(mnt_userns, path.dentry->d_inode, &mode);
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (error)
 		goto out2;
 
-	mnt_userns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(mnt_userns, path.dentry->d_inode,
@@ -3952,12 +3949,11 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	if (IS_ERR(dentry))
 		goto out_putname;
 
-	if (!IS_POSIXACL(path.dentry->d_inode))
-		mode &= ~current_umask();
 	error = security_path_mkdir(&path, dentry, mode);
 	if (!error) {
 		struct user_namespace *mnt_userns;
 		mnt_userns = mnt_user_ns(path.mnt);
+		prepare_mode(mnt_userns, path.dentry->d_inode, &mode);
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
 	}
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c75fd54b9185..c81b8e0847aa 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -198,6 +198,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
 	inode_init_owner(&init_user_ns, inode, dir, mode);
+	inode_sgid_strip(&init_user_ns, dir, &mode);
 	status = dquot_initialize(inode);
 	if (status)
 		return ERR_PTR(status);
-- 
2.27.0

