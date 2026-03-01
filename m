Return-Path: <linux-fsdevel+bounces-78841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOHUHxkSpGlcWQUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78841-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:16:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 846511CF19F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 11:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1B33C30091DE
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 10:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB81175A90;
	Sun,  1 Mar 2026 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pM/QUlwL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7E3A937;
	Sun,  1 Mar 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772360202; cv=none; b=p1avpQG8qwXMbOwAPL9Perk9gB1u62zV4ws3cITQiBcGWmIySCmHdd7VcJm2B3UP/E9blYHeYxzXUX6fYU8fGPZWnINwQbATfXmws4TpUPq0gO/6ypS7cP9xQxhLO1yOMQRXXqXr00CvX5E4GgxsTfKsekpp8Vt2mwSOM2pRL88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772360202; c=relaxed/simple;
	bh=y6L8k0vASMz/bPcRIzrGwf6ssOdNeQe5cZLM2rVE9YY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qGJAWGCNyePN+EiXb/KZfhZru2SufLo1XUqd0juRYyy2qMjLOJtFplFHM1SqukC4OewK2pKXdP9Cy7GseRzvjt5HNgYCxd8u+jVb1KkNTdrAXXTikUI/E4zFwEdLTrBcwOM056miq4mFQNafFdShJWQL7HhUEO0Pt/KD/eHZjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pM/QUlwL; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772360184; bh=6YDJwzaTNZZXldRpDl0UFDy3tH3MQT89XnIJD7yZKuk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pM/QUlwLYkJiXEwwa6qgOucmGCxe8LhN2u/y87Qsmqqt+pjnF88yeBPindBn1UMDa
	 zk6SuD7sV8OADFn0ZzdpQpu608SYZ6U8UpSYWpDjczIkznHZsbC5dPtxoEbEy9Ltqc
	 rg94prkZgLxetEldFvIanb5NJ+Iftw5iq4ed/bhI=
Received: from lxu-ped-host.. ([114.244.57.237])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 32E2288B; Sun, 01 Mar 2026 18:12:46 +0800
X-QQ-mid: xmsmtpt1772359966t2fgdsc5b
Message-ID: <tencent_4C5966F83C65375A97D236684A6C75237609@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5SFSfUZiYQ1kR0aN4OxOMO1jiunMtturwGsgFa9lAMdy1kRkRpaT
	 orcwqu364X6TmAUXagAxa5QI1V1NETAAWnH+axbWFzngJxwM3aU87w0PNXnwFtB1nJZ4sxXwIDa/
	 O+dzPi00X1fTeP+cA2tOw2PZ8IKkoKdds48ZmP6PM4SOjj33CvFwPHgWNWaNGs3SVfuUFX9/9oeN
	 YsqbVhSvYZFnrrQ3Gd7oP6c7XkmU9oIzi1m1N/CqeLJvdmUgAsIQx6MeNPy2YUtJb1kNKBTlOFiF
	 wyaWQi/oFwHlE7N47pzorIg+74XSfcbzeSX6NaELq8lT7+0GqVGodnebVbPRjP/S/o0xhErJzWFs
	 i+409210+MW6wjTd0/GWrvs191XnEXAzlNFZ+erCR/LP2FBcLE0YMrhDLC3rWs3CF3w4wuTKqJCv
	 2rNiahUyx3JqfYTs0WoK7QQ/QCXGs32W/7m1IsYhw2gMEEUmpIdsYsBEGJIuM8l0bmintPV2DGvF
	 uIKyyVke0Ca+u+SHbf99bmiVsE4vcxbLfKmJHYu7LZR6cBNIY+vaQeu9e255nI3IjWQ+mshKX++I
	 mZiMcG0utsiss3pWhP+O57YNMvvJtHbfRgdX3CL1RQbuI31ZmKIvgsDHXX4KfbeCwKQV1l8amfWT
	 RFMgnNad2oJTuEmUWjLAgpBphqK0imAcMpY3XJl+0gad2taKcW2iG0AftJvabFP6MWV9/vvndcgo
	 l9ejzYCYILDPFHqX71dov8u/9tBaFafqituILghNMfTfmA8adMAsA+XBkN6kpY6KXPbQ5kcgcG3Z
	 dTrxohL/MkSbqcRyX5Lha725PNdYdSvgQTDfJdZ0YnA2qiNTlQ4i4sz2QENkeFHi13NFNhke9GEs
	 w7CKrvXneE7BxVsWqolhpYdm0XBfK71TNwb6IBHJqoovZdCU9vqWvEYF9Ya2xzdXeIaKKH3agzOr
	 hZUPpIA4azYtwE5A9VUsQkPgUPKNk/LFhh+6TNq+gyJJzt73zwkYwyaq1w9Josz6S1Mc9DXdMNxz
	 fJeXg8MEqIGIGiIfLi5vm9FepYMYSCCdTnmRJLHw==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+1659aaaaa8d9d11265d7@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH] ext4: avoid infinite loops caused by data conflicts
Date: Sun,  1 Mar 2026 18:12:47 +0800
X-OQ-MSGID: <20260301101246.246595-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <699ebd11.a00a0220.21906d.0005.GAE@google.com>
References: <699ebd11.a00a0220.21906d.0005.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qq.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78841-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,1659aaaaa8d9d11265d7];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url,qq.com:mid,qq.com:dkim,qq.com:email]
X-Rspamd-Queue-Id: 846511CF19F
X-Rspamd-Action: no action

In the execution paths of mkdir and openat, there are two different
structures, struct ext4_xattr_header and struct ext4_dir_entry_2,
that both reference the same buffer head.

In the mkdir path, ext4_add_entry() first sets the rec_len member of
the struct ext4_dir_entry_2 to 2048, and then sets the file_type value
to 2 in add_dirent_to_buf()->ext4_insert_dentry()->ext4_set_de_type().

This causes the h_refcount value in the other struct ext4_xattr_header,
which references the same buffer head, to be too large in the openat
path.

The above causes ext4_xattr_block_set() to enter an infinite loop about
"inserted" and cannot release the inode lock, ultimately leading to the
143s blocking problem mentioned in [1].

When accessing the ext4_xattr_header structure in xattr, the accessed
buffer head data is placed after ext4_dir_entry_2 to prevent data
collisions caused by data overlap.

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
 fs/ext4/ext4.h  | 2 ++
 fs/ext4/xattr.c | 2 +-
 fs/ext4/xattr.h | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 293f698b7042..4b72da4d646f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2425,6 +2425,8 @@ struct ext4_dir_entry_2 {
 	char	name[EXT4_NAME_LEN];	/* File name */
 };
 
+#define DIFF_AREA_DE_XH sizeof(struct ext4_dir_entry_2)
+
 /*
  * Access the hashes at the end of ext4_dir_entry_2
  */
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7bf9ba19a89d..313c460a93c5 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2160,7 +2160,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				error = -EIO;
 				goto getblk_failed;
 			}
-			memcpy(new_bh->b_data, s->base, new_bh->b_size);
+			memcpy(new_bh->b_data + DIFF_AREA_DE_XH, s->base, new_bh->b_size);
 			ext4_xattr_block_csum_set(inode, new_bh);
 			set_buffer_uptodate(new_bh);
 			unlock_buffer(new_bh);
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 1fedf44d4fb6..4a28023c72e8 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -8,6 +8,7 @@
 */
 
 #include <linux/xattr.h>
+#include "ext4.h"
 
 /* Magic value in attribute blocks */
 #define EXT4_XATTR_MAGIC		0xEA020000
@@ -90,7 +91,7 @@ struct ext4_xattr_entry {
 #define EXT4_XATTR_MIN_LARGE_EA_SIZE(b)					\
 	((b) - EXT4_XATTR_LEN(3) - sizeof(struct ext4_xattr_header) - 4)
 
-#define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data))
+#define BHDR(bh) ((struct ext4_xattr_header *)((bh)->b_data + DIFF_AREA_DE_XH))
 #define ENTRY(ptr) ((struct ext4_xattr_entry *)(ptr))
 #define BFIRST(bh) ENTRY(BHDR(bh)+1)
 #define IS_LAST_ENTRY(entry) (*(__u32 *)(entry) == 0)
-- 
2.43.0


