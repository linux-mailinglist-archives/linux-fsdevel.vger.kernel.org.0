Return-Path: <linux-fsdevel+bounces-2816-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E86B27EAA3E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 06:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77E4D1F24036
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 05:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CF5101CB;
	Tue, 14 Nov 2023 05:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="N/MWywY7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FDBD2E1;
	Tue, 14 Nov 2023 05:49:05 +0000 (UTC)
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E9189;
	Mon, 13 Nov 2023 21:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699940940; bh=1N6NYDJiq4Pbtb/X91iD5lwBaY8uIT5bqSRt4NoMnp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/MWywY7aswaQopMgwzcMhl0zN/YyN6ArU13p3EhPWHiYtu2zeRIkewsUS8PdwSg5
	 2zyS54RbdU4vLeXu0e0xzeCaW9shshxMej+4thr1V5BkTjK61UXpyFChn6i1i7SJPT
	 3v0TvzLjrkbDBffYwMBD//1vqQg4WcnFor6u43U0=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id C3A04640; Tue, 14 Nov 2023 13:48:58 +0800
X-QQ-mid: xmsmtpt1699940938t2992o6b6
Message-ID: <tencent_A9BA25BB3A335C9EEB1B224B691B4B254708@qq.com>
X-QQ-XMAILINFO: OLnGMPzD2sDVsfZ1BIsMf0z7FbAS9VJ2j2Lk+8jK6nAjKnzX0+C7aqeWuKBEgO
	 Dewpn8yPAJqMB5sLqPeOuORGAmSKfruT2sDDr98zQl0MwzGVF7j//V0wGscG3BFVb7cxu0MZJE+r
	 F+Hc74BjNYS0oW47ZTpDdElgjFzOKRvl8xWZH6oL/wRCBpkZ7ZADDnnfunPmRzrStz82zz2nTawf
	 IwWkLC+HcLbMUm5Rxi6RLPv4DQR8jIjNWdS/NuFdqd9vDpf0ALctxGfukaJhUDhuXhgx0rY6qoqZ
	 A0dRpQ2qpx9ybjloMt37RF/ZVlvB+MtuO+LSU3osUF34IEgVwwB10saL8XjaB7N9Kqi6162XgQB3
	 zwK4U4D85QjMwHnWC1r1L6EOgz5nC+45y9cT+JKuFKztqSI0ZIJisKSxDtzw1yUOzqr2EB/HLrtu
	 1HEj53DJZjzTiceoqG+ipp+RZYyLNpdcQ+Yi2NlPjFwQGSkk7JnLJysGKcsnv8P11gsPxy5deBq6
	 6esuh74asZ7y8IUYsvyvLuG5UZ3PSAkOwakDtuVZRJqbVItU9yJmlASkRQKtOAAp8z7woiuggK0P
	 IXb51wHNW2OLCitwQyuKrOp/nJuu8OCIFXaFeagmJDKXTqBOuZdXYeRVAO+x0SLFJ/nuD5VroNKp
	 VidIjVVo1drNhM+S7hbax4gIPOB+EFg/3UBOpDSHfTSexJc3Wd/gnX02VIltIY8L5hNib/py6z2y
	 yZUjuL6TF8RNxGDE2UP80R6SSHH9EJXP/GNGzqflt6PYv76gLSG1KvcQ/xDyou87lmpA3y974bxy
	 2OmQdfqsjzsudhtBLHC2WPBj70q3kF5lnJNoKP28MowIzjy2xZzoAp5unRSV9ERyGFYWx1hy17xG
	 hjYfg0Ec25yR8zyRR1SBcnfFyrWbLc5mT1MSOMH8n1NYYVIk/1eJ8Ezkbc7XKSid68t9PA5S2QTL
	 MihhXB7SjAz0rhy73Rww==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: raven@themaw.net
Cc: autofs@vger.kernel.org,
	eadavis@qq.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] autofs: fix null ptr deref in autofs_fill_super
Date: Tue, 14 Nov 2023 13:48:59 +0800
X-OQ-MSGID: <20231114054858.2289411-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
References: <4fcf49456c32087f5306e84c4a8df5b2bd9f4146.camel@themaw.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syz logs]
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 PID: 5098 Comm: syz-executor.0 Not tainted 6.6.0-syzkaller-15601-g4bbdb725a36b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/09/2023
RIP: 0010:autofs_fill_super+0x47d/0xb50 fs/autofs/inode.c:334

[pid  5095] mount(NULL, "./file1", "autofs", 0, "fd=0x0000000000000000") = -1 ENOMEM (Cannot allocate memory)

[Analysis]
autofs_get_inode() will return null, when memory cannot be allocated.

[Fix]
Confirm that root_inode is not null before using it.

Reported-and-tested-by: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/autofs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index a5083d447a62..f2e89a444edf 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -331,6 +331,9 @@ static int autofs_fill_super(struct super_block *s, struct fs_context *fc)
 		goto fail;
 
 	root_inode = autofs_get_inode(s, S_IFDIR | 0755);
+	if (!root_inode)
+		goto fail_ino;
+
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
 
-- 
2.25.1


