Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4528F51EE44
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 May 2022 16:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiEHOkc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 May 2022 10:40:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbiEHOkX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 May 2022 10:40:23 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D451AE0BE;
        Sun,  8 May 2022 07:36:32 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3ABTxkxKMw4Thp17DvrR0glsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQnthWgl0D0AzTNJUWGFb/+PYWOnL9B0Odu08xkO7MeGm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79yEmjfjQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPcaoOCafiPg2SCU5wicG5f2+N1iBV83MaUW4OFyBnt?=
 =?us-ascii?q?E9OBeIzcIBjiHhuSzwbu8SuREhtkqM8TqeogYvxlIzTrZJfcgT4rKT6jD6Zlfx?=
 =?us-ascii?q?jhYrt9PGfLPT8sfZyBmYBnJb1tIIFh/IJ43mqGqwGb+dzlZoVeOjasx/2XXigd?=
 =?us-ascii?q?21dDFPNjKfdqFbcZYhECVoiTB5WuRKhUbMsGPjD+A2nGyj+TM2yThV+o6Dryk+?=
 =?us-ascii?q?+VqgHWXx2oOGFsXX179qv684ma4Rd5eLkk8/is1sbN08E2tU8m7UxCmyFaEtR4?=
 =?us-ascii?q?0X8FMVeE3gCmLw63F6kCZAXIFQSNKaN0OssI9Azct0zehndrvCHpksKC9TmiU/?=
 =?us-ascii?q?bOZ6zi1PEA9N2AFYSMbXA0t+MT4rcc/g3rnStdlDb7wgMb5FC/9xxiUoyUkwbY?=
 =?us-ascii?q?el8gG0+O851+vqzatoIXZCw04/APaWkq74Q5jIo2ofYql7R7c9/koBIKYSESR+?=
 =?us-ascii?q?WgKgOCA4+0US5KAjiqARKMKBr7Bz+iEKjr0k1NpHodn8zWr5m7leppfpix9THq?=
 =?us-ascii?q?FmO5slSTBOReV4F0OosQIeibCUEO+WKrpY+xC8EQqPY+NuijoU+dz?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AiiA6TayJNfSnfB4MsbVPKrPwyL1zdoMgy1kn?=
 =?us-ascii?q?xilNoRw8SKKlfqeV7ZImPH7P+U8ssR4b+exoVJPtfZqYz+8R3WBzB8bEYOCFgh?=
 =?us-ascii?q?rKEGgK1+KLqFeMJ8S9zJ846U4KSclD4bPLYmSS9fyKgjVQDexQveWvweS5g/vE?=
 =?us-ascii?q?1XdxQUVPY6Fk1Q1wDQGWCSRNNXJ7LKt8BJyB/dBGujblXXwWa/6wDn4DU/OGiM?=
 =?us-ascii?q?bMkPvdEGQ7Li9i+A+Tlimp9bK/NxCZ2y0VWzRJzaxn0UWtqX2A2pme?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124075737"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 08 May 2022 22:36:31 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 4C9FD4D1719C;
        Sun,  8 May 2022 22:36:31 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sun, 8 May 2022 22:36:30 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sun, 8 May 2022 22:36:29 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <linux-kernel@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <linux-mm@kvack.org>,
        <linux-fsdevel@vger.kernel.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <david@fromorbit.com>, <hch@infradead.org>, <jane.chu@oracle.com>,
        <rgoldwyn@suse.de>, <viro@zeniv.linux.org.uk>,
        <willy@infradead.org>, <naoya.horiguchi@nec.com>,
        <linmiaohe@huawei.com>, Ritesh Harjani <riteshh@linux.ibm.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v11 04/07] fsdax: Add dax_iomap_cow_copy() for dax zero
Date:   Sun, 8 May 2022 22:36:17 +0800
Message-ID: <20220508143620.1775214-12-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
References: <20220508143620.1775214-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 4C9FD4D1719C.A116D
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

Punch hole on a reflinked file needs dax_iomap_cow_copy() too.
Otherwise, data in not aligned area will be not correct.  So, add the
CoW operation for not aligned case in dax_memzero().

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>

==
This patch changed a lot when rebasing to next-20220504 branch.  Though it
has been tested by myself, I think it needs a re-review.
==
---
 fs/dax.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 78e26204697b..b3aa863e9fec 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1220,17 +1220,27 @@ static vm_fault_t dax_pmd_load_hole(struct xa_state *xas, struct vm_fault *vmf,
 }
 #endif /* CONFIG_FS_DAX_PMD */
 
-static int dax_memzero(struct dax_device *dax_dev, pgoff_t pgoff,
-		unsigned int offset, size_t size)
+static int dax_memzero(struct iomap_iter *iter, loff_t pos, size_t size)
 {
+	const struct iomap *iomap = &iter->iomap;
+	const struct iomap *srcmap = iomap_iter_srcmap(iter);
+	unsigned offset = offset_in_page(pos);
+	pgoff_t pgoff = dax_iomap_pgoff(iomap, pos);
 	void *kaddr;
 	long ret;
 
-	ret = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
-	if (ret > 0) {
-		memset(kaddr + offset, 0, size);
-		dax_flush(dax_dev, kaddr + offset, size);
-	}
+	ret = dax_direct_access(iomap->dax_dev, pgoff, 1, &kaddr, NULL);
+	if (ret < 0)
+		return ret;
+	memset(kaddr + offset, 0, size);
+	if (srcmap->addr != iomap->addr) {
+		ret = dax_iomap_cow_copy(pos, size, PAGE_SIZE, srcmap,
+					 kaddr);
+		if (ret < 0)
+			return ret;
+		dax_flush(iomap->dax_dev, kaddr, PAGE_SIZE);
+	} else
+		dax_flush(iomap->dax_dev, kaddr + offset, size);
 	return ret;
 }
 
@@ -1257,7 +1267,7 @@ static s64 dax_zero_iter(struct iomap_iter *iter, bool *did_zero)
 		if (IS_ALIGNED(pos, PAGE_SIZE) && size == PAGE_SIZE)
 			rc = dax_zero_page_range(iomap->dax_dev, pgoff, 1);
 		else
-			rc = dax_memzero(iomap->dax_dev, pgoff, offset, size);
+			rc = dax_memzero(iter, pos, size);
 		dax_read_unlock(id);
 
 		if (rc < 0)
-- 
2.35.1



