Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BE150EF1A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 05:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242859AbiDZDWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 23:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240250AbiDZDWN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 23:22:13 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F917939B3;
        Mon, 25 Apr 2022 20:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650943146; i=@fujitsu.com;
        bh=u31o66RvqjlzILoXUByOPpepwtsEmCeLKTUxGK5xW5U=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=ND58KwO4zE8xrHQEaDJYYpuDIlE0GA9HQJo6GCr5ZMYp/4MkYYo3JQPVY5aC1/MZ3
         2BG2c9J3WPjQEweDKUel5jVCxo8IohKD0AewiSnN5oP5TWi/o9FBHzCV7MIMjBUT/y
         wJqGbjAr3CKs/VNUz9ld/VES+IC9pN+soEskoMFHqv1iEDNFAI7lQ8dmm3rCMWJ5pY
         6VIRuxt4Vky1XGemMsyJ3sUNKY88O7MtvXtwSFV8KEjXyP9p94dgqwqxJiSJlK4F+1
         zJRHBaXK1N9IYtOO43tpAO/QcHvAm5g5mn/rAkHQPcMUM1S+qJs9bH0DadNOyqSiFN
         fAMEyA0WWZa6A==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRWlGSWpSXmKPExsViZ8MRors8JT3
  J4Opna4vXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywW5/8eZ7X4/WMOmwOHx6lFEh6b
  V2h5bFrVyebxeZOcx6Ynb5kCWKNYM/OS8isSWDO6d11nKVgsXnF88Um2Bsb9wl2MXBxCAq8ZJ
  Y59vcwC4exhlDg85xNjFyMnB5uApsSzzgXMILaIgKPEi/YZYEXMAocYJe4f6gJLCAukSPz81s
  gOYrMIqEpcP/AFKM7BwSvgIdG+xhEkLCGgIDHl4Xuwcl4BQYmTM5+wgNjMAhISB1+8YIaoUZS
  41PGNEcKukJg1q41pAiPvLCQts5C0LGBkWsVonVSUmZ5RkpuYmaNraGCga2hoqmtsqWtkYKCX
  WKWbqJdaqlueWlyia6SXWF6sl1pcrFdcmZuck6KXl1qyiREYzCnF6id2MD5d+VPvEKMkB5OSK
  O+WpPQkIb6k/JTKjMTijPii0pzU4kOMMhwcShK8rCA5waLU9NSKtMwcYGTBpCU4eJREeMtA0r
  zFBYm5xZnpEKlTjLocT5+f2MssxJKXn5cqJc7rAoxTIQGQoozSPLgRsCi/xCgrJczLyMDAIMR
  TkFqUm1mCKv+KUZyDUUmYlwNkCk9mXgncpldARzABHfGpNhXkiJJEhJRUA5N0cRO3b07m9ule
  6VXyLt3zXySI+zocmlkweYntDMfE1aJPfl532nckZbmSy4P7slNE+5VSmo7O2pf4OG1/7Ufmp
  Z4CYdWnc+byqr/LuOBy8GGCp/Cf+v/XFvi87LZNfRpl97Reo1yvct7+2vNX3/0/puT2WVVm0n
  7LWXzP78xVscu+ZZpVOC00WyrrzzWF64xPTpf41p3/fbO5oGob87K6sz4VWks2rA0vrOjWefS
  s97rdOTc/Zv+rTy+ItXz6d29XXdOFwFs/M5gUN+x9rTjTV1y78eSifs3/53nqOK5qz9wpumpB
  LFdWUfT6tJvVF7d/+n8h1eqmpLvsmmOeMuKuIb6H836drijheWxn91KJpTgj0VCLuag4EQA9U
  BtgbQMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-571.messagelabs.com!1650943143!212575!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30478 invoked from network); 26 Apr 2022 03:19:03 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-6.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 03:19:03 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 23Q3ItNM019448
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 26 Apr 2022 04:18:57 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 04:18:48 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v7 1/4] fs: move sgid stripping operation from inode_init_owner into mode_strip_sgid
Date:   Tue, 26 Apr 2022 12:19:49 +0800
Message-ID: <1650946792-9545-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This has no functional change. Just create and export mode_strip_sgid
api for the subsequent patch. This function is used to strip S_ISGID mode
when init a new inode.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..e9a5f2ec2f89 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2246,10 +2246,8 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		/* Directories are special, and always inherit S_ISGID */
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
-		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
-			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
-			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
-			mode &= ~S_ISGID;
+		else
+			mode = mode_strip_sgid(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
@@ -2405,3 +2403,34 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+/**
+ * mode_strip_sgid - handle the sgid bit for non-directories
+ * @mnt_userns: User namespace of the mount the inode was created from
+ * @dir: parent directory inode
+ * @mode: mode of the file to be created in @dir
+ *
+ * If the @mode of the new file has both the S_ISGID and S_IXGRP bit
+ * raised and @dir has the S_ISGID bit raised ensure that the caller is
+ * either in the group of the parent directory or they have CAP_FSETID
+ * in their user namespace and are privileged over the parent directory.
+ * In all other cases, strip the S_ISGID bit from @mode.
+ *
+ * Return: the new mode to use for the file
+ */
+umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+			 const struct inode *dir, umode_t mode)
+{
+	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
+		return mode;
+	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return mode;
+	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
+		return mode;
+	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
+		return mode;
+
+	mode &= ~S_ISGID;
+	return mode;
+}
+EXPORT_SYMBOL(mode_strip_sgid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..98b44a2732f5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+			 const struct inode *dir, umode_t mode);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

