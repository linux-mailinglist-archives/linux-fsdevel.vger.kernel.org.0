Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7984B3B67
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Feb 2022 13:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiBMM6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 13 Feb 2022 07:58:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiBMM6q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 13 Feb 2022 07:58:46 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4EE95B3F2;
        Sun, 13 Feb 2022 04:58:39 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AtdpGoq2hW/Ry+r0Y5/bD5bhwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ12920zIOyWccXjuDOq3eZ2D8fo1wPt638RwHu8KDmN82QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouabfynj6J37I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHN6WzzfD+XKxrujVlCj/VcQZE7jQ3?=
 =?us-ascii?q?vprhkCDg2IIBBAIWF+Tv/a0kAi9VshZJkhS/TAhxYA29Uq2Xpz+Uge+rXqsoBE?=
 =?us-ascii?q?RQZxTHvc85QXLzbDbiy6dB24ZXntRZscOqsA7X3op20WPktevAiZg2IB541r1G?=
 =?us-ascii?q?qy89Gv0YHZKazRZI3JscOfM2PG7yKlbs/4FZo8L/HaJs+DI?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZCsgAqhGJWnWRItFyewITUkRQnBQXuYji2hC?=
 =?us-ascii?q?6mlwRA09TyX4rbHLoB1/73LJYVkqNk3I5urrBEDtexLhHP1OkOws1NWZLWrbUQ?=
 =?us-ascii?q?KTRekM0WKI+UyDJ8SRzI5g/JYlW61/Jfm1NlJikPv9iTPSL/8QhPWB74Ck7N2z?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="121469419"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 Feb 2022 20:58:38 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 3C2374D169D8;
        Sun, 13 Feb 2022 20:58:34 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 13 Feb 2022 20:58:36 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 13 Feb 2022 20:58:35 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 13 Feb 2022 20:58:33 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <hch@infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>, <djwong@kernel.org>,
        <dan.j.williams@intel.com>, <david@fromorbit.com>,
        <jane.chu@oracle.com>
Subject: [PATCH v10.1 1/9] dax: Introduce holder for dax_device
Date:   Sun, 13 Feb 2022 20:58:32 +0800
Message-ID: <20220213125832.2722009-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <YfqBLxjr5zz1TU91@infradead.org>
References: <YfqBLxjr5zz1TU91@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3C2374D169D8.A0F17
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

v10.1 update:
 - Fix build error reported by kernel test robot
 - Add return code to dax_register_holder()
 - Add write lock to prevent concurrent registrations
 - Rename dax_get_holder() to dax_holder()
 - Add kernel doc for new added functions

To easily track filesystem from a pmem device, we introduce a holder for
dax_device structure, and also its operation.  This holder is used to
remember who is using this dax_device:
 - When it is the backend of a filesystem, the holder will be the
   instance of this filesystem.
 - When this pmem device is one of the targets in a mapped device, the
   holder will be this mapped device.  In this case, the mapped device
   has its own dax_device and it will follow the first rule.  So that we
   can finally track to the filesystem we needed.

The holder and holder_ops will be set when filesystem is being mounted,
or an target device is being activated.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 30 ++++++++++++++
 2 files changed, 125 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..d7fb4c36bf16 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -21,6 +21,9 @@
  * @cdev: optional character interface for "device dax"
  * @private: dax driver private data
  * @flags: state and boolean properties
+ * @ops: operations for dax_device
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
+ * @holder_ops: operations for the inner holder
  */
 struct dax_device {
 	struct inode inode;
@@ -28,6 +31,9 @@ struct dax_device {
 	void *private;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	void *holder_data;
+	struct percpu_rw_semaphore holder_rwsem;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -193,6 +199,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
+			      u64 len, int mf_flags)
+{
+	int rc, id;
+
+	id = dax_read_lock();
+	if (!dax_alive(dax_dev)) {
+		rc = -ENXIO;
+		goto out;
+	}
+
+	if (!dax_dev->holder_ops) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
+	rc = dax_dev->holder_ops->notify_failure(dax_dev, off, len, mf_flags);
+out:
+	dax_read_unlock(id);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -268,6 +297,13 @@ void kill_dax(struct dax_device *dax_dev)
 
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
+
+	/* Lock to prevent concurrent registrations. */
+	percpu_down_write(&dax_dev->holder_rwsem);
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
+	percpu_up_write(&dax_dev->holder_rwsem);
 }
 EXPORT_SYMBOL_GPL(kill_dax);
 
@@ -393,6 +429,7 @@ struct dax_device *alloc_dax(void *private, const struct dax_operations *ops)
 
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	percpu_init_rwsem(&dax_dev->holder_rwsem);
 	return dax_dev;
 
  err_dev:
@@ -409,6 +446,64 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+/**
+ * dax_holder() - obtain the holder of a dax device
+ * @dax_dev: a dax_device instance
+
+ * Return: the holder's data which represents the holder if registered,
+ * otherwize NULL.
+ */
+void *dax_holder(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return NULL;
+
+	return dax_dev->holder_data;
+}
+EXPORT_SYMBOL_GPL(dax_holder);
+
+/**
+ * dax_register_holder() - register a holder to a dax device
+ * @dax_dev: a dax_device instance
+ * @holder: a pointer to a holder's data which represents the holder
+ * @ops: operations of this holder
+
+ * Return: negative errno if an error occurs, otherwise 0.
+ */
+int dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	/* Already registered */
+	if (dax_holder(dax_dev))
+		return -EBUSY;
+
+	/* Lock to prevent concurrent registrations. */
+	percpu_down_write(&dax_dev->holder_rwsem);
+	dax_dev->holder_data = holder;
+	dax_dev->holder_ops = ops;
+	percpu_up_write(&dax_dev->holder_rwsem);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_register_holder);
+
+/**
+ * dax_unregister_holder() - unregister the holder for a dax device
+ * @dax_dev: a dax_device instance
+ */
+void dax_unregister_holder(struct dax_device *dax_dev)
+{
+	if (!dax_alive(dax_dev))
+		return;
+
+	dax_dev->holder_data = NULL;
+	dax_dev->holder_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(dax_unregister_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..9800d84e5b7d 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -32,8 +32,24 @@ struct dax_operations {
 	int (*zero_page_range)(struct dax_device *, pgoff_t, size_t);
 };
 
+struct dax_holder_operations {
+	/*
+	 * notify_failure - notify memory failure into inner holder device
+	 * @dax_dev: the dax device which contains the holder
+	 * @offset: offset on this dax device where memory failure occurs
+	 * @len: length of this memory failure event
+	 * @flags: action flags for memory failure handler
+	 */
+	int (*notify_failure)(struct dax_device *dax_dev, u64 offset,
+			u64 len, int mf_flags);
+};
+
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops);
+int dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void dax_unregister_holder(struct dax_device *dax_dev);
+void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
@@ -53,6 +69,18 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
+static inline int dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	return 0;
+}
+static inline void dax_unregister_holder(struct dax_device *dax_dev)
+{
+}
+static inline void *dax_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops)
 {
@@ -185,6 +213,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.34.1



