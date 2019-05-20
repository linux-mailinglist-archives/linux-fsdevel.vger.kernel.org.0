Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBDD22B4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:43:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730188AbfETFmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:42:25 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:54221 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727057AbfETFmY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:42:24 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 045C9BC13;
        Mon, 20 May 2019 01:42:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:42:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=US5HWl6Yr+o7Tqlb3g83eU3pKx3YxwNaogU4TX1LtRs=; b=kc0kWlJs
        0NmjnfFnQi6LJk07eViEaoQIS4EmoXA3ywM5OjQF4mkY8O/fnqPxMiPO4eJ8GufP
        9CEETvaMZ5OeCvk7DNGRQS4MdzhgMBOx9/f6mwIBOaRjjW0gsGAba7cI/Vj+rkCH
        dqdNfbqvrGDv5OgqZmFlGxGS90D2eESO0qDO3VN37SwQcI0YUHkqRMeyUQEyyUA4
        1vho7FU/MKIdoJyvgGcNb7BTfBvEDaPlR6ZpSUWpGA1Iqi60m33B1iIIBIoF2fNW
        xxp75W69/QaOZpEOP/JEVcwmXEcp0qnKw9YflyGEDCy0BKnRld5h5QLLZnCSC9DH
        RN4TnjdXHArysw==
X-ME-Sender: <xms:Pj7iXCUNA08MwsYu5IX3tZvJh0N1IPILLzZ4Yifg02CVzOly11pGPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeple
X-ME-Proxy: <xmx:Pj7iXIn0IAsTU1BMvy5Pzl3kvULEP46U3l_7yP-sRiggzZ2kj0htqw>
    <xmx:Pj7iXNDCRb0IOfsaWYmSFmF1QxV1Xw94DRB7-cwVMdW6NMSNKqcSWg>
    <xmx:Pj7iXHjQMhy_D6yVWyr9yqf1weJjFjAM5j_T-_6JYWhl1WkN9M8nOA>
    <xmx:Pj7iXHxwAKqWEbwNJ7zAAejwR9xygPgXid6LgQMl0-uzEdMZli4Trg>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id DBBF380064;
        Mon, 20 May 2019 01:42:15 -0400 (EDT)
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
Subject: [RFC PATCH v5 10/16] xarray: Implement migration function for xa_node objects
Date:   Mon, 20 May 2019 15:40:11 +1000
Message-Id: <20190520054017.32299-11-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Recently Slab Movable Objects (SMO) was implemented for the SLUB
allocator.  The XArray can take advantage of this and make the xa_node
slab cache objects movable.

Implement functions to migrate objects and activate SMO when we
initialise the XArray slab cache.

This is based on initial code by Matthew Wilcox and was modified to work
with slab object migration.

Cc: Matthew Wilcox <willy@infradead.org>
Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 lib/xarray.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/lib/xarray.c b/lib/xarray.c
index a528a5277c9d..c6b077f59e88 100644
--- a/lib/xarray.c
+++ b/lib/xarray.c
@@ -1993,12 +1993,73 @@ static void xa_node_ctor(void *arg)
 	INIT_LIST_HEAD(&node->private_list);
 }
 
+static void xa_object_migrate(struct xa_node *node, int numa_node)
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
+	new_node = kmem_cache_alloc_node(xa_node_cachep, GFP_KERNEL, numa_node);
+	if (!new_node) {
+		pr_err("%s: slab cache allocation failed\n", __func__);
+		return;
+	}
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
+static void xa_migrate(struct kmem_cache *s, void **objects, int nr,
+		       int node, void *_unused)
+{
+	int i;
+
+	for (i = 0; i < nr; i++)
+		xa_object_migrate(objects[i], node);
+}
+
+
 void __init xarray_slabcache_init(void)
 {
 	xa_node_cachep = kmem_cache_create("xarray_node",
 					   sizeof(struct xa_node), 0,
 					   SLAB_PANIC | SLAB_RECLAIM_ACCOUNT,
 					   xa_node_ctor);
+	kmem_cache_setup_mobility(xa_node_cachep, NULL, xa_migrate);
 }
 
 #ifdef XA_DEBUG
-- 
2.21.0

