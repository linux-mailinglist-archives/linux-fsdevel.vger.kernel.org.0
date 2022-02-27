Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4D34C5ADA
	for <lists+linux-fsdevel@lfdr.de>; Sun, 27 Feb 2022 13:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiB0MId (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 27 Feb 2022 07:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbiB0MIa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 27 Feb 2022 07:08:30 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D942524584;
        Sun, 27 Feb 2022 04:07:52 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3AFZDV6K/sIaRalZdNFs+tDrUD63+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUojgTVRnWJOXjyBOfuCZWbwftx3ao7g804OsZ6EyYRjHldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadeyDk7pLDlCUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqewLm7YuhqiN4qIMTiMMUYoH4I5T3QC7AkB4/CR6HL7NpD9?=
 =?us-ascii?q?DY2ms1KW/3ZYqIxZThwaxLPSx5CIFEaDNQ5hujArn3+dSBI7VeQjakp6mPQigt?=
 =?us-ascii?q?r39DFNsTZe9mPbcFUhVqD4GbH+XnpRB0XKrS3yzOD/zSnhvLnmjnyU4YfUra/8?=
 =?us-ascii?q?5ZChFyV23xWBgYaWEW2pdGnhUOkHdFSMUoZ/mwpt6da3EiqSMTtGh61uniJujY?=
 =?us-ascii?q?CVNdKVe438geAzuzT+QnxLmwFSCNRLcwor+coSjEwkFyEhdXkAXpoqrL9dJ433?=
 =?us-ascii?q?t94thvrYW5MczBEPnRCEGM4DxDYiNlbpnryohxLTcZZVuHIJAw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AQDDhVKs89yhQaqrvakNmYn8o7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122037683"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Feb 2022 20:07:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 837564D169F1;
        Sun, 27 Feb 2022 20:07:49 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 27 Feb 2022 20:07:51 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 27 Feb 2022 20:07:48 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v11 1/8] dax: Introduce holder for dax_device
Date:   Sun, 27 Feb 2022 20:07:40 +0800
Message-ID: <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 837564D169F1.A27BF
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
 drivers/dax/super.c | 89 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 32 ++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index e3029389d809..da5798e19d57 100644
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
@@ -28,6 +31,8 @@ struct dax_device {
 	void *private;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	void *holder_data;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -193,6 +198,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
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
@@ -268,6 +296,10 @@ void kill_dax(struct dax_device *dax_dev)
 
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
 	synchronize_srcu(&dax_srcu);
+
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
 }
 EXPORT_SYMBOL_GPL(kill_dax);
 
@@ -409,6 +441,63 @@ void put_dax(struct dax_device *dax_dev)
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
+	if (cmpxchg(&dax_dev->holder_data, NULL, holder))
+		return -EBUSY;
+
+	dax_dev->holder_ops = ops;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_register_holder);
+
+/**
+ * dax_unregister_holder() - unregister the holder for a dax device
+ * @dax_dev: a dax_device instance
+ * @holder: the holder to be unregistered
+ *
+ * Return: negative errno if an error occurs, otherwise 0.
+ */
+int dax_unregister_holder(struct dax_device *dax_dev, void *holder)
+{
+	if (!dax_alive(dax_dev))
+		return -ENXIO;
+
+	if (cmpxchg(&dax_dev->holder_data, holder, NULL) != holder)
+		return -EBUSY;
+	dax_dev->holder_ops = NULL;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dax_unregister_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9fc5f99a0ae2..262d7bad131a 100644
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
+int dax_unregister_holder(struct dax_device *dax_dev, void *holder);
+void *dax_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
@@ -53,6 +69,20 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
+static inline int dax_register_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	return 0;
+}
+static inline int dax_unregister_holder(struct dax_device *dax_dev,
+		void *holder)
+{
+	return 0;
+}
+static inline void *dax_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops)
 {
@@ -185,6 +215,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.35.1



