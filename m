Return-Path: <linux-fsdevel+bounces-7311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DEE82385D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 23:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F2D1C24596
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 22:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8EE200D8;
	Wed,  3 Jan 2024 22:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l124v6Rl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70CD200C7;
	Wed,  3 Jan 2024 22:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1d4414ec9c7so28437025ad.0;
        Wed, 03 Jan 2024 14:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704321769; x=1704926569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REqFU5ZxtHyflU6mIkcuYZVFroNR18NafHasOjXOpiU=;
        b=l124v6RliIzTkkjlHCebixGp/qdtfy9QCmxC76ZJUeQxKqjUxtQQEqdtYPalZtG+cs
         tUdcFRRSyHDa9YW4ntTRIAXCLpgfPxAb56UaZvxuFXLEhMIxiwi43lPJA/5BJw+NpvEy
         WomEOWQvVPSv7Jx23y5iUCHDpLm/z4u1X8c9u8Nk0WYs3NhXtj1iip4JLb/1lhCOSYaS
         s8bDiSDjjsPV/T1hgvj0J5BCXNhJsVyMQv4QRB8cbhbhr8ijJloaIEYg+xNbGyqPwwnG
         tDZa/YPq2KZdi5PcSwaKRQtWE0pyK925YJ0bQJyb4EJcRxss2FnALcOfZuy0HyKyLJCS
         G9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704321769; x=1704926569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REqFU5ZxtHyflU6mIkcuYZVFroNR18NafHasOjXOpiU=;
        b=ItpP0IGZKmMs9W5ePjxrMeV9pJPPvKrl+B5W8v46AzwrIWlFWudCXNSVM3dCE/f7S1
         CKkMS90VUYEHA8jyPpflzx38mFHGMSCF2SRdeU4IZ2cfPks+/vpIdXBMIRXrYg7cXdVn
         BrCSwALufeSCRj0Wwm5pez4XbJ8iDy+YRaytJWgFG1hOtraw/dSh3BPEsqAMlwj6vPjB
         vYI6qx9RSkTLJESOhUlJ1klSPkkLsnJomuvHjujXHQjxyYIgmi+mt4OMBf1/+SUkOM4Y
         7wSCdZDH57FfqeNFAR40L9jAqIXxA8+cWP+a23eRnP7QR0S4w2+dYb0MgTjCg8q+iUP2
         fb4Q==
X-Gm-Message-State: AOJu0YzXLZVYEW8+21tRGtQAwkwMrQjXxJYarEPH5gMa3Q7xleeUhHhY
	YL0HxTTT1nkhd7bxXVct0A==
X-Google-Smtp-Source: AGHT+IEch49DwGawQBn0E3k8RD3KwVjuH9SY2ca7uybqAfQ2DMlZPCK55U6uetT1xyJ87hwmWjjubg==
X-Received: by 2002:a17:902:ce84:b0:1d4:5c6c:2089 with SMTP id f4-20020a170902ce8400b001d45c6c2089mr9352928plg.14.1704321769076;
        Wed, 03 Jan 2024 14:42:49 -0800 (PST)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id g1-20020a170902fe0100b001d36df58ba2sm24269426plj.308.2024.01.03.14.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 14:42:48 -0800 (PST)
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
	seungjun.ha@samsung.com,
	Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Subject: [PATCH v6 03/12] mm/mempolicy: introduce MPOL_WEIGHTED_INTERLEAVE for weighted interleaving
Date: Wed,  3 Jan 2024 17:42:00 -0500
Message-Id: <20240103224209.2541-4-gregory.price@memverge.com>
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

When a system has multiple NUMA nodes and it becomes bandwidth hungry,
the current MPOL_INTERLEAVE could be an wise option.

However, if those NUMA nodes consist of different types of memory such
as having local DRAM and CXL memory together, the current round-robin
based interleaving policy doesn't maximize the overall bandwidth because
of their different bandwidth characteristics.

Instead, the interleaving can be more efficient when the allocation
policy follows each NUMA nodes' bandwidth weight rather than having 1:1
round-robin allocation.

This patch introduces a new memory policy, MPOL_WEIGHTED_INTERLEAVE, which
enables weighted interleaving between NUMA nodes.  Weighted interleave
allows for a proportional distribution of memory across multiple numa
nodes, preferablly apportioned to match the bandwidth capacity of each
node from the perspective of the accessing node.

For example, if a system has 1 CPU node (0), and 2 memory nodes (0,1),
with a relative bandwidth of (100GB/s, 50GB/s) respectively, the
appropriate weight distribution is (2:1).

Weights will be acquired from the global weight matrix exposed by the
sysfs extension: /sys/kernel/mm/mempolicy/weighted_interleave/ or
from the `default_iw_table`, which will be extended to allow defaults
to be registered by core/cxl drivers in the future.

The policy will then allocate the number of pages according to the
set weights.  For example, if the weights are (2,1), then 2 pages
will be allocated on node0 for every 1 page allocated on node1.

The new flag MPOL_WEIGHTED_INTERLEAVE can be used in set_mempolicy(2)
and mbind(2).

There are 3 integration points:

weighted_interleave_nodes:
    Counts the number of allocations as they occur, and applies the
    weight for the current node.  When the weight reaches 0, switch
    to the next node. Applied by `mempolicy_slab_node()` and
    `policy_nodemask()`

weighted_interleave_nid:
    Gets the total weight of the nodemask as well as each individual
    node weight, then calculates the node based on the given index.
    Applied by `policy_nodemask()` and `mpol_misplaced()`

bulk_array_weighted_interleave:
    Gets the total weight of the nodemask as well as each individual
    node weight, then calculates the number of "interleave rounds" as
    well as any delta ("partial round").  Calculates the number of
    pages for each node and allocates them.

    If a node was scheduled for interleave via interleave_nodes, the
    current weight (pol->cur_weight) will be allocated first, before
    the remaining bulk calculation is done. This simplifies the
    calculation at the cost of an additional allocation call.

One piece of complexity is the interaction between a recent refactor
which split the logic to acquire the "ilx" (interleave index) of an
allocation and the actually application of the interleave.  The
calculation of the `interleave index` is done by `get_vma_policy()`,
while the actual selection of the node will be later appliex by the
relevant weighted_interleave function.

Suggested-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
Signed-off-by: Gregory Price <gregory.price@memverge.com>
Co-developed-by: Rakie Kim <rakie.kim@sk.com>
Signed-off-by: Rakie Kim <rakie.kim@sk.com>
Co-developed-by: Honggyu Kim <honggyu.kim@sk.com>
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Co-developed-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Signed-off-by: Hyeongtak Ji <hyeongtak.ji@sk.com>
Co-developed-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Signed-off-by: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>
Co-developed-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
Signed-off-by: Ravi Jonnalagadda <ravis.opensrc@micron.com>
---
 .../admin-guide/mm/numa_memory_policy.rst     |   9 +
 include/linux/mempolicy.h                     |   6 +
 include/uapi/linux/mempolicy.h                |   1 +
 mm/mempolicy.c                                | 198 +++++++++++++++++-
 4 files changed, 211 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/mm/numa_memory_policy.rst b/Documentation/admin-guide/mm/numa_memory_policy.rst
index eca38fa81e0f..a70f20ce1ffb 100644
--- a/Documentation/admin-guide/mm/numa_memory_policy.rst
+++ b/Documentation/admin-guide/mm/numa_memory_policy.rst
@@ -250,6 +250,15 @@ MPOL_PREFERRED_MANY
 	can fall back to all existing numa nodes. This is effectively
 	MPOL_PREFERRED allowed for a mask rather than a single node.
 
+MPOL_WEIGHTED_INTERLEAVE
+	This mode operates the same as MPOL_INTERLEAVE, except that
+	interleaving behavior is executed based on weights set in
+	/sys/kernel/mm/mempolicy/weighted_interleave/
+
+	Weighted interleave allocates pages on nodes according to a
+	weight.  For example if nodes [0,1] are weighted [5,2], 5 pages
+	will be allocated on node0 for every 2 pages allocated on node1.
+
 NUMA memory policy supports the following optional mode flags:
 
 MPOL_F_STATIC_NODES
diff --git a/include/linux/mempolicy.h b/include/linux/mempolicy.h
index 931b118336f4..fae903b1d3de 100644
--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -54,6 +54,12 @@ struct mempolicy {
 		nodemask_t cpuset_mems_allowed;	/* relative to these nodes */
 		nodemask_t user_nodemask;	/* nodemask passed by user */
 	} w;
+
+	/* Weighted interleave settings */
+	struct {
+		u8 cur_weight;
+		u8 scratch_weights[MAX_NUMNODES]; /* Used to avoid allocations */
+	} wil;
 };
 
 /*
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index a8963f7ef4c2..1f9bb10d1a47 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -23,6 +23,7 @@ enum {
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
+	MPOL_WEIGHTED_INTERLEAVE,
 	MPOL_MAX,	/* always last member of enum */
 };
 
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 6cdb00acb86b..46e6b6f36a10 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -320,6 +320,7 @@ static struct mempolicy *mpol_new(unsigned short mode, unsigned short flags,
 	policy->mode = mode;
 	policy->flags = flags;
 	policy->home_node = NUMA_NO_NODE;
+	policy->wil.cur_weight = 0;
 
 	return policy;
 }
@@ -432,6 +433,10 @@ static const struct mempolicy_operations mpol_ops[MPOL_MAX] = {
 		.create = mpol_new_nodemask,
 		.rebind = mpol_rebind_preferred,
 	},
+	[MPOL_WEIGHTED_INTERLEAVE] = {
+		.create = mpol_new_nodemask,
+		.rebind = mpol_rebind_nodemask,
+	},
 };
 
 static bool migrate_folio_add(struct folio *folio, struct list_head *foliolist,
@@ -853,7 +858,8 @@ static long do_set_mempolicy(unsigned short mode, unsigned short flags,
 
 	old = current->mempolicy;
 	current->mempolicy = new;
-	if (new && new->mode == MPOL_INTERLEAVE)
+	if (new && (new->mode == MPOL_INTERLEAVE ||
+		    new->mode == MPOL_WEIGHTED_INTERLEAVE))
 		current->il_prev = MAX_NUMNODES-1;
 	task_unlock(current);
 	mpol_put(old);
@@ -879,6 +885,7 @@ static void get_policy_nodemask(struct mempolicy *pol, nodemask_t *nodes)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*nodes = pol->nodes;
 		break;
 	case MPOL_LOCAL:
@@ -963,6 +970,13 @@ static long do_get_mempolicy(int *policy, nodemask_t *nmask,
 		} else if (pol == current->mempolicy &&
 				pol->mode == MPOL_INTERLEAVE) {
 			*policy = next_node_in(current->il_prev, pol->nodes);
+		} else if (pol == current->mempolicy &&
+				(pol->mode == MPOL_WEIGHTED_INTERLEAVE)) {
+			if (pol->wil.cur_weight)
+				*policy = current->il_prev;
+			else
+				*policy = next_node_in(current->il_prev,
+						       pol->nodes);
 		} else {
 			err = -EINVAL;
 			goto out;
@@ -1792,7 +1806,8 @@ struct mempolicy *get_vma_policy(struct vm_area_struct *vma,
 	pol = __get_vma_policy(vma, addr, ilx);
 	if (!pol)
 		pol = get_task_policy(current);
-	if (pol->mode == MPOL_INTERLEAVE) {
+	if (pol->mode == MPOL_INTERLEAVE ||
+	    pol->mode == MPOL_WEIGHTED_INTERLEAVE) {
 		*ilx += vma->vm_pgoff >> order;
 		*ilx += (addr - vma->vm_start) >> (PAGE_SHIFT + order);
 	}
@@ -1842,6 +1857,29 @@ bool apply_policy_zone(struct mempolicy *policy, enum zone_type zone)
 	return zone >= dynamic_policy_zone;
 }
 
+static unsigned int weighted_interleave_nodes(struct mempolicy *policy)
+{
+	unsigned int next;
+	struct task_struct *me = current;
+
+	next = next_node_in(me->il_prev, policy->nodes);
+	if (next == MAX_NUMNODES)
+		return next;
+
+	if (!policy->wil.cur_weight) {
+		u8 next_weight = iw_table[next];
+
+		if (!next_weight)
+			next_weight = default_iw_table[next];
+		policy->wil.cur_weight = next_weight;
+	}
+
+	policy->wil.cur_weight--;
+	if (!policy->wil.cur_weight)
+		me->il_prev = next;
+	return next;
+}
+
 /* Do dynamic interleaving for a process */
 static unsigned int interleave_nodes(struct mempolicy *policy)
 {
@@ -1876,6 +1914,9 @@ unsigned int mempolicy_slab_node(void)
 	case MPOL_INTERLEAVE:
 		return interleave_nodes(policy);
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		return weighted_interleave_nodes(policy);
+
 	case MPOL_BIND:
 	case MPOL_PREFERRED_MANY:
 	{
@@ -1914,6 +1955,52 @@ static unsigned int read_once_policy_nodemask(struct mempolicy *pol,
 	return nodes_weight(*mask);
 }
 
+/* places active weights in pol->wil.scratch_weights and return total */
+static unsigned int read_once_interleave_weights(struct mempolicy *pol,
+						 nodemask_t *mask)
+{
+	int nid;
+	unsigned int weight_total = 0;
+
+	/* Similar issue to read_once_policy_nodemask */
+	barrier();
+	for_each_node_mask(nid, *mask) {
+		u8 weight = iw_table[nid];
+
+		if (!weight)
+			weight = default_iw_table[nid];
+		weight_total += weight;
+		pol->wil.scratch_weights[nid] = weight;
+	}
+	barrier();
+	return weight_total;
+}
+
+static unsigned int weighted_interleave_nid(struct mempolicy *pol, pgoff_t ilx)
+{
+	nodemask_t nodemask;
+	unsigned int target, weight_total;
+	int nid;
+	u8 weight;
+
+	read_once_policy_nodemask(pol, &nodemask);
+	weight_total = read_once_interleave_weights(pol, &nodemask);
+	if (!weight_total)
+		return numa_node_id();
+
+	/* Finally, calculate the node offset based on totals */
+	target = ilx % weight_total;
+	nid = first_node(nodemask);
+	while (target) {
+		weight = pol->wil.scratch_weights[nid];
+		if (target < weight)
+			break;
+		target -= weight;
+		nid = next_node_in(nid, nodemask);
+	}
+	return nid;
+}
+
 /*
  * Do static interleaving for interleave index @ilx.  Returns the ilx'th
  * node in pol->nodes (starting from ilx=0), wrapping around if ilx
@@ -1974,6 +2061,11 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struct mempolicy *pol,
 		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
 			interleave_nodes(pol) : interleave_nid(pol, ilx);
 		break;
+	case MPOL_WEIGHTED_INTERLEAVE:
+		*nid = (ilx == NO_INTERLEAVE_INDEX) ?
+			weighted_interleave_nodes(pol) :
+			weighted_interleave_nid(pol, ilx);
+		break;
 	}
 
 	return nodemask;
@@ -2035,6 +2127,7 @@ bool init_nodemask_of_mempolicy(nodemask_t *mask)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		*mask = mempolicy->nodes;
 		break;
 
@@ -2134,7 +2227,8 @@ struct page *alloc_pages_mpol(gfp_t gfp, unsigned int order,
 		 * If the policy is interleave or does not allow the current
 		 * node in its nodemask, we allocate the standard way.
 		 */
-		if (pol->mode != MPOL_INTERLEAVE &&
+		if ((pol->mode != MPOL_INTERLEAVE &&
+		    pol->mode != MPOL_WEIGHTED_INTERLEAVE) &&
 		    (!nodemask || node_isset(nid, *nodemask))) {
 			/*
 			 * First, try to allocate THP only on local node, but
@@ -2270,6 +2364,91 @@ static unsigned long alloc_pages_bulk_array_interleave(gfp_t gfp,
 	return total_allocated;
 }
 
+static unsigned long alloc_pages_bulk_array_weighted_interleave(gfp_t gfp,
+		struct mempolicy *pol, unsigned long nr_pages,
+		struct page **page_array)
+{
+	struct task_struct *me = current;
+	unsigned long total_allocated = 0;
+	unsigned long nr_allocated;
+	unsigned long rounds;
+	unsigned long node_pages, delta;
+	u8 weight;
+	unsigned int weight_total = 0;
+	unsigned long rem_pages = nr_pages;
+	nodemask_t nodes;
+	int nnodes, node;
+	int prev_node = NUMA_NO_NODE;
+	int i;
+
+	nnodes = read_once_policy_nodemask(pol, &nodes);
+	weight_total = read_once_interleave_weights(pol, &nodes);
+
+	/* Continue allocating from most recent node and adjust the nr_pages */
+	if (pol->wil.cur_weight) {
+		node = next_node_in(me->il_prev, nodes);
+		node_pages = pol->wil.cur_weight;
+		if (node_pages > rem_pages)
+			node_pages = rem_pages;
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		/* if that's all the pages, no need to interleave */
+		if (rem_pages <= pol->wil.cur_weight) {
+			pol->wil.cur_weight -= rem_pages;
+			return total_allocated;
+		}
+		/* Otherwise we adjust nr_pages down, and continue from there */
+		rem_pages -= pol->wil.cur_weight;
+		pol->wil.cur_weight = 0;
+		prev_node = node;
+	}
+
+	/* Now we can continue allocating as if from 0 instead of an offset */
+	rounds = rem_pages / weight_total;
+	delta = rem_pages % weight_total;
+	for (i = 0; i < nnodes; i++) {
+		node = next_node_in(prev_node, nodes);
+		weight = pol->wil.scratch_weights[node];
+		node_pages = weight * rounds;
+		if (delta) {
+			if (delta > weight) {
+				node_pages += weight;
+				delta -= weight;
+			} else {
+				node_pages += delta;
+				delta = 0;
+			}
+		}
+		nr_allocated = __alloc_pages_bulk(gfp, node, NULL, node_pages,
+						  NULL, page_array);
+		page_array += nr_allocated;
+		total_allocated += nr_allocated;
+		if (total_allocated == nr_pages)
+			break;
+		prev_node = node;
+	}
+
+	/*
+	 * Finally, we need to update me->il_prev and pol->wil.cur_weight
+	 * if there were overflow pages, but not equivalent to the node
+	 * weight, set the cur_weight to node_weight - delta and the
+	 * me->il_prev to the previous node. Otherwise if it was perfect
+	 * we can simply set il_prev to node and cur_weight to 0
+	 */
+	if (node_pages) {
+		me->il_prev = prev_node;
+		node_pages %= weight;
+		pol->wil.cur_weight = weight - node_pages;
+	} else {
+		me->il_prev = node;
+		pol->wil.cur_weight = 0;
+	}
+
+	return total_allocated;
+}
+
 static unsigned long alloc_pages_bulk_array_preferred_many(gfp_t gfp, int nid,
 		struct mempolicy *pol, unsigned long nr_pages,
 		struct page **page_array)
@@ -2310,6 +2489,11 @@ unsigned long alloc_pages_bulk_array_mempolicy(gfp_t gfp,
 		return alloc_pages_bulk_array_interleave(gfp, pol,
 							 nr_pages, page_array);
 
+	if (pol->mode == MPOL_WEIGHTED_INTERLEAVE)
+		return alloc_pages_bulk_array_weighted_interleave(gfp, pol,
+								  nr_pages,
+								  page_array);
+
 	if (pol->mode == MPOL_PREFERRED_MANY)
 		return alloc_pages_bulk_array_preferred_many(gfp,
 				numa_node_id(), pol, nr_pages, page_array);
@@ -2385,6 +2569,7 @@ bool __mpol_equal(struct mempolicy *a, struct mempolicy *b)
 	case MPOL_INTERLEAVE:
 	case MPOL_PREFERRED:
 	case MPOL_PREFERRED_MANY:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		return !!nodes_equal(a->nodes, b->nodes);
 	case MPOL_LOCAL:
 		return true;
@@ -2521,6 +2706,10 @@ int mpol_misplaced(struct folio *folio, struct vm_area_struct *vma,
 		polnid = interleave_nid(pol, ilx);
 		break;
 
+	case MPOL_WEIGHTED_INTERLEAVE:
+		polnid = weighted_interleave_nid(pol, ilx);
+		break;
+
 	case MPOL_PREFERRED:
 		if (node_isset(curnid, pol->nodes))
 			goto out;
@@ -2895,6 +3084,7 @@ static const char * const policy_modes[] =
 	[MPOL_PREFERRED]  = "prefer",
 	[MPOL_BIND]       = "bind",
 	[MPOL_INTERLEAVE] = "interleave",
+	[MPOL_WEIGHTED_INTERLEAVE] = "weighted interleave",
 	[MPOL_LOCAL]      = "local",
 	[MPOL_PREFERRED_MANY]  = "prefer (many)",
 };
@@ -2954,6 +3144,7 @@ int mpol_parse_str(char *str, struct mempolicy **mpol)
 		}
 		break;
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		/*
 		 * Default to online nodes with memory if no nodelist
 		 */
@@ -3064,6 +3255,7 @@ void mpol_to_str(char *buffer, int maxlen, struct mempolicy *pol)
 	case MPOL_PREFERRED_MANY:
 	case MPOL_BIND:
 	case MPOL_INTERLEAVE:
+	case MPOL_WEIGHTED_INTERLEAVE:
 		nodes = pol->nodes;
 		break;
 	default:
-- 
2.39.1


