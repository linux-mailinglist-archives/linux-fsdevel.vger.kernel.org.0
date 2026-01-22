Return-Path: <linux-fsdevel+bounces-75015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCeIKk8DcmmvZwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75015-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:00:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6B565A28
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 818A78A8910
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 10:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75BDC3B8BBF;
	Thu, 22 Jan 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m47B8e0H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8163A35DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769078950; cv=none; b=ibkBcbR4376kVwYzIcgTyp8NuJrIqca6myxNb0E5/tT9nR2zsqcgkDdqKlN13VMAcL4bAHrLsNMllGrt434YaeVRRwn1lwy8w2u6Wu4/75DjCnRUzpkRQNlqboAl2SaqM2hXFbjLJmWj5DOOfloh2hrocZJcmuJdNUvya5IjFUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769078950; c=relaxed/simple;
	bh=rpraz+CpTUVff2ozzDglsuz2apJ19c698O4vSTGoHJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E/VDKXzzBwvQB0eRgci4FAkliIzetyg9fSKg0meTMYKdSNy3eF/J4Waal7BeE4OoZHXTZkm/L+G1PfzBKMmsh0MaYiXDzAnS1NnHzCPkHpSC93NSQLVUH68QOIdyvyW3ovZ+tWw+mSF4WqvIv55BtSyMGMI7pnckectWKGMVrXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m47B8e0H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E81C116C6;
	Thu, 22 Jan 2026 10:49:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769078948;
	bh=rpraz+CpTUVff2ozzDglsuz2apJ19c698O4vSTGoHJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m47B8e0Hbh3QjDruRkuQMCk3A6AkaIIDAiGKAw+iKCS9pJ1ji0uacbWcIpPgANU3P
	 rZ4qE16iWXzjobOKdVzHdwIyhh7twDVN+7lBo4L8QMk7DAklvAJfsEIdAf+6BZQfAn
	 K9OKer9uxJlz3LQc6hzA6tjM/0/a7cZIff7Z6YwM62F/QxLizkRQEyzU2V/mEtMt6v
	 688fvqnzA4TAsImOwLwaRNvciGRiuHdrlApFWwaSL3rv58WqHyjAQZ86ti+avf8atu
	 Vs0VFuJJFtsQ32t/VDn9eFTxJOxyjqCphUTY1w4PWRMx72YuwJAiNi+LAoXkd3RzOj
	 5te9LPUTSVGwQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 22 Jan 2026 11:48:49 +0100
Subject: [PATCH 4/7] tools: update mount.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-work-fsmount-namespace-v1-4-5ef0a886e646@kernel.org>
References: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
In-Reply-To: <20260122-work-fsmount-namespace-v1-0-5ef0a886e646@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Josef Bacik <josef@toxicpanda.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1606; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rpraz+CpTUVff2ozzDglsuz2apJ19c698O4vSTGoHJg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQWMcx0rVyjeebu7+InZzICZ378Y6O5zmf+svhbwauif
 Vea/9lW21HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRS0wM/wwUtuwXTdq22Xna
 hFN8gm9XeT6KqsgJkbiwY8lLmx627AeMDNszL1btXX36A6e11Y/nLuc+f1oYuYeh7Pd0Xaup5+Q
 Np/EDAA==
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
	TAGGED_FROM(0.00)[bounces-75015-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 1E6B565A28
X-Rspamd-Action: no action

Update the mount.h header so we can rely on it in the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/mount.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/include/uapi/linux/mount.h b/tools/include/uapi/linux/mount.h
index 7fa67c2031a5..2204708dbf7a 100644
--- a/tools/include/uapi/linux/mount.h
+++ b/tools/include/uapi/linux/mount.h
@@ -61,7 +61,8 @@
 /*
  * open_tree() flags.
  */
-#define OPEN_TREE_CLONE		1		/* Clone the target tree and attach the clone */
+#define OPEN_TREE_CLONE		(1 << 0)	/* Clone the target tree and attach the clone */
+#define OPEN_TREE_NAMESPACE	(1 << 1)	/* Clone the target tree into a new mount namespace */
 #define OPEN_TREE_CLOEXEC	O_CLOEXEC	/* Close the file on execve() */
 
 /*
@@ -109,6 +110,7 @@ enum fsconfig_command {
  * fsmount() flags.
  */
 #define FSMOUNT_CLOEXEC		0x00000001
+#define FSMOUNT_NAMESPACE	0x00000002	/* Create the mount in a new mount namespace */
 
 /*
  * Mount attributes.
@@ -197,7 +199,10 @@ struct statmount {
  */
 struct mnt_id_req {
 	__u32 size;
-	__u32 spare;
+	union {
+		__u32 mnt_ns_fd;
+		__u32 mnt_fd;
+	};
 	__u64 mnt_id;
 	__u64 param;
 	__u64 mnt_ns_id;
@@ -232,4 +237,9 @@ struct mnt_id_req {
 #define LSMT_ROOT		0xffffffffffffffff	/* root mount */
 #define LISTMOUNT_REVERSE	(1 << 0) /* List later mounts first */
 
+/*
+ * @flag bits for statmount(2)
+ */
+#define STATMOUNT_BY_FD		0x00000001U	/* want mountinfo for given fd */
+
 #endif /* _UAPI_LINUX_MOUNT_H */

-- 
2.47.3


