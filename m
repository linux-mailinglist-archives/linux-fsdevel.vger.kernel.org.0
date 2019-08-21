Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 619AF972BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbfHUGnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:43:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10161 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbfHUGmb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:31 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821064227epoutp01be42e9d2416edec794c39181c9de1bd4~83Px_IBtr1005210052epoutp019
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821064227epoutp01be42e9d2416edec794c39181c9de1bd4~83Px_IBtr1005210052epoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369747;
        bh=RufiVNT5+Lb2KOyQZLDZhzg9HYJCDXGJWlH0uDh9Bn0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=clS10835/affNGODFrWo2NUHKtnZdFS5lP+/Aw0A0qBoqhK7QHQ73e6PeySgDsPPs
         hA3xePmpCtsxVnPnPa6b8QZe6cCy7LM52IiYYce3ekI0ze+cbhc8gyydsTEqHxCCoq
         ZVGxIeV2mqit5FKe6+6VHbiGTkuA5I9Z+1LrNWcQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190821064226epcas2p1753a8812f10c55908a889b5f613f6935~83PxEH5Fd0242202422epcas2p1s;
        Wed, 21 Aug 2019 06:42:26 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.189]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46Cyl36Fy8zMqYkf; Wed, 21 Aug
        2019 06:42:23 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        7C.0F.04112.FC7EC5D5; Wed, 21 Aug 2019 15:42:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821064223epcas2p18a14724427711e22c6c76b24bce1c8e0~83PuUy3oh1228312283epcas2p1R;
        Wed, 21 Aug 2019 06:42:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821064223epsmtrp10047dd5905b9e4fa8ae715493939ee58~83PuTsqjI2011020110epsmtrp1X;
        Wed, 21 Aug 2019 06:42:23 +0000 (GMT)
X-AuditID: b6c32a48-f1fff70000001010-90-5d5ce7cfaa31
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8D.02.03706.FC7EC5D5; Wed, 21 Aug 2019 15:42:23 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064222epsmtip169b78fa5e45597d9ba7e035be2ddd798~83PtgT-AE0460704607epsmtip1G;
        Wed, 21 Aug 2019 06:42:22 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        <linux-mmc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Chao Yu'" <chao@kernel.org>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Andreas Dilger'" <adilger.kernel@dilger.ca>,
        "'Theodore Ts'o'" <tytso@mit.edu>, <dm-devel@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>,
        "'Alasdair Kergon'" <agk@redhat.com>,
        "'Jens Axboe'" <axboe@kernel.dk>,
        "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Kukjin Kim'" <kgene@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 4/9] mmc: dw_mmc-exynos: support FMP
Date:   Wed, 21 Aug 2019 15:42:22 +0900
Message-ID: <004001d557eb$9697f5d0$c3c7e170$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6FzCeDd/I620REGbQnBHWgE56Q==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjOuV8taJdr6bZjs7h6h1vAgb0d7Q4OFpPpvIkuqdmPJSphN3BH
        if2yt3Uwk0mUVUQEpjMZbSWEmUW7mc7SuCKUmeIkKKzLmN1AYYswP2CuCyALOHEtt2T8e973
        fZ7zvE/eHDmu9MnU8kqrU3BYeTNDZRKXenP0ebF7e0u08dM69Gi2jkCB69dw9NVoE4VunB7E
        kC9WS6DIX14SXej+F0fHJ19AEwEPjn5dcJOoaXwKR7HYNzIUHI+TKDKyEf02No+hltbbFPqp
        fTuabJ0jUHekn0BDl30Uuvq0CaDPYz0Ycl98BNAnDfMy1HfhvS1rudD5YYyr7fiQu3RlAzc0
        6OKC/mMUdzveTXEdZw9xXW0zGHd44HucS/TcpLjGkB9wM8F1xtW7zUUmgS8XHBrBWmYrr7RW
        FDM73i19q1Rv0LJ5bCF6ndFYeYtQzGzdacx7u9KczM5oDvBmV7Jl5EWR2fRmkcPmcgoak010
        FjOCvdxsZ1l7vshbRJe1Ir/MZtnMarU6fZL5vtk0OjVN2e/lVHXFD4MaMLC+HmTIIV0A/znS
        Q9aDTLmSDgPYOz6LS8U0gD/eaU0XcwCeHwxiyxJvuD09iABYk6jDpOIBgIudM2SKRdEbYUef
        H6QGKroeg72Nx6lUgdOLMjgxHSVSrKzkW2cW+pcwQW+A34WeUimsoAvh7IkWTMJrYH/LxBIH
        p1+E3z704dIeGhgenAIprKLz4czcQJqjgt5j7qX9IP1EBhe7RghJsBWeqE2kQ2TByb6QTMJq
        +KDJncaH4M0vv5BJ4gYABxaWB69Bz92jSTd50iEHBi5vSkFIvwSvjqR9n4F1vU9kUlsB69xK
        SZgNz0wPYVJbDf9u+Fhqc3D87M9kM1jvWRHSsyKkZ0UYz/+2bYDwg+cEu2ipEESdvWDluYNg
        6WfkcmFw5YedUUDLAbNaER7eU6Ik+QNitSUKoBxnVIoq3+4SpaKcr/5IcNhKHS6zIEaBPnmD
        T3H1s2W25D+zOktZvc5g0Bbqkd6gQ8zziuCq4b1KuoJ3CvsEwS44lnWYPENdA2QO48uv7hfZ
        yCpN7n6nlS+q7jR36NsSgV9O/bGZzGo/yLCn+h9/VqN7SK29futip+FWZllxa4m3sfncwYLH
        TLNprNCt2bOODFz74J0b9wnv7/vGQDzjyGhf950tRu0O/3zPG9lHE7uKqqJ3XzFtI8XQtsBJ
        z/01Yu7X8eyTf6qaGUI08Wwu7hD5/wBB5vuoLwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWy7bCSnO755zGxBqe3S1h8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBl3H39ia3guWbF7mtNjA2MZxS7GDk5
        JARMJGbvWMQMYgsJ7GaU+D27GCIuJbG1fQ8zhC0scb/lCGsXIxdQzXNGiW+TG1hBEmwC2hKb
        j69iBEmICExgkviz9SEjSIJZYBqHxK4P4iC2MNCGub9OsoDYLAKqEvu3/GcDsXkFLCW+9M5k
        grAFJU7OfAJUwwHUqyfRthFqjLzE9rdzoI5QkNhx9jVYXASo5PO3MywQNSISszvbmCcwCs5C
        MmkWwqRZSCbNQtKxgJFlFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcBLQ0tzBeHlJ
        /CFGAQ5GJR7eHTejY4VYE8uKK3MPMUpwMCuJ8FbMiYoV4k1JrKxKLcqPLyrNSS0+xCjNwaIk
        zvs071ikkEB6YklqdmpqQWoRTJaJg1OqgVHhnceZwqzN89gnLRBa+uNUtFhtgx+r7833Ra3H
        Pk2Ve70h+GeXM8PXJm5T0/IHW018C2r0Toiryvd2cf6+saswlGdu0WK2DD0Fl4vVR51vOoRc
        PPrzidzTjqlut7s5m912dgVPeyi5Uucgi+N1je4DrbY39JpU66NZak7u22eZvtF/3zXldiWW
        4oxEQy3mouJEAAakvEn+AgAA
X-CMS-MailID: 20190821064223epcas2p18a14724427711e22c6c76b24bce1c8e0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064223epcas2p18a14724427711e22c6c76b24bce1c8e0
References: <CGME20190821064223epcas2p18a14724427711e22c6c76b24bce1c8e0@epcas2p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exynos MMC uses FMP to encrypt data stored on MMC device.
FMP H/W reads crypto information from MMC descriptor.
So, when using FMP H/W, the format of MMC descriptor should be extended.
The FMP driver is registered with the diskcipher algorithm,
so exynos MMC calls diskcipher API to use FMP.

Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/mmc/host/Kconfig         |  8 ++++++
 drivers/mmc/host/dw_mmc-exynos.c | 62
++++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/dw_mmc.c        | 26 +++++++++++++++++
 3 files changed, 96 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 14d89a1..f6c5a54 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -761,6 +761,14 @@ config MMC_DW_EXYNOS
 	  Synopsys DesignWare Memory Card Interface driver. Select this
option
 	  for platforms based on Exynos4 and Exynos5 SoC's.
 
+config MMC_DW_EXYNOS_FMP
+	tristate "EXYNOS Flash Memory Protector for MMC_DW"
+	depends on MMC_DW_EXYNOS
+	---help---
+	  This selects the EXYNOS MMC_DW FMP Driver.
+
+	  If you have a controller with this interface, say Y or M here.
+
 config MMC_DW_HI3798CV200
 	tristate "Hi3798CV200 specific extensions for Synopsys DW Memory
Card Interface"
 	depends on MMC_DW
diff --git a/drivers/mmc/host/dw_mmc-exynos.c
b/drivers/mmc/host/dw_mmc-exynos.c
index 5e3d95b..d3848ba 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -14,10 +14,12 @@
 #include <linux/of_gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <crypto/fmp.h>
 
 #include "dw_mmc.h"
 #include "dw_mmc-pltfm.h"
 #include "dw_mmc-exynos.h"
+#include "../core/queue.h"
 
 /* Variations in Exynos specific dw-mshc controller */
 enum dw_mci_exynos_type {
@@ -508,6 +510,62 @@ static int dw_mci_exynos_prepare_hs400_tuning(struct
dw_mci *host,
 	return 0;
 }
 
+#ifdef CONFIG_MMC_DW_EXYNOS_FMP
+static struct bio *get_bio(struct dw_mci *host,
+				struct mmc_data *data, bool cmdq_enabled)
+{
+	struct bio *bio = NULL;
+	struct mmc_queue_req *mq_rq = NULL;
+	struct request *req = NULL;
+	struct mmc_blk_request *brq = NULL;
+
+	if (!host || !data) {
+		pr_err("%s: Invalid MMC:%p data:%p\n", __func__, host,
data);
+		return NULL;
+	}
+
+	if (cmdq_enabled) {
+		pr_err("%s: no support cmdq yet:%p\n", __func__, host);
+		bio = NULL;
+	} else {
+		brq = container_of(data, struct mmc_blk_request, data);
+		if (!brq)
+			return NULL;
+
+		mq_rq = container_of(brq, struct mmc_queue_req, brq);
+		if (virt_addr_valid(mq_rq))
+			req = mmc_queue_req_to_req(mq_rq);
+			if (virt_addr_valid(req))
+				bio = req->bio;
+	}
+	return bio;
+}
+
+static int dw_mci_exynos_crypto_engine_cfg(struct dw_mci *host,
+					void *desc, struct mmc_data *data,
+					struct page *page, int page_index,
+					int sector_offset, bool
cmdq_enabled)
+{
+	struct bio *bio = get_bio(host, host->data, cmdq_enabled);
+
+	if (!bio)
+		return 0;
+
+	return exynos_fmp_crypt_cfg(bio, desc, page_index, sector_offset);
+}
+
+static int dw_mci_exynos_crypto_engine_clear(struct dw_mci *host,
+					void *desc, bool cmdq_enabled)
+{
+	struct bio *bio = get_bio(host, host->data, cmdq_enabled);
+
+	if (!bio)
+		return 0;
+
+	return exynos_fmp_crypt_clear(bio, desc);
+}
+#endif
+
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
@@ -524,6 +582,10 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.parse_dt		= dw_mci_exynos_parse_dt,
 	.execute_tuning		= dw_mci_exynos_execute_tuning,
 	.prepare_hs400_tuning	= dw_mci_exynos_prepare_hs400_tuning,
+#ifdef CONFIG_MMC_DW_EXYNOS_FMP
+	.crypto_engine_cfg = dw_mci_exynos_crypto_engine_cfg,
+	.crypto_engine_clear = dw_mci_exynos_crypto_engine_clear,
+#endif
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0cdf574..4de476a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -79,6 +79,32 @@ struct idmac_desc_64addr {
 
 	u32		des6;	/* Lower 32-bits of Next Descriptor Address
*/
 	u32		des7;	/* Upper 32-bits of Next Descriptor Address
*/
+#if defined(CONFIG_MMC_DW_EXYNOS_FMP)
+	u32 des8;		/* File IV 0 */
+	u32 des9;		/* File IV 1 */
+	u32 des10;		/* File IV 2 */
+	u32 des11;		/* File IV 3 */
+	u32 des12;		/* File EncKey 0 */
+	u32 des13;		/* File EncKey 1 */
+	u32 des14;		/* File EncKey 2 */
+	u32 des15;		/* File EncKey 3 */
+	u32 des16;		/* File EncKey 4 */
+	u32 des17;		/* File EncKey 5 */
+	u32 des18;		/* File EncKey 6 */
+	u32 des19;		/* File EncKey 7 */
+	u32 des20;		/* File TwKey 0 */
+	u32 des21;		/* File TwKey 1 */
+	u32 des22;		/* File TwKey 2 */
+	u32 des23;		/* File TwKey 3 */
+	u32 des24;		/* File TwKey 4 */
+	u32 des25;		/* File TwKey 5 */
+	u32 des26;		/* File TwKey 6 */
+	u32 des27;		/* File TwKey 7 */
+	u32 des28;		/* Disk IV 0 */
+	u32 des29;		/* Disk IV 1 */
+	u32 des30;		/* Disk IV 2 */
+	u32 des31;		/* Disk IV 3 */
+#endif
 };
 
 struct idmac_desc {
-- 
2.7.4

