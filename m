Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA2922B5B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfETFnB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:43:01 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:41005 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbfETFnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:43:00 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3D25710E56;
        Mon, 20 May 2019 01:42:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=saCxizw32Jq7dMTN5gwfHcfa+dy7EpZHGbTHKFMG+ho=; b=gAlSX8TO
        fcuek0YYCjnPtnRqtTcFPf18A3CjnScnL+unrhGzFdsGVFTur1RufeyGl9kcHIaL
        uh+hknblFftXo3OYtovnHQI2ovqIw3J2VlkVvKvL2XMGveghgWqujLvvqSY+MEoe
        E4fMy9EQy2zlr1MI5fcpEWgb9YE1vP/9Uql5R27Y98ZbHlNDeqFpIlf9d7j1De8p
        CK6f9780Qk7kRhUIHEU9zvE4Ugss5ENJOjjRl8UG/N8YxE2xrnBzHk9BvYQANfJN
        RHwzqYkX7doCeg+0YeDniqXxNMRyE+u8ftFvTnoIrEeAIoDQguHkwlYO5BE0GgMT
        zwwTNjFHjeRviw==
X-ME-Sender: <xms:Yj7iXKNnVSUcQRk2g_7dQ0ex5OaE1H7QBvisnGaTsBHRtJh0JuWTMQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepudeg
X-ME-Proxy: <xmx:Yj7iXNOH4iW8wxBM2SLZ9guclf989J13YwVM2CrnSbKr4NzSADYbvw>
    <xmx:Yj7iXMRTqplrYJndw1fxg_JsUYdN2SgMpgd3WtEcbb2dNd3A78x6zg>
    <xmx:Yj7iXPDLdrTfg3fJfqQAwLdLrLao8F5ueKsP2yN_B9r5gOIVHFy7bQ>
    <xmx:Yz7iXGFoOtQ8Iy44Z1cLvm308Kv_fiOVCGVvmSLFcDRYYHIMr9mBqQ>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id 016CE8005B;
        Mon, 20 May 2019 01:42:51 -0400 (EDT)
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
Subject: [RFC PATCH v5 15/16] dcache: Implement partial shrink via Slab Movable Objects
Date:   Mon, 20 May 2019 15:40:16 +1000
Message-Id: <20190520054017.32299-16-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The dentry slab cache is susceptible to internal fragmentation.  Now
that we have Slab Movable Objects we can attempt to defragment the
dcache.  Dentry objects are inherently _not_ relocatable however under
some conditions they can be free'd.  This is the same as shrinking the
dcache but instead of shrinking the whole cache we only attempt to free
those objects that are located in partially full slab pages.  There is
no guarantee that this will reduce the memory usage of the system, it is
a compromise between fragmented memory and total cache shrinkage with
the hope that some memory pressure can be alleviated.

This is implemented using the newly added Slab Movable Objects
infrastructure.  The dcache 'migration' function is intentionally _not_
called 'd_migrate' because we only free, we do not migrate.  Call it
'd_partial_shrink' to make explicit that no reallocation is done.

Implement isolate and 'migrate' functions for the dentry slab cache.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 76 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index b7318615979d..0dfe580c2d42 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -31,6 +31,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/backing-dev.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3071,6 +3072,79 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+/*
+ * d_isolate() - Dentry isolation callback function.
+ * @s: The dentry cache.
+ * @v: Vector of pointers to the objects to isolate.
+ * @nr: Number of objects in @v.
+ *
+ * The slab allocator is holding off frees. We can safely examine
+ * the object without the danger of it vanishing from under us.
+ */
+static void *d_isolate(struct kmem_cache *s, void **v, int nr)
+{
+	struct list_head *dispose;
+	struct dentry *dentry;
+	int i;
+
+	dispose = kmalloc(sizeof(*dispose), GFP_KERNEL);
+	if (!dispose)
+		return NULL;
+
+	INIT_LIST_HEAD(dispose);
+
+	for (i = 0; i < nr; i++) {
+		dentry = v[i];
+		spin_lock(&dentry->d_lock);
+
+		if (dentry->d_lockref.count > 0 ||
+		    dentry->d_flags & DCACHE_SHRINK_LIST) {
+			spin_unlock(&dentry->d_lock);
+			continue;
+		}
+
+		if (dentry->d_flags & DCACHE_LRU_LIST)
+			d_lru_del(dentry);
+
+		d_shrink_add(dentry, dispose);
+		spin_unlock(&dentry->d_lock);
+	}
+
+	return dispose;
+}
+
+/*
+ * d_partial_shrink() - Dentry migration callback function.
+ * @s: The dentry cache.
+ * @_unused: We do not access the vector.
+ * @__unused: No need for length of vector.
+ * @___unused: We do not do any allocation.
+ * @private: list_head pointer representing the shrink list.
+ *
+ * Dispose of the shrink list created during isolation function.
+ *
+ * Dentry objects can _not_ be relocated and shrinking the whole dcache
+ * can be expensive.  This is an effort to free dentry objects that are
+ * stopping slab pages from being free'd without clearing the whole dcache.
+ *
+ * This callback is called from the SLUB allocator object migration
+ * infrastructure in attempt to free up slab pages by freeing dentry
+ * objects from partially full slabs.
+ */
+static void d_partial_shrink(struct kmem_cache *s, void **_unused, int __unused,
+			     int ___unused, void *private)
+{
+	struct list_head *dispose = private;
+
+	if (!private)		/* kmalloc error during isolate. */
+		return;
+
+	if (!list_empty(dispose))
+		shrink_dentry_list(dispose);
+
+	kfree(private);
+}
+
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
 {
@@ -3116,6 +3190,8 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
-- 
2.21.0

