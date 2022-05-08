Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAE51EE12
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 16:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiEHOkS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiEHOkR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 10:40:17 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CDEDE0AC;
        Sun,  8 May 2022 07:36:26 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3A2KmLh6wjMp9rd3nqr7B6t+fbxyrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApGt0hjZSmjccUGGCOqreMWKhedhwO4jn8hsHu8PTyddmHQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kfF3oTJ9yEmj/nSHuOkUYY?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeWbeSfi7pfLp6HBWz62qxl0N2k6NJMZ9s55G2Z?=
 =?us-ascii?q?L8uYSKSxLZReG78qywbS+S+BrhskLLNTiI44e/HpnyFnxDf0maZHFTb/D6dJR0?=
 =?us-ascii?q?HE3nM8mNenfY84IQTtpYg7JbxBGNhEQEp1WtOuhgD/9NSJZrFaUrK8sy2nV0AF?=
 =?us-ascii?q?1lrPqNbL9dt6VQsNatkWVvGTL+yL+GB5yHNiezyeVt3epruzRlCj4HoUIG9WQ8?=
 =?us-ascii?q?OBmgViW7mgSEwENE1+6p+SpzEKzRbp3K0cU0i41se4++SSDSND6ThT+oHmevxE?=
 =?us-ascii?q?BUNpRO+s340eGza+8ywSQAGVCRT5cQNs8vcQySHoh0Vrht8nmAjhjr6yTYWmA7?=
 =?us-ascii?q?brSoT7aESwUK3ISICEfQQYb7t3Lvo4+lFTMQ8xlHarzicf6cRn0wjaXvG09iq8?=
 =?us-ascii?q?VgMojyaq25xbEjiiqq5yPSRQ6ji3TX2S4/kZpapWNeYOl8x7Y4OxGIYLfSUOO1?=
 =?us-ascii?q?FAamtKZxPIDC5CT0iiMRvgdWraz6LCYM1XhbfRHd3U63231vSf9IsYLu3cjTHq?=
 =?us-ascii?q?F+/0sIVfBCHI/cysIjHOLAEaXUA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AoPiYlKOFYjqf2sBcTiWjsMiBIKoaSvp037Eq?=
 =?us-ascii?q?v3oedfUzSL3/qynOpoVj6faaslYssR0b9exofZPwJE80lqQFhrX5X43SPzUO0V?=
 =?us-ascii?q?HAROoJgLcKgQeQfxEWndQ96U4PScdD4aXLfDpHZNjBkXSFOudl0N+a67qpmOub?=
 =?us-ascii?q?639sSDthY6Zm4xwRMHfhLmRGABlBGYEiFIeRou5Opz+bc3wRacihQlYfWeyrna?=
 =?us-ascii?q?ywqLvWJQ4BGwU86BSDyReh6LvBGRCe2RsEFxNjqI1SiVT4rw=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124075730"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 May 2022 22:36:25 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 948B24D17197;
        Sun,  8 May 2022 22:36:24 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 8 May 2022 22:36:27 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 8 May 2022 22:36:23 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v14 03/07] pagemap,pmem: Introduce ->memory_failure()
Date:   Sun, 8 May 2022 22:36:09 +0800
Message-ID: <20220508143620.1775214-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 948B24D17197.AED1F
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

When memory-failure occurs, we call this function which is implemented
by each kind of devices.  For the fsdax case, pmem device driver
implements it.  Pmem device driver will find out the filesystem in which
the corrupted page located in.

With dax_holder notify support, we are able to notify the memory failure
from pmem driver to upper layers.  If there is something not support in
the notify routine, memory_failure will fall back to the generic hanlder.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 drivers/nvdimm/pmem.c    | 17 +++++++++++++++++
 include/linux/memremap.h | 12 ++++++++++++
 mm/memory-failure.c      | 14 ++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 58d95242a836..bd502957cfdf 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -366,6 +366,21 @@ static void pmem_release_disk(void *__pmem)
 	blk_cleanup_disk(pmem->disk);
 }
 
+static int pmem_pagemap_memory_failure(struct dev_pagemap *pgmap,
+		unsigned long pfn, unsigned long nr_pages, int mf_flags)
+{
+	struct pmem_device *pmem =
+			container_of(pgmap, struct pmem_device, pgmap);
+	u64 offset = PFN_PHYS(pfn) - pmem->phys_addr - pmem->data_offset;
+	u64 len = nr_pages << PAGE_SHIFT;
+
+	return dax_holder_notify_failure(pmem->dax_dev, offset, len, mf_flags);
+}
+
+static const struct dev_pagemap_ops fsdax_pagemap_ops = {
+	.memory_failure		= pmem_pagemap_memory_failure,
+};
+
 static int pmem_attach_disk(struct device *dev,
 		struct nd_namespace_common *ndns)
 {
@@ -427,6 +442,7 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -440,6 +456,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 8af304f6b504..f1d413ef7c0d 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -79,6 +79,18 @@ struct dev_pagemap_ops {
 	 * the page back to a CPU accessible page.
 	 */
 	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
+
+	/*
+	 * Handle the memory failure happens on a range of pfns.  Notify the
+	 * processes who are using these pfns, and try to recover the data on
+	 * them if necessary.  The mf_flags is finally passed to the recover
+	 * function through the whole notify routine.
+	 *
+	 * When this is not implemented, or it returns -EOPNOTSUPP, the caller
+	 * will fall back to a common handler called mf_generic_kill_procs().
+	 */
+	int (*memory_failure)(struct dev_pagemap *pgmap, unsigned long pfn,
+			      unsigned long nr_pages, int mf_flags);
 };
 
 #define PGMAP_ALTMAP_VALID	(1 << 0)
diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 9e4728103c0d..aeb19593af9c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1740,6 +1740,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
 	if (!pgmap_pfn_valid(pgmap, pfn))
 		goto out;
 
+	/*
+	 * Call driver's implementation to handle the memory failure, otherwise
+	 * fall back to generic handler.
+	 */
+	if (pgmap->ops->memory_failure) {
+		rc = pgmap->ops->memory_failure(pgmap, pfn, 1, flags);
+		/*
+		 * Fall back to generic handler too if operation is not
+		 * supported inside the driver/device/filesystem.
+		 */
+		if (rc != -EOPNOTSUPP)
+			goto out;
+	}
+
 	rc = mf_generic_kill_procs(pfn, flags, pgmap);
 out:
 	/* drop pgmap ref acquired in caller */
-- 
2.35.1



