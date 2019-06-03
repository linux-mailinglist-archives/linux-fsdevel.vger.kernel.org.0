Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 831A332771
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfFCE1n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:27:43 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:47423 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfFCE1n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:27:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5DBEC1384;
        Mon,  3 Jun 2019 00:27:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:27:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TNd3AKi13tITwVLf9iauaAEdzLmpPhHyUVYcM4rMbN8=; b=Vkzc4LYp
        /5xDnTNN+Nfu0iVRlIFqTfQOgB99QvwsXfrfDniMZ9IivTm59qe9tzXVm/U0Q1Y7
        x7532FpV/ROI0VLbaDG0QtoevdcHoH392l23r7jC/XRm6tZhSpoRgaupLHljRTv9
        w2qPO5xy3eFaHe7Lt/zBwuI718BNxvwYSUH1A+XSFL7UTJ6P6ktoPubdnCV+dY1z
        C+10JpvdYVlDyjMXs8JRBte4wT4N3jYIRtatRUrr9yQnk0HJWntBFZ6LEzSdm5nl
        6CNarloB8shWAgZEy/bfhVPYeoHIMG/7npTKdrwQwTfKr+me+xwQi+37rBZavSxQ
        MkjIRNnPGzyW5w==
X-ME-Sender: <xms:vaH0XKnU-B9mjOW-hRjg1oCt1lGwAicyMRrQUOjQdh6Ah_XoFdU7qw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:vaH0XCjQfVQeT9sHTsfwm0mxIuolQQE_bA3e-UF-tOgTOclPKmWLLQ>
    <xmx:vaH0XG1lKt8NxPJEzr7BT1hNP2yOho5Dholg8rMKawEPUmZ9-PoAZA>
    <xmx:vaH0XDJ99nS0S4tqE2ENNj51Cmw7AjzBemCfL26Q3Ct_c3FYwuROrg>
    <xmx:vaH0XC92cyHmCDy7uHvyxawSLAnFUIk5tTmA-Afw7kYfF_xz822TCQ>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3FBAA80061;
        Mon,  3 Jun 2019 00:27:34 -0400 (EDT)
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
Subject: [PATCH 01/15] slub: Add isolate() and migrate() methods
Date:   Mon,  3 Jun 2019 14:26:23 +1000
Message-Id: <20190603042637.2018-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add the two methods needed for moving objects and enable the display of
the callbacks via the /sys/kernel/slab interface.

Add documentation explaining the use of these methods and the prototypes
for slab.h. Add functions to setup the callbacks method for a slab
cache.

Add empty functions for SLAB/SLOB. The API is generic so it could be
theoretically implemented for these allocators as well.

Change sysfs 'ctor' field to be 'ops' to contain all the callback
operations defined for a slab cache.  Display the existing 'ctor'
callback in the ops fields contents along with 'isolate' and 'migrate'
callbacks.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 include/linux/slab.h     | 70 ++++++++++++++++++++++++++++++++++++++++
 include/linux/slub_def.h |  3 ++
 mm/slub.c                | 59 +++++++++++++++++++++++++++++----
 3 files changed, 126 insertions(+), 6 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 9449b19c5f10..886fc130334d 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -154,6 +154,76 @@ void memcg_create_kmem_cache(struct mem_cgroup *, struct kmem_cache *);
 void memcg_deactivate_kmem_caches(struct mem_cgroup *);
 void memcg_destroy_kmem_caches(struct mem_cgroup *);
 
+/*
+ * Function prototypes passed to kmem_cache_setup_mobility() to enable
+ * mobile objects and targeted reclaim in slab caches.
+ */
+
+/**
+ * typedef kmem_cache_isolate_func - Object migration callback function.
+ * @s: The cache we are working on.
+ * @ptr: Pointer to an array of pointers to the objects to isolate.
+ * @nr: Number of objects in @ptr array.
+ *
+ * The purpose of kmem_cache_isolate_func() is to pin each object so that
+ * they cannot be freed until kmem_cache_migrate_func() has processed
+ * them. This may be accomplished by increasing the refcount or setting
+ * a flag.
+ *
+ * The object pointer array passed is also passed to
+ * kmem_cache_migrate_func().  The function may remove objects from the
+ * array by setting pointers to %NULL. This is useful if we can
+ * determine that an object is being freed because
+ * kmem_cache_isolate_func() was called when the subsystem was calling
+ * kmem_cache_free().  In that case it is not necessary to increase the
+ * refcount or specially mark the object because the release of the slab
+ * lock will lead to the immediate freeing of the object.
+ *
+ * Context: Called with locks held so that the slab objects cannot be
+ *          freed.  We are in an atomic context and no slab operations
+ *          may be performed.
+ * Return: A pointer that is passed to the migrate function. If any
+ *         objects cannot be touched at this point then the pointer may
+ *         indicate a failure and then the migration function can simply
+ *         remove the references that were already obtained. The private
+ *         data could be used to track the objects that were already pinned.
+ */
+typedef void *kmem_cache_isolate_func(struct kmem_cache *s, void **ptr, int nr);
+
+/**
+ * typedef kmem_cache_migrate_func - Object migration callback function.
+ * @s: The cache we are working on.
+ * @ptr: Pointer to an array of pointers to the objects to migrate.
+ * @nr: Number of objects in @ptr array.
+ * @node: The NUMA node where the object should be allocated.
+ * @private: The pointer returned by kmem_cache_isolate_func().
+ *
+ * This function is responsible for migrating objects.  Typically, for
+ * each object in the input array you will want to allocate an new
+ * object, copy the original object, update any pointers, and free the
+ * old object.
+ *
+ * After this function returns all pointers to the old object should now
+ * point to the new object.
+ *
+ * Context: Called with no locks held and interrupts enabled.  Sleeping
+ *          is possible.  Any operation may be performed.
+ */
+typedef void kmem_cache_migrate_func(struct kmem_cache *s, void **ptr,
+				     int nr, int node, void *private);
+
+/*
+ * kmem_cache_setup_mobility() is used to setup callbacks for a slab cache.
+ */
+#ifdef CONFIG_SLUB
+void kmem_cache_setup_mobility(struct kmem_cache *, kmem_cache_isolate_func,
+			       kmem_cache_migrate_func);
+#else
+static inline void
+kmem_cache_setup_mobility(struct kmem_cache *s, kmem_cache_isolate_func isolate,
+			  kmem_cache_migrate_func migrate) {}
+#endif
+
 /*
  * Please use this macro to create slab caches. Simply specify the
  * name of the structure and maybe some flags that are listed above.
diff --git a/include/linux/slub_def.h b/include/linux/slub_def.h
index d2153789bd9f..2879a2f5f8eb 100644
--- a/include/linux/slub_def.h
+++ b/include/linux/slub_def.h
@@ -99,6 +99,9 @@ struct kmem_cache {
 	gfp_t allocflags;	/* gfp flags to use on each alloc */
 	int refcount;		/* Refcount for slab cache destroy */
 	void (*ctor)(void *);
+	kmem_cache_isolate_func *isolate;
+	kmem_cache_migrate_func *migrate;
+
 	unsigned int inuse;		/* Offset to metadata */
 	unsigned int align;		/* Alignment */
 	unsigned int red_left_pad;	/* Left redzone padding size */
diff --git a/mm/slub.c b/mm/slub.c
index cd04dbd2b5d0..1c380a2bc78a 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4317,6 +4317,33 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
 	return err;
 }
 
+void kmem_cache_setup_mobility(struct kmem_cache *s,
+			       kmem_cache_isolate_func isolate,
+			       kmem_cache_migrate_func migrate)
+{
+	/*
+	 * Mobile objects must have a ctor otherwise the object may be
+	 * in an undefined state on allocation.  Since the object may
+	 * need to be inspected by the migration function at any time
+	 * after allocation we must ensure that the object always has a
+	 * defined state.
+	 */
+	if (!s->ctor) {
+		pr_err("%s: require constructor to setup mobility\n", s->name);
+		return;
+	}
+
+	s->isolate = isolate;
+	s->migrate = migrate;
+
+	/*
+	 * Sadly serialization requirements currently mean that we have
+	 * to disable fast cmpxchg based processing.
+	 */
+	s->flags &= ~__CMPXCHG_DOUBLE;
+}
+EXPORT_SYMBOL(kmem_cache_setup_mobility);
+
 void *__kmalloc_track_caller(size_t size, gfp_t gfpflags, unsigned long caller)
 {
 	struct kmem_cache *s;
@@ -5001,13 +5028,33 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
 }
 SLAB_ATTR(cpu_partial);
 
-static ssize_t ctor_show(struct kmem_cache *s, char *buf)
+static int op_show(char *buf, const char *txt, unsigned long addr)
 {
-	if (!s->ctor)
-		return 0;
-	return sprintf(buf, "%pS\n", s->ctor);
+	int x = 0;
+
+	x += sprintf(buf, "%s : ", txt);
+	x += sprint_symbol(buf + x, addr);
+	x += sprintf(buf + x, "\n");
+
+	return x;
+}
+
+static ssize_t ops_show(struct kmem_cache *s, char *buf)
+{
+	int x = 0;
+
+	if (s->ctor)
+		x += op_show(buf + x, "ctor", (unsigned long)s->ctor);
+
+	if (s->isolate)
+		x += op_show(buf + x, "isolate", (unsigned long)s->isolate);
+
+	if (s->migrate)
+		x += op_show(buf + x, "migrate", (unsigned long)s->migrate);
+
+	return x;
 }
-SLAB_ATTR_RO(ctor);
+SLAB_ATTR_RO(ops);
 
 static ssize_t aliases_show(struct kmem_cache *s, char *buf)
 {
@@ -5420,7 +5467,7 @@ static struct attribute *slab_attrs[] = {
 	&objects_partial_attr.attr,
 	&partial_attr.attr,
 	&cpu_slabs_attr.attr,
-	&ctor_attr.attr,
+	&ops_attr.attr,
 	&aliases_attr.attr,
 	&align_attr.attr,
 	&hwcache_align_attr.attr,
-- 
2.21.0

