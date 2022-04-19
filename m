Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A705068F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Apr 2022 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348928AbiDSKtY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Apr 2022 06:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237759AbiDSKtX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:49:23 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CCE18E3B;
        Tue, 19 Apr 2022 03:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1650365198; i=@fujitsu.com;
        bh=nKcbw9G10YRwJtuTkWKrJxPtCYxkjd1NLjOt968HcKM=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=FtukdF7buVA7kfo1MC9GCqe2FA/iAKQnj7RcQrpOn9pKeTatldHlqxERZAtqaKDgh
         PLKlmPoUOMEz1nBrxNm9t/youJkNGcdT1D9IxMmHfP7SydwrknrB0+z3T80DI2oUk6
         OqS+YTCjKQ1XkCyJMGQcb74E3Rfzsme7Ls6SxHD4S70pfHoJpLJ6sby7REdzeAV5UW
         xmRv5yqZCxV70WTms/aAPGDxpcEPGVdakI+XeNYrRrymX9BNodUJYOYnL1FUlL0GPd
         ES9aKpcVmHedXk64fLxVKuC4/Nm93dbORwKOYDlbAfwEVy7r3xmTyuo7iMayAqHxrL
         nbHmmPyKD8dXA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPIsWRWlGSWpSXmKPExsViZ8MxSZd3cly
  SwbH9phavD39itPhwcxKTxempZ5ksthy7x2hx+Qmfxc9lq9gtLi1yt9iz9ySLxYUDp1ktdv3Z
  wW6x8vFWJovzf4+zOvB4nFok4bFpVSebx4vNMxk9di/4zOTxeZOcx6Ynb5kC2KJYM/OS8isSW
  DM62rULpgpVdJx+zt7AuIq/i5GLQ0hgC6PEtmM3WSGcBUwScz++YIZw9jBKPPm3hLGLkZODTU
  BT4lnnAmYQW0RAWWLBjWNsIEXMAmeYJC5dgygSFkiUOHv6ACuIzSKgKnHjQx9YnFfAQ6LhSx9
  YXEJAQWLKw/fMEHFBiZMzn7CA2MwCEhIHX7xghqhRlLjU8Y0Rwq6QmDWrjQnCVpO4em4T8wRG
  /llI2mchaV/AyLSK0SqpKDM9oyQ3MTNH19DAQNfQ0FTXQNfIxFgvsUo3US+1VLc8tbhE11Avs
  bxYL7W4WK+4Mjc5J0UvL7VkEyMwXlKKGT7vYFzQ91PvEKMkB5OSKG99VFySEF9SfkplRmJxRn
  xRaU5q8SFGGQ4OJQne0glAOcGi1PTUirTMHGDswqQlOHiURHgn9wOleYsLEnOLM9MhUqcYFaX
  EecVagBICIImM0jy4Nli6uMQoKyXMy8jAwCDEU5BalJtZgir/ilGcg1FJmLdpItAUnsy8Erjp
  r4AWMwEtrp4SC7K4JBEhJdXAlG0x47WhXXPmhOZX25cXbJ/22zNIXuVX1Rr1zBk/LzkUiB/Zl
  PQzzPpcf0Czsuf21pzcfpHZPJPW7Pi1XE1yYsHb96E/e+ZveLJiRsd7h+IF1pPU7shLvNffM+
  Olh9urBQWFR5i2/d/ie5xdS4L12ft9zPnLl794xf5MN3frp64bp+Mem0iL7HHgE8rUm2JtvH3
  VKz391Tvt3tY+mNnt1PktKVklxjYg+GSnmh/7vOM7+Y4+5cu62/THvyEj7J0Nt3DgjSdn8nJW
  yvAd3BYs2Kl0KXfaVVn1yO6l84PLs9Pe1CWdf56yYvOOcxs5/9ycn3HgiVjL28fzbJ03XFHMf
  TZPP/FhX9KuNpXt2W0GjUosxRmJhlrMRcWJABJQCauSAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1650365197!269511!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 19231 invoked from network); 19 Apr 2022 10:46:37 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 19 Apr 2022 10:46:37 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 29D4210045A;
        Tue, 19 Apr 2022 11:46:37 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 17C58100440;
        Tue, 19 Apr 2022 11:46:37 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 19 Apr 2022 11:46:11 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <ceph-devel@vger.kernel.org>, <linux-nfs@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <viro@zeniv.linux.org.uk>,
        <david@fromorbit.com>, <djwong@kernel.org>, <brauner@kernel.org>,
        <jlayton@kernel.org>, <ntfs3@lists.linux.dev>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v4 1/8] fs: move sgid strip operation from inode_init_owner into inode_sgid_strip
Date:   Tue, 19 Apr 2022 19:47:07 +0800
Message-ID: <1650368834-2420-1-git-send-email-xuyang2018.jy@fujitsu.com>
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

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/inode.c         | 22 ++++++++++++++++++----
 include/linux/fs.h |  3 ++-
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 9d9b422504d1..3215e61a0021 100644
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
@@ -2405,3 +2403,19 @@ struct timespec64 current_time(struct inode *inode)
 	return timestamp_truncate(now, inode);
 }
 EXPORT_SYMBOL(current_time);
+
+void inode_sgid_strip(struct user_namespace *mnt_userns,
+		      const struct inode *dir, umode_t *mode)
+{
+	if (S_ISDIR(*mode) || !dir || !(dir->i_mode & S_ISGID))
+		return;
+	if ((*mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
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

