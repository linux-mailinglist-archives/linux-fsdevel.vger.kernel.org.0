Return-Path: <linux-fsdevel+bounces-61051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68EEB54BC0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 13:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997535862BB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 11:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC114308F27;
	Fri, 12 Sep 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sSJxFFFm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B89302162;
	Fri, 12 Sep 2025 11:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678015; cv=none; b=O3ZWwcY+zaOvgNm1Y60yhTi0eWxQIlOANvPlKZovq3Bba8paVVacPRcanPTwFRMD+ecIrINFrEHPGU3V1KT+QxM/Deilv9v0xtBXyrxWMIveoFMZSgACl41ezaNNIrzVrsB6GRj7ZptxA79S8AYN65y2bULH3eP0gGeqGO+cAN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678015; c=relaxed/simple;
	bh=zPA7souuP4HjB1UkBna05aMTUug+4OcAojyhqy386NY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQDq/NTeoxxwA003rzErMRNyf+AqDvZ7sQKo+aHsyGdQbYqiLwXmSJQMUHw8r3Lav2FzswMQhyrjl6OgzLAdNjZreru5MOYMk0xzBWr99qoFXjtm40zZzcjQkHq35uVzQpiQUqysPmWptr6tnYpmqapKJWbK8jucTJT645eVMco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sSJxFFFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716A9C4CEF1;
	Fri, 12 Sep 2025 11:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678014;
	bh=zPA7souuP4HjB1UkBna05aMTUug+4OcAojyhqy386NY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sSJxFFFmUN6Pae+zgxwPYE3PGYij3X3w9OypT0nVQf3NlTShBb766FLZMac0KAIDH
	 A0RObvlJ4FppvinuFbloJMHRxwsMcCF9T08oyZ65FaEqcby+yR3O5ONchkulV+uI2h
	 BS72fT60Z7EpxSwlz/BfgEs5cThRs5QQTqrOTYU4ESdjWk2WPuVmcz5Je4U7IHYEWT
	 n4YfXLZ3IB00aGvXNETKaNoBqG4CW1GpSPfwfYUcX7GGoCZqeZRgIcFZPyKiIfAv7q
	 EGdXjn7v44ZlDKinRYAnUX7ry2u5Nfbp/ivHuAU0eugSKZQfDEyiFSm2GLFHw8Vzvt
	 Jy1GJTzJJWNaQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:29 +0200
Subject: [PATCH v2 06/33] nsfs: add nsfs.h header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-6-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zPA7souuP4HjB1UkBna05aMTUug+4OcAojyhqy386NY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyirq31c+/u3vT4M9Mv3J2jutayvbe7tiDnW75jR
 o30FBWVjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImkb2Fk6C9/ebCLoV/K7vr9
 1ULP4jNURJZtdDKtj1md8WLditP/bRkZ3i07oPu9p/SPWrWtV7pa3uIHjfZxkQ9OWRxJzdW/lC7
 GBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

And move the stuff out from proc_ns.h where it really doesn't belong.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 include/linux/nsfs.h    | 26 ++++++++++++++++++++++++++
 include/linux/proc_ns.h | 13 +------------
 2 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/include/linux/nsfs.h b/include/linux/nsfs.h
new file mode 100644
index 000000000000..fb84aa538091
--- /dev/null
+++ b/include/linux/nsfs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Christian Brauner <brauner@kernel.org> */
+
+#ifndef _LINUX_NSFS_H
+#define _LINUX_NSFS_H
+
+#include <linux/ns_common.h>
+
+struct path;
+struct task_struct;
+struct proc_ns_operations;
+
+int ns_get_path(struct path *path, struct task_struct *task,
+		const struct proc_ns_operations *ns_ops);
+typedef struct ns_common *ns_get_path_helper_t(void *);
+int ns_get_path_cb(struct path *path, ns_get_path_helper_t ns_get_cb,
+		   void *private_data);
+
+bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino);
+
+int ns_get_name(char *buf, size_t size, struct task_struct *task,
+			const struct proc_ns_operations *ns_ops);
+void nsfs_init(void);
+
+#endif /* _LINUX_NSFS_H */
+
diff --git a/include/linux/proc_ns.h b/include/linux/proc_ns.h
index 4b20375f3783..5e1a4b378b79 100644
--- a/include/linux/proc_ns.h
+++ b/include/linux/proc_ns.h
@@ -5,7 +5,7 @@
 #ifndef _LINUX_PROC_NS_H
 #define _LINUX_PROC_NS_H
 
-#include <linux/ns_common.h>
+#include <linux/nsfs.h>
 #include <uapi/linux/nsfs.h>
 
 struct pid_namespace;
@@ -75,16 +75,5 @@ static inline int ns_alloc_inum(struct ns_common *ns)
 #define ns_free_inum(ns) proc_free_inum((ns)->inum)
 
 #define get_proc_ns(inode) ((struct ns_common *)(inode)->i_private)
-extern int ns_get_path(struct path *path, struct task_struct *task,
-			const struct proc_ns_operations *ns_ops);
-typedef struct ns_common *ns_get_path_helper_t(void *);
-extern int ns_get_path_cb(struct path *path, ns_get_path_helper_t ns_get_cb,
-			    void *private_data);
-
-extern bool ns_match(const struct ns_common *ns, dev_t dev, ino_t ino);
-
-extern int ns_get_name(char *buf, size_t size, struct task_struct *task,
-			const struct proc_ns_operations *ns_ops);
-extern void nsfs_init(void);
 
 #endif /* _LINUX_PROC_NS_H */

-- 
2.47.3


