Return-Path: <linux-fsdevel+bounces-6419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 319E2817B3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 20:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF118284CB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Dec 2023 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F300F74E3C;
	Mon, 18 Dec 2023 19:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpttFZQD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9476E74E2F;
	Mon, 18 Dec 2023 19:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1d3b4b803f4so7589415ad.1;
        Mon, 18 Dec 2023 11:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702928823; x=1703533623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHTqs7dpBmEn4KdO/6oNdwNsZG5gzWbikrQ+JB0FZfM=;
        b=cpttFZQDEdMkB73ib0tsvz43Tgzqjz75F7wOu6cgrV+vMbl02jZ/dD/hJEHZ1QIg8v
         BEWERgDwcmJfqMRDgAkcW0w0KWrvW0xYdWTUooBRXhQt9Wq585+dZBZlElMkBwFAfKV2
         6/ryNGPDyP5EMVx7nNgdGjFQCRWMWstFAoviE7FFs96gJ+6H2Dht4jNwPt6+1BJ+X5wu
         dqpF+JRDYjC/FRcd2qGJYd5/UCnDlng0R9UjxvH69AXfnJsKyRRaGo2eLi2AFdA+O316
         BiPPJvfJidMrhY4umo6wEQ3qeDURmN9v6f741iYOYsgGqaQsBdTRQGgz53gIYQLU6+dZ
         6iWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702928823; x=1703533623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHTqs7dpBmEn4KdO/6oNdwNsZG5gzWbikrQ+JB0FZfM=;
        b=Tu/sY0yOPIgKoR5VyVnDirsgLsX2HpJgnKLQeoPebCSdKSVXKS2tbfdislrpWnw/T5
         Hf//rz/niuUjPEiYcW0jsYkcTIdyRXojDf0Kwphu4DF1O1fuMHEd/O34sq8989LzTaJn
         nflahOjChH7pi/+CaACkw02evO3YHbzqi/gT7riduPntuYsNGUxQZg9pGo+rcbBKILDB
         xYnEdZtLOaL4122g2O6Ono+FPXe7U5ZNSfu26iGpY1yNgRqUhKKz6ZkrD4zlrJy9eCVZ
         VIoIad+l7y2Fl/TIKRJi3kxuaKJnHcLZYeR6YGs/qhSRWDKs8T48L24Upg0n3D2OhI9e
         jXEg==
X-Gm-Message-State: AOJu0YwyXxkB3Sl2O+j4yyarZ1dQOWVyQjGr+Pjl+DFaHMHg4EEdeI7t
	8DbzG/TUubVmeZjYw3wMDw==
X-Google-Smtp-Source: AGHT+IEuiCIzHZoSaKljz8Xu8gZjlhUFEwbhr2C8Xz88VdeRlmyWhChyIM2RKyajYncVtVwvuI1x7g==
X-Received: by 2002:a17:902:db0d:b0:1d3:d9c2:224a with SMTP id m13-20020a170902db0d00b001d3d9c2224amr276918plx.47.1702928822837;
        Mon, 18 Dec 2023 11:47:02 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 11-20020a170902c20b00b001ce664c05b0sm19456335pll.33.2023.12.18.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 11:47:02 -0800 (PST)
From: Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To: linux-mm@kvack.org
Cc: linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
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
Subject: [PATCH v4 05/11] mm/mempolicy: refactor kernel_get_mempolicy for code re-use
Date: Mon, 18 Dec 2023 14:46:25 -0500
Message-Id: <20231218194631.21667-6-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231218194631.21667-1-gregory.price@memverge.com>
References: <20231218194631.21667-1-gregory.price@memverge.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pull operation flag checking from inside do_get_mempolicy out
to kernel_get_mempolicy.  This allows us to flatten the
internal code, and break it into separate functions for future
syscalls (get_mempolicy2, process_get_mempolicy) to re-use the
code, even after additional extensions are made.

The primary change is that the flag is treated as the multiplexer
that it actually is.  For get_mempolicy, the flags represents 3
different primary operations:

if (flags & MPOL_F_MEMS_ALLOWED)
	return task->mems_allowed
else if (flags & MPOL_F_ADDR)
	return vma mempolicy information
else
	return task mempolicy information

Plus the behavior modifying flag:

if (flags & MPOL_F_NODE)
	change the return value of (int __user *policy)
	based on whether MPOL_F_ADDR was set.

The original behavior of get_mempolicy is retained, but we utilize
the new mempolicy_args structure to pass the operations down the
stack.  This will allow us to extend the internal functions without
affecting the legacy behavior of get_mempolicy.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 mm/mempolicy.c | 245 +++++++++++++++++++++++++++++++------------------
 1 file changed, 155 insertions(+), 90 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 42037b7ff6d6..4426365a353d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -895,106 +895,111 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 	return ret;
 }
 
-/* Retrieve NUMA policy */
-static long do_get_mempolicy(int *policy, nodemask_t *nmask,
-			     unsigned long addr, unsigned long flags)
+/* Retrieve the mems_allowed for current task */
+static inline long do_get_mems_allowed(nodemask_t *nmask)
 {
-	int err;
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma = NULL;
-	struct mempolicy *pol = current->mempolicy, *pol_refcount = NULL;
+	task_lock(current);
+	*nmask  = cpuset_current_mems_allowed;
+	task_unlock(current);
+	return 0;
+}
 
-	if (flags &
-		~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR|MPOL_F_MEMS_ALLOWED))
-		return -EINVAL;
+/* If the policy has additional node information to retrieve, return it */
+static long do_get_policy_node(struct mempolicy *pol)
+{
+	/*
+	 * For MPOL_INTERLEAVE, the extended node information is the next
+	 * node that will be selected for interleave. For weighted interleave
+	 * we return the next node based on the current weight.
+	 */
+	if (pol == current->mempolicy && pol->mode == MPOL_INTERLEAVE)
+		return next_node_in(current->il_prev, pol->nodes);
 
-	if (flags & MPOL_F_MEMS_ALLOWED) {
-		if (flags & (MPOL_F_NODE|MPOL_F_ADDR))
-			return -EINVAL;
-		*policy = 0;	/* just so it's initialized */
+	if (pol == current->mempolicy &&
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
+		if (pol->wil.cur_weight)
+			return current->il_prev;
+		else
+			return next_node_in(current->il_prev, pol->nodes);
+	}
+	return -EINVAL;
+}
+
+/* Handle user_nodemask condition when fetching nodemask for userspace */
+static void do_get_mempolicy_nodemask(struct mempolicy *pol, nodemask_t *nmask)
+{
+	if (mpol_store_user_nodemask(pol)) {
+		*nmask = pol->w.user_nodemask;
+	} else {
 		task_lock(current);
-		*nmask  = cpuset_current_mems_allowed;
+		get_policy_nodemask(pol, nmask);
 		task_unlock(current);
-		return 0;
 	}
+}
 
-	if (flags & MPOL_F_ADDR) {
-		pgoff_t ilx;		/* ignored here */
-		/*
-		 * Do NOT fall back to task policy if the
-		 * vma/shared policy at addr is NULL.  We
-		 * want to return MPOL_DEFAULT in this case.
-		 */
-		mmap_read_lock(mm);
-		vma = vma_lookup(mm, addr);
-		if (!vma) {
-			mmap_read_unlock(mm);
-			return -EFAULT;
-		}
-		pol = __get_vma_policy(vma, addr, &ilx);
-	} else if (addr)
-		return -EINVAL;
+/* Retrieve NUMA policy for a VMA assocated with a given address  */
+static long do_get_vma_mempolicy(unsigned long addr, int *addr_node,
+				 struct mempolicy_args *args)
+{
+	pgoff_t ilx;
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma = NULL;
+	struct mempolicy *pol = NULL;
 
+	mmap_read_lock(mm);
+	vma = vma_lookup(mm, addr);
+	if (!vma) {
+		mmap_read_unlock(mm);
+		return -EFAULT;
+	}
+	pol = __get_vma_policy(vma, addr, &ilx);
 	if (!pol)
-		pol = &default_policy;	/* indicates default behavior */
+		pol = &default_policy;
+	else
+		mpol_get(pol);
+	mmap_read_unlock(mm);
 
-	if (flags & MPOL_F_NODE) {
-		if (flags & MPOL_F_ADDR) {
-			/*
-			 * Take a refcount on the mpol, because we are about to
-			 * drop the mmap_lock, after which only "pol" remains
-			 * valid, "vma" is stale.
-			 */
-			pol_refcount = pol;
-			vma = NULL;
-			mpol_get(pol);
-			mmap_read_unlock(mm);
-			err = lookup_node(mm, addr);
-			if (err < 0)
-				goto out;
-			*policy = err;
-		} else if (pol == current->mempolicy &&
-				pol->mode == MPOL_INTERLEAVE) {
-			*policy = next_node_in(current->il_prev, pol->nodes);
-		} else if (pol == current->mempolicy &&
-				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
-			if (pol->wil.cur_weight)
-				*policy = current->il_prev;
-			else
-				*policy = next_node_in(current->il_prev,
-						       pol->nodes);
-		} else {
-			err = -EINVAL;
-			goto out;
-		}
-	} else {
-		*policy = pol == &default_policy ? MPOL_DEFAULT :
-						pol->mode;
-		/*
-		 * Internal mempolicy flags must be masked off before exposing
-		 * the policy to userspace.
-		 */
-		*policy |= (pol->flags & MPOL_MODE_FLAGS);
-	}
+	/* Fetch the node for the given address */
+	if (addr_node)
+		*addr_node = lookup_node(mm, addr);
 
-	err = 0;
-	if (nmask) {
-		if (mpol_store_user_nodemask(pol)) {
-			*nmask = pol->w.user_nodemask;
-		} else {
-			task_lock(current);
-			get_policy_nodemask(pol, nmask);
-			task_unlock(current);
-		}
+	args->mode = pol == &default_policy ? MPOL_DEFAULT : pol->mode;
+	args->mode_flags = (pol->flags & MPOL_MODE_FLAGS);
+	args->home_node = pol->home_node;
+
+	/* If this policy has extra node info, fetch that */
+	args->policy_node = do_get_policy_node(pol);
+
+	if (args->policy_nodes)
+		do_get_mempolicy_nodemask(pol, args->policy_nodes);
+
+	if (pol != &default_policy) {
+		mpol_put(pol);
+		mpol_cond_put(pol);
 	}
 
- out:
-	mpol_cond_put(pol);
-	if (vma)
-		mmap_read_unlock(mm);
-	if (pol_refcount)
-		mpol_put(pol_refcount);
-	return err;
+	return 0;
+}
+
+/* Retrieve NUMA policy for the current task */
+static long do_get_task_mempolicy(struct mempolicy_args *args)
+{
+	struct mempolicy *pol = current->mempolicy;
+
+	if (!pol)
+		pol = &default_policy;	/* indicates default behavior */
+
+	args->mode = pol == &default_policy ? MPOL_DEFAULT : pol->mode;
+	/* Internal flags must be masked off before exposing to userspace */
+	args->mode_flags = (pol->flags & MPOL_MODE_FLAGS);
+	args->home_node = NUMA_NO_NODE;
+
+	args->policy_node = do_get_policy_node(pol);
+
+	if (args->policy_nodes)
+		do_get_mempolicy_nodemask(pol, args->policy_nodes);
+
+	return 0;
 }
 
 #ifdef CONFIG_MIGRATION
@@ -1731,16 +1736,76 @@ static int kernel_get_mempolicy(int __user *policy,
 				unsigned long addr,
 				unsigned long flags)
 {
+	struct mempolicy_args args;
 	int err;
-	int pval;
+	int address_node = NUMA_NO_NODE;
+	int pval = 0;
 	nodemask_t nodes;
 
 	if (nmask != NULL && maxnode < nr_node_ids)
 		return -EINVAL;
 
-	addr = untagged_addr(addr);
+	if (flags &
+		~(unsigned long)(MPOL_F_NODE|MPOL_F_ADDR|MPOL_F_MEMS_ALLOWED))
+		return -EINVAL;
 
-	err = do_get_mempolicy(&pval, &nodes, addr, flags);
+	/* Ensure any data that may be copied to userland is initialized */
+	memset(&args, 0, sizeof(args));
+	args.policy_nodes = &nodes;
+
+	/*
+	 * set_mempolicy was originally multiplexed based on 3 flags:
+	 *   MPOL_F_MEMS_ALLOWED:  fetch task->mems_allowed
+	 *   MPOL_F_ADDR        :  operate on vma->mempolicy
+	 *   MPOL_F_NODE        :  change return value of *policy
+	 *
+	 * Split this behavior out here, rather than internal functions,
+	 * so that the internal functions can be re-used by future
+	 * get_mempolicy2 interfaces and the arg structure made extensible
+	 */
+	if (flags & MPOL_F_MEMS_ALLOWED) {
+		if (flags & (MPOL_F_NODE|MPOL_F_ADDR))
+			return -EINVAL;
+		pval = 0;	/* just so it's initialized */
+		err = do_get_mems_allowed(&nodes);
+	} else if (flags & MPOL_F_ADDR) {
+		/* If F_ADDR, we operation on a vma policy (or default) */
+		err = do_get_vma_mempolicy(untagged_addr(addr),
+					   &address_node, &args);
+		if (err)
+			return err;
+		 /* if (F_ADDR | F_NODE), *pval is the address' node */
+		if (flags & MPOL_F_NODE) {
+			/* if we failed to fetch, that's likely an EFAULT */
+			if (address_node < 0)
+				return address_node;
+			pval = address_node;
+		} else
+			pval = args.mode | args.mode_flags;
+	} else {
+		 /* if not F_ADDR and addr != null, EINVAL */
+		if (addr)
+			return -EINVAL;
+
+		err = do_get_task_mempolicy(&args);
+		if (err)
+			return err;
+		/*
+		 * if F_NODE was set and mode was MPOL_INTERLEAVE
+		 * *pval is equal to next interleave node.
+		 *
+		 * if args.policy_node < 0, this means the mode did
+		 * not have a policy.  This presently emulates the
+		 * original behavior of (F_NODE) & (!MPOL_INTERLEAVE)
+		 * producing -EINVAL
+		 */
+		if (flags & MPOL_F_NODE) {
+			if (args.policy_node < 0)
+				return args.policy_node;
+			pval = args.policy_node;
+		} else
+			pval = args.mode | args.mode_flags;
+	}
 
 	if (err)
 		return err;
-- 
2.39.1


