Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DD1150322
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2019 09:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbfFXHXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Jun 2019 03:23:45 -0400
Received: from sonic311-23.consmr.mail.gq1.yahoo.com ([98.137.65.204]:42230
        "EHLO sonic311-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727646AbfFXHXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Jun 2019 03:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1561361022; bh=sq0VrL1Z2MCK2lZQBNlmgC2HtOspHWio4sywSI6WP08=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=js/QHrfuLqxgpDZedsfi8QZjQXYA3oliRYkVXR+1taQQJeynjTc8BmwkXxhLKq1T+FvS18rYQMIVe30pIdFi82NymJEXiY+5B1Hbq+Y3/z44HbuV2dIUHnZEXg8hHvJMTX7EHxJjFBsqVvI6tMmzEt5cL6+NfVsSowSUJZP4E/ei2PbffW365dB9wjpAOtUkyLIczALu4fMIo5zlpcfKMBHghfLgNWSHhZ5TErKm56rRojWOYu/fY9TGFBstY8j7mOETL+t4bLzTncJJFHTXc/qCiwP8pfQdvVux4DrCyP8VH1xFwbLAxZZ101nmy2xw3rZqDANF0zg79dzARhWJ/Q==
X-YMail-OSG: AdDoJOcVM1naV2b47LDiq0xcIP0PxQuKnogR_RJ2q2IPosKP.11yzOivBVyKyT7
 QCFqlcPnx.iUOEPTph3Da.0nCjJ7iwkhGF00hm36YOR6y7FoXk0rwm2_w0Bgn_bG2E5nLCKgujIe
 w1YUKRomjAbEwyi6XJadaVWk.sTuFYshlNKv.ozTkL0ADeG2Gl8eLmR2NOUhvTBlw4YG2e58dgvm
 5Za6AaKY9ukyFFryDlHJiDExXh1beuN5d_J7z01l26aAyRe0scEqSIKkLiDlL81u6BNvJWfAf9pY
 OerPEGzyt4HuazBwf0AWJ.QMPCccmZpQS1fVNte1g7jgEMt9nBg5NwsDiHfH8Fxo8D790O3SqKcP
 wqXMsMgHm4AuqMe6dnHbxJMnA2y9ydhT86lQt7j0ccE_y_EkaMBxmScfn1ytCioiM_Od4gSRRJRK
 QuittpYC39EWirD1SXf0C5yknWarEeNrYYmLRYI.np_4xAqKESk69.i.nYFFD_rZIT4MKf5qNKSm
 fdqYw23dnyIJMpxhHrwjWM_kuDONXcI13xszDmuWFIidE8Ao16Xz_EmDEQEQr1kPJf9lmSH0poNt
 gsBEejV5Wh1mGfCHUhElCB0nSPmMg4TQbc.LdCDhUYbzgwqe0RsjYcoo_OfF.T5xaG72v99f3sq4
 UMCuD1GODrLAvEqy_cVyT8FrtThFeFrb1loNRExGjMAbI4B9Zo14Vp0guFNeujTwZZeF9z0r8h17
 DS9nRAWGqlLiHyKRIQl3QvqensEqtz7FS1Dv4txGqliq4YXrvRsaMdUa5RtUCSQliTqmQL58PPYG
 h66SIHOU0zMKhhxvmbk6thUOUiLtiejMUtu8x1D.gOQlBI_UQc9.ZUeDMdW6rpdiSrYL9PCgOrV4
 e.pMppkVmvGBhFIvcw3jYN7wAa3._61le_KvKDnn.EPS367VP8YJpBD87fB5jKpsAWrR1kVjFBwF
 uU7Z_kP_Pddq4gYNrt74.pTtA1Wm6qJCz9PzzZqR_oNn_AIWWmgV7rp1xzWfLqDN0kx6w1SMykoq
 aLQ8p.NOPmWfXAxVXeZMMt9sw19W4d2ONjjTwlStMDPrBz1WlUXM8sSZXlUuesIz9d3o4Ut.b8MJ
 oKPIsu9IvTvnZoWM394RgtwN6VSIPP2Dia6f18qrvQfgrKVgDL2_sjl5UJorQK837uMbB969BIEh
 ceeJKCj9v2MoxO.VzsunCT7iqiv34Msx8WV2BwyS9mupB9gxyCDhN3Q3V9OHDHh4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 24 Jun 2019 07:23:42 +0000
Received: from 116.226.249.212 (EHLO localhost.localdomain) ([116.226.249.212])
          by smtp415.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 6d1878af4efb7cadb69856afeea1b125;
          Mon, 24 Jun 2019 07:23:38 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Miao Xie <miaoxie@huawei.com>,
        Fang Wei <fangwei1@huawei.com>, Du Wei <weidu.du@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 3/8] staging: erofs: move per-CPU buffers implementation to utils.c
Date:   Mon, 24 Jun 2019 15:22:53 +0800
Message-Id: <20190624072258.28362-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190624072258.28362-1-hsiangkao@aol.com>
References: <20190624072258.28362-1-hsiangkao@aol.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

This patch moves per-CPU buffers to utils.c in order for
the upcoming generic decompression framework to use it.

Note that I tried to use generic per-CPU buffer or
per-CPU page approaches to clean up further, but obvious
performanace regression (about 2% for sequential read) was
observed.

Therefore let's leave it as it is instead, just move
to utils.c and I'll try to dig into the root cause later.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
change log v3:
 - handle error code if returned by erofs_get_pcpubuf() pointed out by Chao.

 drivers/staging/erofs/internal.h      | 26 +++++++++++++++++++
 drivers/staging/erofs/unzip_vle.c     |  5 ++--
 drivers/staging/erofs/unzip_vle.h     |  4 +--
 drivers/staging/erofs/unzip_vle_lz4.c | 37 +++++++++++----------------
 drivers/staging/erofs/utils.c         | 12 +++++++++
 5 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
index f3063b13c117..dcbe6f7f5dae 100644
--- a/drivers/staging/erofs/internal.h
+++ b/drivers/staging/erofs/internal.h
@@ -321,6 +321,16 @@ static inline void z_erofs_exit_zip_subsystem(void) {}
 
 /* page count of a compressed cluster */
 #define erofs_clusterpages(sbi)         ((1 << (sbi)->clusterbits) / PAGE_SIZE)
+#define Z_EROFS_NR_INLINE_PAGEVECS      3
+
+#if (Z_EROFS_CLUSTER_MAX_PAGES > Z_EROFS_NR_INLINE_PAGEVECS)
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_CLUSTER_MAX_PAGES
+#else
+#define EROFS_PCPUBUF_NR_PAGES          Z_EROFS_NR_INLINE_PAGEVECS
+#endif
+
+#else
+#define EROFS_PCPUBUF_NR_PAGES          0
 #endif
 
 typedef u64 erofs_off_t;
@@ -608,6 +618,22 @@ static inline void erofs_vunmap(const void *mem, unsigned int count)
 extern struct shrinker erofs_shrinker_info;
 
 struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp);
+
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+void *erofs_get_pcpubuf(unsigned int pagenr);
+#define erofs_put_pcpubuf(buf) do { \
+	(void)&(buf);	\
+	preempt_enable();	\
+} while (0)
+#else
+static inline void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+
+#define erofs_put_pcpubuf(buf) do {} while (0)
+#endif
+
 void erofs_register_super(struct super_block *sb);
 void erofs_unregister_super(struct super_block *sb);
 
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 8aea938172df..08f2d4302ecb 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -552,8 +552,7 @@ static int z_erofs_vle_work_iter_begin(struct z_erofs_vle_work_builder *builder,
 	if (IS_ERR(work))
 		return PTR_ERR(work);
 got_it:
-	z_erofs_pagevec_ctor_init(&builder->vector,
-				  Z_EROFS_VLE_INLINE_PAGEVECS,
+	z_erofs_pagevec_ctor_init(&builder->vector, Z_EROFS_NR_INLINE_PAGEVECS,
 				  work->pagevec, work->vcnt);
 
 	if (builder->role >= Z_EROFS_VLE_WORK_PRIMARY) {
@@ -936,7 +935,7 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	for (i = 0; i < nr_pages; ++i)
 		pages[i] = NULL;
 
-	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_VLE_INLINE_PAGEVECS,
+	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
 				  work->pagevec, 0);
 
 	for (i = 0; i < work->vcnt; ++i) {
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 902e67d04029..9c53009700cf 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -44,8 +44,6 @@ static inline bool z_erofs_gather_if_stagingpage(struct list_head *page_pool,
  *
  */
 
-#define Z_EROFS_VLE_INLINE_PAGEVECS     3
-
 struct z_erofs_vle_work {
 	struct mutex lock;
 
@@ -58,7 +56,7 @@ struct z_erofs_vle_work {
 
 	union {
 		/* L: pagevec */
-		erofs_vtptr_t pagevec[Z_EROFS_VLE_INLINE_PAGEVECS];
+		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
 		struct rcu_head rcu;
 	};
 };
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index 0daac9b984a8..02e694d9288d 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -34,16 +34,6 @@ static int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen)
 	return -EIO;
 }
 
-#if Z_EROFS_CLUSTER_MAX_PAGES > Z_EROFS_VLE_INLINE_PAGEVECS
-#define EROFS_PERCPU_NR_PAGES   Z_EROFS_CLUSTER_MAX_PAGES
-#else
-#define EROFS_PERCPU_NR_PAGES   Z_EROFS_VLE_INLINE_PAGEVECS
-#endif
-
-static struct {
-	char data[PAGE_SIZE * EROFS_PERCPU_NR_PAGES];
-} erofs_pcpubuf[NR_CPUS];
-
 int z_erofs_vle_plain_copy(struct page **compressed_pages,
 			   unsigned int clusterpages,
 			   struct page **pages,
@@ -56,8 +46,9 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 	char *percpu_data;
 	bool mirrored[Z_EROFS_CLUSTER_MAX_PAGES] = { 0 };
 
-	preempt_disable();
-	percpu_data = erofs_pcpubuf[smp_processor_id()].data;
+	percpu_data = erofs_get_pcpubuf(0);
+	if (IS_ERR(percpu_data))
+		return PTR_ERR(percpu_data);
 
 	j = 0;
 	for (i = 0; i < nr_pages; j = i++) {
@@ -117,7 +108,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 	if (src && !mirrored[j])
 		kunmap_atomic(src);
 
-	preempt_enable();
+	erofs_put_pcpubuf(percpu_data);
 	return 0;
 }
 
@@ -131,7 +122,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	unsigned int nr_pages, i, j;
 	int ret;
 
-	if (outlen + pageofs > EROFS_PERCPU_NR_PAGES * PAGE_SIZE)
+	if (outlen + pageofs > EROFS_PCPUBUF_NR_PAGES * PAGE_SIZE)
 		return -ENOTSUPP;
 
 	nr_pages = DIV_ROUND_UP(outlen + pageofs, PAGE_SIZE);
@@ -144,8 +135,9 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 			return -ENOMEM;
 	}
 
-	preempt_disable();
-	vout = erofs_pcpubuf[smp_processor_id()].data;
+	vout = erofs_get_pcpubuf(0);
+	if (IS_ERR(vout))
+		return PTR_ERR(vout);
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
 				clusterpages * PAGE_SIZE, outlen);
@@ -174,7 +166,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	}
 
 out:
-	preempt_enable();
+	erofs_put_pcpubuf(vout);
 
 	if (clusterpages == 1)
 		kunmap_atomic(vin);
@@ -196,8 +188,9 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	int ret;
 
 	if (overlapped) {
-		preempt_disable();
-		vin = erofs_pcpubuf[smp_processor_id()].data;
+		vin = erofs_get_pcpubuf(0);
+		if (IS_ERR(vin))
+			return PTR_ERR(vin);
 
 		for (i = 0; i < clusterpages; ++i) {
 			void *t = kmap_atomic(compressed_pages[i]);
@@ -216,13 +209,13 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	if (ret > 0)
 		ret = 0;
 
-	if (!overlapped) {
+	if (overlapped) {
+		erofs_put_pcpubuf(vin);
+	} else {
 		if (clusterpages == 1)
 			kunmap_atomic(vin);
 		else
 			erofs_vunmap(vin, clusterpages);
-	} else {
-		preempt_enable();
 	}
 	return ret;
 }
diff --git a/drivers/staging/erofs/utils.c b/drivers/staging/erofs/utils.c
index 3e7d30b6de1d..4bbd3bf34acd 100644
--- a/drivers/staging/erofs/utils.c
+++ b/drivers/staging/erofs/utils.c
@@ -27,6 +27,18 @@ struct page *erofs_allocpage(struct list_head *pool, gfp_t gfp)
 	return page;
 }
 
+#if (EROFS_PCPUBUF_NR_PAGES > 0)
+static struct {
+	u8 data[PAGE_SIZE * EROFS_PCPUBUF_NR_PAGES];
+} ____cacheline_aligned_in_smp erofs_pcpubuf[NR_CPUS];
+
+void *erofs_get_pcpubuf(unsigned int pagenr)
+{
+	preempt_disable();
+	return &erofs_pcpubuf[smp_processor_id()].data[pagenr * PAGE_SIZE];
+}
+#endif
+
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
-- 
2.17.1

