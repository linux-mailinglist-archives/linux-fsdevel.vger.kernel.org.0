Return-Path: <linux-fsdevel+bounces-79459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPdQOxYwqWmO2wAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79459-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 08:26:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4581720CA06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 08:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371373013255
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 07:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED6331B114;
	Thu,  5 Mar 2026 07:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ZHEW3Rr9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46AA6191F91;
	Thu,  5 Mar 2026 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772695563; cv=none; b=hzNiU0HckWkuP7D2J4LNSkHNT+X78dFmPiwqayaC9qxISdkNXMN9ysIea74+4/vLson+yiuMz7YM/g4o1ACBIWUSbDRNcM96nJbF8pTA/zO3TPhY/hOsfIC7u1ZKp50ZYTCyEaC+lYWcYv9HL03A/lrsAwIa3bTG0NEHOn3pjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772695563; c=relaxed/simple;
	bh=serZQOjnyKdUf+Hv6YV4uym9KicUIWkjWuwieX7M2VY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=OK1TaItzo0tU1xxLBEA0LILAnmurMajQP+dVq/yeu0A/D8jAD1GY8a1VJzTsqUovXgcBQEmeiZPiVoqhPWRKouoMNX+3LQmoCjokci4Y/kXL1D8LMsALfe1jVyOcPKLhJzho/vE2pGtmy4x3cMi+JP5kIO5f+dWqwdpP+KRo+Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ZHEW3Rr9; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772695550; bh=tpTsQ2K114SC6xh+ee+XJnACDZ9x/Yy2EK81NPiw8jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZHEW3Rr96kLoXWdqopctCfbDv+EVwGSAevgEPMNNVu7EV5f9IyzzMVvYDLRiqBQlf
	 fQRhnjcPcV2NFHPr9sYlGrbi42S0kOrgjGlXDCkJcEa+2LCwOD3D1KmLDllBAtPtWI
	 sPEAR0LAGkXvGtloIPYHC2u480lfRGQCM4varWh0=
Received: from lxu-ped-host.. ([111.201.4.63])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 66EB40F4; Thu, 05 Mar 2026 15:25:46 +0800
X-QQ-mid: xmsmtpt1772695546tlk118xcc
Message-ID: <tencent_722F916D689510E89EEE92CD8C78226D480A@qq.com>
X-QQ-XMAILINFO: NKDEJ657lpu+IGcb52ag05LJhLwenjCN9xNlMgJ6/gYss4YmkT0oDFCNR1S6SZ
	 0uK4ps7p/NaTt9+dsX3mqt4OPhWKb+FmDWE4beqp+A/Ncjjvd7fOZnpiPiVLox6KLv86K4P+vRAH
	 EDYxJc9M+kipg9jU3NJCVddWXFKH0HkL6it4G7V31GvLWQsH8QOIoP1WoAVGm1qDzvxUNsojKtWS
	 AH6EMOuHgMmeSHlIQwjDbN6s9Ur2GgKQGddrtnoES+kN1tGKR4xkXW4ebF0TYaEpCOMDrnRz4pw/
	 NfIKSmNWNwVD1rin5T+I43uNWBHJWykSFeU7zJwyYw/5Y4TOnWOc27XYa8ZsVWCiRRFDfVt2cCQX
	 HOIeCoKop/hK7BaFxShD1h1bqa+R2n6PBLXOJu3nCNU4EeYEGR9oGikK6YlTX+osLy28z4ZJrpCA
	 Ka1mFGZK04QQE5XREanKOLSSb7NNk70Cb5TvWFUQUeI5/RkhfjhU6ktku1JcAD6ZylhyBp0pMxaq
	 3D4HZr7QnyHRU8FFI7WJF4C/q8BQPnu50UdWI8LGpS+GUA4BChXL3MHXuA06DYy9gKva7d5uSRhZ
	 b5eM99rgHRMu/YjMvsUb2+e+pNLxTLsz+hJ77t2b9YGWotSN1lk4QBnuYlrFl32M8NeGFDNHaRFS
	 DECLiZZzApCclrL8OiUu57o3hUi3ZeHVSLVyv3IkdUJK22SSH8F2hq1LqKMwCKlqSFqzTGARqTbl
	 9tRd2u8Zd9yU67wE41gYPdUdexeI0cHnWXIIvwJSqJl4EUigZYBWpTkXcyGA0H+VmxYdSCc6tpKh
	 zwMsVf0X2UId6Wk0LxYGKbd9sUQmQP4SVk8Fd/dKOaXtfzrYjDaL6mpfJNfXQt5ukzy2odnVKCgb
	 V1NwIsOle9IlE++QwpryMEdJkSzFrfcsbYRkVJ2WXjwwpDxC8pmzHPv9L4xKKSwGftcgq+To7IX7
	 qP649uOyKsHv8cLkGojsT9NfcIGTh+/78Ph932ZCAOFbw74s1OxDHvUVqge/YRnqR+85pjWfOT5d
	 QyVyfK9fzOqTLXlezH6pMlmEBYDT5vbWqId8p+3g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: jack@suse.cz
Cc: brauner@kernel.org,
	eadavis@qq.com,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v3] ext4: avoid infinite loops caused by residual data
Date: Thu,  5 Mar 2026 15:25:46 +0800
X-OQ-MSGID: <20260305072546.414952-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4x3xixojbclwq45cpitmylbhis4ya4g3sugtnmj2yzv6avngqb@5xkwu6l467rm>
References: <4x3xixojbclwq45cpitmylbhis4ya4g3sugtnmj2yzv6avngqb@5xkwu6l467rm>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4581720CA06
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-79459-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,qq.com,vger.kernel.org,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:dkim,qq.com:email,qq.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,syzkaller.appspot.com:url]
X-Rspamd-Action: no action

On the mkdir/mknod path, when mapping logical blocks to physical blocks,
if inserting a new extent into the extent tree fails (in this example,
because the file system disabled the huge file feature when marking the
inode as dirty), ext4_ext_map_blocks() only calls ext4_free_blocks() to
reclaim the physical block without deleting the corresponding data in
the extent tree. This causes subsequent mkdir operations to reference
the previously reclaimed physical block number again, even though this
physical block is already being used by the xattr block. Therefore, a
situation arises where both the directory and xattr are using the same
buffer head block in memory simultaneously.

The above causes ext4_xattr_block_set() to enter an infinite loop about
"inserted" and cannot release the inode lock, ultimately leading to the
143s blocking problem mentioned in [1].

By using ext4_ext_remove_space() to delete the inserted logical block
and reclaim the physical block when inserting a new extent fails during
extent block mapping, residual extent data can be prevented from affecting
subsequent logical block physical mappings. 

[1]
INFO: task syz.0.17:5995 blocked for more than 143 seconds.
Call Trace:
 inode_lock_nested include/linux/fs.h:1073 [inline]
 __start_dirop fs/namei.c:2923 [inline]
 start_dirop fs/namei.c:2934 [inline]

Reported-by: syzbot+512459401510e2a9a39f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1659aaaaa8d9d11265d7
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Reported-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=512459401510e2a9a39f
Tested-by: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
v1 -> v2: fix ci reported issues
v2 -> v3: new fix for removing residual data and update subject and coments

 fs/ext4/extents.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ae3804f36535..0bed3379f2d2 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4458,19 +4458,13 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	if (IS_ERR(path)) {
 		err = PTR_ERR(path);
 		if (allocated_clusters) {
-			int fb_flags = 0;
-
 			/*
 			 * free data blocks we just allocated.
 			 * not a good idea to call discard here directly,
 			 * but otherwise we'd need to call it every free().
 			 */
 			ext4_discard_preallocations(inode);
-			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
-				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
-			ext4_free_blocks(handle, inode, NULL, newblock,
-					 EXT4_C2B(sbi, allocated_clusters),
-					 fb_flags);
+			ext4_ext_remove_space(inode, newex.ee_block, newex.ee_block);
 		}
 		goto out;
 	}
-- 
2.43.0


