Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0D33278A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfFCE3K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:29:10 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:48365 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726221AbfFCE3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:29:10 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 3641A21A9;
        Mon,  3 Jun 2019 00:29:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:29:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=xAUe/GSEE+822SPVzryZpZO8XwI9dFOU44eaj5D2zRU=; b=imTMfnlo
        DxJpQ3ZxqMsQ2FeM4DiG4WgLXKr5msfS1/U/H5OrxPpDNaXEwnxHt8wwMp8oC7L7
        qSZAJSfFctSrnVTckBMZGqjeXdCrcd1oHGlX9em+unJm5R3wii3FXU3s6j/SO/s1
        JbnEVn2Z4DyDP2bkXpiBaXBH1zzCfH0QBVQy4kVden0T4LwoZH2AuV7FosgiURg7
        vsNs0fJPAwfCl4AEl9frWtjJrqBIglSha7eFWUfteIrLpTorvhhugU8jANxdOovL
        GK8/mzteXjES6m4AM50S/0nZUhcdjo1fiIc3EVKknK5JJmkbOV5YZDa878SXgF4W
        0AWGw9QQxSU24A==
X-ME-Sender: <xms:FKL0XL0WBKpXoRtUtKwz4OoxhFG7BliILJQHKZfXbg010fA1-_19wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:FaL0XFebpgoB0thHOIJmFRPSUuBVzfemRAqNezm-3JVOH5ltVVYuxA>
    <xmx:FaL0XFRUZQt1FCxWTY7IJuij0m5r5sugIYt81uAFWjtVf6wrHAwIuQ>
    <xmx:FaL0XImnw-ykTV2vbadnKyx0B5vvj12XjU7eKKa5InkzQvHTigFhWQ>
    <xmx:FaL0XO69olUJ2D5MOUtv6Pnj7TpteWMBSVsK4ZPKLM8oSDI8hmMPNQ>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1FD568005C;
        Mon,  3 Jun 2019 00:29:01 -0400 (EDT)
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
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/15] dcache: Implement partial shrink via Slab Movable Objects
Date:   Mon,  3 Jun 2019 14:26:35 +1000
Message-Id: <20190603042637.2018-14-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
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

In order to enable SMO a call to kmem_cache_setup_mobility() must be
made, we do this during initialization of the dcache.

Implement isolate and 'migrate' functions for the dentry slab cache.
Enable SMO for the dcache during initialization.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 867d97a86940..3ca721752723 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3072,6 +3072,79 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
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
@@ -3117,6 +3190,8 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
 		return;
-- 
2.21.0

