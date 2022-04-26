Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E3150FAA8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 12:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349052AbiDZKds (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349103AbiDZKdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:33:10 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED7133E69;
        Tue, 26 Apr 2022 03:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650967832; i=@fujitsu.com;
        bh=8pp32TE4VyGS0yHFL59khUccAQydTBIkgLyi5kpoUBg=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=TnXZk9S5M53Dcf3cg99KZiKwRrE8M3bM3FM0m7nU5N+ye0HSGYVdHi4qlTPVJIq1r
         eQtseweE/LvVKy29/GqSApKtxnsEtTsPO5JKoEt5aoS8H8ObTaWMEGiVa1rUBn6uqb
         C9/Jfr4EICRcAVq1xPO4nLsLB0buNX851ds1K8B7tbsNKvpbbDYnBGxT2rX6RIOHI1
         uOvJL1Ui9++/lgANvw2QvGBYUcgjnXGR/5/kE30UxFsmzhtIILZKqwvbHx43/c8HZG
         /Y+4r9Qf/chay3T7p+XqrJkEnbLNKgR5p/vFWGygaw4FFWgtJyJ0/qZO47r5DkUM8c
         J4DzWd64J0s9w==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKIsWRWlGSWpSXmKPExsViZ8MxSVf8aHq
  Swds5WhavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1kszv89zmrx+8ccNgcOj1OLJDw2
  r9Dy2LSqk83j8yY5j01P3jIFsEaxZuYl5VcksGbsmGVY0CZTcWDNB+YGxsPiXYxcHEICWxgl2
  nadZYZwFjBJPOs5wg7h7GGU6FuxBsjh5GAT0JR41rmAGcQWEXCUeNE+gwXEZhbYzCix7HE4iC
  0sYCHRePseI4jNIqAqsftDF1gNr4CHxPRvf5lAbAkBBYkpD98zQ8QFJU7OfAI1R0Li4IsXzBA
  1ihKXOr4xQtgVErNmtUH1qklcPbeJeQIj/ywk7bOQtC9gZFrFaJVUlJmeUZKbmJmja2hgoGto
  aKprpmtoZqmXWKWbqJdaqlueWlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREY+inFbCt3MK7s+
  6l3iFGSg0lJlFdnX3qSEF9SfkplRmJxRnxRaU5q8SFGGQ4OJQnewENAOcGi1PTUirTMHGAcwq
  QlOHiURHjfHgZK8xYXJOYWZ6ZDpE4xKkqJ8y7fC5QQAElklObBtcFi/xKjrJQwLyMDA4MQT0F
  qUW5mCar8K0ZxDkYlYYjxPJl5JXDTXwEtZgJa/Kk2FWRxSSJCSqqBie/r30M8QQxuSkeK586R
  XTxxX+i7jgMBE2bkJXVyfuna3xZgdLWw9wp3bvPtWOE/h3eoLbv+5gD/UXb2kG8Lj10VTF4p0
  zdN5IjE/bBUvsjev4tNq43OOV79sebb6QavFxXzP31kqXMUfHnBPXJr3fSivq86IXdmfDuwh/
  Xu7a23nj631fnDp/Q0XtP477uML0vP1K2975B/+qHk1kvzjL12GO4xnH1O1P+joo3D2bvy55M
  OuRufU48W54mdz72j55jlz64NMYzNobP+SpV7rWRhb8lfsSx66olNB1e1KV15/Ps5h8kHtfX8
  zM4rfk1JsDbsXVOfuWWe5KqJl9lK+p1sfrbtZ13m1sI8e8GnvF1KLMUZiYZazEXFiQAeFiBXe
  AMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-12.tower-585.messagelabs.com!1650967831!244931!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 18865 invoked from network); 26 Apr 2022 10:10:31 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-12.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 26 Apr 2022 10:10:31 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 28FC9100464;
        Tue, 26 Apr 2022 11:10:31 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 1BB6C10032A;
        Tue, 26 Apr 2022 11:10:31 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 26 Apr 2022 11:10:10 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Date:   Tue, 26 Apr 2022 19:11:27 +0800
Message-ID: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

Add a dedicated helper to handle the setgid bit when creating a new file
in a setgid directory. This is a preparatory patch for moving setgid
stripping into the vfs. The patch contains no functional changes.

Currently the setgid stripping logic is open-coded directly in
inode_init_owner() and the individual filesystems are responsible for
handling setgid inheritance. Since this has proven to be brittle as
evidenced by old issues we uncovered over the last months (see [1] to
[3] below) we will try to move this logic into the vfs.

Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
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

