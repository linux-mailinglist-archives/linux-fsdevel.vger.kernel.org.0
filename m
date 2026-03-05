Return-Path: <linux-fsdevel+bounces-79461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEuoFl0+qWnK3QAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:27:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A6820D6D8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 05 Mar 2026 09:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93CC1301E951
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Mar 2026 08:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A701372EF7;
	Thu,  5 Mar 2026 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjh0it27"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFEA36680F
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Mar 2026 08:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772699202; cv=none; b=JTOlTRXMfuLySwS5MXeeSF8Q/+80GULyIHcGkSCfkzHnjmOqi/tGCNKNvtRtyZvPR+HTAWl/7dvXywb/LH5LVpkqbIqjRYAbQeIDdv8CZe9e8FFop3DHM2ETx7Ql4pD72CLk2lqCG45mheX2KnjPLAm5oQTnbGyPcRQfzDHCDjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772699202; c=relaxed/simple;
	bh=appJNxvXAZ1qTdkOzxd46DdOguQx/fhK1KOjR5cyeAg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QGl+bwg5hChNUMTCcrOK0h560m5ae2hCg3YpEr6cfwMg4znQ+CHwjAJzjQ9VUL/848HGSCd73myUfuz7audnuyMLjdh43JdhpRsSoj1qeOdjwG5gZ9CBgQ9qAsvewzCJCVhGwOzs1P3NUSaP4KdRnoiRQYQx12w8WDK7SAbZC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjh0it27; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE5FC116C6;
	Thu,  5 Mar 2026 08:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772699202;
	bh=appJNxvXAZ1qTdkOzxd46DdOguQx/fhK1KOjR5cyeAg=;
	h=From:Date:Subject:To:Cc:From;
	b=fjh0it27PmUSmTEUDUWvLxr9P9Lmes/GnCQr/9QUTXPIePz+QiN06l+r7Ofg5i/7g
	 dK0nOJSNw3t/kM53iZkxCVI2lJgGFS4hVw3pnHBpBN47xP0SyEKdAgmNbSZEtye47r
	 U94bv/Y+HtmuZ8F499L+i2CuGlSXygsvyx5b5Xmer5nB2msqVipqPqjOv9Xe+AO2PF
	 BNCMtsvXT+PcJJsl5SH6Tw5TBNdZtXaUWirr34goX0Y+4kmVT+GEcWNbQ9Wq25EAz0
	 emh1vW/x7r6vC/Sgt96OflQGdqZY4vZ6kVK4eoMyb/qmb/HJ0msggwOtL45+XzjcP1
	 3zqiF2rb6vRyg==
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Date: Thu, 05 Mar 2026 09:26:29 +0100
Subject: [PATCH] MAINTAINERS: add mm-related procfs files to MM sections
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-maintainers-proc-v1-1-d6d09b3db3b6@kernel.org>
X-B4-Tracking: v=1; b=H4sIADQ+qWkC/x2MQQqAIBAAvyJ7TrDUoL4SHcS22kMqa0Qg/j3pM
 Ic5zBTIyIQZZlGA8aFMMTTpOwH+dOFASVtzGNQwKq2svByFu4GcZeLopVZorHcTGm2gZYlxp/d
 fLmutH4jz4QNiAAAA
X-Change-ID: 20260305-maintainers-proc-30e45ca9e434
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Lorenzo Stoakes <ljs@kernel.org>
Cc: Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org, 
 linux-fsdevel@vger.kernel.org, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123; i=vbabka@kernel.org;
 h=from:subject:message-id; bh=appJNxvXAZ1qTdkOzxd46DdOguQx/fhK1KOjR5cyeAg=;
 b=owEBiQF2/pANAwAIAbvgsHXSRYiaAcsmYgBpqT487tTwKDeClkZYrSim5P35ohDOl7AcH5w1p
 gAtpeZQHGuJAU8EAAEIADkWIQR7u8hBFZkjSJZITfG74LB10kWImgUCaak+PBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDIACgkQu+CwddJFiJpuLQf/fyyHRPgCXChezTV/ThaiDBewq8NjreX
 +rSI2RI8++6bgVApk8n7+BYKzyOzfw6XvvHZhVbHqp76krpGllyKEOZla91MP9W1RvuFApRLdW2
 eF31zssrll1QE8AGFWN7cmoiGeS/i4qzstWRxegUQvH0F7lNa7co1yocj0/a77uSnyOPXxbnyEa
 +g3nt0j5MJk3KJn/M51c922knWRrLMId2V1GaJPI+pC23/ae9Juj6QTQUH3XyfS15BnJlIMQ20n
 n8xCTnee8flnzG6tL1LTz/mD6UpijjTgoZAF3Vbv0MvNVrjw2oqlH6JRRKdkfHA32G1Yzps/uyZ
 pTHU5XfP8sg==
X-Developer-Key: i=vbabka@kernel.org; a=openpgp;
 fpr=A940D434992C2E8E99103D50224FA7E7CC82A664
X-Rspamd-Queue-Id: B1A6820D6D8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79461-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vbabka@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-mm.org:url]
X-Rspamd-Action: no action

Some procfs files are very much related to memory management so let's
have MAINTAINERS reflect that.

Add fs/proc/meminfo.c to MEMORY MANAGEMENT - CORE.

Add fs/proc/task_[no]mmu.c to MEMORY MAPPING.

Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3553554019e8..39987895bcfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16683,6 +16683,7 @@ F:	include/linux/ptdump.h
 F:	include/linux/vmpressure.h
 F:	include/linux/vmstat.h
 F:	include/trace/events/zone_lock.h
+F:	fs/proc/meminfo.c
 F:	kernel/fork.c
 F:	mm/Kconfig
 F:	mm/debug.c
@@ -16998,6 +16999,8 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/trace/events/mmap.h
+F:	fs/proc/task_mmu.c
+F:	fs/proc/task_nommu.c
 F:	mm/interval_tree.c
 F:	mm/mincore.c
 F:	mm/mlock.c

---
base-commit: 7fcd8889fbf318409163ff5033fe161dd2a73243
change-id: 20260305-maintainers-proc-30e45ca9e434

Best regards,
-- 
Vlastimil Babka (SUSE) <vbabka@kernel.org>


