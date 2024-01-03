Return-Path: <linux-fsdevel+bounces-7180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8189822D79
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 13:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7661C233E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 12:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A711719458;
	Wed,  3 Jan 2024 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hcmvA4LW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-251-60.mail.qq.com (out203-205-251-60.mail.qq.com [203.205.251.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F8C19442;
	Wed,  3 Jan 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704286116; bh=c5fu1A1ImJUvOCFks4wnS2EUsKt4lP/tQqjI0lBUL38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hcmvA4LWXBW9xciq3lVSqWSFlYfpC1nh7bY5MqPwkFqZE2UrzUfEnhzDNEqPuOAv3
	 JPar13Vekt+dX+9rggQkpU8OQnw+CpHsVFZas2lC4JLg9r9SCgXse4PsSkWxifIsuR
	 I7kCHzlnnAJOXrcQSr2AFzQkX3Sb7htUmrneEmvs=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id A0D1B6CA; Wed, 03 Jan 2024 20:40:13 +0800
X-QQ-mid: xmsmtpt1704285613tf9xk87nb
Message-ID: <tencent_364B28745976AD66CC3D7137029706364609@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYSjGGl4pI81D+9aPPG4Pl6XKvRN2GgZe65xh/KrLRQFrwo9ipoS5
	 rcpgrV+ZnEYvIwaDDEQrTLgumXGp8mIzoX574PfCtSOz4bYCvGZX2ujoTNIx8cIKpACwrwCDdI2O
	 dP0dK5u6RGeKrk6x0QGeGfou49RKH5P0Gf9arHXmm5P86KbtFkcHbsGow2GCMMqMBNPKgQjBF3Wx
	 P7BYqXgCRfX32nxTE/EgeGnFu6h1kWmY86pwZ0FTb8PkRxS/ZeTz+y6DVSZcbX0Xzyg36SclpYdl
	 c6Kti6PjAJFiT9z5zJIpRWmUJcyv+XoOPBQhvAGxZrlq78uCTlCBvb497ek1y4XMusZ2i0hMl1Ug
	 XtGeAB1uF6oUOhSf3iIIlKQV/06li6rw4UWx+RW2mxHooQpPSL1LB+59MK1viv75fn+0pR2lCN0X
	 H65pDupLP2a0+osRu7Nr2mlZWus1RyyGQATnuFWUqQDTscJVz3qjXsNXTwHR7O3vqqAQ95+HVG/H
	 V8bHLb6T2NE1IESyeols2O7ev8jKI9Ou4jMhKtPA3kgjuBmd9rtTdVHRznPsd8m6AzXokT6w3Q95
	 3l3Ttbvp2/aHzoHWHXupZBqJN3oUkZlVATLgWNsGO55sKl9+PXpiv0IVpw0C955rvQ9Zp2+5PZds
	 xXxBZsbvpFH60iRWuP/JDwCqXdlXIo4czkIf6B9L6sC4+13gNmdZuTf2z9uZmfQ0VwGJuth0bJaI
	 yowE4SXUxe5OOVnpKwwZGgzC/+DyEBUss/iOxAbFuVop8UAxjLcGtTquw5qnSicCmUCwzU/OHiLe
	 BOovfhFzrjS03rmHyK8RhNyd4CPaHEQxuQ7DctdhbYMn3VXcU+fvM2rOQvTU8Y9QCyKB7ZJ7/J2u
	 uiSyciYzoruBpDmB7rPixmz4cg6jPNUQ+SXA+Ge4tLRTPfGOfg55yfcgUtT5Hp0l4mvfpOwVCN
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] reiserfs: fix null ptr deref in reiserfs_xattr_set
Date: Wed,  3 Jan 2024 20:40:13 +0800
X-OQ-MSGID: <20240103124012.2765090-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000009d4b80060df41cf8@google.com>
References: <0000000000009d4b80060df41cf8@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before performing any xattr settings, it is necessary to first confirm that both
xattr_root and priv_root are valid.

Reported-and-tested-by: syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com
---
 fs/reiserfs/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/reiserfs/xattr.c b/fs/reiserfs/xattr.c
index 998035a6388e..00fd8f747394 100644
--- a/fs/reiserfs/xattr.c
+++ b/fs/reiserfs/xattr.c
@@ -618,6 +618,9 @@ int reiserfs_xattr_set(struct inode *inode, const char *name,
 	int error, error2;
 	size_t jbegin_count = reiserfs_xattr_nblocks(inode, buffer_size);
 
+	if (!reiserfs_xattrs_initialized(inode->i_sb))
+		return -EOPNOTSUPP;
+
 	/* Check before we start a transaction and then do nothing. */
 	if (!d_really_is_positive(REISERFS_SB(inode->i_sb)->priv_root))
 		return -EOPNOTSUPP;
-- 
2.43.0


