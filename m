Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52371465FD7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Dec 2021 09:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356245AbhLBIwe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Dec 2021 03:52:34 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52106 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356239AbhLBIw3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:52:29 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Ak4mbcKNBwi0KcNzvrR3OlsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQW40zJ00mFSz2IaDGyBafncNzCnf4t3at6xpkMAupXSm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAmjfvQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQWo+aWeCDk2SCU5wicG5f2+N1iBV83MaUW4OFyBnt?=
 =?us-ascii?q?E9OBeIzcIBjiDjOKewbS1UOBgi80vas7xM+s3tnhmizOfEvciRZHKRr7i5NlE0?=
 =?us-ascii?q?TN2jcdLdd7SZdUebzVHbxnaZRBLfFANB/oWmOaum2m6djhwq0ycrqlx5HLcpCR?=
 =?us-ascii?q?3zrTsNd/9ft2RWd4Tmkeeu3KA82nnajkYPdqSjzGF71qrnObEmS69U4UXfJW89?=
 =?us-ascii?q?/h3kBid3WAeFhASfUW0rOP/iUOkXd9bbUsO9UIGqak06VzuTdTnWRC8iGCLswR?=
 =?us-ascii?q?aWNdKFeA+rgaXxcL85wefG3hBXjBaQMIpudVwRjEw0FKN2dTzClRSXBe9IZ6G3?=
 =?us-ascii?q?u7M62rsZm5OdilfDRLohDAtu7HLyLzfRDqWJjq7LJOIsw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXb/LG6m7Rk7likBGoc1jbLHNzc7pDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="118319103"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 02 Dec 2021 16:49:04 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 7EA424D13A1D;
        Thu,  2 Dec 2021 16:49:02 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:04 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 2 Dec 2021 16:49:02 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 2 Dec 2021 16:49:00 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>
Subject: [PATCH v8 2/9] dax: Introduce holder for dax_device
Date:   Thu, 2 Dec 2021 16:48:49 +0800
Message-ID: <20211202084856.1285285-3-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
References: <20211202084856.1285285-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 7EA424D13A1D.A1B20
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To easily track filesystem from a pmem device, we introduce a holder for
dax_device structure, and also its operation.  This holder is used to
remember who is using this dax_device:
 - When it is the backend of a filesystem, the holder will be the
   superblock of this filesystem.
 - When this pmem device is one of the targets in a mapped device, the
   holder will be this mapped device.  In this case, the mapped device
   has its own dax_device and it will follow the first rule.  So that we
   can finally track to the filesystem we needed.

The holder and holder_ops will be set when filesystem is being mounted,
or an target device is being activated.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 drivers/dax/super.c | 61 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dax.h | 25 +++++++++++++++++++
 2 files changed, 86 insertions(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 719e77b2c2d4..a19fcc0a54f3 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -20,15 +20,20 @@
  * @inode: core vfs
  * @cdev: optional character interface for "device dax"
  * @private: dax driver private data
+ * @holder_data: holder of a dax_device: could be filesystem or mapped device
  * @flags: state and boolean properties
+ * @ops: operations for dax_device
+ * @holder_ops: operations for the inner holder
  */
 struct dax_device {
 	struct inode inode;
 	struct cdev cdev;
 	void *private;
 	struct percpu_rw_semaphore rwsem;
+	void *holder_data;
 	unsigned long flags;
 	const struct dax_operations *ops;
+	const struct dax_holder_operations *holder_ops;
 };
 
 static dev_t dax_devt;
@@ -190,6 +195,29 @@ int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 }
 EXPORT_SYMBOL_GPL(dax_zero_page_range);
 
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off,
+			      u64 len, int mf_flags)
+{
+	int rc;
+
+	dax_read_lock(dax_dev);
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
+	dax_read_unlock(dax_dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_holder_notify_failure);
+
 #ifdef CONFIG_ARCH_HAS_PMEM_API
 void arch_wb_cache_pmem(void *addr, size_t size);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size)
@@ -252,6 +280,10 @@ void kill_dax(struct dax_device *dax_dev)
 		return;
 	dax_write_lock(dax_dev);
 	clear_bit(DAXDEV_ALIVE, &dax_dev->flags);
+
+	/* clear holder data */
+	dax_dev->holder_ops = NULL;
+	dax_dev->holder_data = NULL;
 	dax_write_unlock(dax_dev);
 }
 EXPORT_SYMBOL_GPL(kill_dax);
@@ -399,6 +431,35 @@ void put_dax(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(put_dax);
 
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+	dax_write_lock(dax_dev);
+	if (!dax_alive(dax_dev))
+		goto out;
+
+	dax_dev->holder_data = holder;
+	dax_dev->holder_ops = ops;
+out:
+	dax_write_unlock(dax_dev);
+}
+EXPORT_SYMBOL_GPL(dax_set_holder);
+
+void *dax_get_holder(struct dax_device *dax_dev)
+{
+	void *holder = NULL;
+
+	dax_read_lock(dax_dev);
+	if (!dax_alive(dax_dev))
+		goto out;
+
+	holder = dax_dev->holder_data;
+out:
+	dax_read_unlock(dax_dev);
+	return holder;
+}
+EXPORT_SYMBOL_GPL(dax_get_holder);
+
 /**
  * inode_dax: convert a public inode into its dax_dev
  * @inode: An inode with i_cdev pointing to a dax_dev
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 8414a08dcbea..f01684a63447 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -44,6 +44,21 @@ struct dax_operations {
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *alloc_dax(void *private, const struct dax_operations *ops,
 		unsigned long flags);
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
+void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops);
+void *dax_get_holder(struct dax_device *dax_dev);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
@@ -71,6 +86,14 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 	return dax_synchronous(dax_dev);
 }
 #else
+static inline void dax_set_holder(struct dax_device *dax_dev, void *holder,
+		const struct dax_holder_operations *ops)
+{
+}
+static inline void *dax_get_holder(struct dax_device *dax_dev)
+{
+	return NULL;
+}
 static inline struct dax_device *alloc_dax(void *private,
 		const struct dax_operations *ops, unsigned long flags)
 {
@@ -199,6 +222,8 @@ size_t dax_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff, void *addr,
 		size_t bytes, struct iov_iter *i);
 int dax_zero_page_range(struct dax_device *dax_dev, pgoff_t pgoff,
 			size_t nr_pages);
+int dax_holder_notify_failure(struct dax_device *dax_dev, u64 off, u64 len,
+		int mf_flags);
 void dax_flush(struct dax_device *dax_dev, void *addr, size_t size);
 
 ssize_t dax_iomap_rw(struct kiocb *iocb, struct iov_iter *iter,
-- 
2.34.0



