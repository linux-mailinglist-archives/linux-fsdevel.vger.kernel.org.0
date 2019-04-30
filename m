Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0AAEEF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730000AbfD3DIs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:08:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53895 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbfD3DIs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:08:48 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 22555DA1D;
        Mon, 29 Apr 2019 23:08:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:08:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=ToWY0R45y8BHjmAdWxteY+oDuIkdik3lI8PSNGM4h2M=; b=XXcBFbLy
        7CsIB54OmO3t9u36Gqt/SFAsTZ2sSbQXaThBA3qa/du9X8VBd4G2r0OkL+C8Yjqg
        pXOwH9IBjsUEOkTfm+GC+7hImvu/LeaTwLudmHYjWY3KmLukO0hjusWqEsjcgoY2
        7Lq95c8JGCepwOTAIp36JhIFfI7qLU2PVDwR1B0Yh/2zZmjgCDlqIgcYs11R9nwn
        IpZ/X9l/DQysA1F926YMUIbIlgP6fFgSvStvNdAiRXvyNF9w2gxPwXgaI45b/Qn+
        Brg7mr58C6/CUsEXAFasj7ezCLUqIwh+1dIUGjh3Cii8e2LwfbNGOR+GP2spdjh7
        VR3DHONTodgAlw==
X-ME-Sender: <xms:PrzHXH0tKj9_ratHy1B93SvawFkk3RAUcPmv0_HjDXoJWnA4D-JCeA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:PrzHXM8ncYl0Bd3eQyB6YylzltBt1Y5bgyjUHBKv5W04LPbGQFt0sQ>
    <xmx:PrzHXE1uV25KW7X0zrw3jHNIZt7rWlHzfs7mLCIhd1udraYJV5hVsA>
    <xmx:PrzHXJ8uImtQliJEk2xpqH8XHfkzk7ZD-hybYrrHj6rI8FXncZqfJQ>
    <xmx:P7zHXGK01ulm9VwtReRjFUdVVCcuNY0AVRi1uekPRd5ElxGqvXRAvg>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58225103C9;
        Mon, 29 Apr 2019 23:08:39 -0400 (EDT)
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
Subject: [RFC PATCH v4 01/15] slub: Add isolate() and migrate() methods
Date:   Tue, 30 Apr 2019 13:07:32 +1000
Message-Id: <20190430030746.26102-2-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
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

Co-developed-by: Christoph Lameter <cl@linux.com>
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
index d30ede89f4a6..ae44d640b8c1 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4326,6 +4326,33 @@ int __kmem_cache_create(struct kmem_cache *s, slab_flags_t flags)
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
@@ -5010,13 +5037,33 @@ static ssize_t cpu_partial_store(struct kmem_cache *s, const char *buf,
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
@@ -5429,7 +5476,7 @@ static struct attribute *slab_attrs[] = {
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

