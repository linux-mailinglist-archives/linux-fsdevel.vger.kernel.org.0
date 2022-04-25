Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2181850D6D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 04:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiDYCMM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 24 Apr 2022 22:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiDYCMJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 24 Apr 2022 22:12:09 -0400
Received: from mail1.bemta36.messagelabs.com (mail1.bemta36.messagelabs.com [85.158.142.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDB5245A0;
        Sun, 24 Apr 2022 19:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650852545; i=@fujitsu.com;
        bh=ZrLMonqkrdZQn/R0EhmdFYUjKu36GBpTyAZAImamfa4=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=LYi3+cfCoJOyr/4gtgSX8PZZ9suTS2RLafNZrwPDy+md7k6HoOhJmByyawp1S+qCC
         bJ3nw9vI3CUCXhfMuDCeIAAsx0OcUSGagBGQkMyAypYqBEu/jt0U0ZExD4uQo66QIa
         T/zEhN61W6thS00gBg04OLb7R0F7G7+X4kC0/nid6JtS1haQ0LAFdUszbgIQnJ6fNZ
         ALgTXHby7vBseST+sIL/zv/SwsZ7lM0k0zCN2b3z11Ghlz4xhDFBQq6aQgrxXpeR0i
         H0SdBZFfduTVbEaHLoCRBZcWTzjzKi59n3OIHQLpOnC8CDd812Vkt15rEBRPJo1FmD
         TphgKcvLyNntw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRWlGSWpSXmKPExsViZ8MxSXcfU1q
  SQdduG4vXhz8xWny4OYnJYsuxe4wWl5/wWfxctordYs/ekywW5/8eZ7X4/WMOmwOHx6lFEh6b
  V2h5bFrVyebxeZOcx6Ynb5kCWKNYM/OS8isSWDN+n+9kL2gQr/j3dD5LA+MC4S5GLg4hgS2ME
  kenL2WDcBYwSRxe3MsC4exhlJhz9yNjFyMnB5uApsSzzgXMILaIgKPEi/YZLCA2s8BmRollj8
  NBbGGBRImFq3vZQGwWAVWJVfMgbF4BT4n3F86B1UsIKEhMefieGSIuKHFy5hOoORISB1+8YIa
  oUZS41PGNEcKukJg1q40JwlaTuHpuE/MERv5ZSNpnIWlfwMi0itEuqSgzPaMkNzEzR9fQwEDX
  0NBU18xM19DCTC+xSjdRL7VUNzk1r6QoESitl1herJdaXKxXXJmbnJOil5dasokRGAUpxU67d
  jAe7Pupd4hRkoNJSZQ3gzEtSYgvKT+lMiOxOCO+qDQntfgQowwHh5IEb9j/1CQhwaLU9NSKtM
  wcYETCpCU4eJREeH/8AErzFhck5hZnpkOkTjEqSonzOoDMFABJZJTmwbXBksAlRlkpYV5GBgY
  GIZ6C1KLczBJU+VeM4hyMSsK8VSBTeDLzSuCmvwJazAS0+FMt2OKSRISUVANT1LplW7S3JF59
  66W5IfzDv5dJ7ot8d3S+OlibL950T2K3jZxWqH4ky6ZAb6OMxfybdc43veTmSW06UvV6fmLq0
  8fl93e47q/ZsE7vDfdZy5aLTeGGVXmdZxsE77HYF/xYbdHseZBH4s7VK/79Yuunqz4vfOH1OE
  TOfp35tLR1BRO+/OO/vk+/ryIoLffCzJRk9v1s56WcHL59Opdd+GbRzFL73rUVGhMUjuc/5Cx
  5OnFdzOH3D5ysXGZUT7KVTRUS/Pdk1iSfhWd+XtDt+duoWtbX5ROy6kTd+uZ9lQ+KBWcGb2Nj
  2/fMUid4oeRNo/53hhoaEp9cCr9If939kPfE2rIVV4zKtbcuStpXruGuxFKckWioxVxUnAgAH
  eBKtH0DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-10.tower-528.messagelabs.com!1650852542!64942!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6987 invoked from network); 25 Apr 2022 02:09:02 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-10.tower-528.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 25 Apr 2022 02:09:02 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 79CB910034F;
        Mon, 25 Apr 2022 03:09:02 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 6C1BD10033A;
        Mon, 25 Apr 2022 03:09:02 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Mon, 25 Apr 2022 03:08:34 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <djwong@kernel.org>, <brauner@kernel.org>, <willy@infradead.org>,
        <jlayton@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v6 1/4] fs: move sgid strip operation from inode_init_owner into inode_sgid_strip
Date:   Mon, 25 Apr 2022 11:09:38 +0800
Message-ID: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

This has no functional change. Just create and export inode_sgid_strip
api for the subsequent patch. This function is used to strip inode's
S_ISGID mode when init a new inode.

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
 include/linux/fs.h |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..78e7ef567e04 100644
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
+			mode = inode_sgid_strip(mnt_userns, dir, mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
@@ -2405,3 +2403,34 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+/**
+ * inode_sgid_strip - handle the sgid bit for non-directories
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
+umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
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
+EXPORT_SYMBOL(inode_sgid_strip);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..532de76c9b91 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
+umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
+			 const struct inode *dir, umode_t mode);
 
 /*
  * This is the "filldir" function type, used by readdir() to let
-- 
2.27.0

