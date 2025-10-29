Return-Path: <linux-fsdevel+bounces-66234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 537DEC1A405
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 13:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 926AB56505F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 12:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24C357A34;
	Wed, 29 Oct 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="avlouIab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C66346763;
	Wed, 29 Oct 2025 12:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740545; cv=none; b=kq7iTlgTkZZ6cA9UMwpZkzcEOy4nY06lca+jY2/PWmP0lbpntOi2zrnxIjPXvrLRGbFUJ0oKXXerzB46vZH7tTNnYbAcXuGvfk9YDW3R2ukfVyg6TF8lR7athm4lcBKSBogoJ3zGRdn9AArUCQgYqGvMRBXEtVb28H/VM6+gnyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740545; c=relaxed/simple;
	bh=1Vbdfejrzu8I2m1UigJuDF0ynX7SsD3EwMJY3zP1DiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgMbzrCZRm0FddajCPMYk/4KBJMhHK5qEeLn0YXZO11fMdpKRkoZUNdu7ME0Lozgh0LigV7RkCHOFMl43WWWYu4LRjrm+fZE6pOAS/OEFoJOwr4wLhxDOh8Bo6q8tDKHEraI/vD2MrsP+wSkFUZZhOAgBLIDDsJhwV0zo6O52Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=avlouIab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDF0C4CEF7;
	Wed, 29 Oct 2025 12:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761740544;
	bh=1Vbdfejrzu8I2m1UigJuDF0ynX7SsD3EwMJY3zP1DiU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=avlouIab2XwEc4Nq4R9lfVNYlQB8K8SggpO4b+Q5CSnMUQY/uM0AdvEsDR1VMtr1i
	 cm12Pn/75DhLSyWIgDpo+pfs8slDWSnuifA82qd19mrpChLIs0ODb2ZYOHCzgT2WPj
	 693Mz3pzMVdbOU9am0BLXNrM2NnS2QgEajXvepKMlMB6l52gsYRdXa++nHGpt2+Czb
	 ROcCkhEGs+nnjK90Lj8koPcBM6ZVlrsBmQbZDp33LsYnxfaAPfNe+HWoxhuXLvStEC
	 nY95ZRjVsHju0Kg6MwqjO5/YiMiCF7w5cHnC0nBlj22KHpJHXc6af2Igg7d0FlrCtx
	 tw0CKpqSx++Kw==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 29 Oct 2025 13:20:34 +0100
Subject: [PATCH v4 21/72] nsfs: update tools header
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-work-namespace-nstree-listns-v4-21-2e6f823ebdc0@kernel.org>
References: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
In-Reply-To: <20251029-work-namespace-nstree-listns-v4-0-2e6f823ebdc0@kernel.org>
To: linux-fsdevel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Jann Horn <jannh@google.com>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Amir Goldstein <amir73il@gmail.com>, Tejun Heo <tj@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 netdev@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=2616; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1Vbdfejrzu8I2m1UigJuDF0ynX7SsD3EwMJY3zP1DiU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQysfWu28LRIxhccKXhv02e41xjO/1mHv43m7ff9C704
 DFKYmfqKGVhEONikBVTZHFoNwmXW85TsdkoUwNmDisTyBAGLk4BmMjB7wz/Mwu7L589UCzN/t9U
 QeCWxp/0usfnXX96ijK++9Nz52MyJyPDLOG42lZ9Q26mWp6F6R9TJoWVrvDsE112hqf0l5mDsjY
 zAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Ensure all the new uapi bits are visible for the selftests.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 tools/include/uapi/linux/nsfs.h | 70 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/include/uapi/linux/nsfs.h b/tools/include/uapi/linux/nsfs.h
index 33c9b578b3b2..a25e38d1c874 100644
--- a/tools/include/uapi/linux/nsfs.h
+++ b/tools/include/uapi/linux/nsfs.h
@@ -53,6 +53,76 @@ enum init_ns_ino {
 	TIME_NS_INIT_INO	= 0xEFFFFFFAU,
 	NET_NS_INIT_INO		= 0xEFFFFFF9U,
 	MNT_NS_INIT_INO		= 0xEFFFFFF8U,
+#ifdef __KERNEL__
+	MNT_NS_ANON_INO		= 0xEFFFFFF7U,
+#endif
 };
 
+struct nsfs_file_handle {
+	__u64 ns_id;
+	__u32 ns_type;
+	__u32 ns_inum;
+};
+
+#define NSFS_FILE_HANDLE_SIZE_VER0 16 /* sizeof first published struct */
+#define NSFS_FILE_HANDLE_SIZE_LATEST sizeof(struct nsfs_file_handle) /* sizeof latest published struct */
+
+enum init_ns_id {
+	IPC_NS_INIT_ID		= 1ULL,
+	UTS_NS_INIT_ID		= 2ULL,
+	USER_NS_INIT_ID		= 3ULL,
+	PID_NS_INIT_ID		= 4ULL,
+	CGROUP_NS_INIT_ID	= 5ULL,
+	TIME_NS_INIT_ID		= 6ULL,
+	NET_NS_INIT_ID		= 7ULL,
+	MNT_NS_INIT_ID		= 8ULL,
+#ifdef __KERNEL__
+	NS_LAST_INIT_ID		= MNT_NS_INIT_ID,
+#endif
+};
+
+enum ns_type {
+	TIME_NS    = (1ULL << 7),  /* CLONE_NEWTIME */
+	MNT_NS     = (1ULL << 17), /* CLONE_NEWNS */
+	CGROUP_NS  = (1ULL << 25), /* CLONE_NEWCGROUP */
+	UTS_NS     = (1ULL << 26), /* CLONE_NEWUTS */
+	IPC_NS     = (1ULL << 27), /* CLONE_NEWIPC */
+	USER_NS    = (1ULL << 28), /* CLONE_NEWUSER */
+	PID_NS     = (1ULL << 29), /* CLONE_NEWPID */
+	NET_NS     = (1ULL << 30), /* CLONE_NEWNET */
+};
+
+/**
+ * struct ns_id_req - namespace ID request structure
+ * @size: size of this structure
+ * @spare: reserved for future use
+ * @filter: filter mask
+ * @ns_id: last namespace id
+ * @user_ns_id: owning user namespace ID
+ *
+ * Structure for passing namespace ID and miscellaneous parameters to
+ * statns(2) and listns(2).
+ *
+ * For statns(2) @param represents the request mask.
+ * For listns(2) @param represents the last listed mount id (or zero).
+ */
+struct ns_id_req {
+	__u32 size;
+	__u32 spare;
+	__u64 ns_id;
+	struct /* listns */ {
+		__u32 ns_type;
+		__u32 spare2;
+		__u64 user_ns_id;
+	};
+};
+
+/*
+ * Special @user_ns_id value that can be passed to listns()
+ */
+#define LISTNS_CURRENT_USER 0xffffffffffffffff /* Caller's userns */
+
+/* List of all ns_id_req versions. */
+#define NS_ID_REQ_SIZE_VER0 32 /* sizeof first published struct */
+
 #endif /* __LINUX_NSFS_H */

-- 
2.47.3


