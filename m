Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727AB500676
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbiDNG7N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 02:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbiDNG7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 02:59:12 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579553B6A;
        Wed, 13 Apr 2022 23:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1649919404; i=@fujitsu.com;
        bh=smQK4tppl/0P9em1n4iYPJctoNQAJ0+xEhuhlGR6/yo=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=dNssRrL8fwslrgqW+PO0yGjf9kORsjhaLDTfviMxuaZKFNz6npRlsUkRygC8ygEAH
         0GvWr8VPlDf62bbfYzsqOhATAU7INj+TRMviadPB5hpdZkkRlQ/uKT2JntEQJCg0Uu
         1WsO3K5QHCNx+KllaZGuD0bKB4hYDeNB3+YguNmdrnUKgeQtrwbzakLDrU4R5NAcJx
         h2LeN46ITYIOh1KUxE26FBoce4k2B+Aj0a5aeknNT4Irt5K3olLtHvU8vkx6Vi2FGu
         jNEMJB5bjsrIF3v6q0x2kAVfXjzZkd+fK3Hy6DaOID3WN+TmTZ34UoBSPS0sSqS35/
         hA9etSp39u4NQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8MxSXf10fA
  kgyUzLSxeH/7EaPHh5iQmiy3H7jFaXH7CZ/Fz2Sp2iz17T7JY7Hpzjt3i/N/jrA4cHqcWSXhs
  WtXJ5nFh2Rs2j8+b5Dw2PXnLFMAaxZqZl5RfkcCa0fRermAdb8W63YuZGxjXcXcxcnEICWxhl
  Li3eB4rhLOASeLk5XmMEM4eRomnjdvZuhg5OdgENCWedS5gBrFFBBIkXt9azAxSxCwwh1Hi8Y
  nbYEXCAuYSG7cfYwGxWQRUJf51zGYHsXkFPCR+vH0AViMhoCAx5eF7Zoi4oMTJmU/A6pkFJCQ
  OvnjBDFGjKHGp4xsjhF0hMWtWGxOErSZx9dwm5gmM/LOQtM9C0r6AkWkVo3VSUWZ6RkluYmaO
  rqGBga6hoamusZGuoYWlXmKVbqJeaqlueWpxia6RXmJ5sV5qcbFecWVuck6KXl5qySZGYASkF
  Cvs3cF4eeVPvUOMkhxMSqK8TcDYEOJLyk+pzEgszogvKs1JLT7EKMPBoSTB+/8IUE6wKDU9tS
  ItMwcYjTBpCQ4eJRFeP5BW3uKCxNzizHSI1ClGRSlx3tUgfQIgiYzSPLg2WAK4xCgrJczLyMD
  AIMRTkFqUm1mCKv+KUZyDUUmY9wLIFJ7MvBK46a+AFjMBLf62KhRkcUkiQkqqgUn/3vOLi/O7
  pZX7dq1a8ntJlvDHMnFnRYHgJ1Pl1+3uTj543P1B//28XckTPEOPFFy16OjOS/rR9+t90/WGu
  Q/+mDB4lqlfuaJv33Sc21D5hZpFRH2Z99qKR743TeVzXxy6vLtFs2t6UsOjv9cKW3uncUcVsb
  ncX3JOWM7+rIjk/SD/rcz5aWx6VldY5uj82BbnG9rlUPP5rrjnw0+beS9L3XRPvnyjZ7egL3N
  H3Ow9Ljw/rnAuUGWYHCrMVhfFzfq/bZKQe7b48q3vFon5z6hVv5sYl/nqVefTMqH6u8z/FZyP
  +zhYaRfONPWIl//YUsdQaP5ig2Zp15a9c07s2+5R3F2doiIf+Hl3eUWvEktxRqKhFnNRcSIAZ
  wmOD3sDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-11.tower-548.messagelabs.com!1649919403!222910!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 22917 invoked from network); 14 Apr 2022 06:56:43 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-11.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 14 Apr 2022 06:56:43 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 818E7100472;
        Thu, 14 Apr 2022 07:56:43 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 743A6100467;
        Thu, 14 Apr 2022 07:56:43 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Thu, 14 Apr 2022 07:56:32 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <ocfs2-devel@oss.oracle.com>
CC:     <viro@zeniv.linux.org.uk>, <david@fromorbit.com>,
        <brauner@kernel.org>, <djwong@kernel.org>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Date:   Thu, 14 Apr 2022 15:57:17 +0800
Message-ID: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 18 ++++++++++++++++++
 include/linux/fs.h |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..d63264998855 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2405,3 +2405,21 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
+		      umode_t *mode)
+{
+	if (!dir || !(dir->i_mode & S_ISGID))
+		return;
+	if ((*mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
+		return;
+	if (S_ISDIR(*mode))
+		return;
+	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
+		return;
+	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
+		return;
+
+	*mode &= ~S_ISGID;
+}
+EXPORT_SYMBOL(inode_sgid_strip);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index bbde95387a23..94d94219fe7c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,7 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
-
+void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
+		      umode_t *mode);
 /*
  * This is the "filldir" function type, used by readdir() to let
  * the kernel specify what kind of dirent layout it wants to have.
-- 
2.27.0

