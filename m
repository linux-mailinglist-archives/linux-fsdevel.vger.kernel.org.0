Return-Path: <linux-fsdevel+bounces-55563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92477B0BF36
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 10:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C554917988B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D65288C81;
	Mon, 21 Jul 2025 08:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Si3AZFYG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D21288536;
	Mon, 21 Jul 2025 08:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753087494; cv=none; b=H/rL9xDoIQTHuBTfopAxavNbV92dzS/qGytgJclhCRn4xyhfdOVrpnESp04A8RK7+osY+U1CnVvFANKT1qdq1RI0ZDUfK9RRsHeOeIx2sIJvOqGwhXwIBiUnD261/v6o8XR6vnnGhEwflVL3FhSezXIYcrFJUwctihydDbQxcyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753087494; c=relaxed/simple;
	bh=vNxZDH7Bhbz1a0HBJOn6Dz7tHFiiCT6i8sc1DF47H0Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d9ek3NXr4L4TbT7ZboMboOFDojJOyB9AtbmZW09CIZ2hjlI58NVH7EOOlpcHQ9K5ASC9eY6c+6sg6HVq5f+YVQ1S+kk170426kJM78Vka7u6PLxje3HbTDBXCON63967L8mRkebmRJzlPO1TRChLD3NABp4azHJ6BvKGIgRmhmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Si3AZFYG; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4blv8x3nYLz9smq;
	Mon, 21 Jul 2025 10:44:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1753087489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KlhX/YlPjk57dYLUv3DmyL/xzfHmw74JI5i75aK49y8=;
	b=Si3AZFYGrm1OjV4Ha7ykFtgaBuOJi/xuI71oagydQoofK76nG264wF8DKS9CZvhO4uFtvN
	iUMnVZRY2S1LuObRArvLGyMca2zNsPoZlMbSA3srPabFTnFDhvdfPRJdb70+N8RjAByCkg
	BGpO69oP8VebPY/AdRjPxeMhdluhlvPKPf9OkkTBClZFbwpautuoVCiq3s8UciuuMTJLKb
	gwp7sbflF/mSbsqp2Xvt66A0ZAb/SulazazcUBAM24wxyrSPeAodDQQ3Fh1FIVwnJFKY/P
	mieQzmH0t3HPQJ4zJ8JlOWtpIGMm5usUpTDuYVSiMsgE8EoN0CpU/6Pci0Ypiw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Mon, 21 Jul 2025 18:44:11 +1000
Subject: [PATCH RFC 1/4] pidns: move is-ancestor logic to helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-procfs-pidns-api-v1-1-5cd9007e512d@cyphar.com>
References: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
In-Reply-To: <20250721-procfs-pidns-api-v1-0-5cd9007e512d@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2455; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=vNxZDH7Bhbz1a0HBJOn6Dz7tHFiiCT6i8sc1DF47H0Y=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWTU/n1foi34orx7cV2r49lTNu4Otaf66wK4PzCffa5Sv
 ldXcc+ljlIWBjEuBlkxRZZtfp6hm+YvvpL8aSUbzBxWJpAhDFycAjCRAD5GhklVUyLtxeVznI4X
 eL9O+FztmCZScvbTh2/KMdnqp+4xyjMyTNTmdHb4ueXQr+ri5Z7njqUqJL9NOuy5yEzg3ofnJ+o
 /MAMA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4blv8x3nYLz9smq

This check will be needed in later patches, and there's no point
open-coding it each time.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/linux/pid_namespace.h |  9 +++++++++
 kernel/pid_namespace.c        | 21 ++++++++++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index 7c67a5811199..df421a1e3e0b 100644
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
+bool pidns_is_ancestor(struct pid_namespace *child,
+		       struct pid_namespace *ancestor)
+{
+	return false;
+}
 #endif /* CONFIG_PID_NS */
 
 extern struct pid_namespace *task_active_pid_ns(struct task_struct *tsk);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 7098ed44e717..5719b1f679ad 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -390,6 +390,19 @@ static void pidns_put(struct ns_common *ns)
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


