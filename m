Return-Path: <linux-fsdevel+bounces-78889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLIsMgKIpWmWDQYAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 13:52:18 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 733381D92E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 13:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 13781300E6AF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 12:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E63B3BF3;
	Mon,  2 Mar 2026 12:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="aoh+6kza"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA15A3ACF07;
	Mon,  2 Mar 2026 12:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455890; cv=none; b=ENjDwOFe25dJLopzzdPnLiLcotkRFcim4ZLnebM2MsFtUFdWyzpcsHdkBRn5XoPu9dOtL7xpz5St8JgTyV+NFzmVoQGWKmbYAjAgUO+XiWI++K5E2e3+DgmH1IbGBtu4GgvqSa8PgN/kJGJ3Vv1yxqm3DHUqVIYylaDNPyUss2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455890; c=relaxed/simple;
	bh=K1Jc76yBOdiCZOrE3NEBAzT9ZvTZAZqaMZg2bmP72dw=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eRQAH5jOinbZsTzlLrS19kTTdnGABuD4OwV1qEo8Xvz0EMegxB+RjM8oDk2qy7SNGwITmkvDSTcm5SIGlTn1jvrd8i2vasxB10649CrxDxjb6eMnOAGQA486wiC62J/9G/3cabxsWN9rDxtV5I3/adO+YhWurJWTYvqXYF3jlt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=aoh+6kza; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1772455883; bh=35TKkxftZA66OCmA/rR9k9ldi2Fyql3rrrUYj6gwYw4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aoh+6kza1w3+vcOzytVw9WHY6lXHi6b7K/CVEmb+s3Ai4+EdFiIsTXmbnP6IQ+vPC
	 +s1r8pTRK0LWxcXgMP75CoW9Ivns6+hn2zT904vSEoOo804lYX3Xuk+YYbiBfXHEKb
	 ihrbpfcA2ldRN97vKd8J0LIEpMqtCrm2pXH+mIFk=
Received: from lxu-ped-host.. ([114.244.57.237])
	by newxmesmtplogicsvrszc41-0.qq.com (NewEsmtp) with SMTP
	id CD40C2C8; Mon, 02 Mar 2026 20:51:20 +0800
X-QQ-mid: xmsmtpt1772455880tp6j0zsna
Message-ID: <tencent_13E236704A527419766767443D6736EE9609@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtCp4bty5WLlyBVFn0IiXDDRbLGqBeKwDsq++0NgJ58DAF/DgpuP
	 BkKbL3NrZtCiUR/vJVx6zWCfYyuFPrlqtFmhqzGgMMDJjsipdrXHik+v9o3c0205EiyNo50z287D
	 Ndu+b2X+NgjR+fiEcIm+oyyVhNz6oWHxODhjBM6wGOBEgXNn2oaKJJ0MUqUYsPUk90qoXQmVDqo7
	 GJ6mn0nCebM80rNS/qF78btCbsPoFzMDRqCMEdoPwfo6ia293nXJIcTQikI50jm6611ckNNJ/fiN
	 wtM/+OU6Ae9L4D9sLl3uEsmLWwcvcFOw5tzWVDAuBHK1CY6+jpOc72kyCpaBKQPMhHw2IbZBhTdp
	 Kt47+pcIXULJVnwdYOC45NP0OULyEaM/3KPkS+SDwHRbFZOpZt7a/0ZM5rVymwcoGiO2Im0qobEw
	 hXbpSBgCxPcXBn9fWAD1Z3hCZSexb3gdc/FfBLv7LeZxzqQyOJYDkkc9KRo9J0QRpW6CacrkTGv4
	 i93OiWE/bO2LDi8fzXLC1ULAjrO5iCf4PVYNvwgtRu8+3HYKN159kpBxbU2J0ICAtEk/lhTYzIpY
	 KJLrdcRxqUZ/c2xBC4R6wuMEt8y4qyW0UbEemIOOYn9Uh9qb+4it2L6KLe/DVs0a5OCqq0ZNvCXE
	 45LLojF2fkXVF79hssMpY4HisWS3COe2bfL9+lRIorsZE+7J5XYkdc3YbClTt68nBUGPUQMJeged
	 EBA9iX9RwVoY3wyxGC3rlmuXXohSwMU7c6nzPgU9y1M/mB/VrZa8eZuroqBT4QbyJwdRln6JdJlf
	 F6QKqQ2TINYLzkNHarA7ZIJ5nixBuqSR7Or0d4ztyLXJxfAMFFK5Rg4dDPCf1XmF9i7Z09v5gBl5
	 sKoKUiKRRQ1y/s262/DQsclNPgHcuxxIKZpwP+XkuGOOOj6HRiIrMi3E03z6uxmSoP4TNsYP/GmA
	 8h4Dlk23hNhaANQQ2jNY28zPCsxYomocgBU2nzHIrVIR79zGBpNE7whZ6Ld8ztD/2H6PoUDAn5U3
	 jh86AQQPh3FvE7Z6/M9riut5nUG1FcRLQwtYLo6qLSf07ZR7K17t+IEPhNyw20iPHrHZA7DEo1yo
	 IO/YgWWnm6zhVy+4A=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ci4ea9e91a328607dd@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	eadavis@qq.com,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev,
	syzbot@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH v2] ext4: avoid infinite loops caused by data conflicts
Date: Mon,  2 Mar 2026 20:51:20 +0800
X-OQ-MSGID: <20260302125119.282902-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69a56bf2.050a0220.3a55be.0074.GAE@google.com>
References: <69a56bf2.050a0220.3a55be.0074.GAE@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qq.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78889-lists,linux-fsdevel=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,qq.com,suse.cz,vger.kernel.org,lists.linux.dev,syzkaller.appspotmail.com,googlegroups.com,zeniv.linux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[eadavis@qq.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qq.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,ci4ea9e91a328607dd];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:mid,qq.com:dkim,qq.com:email,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 733381D92E5
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
v1 -> v2: fix ci reported issues

 fs/ext4/ext4.h  | 2 ++
 fs/ext4/xattr.c | 3 ++-
 fs/ext4/xattr.h | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

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
index 7bf9ba19a89d..b7bdf8ae2b4f 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2160,7 +2160,8 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				error = -EIO;
 				goto getblk_failed;
 			}
-			memcpy(new_bh->b_data, s->base, new_bh->b_size);
+			memcpy(new_bh->b_data + DIFF_AREA_DE_XH, s->base,
+			       new_bh->b_size - DIFF_AREA_DE_XH);
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


