Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0057122B4C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfETFmS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:42:18 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:44181 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfETFmS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:42:18 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C619AA829;
        Mon, 20 May 2019 01:42:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=F5aR/6PSAAo/4gqYLlgL9w8L/omD4wgEh0XNiCKl+dI=; b=4q0hWeJv
        FFIFSzB6p1Y6Ld4qHXbTythAidiWhdLsKMnKSWiR5p01cWZpv4hFaNHhAkwteTso
        YBCvHKCyNhdOhs2m6HTXibD3ARgYfxV6x1grE5JpOEOtTAtRRWn4gkw1YPFIiBJ3
        scfIfzv1LsLBBxCWhjaIkoOEtBTqGcdTgxy+taAh5a9gAIWMiL84hsZ/l2RTKUBE
        bM/JxmtQ79/pYZrYpJ/hRSYqVPf4sG4307TJJzZmOD4rooSaBremXmbKUkJqkve8
        8vsWXXbVvc4fWaeKbUeGFaf+oyAb4nqgZ00zTN+NqAs5xZ8/PwgUyD2yUM0BDRJZ
        hPdz6VR3FKdrNA==
X-ME-Sender: <xms:Nz7iXHc_p63WmT8Hv_zVX9-hQNRqAcx6_BpQy9aRA_RV-X5qO6YHqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepke
X-ME-Proxy: <xmx:Nz7iXJi5cJTwvcQKFovaZf1kcLHiAvg27tawIkhVPrqBYsbaKjUNLA>
    <xmx:Nz7iXCI40xy_rDeW2AnOPKNgeaaJH_OM--sDroQErKyjjUrnlJ6qGQ>
    <xmx:Nz7iXGEx-o6FUj8lJSRAbf5wyWgfKU7ltKWH8d9GzLXNUozb0RFWVg>
    <xmx:Nz7iXHKZk7UsymP2gqffS4_zS8fZlms0ZDjJ2oub_T4PqlAG_-z7PA>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9B96980061;
        Mon, 20 May 2019 01:42:08 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 09/16] lib: Separate radix_tree_node and xa_node slab cache
Date:   Mon, 20 May 2019 15:40:10 +1000
Message-Id: <20190520054017.32299-10-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Earlier, Slab Movable Objects (SMO) was implemented.  The XArray is now
able to take advantage of SMO in order to make xarray nodes
movable (when using the SLUB allocator).

Currently the radix tree uses the same slab cache as the XArray.  Only
XArray nodes are movable _not_ radix tree nodes.  We can give the radix
tree its own slab cache to overcome this.

In preparation for implementing XArray object migration (xa_node
objects) via Slab Movable Objects add a slab cache solely for XArray
nodes and make the XArray use this slab cache instead of the
radix_tree_node slab cache.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/xarray.h |  3 +++
 init/main.c            |  2 ++
 lib/radix-tree.c       |  2 +-
 lib/xarray.c           | 48 ++++++++++++++++++++++++++++++++++--------
 4 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 0e01e6129145..773f91f8e1db 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -42,6 +42,9 @@
 
 #define BITS_PER_XA_VALUE	(BITS_PER_LONG - 1)
 
+/* Called from init/main.c */
+void xarray_slabcache_init(void);
+
 /**
  * xa_mk_value() - Create an XArray entry from an integer.
  * @v: Value to store in XArray.
diff --git a/init/main.c b/init/main.c
index 5a2c69b4d7b3..e89915ffbe26 100644
--- a/init/main.c
+++ b/init/main.c
@@ -106,6 +106,7 @@ static int kernel_init(void *);
 
 extern void init_IRQ(void);
 extern void radix_tree_init(void);
+extern void xarray_slabcache_init(void);
 
 /*
  * Debug helper: via this flag we know that we are in 'early bootup code'
@@ -621,6 +622,7 @@ asmlinkage __visible void __init start_kernel(void)
 		 "Interrupts were enabled *very* early, fixing it\n"))
 		local_irq_disable();
 	radix_tree_init();
+	xarray_slabcache_init();
 
 	/*
 	 * Set up housekeeping before setting up workqueues to allow the unbound
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 14d51548bea6..edbfb530ba73 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -44,7 +44,7 @@
 /*
  * Radix tree node cache.
  */
-struct kmem_cache *radix_tree_node_cachep;
+static struct kmem_cache *radix_tree_node_cachep;
 
 /*
  * The radix tree is variable-height, so an insert operation not only has
diff --git a/lib/xarray.c b/lib/xarray.c
index 6be3acbb861f..a528a5277c9d 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -27,6 +27,8 @@
  * @entry refers to something stored in a slot in the xarray
  */
 
+static struct kmem_cache *xa_node_cachep;
+
 static inline unsigned int xa_lock_type(const struct xarray *xa)
 {
 	return (__force unsigned int)xa->xa_flags & 3;
@@ -244,9 +246,21 @@ void *xas_load(struct xa_state *xas)
 }
 EXPORT_SYMBOL_GPL(xas_load);
 
-/* Move the radix tree node cache here */
-extern struct kmem_cache *radix_tree_node_cachep;
-extern void radix_tree_node_rcu_free(struct rcu_head *head);
+void xa_node_rcu_free(struct rcu_head *head)
+{
+	struct xa_node *node = container_of(head, struct xa_node, rcu_head);
+
+	/*
+	 * Must only free zeroed nodes into the slab.  We can be left with
+	 * non-NULL entries by radix_tree_free_nodes, so clear the entries
+	 * and tags here.
+	 */
+	memset(node->slots, 0, sizeof(node->slots));
+	memset(node->tags, 0, sizeof(node->tags));
+	INIT_LIST_HEAD(&node->private_list);
+
+	kmem_cache_free(xa_node_cachep, node);
+}
 
 #define XA_RCU_FREE	((struct xarray *)1)
 
@@ -254,7 +268,7 @@ static void xa_node_free(struct xa_node *node)
 {
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
 	node->array = XA_RCU_FREE;
-	call_rcu(&node->rcu_head, radix_tree_node_rcu_free);
+	call_rcu(&node->rcu_head, xa_node_rcu_free);
 }
 
 /*
@@ -270,7 +284,7 @@ static void xas_destroy(struct xa_state *xas)
 	if (!node)
 		return;
 	XA_NODE_BUG_ON(node, !list_empty(&node->private_list));
-	kmem_cache_free(radix_tree_node_cachep, node);
+	kmem_cache_free(xa_node_cachep, node);
 	xas->xa_alloc = NULL;
 }
 
@@ -298,7 +312,7 @@ bool xas_nomem(struct xa_state *xas, gfp_t gfp)
 		xas_destroy(xas);
 		return false;
 	}
-	xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+	xas->xa_alloc = kmem_cache_alloc(xa_node_cachep, gfp);
 	if (!xas->xa_alloc)
 		return false;
 	XA_NODE_BUG_ON(xas->xa_alloc, !list_empty(&xas->xa_alloc->private_list));
@@ -327,10 +341,10 @@ static bool __xas_nomem(struct xa_state *xas, gfp_t gfp)
 	}
 	if (gfpflags_allow_blocking(gfp)) {
 		xas_unlock_type(xas, lock_type);
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc(xa_node_cachep, gfp);
 		xas_lock_type(xas, lock_type);
 	} else {
-		xas->xa_alloc = kmem_cache_alloc(radix_tree_node_cachep, gfp);
+		xas->xa_alloc = kmem_cache_alloc(xa_node_cachep, gfp);
 	}
 	if (!xas->xa_alloc)
 		return false;
@@ -358,7 +372,7 @@ static void *xas_alloc(struct xa_state *xas, unsigned int shift)
 	if (node) {
 		xas->xa_alloc = NULL;
 	} else {
-		node = kmem_cache_alloc(radix_tree_node_cachep,
+		node = kmem_cache_alloc(xa_node_cachep,
 					GFP_NOWAIT | __GFP_NOWARN);
 		if (!node) {
 			xas_set_err(xas, -ENOMEM);
@@ -1971,6 +1985,22 @@ void xa_destroy(struct xarray *xa)
 }
 EXPORT_SYMBOL(xa_destroy);
 
+static void xa_node_ctor(void *arg)
+{
+	struct xa_node *node = arg;
+
+	memset(node, 0, sizeof(*node));
+	INIT_LIST_HEAD(&node->private_list);
+}
+
+void __init xarray_slabcache_init(void)
+{
+	xa_node_cachep = kmem_cache_create("xarray_node",
+					   sizeof(struct xa_node), 0,
+					   SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
+					   xa_node_ctor);
+}
+
 #ifdef XA_DEBUG
 void xa_dump_node(const struct xa_node *node)
 {
-- 
2.21.0

