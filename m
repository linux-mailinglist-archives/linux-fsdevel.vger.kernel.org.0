Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C887897282
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfHUGm2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:42:28 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52605 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbfHUGm1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:27 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190821064219epoutp04f58e1f647dfae50a2ae0f057292ae1bb~83Pqv_Xse1235612356epoutp04f
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190821064219epoutp04f58e1f647dfae50a2ae0f057292ae1bb~83Pqv_Xse1235612356epoutp04f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369739;
        bh=WnbIs/qNlKp6oVnU05R1K6UO7fsp2PDSWNPY+dvDBss=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QnOOWE2ZfLMetCvmT2iUOuqMs4Aj9jFvHnd8vv+McBs/OTBTEvFaEO1FCk935IYS+
         gJR9Io2gVOPz6qN3NmLvgmEJGrzLx4aBAsvEHczzRsr9f6LEcIwao50Q+greiFLdIX
         /Oy0fIStk1lo9i0qhcJTpOMgUaWoPUGRgPV0UghA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190821064218epcas2p3b8efd545ceb279ec179965d376a51e1e~83PqFkKCU0101901019epcas2p3l;
        Wed, 21 Aug 2019 06:42:18 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46Cykw73rZzMqYly; Wed, 21 Aug
        2019 06:42:16 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.23.04068.8C7EC5D5; Wed, 21 Aug 2019 15:42:16 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20190821064216epcas2p37df63284df4be04ba2f51b7f7b4b270b~83PndXVbQ0101901019epcas2p3j;
        Wed, 21 Aug 2019 06:42:16 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821064216epsmtrp2794511fe5f476429faa4c2367deca968~83PnZdtGA2242122421epsmtrp2P;
        Wed, 21 Aug 2019 06:42:16 +0000 (GMT)
X-AuditID: b6c32a47-589ff70000000fe4-62-5d5ce7c88e28
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.02.03706.7C7EC5D5; Wed, 21 Aug 2019 15:42:15 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064215epsmtip18b35762a7fc8e5ecabba39c5d415e4a7~83PmzwwDs3087530875epsmtip1G;
        Wed, 21 Aug 2019 06:42:15 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Herbert Xu'" <herbert@gondor.apana.org.au>,
        "'David S. Miller'" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
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
Subject: [PATCH 2/9] crypto: fmp: add Flash Memory Protector driver
Date:   Wed, 21 Aug 2019 15:42:15 +0900
Message-ID: <003e01d557eb$921d4320$b657c960$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6ADMbtkusay8Q0KDduCY7aX4rA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLLsWRmVeSWpSXmKPExsWy7bCmme6J5zGxBv1HLC2+fulgsVh/6hiz
        xeq7/WwWp6eeZbKYc76FxWLvu9msFmv3/GG26H4lY/Fk/Sxmixu/2lgt+h+/ZrY4f34Du8Wm
        x9dYLfbe0ra4f+8nk8XMeXfYLC4tcrd4Ne8bi8WevSdZLC7vmsNmceR/P6PFjPP7mCzaNn5l
        tGjt+clucXxtuIOkx5aVN5k8WjaXe2w7oOpx+Wypx6ZVnWwed67tYfPYvKTeY/eCz0weTWeO
        Mnu833eVzaNvyypGj8+b5AJ4onJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU
        8hJzU22VXHwCdN0yc4B+V1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn
        5haX5qXrJefnWhkaGBiZAlUm5GSsu/ObuWDLHaaKFWvmMTUw3p/O1MXIySEhYCLx5eYM5i5G
        Lg4hgR2MEucXH4VyPjFKtG++wQ7hfGOUmPNwBTtMy5u1i1lBbCGBvYwSDbPYIIpeMkpcezwb
        LMEmoC2x+fgqRpCEiMB8oMTdd2BVzAL/2CWefDrEAlIlLOAscWn3erAOFgFViYlNkxlBbF4B
        S4lvx55D2YISJ2c+AatnFpCX2P52DjPEGQoSO86+BqsREdCTmLzhIDtEjYjE7M42sCckBBo5
        JF5928MI0eAisWTSX1YIW1ji1fEtUP9ISXx+t5cNwq6XuLpsMTtEcw+jxJlfbVBFxhKznrUD
        DeIA2qApsX6XPogpIaAsceQW1G18Eh2H/7JDhHklOtqEIBpVJOZ+uswEEZaS+NBTBxH2kJh6
        8SjzBEbFWUienIXkyVlInpmFsHYBI8sqRrHUguLc9NRiowJj5PjexAjOGlruOxi3nfM5xCjA
        wajEw5twPTpWiDWxrLgy9xCjBAezkghvxZyoWCHelMTKqtSi/Pii0pzU4kOMpsA4mMgsJZqc
        D8xoeSXxhqZGZmYGlqYWpmZGFkrivJu4b8YICaQnlqRmp6YWpBbB9DFxcEo1ME6qzS81Y9/8
        T6N1udA3ZYcpWq+iPJSV6k8ds7unIR38Z5ex1puINUIvvOZM726WUMz9MFVZUOKhTFPQ9Eid
        wzXzl83w/izz6d/EVy2HVwUq/2T1ls+b75AQ83rrjiTD5xMuiKyNTFVfqNanE6Zmf2ie3Dre
        fOb6chvOh489WOXD7S2PB9zdqsRSnJFoqMVcVJwIAOm5LswwBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCSnO7x5zGxBq9fW1l8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlrLvzm7lgyx2mihVr5jE1MN6fztTF
        yMkhIWAi8WbtYtYuRi4OIYHdjBLzF/ezQCSkJLa272GGsIUl7rccYQWxhQSeM0rMWuYJYrMJ
        aEtsPr6KEaRZRGAho8Sb1TvZQBLMAtM4JHZ9EAexhQWcJS7tXg/WzCKgKjGxaTIjiM0rYCnx
        7dhzKFtQ4uTMJ0CLOYB69STaNjJCjJGX2P52DtQNChI7zr4Gi4sAlUzecJAdokZEYnZnG/ME
        RsFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMxLLdcrTswtLs1L10vOz93ECE4EWpo7
        GC8viT/EKMDBqMTDu+NmdKwQa2JZcWXuIUYJDmYlEd6KOVGxQrwpiZVVqUX58UWlOanFhxil
        OViUxHmf5h2LFBJITyxJzU5NLUgtgskycXBKNTCynMwznOYY38X/WUw3ZfKlS+4T4gWf1Kxu
        /C/d75cVn/KmnnmrabVXX4RnbeJNDSmfruzfvpdtWAJvrVrpfX2pZajD6+dS2fV6QnIGDzfP
        lyg4/OLDX5OInIcaR8zOC1+7HPFXmKHUqK0hsandaeKHQ9JcnSo3Eo6td8iR2FPq/6BIed6Z
        bUosxRmJhlrMRcWJAKq0DdQAAwAA
X-CMS-MailID: 20190821064216epcas2p37df63284df4be04ba2f51b7f7b4b270b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064216epcas2p37df63284df4be04ba2f51b7f7b4b270b
References: <CGME20190821064216epcas2p37df63284df4be04ba2f51b7f7b4b270b@epcas2p3.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Exynos has FMP(Flash Memory Protector) H/W to protect data stored
on storage device.
FMP interworks with the storage controller to encrypt a data before writing
to the storage device and decrypt the data after reading from storage
device.

FMP driver is registered with a cipher algorithm of diskcipher.
FMP driver writes crypto information in the descriptor of the storage
controller.
And then, FMP H/W encrypts plan-text with every write I/O
and decrypts cipher-text with every read I/O.

FMP is divided into three blocks.
The first is fmp driver to control FMP H/W.
The second is the fmp-crypt that is responsible for the interface with
the diskcipher and storage driver.
The third is the fmp-test to test the fmp driver through testmgr of
crypto API.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/crypto/Kconfig         |   2 +
 drivers/crypto/Makefile        |   1 +
 drivers/crypto/fmp/Kconfig     |  13 +
 drivers/crypto/fmp/Makefile    |   1 +
 drivers/crypto/fmp/fmp.c       | 595
+++++++++++++++++++++++++++++++++++++++++
 drivers/crypto/fmp/fmp_crypt.c | 243 +++++++++++++++++
 drivers/crypto/fmp/fmp_test.c  | 310 +++++++++++++++++++++
 drivers/crypto/fmp/fmp_test.h  |  30 +++
 include/crypto/fmp.h           | 324 ++++++++++++++++++++++
 9 files changed, 1519 insertions(+)
 create mode 100644 drivers/crypto/fmp/Kconfig
 create mode 100644 drivers/crypto/fmp/Makefile
 create mode 100644 drivers/crypto/fmp/fmp.c
 create mode 100644 drivers/crypto/fmp/fmp_crypt.c
 create mode 100644 drivers/crypto/fmp/fmp_test.c
 create mode 100644 drivers/crypto/fmp/fmp_test.h
 create mode 100644 include/crypto/fmp.h

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b8c5087..43b8cc4 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -785,4 +785,6 @@ config CRYPTO_DEV_CCREE
 
 source "drivers/crypto/hisilicon/Kconfig"
 
+source "drivers/crypto/fmp/Kconfig"
+
 endif # CRYPTO_HW
diff --git a/drivers/crypto/Makefile b/drivers/crypto/Makefile
index afc4753..d43cf7a 100644
--- a/drivers/crypto/Makefile
+++ b/drivers/crypto/Makefile
@@ -48,3 +48,4 @@ obj-$(CONFIG_CRYPTO_DEV_BCM_SPU) += bcm/
 obj-$(CONFIG_CRYPTO_DEV_SAFEXCEL) += inside-secure/
 obj-$(CONFIG_CRYPTO_DEV_ARTPEC6) += axis/
 obj-y += hisilicon/
+obj-$(CONFIG_EXYNOS_FMP) += fmp/
diff --git a/drivers/crypto/fmp/Kconfig b/drivers/crypto/fmp/Kconfig
new file mode 100644
index 0000000..69cdb53
--- /dev/null
+++ b/drivers/crypto/fmp/Kconfig
@@ -0,0 +1,13 @@
+#
+# SMU/FMP controller drivers
+#
+
+config EXYNOS_FMP
+	tristate "Samsung EXYNOS FMP driver"
+	depends on CRYPTO_DISKCIPHER && MMC_DW_EXYNOS_FMP
+	help
+	  Say yes here to build support for FMP (Flash Memory Protector)
+	  to encrypt and decrypt userdata using inline H/W crypto module.
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here
diff --git a/drivers/crypto/fmp/Makefile b/drivers/crypto/fmp/Makefile
new file mode 100644
index 0000000..5328947
--- /dev/null
+++ b/drivers/crypto/fmp/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_EXYNOS_FMP) += fmp_crypt.o fmp.o fmp_test.o
diff --git a/drivers/crypto/fmp/fmp.c b/drivers/crypto/fmp/fmp.c
new file mode 100644
index 0000000..475d471
--- /dev/null
+++ b/drivers/crypto/fmp/fmp.c
@@ -0,0 +1,595 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Exynos FMP driver
+ *
+ * Copyright (C) 2015 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/smc.h>
+#include <asm/cacheflush.h>
+#include <linux/crypto.h>
+#include <linux/scatterlist.h>
+#include <crypto/fmp.h>
+
+#include "fmp_test.h"
+
+#define WORD_SIZE 4
+#define FMP_IV_MAX_IDX (FMP_IV_SIZE_16 / WORD_SIZE)
+
+#ifndef __SMC_H__
+#define exynos_smc(a, b, c, d) (-EINVAL)
+#endif
+
+#define byte2word(b0, b1, b2, b3)       \
+			(((unsigned int)(b0) << 24) | \
+			((unsigned int)(b1) << 16) | \
+			((unsigned int)(b2) << 8) | (b3))
+#define get_word(x, c)  byte2word(((unsigned char *)(x) + 4 * (c))[0], \
+				((unsigned char *)(x) + 4 * (c))[1], \
+				((unsigned char *)(x) + 4 * (c))[2], \
+				((unsigned char *)(x) + 4 * (c))[3])
+
+static inline void dump_ci(struct fmp_crypto_info *c)
+{
+	if (c) {
+		pr_info
+		    ("%s: crypto:%p algo:%d enc:%d key_size:%d key:%p\n",
+		     __func__, c, c->algo_mode, c->enc_mode,
+		     c->key_size, c->key);
+		if (c->enc_mode == EXYNOS_FMP_FILE_ENC)
+			print_hex_dump(KERN_CONT, "key:",
+				       DUMP_PREFIX_OFFSET, 16, 1, c->key,
+				       sizeof(c->key), false);
+	}
+}
+
+static inline void dump_table(struct fmp_table_setting *table)
+{
+	print_hex_dump(KERN_CONT, "dump:", DUMP_PREFIX_OFFSET, 16, 1,
+		       table, sizeof(struct fmp_table_setting), false);
+}
+
+static inline int is_set_fmp_disk_key(struct exynos_fmp *fmp)
+{
+	return (fmp->status_disk_key == KEY_SET) ? TRUE : FALSE;
+}
+
+static inline int is_stored_fmp_disk_key(struct exynos_fmp *fmp)
+{
+	return (fmp->status_disk_key == KEY_STORED) ? TRUE : FALSE;
+}
+
+static inline int is_supported_ivsize(u32 ivlen)
+{
+	if (ivlen && (ivlen <= FMP_IV_SIZE_16))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+static inline int check_aes_xts_size(struct fmp_table_setting *table,
+				     bool cmdq_enabled)
+{
+	int size;
+
+	if (cmdq_enabled)
+		size = GET_CMDQ_LENGTH(table);
+	else
+		size = GET_LENGTH(table);
+	return (size > MAX_AES_XTS_TRANSFER_SIZE) ? size : 0;
+}
+
+static inline int check_aes_xts_key(char *key,
+				    enum fmp_crypto_key_size key_size)
+{
+	char *enckey, *twkey;
+
+	enckey = key;
+	twkey = key + key_size;
+	return (memcmp(enckey, twkey, key_size)) ? 0 : -1;
+}
+
+int fmplib_set_algo_mode(struct fmp_table_setting *table,
+			 struct fmp_crypto_info *crypto, bool cmdq_enabled)
+{
+	int ret;
+	enum fmp_crypto_algo_mode algo_mode = crypto->algo_mode;
+
+	if (algo_mode == EXYNOS_FMP_ALGO_MODE_AES_XTS) {
+		ret = check_aes_xts_size(table, cmdq_enabled);
+		if (ret) {
+			pr_err("%s: Fail FMP XTS due to invalid size(%d)\n",
+			       __func__, ret);
+			return -EINVAL;
+		}
+	}
+
+	switch (crypto->enc_mode) {
+	case EXYNOS_FMP_FILE_ENC:
+		if (cmdq_enabled)
+			SET_CMDQ_FAS(table, algo_mode);
+		else
+			SET_FAS(table, algo_mode);
+		break;
+	case EXYNOS_FMP_DISK_ENC:
+		if (cmdq_enabled)
+			SET_CMDQ_DAS(table, algo_mode);
+		else
+			SET_DAS(table, algo_mode);
+		break;
+	default:
+		pr_err("%s: Invalid fmp enc mode %d\n", __func__,
+		       crypto->enc_mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int fmplib_set_file_key(struct fmp_table_setting *table,
+			struct fmp_crypto_info *crypto)
+{
+	enum fmp_crypto_algo_mode algo_mode = crypto->algo_mode;
+	enum fmp_crypto_key_size key_size = crypto->fmp_key_size;
+	char *key = crypto->key;
+	int idx, max;
+
+	if (!key || (crypto->enc_mode != EXYNOS_FMP_FILE_ENC) ||
+		((key_size != EXYNOS_FMP_KEY_SIZE_16) &&
+		 (key_size != EXYNOS_FMP_KEY_SIZE_32))) {
+		pr_err("%s: Invalid crypto:%p key:%p key_size:%d
enc_mode:%d\n",
+		       __func__, crypto, key, key_size, crypto->enc_mode);
+		return -EINVAL;
+	}
+
+	if ((algo_mode == EXYNOS_FMP_ALGO_MODE_AES_XTS)
+	    && check_aes_xts_key(key, key_size)) {
+		pr_err("%s: Fail FMP XTS due to the same enc and twkey\n",
+		       __func__);
+		return -EINVAL;
+	}
+
+	if (algo_mode == EXYNOS_FMP_ALGO_MODE_AES_CBC) {
+		max = key_size / WORD_SIZE;
+		for (idx = 0; idx < max; idx++)
+			*(&table->file_enckey0 + idx) =
+			    get_word(key, max - (idx + 1));
+	} else if (algo_mode == EXYNOS_FMP_ALGO_MODE_AES_XTS) {
+		key_size *= 2;
+		max = key_size / WORD_SIZE;
+		for (idx = 0; idx < (max / 2); idx++)
+			*(&table->file_enckey0 + idx) =
+			    get_word(key, (max / 2) - (idx + 1));
+		for (idx = 0; idx < (max / 2); idx++)
+			*(&table->file_twkey0 + idx) =
+			    get_word(key, max - (idx + 1));
+	}
+	return 0;
+}
+
+static int fmplib_set_key_size(struct fmp_table_setting *table,
+			struct fmp_crypto_info *crypto, bool cmdq_enabled)
+{
+	enum fmp_crypto_key_size key_size;
+
+	key_size = crypto->fmp_key_size;
+
+	if ((key_size != EXYNOS_FMP_KEY_SIZE_16) &&
+		(key_size != EXYNOS_FMP_KEY_SIZE_32)) {
+		pr_err("%s: Invalid keysize %d\n", __func__, key_size);
+		return -EINVAL;
+	}
+
+	switch (crypto->enc_mode) {
+	case EXYNOS_FMP_FILE_ENC:
+		if (cmdq_enabled)
+			SET_CMDQ_KEYLEN(table,
+					(key_size ==
+					 FMP_KEY_SIZE_32) ? FKL_CMDQ : 0);
+		else
+			SET_KEYLEN(table,
+				   (key_size == FMP_KEY_SIZE_32) ? FKL : 0);
+		break;
+	case EXYNOS_FMP_DISK_ENC:
+		if (cmdq_enabled)
+			SET_CMDQ_KEYLEN(table,
+					(key_size ==
+					 FMP_KEY_SIZE_32) ? DKL_CMDQ : 0);
+		else
+			SET_KEYLEN(table,
+				   (key_size == FMP_KEY_SIZE_32) ? DKL : 0);
+		break;
+	default:
+		pr_err("%s: Invalid fmp enc mode %d\n", __func__,
+		       crypto->enc_mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static int fmplib_set_disk_key(struct exynos_fmp *fmp, u8 *key, u32
key_size)
+{
+	int ret;
+
+	/* TODO: only set for host0 */
+	__flush_dcache_area(key, (size_t) FMP_MAX_KEY_SIZE);
+	ret =
+	    exynos_smc(SMC_CMD_FMP_DISK_KEY_STORED, 0, virt_to_phys(key),
+		       key_size);
+	if (ret) {
+		pr_err("%s: Fail to set FMP disk key. ret = %d\n", __func__,
+		       ret);
+		fmp->status_disk_key = KEY_ERROR;
+		return -EINVAL;
+	}
+	fmp->status_disk_key = KEY_STORED;
+	return 0;
+}
+
+static int fmplib_clear_disk_key(struct exynos_fmp *fmp)
+{
+	int ret;
+
+	ret = exynos_smc(SMC_CMD_FMP_DISK_KEY_CLEAR, 0, 0, 0);
+	if (ret) {
+		pr_err("%s: Fail to clear FMP disk key. ret = %d\n",
+		       __func__, ret);
+		fmp->status_disk_key = KEY_ERROR;
+		return -EPERM;
+	}
+
+	fmp->status_disk_key = KEY_CLEAR;
+	return 0;
+}
+
+static int fmplib_set_iv(struct fmp_table_setting *table,
+		  struct fmp_crypto_info *crypto, u8 *iv)
+{
+	int idx;
+
+	switch (crypto->enc_mode) {
+	case EXYNOS_FMP_FILE_ENC:
+		for (idx = 0; idx < FMP_IV_MAX_IDX; idx++)
+			*(&table->file_iv0 + idx) =
+			    get_word(iv, FMP_IV_MAX_IDX - (idx + 1));
+		break;
+	case EXYNOS_FMP_DISK_ENC:
+		for (idx = 0; idx < FMP_IV_MAX_IDX; idx++)
+			*(&table->disk_iv0 + idx) =
+			    get_word(iv, FMP_IV_MAX_IDX - (idx + 1));
+		break;
+	default:
+		pr_err("%s: Invalid fmp enc mode %d\n", __func__,
+		       crypto->enc_mode);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+int exynos_fmp_crypt(struct fmp_crypto_info *ci, void *priv)
+{
+	struct exynos_fmp *fmp = ci->ctx;
+	struct fmp_request *r = priv;
+	int ret = 0;
+	u8 iv[FMP_IV_SIZE_16];
+
+	if (!r || !fmp) {
+		pr_err("%s: invalid req:%p, fmp:%p\n", __func__, r, fmp);
+		return -EINVAL;
+	}
+
+	/* check test mode */
+	if (ci->algo_mode & EXYNOS_FMP_ALGO_MODE_TEST) {
+		ci->algo_mode &= EXYNOS_FMP_ALGO_MODE_MASK;
+		if (!ci->algo_mode)
+			return 0;
+
+		if (!fmp->test_data) {
+			pr_err("%s: no test_data for test mode\n",
__func__);
+			goto out;
+		}
+		/* use test manager's iv instead of host driver's iv */
+		r->iv = fmp->test_data->iv;
+		r->ivsize = sizeof(fmp->test_data->iv);
+	}
+
+	/* check crypto info & input param */
+	if (!ci->algo_mode || !is_supported_ivsize(r->ivsize) ||
+			!r->table || !r->iv) {
+		dev_err(fmp->dev,
+			"%s: invalid mode:%d iv:%p ivsize:%d table:%p\n",
+			__func__, ci->algo_mode, r->iv, r->ivsize,
r->table);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set algo & enc mode into table */
+	ret = fmplib_set_algo_mode(r->table, ci, r->cmdq_enabled);
+	if (ret) {
+		dev_err(fmp->dev, "%s: Fail to set FMP encryption mode\n",
+			__func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set key size into table */
+	switch (ci->enc_mode) {
+	case EXYNOS_FMP_FILE_ENC:
+		ret = fmplib_set_file_key(r->table, ci);
+		if (ret) {
+			dev_err(fmp->dev, "%s: Fail to set FMP key\n",
+				__func__);
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+	case EXYNOS_FMP_DISK_ENC:
+		if (is_stored_fmp_disk_key(fmp)) {
+			ret = exynos_smc(SMC_CMD_FMP_DISK_KEY_SET, 0, 0, 0);
+			if (ret) {
+				dev_err(fmp->dev,
+					"%s: Fail to set disk key\n",
__func__);
+				goto out;
+			}
+			fmp->status_disk_key = KEY_SET;
+		} else if (!is_set_fmp_disk_key(fmp)) {
+			dev_err(fmp->dev,
+				"%s: Fail because disk key is clear\n",
+				__func__);
+			ret = -EINVAL;
+			goto out;
+		}
+		break;
+	default:
+		dev_err(fmp->dev, "%s: Invalid fmp enc mode %d\n", __func__,
+			ci->enc_mode);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set key size into table */
+	ret = fmplib_set_key_size(r->table, ci, r->cmdq_enabled);
+	if (ret) {
+		dev_err(fmp->dev, "%s: Fail to set FMP key size\n",
__func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* set iv */
+	memset(iv, 0, FMP_IV_SIZE_16);
+	memcpy(iv, r->iv, r->ivsize);
+	ret = fmplib_set_iv(r->table, ci, iv);
+	if (ret) {
+		dev_err(fmp->dev, "%s: Fail to set FMP IV\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+out:
+	if (ret) {
+		dump_ci(ci);
+		if (r && r->table)
+			dump_table(r->table);
+	}
+	return ret;
+}
+
+static inline void fmplib_clear_file_key(struct fmp_table_setting *table)
+{
+	memset(&table->file_iv0, 0, sizeof(__le32) * 24);
+}
+
+int exynos_fmp_clear(struct fmp_crypto_info *ci, void *priv)
+{
+	struct fmp_request *r = priv;
+
+	if (!r) {
+		pr_err("%s: Invalid input\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!r->table) {
+		pr_err("%s: Invalid input table\n", __func__);
+		return -EINVAL;
+	}
+
+	fmplib_clear_file_key(r->table);
+	return 0;
+}
+
+int exynos_fmp_setkey(struct fmp_crypto_info *ci, u8 *in_key, u32 keylen,
+		      bool persistent)
+{
+	struct exynos_fmp *fmp = ci->ctx;
+	int ret = 0;
+	int keylen_org = keylen;
+
+	if (!fmp || !in_key) {
+		pr_err("%s: invalid input param\n", __func__);
+		return -EINVAL;
+	}
+
+	/* set key_size & fmp_key_size */
+	if (ci->algo_mode == EXYNOS_FMP_ALGO_MODE_AES_XTS)
+		keylen = keylen >> 1;
+	switch (keylen) {
+	case FMP_KEY_SIZE_16:
+		ci->fmp_key_size = EXYNOS_FMP_KEY_SIZE_16;
+		break;
+	case FMP_KEY_SIZE_32:
+		ci->fmp_key_size = EXYNOS_FMP_KEY_SIZE_32;
+		break;
+	default:
+		pr_err("%s: FMP doesn't support key size %d\n", __func__,
+		       keylen);
+		return -ENOKEY;
+	}
+	ci->key_size = keylen_org;
+
+	/* set key */
+	if (persistent) {
+		ci->enc_mode = EXYNOS_FMP_DISK_ENC;
+		ret = fmplib_set_disk_key(fmp, in_key, ci->key_size);
+		if (ret)
+			pr_err("%s: Fail to set FMP disk key\n", __func__);
+	} else {
+		ci->enc_mode = EXYNOS_FMP_FILE_ENC;
+		memset(ci->key, 0, sizeof(ci->key));
+		memcpy(ci->key, in_key, ci->key_size);
+	}
+	return ret;
+}
+
+int exynos_fmp_clearkey(struct fmp_crypto_info *ci)
+{
+	struct exynos_fmp *fmp = ci->ctx;
+	int ret = 0;
+
+	if (!fmp) {
+		pr_err("%s: invalid input param\n", __func__);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (ci->enc_mode == EXYNOS_FMP_DISK_ENC) {
+		ret = fmplib_clear_disk_key(fmp);
+		if (ret)
+			pr_err("%s: fail to clear FMP disk key\n",
__func__);
+	} else if (ci->enc_mode == EXYNOS_FMP_FILE_ENC) {
+		memset(ci->key, 0, sizeof(ci->key));
+		ci->key_size = 0;
+	} else {
+		pr_err("%s: invalid algo mode:%d\n", __func__,
ci->enc_mode);
+		ret = -EINVAL;
+	}
+out:
+	return ret;
+}
+
+int exynos_fmp_test_crypt(struct fmp_crypto_info *ci,
+			const uint8_t *iv, uint32_t ivlen, uint8_t *src,
+			uint8_t *dst, uint32_t len, bool enc, void *priv)
+{
+	struct exynos_fmp *fmp = ci->ctx;
+	int ret = 0;
+
+	if (!fmp || !iv || !src || !dst) {
+		pr_err("%s: invalid input: fmp:%p, iv:%p, s:%p, d:%p\n",
+			__func__, fmp, iv, src, dst);
+		return -EINVAL;
+	}
+
+	/* init fmp test to get test block */
+	fmp->test_data = fmp_test_init(fmp);
+	if (!fmp->test_data) {
+		dev_err(fmp->dev, "%s: fail to initialize fmp test.",
+			__func__);
+		goto err;
+	}
+
+	/* setiv */
+	if (iv && (ivlen <= FMP_IV_SIZE_16)) {
+		memset(fmp->test_data->iv, 0, FMP_IV_SIZE_16);
+		memcpy(fmp->test_data->iv, iv, ivlen);
+	} else {
+		dev_err(fmp->dev, "%s: fail to set fmp iv. ret(%d)",
+			__func__, ret);
+		goto err;
+	}
+
+	/* do crypt: priv: struct crypto_diskcipher */
+	ret = fmp_test_crypt(fmp, fmp->test_data,
+		src, dst, len, enc ? ENCRYPT : DECRYPT, priv, ci);
+	if (ret)
+		dev_err(fmp->dev, "%s: fail to run fmp test. ret(%d)",
+			__func__, ret);
+
+err:
+	if (fmp->test_data)
+		fmp_test_exit(fmp->test_data);
+	return ret;
+}
+
+int exynos_fmp_smu_abort(int id)
+{
+	int ret = 0;
+
+	if (id == SMU_ID_MAX)
+		return 0;
+
+	ret = exynos_smc(SMC_CMD_SMU, SMU_ABORT, id, 0);
+	if (ret)
+		pr_err("%s: Fail smc call. ret(%d)\n", __func__, ret);
+
+	return ret;
+}
+
+#define CFG_DESCTYPE_3 0x3
+int exynos_fmp_sec_cfg(int fmp_id, int smu_id, bool init)
+{
+	int ret = 0;
+
+	if (fmp_id != SMU_ID_MAX) {
+		ret = exynos_smc(SMC_CMD_FMP_SECURITY, 0,
+				fmp_id, CFG_DESCTYPE_3);
+		if (ret)
+			pr_err("%s: Fail smc call for FMP_SECURITY.
ret(%d)\n",
+					__func__, ret);
+	}
+
+	if (smu_id != SMU_ID_MAX) {
+		if (init)
+			ret = exynos_smc(SMC_CMD_SMU, SMU_INIT, smu_id, 0);
+		else
+			ret = exynos_smc(SMC_CMD_FMP_SMU_RESUME, 0, smu_id,
0);
+		if (ret)
+			pr_err("%s: Fail smc call cmd:%d. ret(%d)\n",
+					__func__, init, ret);
+	}
+
+	return ret;
+}
+
+void *exynos_fmp_init(struct platform_device *pdev)
+{
+	struct exynos_fmp *fmp;
+
+	if (!pdev) {
+		pr_err("%s: Invalid platform_device.\n", __func__);
+		return NULL;
+	}
+
+	fmp = devm_kzalloc(&pdev->dev, sizeof(struct exynos_fmp),
GFP_KERNEL);
+	if (!fmp)
+		return NULL;
+
+	fmp->dev = &pdev->dev;
+	if (!fmp->dev) {
+		pr_err("%s: Invalid device.\n", __func__);
+		goto err_dev;
+	}
+
+	/* init disk key status */
+	fmp->status_disk_key = KEY_CLEAR;
+
+	dev_info(fmp->dev, "Exynos FMP Version: %s\n", FMP_DRV_VERSION);
+	return fmp;
+
+err_dev:
+	kzfree(fmp);
+	return NULL;
+}
+
+void exynos_fmp_exit(struct exynos_fmp *fmp)
+{
+	kzfree(fmp);
+}
diff --git a/drivers/crypto/fmp/fmp_crypt.c b/drivers/crypto/fmp/fmp_crypt.c
new file mode 100644
index 0000000..78becb5
--- /dev/null
+++ b/drivers/crypto/fmp/fmp_crypt.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Exynos FMP crypt interface
+ *
+ * Copyright (C) 2018 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/slab.h>
+#include <linux/bio.h>
+#include <linux/crypto.h>
+#include <linux/scatterlist.h>
+#include <crypto/fmp.h>
+#include <crypto/diskcipher.h>
+
+int exynos_fmp_crypt_clear(struct bio *bio, void *table_addr)
+{
+	struct crypto_diskcipher *dtfm = crypto_diskcipher_get(bio);
+	struct fmp_crypto_info *ci;
+	struct fmp_request req;
+	int ret = 0;
+
+	if (unlikely(IS_ERR(dtfm))) {
+		pr_warn("%s: fails to get crypt\n", __func__);
+		return -EINVAL;
+	} else if (dtfm) {
+		ci = crypto_tfm_ctx(crypto_diskcipher_tfm(dtfm));
+		if (ci)
+			if (ci->enc_mode == EXYNOS_FMP_FILE_ENC) {
+				req.table = table_addr;
+				ret = crypto_diskcipher_clear_crypt(dtfm,
&req);
+			}
+	}
+	if (ret)
+		pr_err("%s: fail to config desc (bio:%p, tfm:%p, ci:%p
ret:%d)\n",
+				__func__, bio, dtfm, ci, ret);
+	return ret;
+}
+
+int exynos_fmp_crypt_cfg(struct bio *bio, void *table_addr,
+			u32 page_idx, u32 sector_unit)
+{
+	struct crypto_diskcipher *dtfm = crypto_diskcipher_get(bio);
+	u64 iv;
+	struct fmp_request req;
+	int ret = 0;
+
+	if (unlikely(IS_ERR(dtfm))) {
+		pr_warn("%s: fails to get crypt\n", __func__);
+		return -EINVAL;
+	} else if (dtfm) {
+		req.table = table_addr;
+		req.cmdq_enabled = 0;
+		req.iv = &iv;
+		req.ivsize = sizeof(iv);
+		iv = (dtfm->ivmode == IV_MODE_DUN) ? (bio_dun(bio) +
page_idx) :
+			(bio->bi_iter.bi_sector + (sector_t)sector_unit);
+		ret = crypto_diskcipher_set_crypt(dtfm, &req);
+		if (ret)
+			pr_err("%s: fail to config desc (bio:%p, tfm:%p,
ret:%d)\n",
+					__func__, bio, dtfm, ret);
+		return ret;
+	}
+
+	exynos_fmp_bypass(table_addr, 0);
+	return 0;
+}
+
+static int fmp_crypt(struct crypto_diskcipher *tfm, void *priv)
+{
+	struct fmp_crypto_info *ci =
crypto_tfm_ctx(crypto_diskcipher_tfm(tfm));
+
+	return exynos_fmp_crypt(ci, priv);
+}
+
+static int fmp_clear(struct crypto_diskcipher *tfm, void *priv)
+{
+	struct fmp_crypto_info *ci =
crypto_tfm_ctx(crypto_diskcipher_tfm(tfm));
+
+	return exynos_fmp_clear(ci, priv);
+}
+
+static int fmp_setkey(struct crypto_diskcipher *tfm, const char *in_key,
+			u32 keylen, bool persistent)
+{
+	struct fmp_crypto_info *ci =
crypto_tfm_ctx(crypto_diskcipher_tfm(tfm));
+
+	return exynos_fmp_setkey(ci, (char *)in_key, keylen, persistent);
+}
+
+static int fmp_clearkey(struct crypto_diskcipher *tfm)
+{
+	struct fmp_crypto_info *ci =
crypto_tfm_ctx(crypto_diskcipher_tfm(tfm));
+
+	return exynos_fmp_clearkey(ci);
+}
+
+/* support crypto manager test without CRYPTO_MANAGER_DISABLE_TESTS */
+static int fmp_do_test_crypt(struct crypto_diskcipher *tfm,
+			  struct diskcipher_test_request *req)
+{
+	if (!req) {
+		pr_err("%s: invalid parameter\n", __func__);
+		return -EINVAL;
+	}
+
+	return
exynos_fmp_test_crypt(crypto_tfm_ctx(crypto_diskcipher_tfm(tfm)),
+		    req->iv, tfm->ivsize,
+		    sg_virt(req->src), sg_virt(req->dst),
+		    req->cryptlen, req->enc ? 1 : 0, tfm);
+}
+
+
+static inline void fmp_algo_init(struct crypto_tfm *tfm,
+				 enum fmp_crypto_algo_mode algo)
+{
+	struct fmp_crypto_info *ci = crypto_tfm_ctx(tfm);
+	struct crypto_diskcipher *diskc = __crypto_diskcipher_cast(tfm);
+	struct diskcipher_alg *alg = crypto_diskcipher_alg(diskc);
+
+	/* This field's stongly aligned 'fmp_crypto_info->use_diskc' */
+	diskc->algo = (u32)algo;
+	diskc->ivsize = FMP_IV_SIZE_16;
+	ci->ctx = dev_get_drvdata(alg->dev);
+	ci->algo_mode = algo;
+}
+
+static int fmp_aes_xts_init(struct crypto_tfm *tfm)
+{
+	fmp_algo_init(tfm, EXYNOS_FMP_ALGO_MODE_AES_XTS);
+	return 0;
+}
+
+static int fmp_cbc_aes_init(struct crypto_tfm *tfm)
+{
+	fmp_algo_init(tfm, EXYNOS_FMP_ALGO_MODE_AES_CBC);
+	return 0;
+}
+
+static struct diskcipher_alg fmp_algs[] = {{
+	.base = {
+		.cra_name = "xts(aes)-disk",
+		.cra_driver_name = "xts(aes)-disk(fmp)",
+		.cra_priority = 200,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct fmp_crypto_info),
+		.cra_init = fmp_aes_xts_init,
+	}
+}, {
+	.base = {
+		.cra_name = "cbc(aes)-disk",
+		.cra_driver_name = "cbc(aes)-disk(fmp)",
+		.cra_priority = 200,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct fmp_crypto_info),
+		.cra_init = fmp_cbc_aes_init,
+	}
+} };
+
+static int exynos_fmp_probe(struct platform_device *pdev)
+{
+	struct diskcipher_alg *alg;
+	void *fmp_ctx = exynos_fmp_init(pdev);
+	int ret;
+	int i;
+
+	if (!fmp_ctx) {
+		dev_err(&pdev->dev,
+			"%s: Fail to register diskciphero\n", __func__);
+		return -EINVAL;
+	}
+	dev_set_drvdata(&pdev->dev, fmp_ctx);
+
+	for (i = 0; i < ARRAY_SIZE(fmp_algs); i++) {
+		alg = &fmp_algs[i];
+		alg->dev = &pdev->dev;
+		alg->init = NULL;
+		alg->setkey = fmp_setkey;
+		alg->clearkey = fmp_clearkey;
+		alg->crypt = fmp_crypt;
+		alg->clear = fmp_clear;
+		alg->do_crypt = fmp_do_test_crypt;
+	}
+	ret = crypto_register_diskciphers(fmp_algs, ARRAY_SIZE(fmp_algs));
+	if (ret) {
+		dev_err(&pdev->dev,
+			"%s: Fail to register diskciphero. ret = %d\n",
+			__func__, ret);
+		return -EINVAL;
+	}
+	dev_info(&pdev->dev, "Exynos FMP driver is registered to
diskcipher\n");
+	return 0;
+}
+
+static int exynos_fmp_remove(struct platform_device *pdev)
+{
+	void *drv_data = dev_get_drvdata(&pdev->dev);
+
+	if (!drv_data) {
+		pr_err("%s: Fail to get drvdata\n", __func__);
+		return 0;
+	}
+	crypto_unregister_diskciphers(fmp_algs, ARRAY_SIZE(fmp_algs));
+	exynos_fmp_exit(drv_data);
+	return 0;
+}
+
+static const struct of_device_id exynos_fmp_match[] = {
+	{ .compatible = "samsung,exynos-fmp" },
+	{},
+};
+
+static struct platform_driver exynos_fmp_driver = {
+	.driver = {
+		   .name = "exynos-fmp",
+		   .owner = THIS_MODULE,
+		   .pm = NULL,
+		   .of_match_table = exynos_fmp_match,
+		   },
+	.probe = exynos_fmp_probe,
+	.remove = exynos_fmp_remove,
+};
+
+static int __init fmp_init(void)
+{
+	return platform_driver_register(&exynos_fmp_driver);
+}
+late_initcall(fmp_init);
+
+static void __exit fmp_exit(void)
+{
+	platform_driver_unregister(&exynos_fmp_driver);
+}
+module_exit(fmp_exit);
+MODULE_DESCRIPTION("Exynos Spedific crypto algo driver");
diff --git a/drivers/crypto/fmp/fmp_test.c b/drivers/crypto/fmp/fmp_test.c
new file mode 100644
index 0000000..fb47bbd
--- /dev/null
+++ b/drivers/crypto/fmp/fmp_test.c
@@ -0,0 +1,310 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Exynos FMP cipher driver
+ *
+ * Copyright (C) 2016 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/crypto.h>
+#include <linux/buffer_head.h>
+#include <linux/genhd.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/blk_types.h>
+#include <crypto/fmp.h>
+
+#include "fmp_test.h"
+
+#define MAX_SCAN_PART	(50)
+#define MAX_RETRY_COUNT (0x100000)
+
+static dev_t find_devt_for_test(struct exynos_fmp *fmp,
+				struct fmp_test_data *data)
+{
+	int i, idx = 0;
+	uint32_t count = 0;
+	uint64_t size;
+	uint64_t size_list[MAX_SCAN_PART];
+	dev_t devt_list[MAX_SCAN_PART];
+	dev_t devt_scan = 0;
+	dev_t devt = 0;
+	struct block_device *bdev = NULL;
+	struct device *dev = fmp->dev;
+	fmode_t fmode = FMODE_WRITE | FMODE_READ;
+
+	memset(size_list, 0, sizeof(size_list));
+	memset(devt_list, 0, sizeof(devt_list));
+	do {
+		for (i = 1; i < MAX_SCAN_PART; i++) {
+			devt_scan = blk_lookup_devt(data->block_type, i);
+			bdev = blkdev_get_by_dev(devt_scan, fmode, NULL);
+			if (IS_ERR(bdev))
+				continue;
+			else {
+				size_list[idx] =
+				    (uint64_t) i_size_read(bdev->bd_inode);
+				devt_list[idx++] = devt_scan;
+				blkdev_put(bdev, fmode);
+			}
+		}
+		if (!idx) {
+			mdelay(100);
+			count++;
+			continue;
+		}
+		for (i = 0; i < idx; i++) {
+			if (i == 0) {
+				size = size_list[i];
+				devt = devt_list[i];
+			} else {
+				if (size < size_list[i])
+					devt = devt_list[i];
+			}
+		}
+		bdev = blkdev_get_by_dev(devt, fmode, NULL);
+		dev_dbg(dev, "Found partno %d for FMP test\n",
+			bdev->bd_part->partno);
+		blkdev_put(bdev, fmode);
+		return devt;
+	} while (count < MAX_RETRY_COUNT);
+	dev_err(dev, "Block device isn't initialized yet for FMP test\n");
+	return (dev_t) 0;
+}
+
+static int get_fmp_host_type(struct device *dev,
+				    struct fmp_test_data *data)
+{
+	int ret;
+	struct device_node *node = dev->of_node;
+	const char *type;
+
+	ret =
+	    of_property_read_string_index(node, "exynos,block-type", 0,
&type);
+	if (ret) {
+		pr_err("%s: Could not get block type\n", __func__);
+		return ret;
+	}
+	strscpy(data->block_type, type, FMP_BLOCK_TYPE_NAME_LEN);
+	return 0;
+}
+
+static int get_fmp_test_block_offset(struct device *dev,
+				      struct fmp_test_data *data)
+{
+	int ret = 0;
+	struct device_node *node = dev->of_node;
+	uint32_t offset;
+
+	ret = of_property_read_u32(node, "exynos,fips-block_offset",
&offset);
+	if (ret) {
+		pr_err("%s: Could not get fips test block offset\n",
__func__);
+		ret = -EINVAL;
+		goto err;
+	}
+	data->test_block_offset = offset;
+err:
+	return ret;
+}
+
+/* test block device init for fmp test */
+struct fmp_test_data *fmp_test_init(struct exynos_fmp *fmp)
+{
+	int ret = 0;
+	struct fmp_test_data *data;
+	struct device *dev;
+	struct inode *inode;
+	struct super_block *sb;
+	unsigned long blocksize;
+	unsigned char blocksize_bits;
+	fmode_t fmode = FMODE_WRITE | FMODE_READ;
+
+	if (!fmp) {
+		pr_err("%s: Invalid exynos fmp struct\n", __func__);
+		return NULL;
+	}
+
+	dev = fmp->dev;
+	data = kmalloc(sizeof(struct fmp_test_data), GFP_KERNEL);
+	if (!data)
+		return NULL;
+
+	ret = get_fmp_host_type(dev, data);
+	if (ret) {
+		dev_err(dev, "%s: Fail to get host type. ret(%d)", __func__,
+			ret);
+		goto err;
+	}
+	data->devt = find_devt_for_test(fmp, data);
+	if (!data->devt) {
+		dev_err(dev, "%s: Fail to find devt for self test\n",
__func__);
+		goto err;
+	}
+	data->bdev = blkdev_get_by_dev(data->devt, fmode, NULL);
+	if (IS_ERR(data->bdev)) {
+		dev_err(dev, "%s: Fail to open block device\n", __func__);
+		goto err;
+	}
+	ret = get_fmp_test_block_offset(dev, data);
+	if (ret) {
+		dev_err(dev, "%s: Fail to get fips offset. ret(%d)\n",
+			__func__, ret);
+		goto err;
+	}
+	inode = data->bdev->bd_inode;
+	sb = inode->i_sb;
+	blocksize = sb->s_blocksize;
+	blocksize_bits = sb->s_blocksize_bits;
+	data->sector =
+	    (i_size_read(inode) -
+	     (blocksize * data->test_block_offset)) >> blocksize_bits;
+
+	return data;
+err:
+	kzfree(data);
+	return NULL;
+}
+
+int fmp_cipher_run(struct exynos_fmp *fmp, struct fmp_test_data *fdata,
+		uint8_t *data, uint32_t len, bool bypass, uint32_t write,
+		void *priv, struct fmp_crypto_info *ci)
+{
+	int ret = 0;
+	struct device *dev;
+	static struct buffer_head *bh;
+	u32 org_algo_mode;
+	int op_flags;
+
+	if (!fmp || !fdata || !ci) {
+		pr_err("%s: Invalid fmp struct: %p, %p, %p\n",
+			__func__, fmp, fdata, ci);
+		return -EINVAL;
+	}
+	dev = fmp->dev;
+
+	bh = __getblk(fdata->bdev, fdata->sector, FMP_BLK_SIZE);
+	if (!bh) {
+		dev_err(dev, "%s: Fail to get block from bdev\n", __func__);
+		return -ENODEV;
+	}
+
+	/* set algo_mode for test */
+	org_algo_mode = ci->algo_mode;
+	if (bypass)
+		ci->algo_mode = EXYNOS_FMP_BYPASS_MODE;
+	ci->algo_mode |= EXYNOS_FMP_ALGO_MODE_TEST;
+
+	get_bh(bh);
+	/* priv is diskc for crypto test. */
+	if (!priv) {
+		/* ci is fmp_test_data->ci */
+		fmp->test_data = fdata;
+		ci->ctx = fmp;
+		ci->use_diskc = 0;
+		ci->enc_mode = EXYNOS_FMP_FILE_ENC;
+		bh->b_private = ci;
+	} else {
+		/* ci is crypto_tfm_ctx(tfm) */
+		bh->b_private = priv;
+	}
+	op_flags = REQ_CRYPT;
+
+	if (write == WRITE_MODE) {
+		memcpy(bh->b_data, data, len);
+		set_buffer_dirty(bh);
+		ret = __sync_dirty_buffer(bh, op_flags | REQ_SYNC);
+		if (ret) {
+			dev_err(dev, "%s: IO error syncing for write
mode\n",
+				__func__);
+			ret = -EIO;
+			goto out;
+		}
+		memset(bh->b_data, 0, FMP_BLK_SIZE);
+	} else {
+		lock_buffer(bh);
+		bh->b_end_io = end_buffer_read_sync;
+		submit_bh(REQ_OP_READ, REQ_SYNC | REQ_PRIO | op_flags, bh);
+		wait_on_buffer(bh);
+		if (unlikely(!buffer_uptodate(bh))) {
+			ret = -EIO;
+			goto out;
+		}
+		memcpy(data, bh->b_data, len);
+	}
+out:
+	if (ci)
+		ci->algo_mode = org_algo_mode;
+	put_bh(bh);
+	return ret;
+}
+
+int fmp_test_crypt(struct exynos_fmp *fmp, struct fmp_test_data *fdata,
+		uint8_t *src, uint8_t *dst, uint32_t len, uint32_t enc,
+		void *priv, struct fmp_crypto_info *ci)
+{
+	int ret = 0;
+
+	if (!fdata) {
+		pr_err("%s: Invalid exynos fmp struct\n", __func__);
+		return -1;
+	}
+
+	if (enc == ENCRYPT) {
+		ret = fmp_cipher_run(fmp, fdata, src, len, 0,
+				WRITE_MODE, priv, ci);
+		if (ret) {
+			pr_err("Fail to run fmp cipher ret(%d)\n",
+				ret);
+			goto err;
+		}
+		ret = fmp_cipher_run(fmp, fdata, dst, len, 1,
+				READ_MODE, priv, ci);
+		if (ret) {
+			pr_err("Fail to run fmp cipher ret(%d)\n",
+				ret);
+			goto err;
+		}
+	} else if (enc == DECRYPT) {
+		ret = fmp_cipher_run(fmp, fdata, src, len, 1,
+				WRITE_MODE, priv, ci);
+		if (ret) {
+			pr_err("Fail to run fmp cipher ret(%d)\n",
+				ret);
+			goto err;
+		}
+		ret = fmp_cipher_run(fmp, fdata, dst, len, 0,
+				READ_MODE, priv, ci);
+		if (ret) {
+			pr_err("Fail to run fmp cipher ret(%d)\n",
+				ret);
+			goto err;
+		}
+	} else {
+		pr_err("%s: Invalid enc %d mode\n", __func__, enc);
+		goto err;
+	}
+
+	return 0;
+err:
+	return -EINVAL;
+}
+
+/* test block device release for fmp test */
+void fmp_test_exit(struct fmp_test_data *fdata)
+{
+	fmode_t fmode = FMODE_WRITE | FMODE_READ;
+
+	if (!fdata) {
+		pr_err("%s: Invalid exynos fmp struct\n", __func__);
+		return;
+	}
+	if (fdata->bdev)
+		blkdev_put(fdata->bdev, fmode);
+	kzfree(fdata);
+}
diff --git a/drivers/crypto/fmp/fmp_test.h b/drivers/crypto/fmp/fmp_test.h
new file mode 100644
index 0000000..42af22a
--- /dev/null
+++ b/drivers/crypto/fmp/fmp_test.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2016 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _FMP_TEST_H_
+#define _FMP_TEST_H_
+
+#define FMP_BLK_SIZE	(4096)
+
+#define WRITE_MODE	1
+#define READ_MODE	2
+
+#define ENCRYPT		1
+#define DECRYPT		2
+
+struct fmp_test_data *fmp_test_init(struct exynos_fmp *fmp);
+int fmp_cipher_run(struct exynos_fmp *fmp, struct fmp_test_data *fdata,
+		uint8_t *data, uint32_t len, bool bypass, uint32_t write,
+		void *priv, struct fmp_crypto_info *ci);
+int fmp_test_crypt(struct exynos_fmp *fmp, struct fmp_test_data *fdata,
+		uint8_t *src, uint8_t *dst, uint32_t len, uint32_t enc,
+		void *priv, struct fmp_crypto_info *ci);
+void fmp_test_exit(struct fmp_test_data *fdata);
+#endif /* _FMP_TEST_H_ */
diff --git a/include/crypto/fmp.h b/include/crypto/fmp.h
new file mode 100644
index 0000000..b0ac483
--- /dev/null
+++ b/include/crypto/fmp.h
@@ -0,0 +1,324 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2016 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _EXYNOS_FMP_H_
+#define _EXYNOS_FMP_H_
+
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+
+#define FMP_DRV_VERSION "1.5.0"
+
+#define FMP_KEY_SIZE_16		16
+#define FMP_KEY_SIZE_32		32
+#define FMP_IV_SIZE_16		16
+
+#define FMP_CBC_MAX_KEY_SIZE	FMP_KEY_SIZE_16
+#define FMP_XTS_MAX_KEY_SIZE	((FMP_KEY_SIZE_32) * (2))
+#define FMP_MAX_KEY_SIZE	FMP_XTS_MAX_KEY_SIZE
+
+#define FMP_HOST_TYPE_NAME_LEN	8
+#define FMP_BLOCK_TYPE_NAME_LEN	8
+
+#define FMP_SECTOR_SIZE	0x1000
+#define FMP_MIN_SECTOR_SIZE	0x200
+#define NUM_SECTOR_UNIT	((FMP_SECTOR_SIZE)/(FMP_MIN_SECTOR_SIZE))
+
+#define MAX_AES_XTS_TRANSFER_SIZE	0x1000
+
+#ifndef TRUE
+#define TRUE 1
+#endif
+
+#ifndef FALSE
+#define FALSE 0
+#endif
+
+enum fmp_crypto_algo_mode {
+	EXYNOS_FMP_BYPASS_MODE = 0,
+	EXYNOS_FMP_ALGO_MODE_AES_CBC = 1,
+	EXYNOS_FMP_ALGO_MODE_AES_XTS = 2,
+};
+
+enum fmp_crypto_key_size {
+	EXYNOS_FMP_KEY_SIZE_16 = 16,
+	EXYNOS_FMP_KEY_SIZE_32 = 32,
+};
+
+enum fmp_crypto_enc_mode {
+	EXYNOS_FMP_FILE_ENC = 0,
+	EXYNOS_FMP_DISK_ENC = 1,	/* use persistent key */
+	EXYNOS_FMP_ENC_MAX
+};
+
+enum fmp_disk_key_status {
+	KEY_STORED = 0,
+	KEY_SET = 1,
+	KEY_CLEAR = 2,
+	KEY_ERROR = -1,
+};
+
+struct fmp_crypto_info {
+	/* This field's stongly aligned 'crypto_diskcipher->algo' */
+	u32 use_diskc;
+	u8 key[FMP_MAX_KEY_SIZE];
+	u32 key_size;
+	enum fmp_crypto_key_size fmp_key_size;
+	enum fmp_crypto_enc_mode enc_mode;
+	enum fmp_crypto_algo_mode algo_mode;
+	void *ctx;
+};
+
+#if defined(CONFIG_MMC_DW_EXYNOS_FMP) &&
defined(CONFIG_SCSI_UFS_EXYNOS_FMP)
+#error "FMP doesn't support muti-host"
+#elif defined(CONFIG_MMC_DW_EXYNOS_FMP)
+struct fmp_table_setting {
+	__le32 des0;		/* des0 */
+#define GET_CMDQ_LENGTH(d) \
+	(((d)->des0 & 0xffff0000) >> 16)
+	__le32 des1;		/* des1 */
+	__le32 des2;		/* des2 */
+#define FKL BIT(26)
+#define DKL BIT(27)
+#define SET_KEYLEN(d, v) ((d)->des2 |= (uint32_t)v)
+#define SET_FAS(d, v) \
+			((d)->des2 = ((d)->des2 & 0xcfffffff) | v << 28)
+#define SET_DAS(d, v) \
+			((d)->des2 = ((d)->des2 & 0x3fffffff) | v << 30)
+#define GET_FAS(d)      ((d)->des2 & 0x30000000)
+#define GET_DAS(d)      ((d)->des2 & 0xc0000000)
+#define GET_LENGTH(d) \
+			((d)->des2 & 0x3ffffff)
+	__le32 des3;		/* des3 */
+	/* CMDQ Operation */
+#define FKL_CMDQ BIT(0)
+#define DKL_CMDQ BIT(1)
+#define SET_CMDQ_KEYLEN(d, v) ((d)->des2 |= (uint32_t)v)
+#define SET_CMDQ_FAS(d, v) \
+			((d)->des3 = ((d)->des3 & 0xfffffff3) | v << 2)
+#define SET_CMDQ_DAS(d, v) \
+			((d)->des3 = ((d)->des3 & 0xffffffcf) | v << 4)
+#define GET_CMDQ_FAS(d) ((d)->des3 & 0x0000000c)
+#define GET_CMDQ_DAS(d) ((d)->des3 & 0x00000030)
+	__le32 reserved0;	/* des4 */
+	__le32 reserved1;
+	__le32 reserved2;
+	__le32 reserved3;
+	__le32 file_iv0;	/* des8 */
+	__le32 file_iv1;
+	__le32 file_iv2;
+	__le32 file_iv3;
+	__le32 file_enckey0;	/* des12 */
+	__le32 file_enckey1;
+	__le32 file_enckey2;
+	__le32 file_enckey3;
+	__le32 file_enckey4;
+	__le32 file_enckey5;
+	__le32 file_enckey6;
+	__le32 file_enckey7;
+	__le32 file_twkey0;	/* des20 */
+	__le32 file_twkey1;
+	__le32 file_twkey2;
+	__le32 file_twkey3;
+	__le32 file_twkey4;
+	__le32 file_twkey5;
+	__le32 file_twkey6;
+	__le32 file_twkey7;
+	__le32 disk_iv0;	/* des28 */
+	__le32 disk_iv1;
+	__le32 disk_iv2;
+	__le32 disk_iv3;
+};
+#elif defined(CONFIG_SCSI_UFS_EXYNOS_FMP)
+struct fmp_table_setting {
+	__le32 des0;		/* des0 */
+#define GET_CMDQ_LENGTH(d) \
+	(((d)->des0 & 0xffff0000) >> 16)
+	__le32 des1;		/* des1 */
+	__le32 des2;		/* des2 */
+	__le32 des3;		/* des3 */
+/* Legacy Operation */
+#define FKL BIT(26)
+#define DKL BIT(27)
+#define SET_KEYLEN(d, v) ((d)->des3 |= (uint32_t)v)
+#define SET_FAS(d, v) \
+	((d)->des3 = ((d)->des3 & 0xcfffffff) | v << 28)
+#define SET_DAS(d, v) \
+	((d)->des3 = ((d)->des3 & 0x3fffffff) | v << 30)
+#define GET_FAS(d)	((d)->des3 & 0x30000000)
+#define GET_DAS(d)	((d)->des3 & 0xc0000000)
+#define GET_LENGTH(d) \
+	((d)->des3 & 0x3ffffff)
+/* CMDQ Operation */
+#define FKL_CMDQ BIT(0)
+#define DKL_CMDQ BIT(1)
+#define SET_CMDQ_KEYLEN(d, v) ((d)->des3 |= (uint32_t)v)
+#define SET_CMDQ_FAS(d, v) \
+	((d)->des3 = ((d)->des3 & 0xfffffff3) | v << 2)
+#define SET_CMDQ_DAS(d, v) \
+	((d)->des3 = ((d)->des3 & 0xffffffcf) | v << 4)
+#define GET_CMDQ_FAS(d)	((d)->des3 & 0x0000000c)
+#define GET_CMDQ_DAS(d)	((d)->des3 & 0x00000030)
+	__le32 file_iv0;	/* des4 */
+	__le32 file_iv1;	/* des5 */
+	__le32 file_iv2;	/* des6 */
+	__le32 file_iv3;	/* des7 */
+	__le32 file_enckey0;	/* des8 */
+	__le32 file_enckey1;	/* des9 */
+	__le32 file_enckey2;	/* des10 */
+	__le32 file_enckey3;	/* des11 */
+	__le32 file_enckey4;	/* des12 */
+	__le32 file_enckey5;	/* des13 */
+	__le32 file_enckey6;	/* des14 */
+	__le32 file_enckey7;	/* des15 */
+	__le32 file_twkey0;	/* des16 */
+	__le32 file_twkey1;	/* des17 */
+	__le32 file_twkey2;	/* des18 */
+	__le32 file_twkey3;	/* des19 */
+	__le32 file_twkey4;	/* des20 */
+	__le32 file_twkey5;	/* des21 */
+	__le32 file_twkey6;	/* des22 */
+	__le32 file_twkey7;	/* des23 */
+	__le32 disk_iv0;	/* des24 */
+	__le32 disk_iv1;	/* des25 */
+	__le32 disk_iv2;	/* des26 */
+	__le32 disk_iv3;	/* des27 */
+	__le32 reserved0;	/* des28 */
+	__le32 reserved1;	/* des29 */
+	__le32 reserved2;	/* des30 */
+	__le32 reserved3;	/* des31 */
+};
+#endif
+
+struct fmp_data_setting {
+	struct fmp_crypto_info crypt[EXYNOS_FMP_ENC_MAX];
+	struct fmp_table_setting *table;
+	bool cmdq_enabled;
+};
+
+#define EXYNOS_FMP_ALGO_MODE_MASK (0x3)
+#define EXYNOS_FMP_ALGO_MODE_TEST_OFFSET (0xf)
+#define EXYNOS_FMP_ALGO_MODE_TEST (1 << EXYNOS_FMP_ALGO_MODE_TEST_OFFSET)
+
+struct fmp_test_data {
+	char block_type[FMP_BLOCK_TYPE_NAME_LEN];
+	struct block_device *bdev;
+	sector_t sector;
+	dev_t devt;
+	uint32_t test_block_offset;
+	/* iv to submitted */
+	u8 iv[FMP_IV_SIZE_16];
+	/* diskcipher for test */
+	struct fmp_crypto_info ci;
+};
+
+struct exynos_fmp {
+	struct device *dev;
+	enum fmp_disk_key_status status_disk_key;
+	struct fmp_test_data *test_data;
+};
+
+struct fmp_request {
+	void *table;
+	bool cmdq_enabled;
+	void *iv;
+	u32 ivsize;
+};
+
+static inline void exynos_fmp_bypass(void *desc, bool cmdq_enabled)
+{
+#if defined(CONFIG_MMC_DW_EXYNOS_FMP) ||
defined(CONFIG_SCSI_UFS_EXYNOS_FMP)
+	if (cmdq_enabled) {
+		SET_CMDQ_FAS((struct fmp_table_setting *)desc, 0);
+		SET_CMDQ_DAS((struct fmp_table_setting *)desc, 0);
+	} else {
+		SET_FAS((struct fmp_table_setting *)desc, 0);
+		SET_DAS((struct fmp_table_setting *)desc, 0);
+	}
+#endif
+}
+
+#define ACCESS_CONTROL_ABORT	0x14
+
+#ifndef SMC_CMD_FMP_SECURITY
+/* For FMP/SMU Ctrl */
+#define SMC_CMD_FMP_SECURITY		(0xC2001810)
+#define SMC_CMD_FMP_DISK_KEY_STORED	(0xC2001820)
+#define SMC_CMD_FMP_DISK_KEY_SET	(0xC2001830)
+#define SMC_CMD_FMP_DISK_KEY_CLEAR	(0xC2001840)
+#define SMC_CMD_SMU			(0xC2001850)
+#define SMC_CMD_FMP_SMU_RESUME		(0xC2001860)
+#define SMC_CMD_FMP_SMU_DUMP		(0xC2001870)
+#define SMC_CMD_UFS_LOG			(0xC2001880)
+
+/* For FMP/SMU Ctrl */
+#define SMC_CMD_FMP_SECURITY		(0xC2001810)
+#define SMC_CMD_FMP_DISK_KEY_STORED	(0xC2001820)
+#define SMC_CMD_FMP_DISK_KEY_SET	(0xC2001830)
+#define SMC_CMD_FMP_DISK_KEY_CLEAR	(0xC2001840)
+#define SMC_CMD_SMU			(0xC2001850)
+#define SMC_CMD_FMP_SMU_RESUME		(0xC2001860)
+#define SMC_CMD_FMP_SMU_DUMP		(0xC2001870)
+#define SMC_CMD_UFS_LOG			(0xC2001880)
+#endif
+
+enum smu_id {
+	SMU_EMBEDDED = 0,
+	SMU_UFSCARD = 1,
+	SMU_SDCARD = 2,
+	SMU_ID_MAX,
+};
+
+enum smu_command {
+	SMU_INIT = 0,
+	SMU_SET = 1,
+	SMU_ABORT = 2,
+};
+
+/* fmp functions */
+#ifdef CONFIG_EXYNOS_FMP
+int exynos_fmp_sec_cfg(int fmp_id, int smu_id, bool init);
+int exynos_fmp_smu_abort(int id);
+int exynos_fmp_crypt_cfg(struct bio *bio, void *table_base,
+		u32 page_idx, u32 sector_unit);
+int exynos_fmp_crypt_clear(struct bio *bio, void *table_addr);
+#else
+int exynos_fmp_sec_cfg(int fmp_id, int smu_id, bool init)
+{
+	return 0;
+}
+
+int exynos_fmp_smu_abort(int id)
+{
+	return 0;
+}
+
+int exynos_fmp_crypt_cfg(struct bio *bio, void *table_base,
+		u32 page_idx, u32 sector_unit)
+{
+	return 0;
+}
+
+int exynos_fmp_crypt_clear(struct bio *bio, void *table_addr)
+{
+	return 0;
+}
+#endif
+int exynos_fmp_crypt(struct fmp_crypto_info *ci, void *priv);
+int exynos_fmp_clear(struct fmp_crypto_info *ci, void *priv);
+int exynos_fmp_setkey(struct fmp_crypto_info *ci,
+		u8 *in_key, u32 keylen, bool persistent);
+int exynos_fmp_clearkey(struct fmp_crypto_info *ci);
+void *exynos_fmp_init(struct platform_device *pdev);
+void exynos_fmp_exit(struct exynos_fmp *fmp);
+int exynos_fmp_test_crypt(struct fmp_crypto_info *ci,
+		const uint8_t *iv, uint32_t ivlen, uint8_t *src,
+		uint8_t *dst, uint32_t len, bool enc, void *priv);
+#endif	/* _EXYNOS_FMP_H_ */
-- 
2.7.4

