Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82EC5027E5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 12:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352052AbiDOKEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 06:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbiDOKEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:04:42 -0400
Received: from mail1.bemta34.messagelabs.com (mail1.bemta34.messagelabs.com [195.245.231.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8425BB092;
        Fri, 15 Apr 2022 03:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650016932; i=@fujitsu.com;
        bh=L39Zc6T31yhBdlKZJPZn+8BfrmfPaBm119Jec/uhYAA=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=KGvEO1qDW1f7azgJxx4j/+vZ2wx+7xAoJHrGP8SIABs1QyibzCU0Eu+sst64JFFUd
         uoboTag2Us2lj1U3zBuUr9qD5LNaDeziHsm0xXGcud5q+THMHqkvgvtm80DQGU8qxV
         12U96NqGkvSu9AKK5sCm2+adWDnE1Jex7TLtva7jZB0mBzBfb4XWPlBinG8qqHXgwZ
         /z//E4n9LnnOkBjMxigTrXldz0mhwCaNOlr2JeHyChWw6Oj9oMszJIzbut/8yw+g2I
         /TIsxMtEhhFnL8jGRG4wb5mDxkS8Xv8yyk1hRkqDyn/+K4YYSPKkDdsII8lGXGcZMo
         9KFsvBT8vyp6Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRWlGSWpSXmKPExsViZ8MxSXexU2S
  SwZtZkhavD39itPhwcxKTxZZj9xgtLj/hs/i5bBW7xZ69J1ksLhw4zWqx688Odovzf4+zOnB6
  nFok4bFpVSebx+dNch6bnrxlCmCJYs3MS8qvSGDNuH1tE2PBY6GKu8suMTYwPuXvYuTkEBLYw
  ijxY4pZFyMXkL2ASWLW+x1MEM4eRomPTY9YQKrYBDQlnnUuYAaxRQRcJBZOWM8IUsQscIVR4n
  r7HLCEsEC6RMuhr+wgNouAqsSUA/vZQGxeAU+JWee2gg2SEFCQmPLwPTNEXFDi5MwnYHFmAQm
  Jgy9eMEPUKEpc6vjGCGFXSMya1cYEYatJXD23iXkCI/8sJO2zkLQvYGRaxWidVJSZnlGSm5iZ
  o2toYKBraGiqa2ypa2RorJdYpZuol1qqW55aXKJrpJdYXqyXWlysV1yZm5yTopeXWrKJERgBK
  cXqV3cwbl71U+8QoyQHk5Io71vRyCQhvqT8lMqMxOKM+KLSnNTiQ4wyHBxKErx/7YFygkWp6a
  kVaZk5wGiESUtw8CiJ8IZaA6V5iwsSc4sz0yFSpxgVpcR5lRyBEgIgiYzSPLg2WAK4xCgrJcz
  LyMDAIMRTkFqUm1mCKv+KUZyDUUmY9xvIFJ7MvBK46a+AFjMBLf62KhRkcUkiQkqqgWm2zIMr
  BTor8v9dSTppq8/YfMI97NXhZYInZIsj3F8ke9+Y9TajUqDv6/4zxWLCsddfNRjoHvy5csGMh
  668UxrMS2cdSP/5m/FmwFG/F8ufVh+tiJdKsIx05Lq19qOKy//1r65XBti0ps84dnL2dJk3sa
  s+nDxTo3+MLbPv4M86mSNcXB0r3/j+4F59y9as6bDxzh9Hr+mWFs8wSLx4c9m8/qrHS4tXO0/
  rjtOs+29qafIw995V8dd6jAvLjprMrQg+35z1XTw282HmmqmL9/tkPpmf9c5NuerZ2vfLT0oX
  cj8/GJV0/viDb8dFUiXjQs0PlvyTyzwY01b8oaF7uW/T5KCWSSE3DK7NXVS4KVBGiaU4I9FQi
  7moOBEA/dcPcnsDAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-23.tower-548.messagelabs.com!1650016931!58992!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 12238 invoked from network); 15 Apr 2022 10:02:11 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-23.tower-548.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 15 Apr 2022 10:02:11 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 05119100475;
        Fri, 15 Apr 2022 11:02:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id EBDD2100467;
        Fri, 15 Apr 2022 11:02:10 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Fri, 15 Apr 2022 11:01:45 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>
CC:     <linux-fsdevel@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
        <linux-nfs@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <viro@zeniv.linux.org.uk>, <jlayton@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 1/7] fs/inode: move sgid strip operation from inode_init_owner into inode_sgid_strip
Date:   Fri, 15 Apr 2022 19:02:17 +0800
Message-ID: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

This has no functional change. Just create and export inode_sgid_strip api for
the subsequent patch. This function is used to strip S_ISGID mode when init
a new inode.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
v2->v3:
1.Use const struct inode * instead of struct inode *
2.replace sgid strip with inode_sgid_strip in a single patch
 fs/inode.c         | 24 ++++++++++++++++++++----
 include/linux/fs.h |  3 ++-
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..1b569ad882ce 100644
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
+			inode_sgid_strip(mnt_userns, dir, &mode);
 	} else
 		inode_fsgid_set(inode, mnt_userns);
 	inode->i_mode = mode;
@@ -2405,3 +2403,21 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_sgid_strip(struct user_namespace *mnt_userns,
+		      const struct inode *dir, umode_t *mode)
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
index bbde95387a23..4a617aaab6f6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1897,7 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
 void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
 		      const struct inode *dir, umode_t mode);
 extern bool may_open_dev(const struct path *path);
-
+void inode_sgid_strip(struct user_namespace *mnt_userns,
+		      const struct inode *dir, umode_t *mode);
 /*
  * This is the "filldir" function type, used by readdir() to let
  * the kernel specify what kind of dirent layout it wants to have.
-- 
2.27.0

