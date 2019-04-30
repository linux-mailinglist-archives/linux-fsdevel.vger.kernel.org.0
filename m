Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004C3EF06
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbfD3DJk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:09:40 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53017 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730090AbfD3DJj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:09:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 33AD06758;
        Mon, 29 Apr 2019 23:09:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=r+9QuCXW7/td+AqWATFlgqfuY4wjDJcwrAnptYZPsCY=; b=u429WcMU
        mXINl+wHr1/9u31BzBnEWPLbjPYZU8JXztnGxSlrBhAwBVx78Ws8ynJIs+ImPem4
        1cv0daSGYBST6C6UkgwoBMOm7Ll8kKfbg6itM+GEBSv5Qz5DXiSR0J9Jc9dl3kWE
        Dmvx5kQXR+Hz9ndLdD4XMz9Qe9E+tEs6RZzHsIHt5nP2PQ1T0aDzu0Fwhy4XiGEv
        8xpYVhLfnIyYYvUiwfyjTJz4RTUIvRPHq1NouOlH//phVQFk7QjgCGMxRGsVtvuK
        yaewJlPRajmm+966r/NtMy31n4zJPEoE5NEgNhA0pEufEXiXgIoNbyGFqI3tmck2
        7IA/VS6evxG45A==
X-ME-Sender: <xms:cLzHXF0UxKLy-umq8laDZv1xas1L2hng8dnEtT-bQNkfeaL20CLgdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeei
X-ME-Proxy: <xmx:cLzHXOU9UuJR7G4SHgNWJ3cb-9UYny00PDutnBTDJIdzyzvfTjNv8A>
    <xmx:cLzHXIL0_9CDES32Jr7uE46F4c_GoB7b0JHJjsKxLquCaJaQ5TH1wg>
    <xmx:cLzHXI1VL6XvoAF7c-r3rCpMpepsphpalWKOkb4sqSyKSHbZHFsY7A>
    <xmx:cbzHXFqLYvGMz9IM5TFe8NDcdIicSWVQSTTXdFBV6rqaMXCqQvBf3Q>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id 24E7C103CA;
        Mon, 29 Apr 2019 23:09:28 -0400 (EDT)
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
Subject: [RFC PATCH v4 07/15] tools/testing/slab: Add object migration test module
Date:   Tue, 30 Apr 2019 13:07:38 +1000
Message-Id: <20190430030746.26102-8-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We just implemented slab movable objects for the SLUB allocator.  We
should test that code.  In order to do so we need to be able to do a
number of things

 - Create a cache
 - Enable Slab Movable Objects for the cache
 - Allocate objects to the cache
 - Free objects from within specific slabs of the cache

We can do all this via a loadable module.

Add a module that defines functions that can be triggered from userspace
via a debugfs entry. From the source:

  /*
   * SLUB defragmentation a.k.a. Slab Movable Objects (SMO).
   *
   * This module is used for testing the SLUB allocator.  Enables
   * userspace to run kernel functions via a debugfs file.
   *
   *   debugfs: /sys/kernel/debugfs/smo/callfn (write only)
   *
   * String written to `callfn` is parsed by the module and associated
   * function is called.  See fn_tab for mapping of strings to functions.
   */

References to allocated objects are kept by the module in a linked list
so that userspace can control which object to free.

We introduce the following four functions via the function table

  "enable": Enables object migration for the test cache.
  "alloc X": Allocates X objects
  "free X [Y]": Frees X objects starting at list position Y (default Y==0)
  "test": Runs [stress] tests from within the module (see below).

       {"enable", smo_enable_cache_mobility},
       {"alloc", smo_alloc_objects},
       {"free", smo_free_object},
       {"test", smo_run_module_tests},

Freeing from the start of the list creates a hole in the slab being
freed from (i.e. creates a partial slab).  The results of running these
commands can be see using `slabinfo` (available in tools/vm/):

	make -o slabinfo tools/vm/slabinfo.c

Stress tests can be run from within the module.  These tests are
internal to the module because we verify that object references are
still good after object migration.  These are called 'stress' tests
because it is intended that they create/free a lot of objects.
Userspace can control the number of objects to create, default is 1000.

Example test session
--------------------

Relevant /proc/slabinfo column headers:

  name   <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab>

  # mount -t debugfs none /sys/kernel/debug/
  $ cd path/to/linux/tools/testing/slab; make
  ...

  # insmod slub_defrag.ko
  # cat /proc/slabinfo | grep smo_test | sed 's/:.*//'
  smo_test               0      0    392   20    2

From this we can see that the module created cache 'smo_test' with 20
objects per slab and 2 pages per slab (and cache is currently empty).

We can play with the slab allocator manually:

  # insmod slub_defrag.ko
  # echo 'alloc 21' > callfn
  # cat /proc/slabinfo | grep smo_test | sed 's/:.*//'
  smo_test              21     40    392   20    2

We see here that 21 active objects have been allocated creating 2
slabs (40 total objects).

  # slabinfo smo_test --report

  Slabcache: smo_test         Aliases:  0 Order :  1 Objects: 21

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :      56  Total  :       2   Sanity Checks : On   Total:   16384
  SlabObj:     392  Full   :       1   Redzoning     : On   Used :    1176
  SlabSiz:    8192  Partial:       1   Poisoning     : On   Loss :   15208
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig:    7056
  Align  :       8  Objects:      20   Tracing       : Off  Lpadd:     704

Now free an object from the first slot of the first slab

  # echo 'free 1' > callfn
  # cat /proc/slabinfo | grep smo_test | sed 's/:.*//'
  smo_test              20     40    392   20    2

  # slabinfo smo_test --report

  Slabcache: smo_test         Aliases:  0 Order :  1 Objects: 20

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :      56  Total  :       2   Sanity Checks : On   Total:   16384
  SlabObj:     392  Full   :       0   Redzoning     : On   Used :    1120
  SlabSiz:    8192  Partial:       2   Poisoning     : On   Loss :   15264
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig:    6720
  Align  :       8  Objects:      20   Tracing       : Off  Lpadd:     704

Calling shrink now on the cache does nothing because object migration is
not enabled (output omitted).  If we enable object migration then shrink
the cache we expect the object from the second slab to me moved to the
first slot in the first slab and the second slab to be removed from the
partial list.

  # echo 'enable' > callfn
  # slabinfo smo_test --shrink
  # slabinfo smo_test --report

  Slabcache: smo_test         Aliases:  0 Order :  1 Objects: 20
  ** Defragmentation at 30%

  Sizes (bytes)     Slabs              Debug                Memory
  ------------------------------------------------------------------------
  Object :      56  Total  :       1   Sanity Checks : On   Total:    8192
  SlabObj:     392  Full   :       1   Redzoning     : On   Used :    1120
  SlabSiz:    8192  Partial:       0   Poisoning     : On   Loss :    7072
  Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig:    6720
  Align  :       8  Objects:      20   Tracing       : Off  Lpadd:     352

We can run the stress tests (with the default number of objects):

  # cd /sys/kernel/debug/smo
  # echo 'test' > callfn
  [    3.576617] smo: test using nr_objs: 1000 keep: 10
  [    3.580169] smo: Module tests completed successfully

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 tools/testing/slab/Makefile      |  10 +
 tools/testing/slab/slub_defrag.c | 566 +++++++++++++++++++++++++++++++
 2 files changed, 576 insertions(+)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c

diff --git a/tools/testing/slab/Makefile b/tools/testing/slab/Makefile
new file mode 100644
index 000000000000..440c2e3e356f
--- /dev/null
+++ b/tools/testing/slab/Makefile
@@ -0,0 +1,10 @@
+obj-m += slub_defrag.o
+
+KTREE=../../..
+
+all:
+	make -C ${KTREE} M=$(PWD) modules
+
+clean:
+	make -C ${KTREE} M=$(PWD) clean
+
diff --git a/tools/testing/slab/slub_defrag.c b/tools/testing/slab/slub_defrag.c
new file mode 100644
index 000000000000..4a5c24394b96
--- /dev/null
+++ b/tools/testing/slab/slub_defrag.c
@@ -0,0 +1,566 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <linux/list.h>
+#include <linux/gfp.h>
+#include <linux/debugfs.h>
+#include <linux/numa.h>
+
+/*
+ * SLUB defragmentation a.k.a. Slab Movable Objects (SMO).
+ *
+ * This module is used for testing the SLUB allocator.  Enables
+ * userspace to run kernel functions via a debugfs file.
+ *
+ *   debugfs: /sys/kernel/debugfs/smo/callfn (write only)
+ *
+ * String written to `callfn` is parsed by the module and associated
+ * function is called.  See fn_tab for mapping of strings to functions.
+ */
+
+/* debugfs commands accept two optional arguments */
+#define SMO_CMD_DEFAUT_ARG -1
+
+#define SMO_DEBUGFS_DIR "smo"
+struct dentry *smo_debugfs_root;
+
+#define SMO_CACHE_NAME "smo_test"
+static struct kmem_cache *cachep;
+
+struct smo_slub_object {
+	struct list_head list;
+	char buf[32];		/* Unused except to control size of object */
+	long id;
+};
+
+/* Our list of allocated objects */
+LIST_HEAD(objects);
+
+static void list_add_to_objects(struct smo_slub_object *so)
+{
+	/*
+	 * We free from the front of the list so store at the
+	 * tail in order to put holes in the cache when we free.
+	 */
+	list_add_tail(&so->list, &objects);
+}
+
+/**
+ * smo_object_ctor() - SMO object constructor function.
+ * @ptr: Pointer to memory where the object should be constructed.
+ */
+void smo_object_ctor(void *ptr)
+{
+	struct smo_slub_object *so = ptr;
+
+	INIT_LIST_HEAD(&so->list);
+	memset(so->buf, 0, sizeof(so->buf));
+	so->id = -1;
+}
+
+/**
+ * smo_cache_migrate() - kmem_cache migrate function.
+ * @cp: kmem_cache pointer.
+ * @objs: Array of pointers to objects to migrate.
+ * @size: Number of objects in @objs.
+ * @node: NUMA node where the object should be allocated.
+ * @private: Pointer returned by kmem_cache_isolate_func().
+ */
+void smo_cache_migrate(struct kmem_cache *cp, void **objs, int size,
+		       int node, void *private)
+{
+	struct smo_slub_object **so_objs = (struct smo_slub_object **)objs;
+	struct smo_slub_object *so_old, *so_new;
+	int i;
+
+	for (i = 0; i < size; i++) {
+		so_old = so_objs[i];
+
+		so_new = kmem_cache_alloc_node(cachep, GFP_KERNEL, node);
+		if (!so_new) {
+			pr_debug("kmem_cache_alloc failed\n");
+			return;
+		}
+
+		/* Copy object */
+		so_new->id = so_old->id;
+
+		/* Update references to old object */
+		list_del(&so_old->list);
+		list_add_to_objects(so_new);
+
+		kmem_cache_free(cachep, so_old);
+	}
+}
+
+static int smo_enable_cache_mobility(int _unused, int __unused)
+{
+	/* Enable movable objects: BOOM! */
+	kmem_cache_setup_mobility(cachep, NULL, smo_cache_migrate);
+	pr_info("smo: kmem_cache %s defrag enabled\n", SMO_CACHE_NAME);
+	return 0;
+}
+
+/*
+ * smo_alloc_objects() - Allocate objects and store reference.
+ * @nr_objs: Number of objects to allocate.
+ * @node: NUMA node to allocate objects on.
+ *
+ * Allocates @n smo_slub_objects.  Stores a reference to them in
+ * the global list of objects (at the tail of the list).
+ *
+ * Return: The number of objects allocated.
+ */
+static int smo_alloc_objects(int nr_objs, int node)
+{
+	struct smo_slub_object *so;
+	int i;
+
+	/* Set sane parameters if no args passed in */
+	if (nr_objs == SMO_CMD_DEFAUT_ARG)
+		nr_objs = 1;
+	if (node == SMO_CMD_DEFAUT_ARG)
+		node = NUMA_NO_NODE;
+
+	for (i = 0; i < nr_objs; i++) {
+		if (node == NUMA_NO_NODE)
+			so = kmem_cache_alloc(cachep, GFP_KERNEL);
+		else
+			so = kmem_cache_alloc_node(cachep, GFP_KERNEL, node);
+		if (!so) {
+			pr_err("smo: Failed to alloc object %d of %d\n", i, nr_objs);
+			return i;
+		}
+		list_add_to_objects(so);
+	}
+	return nr_objs;
+}
+
+/*
+ * smo_free_object() - Frees n objects from position.
+ * @nr_objs: Number of objects to free.
+ * @pos: Position in global list to start freeing.
+ *
+ * Iterates over the global list of objects to position @pos then frees @n
+ * objects from there (or to end of list).  Does nothing if @n > list length.
+ *
+ * Calling with @n==0 frees all objects starting at @pos.
+ *
+ * Return: Number of objects freed.
+ */
+static int smo_free_object(int nr_objs, int pos)
+{
+	struct smo_slub_object *cur, *tmp;
+	int deleted = 0;
+	int i = 0;
+
+	/* Set sane parameters if no args passed in */
+	if (nr_objs == SMO_CMD_DEFAUT_ARG)
+		nr_objs = 1;
+	if (pos == SMO_CMD_DEFAUT_ARG)
+		pos = 0;
+
+	list_for_each_entry_safe(cur, tmp, &objects, list) {
+		if (i < pos) {
+			i++;
+			continue;
+		}
+
+		list_del(&cur->list);
+		kmem_cache_free(cachep, cur);
+		deleted++;
+		if (deleted == nr_objs)
+			break;
+	}
+	return deleted;
+}
+
+static int index_for_expected_id(long *expected, int size, long id)
+{
+	int i;
+
+	/* Array is unsorted, just iterate the whole thing */
+	for (i = 0; i < size; i++) {
+		if (expected[i] == id)
+			return i;
+	}
+	return -1;		/* Not found */
+}
+
+static int assert_have_objects(int nr_objs, int keep)
+{
+	struct smo_slub_object *cur;
+	long *expected;		/* Array of expected IDs */
+	int nr_ids;		/* Length of array */
+	long id;
+	int index, i;
+
+	nr_ids = nr_objs / keep + 1;
+
+	expected = kmalloc_array(nr_ids, sizeof(long), GFP_KERNEL);
+	if (!expected)
+		return -ENOMEM;
+
+	id = 0;
+	for (i = 0; i < nr_ids; i++) {
+		expected[i] = id;
+		id += keep;
+	}
+
+	list_for_each_entry(cur, &objects, list) {
+		index = index_for_expected_id(expected, nr_ids, cur->id);
+		if (index < 0) {
+			pr_err("smo: ID not found: %ld\n", cur->id);
+			return -1;
+		}
+
+		if (expected[index] == -1) {
+			pr_err("smo: ID already encountered: %ld\n", cur->id);
+			return -1;
+		}
+		expected[index] = -1;
+	}
+	return 0;
+}
+
+/*
+ * smo_run_module_tests() - Runs unit tests from within the module
+ * @nr_objs: Number of objects to allocate.
+ * @keep: Free all but 1 in @keep objects.
+ *
+ * Allocates @nr_objects then iterates over the allocated objects
+ * freeing all but 1 out of every @keep objects i.e. for @keep==10
+ * keeps the first object then frees the next 9.
+ *
+ * Caller is responsible for ensuring that the cache has at most a
+ * single slab on the partial list without any objects in it.  This is
+ * easy enough to ensure, just call this when the module is freshly
+ * loaded.
+ */
+static int smo_run_module_tests(int nr_objs, int keep)
+{
+	struct smo_slub_object *so;
+	struct smo_slub_object *cur, *tmp;
+	long i;
+
+	if (!list_empty(&objects)) {
+		pr_err("smo: test requires clean module state\n");
+		return -1;
+	}
+
+	/* Set sane parameters if no args passed in */
+	if (nr_objs == SMO_CMD_DEFAUT_ARG)
+		nr_objs = 1000;
+	if (keep == SMO_CMD_DEFAUT_ARG)
+		keep = 10;
+
+	pr_info("smo: test using nr_objs: %d keep: %d\n", nr_objs, keep);
+
+	/* Perhaps we got called like this 'test 1000' */
+	if (keep == 0) {
+		pr_err("Usage: test <nr_objs> <keep>\n");
+		return -1;
+	}
+
+	/* Test constructor */
+	so = kmem_cache_alloc(cachep, GFP_KERNEL);
+	if (!so) {
+		pr_err("smo: Failed to alloc object\n");
+		return -1;
+	}
+	if (so->id != -1) {
+		pr_err("smo: Initial state incorrect");
+		return -1;
+	}
+	kmem_cache_free(cachep, so);
+
+	/*
+	 * Test that object migration is correctly implemented by module
+	 *
+	 * This gives us confidence that if new code correctly enables
+	 * object migration (via correct implementation of migrate and
+	 * isolate functions) then the slub allocator code that does
+	 * object migration is correct.
+	 */
+
+	for (i = 0; i < nr_objs; i++) {
+		so = kmem_cache_alloc(cachep, GFP_KERNEL);
+		if (!so) {
+			pr_err("smo: Failed to alloc object %ld of %d\n",
+			       i, nr_objs);
+			return -1;
+		}
+		so->id = (long)i;
+		list_add_to_objects(so);
+	}
+
+	assert_have_objects(nr_objs, 1);
+
+	i = 0;
+	list_for_each_entry_safe(cur, tmp, &objects, list) {
+		if (i++ % keep == 0)
+			continue;
+
+		list_del(&cur->list);
+		kmem_cache_free(cachep, cur);
+	}
+
+	/* Verify shrink does nothing when migration is not enabled */
+	kmem_cache_shrink(cachep);
+	assert_have_objects(nr_objs, 1);
+
+	/* Now test shrink */
+	kmem_cache_setup_mobility(cachep, NULL, smo_cache_migrate);
+	kmem_cache_shrink(cachep);
+	/*
+	 * Because of how migrate function deletes and adds objects to
+	 * the objects list we have no way of knowing the order.  We
+	 * want to confirm that we have all the objects after shrink
+	 * that we had before we did the shrink.
+	 */
+	assert_have_objects(nr_objs, keep);
+
+	/* cleanup */
+	list_for_each_entry_safe(cur, tmp, &objects, list) {
+		list_del(&cur->list);
+		kmem_cache_free(cachep, cur);
+	}
+	kmem_cache_shrink(cachep); /* Remove empty slabs from partial list */
+
+	pr_info("smo: Module tests completed successfully\n");
+	return 0;
+}
+
+/*
+ * struct functions() - Map command to a function pointer.
+ */
+struct functions {
+	char *fn_name;
+	int (*fn_ptr)(int arg0, int arg1);
+} fn_tab[] = {
+	/*
+	 * Because of the way we parse the function table no command
+	 * may have another command as its prefix.
+	 *  i.e. this will break: 'foo'  and 'foobar'
+	 */
+	{"enable", smo_enable_cache_mobility},
+	{"alloc", smo_alloc_objects},
+	{"free", smo_free_object},
+	{"test", smo_run_module_tests},
+};
+
+#define FN_TAB_SIZE (sizeof(fn_tab) / sizeof(struct functions))
+
+/*
+ * parse_cmd_buf() - Gets command and arguments command string.
+ * @buf: Buffer containing the command string.
+ * @cmd: Out parameter, pointer to the command.
+ * @arg1: Out parameter, stores the first argument.
+ * @arg2: Out parameter, stores the second argument.
+ *
+ * Parses and tokenizes the input command buffer. Stores a pointer to the
+ * command (start of @buf) in @cmd.  Stores the converted long values for
+ * argument 1 and 2 in the respective out parameters @arg1 and @arg2.
+ *
+ * Since arguments are optional, if they are not found the default values are
+ * returned.  In order for the caller to differentiate defaults from arguments
+ * of the same value the number of arguments parsed is returned.
+ *
+ * Return: Number of arguments found.
+ */
+static int parse_cmd_buf(char *buf, char **cmd, long *arg1, long *arg2)
+{
+	int found;
+	char *ptr;
+	int ret;
+
+	*arg1 = SMO_CMD_DEFAUT_ARG;
+	*arg2 = SMO_CMD_DEFAUT_ARG;
+	found = 0;
+
+	/* Jump over the command, check if there are any args */
+	ptr = strsep(&buf, " ");
+	if (!ptr || !buf)
+		return found;
+
+	ptr = strsep(&buf, " ");
+	ret = kstrtol(ptr, 10, arg1);
+	if (ret < 0) {
+		pr_err("failed to convert arg, defaulting to %d. (%s)\n",
+		       SMO_CMD_DEFAUT_ARG, ptr);
+		return found;
+	}
+	found++;
+	if (!buf)		/* No second arg */
+		return found;
+
+	ptr = strsep(&buf, " ");
+	ret = kstrtol(ptr, 10, arg2);
+	if (ret < 0) {
+		pr_err("failed to convert arg, defaulting to %d. (%s)\n",
+		       SMO_CMD_DEFAUT_ARG, ptr);
+		return found;
+	}
+	found++;
+
+	return found;
+}
+
+/*
+ * call_function() - Calls the function described by str.
+ * @str: '<cmd> [<arg>]'
+ *
+ * Does table lookup on <cmd>, calls appropriate function passing
+ * <arg> as a the argument.  Optional arg defaults to 1.
+ */
+static void call_function(char *str)
+{
+	char *cmd;
+	long arg1 = 0;
+	long arg2 = 0;
+	int i;
+
+	if (!str)
+		return;
+
+	(void)parse_cmd_buf(str, &cmd, &arg1, &arg2);
+
+	for (i = 0; i < FN_TAB_SIZE; i++) {
+		char *fn_name = fn_tab[i].fn_name;
+
+		if (strcmp(fn_name, str) == 0) {
+			fn_tab[i].fn_ptr(arg1, arg2);
+			return;	/* All done */
+		}
+	}
+
+	pr_err("failed to call function for cmd: %s\n", str);
+}
+
+/*
+ * smo_callfn_debugfs_write() - debugfs write function.
+ * @file: User file
+ * @user_buf: Userspace buffer
+ * @len: Length of the user space buffer
+ * @off: Offset within the file
+ *
+ * Used for triggering functions by writing command to debugfs file.
+ *
+ *   echo '<cmd> <arg>'  > /sys/kernel/debug/smo/callfn
+ *
+ * Return: Number of bytes copied if request succeeds,
+ *	   the corresponding error code otherwise.
+ */
+static ssize_t smo_callfn_debugfs_write(struct file *file,
+					const char __user *ubuf,
+					size_t len,
+					loff_t *off)
+{
+	char *kbuf;
+	int nbytes = 0;
+
+	if (*off != 0 || len == 0)
+		return -EINVAL;
+
+	kbuf = kzalloc(len, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	nbytes = strncpy_from_user(kbuf, ubuf, len);
+	if (nbytes < 0)
+		goto out;
+
+	if (kbuf[nbytes - 1] == '\n')
+		kbuf[nbytes - 1] = '\0';
+
+	call_function(kbuf);	/* Tokenizes kbuf */
+out:
+	kfree(kbuf);
+	return nbytes;
+}
+
+const struct file_operations fops_callfn_debugfs = {
+	.owner = THIS_MODULE,
+	.write = smo_callfn_debugfs_write,
+};
+
+static int __init smo_debugfs_init(void)
+{
+	struct dentry *d;
+
+	smo_debugfs_root = debugfs_create_dir(SMO_DEBUGFS_DIR, NULL);
+	d = debugfs_create_file("callfn", 0200, smo_debugfs_root, NULL,
+				&fops_callfn_debugfs);
+	if (IS_ERR(d))
+		return PTR_ERR(d);
+
+	return 0;
+}
+
+static void __exit smo_debugfs_cleanup(void)
+{
+	debugfs_remove_recursive(smo_debugfs_root);
+}
+
+static int __init smo_cache_init(void)
+{
+	cachep = kmem_cache_create(SMO_CACHE_NAME,
+				   sizeof(struct smo_slub_object),
+				   0, 0, smo_object_ctor);
+	if (!cachep)
+		return -1;
+
+	return 0;
+}
+
+static void __exit smo_cache_cleanup(void)
+{
+	struct smo_slub_object *cur, *tmp;
+
+	list_for_each_entry_safe(cur, tmp, &objects, list) {
+		list_del(&cur->list);
+		kmem_cache_free(cachep, cur);
+	}
+	kmem_cache_destroy(cachep);
+}
+
+static int __init smo_init(void)
+{
+	int ret;
+
+	ret = smo_cache_init();
+	if (ret) {
+		pr_err("smo: Failed to create cache\n");
+		return ret;
+	}
+	pr_info("smo: Created kmem_cache: %s\n", SMO_CACHE_NAME);
+
+	ret = smo_debugfs_init();
+	if (ret) {
+		pr_err("smo: Failed to init debugfs\n");
+		return ret;
+	}
+	pr_info("smo: Created debugfs directory: /sys/kernel/debugfs/%s\n",
+		SMO_DEBUGFS_DIR);
+
+	pr_info("smo: Test module loaded\n");
+	return 0;
+}
+module_init(smo_init);
+
+static void __exit smo_exit(void)
+{
+	smo_debugfs_cleanup();
+	smo_cache_cleanup();
+
+	pr_info("smo: Test module removed\n");
+}
+module_exit(smo_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Tobin C. Harding");
+MODULE_DESCRIPTION("SLUB Movable Objects test module.");
-- 
2.21.0

