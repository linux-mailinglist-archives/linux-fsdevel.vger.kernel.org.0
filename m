Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87C4EF0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbfD3DKN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:10:13 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:56221 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729988AbfD3DKM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:10:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 34C78A460;
        Mon, 29 Apr 2019 23:10:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:10:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=YTpDBiPIz+r0uG1auSa8ph45UtBEpiDJlB6LNiHXZmQ=; b=Gp5AtuwP
        zsytgvXMsqqx/PEtOwlH2cf2yZ3KT6uRfusGcuJ2FfuUcZKoYIEYwFCV4q1J0Ilr
        kYc/XwcdafDBxRD/DxKrSDtaO144R64GZgzlTWI4u6zCBTJqVGeKvyLzdjxBa6IT
        sHzUCFtM7mHHGVcFgmawPMJFu8VqeFrbVxvG+AalTTxjBn2haouwmmqTOoCTtyBv
        KqBuTy6y3zpytrZdsA4+wR9FKQoDPi1xHG6rVZIW1Uz2EFPushPjUPHjS2Rj1PrG
        MO1r5tX/r5UA27ehob5lmdb5fTOBJJaCGmARSXhGwwXXRcBRoYDMfI0/DKKvq2bw
        lADQ4WHAzmGabQ==
X-ME-Sender: <xms:krzHXK04tV0cST-ddWM4dAflEWWw7VTpRSXNr0iaLFTg450BqbDX0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedutd
X-ME-Proxy: <xmx:krzHXEpfIlPgUj132tU2yutZZmyzBxEyNUnlpt13I-p-1mSiOroDpA>
    <xmx:krzHXCgZImbuvAXPy2IaJFhf0Clk-11gE262ZFBp-cI8Uc1O1-nmkQ>
    <xmx:krzHXIkFsrPu_LcUJc6384ymM0UgmVdwhVCFWz7cnR6KNYWPdeFQpw>
    <xmx:k7zHXH4LBkLQkf_Tq--68cdWlGD8uPJcSxoJsrpRVDjSVev9okiVvQ>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 072E5103C8;
        Mon, 29 Apr 2019 23:10:02 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 11/15] slub: Enable moving objects to/from specific nodes
Date:   Tue, 30 Apr 2019 13:07:42 +1000
Message-Id: <20190430030746.26102-12-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We have just implemented Slab Movable Objects (object migration).
Currently object migration is used to defrag a cache.  On NUMA systems
it would be nice to be able to control the source and destination nodes
when moving objects.

Add CONFIG_SMO_NODE to guard this feature.  CONFIG_SMO_NODE depends on
CONFIG_SLUB_DEBUG because we use the full list.  Leave it like this for
the RFC because the patch will be less cluttered to review, separate
full list out of CONFIG_DEBUG before doing a PATCH version.

Implement moving all objects (including those in full slabs) to a
specific node.  Expose this functionality to userspace via a sysfs entry.

Add sysfs entry:

   /sysfs/kernel/slab/<cache>/move

With this users get access to the following functionality:

 - Move all objects to specified node.

   	echo "N1" > move

 - Move all objects from specified node to other specified
   node (from N1 -> to N2):

   	echo "N1 N2" > move

This also enables shrinking slabs on a specific node:

   	echo "N1 N1" > move

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/Kconfig |   7 ++
 mm/slub.c  | 249 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 256 insertions(+)

diff --git a/mm/Kconfig b/mm/Kconfig
index 25c71eb8a7db..47040d939f3b 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -258,6 +258,13 @@ config ARCH_ENABLE_HUGEPAGE_MIGRATION
 config ARCH_ENABLE_THP_MIGRATION
 	bool
 
+config SMO_NODE
+       bool "Enable per node control of Slab Movable Objects"
+       depends on SLUB && SYSFS
+       select SLUB_DEBUG
+       help
+         On NUMA systems enable moving objects to and from a specified node.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
diff --git a/mm/slub.c b/mm/slub.c
index e601c804ed79..e4f3dde443f5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4345,6 +4345,106 @@ static void move_slab_page(struct page *page, void *scratch, int node)
 	s->migrate(s, vector, count, node, private);
 }
 
+#ifdef CONFIG_SMO_NODE
+/*
+ * kmem_cache_move() - Attempt to move all slab objects.
+ * @s: The cache we are working on.
+ * @node: The node to move objects away from.
+ * @target_node: The node to move objects on to.
+ *
+ * Attempts to move all objects (partial slabs and full slabs) to target
+ * node.
+ *
+ * Context: Takes the list_lock.
+ * Return: The number of slabs remaining on node.
+ */
+static unsigned long kmem_cache_move(struct kmem_cache *s,
+				     int node, int target_node)
+{
+	struct kmem_cache_node *n = get_node(s, node);
+	LIST_HEAD(move_list);
+	struct page *page, *page2;
+	unsigned long flags;
+	void **scratch;
+
+	if (!s->migrate) {
+		pr_warn("%s SMO not enabled, cannot move objects\n", s->name);
+		goto out;
+	}
+
+	scratch = alloc_scratch(s);
+	if (!scratch)
+		goto out;
+
+	spin_lock_irqsave(&n->list_lock, flags);
+
+	list_for_each_entry_safe(page, page2, &n->partial, lru) {
+		if (!slab_trylock(page))
+			/* Busy slab. Get out of the way */
+			continue;
+
+		if (page->inuse) {
+			list_move(&page->lru, &move_list);
+			/* Stop page being considered for allocations */
+			n->nr_partial--;
+			page->frozen = 1;
+
+			slab_unlock(page);
+		} else {	/* Empty slab page */
+			list_del(&page->lru);
+			n->nr_partial--;
+			slab_unlock(page);
+			discard_slab(s, page);
+		}
+	}
+	list_for_each_entry_safe(page, page2, &n->full, lru) {
+		if (!slab_trylock(page))
+			continue;
+
+		list_move(&page->lru, &move_list);
+		page->frozen = 1;
+		slab_unlock(page);
+	}
+
+	spin_unlock_irqrestore(&n->list_lock, flags);
+
+	list_for_each_entry(page, &move_list, lru) {
+		if (page->inuse)
+			move_slab_page(page, scratch, target_node);
+	}
+	kfree(scratch);
+
+	/* Bail here to save taking the list_lock */
+	if (list_empty(&move_list))
+		goto out;
+
+	/* Inspect results and dispose of pages */
+	spin_lock_irqsave(&n->list_lock, flags);
+	list_for_each_entry_safe(page, page2, &move_list, lru) {
+		list_del(&page->lru);
+		slab_lock(page);
+		page->frozen = 0;
+
+		if (page->inuse) {
+			if (page->inuse == page->objects) {
+				list_add(&page->lru, &n->full);
+				slab_unlock(page);
+			} else {
+				n->nr_partial++;
+				list_add_tail(&page->lru, &n->partial);
+				slab_unlock(page);
+			}
+		} else {
+			slab_unlock(page);
+			discard_slab(s, page);
+		}
+	}
+	spin_unlock_irqrestore(&n->list_lock, flags);
+out:
+	return atomic_long_read(&n->nr_slabs);
+}
+#endif	/* CONFIG_SMO_NODE */
+
 /*
  * kmem_cache_defrag() - Defragment node.
  * @s: cache we are working on.
@@ -4459,6 +4559,32 @@ static unsigned long kmem_cache_defrag(struct kmem_cache *s,
 	return n->nr_partial;
 }
 
+#ifdef CONFIG_SMO_NODE
+/*
+ * kmem_cache_move_to_node() - Move all slab objects to node.
+ * @s: The cache we are working on.
+ * @node: The target node to move objects to.
+ *
+ * Attempt to move all slab objects from all nodes to @node.
+ *
+ * Return: The total number of slabs left on emptied nodes.
+ */
+static unsigned long kmem_cache_move_to_node(struct kmem_cache *s, int node)
+{
+	unsigned long left = 0;
+	int nid;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		if (nid == node)
+			continue;
+
+		left += kmem_cache_move(s, nid, node);
+	}
+
+	return left;
+}
+#endif
+
 /**
  * kmem_defrag_slabs() - Defrag slab caches.
  * @node: The node to defrag or -1 for all nodes.
@@ -5603,6 +5729,126 @@ static ssize_t shrink_store(struct kmem_cache *s,
 }
 SLAB_ATTR(shrink);
 
+#ifdef CONFIG_SMO_NODE
+static ssize_t move_show(struct kmem_cache *s, char *buf)
+{
+	return 0;
+}
+
+/*
+ * parse_move_store_input() - Parse buf getting integer arguments.
+ * @buf: Buffer to parse.
+ * @length: Length of @buf.
+ * @arg0: Return parameter, first argument.
+ * @arg1: Return parameter, second argument.
+ *
+ * Parses the input from user write to sysfs file 'move'.  Input string
+ * should contain either one or two node specifiers of form Nx where x
+ * is an integer specifying the NUMA node ID.  'N' or 'n' may be used.
+ * n/N may be omitted.
+ *
+ * e.g.
+ *     echo 'N1' > /sysfs/kernel/slab/cache/move
+ * or
+ *     echo 'N0 N2' > /sysfs/kernel/slab/cache/move
+ *
+ * Regex matching accepted forms: '[nN]?[0-9]( [nN]?[0-9])?'
+ *
+ * FIXME: This is really fragile.  Input must be exactly correct,
+ *        spurious whitespace causes parse errors.
+ *
+ * Return: 0 if an argument was successfully converted, or an error code.
+ */
+static ssize_t parse_move_store_input(const char *buf, size_t length,
+				      long *arg0, long *arg1)
+{
+	char *s, *save, *ptr;
+	int ret = 0;
+
+	if (!buf)
+		return -EINVAL;
+
+	s = kstrdup(buf, GFP_KERNEL);
+	if (!s)
+		return -ENOMEM;
+	save = s;
+
+	if (s[length - 1] == '\n') {
+		s[length - 1] = '\0';
+		length--;
+	}
+
+	ptr = strsep(&s, " ");
+	if (!ptr || strcmp(ptr, "") == 0) {
+		ret = 0;
+		goto out;
+	}
+
+	if (*ptr == 'N' || *ptr == 'n')
+		ptr++;
+	ret = kstrtol(ptr, 10, arg0);
+	if (ret < 0)
+		goto out;
+
+	if (s) {
+		if (*s == 'N' || *s == 'n')
+			s++;
+		ret = kstrtol(s, 10, arg1);
+		if (ret < 0)
+			goto out;
+	}
+
+	ret = 0;
+out:
+	kfree(save);
+	return ret;
+}
+
+static bool is_valid_node(int node)
+{
+	int nid;
+
+	for_each_node_state(nid, N_NORMAL_MEMORY) {
+		if (nid == node)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * move_store() - Move objects between nodes.
+ * @s: The cache we are working on.
+ * @buf: String received.
+ * @length: Length of @buf.
+ *
+ * Writes to /sys/kernel/slab/<cache>/move are interpreted as follows:
+ *
+ *  echo "N1" > move       : Move all objects (from all nodes) to node 1.
+ *  echo "N0 N1" > move    : Move all objects from node 0 to node 1.
+ *
+ * 'N' may be omitted:
+ */
+static ssize_t move_store(struct kmem_cache *s, const char *buf, size_t length)
+{
+	long arg0 = -1;
+	long arg1 = -1;
+	int ret;
+
+	ret = parse_move_store_input(buf, length, &arg0, &arg1);
+	if (ret < 0)
+		return -EINVAL;
+
+	if (is_valid_node(arg0) && is_valid_node(arg1))
+		(void)kmem_cache_move(s, arg0, arg1);
+	else if (is_valid_node(arg0))
+		(void)kmem_cache_move_to_node(s, arg0);
+
+	/* FIXME: What should we be returning here? */
+	return length;
+}
+SLAB_ATTR(move);
+#endif	/* CONFIG_SMO_NODE */
+
 #ifdef CONFIG_NUMA
 static ssize_t remote_node_defrag_ratio_show(struct kmem_cache *s, char *buf)
 {
@@ -5727,6 +5973,9 @@ static struct attribute *slab_attrs[] = {
 	&reclaim_account_attr.attr,
 	&destroy_by_rcu_attr.attr,
 	&shrink_attr.attr,
+#ifdef CONFIG_SMO_NODE
+	&move_attr.attr,
+#endif
 	&slabs_cpu_partial_attr.attr,
 #ifdef CONFIG_SLUB_DEBUG
 	&total_objects_attr.attr,
-- 
2.21.0

