Return-Path: <linux-fsdevel+bounces-4677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 883A3801C32
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 11:31:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42CD12817F4
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF37116406
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CRykrYiy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62E09E;
	Sat,  2 Dec 2023 01:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1701509151; bh=vwasgKMlkrgq4cDMRp4Pe0lTBLkjlKM1cXwkKpfADzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CRykrYiyquOi9taFvLpMW7p9ywI4sCX8UM7pzS8sGxNxZAmo1oQh2KrYoKIFuyg/K
	 jqAlCtW1MTPnIUmeLPDDkK2EjX6og801egxyKjJ8bw6S3t66dnpgG/vWJbJXYYlsJB
	 Ld8fvUoJe/8/W0l+TW99akwFVfRdCPNOEgJtCwFs=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 67122CEF; Sat, 02 Dec 2023 17:25:49 +0800
X-QQ-mid: xmsmtpt1701509149tlxnb0q5j
Message-ID: <tencent_FCCCB879B66D7C2C2D6E4C97F4E972EE3A0A@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxKKwxo/p8YL3Gyc0/gL8pkt7W01IcJUeMPaIoW2hT5UvgbIKC4D
	 eUqPIItdH6PG5/VdVyF3LdYSwnZmNMgpB+2xDlRYdG/kw0oMgMA07owVxaTaOUldueMGZhxCt0bK
	 YGlkrOKPfsQPeoN3EJGIo/kODIXTt5Re7ISSiUNuAyNk7AY535TWNMPGidvaycZcd0Z/gjuSGtFM
	 KH7bH4aONBFpnzQ9a2inPHMX+W3rM3eTkpMNoNIxnhm3kIOstJj0IqEffp0BmuEYES65ShOP5pCI
	 WgmLRDc7vKXtkrER1tedXl9r6v9M92KcjyCgqDyn5G3PeJtTTH03evhPyMUzisdqLoJkTYVH7EpA
	 dOXd4c1e2NvBpV2UDjOQzG70ZRIacPQeqJGUjZxx/TNDAScF/W2+Rc21xXsSHrPYwhxJOGcA5gHn
	 Aia/j+OGVd9ZSVyq72LMEWDCi4golQ/oacXz2dSzNrTM5rIBA0XE7hYjfZ40ipVz7G+frq2poaWB
	 PEs0JoH8syV2f3rCTBTY10NFiG/69Pbv6vkmWmTV3qTfGymCB2p7yuOgD4EiYO61QZT8yZG4grxf
	 KeYQW03jeONBMzSCg3wIoqD6ldA5cerV/65dIBKsHcTfPzD68WQ3Ohx7vkxsRFsZl15SBwyPbZaY
	 I/0AK2rYpL7ZY8YuMREP2NuiQ9kvkq8vmpMZsL5o7rQmikn38l/11lw/3ySNaTl5k16Sn6xdNy3Z
	 DxI3uqgG1lxQnJ87kAqJNV52N4JChm/asoMzycBXja9QU8JJB5kebvH3x3aiAWBnh35Kwpg4nXjw
	 BY+rQPl/w86q5pbmbd7d6rWtQs0WaKHVT16GtIDSJ1iimf0Puy41/PFpMdMOTvXIWPJIrizHmLeZ
	 jxjsqxrjn3nS39WRRK1le7jqPatAOwvDcVASXGMlTo0aWlUsVZ6zXjnpnIXJHgPNNO/lY9z6Sycx
	 DIuE9RRI0aUl009q8LMQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com
Cc: agruenba@redhat.com,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rpeterso@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] gfs2: fix kernel BUG in gfs2_quota_cleanup
Date: Sat,  2 Dec 2023 17:25:49 +0800
X-OQ-MSGID: <20231202092548.2852785-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000737829060b7b8775@google.com>
References: <000000000000737829060b7b8775@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: ***

[Syz report]
kernel BUG at fs/gfs2/quota.c:1508!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 5060 Comm: syz-executor505 Not tainted 6.7.0-rc3-syzkaller-00134-g994d5c58e50e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
RIP: 0010:gfs2_quota_cleanup+0x6b5/0x6c0 fs/gfs2/quota.c:1508
Code: fe e9 cf fd ff ff 44 89 e9 80 e1 07 80 c1 03 38 c1 0f 8c 2d fe ff ff 4c 89 ef e8 b6 19 23 fe e9 20 fe ff ff e8 ec 11 c7 fd 90 <0f> 0b e8 84 9c 4f 07 0f 1f 40 00 66 0f 1f 00 55 41 57 41 56 41 54
RSP: 0018:ffffc9000409f9e0 EFLAGS: 00010293
RAX: ffffffff83c76854 RBX: 0000000000000002 RCX: ffff888026001dc0
RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000000
RBP: ffffc9000409fb00 R08: ffffffff83c762b0 R09: 1ffff1100fd38015
R10: dffffc0000000000 R11: ffffed100fd38016 R12: dffffc0000000000
R13: ffff88807e9c0828 R14: ffff888014693580 R15: ffff88807e9c0000
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f16d1bd70f8 CR3: 0000000027199000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 gfs2_put_super+0x2e1/0x940 fs/gfs2/super.c:611
 generic_shutdown_super+0x13a/0x2c0 fs/super.c:696
 kill_block_super+0x44/0x90 fs/super.c:1667
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 exit_task_work include/linux/task_work.h:38 [inline]
 do_exit+0xa34/0x2750 kernel/exit.c:871
 do_group_exit+0x206/0x2c0 kernel/exit.c:1021
 __do_sys_exit_group kernel/exit.c:1032 [inline]
 __se_sys_exit_group kernel/exit.c:1030 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1030
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
...

[pid  5060] fsconfig(4, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0) = 0
[pid  5060] exit_group(1)               = ?
...

[Analysis]
When the task exits, it will execute cleanup_mnt() to recycle the mounted gfs2 
file system, but it performs a system call fsconfig(4, FSCONFIG_CMD_RECONFIGURE,
NULL, NULL, 0) before executing the task exit operation.

This will execute the following kernel path to complete the setting of 
SDF_JOURNAL_LIVE for sd_flags:

SYSCALL_DEFINE5(fsconfig, ..)->
	vfs_fsconfig_locked()->
		vfs_cmd_reconfigure()->
			gfs2_reconfigure()->
				gfs2_make_fs_rw()-> 
					set_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags);

[Fix]
Add SDF_NORECOVERY check in gfs2_quota_cleanup() to avoid checking 
SDF_JOURNAL_LIVE on the path where gfs2 is being unmounted.

Reported-and-tested-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/gfs2/quota.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/gfs2/quota.c b/fs/gfs2/quota.c
index 95dae7838b4e..af32dd8a72fa 100644
--- a/fs/gfs2/quota.c
+++ b/fs/gfs2/quota.c
@@ -1505,7 +1505,8 @@ void gfs2_quota_cleanup(struct gfs2_sbd *sdp)
 	LIST_HEAD(dispose);
 	int count;
 
-	BUG_ON(test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
+	BUG_ON(!test_bit(SDF_NORECOVERY, &sdp->sd_flags) && 
+		test_bit(SDF_JOURNAL_LIVE, &sdp->sd_flags));
 
 	spin_lock(&qd_lock);
 	list_for_each_entry(qd, &sdp->sd_quota_list, qd_list) {
-- 
2.43.0


