Return-Path: <linux-fsdevel+bounces-56625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF13B19DD0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 10:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 852721794F1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Aug 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4D3242D76;
	Mon,  4 Aug 2025 08:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cH4+6Ecs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xzEOEukZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934A4241696;
	Mon,  4 Aug 2025 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754296828; cv=none; b=CQVwOPfmWVrFoHED9u8JU53IzCWwAqnoyt71XXrYPWZ9VJ3U6d8OodFq7loIqNsvgBTz7Nr7MHYmnaGhWltBy2LeeJO6eOVsN6Mf+THzV06xm09eumU26j00iokAF3bpUbB9UcnnVOUYmMXIc2gsoe4RBXfgV9Fjc3rZ0WDMg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754296828; c=relaxed/simple;
	bh=BVj2K46i1P8TjN6ep5m470ptQamNf/FI5rrL3pHLAbY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qpj9DeZy1DA4OicZdaEG1Di8UQMCt18tDsk1s85oYO/IWaDUudYdRKAxE/nI6c15jOlHb57rHbcCQN3OEKggxJ4v7JhGlxCDRpr4605iuDOYuKYn1YYaYHazFkw8VdNg9Pq8xpvTRSx7776Wy1z6N/0oDuMbpL1+WDYXVSQSQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cH4+6Ecs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xzEOEukZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754296824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cwf0xBGF64OhO606sUPwEaX7nlasQOFI0s+srhYAOK0=;
	b=cH4+6EcsXntrIwNvELdJaksa1ZJBUZc9iPdskQQYF7oIJcWRjRrDuOcyBRFMk5xAiV9kHI
	CRsnOZRW3mJSH5NLpqA7enidl8Nzf7+ArQ2YE0Qb7tQb24fBrLba42y7YM0QIbD8UBFOQm
	d+TQEu8LuCkhNBxMyYSR6Gk5YQ9X0FiJjYj2Ddx4hroGAeNQkTgV81QmOS7gmTwc/p5IHQ
	DmgW0JinXAMKvP89HG6/7CA0n1Pm5PB6TS1A3RLo90rtGIYC6uoQt0RcXRs+8XOn+1O/8D
	n/wR3XhphducfgSDhw1iNL4VCGENtGHyNwuHXWLZwNm6mj53Gep0YhdUIWpdEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754296824;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cwf0xBGF64OhO606sUPwEaX7nlasQOFI0s+srhYAOK0=;
	b=xzEOEukZDKkiXJneWe5t3rELp1DjU/OGtqk9xq1BQDXJAIihWCKk4xdHEtexNdLbLvZhYk
	SwAlOyMlg0LdgWBA==
Date: Mon, 04 Aug 2025 10:40:17 +0200
Subject: [PATCH v2] fs: always return zero on success from replace_fd()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250804-fix-receive_fd_replace-v2-1-ecb28c7b9129@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAPBxkGgC/4WNUQqDMBBEryL73ZQk1Vj65T2KiGTXuiBRNjZYx
 Ls39QL9fMPMmx0iCVOER7GDUOLIc8hgLwX4sQ8vUoyZwWpb6bs2auBNCXniRN2AndAy9Z5UPSB
 Wnlx1swh5vAjl5il+tplHjussn/MnmV/6V5mMMgpLh05rX5fomonDe5U58HZFgvY4ji9bgaF/w
 AAAAA==
X-Change-ID: 20250801-fix-receive_fd_replace-7fdd5ce6532d
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Sargun Dhillon <sargun@sargun.me>, Kees Cook <kees@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754296820; l=1840;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=BVj2K46i1P8TjN6ep5m470ptQamNf/FI5rrL3pHLAbY=;
 b=45K73s0Y6YV8fA2OCAJMAwAId01qWNo3p0vTqqz64u6yxrheS6UnXcxw5jJcaTKRAl8NQ19Ba
 7+NFieiBjwyA693gJYwdzaIYOSvbpGmudpzodXgi/+LiH99JpkMvtJ8
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

replace_fd() returns the number of the new file descriptor through the
return value of do_dup2(). However its callers never care about the
specific number. In fact the caller in receive_fd_replace() treats any
non-zero return value as an error and therefore never calls
__receive_sock() for most file descriptors, which is a bug.

To fix the bug in receive_fd_replace() and to avoid the same issue
happening in future callers, signal success through a plain zero.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/lkml/20250801220215.GS222315@ZenIV/
Fixes: 173817151b15 ("fs: Expand __receive_fd() to accept existing fd")
Fixes: 42eb0d54c08a ("fs: split receive_fd_replace from __receive_fd")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Move the fix to replace_fd() (Al)
- Link to v1: https://lore.kernel.org/r/20250801-fix-receive_fd_replace-v1-1-d46d600c74d6@linutronix.de
---
Untested, it stuck out while reading the code.
---
 fs/file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/file.c b/fs/file.c
index 6d2275c3be9c6967d16c75d1b6521f9b58980926..f8a271265913951d755a5db559938d589219c4f2 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1330,7 +1330,10 @@ int replace_fd(unsigned fd, struct file *file, unsigned flags)
 	err = expand_files(files, fd);
 	if (unlikely(err < 0))
 		goto out_unlock;
-	return do_dup2(files, file, fd, flags);
+	err = do_dup2(files, file, fd, flags);
+	if (err < 0)
+		goto out_unlock;
+	err = 0;
 
 out_unlock:
 	spin_unlock(&files->file_lock);

---
base-commit: d2eedaa3909be9102d648a4a0a50ccf64f96c54f
change-id: 20250801-fix-receive_fd_replace-7fdd5ce6532d

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


