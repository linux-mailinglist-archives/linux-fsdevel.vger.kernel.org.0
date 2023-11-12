Return-Path: <linux-fsdevel+bounces-2761-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1557E8E5D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 05:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DADA1C20841
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 Nov 2023 04:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BE82581;
	Sun, 12 Nov 2023 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PS2Wx/dr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17B41FCC;
	Sun, 12 Nov 2023 04:48:57 +0000 (UTC)
X-Greylist: delayed 85368 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 11 Nov 2023 20:48:54 PST
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594CA273F;
	Sat, 11 Nov 2023 20:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699764532; bh=Nh9NEmXMKKSIzgHHFg3D8MirxmXG82ZjNkyrfeIx1BI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PS2Wx/drBxAj9JLyZxBhsKwKnMtF86ZEog5jf8n0oFvwhWfP3/6Oz4eV00MhMiaJE
	 Ey5gHB327whmyEn7ywK1MPypHRQapMHMMi1nrB129/GXmUP9Y+QWWe00dcn3cGyr9U
	 cxo6a1wqVHSDYRX4KNwV8tTxhJJycrV6T2gIe+r4=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id C3100069; Sun, 12 Nov 2023 12:48:49 +0800
X-QQ-mid: xmsmtpt1699764529tja0crvr6
Message-ID: <tencent_B9A7767566563D4D376C96BE36524B147409@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9EjBHd0TTbrkbHuSYIBIWvF3vPA65b4MQu58idl4QdNiQjcrTAI
	 85fAVZygykgle7SXAFWUEjenICHrZX4Wvv7sxUS1UE+AojnUas8H9EPjKBxapK6hIL6hizBSjrL/
	 6/oRYJfoqw8qkNULAE2iz0LmQDb+tXI9sFDxgwsBLPzr1u2Cc0N3zEl4Mt2g3glAIMoPPuDT42Sq
	 tYDmUnBiNd8bCWrdoLJt1Ui/SQiZKZJfythEXz5CKGJC/Qsjk1mjn9+xZLy12gv0DPH7Zi7dn7Sx
	 KBsq7BgdsphqAejjdu6KdMwxgqOG6+RWEnUKrne7CiUcxQj7InTzcRLd1k1zN6NzIKl6t9640W+c
	 XtqTqW1nbL51jWAekL4r96mBblIv+cY4ukz+N1jKaAFqQPyvuUhwEMDmWhqLF0eo4d7gMYcGhb1R
	 fccMzF9QMfiW6ILlxlCFVKSnQHRhgKezZu9mDphSBqy1V6iCpmAIx4mFg0OWV/zwxvtb1VofTPiw
	 3vmQjLMW8x3SVScdhQBe2gPbgzb0gS1i2Wcmvu64Ahrjs5RZNryPo+ArFQfuRRxY169SQmQP2m1U
	 TiQpLrTuYKx//0HOO+WQI1UWYN9lbOi3q8eGVVEReyRkIGTJ1Euv+M5Eo5/fEY99MvB7x/l05ebH
	 mhlkn6DaESjddbq/kXtm+LX5yEEXxeSqnj8HxiWHgeRf8VMx56FUZoOunu/GzZg6rsQDkiF9g1vn
	 bjYSaG5N7zBf8+NJ1ivMpGSS4tOsN6o0dCWM5eMl3B0ZkDdt/DsvavOj1WOYxTi7nVmGwAZeNjA+
	 UrLESRYondWaeQEuYVzJExZGdV6bcZLVC8hfp2taVK631rgkgwMa+/WBhtMbYmrl67RFe0uIT8b7
	 LDxWnDSxYqDrj+nORsb7c6LZMGc7V31MYsGMi3w0Jt1++81kAP7YvOhbrFf9y/I/VAcRGkQnnmjf
	 d4q+i5p/8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
Subject: [PATCH V2] btrfs: fix warning in create_pending_snapshot
Date: Sun, 12 Nov 2023 12:48:50 +0800
X-OQ-MSGID: <20231112044849.630843-2-eadavis@qq.com>
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

[syz logs]
1.syz reported:
open("./file0", O_RDONLY)               = 4
ioctl(4, BTRFS_IOC_QUOTA_CTL, {cmd=BTRFS_QUOTA_CTL_ENABLE}) = 0
openat(AT_FDCWD, "blkio.bfq.time_recursive", O_RDWR|O_CREAT|O_NOCTTY|O_TRUNC|O_APPEND|FASYNC|0x18, 000) = 5
ioctl(5, BTRFS_IOC_QGROUP_CREATE, {create=1, qgroupid=256}) = 0
openat(AT_FDCWD, ".", O_RDONLY)         = 6
------------[ cut here ]------------
BTRFS: Transaction aborted (error -17)
WARNING: CPU: 0 PID: 5057 at fs/btrfs/transaction.c:1778 create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Modules linked in:
CPU: 0 PID: 5057 Comm: syz-executor225 Not tainted 6.6.0-syzkaller-15365-g305230142ae0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:create_pending_snapshot+0x25f4/0x2b70 fs/btrfs/transaction.c:1778
Code: f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 76 4b be fd 0f 0b e9 30 f3 ff ff e8 7a 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8 5c 4b be fd <0f> 0b e9 f8 f6 ff ff e8 60 8d f8 fd 48 c7 c7 00 43 ab 8b 89 de e8
RSP: 0018:ffffc90003abf580 EFLAGS: 00010246
RAX: 10fb7cf24e10ea00 RBX: 00000000ffffffef RCX: ffff888023ea9dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003abf870 R08: ffffffff81547c82 R09: 1ffff11017305172
R10: dffffc0000000000 R11: ffffed1017305173 R12: ffff888078ae2878
R13: 00000000ffffffef R14: 0000000000000000 R15: ffff888078ae2818
FS:  000055555667d380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6ff7bf2304 CR3: 0000000079f17000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 create_pending_snapshots+0x195/0x1d0 fs/btrfs/transaction.c:1967
 btrfs_commit_transaction+0xf1c/0x3730 fs/btrfs/transaction.c:2440
 create_snapshot+0x4a5/0x7e0 fs/btrfs/ioctl.c:845
 btrfs_mksubvol+0x5d0/0x750 fs/btrfs/ioctl.c:995
 btrfs_mksnapshot+0xb5/0xf0 fs/btrfs/ioctl.c:1041
 __btrfs_ioctl_snap_create+0x344/0x460 fs/btrfs/ioctl.c:1294
 btrfs_ioctl_snap_create+0x13c/0x190 fs/btrfs/ioctl.c:1321
 btrfs_ioctl+0xbbf/0xd40
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:871 [inline]
 __se_sys_ioctl+0xf8/0x170 fs/ioctl.c:857
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

2. syz repro:
r0 = open(&(0x7f0000000080)='./file0\x00', 0x0, 0x0)
ioctl$BTRFS_IOC_QUOTA_CTL(r0, 0xc0109428, &(0x7f0000000000)={0x1})
r1 = openat$cgroup_ro(0xffffffffffffff9c, &(0x7f0000000100)='blkio.bfq.time_recursive\x00', 0x275a, 0x0)
ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)={0x1, 0x100})
r2 = openat(0xffffffffffffff9c, &(0x7f0000000500)='.\x00', 0x0, 0x0)
ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)={{r2},

[Analysis]
1. ioctl$BTRFS_IOC_QGROUP_CREATE(r1, 0x4010942a, &(0x7f0000000640)={0x1, 0x100})
After executing create qgroup, a qgroup of "qgroupid=256" will be created, 
which corresponds to the file "blkio.bfq.time_recursive".

2. ioctl$BTRFS_IOC_SNAP_CREATE(r0, 0x50009401, &(0x7f0000000a80)={{r2},
Create snap is to create a subvolume for the file0.

Therefore, the qgroup created for the file 'blkio.bfq.time_recursive' cannot 
be used for file0.

[Fix]
After added new qgroup to qgroup tree, we need to sync free_objectid use
the qgroupid, avoiding subvolume creation failure.

Reported-and-tested-by: syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com
Fixes: 6ed05643ddb1 ("btrfs: create qgroup earlier in snapshot creation")
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/btrfs/qgroup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..9be5a836c9c0 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -218,6 +218,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 			p = &(*p)->rb_right;
 		} else {
 			kfree(prealloc);
+			prealloc = NULL;
 			return qgroup;
 		}
 	}
@@ -1697,6 +1698,7 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	struct btrfs_root *quota_root;
 	struct btrfs_qgroup *qgroup;
 	struct btrfs_qgroup *prealloc = NULL;
+	u64 objid;
 	int ret = 0;
 
 	if (btrfs_qgroup_mode(fs_info) == BTRFS_QGROUP_MODE_DISABLED)
@@ -1727,6 +1729,8 @@ int btrfs_create_qgroup(struct btrfs_trans_handle *trans, u64 qgroupid)
 	spin_lock(&fs_info->qgroup_lock);
 	qgroup = add_qgroup_rb(fs_info, prealloc, qgroupid);
 	spin_unlock(&fs_info->qgroup_lock);
+	while (prealloc && !btrfs_get_free_objectid(fs_info->tree_root, 
+				&objid) && objid <= qgroupid);
 	prealloc = NULL;
 
 	ret = btrfs_sysfs_add_one_qgroup(fs_info, qgroup);
-- 
2.25.1


