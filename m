Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0231352EEC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 17:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350638AbiETPK1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 11:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244681AbiETPKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 11:10:23 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81657170657;
        Fri, 20 May 2022 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1653059420; i=@fujitsu.com;
        bh=e8B5juuhS5toG5hw6zygxw/VPuvjMx9f/RS70eZ4JIA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=WElLPHirCQ6ngd84DCKP3el7h+G1GXwPAhd+2s+qMNcjnQ9u/a4C/UNcv6wv6xvFZ
         FLy3hC48lZaowJGrnjZ+HFk9/Q3jSMCsnKTLHAIWM+5P25un+wDllF4qv7Yf23W28J
         +CC2weXtVrKXxYayda25+wYNBbfogcJMXgyXSn72mfXqHTChNoX+DCGHXfldpMf9qQ
         SHyqKUUXU4FmHTaOOTMaQBQnZTSxENVY/yCyMNXMCN4zottHY+OMnAHKen6XlyGAkG
         IO7m45cfY5iLx/gGvb9HYH3wXLVAEufb0iIHnm+stSN3eQHzgh+T2sRGZeQ+zN4sgj
         Lq4JFvMQ1//rQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRWlGSWpSXmKPExsViZ8MxSTd6fXu
  SwcpnXBavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1kszv89zmrx+8ccNgcOj1OLJDw2
  r9Dy2LSqk83j8yY5j01P3jIFsEaxZuYl5VcksGbcv/6TpeCUbMXMJ/eZGxh/SnQxcnEICWxhl
  Pj97zUjhLOASWLts9+sEM4eRonmm4tYuhg5OdgENCWedS5gBrFFBBwlXrTPAIszC2xmlFj2OB
  zEFhawkDh3YhkbiM0ioCqx5/cdRhCbV8BD4tCPZiYQW0JAQWLKw/fMEHFBiZMzn0DNkZA4+OI
  FM0SNosSljm+MEHaFxOvDl6DiahJXz21insDIPwtJ+ywk7QsYmVYxWiUVZaZnlOQmZuboGhoY
  6BoamuoaW+paGOklVukm6qWW6panFpfoArnlxXqpxcV6xZW5yTkpenmpJZsYgcGfUqwetIPx2
  4qfeocYJTmYlER5S1e0JwnxJeWnVGYkFmfEF5XmpBYfYpTh4FCS4M1ZA5QTLEpNT61Iy8wBRi
  JMWoKDR0mEV34tUJq3uCAxtzgzHSJ1ilFRSpzXbh1QQgAkkVGaB9cGi/5LjLJSwryMDAwMQjw
  FqUW5mSWo8q8YxTkYlYR5VVcDTeHJzCuBm/4KaDET0OJbyq0gi0sSEVJSDUzFTxJcdT1CIvc+
  57Au+q88Q55RaMelRb90hYofex68dyZK+kNncRL3qdZlbZP745RPl99VyZstw5oW99Pz5PodH
  j0HWH5p7r139PXx7t0bWxrZZ88JEopaE+cxzXK/it/S3zMX6waeXtHg8khydaRf7WzhAt+yx6
  v87undO/PvqkmaQGC1Qb1nLPvuaaJKvA/Y+f4zlOxb1n7jrlC3yxvFj7tWhx2PKVYsvlxm/YY
  h4dEtJp477zWS/+008slb7DN1lumWaZ1alhz5DSqHwn72LxG5OSVg82uXu9Zi03TdJd4/iWaZ
  bLTYhO2PAkNQaesVXSaV741PrDnPa2kmbNyxyPFoT9BqofXpS42bC5VYijMSDbWYi4oTAV6i+
  5Z5AwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-7.tower-571.messagelabs.com!1653059418!68365!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 462 invoked from network); 20 May 2022 15:10:19 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-7.tower-571.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 20 May 2022 15:10:19 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id B6A63100359;
        Fri, 20 May 2022 16:10:18 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id A8F9D1000FB;
        Fri, 20 May 2022 16:10:18 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 20 May 2022 16:09:55 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v9 1/4] fs: add mode_strip_sgid() helper
Date:   Sat, 21 May 2022 00:10:34 +0800
Message-ID: <1653063037-2461-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
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
Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v8->v9: 
1.move if orders in mode_strip_sgid helper
2.xfstests testcase url
https://patchwork.kernel.org/project/fstests/list/?series=643643
 fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..37bd85981d38 100644
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
+			const struct inode *dir, umode_t mode)
+{
+	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return mode;
+	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
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
index bbde95387a23..3bccb7ba44a5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
+			const struct inode *dir, umode_t mode);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

