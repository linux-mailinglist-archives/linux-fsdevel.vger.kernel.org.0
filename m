Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5053C460
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jun 2022 07:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240953AbiFCFhz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jun 2022 01:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbiFCFhv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jun 2022 01:37:51 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A4E0C2F019;
        Thu,  2 Jun 2022 22:37:48 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Arn50ua8DEZ9sGKuWVkEZDrUDAX+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUor0TdWzWcdDTiCP/eOZTDwfNF3bo/i80IPucTRmNRqQVdlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadfSbv75PCniUqdFOpmZ2CFnoeMYQG++pfD3t?=
 =?us-ascii?q?J8PsCIjERKBuEgoqexLO9T+hlgcQuBMn2NZwSuzdryjSxJfYtQbjCRavQ7NNV1?=
 =?us-ascii?q?Tt2gdpBdd7BZs4deBJuahraahFCM1tRD4gx9M+kj3+5cXtHqVaRpKMy+EDSyhB?=
 =?us-ascii?q?81P7mN9+9UtCIWsJTkW6bq3jA8mC/BQsVXPSbyDyY4jepg8fMgyrwW8QVDrLQ3?=
 =?us-ascii?q?vdpmFi7wm0VFQ1TW1ymp/Wwlk+5XZRYMUN80iwwoak38WSvT8LhRFu8oXiZrlg?=
 =?us-ascii?q?QVsQ4O+0x6CmJ0baS7wvxLm4NSS9ILtwhrs45WDcq13ePktivDjtq2JWXQHSQs?=
 =?us-ascii?q?LyUsBu1IyEeKWJEbigBJSMf7N7nrJ4iiDrUU81uVqK45vXxGDft03WEtyQzmbg?=
 =?us-ascii?q?XpdAE2r/9/l3dhT+o4J/TQWYd4gTRQ3Lg7Q5jYoOhT5Kn5EKd7vtaKoudCF6bs?=
 =?us-ascii?q?xAsn8mY8fBLHZ+WvDKCTf9LH7yz4fuBdjrGjjZHAZg78By/9niiY8ZU4TdjNAF?=
 =?us-ascii?q?uKMlCZDyBXaN5kWu9/7cKZD3zM/AxONn3VqwXIWHbPYyNfpjpghBmO/CdrDO6w?=
 =?us-ascii?q?Rw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgO6QWqocm2G5sIxIpnsgamoaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124686799"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 03 Jun 2022 13:37:44 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 90EA54D1719A;
        Fri,  3 Jun 2022 13:37:43 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 3 Jun 2022 13:37:43 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 3 Jun 2022 13:37:43 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>,
        <akpm@linux-foundation.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 03/14] pagemap,pmem: Introduce ->memory_failure()
Date:   Fri, 3 Jun 2022 13:37:27 +0800
Message-ID: <20220603053738.1218681-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
References: <20220603053738.1218681-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 90EA54D1719A.A17CB
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
index 629d10fcf53b..107c9cb3d57d 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -453,6 +453,21 @@ static void pmem_release_disk(void *__pmem)
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
@@ -514,6 +529,7 @@ static int pmem_attach_disk(struct device *dev,
 	pmem->pfn_flags = PFN_DEV;
 	if (is_nd_pfn(dev)) {
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pfn_sb = nd_pfn->pfn_sb;
 		pmem->data_offset = le64_to_cpu(pfn_sb->dataoff);
@@ -527,6 +543,7 @@ static int pmem_attach_disk(struct device *dev,
 		pmem->pgmap.range.end = res->end;
 		pmem->pgmap.nr_range = 1;
 		pmem->pgmap.type = MEMORY_DEVICE_FS_DAX;
+		pmem->pgmap.ops = &fsdax_pagemap_ops;
 		addr = devm_memremap_pages(dev, &pmem->pgmap);
 		pmem->pfn_flags |= PFN_MAP;
 		bb_range = pmem->pgmap.range;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 9f752ebed613..334ce79a3b91 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -87,6 +87,18 @@ struct dev_pagemap_ops {
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
index b39424da7625..a9d93c30a1e4 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1737,6 +1737,20 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
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
2.36.1



