Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E96849E292
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbiA0Mlb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jan 2022 07:41:31 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:35632 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241305AbiA0MlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:41:17 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AyofZi61xxev+cRNMzPbD5axwkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJgG8rhWYCmGUdDGrVaP2KYzD0Ld5/btvip09V7ZHQxtA2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfjSGeKlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoueWeCPl7pX7I0ruNiGEL+9VJE0/I4wU0uhtBmR?=
 =?us-ascii?q?J7/YZNHYGaRXrr+K9wJq6TOd2j8guJcWtO5kQ0llsxDefD7A5QJTHQqzP/vdZ2?=
 =?us-ascii?q?is9goZFGvO2T8Ybdj1pYzzDbgdJN1NRD4gx9M+sh3/iY3hdrXqWu6M84C7U1gM?=
 =?us-ascii?q?Z+L7zPNvQf/SORN5JhQCcp2Tb7yL1Dw9yHNyUyRKB6W7qiuKntSHyXo9UH72l3?=
 =?us-ascii?q?vlwiVaXyyoYDxh+fV+6p+Spz0ClV99BJkg85CUjt+4x+VatQ927WAe3yFaAvxg?=
 =?us-ascii?q?BS59THvc85QWl1KXZ+UCaC3ICQzoHb8Yp3OcyRDo3xhqZkcjBGzNiqvuWRGib+?=
 =?us-ascii?q?7PSqim9URX5h0dqiTQsFFNDuoe85tpoyE+nczqqK4bt5vWdJN06623iQPACuog?=
 =?us-ascii?q?u?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AHKAZGKsvYMoMICJtedEBM9JN7skDStV00zEX?=
 =?us-ascii?q?/kB9WHVpm62j5qSTdZEguCMc5wx+ZJheo7q90cW7IE80lqQFhLX5X43SPzUO0V?=
 =?us-ascii?q?HARO5fBODZsl/d8kPFltJ15ONJdqhSLJnKB0FmsMCS2mKFOudl7N6Z0K3Av4vj?=
 =?us-ascii?q?80s=3D?=
X-IronPort-AV: E=Sophos;i="5.88,320,1635177600"; 
   d="scan'208";a="120913271"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 27 Jan 2022 20:41:07 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id ED7DA4D169C9;
        Thu, 27 Jan 2022 20:41:03 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 27 Jan 2022 20:41:02 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 27 Jan 2022 20:41:01 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v10 6/9] mm: move pgoff_address() to vma_pgoff_address()
Date:   Thu, 27 Jan 2022 20:40:55 +0800
Message-ID: <20220127124058.1172422-7-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
References: <20220127124058.1172422-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: ED7DA4D169C9.A411D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since it is not a DAX-specific function, move it into mm and rename it
to be a generic helper.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c           | 12 +-----------
 include/linux/mm.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 964512107c23..250794a5b789 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -834,16 +834,6 @@ static void *dax_insert_entry(struct xa_state *xas,
 	return entry;
 }
 
-static inline
-unsigned long pgoff_address(pgoff_t pgoff, struct vm_area_struct *vma)
-{
-	unsigned long address;
-
-	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
-	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
-	return address;
-}
-
 /* Walk all mappings of a given index of a file and writeprotect them */
 static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 		unsigned long pfn)
@@ -863,7 +853,7 @@ static void dax_entry_mkclean(struct address_space *mapping, pgoff_t index,
 		if (!(vma->vm_flags & VM_SHARED))
 			continue;
 
-		address = pgoff_address(index, vma);
+		address = vma_pgoff_address(vma, index);
 
 		/*
 		 * follow_invalidate_pte() will use the range to call
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e1a84b1e6787..9b1d56c5c224 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2816,6 +2816,19 @@ static inline unsigned long vma_pages(struct vm_area_struct *vma)
 	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
 }
 
+/*
+ * Get user virtual address at the specific offset within a vma.
+ */
+static inline unsigned long vma_pgoff_address(struct vm_area_struct *vma,
+					      pgoff_t pgoff)
+{
+	unsigned long address;
+
+	address = vma->vm_start + ((pgoff - vma->vm_pgoff) << PAGE_SHIFT);
+	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
+	return address;
+}
+
 /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
-- 
2.34.1



