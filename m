Return-Path: <linux-fsdevel+bounces-2813-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 530617EA93A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 04:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956A8281049
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Nov 2023 03:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2468E8F70;
	Tue, 14 Nov 2023 03:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OqsZzOat"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9978F44
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Nov 2023 03:52:36 +0000 (UTC)
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC49C1A7;
	Mon, 13 Nov 2023 19:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1699933951; bh=lg+AxG6nmCwiRU7/zoqFobhF9shMWgq6Z2Z7gSmW0z4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqsZzOatVWx7E3EC9CDPt1hnKGvqaII9TPe1/D/rbipVNfqFRMD4ypfUjwVpZUK38
	 /TmJEIK6NzfVu+iD//4NoRLIG5BZSGW2w/UOmOFAD4WRop/cF1ydSji3xz8NjBrERH
	 GXXmtAbAGj+j4D9/nyBURvGhTN7qcsvK6ASE9BiQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id D1C01E23; Tue, 14 Nov 2023 11:52:28 +0800
X-QQ-mid: xmsmtpt1699933948tuov78bdg
Message-ID: <tencent_3744B76B9760E6DA33798369C96563B2C405@qq.com>
X-QQ-XMAILINFO: NEoGzTA04D+52sRBA2ec1IXMY1ou3fobcAWlr77b1Urev4qLHPcI3kJ7vZYXW0
	 +bOh1syTpWwymZUZfnKJQZ7/gmAPuZFo0HnxPQGgSiDpiIw116KpWy0vW0w5jwNDoaK3+6sp9C1b
	 1/VCH/AMWAIAAgZegH20/HNNRILOB8cCQRWcECw6zBXMwirB0hDbbuu6HTWCFQnKlz7VU0pzjY7c
	 9tLvwWmIk0erJl7TSDXgPcPuHABD80AIVXbhNwCIVppqV3NbgMPsS/jAq/ZvDHIFDqcHo34MTBzb
	 CYMzacCZgGjkvX/2g9skDizMLrt/xLADC8DjBN6+ymDEkkQS65XGYb/MQsLYjvBa+VT3pg7Tb9go
	 f45/D8d9oqvK70zAvZ5A5GGj1/1HomMPENK4Oad07ckMrqkxA3cFdQx7Fl8kfwWOmC8VIoHTc2D2
	 Ttt7Gw+b+ZLbW5OayJ3IOxpIOl006rx9YpIvK8EYWXlJSQf55gPni704Qt1SrC4n1bBdsCXBPAKf
	 7zDVRiyWpBitJvzBzeQoSFufJFFFpEUtY29IF6mSYvQ3vKOh4XNh5GKNUArYKKd8TDU+YBmU4580
	 hIj7bbK+qI8kKSf32V/aa6nihOIjrnRX9vc1PPt6Di9ppQb397SvqgZ4mlurIXS5H27OCrGhrtUX
	 DrDZSXoon0Fz5ydYHazN0+WB3UD3eqRBTADmhodUY6n9P8Un1sWpN/v39UBW1LxF1l5RNZwDTP1/
	 /LBkBzpli4Dci0mFiK/FcbCHuu2X61bHJWoHYAMXLlbSG4tnr+c/n51JTY5e8PIg2SXpGsuFq7K7
	 GLKBXrHOMU644bnPvBQyDq+TlzIMR3zWT2yAENRU+QNkYTskoZZSQWvhDPbgYNNDN9QWVB5/MhMj
	 OaIBX0rWxgV374IoToLrf7Icy3S6H2LJrRJTr0SO4T1cWEgVpttFwMHyjfIijZUiit36XnduwS
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+662f87a8ef490f45fa64@syzkaller.appspotmail.com
Cc: autofs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raven@themaw.net,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] autofs: fix null deref in autofs_fill_super
Date: Tue, 14 Nov 2023 11:52:29 +0800
X-OQ-MSGID: <20231114035228.2123194-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <000000000000ae5995060a125650@google.com>
References: <000000000000ae5995060a125650@google.com>
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
Confirm that root_inde is not null before using it.

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
+		goto fail;
+
 	root_inode->i_uid = ctx->uid;
 	root_inode->i_gid = ctx->gid;
 
-- 
2.25.1


