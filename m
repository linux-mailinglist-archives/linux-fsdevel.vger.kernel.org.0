Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E137B41A8D5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 08:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239075AbhI1GZh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 02:25:37 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:6283 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S239053AbhI1GZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 02:25:32 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AzxInbKIOS5sSqRVzFE+RwZQlxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHC60zkl1GFVyDEbWjuFa6mOajTwKo8nPo6/pkIHuJPQxoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+BzvuRGuK59yAkhPvYHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpeeWfynu6qR/yGWDKRMA2c5GAEgoPIEw9PxwBGZ?=
 =?us-ascii?q?U//0EbjsKa3irmOOyxKOTS+9inM0vIcDneoQFtRlIwTjfS/RgXpHHR6TD4MRw3?=
 =?us-ascii?q?TEsi8QIFvHbD+IVayVoahvoYBBVPFoTTpUkk4+AnHjjfiZYqHqRpKwq8y7Sxgk?=
 =?us-ascii?q?327/oWPLTZNCLQMB9mkeDunmA+2X/HwFcONGBoRKF+XKEgvTT2y/2MKoIG7q8+?=
 =?us-ascii?q?uF7hnWI23ceThEbPXO/oP+kmguwQN5SNUEQ0jQhoLJ090GxSNT5GRqirxasuh8?=
 =?us-ascii?q?aRsoVEOAg7gyJ4rTb7hzfBWUeSDNFLts8u6ceQT0sy0/Mj93yLSJgvafTSn+H8?=
 =?us-ascii?q?LqQ6zSoNkA9M24YYgcWQA0E/Z/noYcunlTIVNklDa3dszFfMVkc2BjT9G5n2ep?=
 =?us-ascii?q?V1pVNis2GEZn8q2rEjvD0osQdu207hl6Y0z4=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AunpnqKNbIuqYKcBcTv2jsMiBIKoaSvp037BL?=
 =?us-ascii?q?7TEUdfUxSKGlfq+V8sjzqiWftN98YhAdcLO7Scy9qBHnhP1ICOAqVN/MYOCMgh?=
 =?us-ascii?q?rLEGgN1+vf6gylMyj/28oY7q14bpV5YeeaMXFKyer8/ym0euxN/OW6?=
X-IronPort-AV: E=Sophos;i="5.85,328,1624291200"; 
   d="scan'208";a="115096993"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 28 Sep 2021 14:23:51 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 8836C4D0DC83;
        Tue, 28 Sep 2021 14:23:50 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:44 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 28 Sep 2021 14:23:43 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 28 Sep 2021 14:23:42 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <dan.j.williams@intel.com>, <djwong@kernel.org>, <hch@lst.de>,
        <linux-xfs@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, <david@fromorbit.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rgoldwyn@suse.de>,
        <viro@zeniv.linux.org.uk>, <willy@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH v10 5/8] fsdax: Add dax_iomap_cow_copy() for dax_iomap_zero
Date:   Tue, 28 Sep 2021 14:23:08 +0800
Message-ID: <20210928062311.4012070-6-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
References: <20210928062311.4012070-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 8836C4D0DC83.AED86
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
X-Spam-Status: No
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Punch hole on a reflinked file needs dax_iomap_cow_copy() too.
Otherwise, data in not aligned area will be not correct.  So, add the
CoW operation for not aligned case in dax_iomap_zero().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/dax.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index debe459680f2..5379de8ad0c7 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1212,6 +1212,7 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 s64 dax_iomap_zero(const struct iomap_iter *iter, loff_t pos, u64 length)
 {
 	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = &iter->srcmap;
 	sector_t sector = iomap_sector(iomap, pos & PAGE_MASK);
 	pgoff_t pgoff;
 	long rc, id;
@@ -1230,21 +1231,27 @@ s64 dax_iomap_zero(const struct iomap_iter *iter, loff_t pos, u64 length)
 
 	id = dax_read_lock();
 
-	if (page_aligned)
+	if (page_aligned) {
 		rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
-	else
-		rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
-	if (rc < 0) {
-		dax_read_unlock(id);
-		return rc;
+		goto out;
 	}
 
-	if (!page_aligned) {
-		memset(kaddr + offset, 0, size);
+	rc = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
+	if (rc < 0)
+		goto out;
+	memset(kaddr + offset, 0, size);
+	if (srcmap->addr != IOMAP_HOLE && srcmap->addr != iomap->addr) {
+		rc = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
+					kaddr);
+		if (rc < 0)
+			goto out;
+		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
+	} else
 		dax_flush(iomap->dax_dev, kaddr + offset, size);
-	}
+
+out:
 	dax_read_unlock(id);
-	return size;
+	return rc < 0 ? rc : size;
 }
 
 static loff_t dax_iomap_iter(const struct iomap_iter *iomi,
-- 
2.33.0



