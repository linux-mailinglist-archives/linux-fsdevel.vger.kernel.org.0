Return-Path: <linux-fsdevel+bounces-7313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F014D823867
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 730851F25032
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D83208BE;
	Wed,  3 Jan 2024 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxKtrbMj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECCD208BB;
	Wed,  3 Jan 2024 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso625649a12.3;
        Wed, 03 Jan 2024 14:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321778; x=1704926578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HZKG0+8bOrcMVz8DZz+ELjEjEoDwyx2ZdYAuvWnw0cE=;
        b=YxKtrbMjHA7VzQkGftdxZwS0PNvgsHCUJvsRoywI7pUztQIMBzltEEhefuN4tSbGMc
         WOW/S7S1fUuYTSjxMjFvZ987FJCLpc7z/uv+RbEtYaAIq4v8ALY9juYnsw7FIEBLe863
         XMljYXRR90ri/J/x+I9LLD+JfQ9tLTqE9/5gy7MFrB77sRSx5DfFp7n8lQVtBSby8l4p
         L64VK0d3Ig/g6EGKxPPXGYa7GK9SPsWWWnsmggcy2djTAGjNRPv7XOWnk9PlmkIguidI
         Ko9bvXB39E1D5vPZVn9BvJxLqM/EvUO/6S1N9oI7xCW2zl/5gkRwCGz4sRo3D3IImZHf
         +RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321778; x=1704926578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZKG0+8bOrcMVz8DZz+ELjEjEoDwyx2ZdYAuvWnw0cE=;
        b=RIQj24kEiGfimS1IVst8vGw40KpySX4a7Fnc+j4TBw4dmosnu0EbVJF7QIuzX8nKrf
         NGQcPnn5gsnmd7yc1CVZznPK/+0TuFE7c66kp0a0elD28cjr7hyjwzuWierAy6KOMbGf
         PJiTqfQDcLDe2Q1PQwYbzH70QiT/dXm6Z6M6rf8MLzFTydhGXlDwwXBB8gN1EA/Eq8jT
         rhJxmziPxP8V1Hn8NGbSejn2xxd63K2rKF+hxHoM/mMFMDXF5QUMIJ1xUmeBn9/htqOE
         DCRZGnCmqAQiXP4jjffrgE/F3BfYOCF4l18ui/FKICGQ+04PxXOWcSY0RIuBdk+o/2gw
         fCPg==
X-Gm-Message-State: AOJu0YzEvsvZ0c3xabq9I1L2oZFIVG+Q4hAbWArg17KQxV1qoIdlRypE
	c2fq9NbKkQlb7Xk427dTmw==
X-Google-Smtp-Source: AGHT+IEjgc4CjelPkG95hlPm6CS+AolxPwp3LIumI7aUMfOsB138oQK6JNgNBpHDs3udC29zWbYE5w==
X-Received: by 2002:a17:90a:e98c:b0:28b:c1ad:9cf5 with SMTP id v12-20020a17090ae98c00b0028bc1ad9cf5mr7508460pjy.26.1704321778498;
        Wed, 03 Jan 2024 14:42:58 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:58 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	akpm@linux-foundation.org,
	arnd@arndb.de,
	tglx@linutronix.de,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	mhocko@kernel.org,
	tj@kernel.org,
	ying.huang@intel.com,
	gregory.price@memverge.com,
	corbet@lwn.net,
	rakie.kim@sk.com,
	hyeongtak.ji@sk.com,
	honggyu.kim@sk.com,
	vtavarespetr@micron.com,
	peterz@infradead.org,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	sthanneeru@micron.com,
	emirakhur@micron.com,
	Hasan.Maruf@amd.com,
	seungjun.ha@samsung.com
Subject: [PATCH v6 05/12] mm/mempolicy: create struct mempolicy_param for creating new mempolicies
Date: Wed,  3 Jan 2024 17:42:02 -0500
Message-Id: <20240103224209.2541-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20240103224209.2541-1-gregory.price@memverge.com>
References: <20240103224209.2541-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a new kernel structure `struct mempolicy_param`,
intended to be used for an extensible get/set_mempolicy interface.

This implements the fields required to support the existing syscall
interfaces interfaces, but does not expose any user-facing arg
structure.

mpol_new is refactored to take the argument structure so that future
mempolicy extensions can all be managed in the mempolicy constructor.

The get_mempolicy and mbind syscalls are refactored to utilize the
new argument structure, as are all the callers of mpol_new() and
do_set_mempolicy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 include/linux/mempolicy.h | 11 +++++++
 mm/mempolicy.c            | 69 +++++++++++++++++++++++++++++----------
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index fae903b1d3de..e6795e2d0cc2 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -62,6 +62,17 @@ struct mempolicy {
 	} wil;
 };
 
+/*
+ * Describes settings of a mempolicy during set/get syscalls and
+ * kernel internal calls to do_set_mempolicy()
+ */
+struct mempolicy_param {
+	unsigned short mode;		/* policy mode */
+	unsigned short mode_flags;	/* policy mode flags */
+	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
+	nodemask_t *policy_nodes;	/* get/set/mbind */
+};
+
 /*
  * Support for managing mempolicy data objects (clone, copy, destroy)
  * The default fast path of a NULL MPOL_DEFAULT policy is always inlined.
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6e2ea94c0f31..1f6f19b5d157 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -280,10 +280,12 @@ static int mpol_set_nodemask(struct mempolicy *pol,
  * This function just creates a new policy, does some check and simple
  * initialization. You must invoke mpol_set_nodemask() to set nodes.
  */
-static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
-				  nodemask_t *nodes)
+static struct mempolicy *mpol_new(struct mempolicy_param *param)
 {
 	struct mempolicy *policy;
+	unsigned short mode = param->mode;
+	unsigned short flags = param->mode_flags;
+	nodemask_t *nodes = param->policy_nodes;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -832,8 +834,7 @@ static int mbind_range(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /* Set the process memory policy */
-static long do_set_mempolicy(unsigned short mode, unsigned short flags,
-			     nodemask_t *nodes)
+static long do_set_mempolicy(struct mempolicy_param *param)
 {
 	struct mempolicy *new, *old;
 	NODEMASK_SCRATCH(scratch);
@@ -842,14 +843,14 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 	if (!scratch)
 		return -ENOMEM;
 
-	new = mpol_new(mode, flags, nodes);
+	new = mpol_new(param);
 	if (IS_ERR(new)) {
 		ret = PTR_ERR(new);
 		goto out;
 	}
 
 	task_lock(current);
-	ret = mpol_set_nodemask(new, nodes, scratch);
+	ret = mpol_set_nodemask(new, param->policy_nodes, scratch);
 	if (ret) {
 		task_unlock(current);
 		mpol_put(new);
@@ -1247,8 +1248,7 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 #endif
 
 static long do_mbind(unsigned long start, unsigned long len,
-		     unsigned short mode, unsigned short mode_flags,
-		     nodemask_t *nmask, unsigned long flags)
+		     struct mempolicy_param *mparam, unsigned long flags)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -1268,7 +1268,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (start & ~PAGE_MASK)
 		return -EINVAL;
 
-	if (mode == MPOL_DEFAULT)
+	if (mparam->mode == MPOL_DEFAULT)
 		flags &= ~MPOL_MF_STRICT;
 
 	len = PAGE_ALIGN(len);
@@ -1279,7 +1279,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	if (end == start)
 		return 0;
 
-	new = mpol_new(mode, mode_flags, nmask);
+	new = mpol_new(mparam);
 	if (IS_ERR(new))
 		return PTR_ERR(new);
 
@@ -1296,7 +1296,8 @@ static long do_mbind(unsigned long start, unsigned long len,
 		NODEMASK_SCRATCH(scratch);
 		if (scratch) {
 			mmap_write_lock(mm);
-			err = mpol_set_nodemask(new, nmask, scratch);
+			err = mpol_set_nodemask(new, mparam->policy_nodes,
+						scratch);
 			if (err)
 				mmap_write_unlock(mm);
 		} else
@@ -1310,7 +1311,7 @@ static long do_mbind(unsigned long start, unsigned long len,
 	 * Lock the VMAs before scanning for pages to migrate,
 	 * to ensure we don't miss a concurrently inserted page.
 	 */
-	nr_failed = queue_pages_range(mm, start, end, nmask,
+	nr_failed = queue_pages_range(mm, start, end, mparam->policy_nodes,
 			flags | MPOL_MF_INVERT | MPOL_MF_WRLOCK, &pagelist);
 
 	if (nr_failed < 0) {
@@ -1511,6 +1512,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
+	struct mempolicy_param mparam;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1525,7 +1527,12 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
-	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
+	memset(&mparam, 0, sizeof(mparam));
+	mparam.mode = lmode;
+	mparam.mode_flags = mode_flags;
+	mparam.policy_nodes = &nodes;
+
+	return do_mbind(start, len, &mparam, flags);
 }
 
 SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
@@ -1606,6 +1613,7 @@ SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 				 unsigned long maxnode)
 {
+	struct mempolicy_param param;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1619,7 +1627,12 @@ static long kernel_set_mempolicy(int mode, const unsigned long __user *nmask,
 	if (err)
 		return err;
 
-	return do_set_mempolicy(lmode, mode_flags, &nodes);
+	memset(&param, 0, sizeof(param));
+	param.mode = lmode;
+	param.mode_flags = mode_flags;
+	param.policy_nodes = &nodes;
+
+	return do_set_mempolicy(&param);
 }
 
 SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
@@ -2908,6 +2921,7 @@ static int shared_policy_replace(struct shared_policy *sp, pgoff_t start,
 void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 {
 	int ret;
+	struct mempolicy_param mparam;
 
 	sp->root = RB_ROOT;		/* empty tree == default mempolicy */
 	rwlock_init(&sp->lock);
@@ -2920,8 +2934,12 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 		if (!scratch)
 			goto put_mpol;
 
+		memset(&mparam, 0, sizeof(mparam));
+		mparam.mode = mpol->mode;
+		mparam.mode_flags = mpol->flags;
+		mparam.policy_nodes = &mpol->w.user_nodemask;
 		/* contextualize the tmpfs mount point mempolicy to this file */
-		npol = mpol_new(mpol->mode, mpol->flags, &mpol->w.user_nodemask);
+		npol = mpol_new(&mparam);
 		if (IS_ERR(npol))
 			goto free_scratch; /* no valid nodemask intersection */
 
@@ -3029,6 +3047,7 @@ static inline void __init check_numabalancing_enable(void)
 
 void __init numa_policy_init(void)
 {
+	struct mempolicy_param param;
 	nodemask_t interleave_nodes;
 	unsigned long largest = 0;
 	int nid, prefer = 0;
@@ -3074,7 +3093,11 @@ void __init numa_policy_init(void)
 	if (unlikely(nodes_empty(interleave_nodes)))
 		node_set(prefer, interleave_nodes);
 
-	if (do_set_mempolicy(MPOL_INTERLEAVE, 0, &interleave_nodes))
+	memset(&param, 0, sizeof(param));
+	param.mode = MPOL_INTERLEAVE;
+	param.policy_nodes = &interleave_nodes;
+
+	if (do_set_mempolicy(&param))
 		pr_err("%s: interleaving failed\n", __func__);
 
 	check_numabalancing_enable();
@@ -3083,7 +3106,12 @@ void __init numa_policy_init(void)
 /* Reset policy of current process to default */
 void numa_default_policy(void)
 {
-	do_set_mempolicy(MPOL_DEFAULT, 0, NULL);
+	struct mempolicy_param param;
+
+	memset(&param, 0, sizeof(param));
+	param.mode = MPOL_DEFAULT;
+
+	do_set_mempolicy(&param);
 }
 
 /*
@@ -3113,6 +3141,7 @@ static const char * const policy_modes[] =
  */
 int mpol_parse_str(char *str, struct mempolicy **mpol)
 {
+	struct mempolicy_param mparam;
 	struct mempolicy *new = NULL;
 	unsigned short mode_flags;
 	nodemask_t nodes;
@@ -3199,7 +3228,11 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 			goto out;
 	}
 
-	new = mpol_new(mode, mode_flags, &nodes);
+	memset(&mparam, 0, sizeof(mparam));
+	mparam.mode = mode;
+	mparam.mode_flags = mode_flags;
+	mparam.policy_nodes = &nodes;
+	new = mpol_new(&mparam);
 	if (IS_ERR(new))
 		goto out;
 
-- 
2.39.1


