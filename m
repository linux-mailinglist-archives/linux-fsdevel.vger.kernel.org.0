Return-Path: <linux-fsdevel+bounces-7320-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1A82388C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7D31C24594
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5D32137D;
	Wed,  3 Jan 2024 22:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWIyoQM/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC121375;
	Wed,  3 Jan 2024 22:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so3045456a12.0;
        Wed, 03 Jan 2024 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321811; x=1704926611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTh6xtZGVzP3PdSvCf1bvrsloFYLRrQIaYq034Jk50c=;
        b=mWIyoQM/MmPyjyOnYICtxyFjABf2yl28me2enOwWU3ljEAM+XJnHAlrRdwSZLDKMV1
         k4argNxhpwbhLp/pxdKBhoHazDDKTqf5EDdRBawTG76M6Deb25IfRv7h0INKnhdIEFZV
         Mwa2ust0W5Fi9TT7Za9Blj3BNwqZj+TcIt1VRCMTtVcJYLzXcA7X2vyPmtLqmvFL8+Lz
         RIi89z3In4frG80IJm71hjt9nB7dnYHql6F+J5+cuYTYDdj9adulboj8PLxc9pXtOb0P
         nIKbzy2wBmE3F+QKCEoQ6ymsB+hH8Fc1u5Ucvxh4/bF14upN0wuCfkJbK9qNpro9/djG
         M6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321811; x=1704926611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTh6xtZGVzP3PdSvCf1bvrsloFYLRrQIaYq034Jk50c=;
        b=JYXpsE/t85Z+VKmJMKFhAO+x/bM/cE3WHr1Rp+eMHTCrC6lui+wBygCtox+otK4n6a
         2fIzQgXjUp6D92Nzx6FJUPlsVDYpamniLc4eBJR4OZI1iyIm08+qhyetPnvsdaAwpJaE
         uqM+fxwlGhQGX0nPwbKE3c6nWUPBFFmrUND7TNqlor8iPvwBs3GbePQ7J/Ag84n3Bmfa
         mjbJLpLTR8dX5acnZqkBRcw/L2tVCHOvohOL8aDxs6Ty2lVLbrMwKCXHecYQMIXGFohE
         z1fyWQAssdHp599aaK5tp7fZ1YNWEywSIUxV/JDng8UNw/wMTY5KkulMOsRnRXL/gxCP
         Yf6A==
X-Gm-Message-State: AOJu0Yy/TH0LWI6vGw941C2Wqyuxr+0DqixrNazzRUvEZOOgsnxELIVV
	fXGytkxV9xt+A4WMkgUaGe90dT1nuGDq8jM=
X-Google-Smtp-Source: AGHT+IHj4IdnrLjJKicXSl2ez9+yiEio1lEnIuJiRk/U8wWoKnVHnsybkLZIFe48jEEc9NQFScbm2w==
X-Received: by 2002:a17:902:8b8a:b0:1d0:6ffe:1e6f with SMTP id ay10-20020a1709028b8a00b001d06ffe1e6fmr8043944plb.82.1704321811547;
        Wed, 03 Jan 2024 14:43:31 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:43:31 -0800 (PST)
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
Subject: [PATCH v6 12/12] mm/mempolicy: extend mempolicy2 and mbind2 to support weighted interleave
Date: Wed,  3 Jan 2024 17:42:09 -0500
Message-Id: <20240103224209.2541-13-gregory.price@memverge.com>
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

Extend mempolicy2 and mbind2 to support weighted interleave, and
demonstrate the extensibility of the mpol_param structure.

To support weighted interleave we add interleave weight fields to the
following structures:

Kernel Internal:  (include/linux/mempolicy.h)
struct mempolicy {
	/* task-local weights to apply to weighted interleave */
	u8 weights[MAX_NUMNODES];
}
struct mempolicy_param {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	u8 *il_weights;	/* of size MAX_NUMNODES */
}

UAPI: (/include/uapi/linux/mempolicy.h)
struct mpol_param {
	/* Optional: interleave weights for MPOL_WEIGHTED_INTERLEAVE */
	__u8 *il_weights; /* of size pol_maxnodes */
}

The minimum weight of a node is always 1.  If the user desires 0
allocations on a node, the node should be removed from the nodemask.

If the user does not provide weights (il_weights == NULL), global
weights will be used during allocation. Changes made to global weights
will be reflected in future allocations.

If the user provides weights and a weight is set to 0, the weight for
that node will be initialized to the global value.

If a user provides weights and a node is not set in the node mask,
the weight for that node will be set to the globally defined weight.
This is so a reasonable default value can be expected if the nodemask
changes (e.g. cgroups causes a migration or mems_allowed change).

Local weights are never updated when a global weight is updated.

Examples:

global weights: [4,4,2,2]
Set:  Nodes-0,1,2,3  Weights: NULL
      [global weights] are used.

Set:  Nodes-0,1,2,3  Weights: [1,2,3,4]
      local_weights = [1,2,3,4]

Set:  Nodes-0,2      Weights: [2,0,2,0]
      local_weights = [2,4,1,2]

Basic logic during allocation is as follows:

  weight = pol->wil.weights[node]
  /* if no local weight, use sysfs weight */
  if (!weight)
    weight = iw_table[weight]
  /* if no sysfs weight, use system default */
  if (!weight)
    weight = default_iw_table[weight]

To simplify creations and duplication of mempolicies, the weights are
added as a structure directly within mempolicy. This allows the
existing logic in __mpol_dup to copy the weights without additional
allocations:

if (old == current->mempolicy) {
	task_lock(current);
	*new = *old;
	task_unlock(current);
} else
	*new = *old

Suggested-by: Rakie Kim <rakie.kim@sk.com>
Suggested-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Suggested-by: Honggyu Kim <honggyu.kim@sk.com>
Suggested-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Suggested-by: Huang Ying <ying.huang@intel.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |  12 ++
 include/linux/mempolicy.h                     |   2 +
 include/uapi/linux/mempolicy.h                |   1 +
 mm/mempolicy.c                                | 134 ++++++++++++++++--
 4 files changed, 141 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index 66a778d58899..620b54ff2cef 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -254,11 +254,22 @@ MPOL_WEIGHTED_INTERLEAVE
 	This mode operates the same as MPOL_INTERLEAVE, except that
 	interleaving behavior is executed based on weights set in
 	/sys/kernel/mm/mempolicy/weighted_interleave/
+	when configured to utilize global weights, or based on task-local
+	weights configured with set_mempolicy2(2) or mbind2(2).
 
 	Weighted interleave allocates pages on nodes according to a
 	weight.  For example if nodes [0,1] are weighted [5,2], 5 pages
 	will be allocated on node0 for every 2 pages allocated on node1.
 
+	When utilizing task-local weights, if node's is not set in the
+	nodemask, or its weight was set to 0, the local weight will be
+	set to the system default.  Updates to system default weights
+	will not be refleted in local weights.
+
+	The minimum weight for a node set in the policy nodemask is
+	always 1. If no allocations on a node, the node should be
+	removed from the nodemask.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
@@ -514,6 +525,7 @@ Extended Mempolicy Arguments::
 		__s32 home_node;	 /* mbind2: set home node */
 		__u64 pol_maxnodes;
 		__aligned_u64 pol_nodes; /* nodemask pointer */
+		__aligned_u64 il_weights;  /* u8 buf of size pol_maxnodes */
 	};
 
 The extended mempolicy argument structure is defined to allow the mempolicy
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index e6795e2d0cc2..9854790a9aac 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -58,6 +58,7 @@ struct mempolicy {
 	/* Weighted interleave settings */
 	struct {
 		u8 cur_weight;
+		u8 weights[MAX_NUMNODES];
 		u8 scratch_weights[MAX_NUMNODES]; /* Used to avoid allocations */
 	} wil;
 };
@@ -71,6 +72,7 @@ struct mempolicy_param {
 	unsigned short mode_flags;	/* policy mode flags */
 	int home_node;			/* mbind: use MPOL_MF_HOME_NODE */
 	nodemask_t *policy_nodes;	/* get/set/mbind */
+	u8 *il_weights;			/* for mode MPOL_WEIGHTED_INTERLEAVE */
 };
 
 /*
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 7c7c384479fc..06e0fc2bb29b 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -34,6 +34,7 @@ struct mpol_param {
 	__u16 pol_maxnodes;
 	__u8 resv[6];
 	__aligned_u64 pol_nodes;
+	__aligned_u64 il_weights; /* size: pol_maxnodes * sizeof(__u8) */
 };
 
 /* Flags for set_mempolicy */
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 53301e173c90..78e7614e0cd4 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -286,6 +286,7 @@ static struct mempolicy *mpol_new(struct mempolicy_param *param)
 	unsigned short mode = param->mode;
 	unsigned short flags = param->mode_flags;
 	nodemask_t *nodes = param->policy_nodes;
+	int node;
 
 	if (mode == MPOL_DEFAULT) {
 		if (nodes && !nodes_empty(*nodes))
@@ -323,6 +324,23 @@ static struct mempolicy *mpol_new(struct mempolicy_param *param)
 	policy->flags = flags;
 	policy->home_node = param->home_node;
 	policy->wil.cur_weight = 0;
+	memset(policy->wil.weights, 0, MAX_NUMNODES);
+
+	/* If user provides weights, ensure all weights are set to something */
+	if (policy->mode == MPOL_WEIGHTED_INTERLEAVE && param->il_weights) {
+		for (node = 0; node < MAX_NUMNODES; node++) {
+			u8 weight = 0;
+
+			if (node_isset(node, *nodes))
+				weight = param->il_weights[node];
+			/* If a user sets a weight to 0, use global default */
+			if (!weight)
+				weight = iw_table[node];
+			if (!weight)
+				weight = default_iw_table[node];
+			policy->wil.weights[node] = weight;
+		}
+	}
 
 	return policy;
 }
@@ -952,6 +970,26 @@ static void do_get_mempolicy_nodemask(struct mempolicy *pol, nodemask_t *nmask)
 	}
 }
 
+static void do_get_mempolicy_il_weights(struct mempolicy *pol,
+					u8 weights[MAX_NUMNODES])
+{
+	int i = 0;
+
+	if (pol->mode != MPOL_WEIGHTED_INTERLEAVE) {
+		memset(weights, 0, MAX_NUMNODES);
+		return;
+	}
+	for (i = 0; i < MAX_NUMNODES; i++) {
+		u8 weight = pol->wil.weights[i];
+
+		if (!weight)
+			weight = iw_table[i];
+		if (!weight)
+			weight = default_iw_table[i];
+		weights[i] = weight;
+	}
+}
+
 /* Retrieve NUMA policy for a VMA assocated with a given address  */
 static long do_get_vma_mempolicy(unsigned long addr, int *addr_node,
 				 struct mempolicy_param *param)
@@ -985,6 +1023,9 @@ static long do_get_vma_mempolicy(unsigned long addr, int *addr_node,
 	if (param->policy_nodes)
 		do_get_mempolicy_nodemask(pol, param->policy_nodes);
 
+	if (param->il_weights)
+		do_get_mempolicy_il_weights(pol, param->il_weights);
+
 	if (pol != &default_policy) {
 		mpol_put(pol);
 		mpol_cond_put(pol);
@@ -1012,6 +1053,9 @@ static long do_get_task_mempolicy(struct mempolicy_param *param, int *pol_node)
 	if (param->policy_nodes)
 		do_get_mempolicy_nodemask(pol, param->policy_nodes);
 
+	if (param->il_weights)
+		do_get_mempolicy_il_weights(pol, param->il_weights);
+
 	return 0;
 }
 
@@ -1620,6 +1664,8 @@ SYSCALL_DEFINE5(mbind2, unsigned long, start, unsigned long, len,
 	struct mempolicy_param mparam;
 	nodemask_t policy_nodes;
 	unsigned long __user *nodes_ptr;
+	u8 *weights = NULL;
+	u8 __user *weights_ptr;
 	int err;
 
 	if (!start || !len)
@@ -1652,7 +1698,27 @@ SYSCALL_DEFINE5(mbind2, unsigned long, start, unsigned long, len,
 		return err;
 	mparam.policy_nodes = &policy_nodes;
 
-	return do_mbind(untagged_addr(start), len, &mparam, flags);
+	if (kparam.mode == MPOL_WEIGHTED_INTERLEAVE) {
+		weights_ptr = u64_to_user_ptr(kparam.il_weights);
+		if (weights_ptr) {
+			weights = kzalloc(MAX_NUMNODES,
+					  GFP_KERNEL | __GFP_NORETRY);
+			if (!weights)
+				return -ENOMEM;
+			err = copy_struct_from_user(weights,
+						    MAX_NUMNODES,
+						    weights_ptr,
+						    kparam.pol_maxnodes);
+			if (err)
+				goto leave_weights;
+		}
+	}
+	mparam.il_weights = weights;
+
+	err = do_mbind(untagged_addr(start), len, &mparam, flags);
+leave_weights:
+	kfree(weights);
+	return err;
 }
 
 /* Set the process memory policy */
@@ -1696,6 +1762,8 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_param __user *, uparam,
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	u8 *weights = NULL;
+	u8 __user *weights_ptr;
 
 	if (flags)
 		return -EINVAL;
@@ -1721,7 +1789,24 @@ SYSCALL_DEFINE3(set_mempolicy2, struct mpol_param __user *, uparam,
 	} else
 		mparam.policy_nodes = NULL;
 
-	return do_set_mempolicy(&mparam);
+	if (kparam.mode == MPOL_WEIGHTED_INTERLEAVE && kparam.il_weights) {
+		weights = kzalloc(MAX_NUMNODES, GFP_KERNEL | __GFP_NORETRY);
+		if (!weights)
+			return -ENOMEM;
+		weights_ptr = u64_to_user_ptr(kparam.il_weights);
+		err = copy_struct_from_user(weights,
+					    MAX_NUMNODES,
+					    weights_ptr,
+					    kparam.pol_maxnodes);
+		if (err)
+			goto leave_weights;
+	}
+	mparam.il_weights = weights;
+
+	err = do_set_mempolicy(&mparam);
+leave_weights:
+	kfree(weights);
+	return err;
 }
 
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
@@ -1924,6 +2009,8 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_param __user *, uparam, size_t, usiz
 	int err;
 	nodemask_t policy_nodemask;
 	unsigned long __user *nodes_ptr;
+	u8 __user *weights_ptr;
+	u8 *weights = NULL;
 
 	if (flags & ~(MPOL_F_ADDR))
 		return -EINVAL;
@@ -1935,6 +2022,13 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_param __user *, uparam, size_t, usiz
 	if (err)
 		return -EINVAL;
 
+	if (kparam.il_weights) {
+		weights = kzalloc(MAX_NUMNODES, GFP_KERNEL | __GFP_NORETRY);
+		if (!weights)
+			return -ENOMEM;
+	}
+	mparam.il_weights = weights;
+
 	mparam.policy_nodes = kparam.pol_nodes ? &policy_nodemask : NULL;
 	if (flags & MPOL_F_ADDR)
 		err = do_get_vma_mempolicy(untagged_addr(addr), NULL, &mparam);
@@ -1942,7 +2036,7 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_param __user *, uparam, size_t, usiz
 		err = do_get_task_mempolicy(&mparam, NULL);
 
 	if (err)
-		return err;
+		goto leave_weights;
 
 	kparam.mode = mparam.mode;
 	kparam.mode_flags = mparam.mode_flags;
@@ -1952,10 +2046,21 @@ SYSCALL_DEFINE4(get_mempolicy2, struct mpol_param __user *, uparam, size_t, usiz
 		err = copy_nodes_to_user(nodes_ptr, kparam.pol_maxnodes,
 					 mparam.policy_nodes);
 		if (err)
-			return err;
+			goto leave_weights;
+	}
+
+	if (kparam.mode == MPOL_WEIGHTED_INTERLEAVE && kparam.il_weights) {
+		weights_ptr = u64_to_user_ptr(kparam.il_weights);
+		if (copy_to_user(weights_ptr, weights, kparam.pol_maxnodes)) {
+			err = -EFAULT;
+			goto leave_weights;
+		}
 	}
 
-	return copy_to_user(uparam, &kparam, usize) ? -EFAULT : 0;
+	err = copy_to_user(uparam, &kparam, usize) ? -EFAULT : 0;
+leave_weights:
+	kfree(weights);
+	return err;
 }
 
 bool vma_migratable(struct vm_area_struct *vma)
@@ -2077,8 +2182,10 @@ static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
 		return next;
 
 	if (!policy->wil.cur_weight) {
-		u8 next_weight = iw_table[next];
+		u8 next_weight = policy->wil.weights[next];
 
+		if (!next_weight)
+			next_weight = iw_table[next];
 		if (!next_weight)
 			next_weight = default_iw_table[next];
 		policy->wil.cur_weight = next_weight;
@@ -2175,8 +2282,10 @@ static unsigned int read_once_interleave_weights(struct mempolicy *pol,
 	/* Similar issue to read_once_policy_nodemask */
 	barrier();
 	for_each_node_mask(nid, *mask) {
-		u8 weight = iw_table[nid];
+		u8 weight = pol->wil.weights[nid];
 
+		if (!weight)
+			weight = iw_table[nid];
 		if (!weight)
 			weight = default_iw_table[nid];
 		weight_total += weight;
@@ -3115,21 +3224,28 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 	if (mpol) {
 		struct sp_node *sn;
 		struct mempolicy *npol;
+		u8 *weights = NULL;
 		NODEMASK_SCRATCH(scratch);
 
 		if (!scratch)
 			goto put_mpol;
 
+		weights = kzalloc(MAX_NUMNODES, GFP_KERNEL | __GFP_NORETRY);
+		if (!weights)
+			goto free_scratch;
+		memcpy(weights, mpol->wil.weights, sizeof(weights));
+
 		memset(&mparam, 0, sizeof(mparam));
 		mparam.mode = mpol->mode;
 		mparam.mode_flags = mpol->flags;
 		mparam.policy_nodes = &mpol->w.user_nodemask;
 		mparam.home_node = NUMA_NO_NODE;
+		mparam.il_weights = weights;
 
 		/* contextualize the tmpfs mount point mempolicy to this file */
 		npol = mpol_new(&mparam);
 		if (IS_ERR(npol))
-			goto free_scratch; /* no valid nodemask intersection */
+			goto free_weights; /* no valid nodemask intersection */
 
 		task_lock(current);
 		ret = mpol_set_nodemask(npol, &mpol->w.user_nodemask, scratch);
@@ -3143,6 +3259,8 @@ void mpol_shared_policy_init(struct shared_policy *sp, struct mempolicy *mpol)
 			sp_insert(sp, sn);
 put_npol:
 		mpol_put(npol);	/* drop initial ref on file's npol */
+free_weights:
+		kfree(weights);
 free_scratch:
 		NODEMASK_SCRATCH_FREE(scratch);
 put_mpol:
-- 
2.39.1


