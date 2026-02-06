Return-Path: <linux-fsdevel+bounces-76543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAlLOT6IhWnfDAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76543-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:20:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D167FA9B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 07:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AD98300B9D5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 06:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1052E62CE;
	Fri,  6 Feb 2026 06:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="T4+ZPwIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A0B2FF16C;
	Fri,  6 Feb 2026 06:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770358841; cv=none; b=rD+dvaEbtvtQdwhEu5uBwlBtkksjqz6/MBQQpqKlCT3OA8MADnDtdrJfbChcRYgWNndaJidVuyhBMAZATNEe9XpNgfkDP5uA2/UZKgwv3ZJQTzo5fyV1S3bHFsPTtOrCi4e2XLOcVHEktE/TLxUrfmHcmQXtOcKNdywdDSrUOro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770358841; c=relaxed/simple;
	bh=wVoRsegTdF3w77QTKOuZyTlmqN1hm4p9WYkokIKcrzk=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=bBO3dCOzETdeFHh0Zq9rF+iBiiVaX1n187sReTV/waVoA59xo0G/c/ShfaFFgbqZPONlg1u9g0RSHFqiU+fEWsD7FGGeuakawsB490FB0JLXW9IYFtKVJs1rohtgBlK4nuFHprW33Fb6VhBfFErkjopxqOTtBmaXMriFyerSwyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=T4+ZPwIN; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1770358830; bh=1SiRZuK37Z0WiV2biKXIYyYsG0DPjjxm6CejmSbD1EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T4+ZPwINCJYLnPx6DDnpM3DHD43G8hd/t0S1FkwVlcwYyQ3enYXyaZDpG9P0ULdd3
	 LHXBo/cIF1KFxq5j3va82IPBTAAp9YrEd5my4RsCGo8I/1SvoLHgPDBoyuyYZGTQjK
	 FFjsV4sX/KKnDpBIoMUCemw8vCbqKlRPvqICflbI=
Received: from lxu-ped-host.. ([114.244.57.237])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 51C02873; Fri, 06 Feb 2026 14:20:28 +0800
X-QQ-mid: xmsmtpt1770358828t7i3pbdeb
Message-ID: <tencent_B6C4583771D76766D71362A368696EC3B605@qq.com>
X-QQ-XMAILINFO: NarItqGHGbpi+6pO2msoXIYCVlv16+ke2Bu8FsEzf3BOxkxJrRwJwHyJXBMkNq
	 qW1L6OI+TsTGYsoqSJ5tjuy8S1DmekBP+rY09kcwfDJgAa7ZyCcYOIveTLWd96Kq0kECKdfDSLdc
	 uCKxyUSzmK5WZxGVhJdSrrT7CNkDD9Y81rQOEf3DaJ10oDyhbvCQ1Zfx3nXEMnsI42QMwLDv6UQa
	 5KRwF0optehoiU9N7fT00LOcOp8xbhIyQuRyjebHnFvSkcwye7KV2+P4qW9/Q+jwz3YEkiW/RkXC
	 iJo64ne6NLot4UNVhxcuezRp4ycHNsqpSjPaLglWjTB/my7lCAe6Lhk/kKIb7m/GDlqLnwSP3+2+
	 +fO1HYV7B+ElxcHsMioViIFrm5wG8WzPTWPx/qetOW8zAT0lfYbecrpwrFiZMuC5jB+pp7Sfjyll
	 QQgF54mXdZda6AeNlA0xWF/M/6OkB0Zb5oq6HvXXiLE3cfbq0NR3Rzj+iICzDmbPQEg5tUvZDC9S
	 FAdUrC472W3juPY+VqpoKF68fbtsw4r/GK3QlOWTX52qp8b00XsNZUdwRPfeso9KtLXzJGx9tKJH
	 RGRCVvk4LdBWlLgCKgnRI1e6ZtpM7DPJ1Y5+8XMFAXVOacfqiY+CwZd1pDBBrlZk4jhp0xt1z62I
	 WHfiFf72nzrA0yLDLhCbbyKNnAFpvj1TohD6bVJOQC4EsNHK7wDDGAwKgNJePa64zibfJqzwskED
	 uqBY3w0meESZIBUXk/EuTh59vf6GXctXdVbSikVwXXE3srvuuDCCqYloJZ6ipPx2IxuJaaj8YfH/
	 ElOJse5KskFcZiFasHJVEv/hEO1fXBRra/9W5bk4jc0sYnClExB7PV0blHFyDzI+2J75WbbLVyyE
	 UbGrd5TYfI4OAHcMgPJfKDV3e6o7Rom4hz3FNAk03j8tP948fbcFO5/X3jSk4bur/czzKQIVjIeC
	 TNSA18IdX6tVwXZTovr7jHE+74x/qogAweOerS6bE4MIyijBWq8+cnVgW/+Bi7yLaAQcb8RWl5hT
	 wzYA2G70mqHN6g91lvW32UCqAgMpPcmNoiai43Hkx1CXcoEGYj
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miklos@szeredi.hu,
	brauner@kernel.org,
	aalbersh@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs: init flags_valid before calling vfs_fileattr_get
Date: Fri,  6 Feb 2026 14:20:28 +0800
X-OQ-MSGID: <20260206062027.9730-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
References: <698561f9.a00a0220.34fa92.0022.GAE@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76543-lists,linux-fsdevel=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[qq.com];
	TAGGED_RCPT(0.00)[linux-fsdevel,7c31755f2cea07838b0c];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,qq.com:email,qq.com:dkim,qq.com:mid]
X-Rspamd-Queue-Id: 1D167FA9B3
X-Rspamd-Action: no action

syzbot reported a uninit-value bug in [1].

Similar to the "*get" context where the kernel's internal file_kattr
structure is initialized before calling vfs_fileattr_get(), we should
use the same mechanism when using fa.

[1]
BUG: KMSAN: uninit-value in fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 fuse_fileattr_get+0xeb4/0x1450 fs/fuse/ioctl.c:517
 vfs_fileattr_get fs/file_attr.c:94 [inline]
 __do_sys_file_getattr fs/file_attr.c:416 [inline]
 
Local variable fa.i created at:
 __do_sys_file_getattr fs/file_attr.c:380 [inline]
 __se_sys_file_getattr+0x8c/0xbd0 fs/file_attr.c:372

Reported-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c31755f2cea07838b0c
Tested-by: syzbot+7c31755f2cea07838b0c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/file_attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index 13cdb31a3e94..4889cf59b256 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -377,7 +377,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 	struct filename *name __free(putname) = NULL;
 	unsigned int lookup_flags = 0;
 	struct file_attr fattr;
-	struct file_kattr fa;
+	struct file_kattr fa = { .flags_valid = true }; /* hint only */
 	int error;
 
 	BUILD_BUG_ON(sizeof(struct file_attr) < FILE_ATTR_SIZE_VER0);
-- 
2.43.0


