Return-Path: <linux-fsdevel+bounces-1617-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D3BB7DC61E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 06:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC36D28172A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Oct 2023 05:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D65DDA8;
	Tue, 31 Oct 2023 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="VZPDHsPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DAAD2FE
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 05:51:35 +0000 (UTC)
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76C19F1;
	Mon, 30 Oct 2023 22:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1698731485; bh=YOE1CEYLTV+5Z4E3X8qtxb3jDwIjdoXcB64mVSFktCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VZPDHsPhfkMD4erz5am4zdXCjxlwMEcuYqyMa6cM2zYnOqeoKj3WqKrp/tRaSqEox
	 1CigSbcVz5r2XpcrKz5sY8syCML8qQ1WpoGk61bSSbOTUFzBB5BAnZIZDVXy7LkMLK
	 GTSV60l+K0+ySBVBY0CbSK/stlCXuzRjoG3pDpKU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.56])
	by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
	id 9C395891; Tue, 31 Oct 2023 13:39:03 +0800
X-QQ-mid: xmsmtpt1698730743td4nu5bjp
Message-ID: <tencent_69E996EDCACDBC79A66CB02F956C3494D80A@qq.com>
X-QQ-XMAILINFO: NY/MPejODIJVwMZyVr9V3VNsFdifSYsIfhL8+4p9Ht9L6383Lo7Lsd1/Pz3IzP
	 ewGSGuo8GuivlwgoWuq6fs2zWuRXn4bpE32t1o84dRRsQ1KAjUVkXryZP7CeUrw9dO9H7GDP7wdq
	 f1IvWkxYUO3UzQQoej9CKtb0ltBqnSdiQRSFvo+iYJLh17USV201VVkm857QFrqg6j2PFOIw3ZpH
	 AMDaiTwIWuJnuslWfgXMcfcWtS+hB0g0W3IjHE3AYyS+d3zLdvp08kR6ZJ8sAYAV8MXZq3CEIQ2d
	 t2oJ2IVgnI6C2A8UCL3r6JMhOzbjSL/FLIbFaALKWUj2vm1aZx4+ksg1LPDGepjPDwYtcT9glVTT
	 UVdzgDLQe2RT1LH9yHAdxsoZrzLHQ2aWjHFZFJuN311uIecC+GnGRp2vAmPvwUE/tOa6JGWE5jqt
	 AW8/0AQbRL3moUurK668oqWc02E/IC8RCJhuBgBHEEB3dNIGakxo+cUYorpo5JxfHGPzcYay0lZC
	 lxCIGBsWi81T/7xLC/AZB39G8giG0i69qjKBtNCO4Ng5nGfojRjc2h9O+vrZZGLDRAQEGCgKgyZ0
	 6PI60iDPEk6Qn5aTspK2McsdimqtEEBb9li9CeQHJTUdGbTg8GLiTGSNkAV3pxCDAFviurmydfYp
	 pW8KcGa7tnMXmukrfpY7dKoX2NBrPdRYxB/yNtURGtxjPQG4wSBReZzHmj1MlVKHGD2qLIGNHiV+
	 fJJGZjGlnEZ2DdEhZw3hw3LCEBTfmeBFfJxfF4I/eJpvHS4FvbdzRvkKJqJukIVGGnBQnVeGbDdO
	 oNW/c2W8PFsdEXtro4KQdTz3FAyxkHzM4L8MXgo7InnjKxrZCms3G9vdxR1u1SwZtSmLc4i8Gq04
	 fCTCdixvPJRwBTXWcJTaBD0GQq7YV1Y2OBIz1z6GNoXwzvJAlkFP9XEZ8/Di8m8w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	shaggy@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: fix uaf in jfs_evict_inode
Date: Tue, 31 Oct 2023 13:39:04 +0800
X-OQ-MSGID: <20231031053903.2661789-2-eadavis@qq.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0000000000007b8bed0608abc6c2@google.com>
References: <0000000000007b8bed0608abc6c2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the execution of diMount(ipimap) fails, the object ipimap that has been
released may be accessed in diFreeSpecial(). Asynchronous ipimap release occurs
when rcu_core() calls jfs_free_node().

Therefore, when diMount(ipimap) fails, sbi->ipimap should not be initialized as
ipimap.

Reported-and-tested-by: syzbot+01cf2dbcbe2022454388@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_mount.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/jfs/jfs_mount.c b/fs/jfs/jfs_mount.c
index 415eb65a36ff..9b5c6a20b30c 100644
--- a/fs/jfs/jfs_mount.c
+++ b/fs/jfs/jfs_mount.c
@@ -172,15 +172,15 @@ int jfs_mount(struct super_block *sb)
 	}
 	jfs_info("jfs_mount: ipimap:0x%p", ipimap);
 
-	/* map further access of per fileset inodes by the fileset inode */
-	sbi->ipimap = ipimap;
-
 	/* initialize fileset inode allocation map */
 	if ((rc = diMount(ipimap))) {
 		jfs_err("jfs_mount: diMount failed w/rc = %d", rc);
 		goto err_ipimap;
 	}
 
+	/* map further access of per fileset inodes by the fileset inode */
+	sbi->ipimap = ipimap;
+
 	return rc;
 
 	/*
-- 
2.25.1


