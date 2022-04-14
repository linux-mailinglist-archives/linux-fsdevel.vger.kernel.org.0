Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40DAA500678
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 08:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiDNG7g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 02:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDNG7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:59:35 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DBE54BDB;
        Wed, 13 Apr 2022 23:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649919422; i=@fujitsu.com;
        bh=w6Q7o/IWhNXvK1HohCBprtiMbt9n3XqxXMz6F3igtm4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=fS0XEOVzh2tbe7uX2WIosgk0v/3PRS23r29cCf76lMB2qXEiM7RU1eHVTMLMRUxhf
         v/+spHb+7NdkoZy8yYoofP7w3MZlMoOxa1SK9XqUBSFsHMPbqpvzwaIFTARWbFwLL6
         HiAQ3Vkw4izqXGRcgS8SfDzUW2cWl2n7h0ExtTZllG0cSNqe3VNjOA1eQF+1s6mJQU
         eqE2nK30kSrqbb3/yNQnz1cs5ECuUzDix5uNmcyjghGsYldoUhyibZ10PJ6b8CTwTe
         6F8wpiLUovxFDvkw+hIWda2/4U6JIN04f9acGnOqFCBFb9310hSSih/yeO+rfrgQln
         tSAnVKqXFbCXg==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRWlGSWpSXmKPExsViZ8MRorv3aHi
  SwZvj5havD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1ksdr05x25x/u9xVgcOj1OLJDw2
  repk87iw7A2bx+dNch6bnrxlCmCNYs3MS8qvSGDNOPf6BHtBi0nF+XVrmRsYH2h3MXJyCAm8Z
  pR4fUC0i5ELyN7DKDF/7k42kASbgKbEs84FzCC2iEC6xJy5V5lBipgFVjNKnJ6+nBEkISyQKP
  FtSjdTFyMHB4uAqkTbXxYQk1fAQ2LKXS2QCgkBBYkpD9+DjeEU8JTo232XEWKvh8T2S3+ZQGx
  eAUGJkzOfsIDYzAISEgdfvGCG6FWUuNTxjRHCrpCYNauNaQIj/ywkLbOQtCxgZFrFaJ1UlJme
  UZKbmJmja2hgoGtoaKprbKFraGSul1ilm6iXWqpbnlpcomukl1herJdaXKxXXJmbnJOil5das
  okRGPopxWr1OxhfrPypd4hRkoNJSZS3cHF4khBfUn5KZUZicUZ8UWlOavEhRhkODiUJXuGDQD
  nBotT01Iq0zBxgHMKkJTh4lER4cw8DpXmLCxJzizPTIVKnGC05zu/cv5eZY23DASD599Pfvcx
  CLHn5ealS4rwbQBoEQBoySvPgxsFSxSVGWSlhXkYGBgYhnoLUotzMElT5V4ziHIxKwrzhR4Cm
  8GTmlcBtfQV0EBPQQd9WhYIcVJKIkJJqYBKoKMitXruJeXW34PIayQJb9g+KPz1KHHyOb8ooU
  a3SMtt927LrcoT9Yk/1aeyvxUoMpm1Zxp5iKKe76uLxSxyRGYHH3t9b96Hz1LbMDQe26J+5IF
  i05MC6TbwdwlnPr1xPzuD44T+RU3etlcz35m2ODuujhKddclK9kDxvjo7v8TdhW3fV1p57Hv1
  06S7d7df0P8oevBSkustltqMn4wE9qfWrshPPB9U/iErMzjvpt1qxiOmkBespy1VNgY6hmVc4
  b5WVun/P/V4g57H4lsenc4p8GbPD7jx2LevisxScMrcmc7fqiWzpkkcirVb/WE5v1O5feXpKh
  qlL5e/W46d+713x3cJiR8WONBHlj0osxRmJhlrMRcWJANraXfGQAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-13.tower-548.messagelabs.com!1649919421!184232!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 24734 invoked from network); 14 Apr 2022 06:57:01 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-13.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Apr 2022 06:57:01 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23E6unTR031938
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 14 Apr 2022 07:56:55 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 07:56:45 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <brauner@kernel.org>, <djwong@kernel.org>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 2/3] vfs: strip file's S_ISGID mode on vfs instead of on underlying filesystem
Date:   Thu, 14 Apr 2022 15:57:18 +0800
Message-ID: <1649923039-2273-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
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
symlink and rename only use valid mode that doesn't have SGID bit.

We have added inode_sgid_strip api for the remaining operations.

In addition to the above six operations, two filesystems has a little difference
1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit mode and can ignore
2) ocfs2 reflink function should add inode_sgid_strip api manually because we don't add it in vfs

Last but not least, this patch also changed grpid behaviour for ext4/xfs because the mode passed to
them may been changed by inode_sgid_strip.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c       | 4 ----
 fs/namei.c       | 5 ++++-
 fs/ocfs2/namei.c | 1 +
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index d63264998855..b08bdd73e116 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,10 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
-			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
diff --git a/fs/namei.c b/fs/namei.c
index 3f1829b3ab5b..e03f7defdd30 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3287,6 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
+		inode_sgid_strip(mnt_userns, dir->d_inode, &mode);
 		if (!IS_POSIXACL(dir->d_inode))
 			mode &= ~current_umask();
 		if (likely(got_write))
@@ -3521,6 +3522,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
+	inode_sgid_strip(mnt_userns, dir, &mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3850,13 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
+	mnt_userns = mnt_user_ns(path.mnt);
+	inode_sgid_strip(mnt_userns, path.dentry->d_inode, &mode);
 	if (!IS_POSIXACL(path.dentry->d_inode))
 		mode &= ~current_umask();
 	error = security_path_mknod(&path, dentry, mode, dev);
 	if (error)
 		goto out2;
 
-	mnt_userns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(mnt_userns, path.dentry->d_inode,
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index c75fd54b9185..f1d626697302 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
 	 * callers. */
 	if (S_ISDIR(mode))
 		set_nlink(inode, 2);
+	inode_sgid_strip(&init_user_ns, dir, &mode);
 	inode_init_owner(&init_user_ns, inode, dir, mode);
 	status = dquot_initialize(inode);
 	if (status)
-- 
2.27.0

