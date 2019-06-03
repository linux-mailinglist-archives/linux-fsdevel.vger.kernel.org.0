Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CACDF32786
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfFCE24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:28:56 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39707 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726277AbfFCE24 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:28:56 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id CC8E921F6;
        Mon,  3 Jun 2019 00:28:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=K23AG6kPeiLizgBxJZXoFVpxoNhX/Z2JwBtP24yd/wE=; b=Vd/2ekDx
        gA5d3InCQyT99wEZUUfJWZne58P6Esdwcw/xM133umlva+wJNXyfPoz2p+X2nSVa
        Yg1NhtRjslyxJkbQuZnNryJf81LZ0/0IeWTBoTLYw5wFCWJjxCMxn0tSCUxRdAGr
        LV9ouS97aXG/AD4jJk+jXfnUJEbBuyrDoCTCtbZzniHLECz4yxn0Z3WGdCxF84Qu
        tvKZvBze+IlaeIxYHaQIAoMQcJryg+uHmPf8in7tAINrOw3wKoAOOR8XIrjq1rgC
        fSqDli/Srm+vV15B19D/vuzv48DHAMsyBO2dR83DRPr4s11595yYCh4OR7j1spE/
        4dNpA4sThJ5MLA==
X-ME-Sender: <xms:BqL0XGYqSj1KU9BXwIvMv4DiNyYFPsWPOvXGcst6nohRktv9F8-qiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghi
    nhcuvedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukf
    hppeduvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthho
    sghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:BqL0XH45HmRm8FFH0WKkySpEqbJbDkpCJLMOuYPn8H3kTnWc4iai9g>
    <xmx:BqL0XMfty6pdQULl_ASzMP3JocoaB256yBF_s7u__ACnIML7qIjZsw>
    <xmx:BqL0XCybZJgqBJcH3MyI5RyF2j9rRA6ajc2Tyj_Vb-JtPypSoQPZpg>
    <xmx:BqL0XA5kqc0tCMCkVg2napgTbB4Xmxbn7J3JdjT3qoqQZEKRSc01EQ>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id A2AC780061;
        Mon,  3 Jun 2019 00:28:47 -0400 (EDT)
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
Subject: [PATCH 11/15] tools/testing/slab: Add XArray movable objects tests
Date:   Mon,  3 Jun 2019 14:26:33 +1000
Message-Id: <20190603042637.2018-12-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190603042637.2018-1-tobin@kernel.org>
References: <20190603042637.2018-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We just implemented movable objects for the XArray.  Let's test it
intree.

Add test module for the XArray's movable objects implementation.

Functionality of the XArray Slab Movable Object implementation can
usually be seen by simply by using `slabinfo` on a running machine since
the radix tree is typically in use on a running machine and will have
partial slabs.  For repeated testing we can use the test module to run
to simulate a workload on the XArray then use `slabinfo` to test object
migration is functioning.

If testing on freshly spun up VM (low radix tree workload) it may be
necessary to load/unload the module a number of times to create partial
slabs.

Example test session
--------------------

Relevant /proc/slabinfo column headers:

  name   <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>

Prior to testing slabinfo report for radix_tree_node:

  # slabinfo radix_tree_node --report

  Slabcache: radix_tree_node  Aliases:  0 Order :  2 Objects: 8352
  ** Reclaim accounting active
  ** Defragmentation at 30%

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :     576  Total  :     497   Sanity Checks : On   Total: 8142848
  SlabObj:     912  Full   :     473   Redzoning     : On   Used : 4810752
  SlabSiz:   16384  Partial:      24   Poisoning     : On   Loss : 3332096
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig: 2806272
  Align  :       8  Objects:      17   Tracing       : Off  Lpadd:  437360

Here you can see the kernel was built with Slab Movable Objects enabled
for the XArray (XArray uses the radix tree below the surface).

After inserting the test module (note we have triggered allocation of a
number of radix tree nodes increasing the object count but decreasing the
number of partial slabs):

  # slabinfo radix_tree_node --report

  Slabcache: radix_tree_node  Aliases:  0 Order :  2 Objects: 8442
  ** Reclaim accounting active
  ** Defragmentation at 30%

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :     576  Total  :     499   Sanity Checks : On   Total: 8175616
  SlabObj:     912  Full   :     484   Redzoning     : On   Used : 4862592
  SlabSiz:   16384  Partial:      15   Poisoning     : On   Loss : 3313024
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig: 2836512
  Align  :       8  Objects:      17   Tracing       : Off  Lpadd:  439120

Now we can shrink the radix_tree_node cache:

  # slabinfo radix_tree_node --shrink
  # slabinfo radix_tree_node --report

  Slabcache: radix_tree_node  Aliases:  0 Order :  2 Objects: 8515
  ** Reclaim accounting active
  ** Defragmentation at 30%

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :     576  Total  :     501   Sanity Checks : On   Total: 8208384
  SlabObj:     912  Full   :     500   Redzoning     : On   Used : 4904640
  SlabSiz:   16384  Partial:       1   Poisoning     : On   Loss : 3303744
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig: 2861040
  Align  :       8  Objects:      17   Tracing       : Off  Lpadd:  440880

Note the single remaining partial slab.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/testing/slab/Makefile             |   2 +-
 tools/testing/slab/slub_defrag_xarray.c | 211 ++++++++++++++++++++++++
 2 files changed, 212 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

diff --git a/tools/testing/slab/Makefile b/tools/testing/slab/Makefile
index 440c2e3e356f..44c18d9a4d52 100644
--- a/tools/testing/slab/Makefile
+++ b/tools/testing/slab/Makefile
@@ -1,4 +1,4 @@
-obj-m += slub_defrag.o
+obj-m += slub_defrag.o slub_defrag_xarray.o
 
 KTREE=../../..
 
diff --git a/tools/testing/slab/slub_defrag_xarray.c b/tools/testing/slab/slub_defrag_xarray.c
new file mode 100644
index 000000000000..41143f73256c
--- /dev/null
+++ b/tools/testing/slab/slub_defrag_xarray.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/list.h>
+#include <linux/gfp.h>
+#include <linux/xarray.h>
+
+#define SMOX_CACHE_NAME "smox_test"
+static struct kmem_cache *cachep;
+
+/*
+ * Declare XArrays globally so we can clean them up on module unload.
+ */
+
+/* Used by test_smo_xarray()*/
+DEFINE_XARRAY(things);
+
+/* Thing to store pointers to in the XArray */
+struct smox_thing {
+	long id;
+};
+
+/* It's up to the caller to ensure id is unique */
+static struct smox_thing *alloc_thing(int id)
+{
+	struct smox_thing *thing;
+
+	thing = kmem_cache_alloc(cachep, GFP_KERNEL);
+	if (!thing)
+		return ERR_PTR(-ENOMEM);
+
+	thing->id = id;
+	return thing;
+}
+
+/**
+ * smox_object_ctor() - SMO object constructor function.
+ * @ptr: Pointer to memory where the object should be constructed.
+ */
+void smox_object_ctor(void *ptr)
+{
+	struct smox_thing *thing = ptr;
+
+	thing->id = -1;
+}
+
+/**
+ * smox_cache_migrate() - kmem_cache migrate function.
+ * @cp: kmem_cache pointer.
+ * @objs: Array of pointers to objects to migrate.
+ * @size: Number of objects in @objs.
+ * @node: NUMA node where the object should be allocated.
+ * @private: Pointer returned by kmem_cache_isolate_func().
+ */
+void smox_cache_migrate(struct kmem_cache *cp, void **objs, int size,
+			int node, void *private)
+{
+	struct smox_thing **ptrs = (struct smox_thing **)objs;
+	struct smox_thing *old, *new;
+	struct smox_thing *thing;
+	unsigned long index;
+	void *entry;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		old = ptrs[i];
+
+		new = kmem_cache_alloc(cachep, GFP_KERNEL);
+		if (!new) {
+			pr_debug("kmem_cache_alloc failed\n");
+			return;
+		}
+
+		new->id = old->id;
+
+		/* Update reference the brain dead way */
+		xa_for_each(&things, index, thing) {
+			if (thing == old) {
+				entry = xa_store(&things, index, new, GFP_KERNEL);
+				if (entry != old) {
+					pr_err("failed to exchange new/old\n");
+					return;
+				}
+			}
+		}
+		kmem_cache_free(cachep, old);
+	}
+}
+
+/*
+ * test_smo_xarray() - Run some tests using an XArray.
+ */
+static int test_smo_xarray(void)
+{
+	const int keep = 6; /* Free 5 out of 6 items */
+	const int nr_items = 10000;
+	struct smox_thing *thing;
+	unsigned long index;
+	void *entry;
+	int expected;
+	int i;
+
+	/*
+	 * Populate XArray, this adds to the radix_tree_node cache as
+	 * well as the smox_test cache.
+	 */
+	for (i = 0; i < nr_items; i++) {
+		thing = alloc_thing(i);
+		entry = xa_store(&things, i, thing, GFP_KERNEL);
+		if (xa_is_err(entry)) {
+			pr_err("smox: failed to allocate entry: %d\n", i);
+			return -ENOMEM;
+		}
+	}
+
+	/* Now free  items, putting holes in both caches. */
+	for (i = 0; i < nr_items; i++) {
+		if (i % keep == 0)
+			continue;
+
+		thing = xa_erase(&things, i);
+		if (xa_is_err(thing))
+			pr_err("smox: error erasing entry: %d\n", i);
+		kmem_cache_free(cachep, thing);
+	}
+
+	expected = 0;
+	xa_for_each(&things, index, thing) {
+		if (thing->id != expected || index != expected) {
+			pr_err("smox: error; got %ld want %d at %ld\n",
+			       thing->id, expected, index);
+			return -1;
+		}
+		expected += keep;
+	}
+
+	/*
+	 * Leave caches sparsely allocated.  Shrink caches manually with:
+	 *
+	 *   slabinfo radix_tree_node --shrink
+	 *   slabinfo smox_test --shrink
+	 */
+
+	return 0;
+}
+
+static int __init smox_cache_init(void)
+{
+	cachep = kmem_cache_create(SMOX_CACHE_NAME,
+				   sizeof(struct smox_thing),
+				   0, 0, smox_object_ctor);
+	if (!cachep)
+		return -1;
+
+	return 0;
+}
+
+static void __exit smox_cache_cleanup(void)
+{
+	struct smox_thing *thing;
+	unsigned long i;
+
+	xa_for_each(&things, i, thing) {
+		kmem_cache_free(cachep, thing);
+	}
+	xa_destroy(&things);
+	kmem_cache_destroy(cachep);
+}
+
+static int __init smox_init(void)
+{
+	int ret;
+
+	ret = smox_cache_init();
+	if (ret) {
+		pr_err("smo_xarray: failed to create cache\n");
+		return ret;
+	}
+	pr_info("smo_xarray: created kmem_cache: %s\n", SMOX_CACHE_NAME);
+
+	kmem_cache_setup_mobility(cachep, NULL, smox_cache_migrate);
+	pr_info("smo_xarray: kmem_cache %s defrag enabled\n", SMOX_CACHE_NAME);
+
+	/*
+	 * Running this test consumes memory unless you shrink the
+	 * radix_tree_node cache manually with `slabinfo`.
+	 */
+	ret = test_smo_xarray();
+	if (ret)
+		pr_warn("test_smo_xarray failed: %d\n", ret);
+
+	pr_info("smo_xarray: module loaded successfully\n");
+	return 0;
+}
+module_init(smox_init);
+
+static void __exit smox_exit(void)
+{
+	smox_cache_cleanup();
+
+	pr_info("smo_xarray: module removed\n");
+}
+module_exit(smox_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobin C. Harding");
+MODULE_DESCRIPTION("SMO XArray test module.");
-- 
2.21.0

