Return-Path: <linux-fsdevel+bounces-78837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gElSNNyXo2neHgUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78837-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 02:35:24 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1D1CB0A3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 02:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 683E1303B15C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EE128FFFB;
	Sun,  1 Mar 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MV9lDI4r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBF72631;
	Sun,  1 Mar 2026 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772328503; cv=none; b=kxZb1M4ZvsW8S/gLGixFWmBAheeSA5APkxGEvd1PvICfzJOSkH+ADqxfk4FLdKmT0j+sztwozvpbNfvyBwwIw3XRMzhbnFHq/LLpETs2GOjvaxOP7hrr1uT6yYzHHNpU7EROqPvESJq6fQ8RSAqbJKePZOaC4e2y9iNO4IazchE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772328503; c=relaxed/simple;
	bh=rOnItPvOeFC2493odyiJAqkJBMeTyNPmiHvAb5UL000=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPtb6qh4VtX/etPXS3NgSCH5ORwfhtVBAUZsOWKf0XnJs3OdyU1SgMOh+MY6kPNuyLlOvWcjrGrV3oRcRs8BzkpZcPh3FAGbiyoddbmA8HcrFuHC+NKHRUjHLahbQwK6XweBQ/XzaqdlUOW+DqnS95y6wvZlbSBaYbNSjKrKZKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MV9lDI4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343F4C19421;
	Sun,  1 Mar 2026 01:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772328503;
	bh=rOnItPvOeFC2493odyiJAqkJBMeTyNPmiHvAb5UL000=;
	h=From:To:Cc:Subject:Date:From;
	b=MV9lDI4rr50SjZ5FU/nlPX4lua9d10wF3QxENSkfPfCzDnE/8CYP70v89l3REM1PA
	 qU1ImWbPKUxDbp4w6gKXoBXY6fvmx84MeBlUCpyM8u1y6oIV31aqhvwwHnDGhm+RxS
	 0rL6tU2d7iatWhNGKVfi4M4s17/dg30kpw1PPxYu68NdJcHk25wNQzrzJ8dhHolh7t
	 jUWBoG0ehAbOWIHoXB2Hs/ifJDPL7JyfdDQ2xS1+xFu/eFd3HCi8OEpqRwDP+rb7x3
	 kTh1+D2a5eG1zZcpP+iwDIS9q0F/QqZB1AuHE0udUvWSMBjh+Ne2E1/m3VCD5tbPDe
	 s7NtW1P1Ku/ZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	andrii@kernel.org
Cc: Ruikai Peng <ruikai@pwno.io>,
	Thomas Gleixner <tglx@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: FAILED: Patch "procfs: fix possible double mmput() in do_procmap_query()" failed to apply to 6.12-stable tree
Date: Sat, 28 Feb 2026 20:28:20 -0500
Message-ID: <20260301012821.1686076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78837-lists,linux-fsdevel=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,237b5b985b78c1da9600];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 11D1D1CB0A3
X-Rspamd-Action: no action

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 61dc9f776705d6db6847c101b98fa4f0e9eb6fa3 Mon Sep 17 00:00:00 2001
From: Andrii Nakryiko <andrii@kernel.org>
Date: Tue, 10 Feb 2026 11:27:38 -0800
Subject: [PATCH] procfs: fix possible double mmput() in do_procmap_query()

When user provides incorrectly sized buffer for build ID for PROCMAP_QUERY
we return with -ENAMETOOLONG error.  After recent changes this condition
happens later, after we unlocked mmap_lock/per-VMA lock and did mmput(),
so original goto out is now wrong and will double-mmput() mm_struct.  Fix
by jumping further to clean up only vm_file and name_buf.

Link: https://lkml.kernel.org/r/20260210192738.3041609-1-andrii@kernel.org
Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Reported-by: Ruikai Peng <ruikai@pwno.io>
Reported-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Cc: Ruikai Peng <ruikai@pwno.io>
Closes: https://lkml.kernel.org/r/CAFD3drOJANTZPuyiqMdqpiRwOKnHwv5QgMNZghCDr-WxdiHvMg@mail.gmail.com
Closes: https://lore.kernel.org/all/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/task_mmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 26188a4ad1abd..2f55efc368162 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -780,7 +780,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 		} else {
 			if (karg.build_id_size < build_id_sz) {
 				err = -ENAMETOOLONG;
-				goto out;
+				goto out_file;
 			}
 			karg.build_id_size = build_id_sz;
 		}
@@ -808,6 +808,7 @@ static int do_procmap_query(struct mm_struct *mm, void __user *uarg)
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+out_file:
 	if (vm_file)
 		fput(vm_file);
 	kfree(name_buf);
-- 
2.51.0





