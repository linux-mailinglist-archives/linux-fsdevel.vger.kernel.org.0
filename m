Return-Path: <linux-fsdevel+bounces-32317-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A159A35CA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 575841F26253
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295D0190072;
	Fri, 18 Oct 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hFERH1ny"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A6418E374;
	Fri, 18 Oct 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729233671; cv=none; b=hFQvr8Vxy6iioCu7zf2qwmTrs1mDbq+e/BrCLEk+Qk0LBnEfCPiofAEMQhhuYJTzc+OdyXnnYp9ElHAdhYlRcu2y9BxdBEMoZJQWPToQyUoZyM8fM7eraT/NsTDza5o1e88dG8lSmlegfKto4NLYmAzJ34ts01jIMeZ53Wof+l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729233671; c=relaxed/simple;
	bh=nJkwHZhq8LUwIQWuM4nmuZlPd/LXd0bS1ate2IE2Ous=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gKMdNYE+/OkO/6z4HLpYHBlTiWo3Y9N47VOrig0UUjRP1g5lyFskC8dutkkWuitYZqjkwbXLP+EizD/AkEVTuHf2HR6EIRYCyjSqnC+DDzrgfxjs9oC7tvKsYaILr2w6ivkWmJ9+ygIsEbeiTrTKZ2RoLnquTEab4inv4ql0UAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hFERH1ny; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729233669; x=1760769669;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nJkwHZhq8LUwIQWuM4nmuZlPd/LXd0bS1ate2IE2Ous=;
  b=hFERH1nytrnRvnVYQe4XmAdAuBfsA/3dFcbEZxqbjFTjSBUPZutq5vgv
   F6tdahWm5ExlYbYpW5UoWMH+Zo7NV74aP4SpX9uOAv4hierb20MQMLUKW
   7Kf4bdpMr4vqXWpwQno4t/b/p+NkUAt2UBLAoB3Z3KvpCMBbuvi4dTAa/
   2CwEOZA2Ae5SnFeCio2IwZtVURSkSc9KeiOE9eqckmwv2zlnbY1nGcxZg
   g6eYCi5nl9bHzx9Ks4RUWOKyrtPgQoce1I334+3vYrbJYg8vXD9Es0Aqm
   GiNBCXNrUhPYyjTAe5Muur30s480Z1YwhayR8whC5KZyfN+S+aGyZCJo2
   Q==;
X-CSE-ConnectionGUID: O64J6kZBTsG1AYXLS8QsDw==
X-CSE-MsgGUID: 1gZknamyTUaaV4jT8HztTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11228"; a="28884886"
X-IronPort-AV: E=Sophos;i="6.11,212,1725346800"; 
   d="scan'208";a="28884886"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 23:41:03 -0700
X-CSE-ConnectionGUID: zewXamuiRemTPufLHe37/A==
X-CSE-MsgGUID: j/tcH1zEQrytip/oRjhc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="83607519"
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.6])
  by orviesa003.jf.intel.com with ESMTP; 17 Oct 2024 23:41:03 -0700
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	zanussi@kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	mcgrof@kernel.org,
	kees@kernel.org,
	joel.granados@kernel.org,
	bfoster@redhat.com,
	willy@infradead.org,
	linux-fsdevel@vger.kernel.org
Cc: wajdi.k.feghali@intel.com,
	vinodh.gopal@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [RFC PATCH v1 08/13] crypto: iaa - Distribute compress jobs to all IAA devices on a NUMA node.
Date: Thu, 17 Oct 2024 23:40:56 -0700
Message-Id: <20241018064101.336232-9-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
References: <20241018064101.336232-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change enables processes running on any logical core on a NUMA node to
use all the IAA devices enabled on that NUMA node for compress jobs. In
other words, compressions originating from any process in a node will be
distributed in round-robin manner to the available IAA devices on the same
socket. The main premise behind this change is to make sure that no
compress engines on any IAA device are left un-utilized/under-utilized. In
other words, the compress engines on all IAA devices are considered a
global resource for that socket.

This allows the use of all IAA devices present in a given NUMA node for
(batched) compressions originating from zswap/zram, from all cores
on this node.

A new per-cpu "global_wq_table" implements this in the iaa_crypto driver.
We can think of the global WQ per IAA as a WQ to which all cores on
that socket can submit compress jobs.

To avail of this feature, the user must configure 2 WQs per IAA in order to
enable distribution of compress jobs to multiple IAA devices.

Each IAA will have 2 WQs:
 wq.0 (local WQ):
   Used for decompress jobs from cores mapped by the cpu_to_iaa() "even
   balancing of logical cores to IAA devices" algorithm.

 wq.1 (global WQ):
   Used for compress jobs from *all* logical cores on that socket.

The iaa_crypto driver will place all global WQs from all same-socket IAA
devices in the global_wq_table per cpu on that socket. When the driver
receives a compress job, it will lookup the "next" global WQ in the cpu's
global_wq_table to submit the descriptor.

The starting wq in the global_wq_table for each cpu is the global wq
associated with the IAA nearest to it, so that we stagger the starting
global wq for each process. This results in very uniform usage of all IAAs
for compress jobs.

Two new driver module parameters are added for this feature:

g_wqs_per_iaa (default 1):

 /sys/bus/dsa/drivers/crypto/g_wqs_per_iaa

 This represents the number of global WQs that can be configured per IAA
 device. The default is 1, and is the recommended setting to enable the use
 of this feature once the user configures 2 WQs per IAA using higher level
 scripts as described in
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst.

g_consec_descs_per_gwq (default 1):

 /sys/bus/dsa/drivers/crypto/g_consec_descs_per_gwq

 This represents the number of consecutive compress jobs that will be
 submitted to the same global WQ (i.e. to the same IAA device) from a given
 core, before moving to the next global WQ. The default is 1, which is also
 the recommended setting to avail of this feature.

The decompress jobs from any core will be sent to the "local" IAA, namely
the one that the driver assigns with the cpu_to_iaa() mapping algorithm
that evenly balances the assignment of logical cores to IAA devices on a
NUMA node.

On a 2-socket Sapphire Rapids server where each socket has 56 cores and
4 IAA devices, this is how the compress/decompress jobs will be mapped
when the user configures 2 WQs per IAA device (which implies wq.1 will
be added to the global WQ table for each logical core on that NUMA node):

 lscpu|grep NUMA
 NUMA node(s):        2
 NUMA node0 CPU(s):   0-55,112-167
 NUMA node1 CPU(s):   56-111,168-223

 Compress jobs:
 --------------
 NUMA node 0:
 All cpus (0-55,112-167) can send compress jobs to all IAA devices on the
 socket (iax1/iax3/iax5/iax7) in round-robin manner:
 iaa   iax1           iax3           iax5           iax7

 NUMA node 1:
 All cpus (56-111,168-223) can send compress jobs to all IAA devices on the
 socket (iax9/iax11/iax13/iax15) in round-robin manner:
 iaa   iax9           iax11          iax13           iax15

 Decompress jobs:
 ----------------
 NUMA node 0:
 cpu   0-13,112-125   14-27,126-139  28-41,140-153  42-55,154-167
 iaa   iax1           iax3           iax5           iax7

 NUMA node 1:
 cpu   56-69,168-181  70-83,182-195  84-97,196-209   98-111,210-223
 iaa   iax9           iax11          iax13           iax15

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 305 ++++++++++++++++++++-
 1 file changed, 290 insertions(+), 15 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index c854a7a1aaa4..2d6c517e9d9b 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -29,14 +29,23 @@ static unsigned int nr_iaa;
 static unsigned int nr_cpus;
 static unsigned int nr_nodes;
 static unsigned int nr_cpus_per_node;
-
 /* Number of physical cpus sharing each iaa instance */
 static unsigned int cpus_per_iaa;
 
 static struct crypto_comp *deflate_generic_tfm;
 
 /* Per-cpu lookup table for balanced wqs */
-static struct wq_table_entry __percpu *wq_table;
+static struct wq_table_entry __percpu *wq_table = NULL;
+
+/* Per-cpu lookup table for global wqs shared by all cpus. */
+static struct wq_table_entry __percpu *global_wq_table = NULL;
+
+/*
+ * Per-cpu counter of consecutive descriptors allocated to
+ * the same wq in the global_wq_table, so that we know
+ * when to switch to the next wq in the global_wq_table.
+ */
+static int __percpu *num_consec_descs_per_wq = NULL;
 
 static struct idxd_wq *wq_table_next_wq(int cpu)
 {
@@ -104,26 +113,68 @@ static void wq_table_add(int cpu, struct idxd_wq *wq)
 
 	entry->wqs[entry->n_wqs++] = wq;
 
-	pr_debug("%s: added iaa wq %d.%d to idx %d of cpu %d\n", __func__,
-		 entry->wqs[entry->n_wqs - 1]->idxd->id,
-		 entry->wqs[entry->n_wqs - 1]->id, entry->n_wqs - 1, cpu);
+	pr_debug("%s: added iaa local wq %d.%d to idx %d of cpu %d\n", __func__,
+		entry->wqs[entry->n_wqs - 1]->idxd->id,
+		entry->wqs[entry->n_wqs - 1]->id, entry->n_wqs - 1, cpu);
+}
+
+static void global_wq_table_add(int cpu, struct idxd_wq *wq)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+
+	if (WARN_ON(entry->n_wqs == entry->max_wqs))
+		return;
+
+	entry->wqs[entry->n_wqs++] = wq;
+
+	pr_debug("%s: added iaa global wq %d.%d to idx %d of cpu %d\n", __func__,
+		entry->wqs[entry->n_wqs - 1]->idxd->id,
+		entry->wqs[entry->n_wqs - 1]->id, entry->n_wqs - 1, cpu);
+}
+
+static void global_wq_table_set_start_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+	int start_wq = (entry->n_wqs / nr_iaa) * cpu_to_iaa(cpu);
+
+	if ((start_wq >= 0) && (start_wq < entry->n_wqs))
+		entry->cur_wq = start_wq;
 }
 
 static void wq_table_free_entry(int cpu)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
 
-	kfree(entry->wqs);
-	memset(entry, 0, sizeof(*entry));
+	if (entry) {
+		kfree(entry->wqs);
+		memset(entry, 0, sizeof(*entry));
+	}
+
+	entry = per_cpu_ptr(global_wq_table, cpu);
+
+	if (entry) {
+		kfree(entry->wqs);
+		memset(entry, 0, sizeof(*entry));
+	}
 }
 
 static void wq_table_clear_entry(int cpu)
 {
 	struct wq_table_entry *entry = per_cpu_ptr(wq_table, cpu);
 
-	entry->n_wqs = 0;
-	entry->cur_wq = 0;
-	memset(entry->wqs, 0, entry->max_wqs * sizeof(struct idxd_wq *));
+	if (entry) {
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
+		memset(entry->wqs, 0, entry->max_wqs * sizeof(struct idxd_wq *));
+	}
+
+	entry = per_cpu_ptr(global_wq_table, cpu);
+
+	if (entry) {
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
+		memset(entry->wqs, 0, entry->max_wqs * sizeof(struct idxd_wq *));
+	}
 }
 
 LIST_HEAD(iaa_devices);
@@ -163,6 +214,70 @@ static ssize_t verify_compress_store(struct device_driver *driver,
 }
 static DRIVER_ATTR_RW(verify_compress);
 
+/* Number of global wqs per iaa*/
+static int g_wqs_per_iaa = 1;
+
+static ssize_t g_wqs_per_iaa_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", g_wqs_per_iaa);
+}
+
+static ssize_t g_wqs_per_iaa_store(struct device_driver *driver,
+				     const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtoint(buf, 10, &g_wqs_per_iaa);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(g_wqs_per_iaa);
+
+/*
+ * Number of consecutive descriptors to allocate from a
+ * given global wq before switching to the next wq in
+ * the global_wq_table.
+ */
+static int g_consec_descs_per_gwq = 1;
+
+static ssize_t g_consec_descs_per_gwq_show(struct device_driver *driver, char *buf)
+{
+	return sprintf(buf, "%d\n", g_consec_descs_per_gwq);
+}
+
+static ssize_t g_consec_descs_per_gwq_store(struct device_driver *driver,
+				     const char *buf, size_t count)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&iaa_devices_lock);
+
+	if (iaa_crypto_enabled)
+		goto out;
+
+	ret = kstrtoint(buf, 10, &g_consec_descs_per_gwq);
+	if (ret)
+		goto out;
+
+	ret = count;
+out:
+	mutex_unlock(&iaa_devices_lock);
+
+	return ret;
+}
+static DRIVER_ATTR_RW(g_consec_descs_per_gwq);
+
 /*
  * The iaa crypto driver supports three 'sync' methods determining how
  * compressions and decompressions are performed:
@@ -751,7 +866,20 @@ static void free_wq_table(void)
 	for (cpu = 0; cpu < nr_cpus; cpu++)
 		wq_table_free_entry(cpu);
 
-	free_percpu(wq_table);
+	if (wq_table) {
+		free_percpu(wq_table);
+		wq_table = NULL;
+	}
+
+	if (global_wq_table) {
+		free_percpu(global_wq_table);
+		global_wq_table = NULL;
+	}
+
+	if (num_consec_descs_per_wq) {
+		free_percpu(num_consec_descs_per_wq);
+		num_consec_descs_per_wq = NULL;
+	}
 
 	pr_debug("freed wq table\n");
 }
@@ -774,6 +902,38 @@ static int alloc_wq_table(int max_wqs)
 		}
 
 		entry->max_wqs = max_wqs;
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
+	}
+
+	global_wq_table = alloc_percpu(struct wq_table_entry);
+	if (!global_wq_table) {
+		free_wq_table();
+		return -ENOMEM;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		entry = per_cpu_ptr(global_wq_table, cpu);
+		entry->wqs = kzalloc(GFP_KERNEL, max_wqs * sizeof(struct wq *));
+		if (!entry->wqs) {
+			free_wq_table();
+			return -ENOMEM;
+		}
+
+		entry->max_wqs = max_wqs;
+		entry->n_wqs = 0;
+		entry->cur_wq = 0;
+	}
+
+	num_consec_descs_per_wq = alloc_percpu(int);
+	if (!num_consec_descs_per_wq) {
+		free_wq_table();
+		return -ENOMEM;
+	}
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+		int *num_consec_descs = per_cpu_ptr(num_consec_descs_per_wq, cpu);
+		*num_consec_descs = 0;
 	}
 
 	pr_debug("initialized wq table\n");
@@ -912,9 +1072,14 @@ static int wq_table_add_wqs(int iaa, int cpu)
 	}
 
 	list_for_each_entry(iaa_wq, &found_device->wqs, list) {
-		wq_table_add(cpu, iaa_wq->wq);
+
+		if (((found_device->n_wq - g_wqs_per_iaa) < 1) ||
+			(n_wqs_added < (found_device->n_wq - g_wqs_per_iaa))) {
+			wq_table_add(cpu, iaa_wq->wq);
+		}
+
 		pr_debug("rebalance: added wq for cpu=%d: iaa wq %d.%d\n",
-			 cpu, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
+			cpu, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
 		n_wqs_added++;
 	}
 
@@ -927,6 +1092,63 @@ static int wq_table_add_wqs(int iaa, int cpu)
 	return ret;
 }
 
+static int global_wq_table_add_wqs(void)
+{
+	struct iaa_device *iaa_device;
+	int ret = 0, n_wqs_added;
+	struct idxd_device *idxd;
+	struct iaa_wq *iaa_wq;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int cpu, node, node_of_cpu = -1;
+
+	for (cpu = 0; cpu < nr_cpus; cpu++) {
+
+#ifdef CONFIG_NUMA
+		node_of_cpu = -1;
+		for_each_online_node(node) {
+			const struct cpumask *node_cpus;
+			node_cpus = cpumask_of_node(node);
+			if (!cpumask_test_cpu(cpu, node_cpus))
+				continue;
+			node_of_cpu = node;
+			break;
+		}
+#endif
+		list_for_each_entry(iaa_device, &iaa_devices, list) {
+			idxd = iaa_device->idxd;
+			pdev = idxd->pdev;
+			dev = &pdev->dev;
+
+#ifdef CONFIG_NUMA
+			if (dev && (node_of_cpu != dev->numa_node))
+				continue;
+#endif
+
+			if (iaa_device->n_wq <= g_wqs_per_iaa)
+				continue;
+
+			n_wqs_added = 0;
+
+			list_for_each_entry(iaa_wq, &iaa_device->wqs, list) {
+
+				if (n_wqs_added < (iaa_device->n_wq - g_wqs_per_iaa)) {
+					n_wqs_added++;
+				}
+				else {
+					global_wq_table_add(cpu, iaa_wq->wq);
+					pr_debug("rebalance: added global wq for cpu=%d: iaa wq %d.%d\n",
+						cpu, iaa_wq->wq->idxd->id, iaa_wq->wq->id);
+				}
+			}
+		}
+
+		global_wq_table_set_start_wq(cpu);
+	}
+
+	return ret;
+}
+
 /*
  * Rebalance the wq table so that given a cpu, it's easy to find the
  * closest IAA instance.  The idea is to try to choose the most
@@ -961,6 +1183,7 @@ static void rebalance_wq_table(void)
 	}
 
 	pr_debug("Finished rebalance local wqs.");
+	global_wq_table_add_wqs();
 }
 
 static inline int check_completion(struct device *dev,
@@ -1509,6 +1732,27 @@ static int iaa_decompress(struct crypto_tfm *tfm, struct acomp_req *req,
 	goto out;
 }
 
+/*
+ * Caller should make sure to call only if the
+ * per_cpu_ptr "global_wq_table" is non-NULL
+ * and has at least one wq configured.
+ */
+static struct idxd_wq *global_wq_table_next_wq(int cpu)
+{
+	struct wq_table_entry *entry = per_cpu_ptr(global_wq_table, cpu);
+	int *num_consec_descs = per_cpu_ptr(num_consec_descs_per_wq, cpu);
+
+	if ((*num_consec_descs) == g_consec_descs_per_gwq) {
+		if (++entry->cur_wq >= entry->n_wqs)
+			entry->cur_wq = 0;
+		*num_consec_descs = 0;
+	}
+
+	++(*num_consec_descs);
+
+	return entry->wqs[entry->cur_wq];
+}
+
 static int iaa_comp_acompress(struct acomp_req *req)
 {
 	struct iaa_compression_ctx *compression_ctx;
@@ -1521,6 +1765,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct idxd_wq *wq;
 	struct device *dev;
 	int order = -1;
+	struct wq_table_entry *entry;
 
 	compression_ctx = crypto_tfm_ctx(tfm);
 
@@ -1535,8 +1780,15 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	}
 
 	cpu = get_cpu();
-	wq = wq_table_next_wq(cpu);
+	entry = per_cpu_ptr(global_wq_table, cpu);
+
+	if (!entry || entry->n_wqs == 0) {
+		wq = wq_table_next_wq(cpu);
+	} else {
+		wq = global_wq_table_next_wq(cpu);
+	}
 	put_cpu();
+
 	if (!wq) {
 		pr_debug("no wq configured for cpu=%d\n", cpu);
 		return -ENODEV;
@@ -2145,13 +2397,32 @@ static int __init iaa_crypto_init_module(void)
 		goto err_sync_attr_create;
 	}
 
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				&driver_attr_g_wqs_per_iaa);
+	if (ret) {
+		pr_debug("IAA g_wqs_per_iaa attr creation failed\n");
+		goto err_g_wqs_per_iaa_attr_create;
+	}
+
+	ret = driver_create_file(&iaa_crypto_driver.drv,
+				&driver_attr_g_consec_descs_per_gwq);
+	if (ret) {
+		pr_debug("IAA g_consec_descs_per_gwq attr creation failed\n");
+		goto err_g_consec_descs_per_gwq_attr_create;
+	}
+
 	if (iaa_crypto_debugfs_init())
 		pr_warn("debugfs init failed, stats not available\n");
 
 	pr_debug("initialized\n");
 out:
 	return ret;
-
+err_g_consec_descs_per_gwq_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_wqs_per_iaa);
+err_g_wqs_per_iaa_attr_create:
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_sync_mode);
 err_sync_attr_create:
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
@@ -2175,6 +2446,10 @@ static void __exit iaa_crypto_cleanup_module(void)
 			   &driver_attr_sync_mode);
 	driver_remove_file(&iaa_crypto_driver.drv,
 			   &driver_attr_verify_compress);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_wqs_per_iaa);
+	driver_remove_file(&iaa_crypto_driver.drv,
+			   &driver_attr_g_consec_descs_per_gwq);
 	idxd_driver_unregister(&iaa_crypto_driver);
 	iaa_aecs_cleanup_fixed();
 	crypto_free_comp(deflate_generic_tfm);
-- 
2.27.0


