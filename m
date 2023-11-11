Return-Path: <linux-fsdevel+bounces-2745-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 379717E8954
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 06:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49011F20F78
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 05:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE646FA5;
	Sat, 11 Nov 2023 05:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cGU0/kgE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CFD63DA;
	Sat, 11 Nov 2023 05:12:28 +0000 (UTC)
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D0A1FD7;
	Fri, 10 Nov 2023 21:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699679541; bh=VMzfDHWZttmRqGf7MURdvPV+w+VlQoTarsbmgiyb6kw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cGU0/kgEpPWdDRDqopelVLgoJAGgYnbS9QhVsXF6HH2wiyWt9UwerXtIDMRhHzanN
	 ANmgh2tfktNFohzm4gp9rFn9i+H4kGD396y04uoidRG63AUT8+cfqEqcZUfIf8zKRt
	 d6CM4l86/x+KkP3rDGzBweSIvzbAlS1s58tmM2ow=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
	id 18134840; Sat, 11 Nov 2023 13:06:01 +0800
X-QQ-mid: xmsmtpt1699679161t862uyehi
Message-ID: <tencent_DB6BA6C1B369A367C96C83A36457D7735705@qq.com>
X-QQ-XMAILINFO: OKKHiI6c9SH3DripbUzX1M1HYTAQyn6nwrXn2sQUvvFT+/ycLadAaBjnIOn1cF
	 wNn9m/PwDtPOdlY2VlqdJWNHZWrHiX12oq9zQCfS3QRoIwmIo72QgZDb2Okjrb6Rsd024WdhWVHf
	 Rd/CSMj1n6hifTgNa7r0UxUjmIO6rvm1Hhom77a3NHUhkwvAwiwu86Y0pusbUjgfUF7C5SUQZjuo
	 Xc0A96kGAp2bd8AenLaH9Q1iY2vroVDszuBqF4dQcTrkOPISfsqVBAuTsItHqcgv1Y03Dp4VD1r7
	 zeZMC71KhmfL0/IHmrVQeyQoO+x3O7V7azZSb8JhBQBmp7RaIfGsbEVquvEWf/twyaw+SKGCjWmK
	 U3n1nMIiXyNTrK6myUXP6jJOkGS7iyrT76BIuSJLBrAfd46tNfBM8kqGaueh2pmefpAsdt3gNb22
	 lFeCGqezAhiIiMUjdxVsSOCBGBqTSZpe8eh2wuM8v+5XqEJl4j9UUB1GeLLP7fDeE8ckk34MuHAK
	 ziX/Ezjle6DwcF3FwZLzzp33ndPWa3c4aVP5wkAzcLFSaRVSbFU7fhM4a6799rF4PbDF/DJFAa1f
	 GEB7g22ttN8xQw0qF2UvRL6SPB0lTFpzR2M/Y+43HmoZ/iBIfbwdTb6ms8/gesxYViJD387OXk/z
	 U5Tr2BRf8yH9B16BFQkbHUrGCjrT8DmBLhp8S/i5ud+2tsoLCHKXczjBvnuRpRor+15wLJLnJmJw
	 X3Bk252k9Tv113u2/CSjK6EKh+uVXkJt0NtBwvEqjAaaDRycdpXPn98ot+lkh9XB4EqZXgdA0daP
	 kc4VHnAc6TAO1IaHo1qm49NcIXdsO1r3kCcwVGFrR4rd/SuvOZKkyAra38FOHIr3h+K9Ht4ySMa4
	 KL0NrGZCaKyjG6U1jb/ZZ1vvzanMLk3lEv7cPpcrfo3goTS4u35TdqcJnTnWp7Y8A7u1hEPCKb
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Cc: boris@bur.io,
	clm@fb.com,
	dsterba@suse.com,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] btrfs: fix warning in create_pending_snapshot
Date: Sat, 11 Nov 2023 13:06:01 +0800
X-OQ-MSGID: <20231111050601.3946524-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
References: <0000000000001959d30609bb5d94@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

The create_snapshot will use the objectid that already exists in the qgroup_tree
tree, so when calculating the free_ojectid, it is added to determine whether it
exists in the qgroup_tree tree.

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/disk-io.c | 3 ++-
 fs/btrfs/qgroup.c  | 2 +-
 fs/btrfs/qgroup.h  | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..97050a3edc32 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = root->free_objectid++;
+	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
+	*objectid = root->free_objectid;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);
diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..3705e7d57057 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -171,7 +171,7 @@ qgroup_rescan_init(struct btrfs_fs_info *fs_info, u64 progress_objectid,
 static void qgroup_rescan_zero_tracking(struct btrfs_fs_info *fs_info);
 
 /* must be called with qgroup_ioctl_lock held */
-static struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
 					   u64 qgroupid)
 {
 	struct rb_node *n = fs_info->qgroup_tree.rb_node;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index 855a4f978761..96c6aa31ca91 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -425,4 +425,6 @@ bool btrfs_check_quota_leak(struct btrfs_fs_info *fs_info);
 int btrfs_record_squota_delta(struct btrfs_fs_info *fs_info,
 			      struct btrfs_squota_delta *delta);
 
+struct btrfs_qgroup *find_qgroup_rb(struct btrfs_fs_info *fs_info,
+                                            u64 qgroupid);
 #endif
-- 
2.25.1


