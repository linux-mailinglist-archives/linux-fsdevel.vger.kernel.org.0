Return-Path: <linux-fsdevel+bounces-75018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEdDEqcDcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:01:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 130D365A71
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 129046C576D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E10A41C2F5;
	Thu, 22 Jan 2026 10:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LT6ZWsx6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B983BFE35
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078955; cv=none; b=emCFfnFphovJO2UbNCdru4hzcHZ0Iuv/rAxFs/pgZ4HlYrPfDQbRBam/Eu7Jyi/eR4JAgls2MBxyIDzeFsIL0+OU8eNpBIqVv+KoqP+gbUq7cAHlP88/pwa2fgC5U2CNZfvcKxnNRJDpMMan7txMyq31BhoTrkoc40SkCLh8giQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078955; c=relaxed/simple;
	bh=4DK1RW4Mvv40Q7jC3XcGwuNPAZU52VAXoQsTgfRGmwQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aYwP84wGGswP/KPQBPFWIHCOjpGAh7xDQ04J6xU2FMV07UXWHyBErH/v+Tq9KPKur8HNgLR08TsEBXWCN2pYTtBsyZF6cEMeiB6hmW3sgdiwFkm641ZEk7hSNVEBYWW0ZtTGcY1zlnuMTYSIWMaBEqTz7rH/1GEMusQPVnqQ4Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LT6ZWsx6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811E1C16AAE;
	Thu, 22 Jan 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078955;
	bh=4DK1RW4Mvv40Q7jC3XcGwuNPAZU52VAXoQsTgfRGmwQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LT6ZWsx6YSLS56x4MWRnvqtKY92DH1wCLLxGAcvamft8TY9dJ1sqT4jrAK6JsJopo
	 VlhDqtfYzP5ZCf+EZxopOVOGLt66jOWii1/Nsxf1ruYvl3lm17CxpU+yfXQ0ciMY3M
	 mtE+Z5MXF5tRnxnvPnPeEhc0/VKWaYkbeuglhjEa2c95+KHdLuc0CbAYNTsW3C00Am
	 62SXx74Hsv+t9ko/q/LV+1EbiXOJnYqa5+iO2Q2hXX+FgBzOwYkwwMoiCvaZP42KB5
	 1ao6Z/cY+v/SRdjXrbDze+34yALlTRhsxnKw4be3nHlq0N5xWUMZ9A47OapL+lMi4H
	 GchjmwECKFEzw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:52 +0100
Subject: [PATCH 7/7] selftests/open_tree_ns: fix compilation
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-7-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3327; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4DK1RW4Mvv40Q7jC3XcGwuNPAZU52VAXoQsTgfRGmwQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMcwU/rn7vpeXQvSTqMkbZm59EnT0weKKeZFGL+8Eb
 tpz+mVvT0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBE3m1g+CvCXv7piYzLI5X7
 P1aXOk6KW1W/95fssr3nQwL/tYrdL3Nj+F94r6RPfsqpzufr9h+eIbJl44rV/kVrP1sJWiw+qSp
 ZOIETAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,gmail.com,toxicpanda.com,cyphar.com];
	TAGGED_FROM(0.00)[bounces-75018-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 130D365A71
X-Rspamd-Action: no action

Fix open_tree_ns selftests and remove it's own local version of the
statmount() allocation helper.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 .../selftests/filesystems/open_tree_ns/Makefile    |  2 +-
 .../filesystems/open_tree_ns/open_tree_ns_test.c   | 33 ++++------------------
 2 files changed, 6 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/filesystems/open_tree_ns/Makefile b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
index 73c03c4a7ef6..4976ed1d7d4a 100644
--- a/tools/testing/selftests/filesystems/open_tree_ns/Makefile
+++ b/tools/testing/selftests/filesystems/open_tree_ns/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 TEST_GEN_PROGS := open_tree_ns_test
 
-CFLAGS := -Wall -Werror -g $(KHDR_INCLUDES)
+CFLAGS += -Wall -O0 -g $(KHDR_INCLUDES) $(TOOLS_INCLUDES)
 LDLIBS := -lcap
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
index 9711556280ae..7511696bea25 100644
--- a/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
+++ b/tools/testing/selftests/filesystems/open_tree_ns/open_tree_ns_test.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (c) 2026 Christian Brauner <brauner@kernel.org>
+ *
  * Test for OPEN_TREE_NAMESPACE flag.
  *
  * Test that open_tree() with OPEN_TREE_NAMESPACE creates a new mount
@@ -50,31 +52,6 @@ static int get_mnt_ns_id_from_path(const char *path, uint64_t *mnt_ns_id)
 	return ret;
 }
 
-#define STATMOUNT_BUFSIZE (1 << 15)
-
-static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask)
-{
-	struct statmount *buf;
-	size_t bufsize = STATMOUNT_BUFSIZE;
-	int ret;
-
-	for (;;) {
-		buf = malloc(bufsize);
-		if (!buf)
-			return NULL;
-
-		ret = statmount(mnt_id, mnt_ns_id, mask, buf, bufsize, 0);
-		if (ret == 0)
-			return buf;
-
-		free(buf);
-		if (errno != EOVERFLOW)
-			return NULL;
-
-		bufsize <<= 1;
-	}
-}
-
 static void log_mount(struct __test_metadata *_metadata, struct statmount *sm)
 {
 	const char *fs_type = "";
@@ -221,7 +198,7 @@ FIXTURE_SETUP(open_tree_ns)
 		SKIP(return, "open_tree() syscall not supported");
 
 	/* Check if statmount/listmount are supported */
-	ret = statmount(0, 0, 0, NULL, 0, 0);
+	ret = statmount(0, 0, 0, 0, NULL, 0, 0);
 	if (ret == -1 && errno == ENOSYS)
 		SKIP(return, "statmount() syscall not supported");
 
@@ -340,7 +317,7 @@ TEST_F(open_tree_ns, verify_mount_properties)
 	ASSERT_GE(nr_mounts, 1);
 
 	/* Get info about the root mount (the bind mount, rootfs is hidden) */
-	ret = statmount(list[0], new_ns_id, STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0);
+	ret = statmount(list[0], new_ns_id, 0, STATMOUNT_MNT_BASIC, &sm, sizeof(sm), 0);
 	ASSERT_EQ(ret, 0);
 
 	ASSERT_NE(sm.mnt_id, sm.mnt_parent_id);
@@ -452,7 +429,7 @@ FIXTURE_SETUP(open_tree_ns_userns)
 		SKIP(return, "open_tree() syscall not supported");
 
 	/* Check if statmount/listmount are supported */
-	ret = statmount(0, 0, 0, NULL, 0, 0);
+	ret = statmount(0, 0, 0, 0, NULL, 0, 0);
 	if (ret == -1 && errno == ENOSYS)
 		SKIP(return, "statmount() syscall not supported");
 }

-- 
2.47.3


