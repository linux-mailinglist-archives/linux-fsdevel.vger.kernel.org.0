Return-Path: <linux-fsdevel+bounces-55933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6956DB10397
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 10:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38691C262E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Jul 2025 08:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCA4274FD7;
	Thu, 24 Jul 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="atZF9+1z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D1426A1A3;
	Thu, 24 Jul 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345957; cv=none; b=CiKDdyy4CV1T0xr3nNnh7tD/a0sDjJpAk0GJOniQ70NgPuBDdSslf8p4afAFoH5M7VpqGi+xT6HM4dk60xPVEDz5jD2/3EHjF4h4ukj7z9MEdEjZH80I6qInVn1tPjnlKufJ+0xzyFm17S4LO10ny9bj5QabTxxe5fzLpcGrdrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345957; c=relaxed/simple;
	bh=KixoyUtbGrLnA3MTF47jcmrfse0K1oiiVQANOqAk1hI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pB28jcvtlvAsv58SbODxdiFsoF9iF2kuAVbrx5e/Nd3KvV4/N7QN6VMedaC/tILBQsYZ6CFSeg+GukIP+bv6Jvb6+P3/2eVD7/d6dEGNA2BDk7AKNuM34vwq1P8oWtoTbj9GDtR1VVNkN8B88uUuBLOMGXYB+6Zft260Dur6kPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=atZF9+1z; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bnklG2l7Lz9t95;
	Thu, 24 Jul 2025 10:32:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753345946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz5+/xzkeEXoj428r2lantinAr2RMkc/0PWdNpXULag=;
	b=atZF9+1zhyrl4eHa/Crrcp/HNJb/OYpnX9YXw9ICtMgS3OUNOyFq5M/fwIKe7XNcrP/xrz
	qzuHWfyfSJvbPp0yGbn+8g4io3puYL+7A/0Nul3+9tZtu3VZHuYmOgUSi56FClpime/fZj
	1F4cyZWvpOsSpJoUcrSJgUqoUpmKZ1Akwgr/w552h75aNMMpNcTxsg/E9FxEji54SUavtD
	sAhv6KCO9UHSpsqrE0zTNKeoXfF6aEvSGi1GzgTw/ZD4VlyN7jW8B1YLbtkTjq2WaPhiU3
	0RIaj1Is0Ob083L5CTYBy91Um7d+9W0yRhviWt7vXgX5SEUuU9PLyzg/eElxmQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 24 Jul 2025 18:32:03 +1000
Subject: [PATCH v3 1/4] pidns: move is-ancestor logic to helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-procfs-pidns-api-v3-1-4c685c910923@cyphar.com>
References: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
In-Reply-To: <20250724-procfs-pidns-api-v3-0-4c685c910923@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2749; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=KixoyUtbGrLnA3MTF47jcmrfse0K1oiiVQANOqAk1hI=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQ0vu/U3h2k9kNHVelrxGQXxyufc2LkzS8vPbitN8Bwj
 s3WtJA1HaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiTqsY/ul5ce16cKhyx5zC
 rx+fT+hZs79195Sj4hyLhDsXzbU2S4xlZHh++KztVlmWo8uZ9ngyPVmosaPBPsaIa9VT+Vu++ry
 2JxkB
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bnklG2l7Lz9t95

This check will be needed in later patches, and there's no point
open-coding it each time.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h |  9 +++++++++
 kernel/pid_namespace.c        | 23 +++++++++++++++--------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a5811199..17fdc059f8da 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -84,6 +84,9 @@ extern void zap_pid_ns_processes(struct pid_namespace *pid_ns);
 extern int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd);
 extern void put_pid_ns(struct pid_namespace *ns);
 
+extern bool pidns_is_ancestor(struct pid_namespace *child,
+			      struct pid_namespace *ancestor);
+
 #else /* !CONFIG_PID_NS */
 #include <linux/err.h>
 
@@ -118,6 +121,12 @@ static inline int reboot_pid_ns(struct pid_namespace *pid_ns, int cmd)
 {
 	return 0;
 }
+
+static inline bool pidns_is_ancestor(struct pid_namespace *child,
+				     struct pid_namespace *ancestor)
+{
+	return false;
+}
 #endif /* CONFIG_PID_NS */
 
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..c2783c5fa90b 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -390,11 +390,24 @@ static void pidns_put(struct ns_common *ns)
 	put_pid_ns(to_pid_ns(ns));
 }
 
+bool pidns_is_ancestor(struct pid_namespace *child,
+		       struct pid_namespace *ancestor)
+{
+	struct pid_namespace *ns;
+
+	if (child->level < ancestor->level)
+		return false;
+	for (ns = child; ns->level > ancestor->level; ns = ns->parent)
+		;
+	return ns == ancestor;
+}
+EXPORT_SYMBOL_GPL(pidns_is_ancestor);
+
 static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 {
 	struct nsproxy *nsproxy = nsset->nsproxy;
 	struct pid_namespace *active = task_active_pid_ns(current);
-	struct pid_namespace *ancestor, *new = to_pid_ns(ns);
+	struct pid_namespace *new = to_pid_ns(ns);
 
 	if (!ns_capable(new->user_ns, CAP_SYS_ADMIN) ||
 	    !ns_capable(nsset->cred->user_ns, CAP_SYS_ADMIN))
@@ -408,13 +421,7 @@ static int pidns_install(struct nsset *nsset, struct ns_common *ns)
 	 * this maintains the property that processes and their
 	 * children can not escape their current pid namespace.
 	 */
-	if (new->level < active->level)
-		return -EINVAL;
-
-	ancestor = new;
-	while (ancestor->level > active->level)
-		ancestor = ancestor->parent;
-	if (ancestor != active)
+	if (!pidns_is_ancestor(new, active))
 		return -EINVAL;
 
 	put_pid_ns(nsproxy->pid_ns_for_children);

-- 
2.50.0


