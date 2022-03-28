Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0392A4E9217
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Mar 2022 11:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbiC1J6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Mar 2022 05:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbiC1J6L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Mar 2022 05:58:11 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA8051E69;
        Mon, 28 Mar 2022 02:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1648461389; i=@fujitsu.com;
        bh=8WLbO1HqnbbPgRObIU30uOMWqLPFjYyA8VcaYzltLzw=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=D1K3aqQhfLkg6vqn57j520MvjcULgHRtQ8jqIq63miM+DqalzhRfkPznez24G8AED
         pT8qGb+n5aLS7ZSmhFcOLSNztrrgFe36MjZS/MmcFlpR/RW/E8vgnA+uCack62RmZG
         Xzfbqi4X8o/8vURqVcXsdeJCnEHHxIuilxkOs7MrXrUY+Ujcs18mn5s5loI+upptaU
         pNvNCI7eQcVcxNip3jn0mkHvHJod6g6a4IfMkFNarf18XjYAoWFvn/2UkZibA0Fdvw
         WNsRWK+Ow7oEejJTa6k0Hsu8IRjV7IjFG5UZHnQoM5VII/lPTuoF+EjAiX2ubi++v/
         iIqpj2f3tN8OQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRWlGSWpSXmKPExsViZ8ORqOvT5ph
  k8OW5jcWHm5OYLLYcu8do8XPZKnaLPXtPslic/3uc1YHV49QiCY9NqzrZPD5vkvPY9OQtUwBL
  FGtmXlJ+RQJrxsFPe9kKenkqlsxeytLAuIKri5GTQ0hgC6PEg8eFXYxcQPYCJon38y8zQzh7G
  CUWH1jIAlLFJqAp8axzATOILSLgKPGifQZYnFmgQOLumbmsILawgLnE38WXmUBsFgFViWkNzW
  D1vAIeEstXrGIDsSUEFCSmPHwPFReUODnzCdQcCYmDL14wQ9QoSlzq+MYIYVdIzJrVxgRhq0l
  cPbeJeQIj/ywk7bOQtC9gZFrFaJVUlJmeUZKbmJmja2hgoGtoaKprqGtkYKyXWKWbqJdaqlue
  Wlyia6iXWF6sl1pcrFdcmZuck6KXl1qyiREY1inFjKd3MG7q+6l3iFGSg0lJlNco0zFJiC8pP
  6UyI7E4I76oNCe1+BCjDAeHkgTvrWagnGBRanpqRVpmDjDGYNISHDxKIrymTUBp3uKCxNzizH
  SI1ClGRSlx3oZWoIQASCKjNA+uDRbXlxhlpYR5GRkYGIR4ClKLcjNLUOVfMYpzMCoJ87q0AE3
  hycwrgZv+CmgxE9Dite9sQRaXJCKkpBqYtNdwiXJozb3M+Z3X1m3NVaF7FmfMg7r/BmZd2NB4
  RXb/l12GSQmxPp+/6m6fGKe1qlw9KiziyoJ7D1N/rCo3/7HJ58ef+/5OAjOlE/TcGa43rt5vv
  uDQ0icxdZ8FwhrY926bcMj7j/PGpvRfC46E5UYnKl78PPGRiZxzwsx3QRNCPvYzCuX45WlfnG
  lqHnErZdbp9t6PyZz8PcbpPBmBjf9Mt3TKKHWmb7wlkb0zNuDbMYkzTC83bqziEBIWOxF77Mn
  8La4uHVlM/g6OB6b/MD7j2dfNbfrSM+6AaV3LyWvKgv+0u5l+vw+d80fl9tVHG9w22sgXnD0k
  6GsW2+3t3vSR1WzbRb7nE7fpLSpTYinOSDTUYi4qTgQA+KWMc2YDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-21.tower-585.messagelabs.com!1648461388!131717!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 11169 invoked from network); 28 Mar 2022 09:56:28 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-21.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Mar 2022 09:56:28 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id 74DE9100192;
        Mon, 28 Mar 2022 10:56:28 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id 67EC9100183;
        Mon, 28 Mar 2022 10:56:28 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 28 Mar 2022 10:56:05 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Date:   Mon, 28 Mar 2022 17:56:27 +0800
Message-ID: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
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

inode_sgid_strip() function is used to strip S_ISGID mode
when creat/open/mknod file.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 12 ++++++++++++
 include/linux/fs.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index 63324df6fa27..1f964e7f9698 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2405,3 +2405,15 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
+		      umode_t *mode)
+{
+	if ((dir && dir->i_mode & S_ISGID) &&
+		(*mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
+		!S_ISDIR(*mode) &&
+		!in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
+		!capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
+		*mode &= ~S_ISGID;
+}
+EXPORT_SYMBOL(inode_sgid_strip);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e2d892b201b0..639c830ad797 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1921,6 +1921,9 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
+		      umode_t *mode);
+
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

