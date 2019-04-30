Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB13EF09
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730121AbfD3DJz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:09:55 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:36709 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730090AbfD3DJy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:09:54 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C2BE713DC3;
        Mon, 29 Apr 2019 23:09:53 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:09:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=+np6ZQiGNtF1RzthBJCokkLQhVYLo5zEKFMlgFr5PgA=; b=O4HjqKHF
        BMRO+50OXaEG3RE7O+zTcbPMuVoq49Tf/5PF9HsXBPI5e79VDS2G7Btpm7streiL
        mPYGpSb5EqoTGXMbit0ASRHdTO/VuEdFnkGXxKQJvpP9FdpAX9qc3uQieAXr4LC+
        EviJ7DdeG/qj2woFW13fjvIrWGhgpkRH1fFGlOn522Ie9ktUS2M63bbpixQkBlrr
        A6P8SddlC74ucI3tn1Vowqk8H9ltLaS5a5voileP8jc2CKMakD3pnO2QRMpoZHDJ
        HOWtOLCIYUkb7I5yLLZs0KwfoXKe8YhWXrRDTRMBkS2ormWiEgNN1BaO1TNEM7fd
        WlL7efT8rA9huQ==
X-ME-Sender: <xms:gbzHXBRYTCS4lSNpktxPk71DArwRS-BnzpPHOsmL02zp1DYqxL_5Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeek
X-ME-Proxy: <xmx:gbzHXMbXIto-RNKcWg1auuy9gBGUheu-bDY8jHYo6NsdDaVV5jSQ0w>
    <xmx:gbzHXFhtK3HpOtASk52KwzAUjgLe_FSgvUgUc4tuSekJKYgV0lhONQ>
    <xmx:gbzHXBj20Qh3nUwKUOdfIynKyTWC4N63JRLnJ7MSShy5KXbdjfkBbA>
    <xmx:gbzHXJNtzZFlRT0acLoWbsXmWhL7SErBF6lvdbLaI2-8eWCMy7tmlA>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 118F3103CB;
        Mon, 29 Apr 2019 23:09:45 -0400 (EDT)
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
Subject: [RFC PATCH v4 09/15] xarray: Implement migration function for objects
Date:   Tue, 30 Apr 2019 13:07:40 +1000
Message-Id: <20190430030746.26102-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement functions to migrate objects. This is based on initial code by
Matthew Wilcox and was modified to work with slab object migration.

This patch can not be merged until all radix tree & IDR users are
converted to the XArray because xa_nodes and radix tree nodes share the
same slab cache (thanks Matthew).

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/radix-tree.c | 13 +++++++++++++
 lib/xarray.c     | 49 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 14d51548bea6..9412c2853726 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -1613,6 +1613,17 @@ static int radix_tree_cpu_dead(unsigned int cpu)
 	return 0;
 }
 
+extern void xa_object_migrate(void *tree_node, int numa_node);
+
+static void radix_tree_migrate(struct kmem_cache *s, void **objects, int nr,
+			       int node, void *private)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		xa_object_migrate(objects[i], node);
+}
+
 void __init radix_tree_init(void)
 {
 	int ret;
@@ -1627,4 +1638,6 @@ void __init radix_tree_init(void)
 	ret = cpuhp_setup_state_nocalls(CPUHP_RADIX_DEAD, "lib/radix:dead",
 					NULL, radix_tree_cpu_dead);
 	WARN_ON(ret < 0);
+	kmem_cache_setup_mobility(radix_tree_node_cachep, NULL,
+				  radix_tree_migrate);
 }
diff --git a/lib/xarray.c b/lib/xarray.c
index 6be3acbb861f..731dd3d8ddb8 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1971,6 +1971,55 @@ void xa_destroy(struct xarray *xa)
 }
 EXPORT_SYMBOL(xa_destroy);
 
+void xa_object_migrate(struct xa_node *node, int numa_node)
+{
+	struct xarray *xa = READ_ONCE(node->array);
+	void __rcu **slot;
+	struct xa_node *new_node;
+	int i;
+
+	/* Freed or not yet in tree then skip */
+	if (!xa || xa == XA_RCU_FREE)
+		return;
+
+	new_node = kmem_cache_alloc_node(radix_tree_node_cachep,
+					 GFP_KERNEL, numa_node);
+	if (!new_node)
+		return;
+
+	xa_lock_irq(xa);
+
+	/* Check again..... */
+	if (xa != node->array) {
+		node = new_node;
+		goto unlock;
+	}
+
+	memcpy(new_node, node, sizeof(struct xa_node));
+
+	if (list_empty(&node->private_list))
+		INIT_LIST_HEAD(&new_node->private_list);
+	else
+		list_replace(&node->private_list, &new_node->private_list);
+
+	for (i = 0; i < XA_CHUNK_SIZE; i++) {
+		void *x = xa_entry_locked(xa, new_node, i);
+
+		if (xa_is_node(x))
+			rcu_assign_pointer(xa_to_node(x)->parent, new_node);
+	}
+	if (!new_node->parent)
+		slot = &xa->xa_head;
+	else
+		slot = &xa_parent_locked(xa, new_node)->slots[new_node->offset];
+	rcu_assign_pointer(*slot, xa_mk_node(new_node));
+
+unlock:
+	xa_unlock_irq(xa);
+	xa_node_free(node);
+	rcu_barrier();
+}
+
 #ifdef XA_DEBUG
 void xa_dump_node(const struct xa_node *node)
 {
-- 
2.21.0

