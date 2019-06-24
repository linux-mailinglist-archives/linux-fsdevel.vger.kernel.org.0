Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6425032A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfFXHYG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:24:06 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32]:34944 "EHLO
        sonic316-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbfFXHYF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361044; bh=Ri5Zo+Enuv8UT43ghcn8ilD6kuVGnnCkc2qbY9XwMFE=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=ZW88v/dbVBO84fybq6iLrUgbm0cOP5bXaUAUedvzmovWy0NqYCSYjRLsSWuJ14KflcfVHanUzxoKtXBXnt5EL4qWwqKd+EOGSZtwb9JY5OLOCZSwksRt4dsR7FzyPUQLAr09UHjY8SoUZuKJWXXogogh4hg8ClKXyBpvT34o1kqTMWqI2Q0inSlXIfrBG/J3lgZdBnyr8Nne3a+kX79vHAkAgYsDFQVIYqzFxxkkuBFrjsL94YLKvm+1EODJAJ0mM3VCHYbIVMd2lI0ltJSyUfZoccwN29QClE08HNsWC5lqNf3r1ynsRR4BjmVBI3+TTMHKvJcZMlfOidug/5n0WQ==
X-YMail-OSG: 4xODsLIVM1ngmTo5gekBmC7WdH8yCS8nz7IWLTMDO7QphMBaCaPnWgtrYNXZkeB
 wppP2_1cK3tIiKu_iWeHxADWGqsRqCWh3_Yn4ZibjjT2AdD.Y8zh0mRyKpEl66zpFRcMueVeoXT4
 GSV.650hQ7AyD9oJRRHVJ7ro5365bL.TFvNWg25LwO3joBqt1PRkPap3c1oapU0g.a4m1ZIMTfpz
 H0f0MqONzmkHnjkZgcPQLAMYzhFwepo5dn4PaGPc_.Q_XTfIUX0K_Irux620E8iOd2OszvJRhl3F
 jUtMqplf946HNe3RD6WvKNaINaFnLpPjXyzktmb_JOggUVxbIh1VTz0n8svbyk1jukJ6V47X.hR4
 UIP4KW3nn7GmM9xRGUzucuARMMJNz1TpRN77LWuYZ_VIyjskxgGlhYADj6c1Qs4rEulqFj_3wXZm
 6WHr97KCU_5new1lpxvgJ1_FOaGPyOCi9GyEHq1xnTGoF.BBF2cZxVwN..cEJcijrGGRBdk3aVRe
 .FkAGGN1ETv59.AY.4kZHwWHQRGnk2CwMHAp.d.f_6d4hw2hN0zDcxYijFnAviIhA_0RCAOXj9FK
 7J79FxWPJTShfkpRI.lBuZLP1CdlV2ZSNz0b4F49VuTiLCtK8wOraxZi7ygz7mKLB3cXn7SlSQ87
 Ch5agfpyztfNAjH39QZenjdCaX0ikqeDXndFZgLed96MxrD8aJehbC4.NdG4BWA7YZ0l9AGepBBo
 drQ1OEIbJMET6U1MvGar7psMBN.aun758eLHb2vKLRSm.eU6cORWMOh7sGilzr5.crt8E4g6Ot5H
 DCiphfr7dasd7oaUuPE2C2QizpsaNRqaiC1FeNIieU9bKG29UFa0i5CmWeT_SuA4HRoFbS0WTX4K
 n3CdGlRPgPYA7ZxnLb2NL5cifruvKnKAWgg_30q10UHXfhBTtTboevy6qkkBKTqjTmDYWpK4pqw9
 YNGzHPS7VDXUV_jGwf1ilfg0l31bq67wu4PHCrWUc.nBm2HUVrKWRaD7kanHPD9LWWXDt._q78Ml
 .0J0zAZX5Wc_KyjFhPZyIRYzgFQBCt1eQ2Qd0iEKupRuOiv5O.5lbZNCHgakUioKKEjlIcKkEalf
 LbtwrWOSKo6DXaZw0PErLE9U6HphmYwvbOk5F4VsorbrSwuACYMPaL8rTsTVK9xKMCmRb2P4JFmj
 dYZ.WNvuXPAU7pHi_oDorV5hln9d8SPffU1fyqBhsVci6IxdXBkxSRuvr3c1TI5qgIA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:24:04 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:24:03 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 7/8] staging: erofs: switch to new decompression backend
Date:   Mon, 24 Jun 2019 15:22:57 +0800
Message-Id: <20190624072258.28362-8-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch integrates new decompression framework to
erofs decompression path, and remove the old
decompression implementation as well.

On kirin980 platform, sequential read is slightly
improved to 778MiB/s after the new decompression
backend is used.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Makefile        |   2 +-
 drivers/staging/erofs/internal.h      |   6 -
 drivers/staging/erofs/unzip_vle.c     |  59 +++----
 drivers/staging/erofs/unzip_vle.h     |  15 +-
 drivers/staging/erofs/unzip_vle_lz4.c | 222 --------------------------
 5 files changed, 24 insertions(+), 280 deletions(-)
 delete mode 100644 drivers/staging/erofs/unzip_vle_lz4.c

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index adeb5d6e2668..e704d9e51514 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o zmap.o decompressor.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o zmap.o decompressor.o
 
diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index dcbe6f7f5dae..6c8767d4a1d5 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -321,14 +321,8 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 
 /* page count of a compressed cluster */
 #define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
-#define Z_EROFS_NR_INLINE_PAGEVECS      3
 
-#if (Z_EROFS_CLUSTER_MAX_PAGES > Z_EROFS_NR_INLINE_PAGEVECS)
 #define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_NR_INLINE_PAGEVECS
-#endif
-
 #else
 #define EROFS_PCPUBUF_NR_PAGES          0
 #endif
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index d95f985936b6..cb870b83f3c8 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -897,12 +897,12 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	unsigned int sparsemem_pages = 0;
 	struct page *pages_onstack[Z_EROFS_VLE_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
-	unsigned int i, llen;
+	unsigned int algorithm;
+	unsigned int i, outputsize;
 
 	enum z_erofs_page_type page_type;
 	bool overlapped;
 	struct z_erofs_vle_work *work;
-	void *vout;
 	int err;
 
 	might_sleep();
@@ -1009,43 +1009,26 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (unlikely(err))
 		goto out;
 
-	llen = (nr_pages << PAGE_SHIFT) - work->pageofs;
-
-	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN) {
-		err = z_erofs_vle_plain_copy(compressed_pages, clusterpages,
-					     pages, nr_pages, work->pageofs);
-		goto out;
-	}
-
-	if (llen > grp->llen)
-		llen = grp->llen;
-
-	err = z_erofs_vle_unzip_fast_percpu(compressed_pages, clusterpages,
-					    pages, llen, work->pageofs);
-	if (err != -ENOTSUPP)
-		goto out;
-
-	if (sparsemem_pages >= nr_pages)
-		goto skip_allocpage;
-
-	for (i = 0; i < nr_pages; ++i) {
-		if (pages[i])
-			continue;
-
-		pages[i] = __stagingpage_alloc(page_pool, GFP_NOFS);
-	}
-
-skip_allocpage:
-	vout = erofs_vmap(pages, nr_pages);
-	if (!vout) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = z_erofs_vle_unzip_vmap(compressed_pages, clusterpages, vout,
-				     llen, work->pageofs, overlapped);
+	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen)
+		outputsize = grp->llen;
+	else
+		outputsize = (nr_pages << PAGE_SHIFT) - work->pageofs;
 
-	erofs_vunmap(vout, nr_pages);
+	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN)
+		algorithm = Z_EROFS_COMPRESSION_SHIFTED;
+	else
+		algorithm = Z_EROFS_COMPRESSION_LZ4;
+
+	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.sb = sb,
+					.in = compressed_pages,
+					.out = pages,
+					.pageofs_out = work->pageofs,
+					.inputsize = PAGE_SIZE,
+					.outputsize = outputsize,
+					.alg = algorithm,
+					.inplace_io = overlapped,
+					.partial_decoding = true }, page_pool);
 
 out:
 	/* must handle all compressed pages before endding pages */
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 6c3e0deb63e7..a2d9b60beebd 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -16,6 +16,8 @@
 #include "internal.h"
 #include "unzip_pagevec.h"
 
+#define Z_EROFS_NR_INLINE_PAGEVECS      3
+
 /*
  * Structure fields follow one of the following exclusion rules.
  *
@@ -189,18 +191,5 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VLE_VMAP_GLOBAL_PAGES	2048
 
-/* unzip_vle_lz4.c */
-int z_erofs_vle_plain_copy(struct page **compressed_pages,
-			   unsigned int clusterpages, struct page **pages,
-			   unsigned int nr_pages, unsigned short pageofs);
-int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
-				  unsigned int clusterpages,
-				  struct page **pages, unsigned int outlen,
-				  unsigned short pageofs);
-int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   void *vaddr, unsigned int llen,
-			   unsigned short pageofs, bool overlapped);
-
 #endif
 
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
deleted file mode 100644
index 02e694d9288d..000000000000
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ /dev/null
@@ -1,222 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/drivers/staging/erofs/unzip_vle_lz4.c
- *
- * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
- */
-#include "unzip_vle.h"
-#include <linux/lz4.h>
-
-static int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret = LZ4_decompress_safe_partial(in, out, inlen, outlen, outlen);
-
-	if (ret >= 0)
-		return ret;
-
-	/*
-	 * LZ4_decompress_safe_partial will return an error code
-	 * (< 0) if decompression failed
-	 */
-	errln("%s, failed to decompress, in[%p, %zu] outlen[%p, %zu]",
-	      __func__, in, inlen, out, outlen);
-	WARN_ON(1);
-	print_hex_dump(KERN_DEBUG, "raw data [in]: ", DUMP_PREFIX_OFFSET,
-		       16, 1, in, inlen, true);
-	print_hex_dump(KERN_DEBUG, "raw data [out]: ", DUMP_PREFIX_OFFSET,
-		       16, 1, out, outlen, true);
-	return -EIO;
-}
-
-int z_erofs_vle_plain_copy(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   struct page **pages,
-			   unsigned int nr_pages,
-			   unsigned short pageofs)
-{
-	unsigned int i, j;
-	void *src = NULL;
-	const unsigned int righthalf = PAGE_SIZE - pageofs;
-	char *percpu_data;
-	bool mirrored[Z_EROFS_CLUSTER_MAX_PAGES] = { 0 };
-
-	percpu_data = erofs_get_pcpubuf(0);
-	if (IS_ERR(percpu_data))
-		return PTR_ERR(percpu_data);
-
-	j = 0;
-	for (i = 0; i < nr_pages; j = i++) {
-		struct page *page = pages[i];
-		void *dst;
-
-		if (!page) {
-			if (src) {
-				if (!mirrored[j])
-					kunmap_atomic(src);
-				src = NULL;
-			}
-			continue;
-		}
-
-		dst = kmap_atomic(page);
-
-		for (; j < clusterpages; ++j) {
-			if (compressed_pages[j] != page)
-				continue;
-
-			DBG_BUGON(mirrored[j]);
-			memcpy(percpu_data + j * PAGE_SIZE, dst, PAGE_SIZE);
-			mirrored[j] = true;
-			break;
-		}
-
-		if (i) {
-			if (!src)
-				src = mirrored[i - 1] ?
-					percpu_data + (i - 1) * PAGE_SIZE :
-					kmap_atomic(compressed_pages[i - 1]);
-
-			memcpy(dst, src + righthalf, pageofs);
-
-			if (!mirrored[i - 1])
-				kunmap_atomic(src);
-
-			if (unlikely(i >= clusterpages)) {
-				kunmap_atomic(dst);
-				break;
-			}
-		}
-
-		if (!righthalf) {
-			src = NULL;
-		} else {
-			src = mirrored[i] ? percpu_data + i * PAGE_SIZE :
-				kmap_atomic(compressed_pages[i]);
-
-			memcpy(dst + pageofs, src, righthalf);
-		}
-
-		kunmap_atomic(dst);
-	}
-
-	if (src && !mirrored[j])
-		kunmap_atomic(src);
-
-	erofs_put_pcpubuf(percpu_data);
-	return 0;
-}
-
-int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
-				  unsigned int clusterpages,
-				  struct page **pages,
-				  unsigned int outlen,
-				  unsigned short pageofs)
-{
-	void *vin, *vout;
-	unsigned int nr_pages, i, j;
-	int ret;
-
-	if (outlen + pageofs > EROFS_PCPUBUF_NR_PAGES * PAGE_SIZE)
-		return -ENOTSUPP;
-
-	nr_pages = DIV_ROUND_UP(outlen + pageofs, PAGE_SIZE);
-
-	if (clusterpages == 1) {
-		vin = kmap_atomic(compressed_pages[0]);
-	} else {
-		vin = erofs_vmap(compressed_pages, clusterpages);
-		if (!vin)
-			return -ENOMEM;
-	}
-
-	vout = erofs_get_pcpubuf(0);
-	if (IS_ERR(vout))
-		return PTR_ERR(vout);
-
-	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-				clusterpages * PAGE_SIZE, outlen);
-
-	if (ret < 0)
-		goto out;
-	ret = 0;
-
-	for (i = 0; i < nr_pages; ++i) {
-		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
-
-		if (pages[i]) {
-			if (clusterpages == 1 &&
-			    pages[i] == compressed_pages[0]) {
-				memcpy(vin + pageofs, vout + pageofs, j);
-			} else {
-				void *dst = kmap_atomic(pages[i]);
-
-				memcpy(dst + pageofs, vout + pageofs, j);
-				kunmap_atomic(dst);
-			}
-		}
-		vout += PAGE_SIZE;
-		outlen -= j;
-		pageofs = 0;
-	}
-
-out:
-	erofs_put_pcpubuf(vout);
-
-	if (clusterpages == 1)
-		kunmap_atomic(vin);
-	else
-		erofs_vunmap(vin, clusterpages);
-
-	return ret;
-}
-
-int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   void *vout,
-			   unsigned int llen,
-			   unsigned short pageofs,
-			   bool overlapped)
-{
-	void *vin;
-	unsigned int i;
-	int ret;
-
-	if (overlapped) {
-		vin = erofs_get_pcpubuf(0);
-		if (IS_ERR(vin))
-			return PTR_ERR(vin);
-
-		for (i = 0; i < clusterpages; ++i) {
-			void *t = kmap_atomic(compressed_pages[i]);
-
-			memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
-			kunmap_atomic(t);
-		}
-	} else if (clusterpages == 1) {
-		vin = kmap_atomic(compressed_pages[0]);
-	} else {
-		vin = erofs_vmap(compressed_pages, clusterpages);
-	}
-
-	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-				clusterpages * PAGE_SIZE, llen);
-	if (ret > 0)
-		ret = 0;
-
-	if (overlapped) {
-		erofs_put_pcpubuf(vin);
-	} else {
-		if (clusterpages == 1)
-			kunmap_atomic(vin);
-		else
-			erofs_vunmap(vin, clusterpages);
-	}
-	return ret;
-}
-
-- 
2.17.1

