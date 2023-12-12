Return-Path: <linux-fsdevel+bounces-5609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8880E11D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 02:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01A5B216F9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 01:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D1D20EA;
	Tue, 12 Dec 2023 01:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="u2n1nEwu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C4A2
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 Dec 2023 17:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1702346025; bh=FD7duTuFK+lQgjiTKG+9TgQ2tzx4vfTI1j+uY0lwi8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=u2n1nEwuVRcf2UOq5fr0a2gaAEjJc9z9OAeQatgcUGkJ2/RDIR3gX79S37qkSxGxT
	 6i3XFDsS7ez5yvUIJfc2INMji9zRUb/VXk/oc69yBKUzPg8AUETony/+2myCijvKge
	 FPL16RX/9DjE4048zTGNVY5QHbuaOy18NiBBr5gA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 915A4E59; Tue, 12 Dec 2023 09:36:21 +0800
X-QQ-mid: xmsmtpt1702344981t7qa9e586
Message-ID: <tencent_B86ECD2ECECC92A7ED86EF92D0064A499206@qq.com>
X-QQ-XMAILINFO: NyTsQ4JOu2J2zOZ5ZNYHLqT4KfOHLzba1FvVOT7bRfSrE8dwbJH2SiwehFmpQn
	 76d7hNEbFs9hUl7z7ICNcOFl1JD7IImxGHSv8oMYzQDgkbSSKRR0r6xzbsb4Bh0jiFADOgsJEE3x
	 TWdXfWm4Eo7SU6xF4yNgyGRjz5Um7gxZiYNdb7IByhy+owTzPpIxllnLPrKfaD8vL7ZbRDYtAKxe
	 SAx7plUbfsn32bOA+v/6lnvenN4YeGYawJQvGSYOjlHsBgVjXriPdkAAFKo8VcrQRdCy/XfK1vUF
	 naI5zjRXVAAZRU5IqrQqc4mTzmDMN7Epfk5Iz2TRT795vyofaTxGlWikWCTumVx+9cO1KWghHrpf
	 XQ2Xay0oQJNszywQAt0jb6PHGdqGTbdYJMIW4JMBcxWN482XUYZ7/Eik1mr6XcUdikFn7rH8uhvJ
	 TGdLpfbqeknDxxB3YeIvt6gYL0LcTPd6verJq60Mk19x3tBIth2Th+nji7hwA9pGzcfbcpx15arJ
	 9foVcX8rfCotnGBYCP/7rDLssOhO6CqX/YOML0TyIzuzhuQZpX2ixFuiLiUPP0B6gW9FUhtJckuv
	 LbgCFyVn2PO+0rW3l8yBHWEo2RrECCNBueXMY+A19c8hwxcEQlRR/LfNfyRV/A5cDeEeDufYP841
	 9Q6OmOIlqFDN3vBB2zv5/sn6ExFZjWfd8rP0+VFcFUywqwhDYJ4RzvxJ3lwmXaBazYRyeUvmZJO1
	 Bs/bzob2W+06LxlhOVxs+WnQ+S6Ppu+Etm4DcrVSqZiIOPCe/h3PRj8XL85l7v/0vj7xvQr3G25a
	 0j0jfeP+e5ky0AT3iUiIVdweE+kQxLvhia8TLgL59I8LCca6hu/ZsAcOJnkKXr66Ufe34Jj002O4
	 /sGKqqpWqNv+x6VSVNmzmVN5breqdB37U2BJXD2I6t4iP5J8j8+VlTf8kHD0O2Ip4KHxiCig0I
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: fix array-index-out-of-bounds in diNewExt
Date: Tue, 12 Dec 2023 09:36:22 +0800
X-OQ-MSGID: <20231212013621.2119245-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <00000000000062a4cc060c2217de@google.com>
References: <00000000000062a4cc060c2217de@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syz report]
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:2360:2
index -878706688 is out of range for type 'struct iagctl[128]'
CPU: 1 PID: 5065 Comm: syz-executor282 Not tainted 6.7.0-rc4-syzkaller-00009-gbee0e7762ad2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 ubsan_epilogue lib/ubsan.c:217 [inline]
 __ubsan_handle_out_of_bounds+0x11c/0x150 lib/ubsan.c:348
 diNewExt+0x3cf3/0x4000 fs/jfs/jfs_imap.c:2360
 diAllocExt fs/jfs/jfs_imap.c:1949 [inline]
 diAllocAG+0xbe8/0x1e50 fs/jfs/jfs_imap.c:1666
 diAlloc+0x1d3/0x1760 fs/jfs/jfs_imap.c:1587
 ialloc+0x8f/0x900 fs/jfs/jfs_inode.c:56
 jfs_mkdir+0x1c5/0xb90 fs/jfs/namei.c:225
 vfs_mkdir+0x2f1/0x4b0 fs/namei.c:4106
 do_mkdirat+0x264/0x3a0 fs/namei.c:4129
 __do_sys_mkdir fs/namei.c:4149 [inline]
 __se_sys_mkdir fs/namei.c:4147 [inline]
 __x64_sys_mkdir+0x6e/0x80 fs/namei.c:4147
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x45/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fcb7e6a0b57
Code: ff ff 77 07 31 c0 c3 0f 1f 40 00 48 c7 c2 b8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd83023038 EFLAGS: 00000286 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007fcb7e6a0b57
RDX: 00000000000a1020 RSI: 00000000000001ff RDI: 0000000020000140
RBP: 0000000020000140 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000286 R12: 00007ffd830230d0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000

[Analysis]
When the agstart is too large, it can cause agno overflow.

[Fix]
After obtaining agno, if the value is invalid, exit the subsequent process.

Reported-and-tested-by: syzbot+553d90297e6d2f50dbc7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_imap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index a037ee59e398..cc5819b3ec9a 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -2179,6 +2179,9 @@ static int diNewExt(struct inomap * imap, struct iag * iagp, int extno)
 	/* get the ag and iag numbers for this iag.
 	 */
 	agno = BLKTOAG(le64_to_cpu(iagp->agstart), sbi);
+	if (agno > MAXAG || agno < 0)
+		return -EIO;
+
 	iagno = le32_to_cpu(iagp->iagnum);
 
 	/* check if this is the last free extent within the
-- 
2.43.0


