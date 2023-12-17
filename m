Return-Path: <linux-fsdevel+bounces-6338-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B9815E23
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE62A283BBC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Dec 2023 08:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776723A2;
	Sun, 17 Dec 2023 08:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="XzPqRjg8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6BA20EE;
	Sun, 17 Dec 2023 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702801485; bh=0lB3OyYqJUjufHeb9cN7xRSKf7npEOsy2UKslyIKn88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XzPqRjg8vwn+CztCNwEscD4q6LFO2MqaOYgGyKoaGrxYfKaPP7FhH9V4+eVsEI5jt
	 PC0eJxjh41gpLTSW/n5KK7SjoZ5CNGM6SZovz7B3XBYVPufVKxrXoX47fbfO007uoI
	 gmA7c1PiJ5c4ramEj2l95lSOXZtH4Q10JYeRW34U=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 2DA082F6; Sun, 17 Dec 2023 16:11:26 +0800
X-QQ-mid: xmsmtpt1702800686t9z4b36nq
Message-ID: <tencent_4E2FCFC90D97A5910DFA926DDD945D9B1907@qq.com>
X-QQ-XMAILINFO: NFcI4DQTV9fmkt9lUNi7+Jvn0ZFoqP30SGNnowiDA+zmTz+Hl5PeBJctWLwk4q
	 tcupdaW6dKq65J5Ks6Gglo2JKNCYzQZwrRWB+GtECzk64+G/ZJ4Ch2dz4mpLbeKH+OgSrI1sAQEY
	 Cf1SiWelvQTp6dzLrYv82lz/kfx5R2+LjdAASeRXVZuZcLzHOKh3jTHe6MzS/06eL/wik+Lz1CnX
	 C6WBYLA37g5yo6+K4yrPDYGlGpVna7tmy4yAzKYjJS3OCr3mCbF//Dy8htBFRtJce11C1oJp4tBD
	 0NUZDNCqUIcuOHthKKbkX4kf7k4jsq9QeRICVCPqq7m2FR+6MgSJ8jIJEUWclgNLrMTG8K+jQ6d/
	 R0j5AuJX3zGwTYBj7VMigzjWIU4XqidkYYUDViPVpVyDnPBCHdaU0SknQij33jrjos8Hs3hVL0KX
	 0mzsk6XdTJDKJN9e/ogA6lx7Wt9b9AMAjObNGZN07ajUnP+JYod3QLp+h9QuVqUo4KWbw3B0SkrB
	 r0OClW4YTS5mfYAvUYfkoEWbhimuLOsPwEe49SSDed89yORqEcGiDKhIuVLOh2lLaECxAH7uFzqk
	 x36G5+clgulmST+sGWuHoHIn2ZoPZLC+CVtRYcVkUdkzo7ml4UmBnFvM7daiTDGqcT8Ay1PYV1am
	 BVNX3VqnmQoJoJF4NIPwWOkq1zpl24t7l3yz+uqEtIb8bPP3uL2xSeqBd3P2tlQojigcQZiCpQS8
	 PP55aKry719AoI3VECLwe1cxx4mk/2pkncOxJypkw8PWMdPSLnu1cBAp8NXu8hYQJMSOpTwWhT4D
	 auLGerAf7mTf1IpWNeyTE7Xqw1kGDMahycg3kSFsFGlVsFKi69wPcf6EOKYSMoJOMcbMVPi1DZKY
	 MPnCh0UFZ4UfcC7U581K//XYicuUrH2pK09azcl80H2N5c0nX0L11jtHB5Nq/hPft0VY7tLglw
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Cc: amir73il@gmail.com,
	chao@kernel.org,
	jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phillip@squashfs.org.uk,
	reiserfs-devel@vger.kernel.org,
	squashfs-devel@lists.sourceforge.net,
	syzkaller-bugs@googlegroups.com,
	terrelln@fb.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] ovl: fix BUG: Dentry still in use in unmount
Date: Sun, 17 Dec 2023 16:11:26 +0800
X-OQ-MSGID: <20231217081125.4138340-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000003362ba060ca8beac@google.com>
References: <0000000000003362ba060ca8beac@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

workdir and destdir could be the same when copying up to indexdir.

Fixes: c63e56a4a652 ("ovl: do not open/llseek lower file with upper sb_writers held")
Reported-and-tested-by: syzbot+8608bb4553edb8c78f41@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/overlayfs/copy_up.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 4382881b0709..ae5eb442025d 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -731,10 +731,14 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 		.rdev = c->stat.rdev,
 		.link = c->link
 	};
+	err = -EIO;
+	/* workdir and destdir could be the same when copying up to indexdir */
+	if (lock_rename(c->workdir, c->destdir) != NULL)
+		goto unlock;
 
 	err = ovl_prep_cu_creds(c->dentry, &cc);
 	if (err)
-		return err;
+		goto unlock;
 
 	ovl_start_write(c->dentry);
 	inode_lock(wdir);
@@ -743,8 +747,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_end_write(c->dentry);
 	ovl_revert_cu_creds(&cc);
 
+	err = PTR_ERR(temp);
 	if (IS_ERR(temp))
-		return PTR_ERR(temp);
+		goto unlock;
 
 	/*
 	 * Copy up data first and then xattrs. Writing data after
@@ -760,10 +765,9 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	 * If temp was moved, abort without the cleanup.
 	 */
 	ovl_start_write(c->dentry);
-	if (lock_rename(c->workdir, c->destdir) != NULL ||
-	    temp->d_parent != c->workdir) {
+	if (temp->d_parent != c->workdir) {
 		err = -EIO;
-		goto unlock;
+		goto unlockcd;
 	} else if (err) {
 		goto cleanup;
 	}
@@ -801,16 +805,18 @@ static int ovl_copy_up_workdir(struct ovl_copy_up_ctx *c)
 	ovl_inode_update(inode, temp);
 	if (S_ISDIR(inode->i_mode))
 		ovl_set_flag(OVL_WHITEOUTS, inode);
+
+unlockcd:
+	ovl_end_write(c->dentry);
 unlock:
 	unlock_rename(c->workdir, c->destdir);
-	ovl_end_write(c->dentry);
 
 	return err;
 
 cleanup:
 	ovl_cleanup(ofs, wdir, temp);
 	dput(temp);
-	goto unlock;
+	goto unlockcd;
 }
 
 /* Copyup using O_TMPFILE which does not require cross dir locking */
-- 
2.43.0


