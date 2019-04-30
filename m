Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89FDCEF14
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfD3DKi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:10:38 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39061 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729931AbfD3DKi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:10:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D25E41489D;
        Mon, 29 Apr 2019 23:10:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=AtTOS3tLSFxiBVY6HKqiEZQDmJwYtvFPI1Eb7X0+v6o=; b=Mz0JYE8q
        6mfgLxTsFaZvnrjTOzIU1K9OLF5xaipxeaIRg07vVAIGydkzG41j0c9cIjAaqfPu
        suuks90VIcxBWrW8xNvU/djcyBGQwdRU8LhIOmphBHp/qUEnucLkh9SU3+9ZrL3d
        v86+RFNKYWgLRshebiLPhu1k9CgZjaQD1CV3uvfH9jdUJwTpHIVG5GyAVb5fJUDT
        JmLxKIFRmxu8gZGpBn9e4PvBsthjqhArLsJfe0HayxvLV9XjrLsyETpCi35zzCbV
        1SPFpp+quxv5q+CrN0Tuy0K7BDEPf39g70zWVvBkBJXP2T0/7SihlY93d07n60Fm
        ApjoRKAP/cCWfA==
X-ME-Sender: <xms:rLzHXKOfqlGrWL8S2WhTKZLl5kxzbCQBIBWcW0smEu6avfPMdN87ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:rLzHXN4f46LGtTZJ7txwKxUIN2IAa7-SpRP9xEMQWgVAxIOQdxpRqw>
    <xmx:rLzHXFg1fs8qluDrz4RrsCEPUamfhH31RF5O25uIMecJ7xu9eAv55Q>
    <xmx:rLzHXKd8a0vMcvXbK2N8oG86vGehKVwfd_MuQHLZY0znoVAMei6pLg>
    <xmx:rLzHXLOmS5-J877V7vApJD0H0THHYtSFeeGb_EMyQgotvz9UJ95g_g>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24FE9103C8;
        Mon, 29 Apr 2019 23:10:28 -0400 (EDT)
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
Subject: [RFC PATCH v4 14/15] dcache: Implement partial shrink via Slab Movable Objects
Date:   Tue, 30 Apr 2019 13:07:45 +1000
Message-Id: <20190430030746.26102-15-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
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
index 3d6cc06eca56..3f9daba1cc78 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -30,6 +30,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/rculist_bl.h>
 #include <linux/list_lru.h>
+#include <linux/backing-dev.h>
 #include "internal.h"
 #include "mount.h"
 
@@ -3067,6 +3068,79 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
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
@@ -3112,6 +3186,8 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
-- 
2.21.0

