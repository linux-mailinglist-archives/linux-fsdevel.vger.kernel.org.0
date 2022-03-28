Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6D54E9216
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 11:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiC1J6P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 05:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240206AbiC1J6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:58:11 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310E452E04;
        Mon, 28 Mar 2022 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648461389; i=@fujitsu.com;
        bh=0Bs19E0WfzggJL9RpkXrc0kSU9KgxaI4TVM403629U4=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=dk0PcyrkIjkt8RkauB1bgMt3tttQsCd4AmJ0HD/bKjmcVN2ltiOwtNzla/G0OmBst
         PFe6F45NzygW4QYqdBOTWho4KOvHZQyVeW6SJvwXO+cTq9FAocPO3kRCckdUvMUgTp
         a6TExibguzaOQ0zmGlV+nwbNErr0mRb0hjK670GryeMSgMIF/VDRf3KG9321Z77eYC
         wZboVrSjmejNl6PKJPvzlPShCZhu/ROhudhjVDjWQvcPMNSiNGJ8lKfS8AHFCKotDw
         wn7+i1ue7pXBkH/1dGJ9mcFDIVnRPd9V3tdBCm6+R0j55sJBGcgNO7VCsf6GK9iB0u
         sWcMVYXJx/YfQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8ORqOvb5ph
  kcHklk8WHm5OYLLYcu8do8XPZKnaLPXtPslic/3uc1YHV49QiCY9NqzrZPD5vkvPY9OQtUwBL
  FGtmXlJ+RQJrxr0/O1kLtohV/Fz4iamB8a1QFyMXh5DAFkaJu40T2CGcBUwS53+3AzmcQM4eR
  onZb1NBbDYBTYlnnQuYQWwRAUeJF+0zWEBsZoECibtn5rKC2MICYRLTTn5i6mLk4GARUJWYOE
  kKJMwr4CExYe0NNhBbQkBBYsrD92BjOAU8JW7P6GOCWOUhMWX/S3aIekGJkzOfQI2XkDj44gU
  zRK+ixKWOb4wQdoXErFltTBC2msTVc5uYJzAKzkLSPgtJ+wJGplWMVklFmekZJbmJmTm6hgYG
  uoaGprqmukampnqJVbqJeqmluuWpxSW6hnqJ5cV6qcXFesWVuck5KXp5qSWbGIFRkFLM+n8HY
  3ffT71DjJIcTEqivEaZjklCfEn5KZUZicUZ8UWlOanFhxhlODiUJHhvNQPlBItS01Mr0jJzgB
  EJk5bg4FES4TVtAkrzFhck5hZnpkOkTjEqSonzMrUCJQRAEhmleXBtsCRwiVFWSpiXkYGBQYi
  nILUoN7MEVf4VozgHo5Iwr0sL0BSezLwSuOmvgBYzAS1e+84WZHFJIkJKqoHp+NsZS3Mur34V
  nXBga85fhSVrjy9VmvHqtlf5bR/t/UsS9XY/nCWoM1FIM+la/x+VA++P/jZenKRtPevWRZMAg
  11WWQf/rRZ023rO7RJTh+bKCJUZF8P+CSgVyNz0aTuxmu/+6U15mUlpwnnS0/WTIpzKj7KEfY
  nxbI24a9dqFtiy6orE4/N7Haev9Dv+pLWx8PpBex7eWwLrLX4k+ryT2zhr78xL7hX/WdakTBY
  2vuq46uu9qVO+/zzJtOzSsdBIhzkOV/eylrF9jRDVctB/HcYhxfbq9+uWdAcBuWlTr7E/Z+1h
  2ih4YHdSQrT+zX8sobY9h994VC/zmaPevOtaxjPTX7Pyv9+vn71bZteHDUosxRmJhlrMRcWJA
  GT9ATx9AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-17.tower-585.messagelabs.com!1648461388!131765!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16125 invoked from network); 28 Mar 2022 09:56:29 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-17.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2022 09:56:29 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 7AF22100198;
        Mon, 28 Mar 2022 10:56:28 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 6DD6810018B;
        Mon, 28 Mar 2022 10:56:28 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 10:56:12 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of on filesystem
Date:   Mon, 28 Mar 2022 17:56:28 +0800
Message-ID: <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
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
S_ISGID clear especially umask with S_IXGRP.

Vfs has all the info it needs - it doesn't need the filesystems to do everything
correctly with the mode and ensuring that they order things like posix acl setup
functions correctly with inode_init_owner() to strip the SGID bit.

Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.

Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
this api may change mode by using umask but S_ISGID clear isn't related to
SB_POSIXACL flag.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c | 4 ----
 fs/namei.c | 7 +++++--
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 1f964e7f9698..a2dd71c2437e 100644
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
index 3f1829b3ab5b..e68a99e0ac96 100644
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
@@ -3521,6 +3522,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
+	inode_sgid_strip(mnt_userns, dir, &mode);
+
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3849,14 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto out1;
-
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
-- 
2.27.0

