Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9F49972CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfHUGnV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:43:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:52553 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfHUGmV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:21 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20190821064215epoutp048d58db974b56e7343997aa3eea02b982~83PmzHAUw1235612356epoutp04Y
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20190821064215epoutp048d58db974b56e7343997aa3eea02b982~83PmzHAUw1235612356epoutp04Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369735;
        bh=3tBehBqI5ol47OnqdVD6jgOstGMohbizIgAlADES1Zs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=GaaiRsWlI1HQ+VPFn8n7o+m/5QhZkKeV/KwPb73HsbPoVy1YgBylkgwcn5NAjybql
         KJTGVvx2TPImiU3vAXwkS670dV43HOMuvh5Iq3nEoZsqeFe3KHfhRMOaxbcamuuteA
         GVEuFNtGXscBmdDL+JcFE6t3Ox81n+7bCDVHo6so=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190821064214epcas2p3a80d3627a4d4a89ca522e4a1df39ce34~83PlsBNAp0925009250epcas2p3k;
        Wed, 21 Aug 2019 06:42:14 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.184]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 46Cykq5d85zMqYlr; Wed, 21 Aug
        2019 06:42:11 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.CD.04156.3C7EC5D5; Wed, 21 Aug 2019 15:42:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20190821064211epcas2p43ed73f4fd126bcc5b470c9136db6aabc~83PjGS6jA1664116641epcas2p4w;
        Wed, 21 Aug 2019 06:42:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821064211epsmtrp1d58d3b97286205f84ed9e32b917d7d97~83PjFHVz_2011020110epsmtrp1H;
        Wed, 21 Aug 2019 06:42:11 +0000 (GMT)
X-AuditID: b6c32a45-df7ff7000000103c-3c-5d5ce7c3e480
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.D2.03638.3C7EC5D5; Wed, 21 Aug 2019 15:42:11 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064210epsmtip2a3dce3779191a3b2627b21e3a9f6c08f~83PimYZXg2145821458epsmtip2C;
        Wed, 21 Aug 2019 06:42:10 +0000 (GMT)
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
Subject: [PATCH 1/9] crypt: Add diskcipher
Date:   Wed, 21 Aug 2019 15:42:10 +0900
Message-ID: <003d01d557eb$8f6ca210$ae45e630$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6IuE1WJuT0BpQ1eJ5qpUVMZ+sg==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjO17teT2eXW+3ct05nd1MjmELbrfixgDHOuYvyB4sjS0wJXsoN
        mP21Xos/tkw2sANlK5oskdIBbqOGLoi0RImjxNAOpuNHIoMIo3OZMGMZTBFrcFPW9krGf8/7
        vM/zfe+TNy+JyTwSBVlmtnM2M2ukidX4pVAaUoXu6AvVoRMq9HChGkft1/sw9H3ERaCfvxoU
        Ic9wFY6Ccw1i1Nb9L4ZORdejqXY3hm4+doqR6/YMhoaHL0qQ//aYGAUntqFbvy2KUH3jJIFu
        fPM2ijbGcNQdvIajkSseAoWXXACdHe4RIWfHQ4BO1C5KUH/beztfZDpbx0VMVeAwc+nqZmZk
        0MH4fTUEMznWTTCB744zPzQ/EDGfDfyIMX/3jBLMl50+wDzwv5y/5oAxp5RjizmbkjMbLMVl
        5pJcet/+ojeLdFlqjUqTjbbTSjNr4nLp3Xn5qj1lxnh2WlnOGh1xKp/leTpzR47N4rBzylIL
        b8+lOWux0arRWDN41sQ7zCUZBovpDY1ardXFlQeNpUMTvxLW8AA44qqbxivAUAs4CVaRkHod
        Pu34NI5XkzKqC8CKvvuEUMwDOB6ZkwhFDMC6jmZs2eKt/AMTGkEAw7FYyn8XwKb2mCShIqht
        MNDvSzbkVBOAY5G55MMY9VQCp+Z78YRqLZUO6xpOihMYpzbDgdHGuJskpVQ2vHBOkaCl1HPw
        Wv1UUo5RG+HlWU9qDCXsGpxJppBTGfBOZFIkaOSwocaZ0tSQ8Mm0VsC7YZv7tEjAa2G0v1Mi
        YAW863Km8HE46v02mRlStQAOPF5uvAbdf34OErNhVBpsv5KZgJB6FYYnUqM9C6tDTyQCLYXV
        Tplg3AS/nh8RCbQC3qv9RKAZ6L0/iNWBV9wrMrpXZHSvyOL+/9tmgPvAOs7Km0o4XmvVrFy3
        HyQvI/2tLnB2KK8XUCSg10gX9fpCmZgt54+aegEkMVouPeI5UCiTFrNHj3E2S5HNYeT4XqCL
        b+A0pnjeYInfmdlepNFps7LU2Tqky9Ii+gVp4JlxvYwqYe3cIY6zcrZln4hcpagArfo9eR/U
        L0Q/XPJypwos5KMc37m+vzaob75fcJ1e+sId+iXKlru858PrGjetf2k+2GHY+o9l78YZo39X
        yxbyzLFo5uzs+QvvXn1UGaE2zBItW/f2VBWogjda3zEc1s3J0zKro/tyFj7afu9iw62Pf/Lv
        DNRPN3Vv2bX/YOXl3w/tqDLQOF/KatIxG8/+ByJqADcvBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWy7bCSvO7h5zGxBgfOiFl8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlnLt1m63gyBnGiv4JT1kaGM8tZexi
        5OSQEDCRWNb8iLmLkYtDSGA3o8SWZ/tZIBJSElvb9zBD2MIS91uOsEIUPWeUeHl3GTtIgk1A
        W2Lz8VWMIAkRgYWMEm9W72QDSTALTOOQ2PVBHMQWFtCSmDC7ixXEZhFQlThzdR5QMwcHr4Cl
        xLqFUiBhXgFBiZMzn7CAhJkF9CTaNjJCTJGX2P52DtQNChI7zr4Gi4sAlTy/e4cJokZEYnZn
        G/MERsFZSCbNQpg0C8mkWUg6FjCyrGKUTC0ozk3PLTYsMMpLLdcrTswtLs1L10vOz93ECE4E
        Wlo7GE+ciD/EKMDBqMTDu+NmdKwQa2JZcWXuIUYJDmYlEd6KOVGxQrwpiZVVqUX58UWlOanF
        hxilOViUxHnl849FCgmkJ5akZqemFqQWwWSZODilGhg5+OPbT+ysuTUlSDVhZonmBo1eWX5f
        o7OpKim3Y+9u3H3fTmPtX6HJHlLJz7yKLofwxjcuvLm9frv8mXcf2gUu8Jr1l/VmeS5MEqqd
        WPx2R/6E/J9XApn755xd8vf4jbCcG/2LftkmxEVMXBPB5qm78mR/97/zAXulVv649X999O+K
        Hl3vE9uVWIozEg21mIuKEwElvNaVAAMAAA==
X-CMS-MailID: 20190821064211epcas2p43ed73f4fd126bcc5b470c9136db6aabc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064211epcas2p43ed73f4fd126bcc5b470c9136db6aabc
References: <CGME20190821064211epcas2p43ed73f4fd126bcc5b470c9136db6aabc@epcas2p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Diskcipher supports cryptographic operations of inline crypto engines like
FMP. Inline crypto engine refers to hardware and solutions implemented
to encrypt data stored in storage device.

When encrypting using the FMP, Additional control is required
to carry and maintain the crypto information between
the encryption user(fscrypt, DM-crypt) and FMP driver.
Diskcipher provides this control.

Diskcipher is a symmetric key cipher in linux crypto API to support FMP.
FMP are registered with the cihper algorithm that uses diskcipher.

Diskcipher has three major steps.
The first step is to assign a cipher and set the key.
The second step is to pass the cipher through the BIO to the storage
driver.
The third step is to get the cipher from BIO and request a crypt
to FMP algorithm.

In the first step, encryption users such as fscrypt or dm-crypt
allocate/release a diskcipher and set key into the diskcipher.
Diskcipher provides allocate(), free(), and setkey() that are similar
to existing ciphers.

In the second step, BIO is used to pass the diskcipher to the storage
driver.
The BIO submitters such as ext4, f2fs and DM-crypt set diskcipher to BIO.
Diskcipher provides the set () API for this.

In the third step, the storage driver extracts the diskcipher from the BIO
and requests the actual encryption behavior to inline crypto engine driver.
Diskcipher provides get() and crypt() APIs for this.

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 crypto/Kconfig              |   9 ++
 crypto/Makefile             |   1 +
 crypto/diskcipher.c         | 349
++++++++++++++++++++++++++++++++++++++++++++
 crypto/testmgr.c            | 157 ++++++++++++++++++++
 include/crypto/diskcipher.h | 245 +++++++++++++++++++++++++++++++
 include/linux/crypto.h      |   1 +
 6 files changed, 762 insertions(+)
 create mode 100644 crypto/diskcipher.c
 create mode 100644 include/crypto/diskcipher.h

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 455a335..382d43a 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1636,6 +1636,15 @@ config CRYPTO_TWOFISH_AVX_X86_64
 	  See also:
 	  <http://www.schneier.com/twofish.html>
 
+config CRYPTO_DISKCIPHER
+	bool "Diskcipher support"
+	default n
+	help
+	  Disk cipher algorithm
+
+	  This cipher supports the crypt operation of the block host device
+	  that has inline crypto engine.
+
 comment "Compression"
 
 config CRYPTO_DEFLATE
diff --git a/crypto/Makefile b/crypto/Makefile
index 0d2cdd5..71df76a 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -165,6 +165,7 @@ obj-$(CONFIG_CRYPTO_USER_API_AEAD) += algif_aead.o
 obj-$(CONFIG_CRYPTO_ZSTD) += zstd.o
 obj-$(CONFIG_CRYPTO_OFB) += ofb.o
 obj-$(CONFIG_CRYPTO_ECC) += ecc.o
+obj-$(CONFIG_CRYPTO_DISKCIPHER) += diskcipher.o
 
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
diff --git a/crypto/diskcipher.c b/crypto/diskcipher.c
new file mode 100644
index 0000000..ffe95a5
--- /dev/null
+++ b/crypto/diskcipher.c
@@ -0,0 +1,349 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2017 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/string.h>
+#include <linux/crypto.h>
+#include <crypto/algapi.h>
+#include <crypto/diskcipher.h>
+#include <linux/delay.h>
+#include <linux/mm_types.h>
+#include <linux/fs.h>
+#include <linux/fscrypt.h>
+
+#include "internal.h"
+
+static int crypto_diskcipher_check(struct bio *bio)
+{
+	struct crypto_diskcipher *ci = NULL;
+	struct inode *inode = NULL;
+	struct page *page = NULL;
+
+	if (!bio) {
+		pr_err("%s: doesn't exist bio\n", __func__);
+		return 0;
+	}
+
+	/* enc without fscrypt */
+	ci = bio->bi_aux_private;
+	if (!ci->inode)
+		return 0;
+	if (ci->algo == 0)
+		return 0;
+
+	page = bio->bi_io_vec[0].bv_page;
+	if (!page || PageAnon(page) || !page->mapping ||
!page->mapping->host)
+		return 0;
+
+	inode = page->mapping->host;
+	if (ci->inode != inode) {
+		pr_err("%s: fails to invalid inode\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!fscrypt_has_encryption_key(inode)) {
+		pr_err("%s: fails to invalid key\n", __func__);
+		return -EINVAL;
+	}
+
+	ci = fscrypt_get_diskcipher(inode);
+	if (!ci) {
+		pr_err("%s: fails to invalid crypto info\n", __func__);
+		return -EINVAL;
+	} else if ((bio->bi_aux_private != ci) &&
+			!(bio->bi_flags & REQ_OP_DISCARD)) {
+		pr_err("%s: fails to async crypto info\n", __func__);
+		return -EINVAL;
+	}
+	return 0;
+}
+
+struct crypto_diskcipher *crypto_diskcipher_get(struct bio *bio)
+{
+	struct crypto_diskcipher *diskc = NULL;
+
+	if (!bio || !virt_addr_valid(bio)) {
+		pr_err("%s: Invalid bio:%pK\n", __func__, bio);
+		return NULL;
+	}
+	if (bio->bi_opf & REQ_CRYPT) {
+		if (bio->bi_aux_private) {
+			if (!crypto_diskcipher_check(bio)) {
+				diskc = bio->bi_aux_private;
+			} else {
+				pr_err("%s: fail to check diskcipher
bio:%pK\n",
+						__func__, bio);
+				diskc = ERR_PTR(-EINVAL);
+			}
+		} else {
+			pr_err("%s: no diskcipher on bio:%pK\n",
+					__func__, bio);
+			diskc = ERR_PTR(-EINVAL);
+		}
+	}
+
+	return diskc;
+}
+
+static inline void *bio_has_crypt(struct bio *bio)
+{
+	if (bio)
+		if (bio->bi_opf & REQ_CRYPT)
+			return bio->bi_aux_private;
+	return NULL;
+}
+
+bool crypto_diskcipher_blk_mergeble(struct bio *bio1, struct bio *bio2)
+{
+	if (!bio_has_crypt(bio1) && !bio_has_crypt(bio2))
+		return true;
+
+	if (bio_has_crypt(bio1) == bio_has_crypt(bio2)) {
+		struct crypto_diskcipher *tfm1 = bio1->bi_aux_private;
+		struct crypto_diskcipher *tfm2 = bio2->bi_aux_private;
+
+		/* no inode for DM-crypt and DM-default-key */
+		if (!tfm1->inode)
+			return true;
+
+		if ((tfm1->ivmode == IV_MODE_DUN) &&
+			(tfm2->ivmode == IV_MODE_DUN)) {
+			if (bio_dun(bio1) && bio_dun(bio2) &&
+				(bio_end_dun(bio1) == bio_dun(bio2)))
+				return true;
+		} else if ((tfm1->ivmode == IV_MODE_LBA) &&
+			(tfm2->ivmode == IV_MODE_LBA)) {
+			return true;
+		}
+	}
+	return false;
+}
+
+void crypto_diskcipher_set(struct bio *bio, struct crypto_diskcipher *tfm,
+				const struct inode *inode, u64 dun)
+{
+	if (bio && tfm) {
+		bio->bi_opf |= REQ_CRYPT;
+		bio->bi_aux_private = tfm;
+		tfm->inode = (struct inode *)inode;
+		if (dun)
+			bio->bi_iter.bi_dun = dun;
+	}
+}
+
+int crypto_diskcipher_setkey(struct crypto_diskcipher *tfm, const char
*in_key,
+				unsigned int key_len, bool persistent)
+{
+	struct crypto_tfm *base = crypto_diskcipher_tfm(tfm);
+	struct diskcipher_alg *cra =
__crypto_diskcipher_alg(base->__crt_alg);
+	int ret = -EINVAL;
+	struct inode *inode = tfm->inode;
+
+	if (cra)
+		ret = cra->setkey(tfm, in_key, key_len, persistent);
+	else
+		pr_err("%s: doesn't exist cra. base:%pK", __func__, base);
+
+	tfm->ivmode = IV_MODE_LBA;
+	if (!persistent && inode) {
+		/* check the filesystem for fscrypt */
+		if (inode->i_sb)
+			if (inode->i_sb->s_type)
+				if (!strcmp(inode->i_sb->s_type->name,
"f2fs"))
+					tfm->ivmode = IV_MODE_DUN;
+	}
+	return ret;
+}
+
+int crypto_diskcipher_clearkey(struct crypto_diskcipher *tfm)
+{
+	struct crypto_tfm *base = crypto_diskcipher_tfm(tfm);
+	struct diskcipher_alg *cra =
__crypto_diskcipher_alg(base->__crt_alg);
+	int ret = -EINVAL;
+
+	if (cra)
+		ret = cra->clearkey(tfm);
+	else
+		pr_err("%s: doesn't exist cra. base:%pK", __func__, base);
+
+	return ret;
+}
+
+int crypto_diskcipher_set_crypt(struct crypto_diskcipher *tfm, void *req)
+{
+	struct crypto_tfm *base = crypto_diskcipher_tfm(tfm);
+	struct diskcipher_alg *cra = NULL;
+	int ret = -EINVAL;
+
+	if (!base) {
+		pr_err("%s: doesn't exist base. tfm:%pK", __func__, tfm);
+		goto out;
+	}
+
+	cra = __crypto_diskcipher_alg(base->__crt_alg);
+	if (!cra) {
+		pr_err("%s: doesn't exist cra. base:%pK\n", __func__, base);
+		goto out;
+	}
+
+	ret = cra->crypt(tfm, req);
+	if (ret)
+		pr_err("%s fails ret:%d, cra:%pK\n", __func__, ret, cra);
+out:
+	return ret;
+}
+
+int crypto_diskcipher_clear_crypt(struct crypto_diskcipher *tfm, void *req)
+{
+	struct crypto_tfm *base = crypto_diskcipher_tfm(tfm);
+	struct diskcipher_alg *cra = NULL;
+	int ret = -EINVAL;
+
+	if (!base) {
+		pr_err("%s: doesn't exist base, tfm:%pK\n", __func__, tfm);
+		goto out;
+	}
+
+	cra = __crypto_diskcipher_alg(base->__crt_alg);
+	if (!cra) {
+		pr_err("%s: doesn't exist cra. base:%pK\n", __func__, base);
+		goto out;
+	}
+
+	ret = cra->clear(tfm, req);
+	if (ret)
+		pr_err("%s fails ret:%d, cra:%pK\n", __func__, ret, cra);
+out:
+	return ret;
+}
+
+int diskcipher_do_crypt(struct crypto_diskcipher *tfm,
+			struct diskcipher_test_request *req)
+{
+	struct crypto_tfm *base = crypto_diskcipher_tfm(tfm);
+	struct diskcipher_alg *cra =
__crypto_diskcipher_alg(base->__crt_alg);
+	int ret = -EINVAL;
+
+	if (!cra) {
+		pr_err("%s: doesn't exist cra. base:%pK\n", __func__, base);
+		return ret;
+	}
+
+	if (cra->do_crypt)
+		ret = cra->do_crypt(tfm, req);
+	if (ret)
+		pr_err("%s fails ret:%d", __func__, ret);
+	return ret;
+}
+
+static int crypto_diskcipher_init_tfm(struct crypto_tfm *base)
+{
+	struct crypto_diskcipher *tfm = __crypto_diskcipher_cast(base);
+	struct diskcipher_alg *alg = crypto_diskcipher_alg(tfm);
+
+	if (alg->init)
+		alg->init(tfm);
+	return 0;
+}
+
+unsigned int crypto_diskcipher_extsize(struct crypto_alg *alg)
+{
+	return alg->cra_ctxsize +
+		(alg->cra_alignmask & ~(crypto_tfm_ctx_alignment() - 1));
+}
+
+static void crypto_diskcipher_show(struct seq_file *m, struct crypto_alg
*alg)
+{
+	seq_puts(m, "type         : diskcipher\n");
+}
+
+static const struct crypto_type crypto_diskcipher_type = {
+	.extsize = crypto_diskcipher_extsize,
+	.init_tfm = crypto_diskcipher_init_tfm,
+#ifdef CONFIG_PROC_FS
+	.show = crypto_diskcipher_show,
+#endif
+	.maskclear = ~CRYPTO_ALG_TYPE_MASK,
+	.maskset = CRYPTO_ALG_TYPE_MASK,
+	.type = CRYPTO_ALG_TYPE_DISKCIPHER,
+	.tfmsize = offsetof(struct crypto_diskcipher, base),
+};
+
+#define DISKC_NAME		"-disk"
+#define DISKC_NAME_SIZE		(5)
+#define DISKCIPHER_MAX_IO_MS	(1000)
+struct crypto_diskcipher *crypto_alloc_diskcipher(const char *alg_name,
+					u32 type, u32 mask, bool force)
+{
+	int alg_name_len;
+
+	if (!force)
+		return crypto_alloc_tfm(alg_name,
+				&crypto_diskcipher_type, type, mask);
+
+	alg_name_len = strlen(alg_name);
+	if (alg_name_len + DISKC_NAME_SIZE < CRYPTO_MAX_ALG_NAME) {
+		char diskc_name[CRYPTO_MAX_ALG_NAME];
+
+		strscpy(diskc_name, alg_name, alg_name_len);
+		strcat(diskc_name, DISKC_NAME);
+		return crypto_alloc_tfm(diskc_name,
+				&crypto_diskcipher_type, type, mask);
+	}
+	return NULL;
+}
+
+void crypto_free_diskcipher(struct crypto_diskcipher *tfm)
+{
+	crypto_destroy_tfm(tfm, crypto_diskcipher_tfm(tfm));
+}
+
+int crypto_register_diskcipher(struct diskcipher_alg *alg)
+{
+	struct crypto_alg *base = &alg->base;
+
+	base->cra_type = &crypto_diskcipher_type;
+	base->cra_flags = CRYPTO_ALG_TYPE_DISKCIPHER;
+	return crypto_register_alg(base);
+}
+
+void crypto_unregister_diskcipher(struct diskcipher_alg *alg)
+{
+	crypto_unregister_alg(&alg->base);
+}
+
+int crypto_register_diskciphers(struct diskcipher_alg *algs, int count)
+{
+	int i, ret;
+
+	for (i = 0; i < count; i++) {
+		ret = crypto_register_diskcipher(algs + i);
+		if (ret)
+			goto err;
+	}
+	return 0;
+
+err:
+	for (--i; i >= 0; --i)
+		crypto_unregister_diskcipher(algs + i);
+	return ret;
+}
+
+void crypto_unregister_diskciphers(struct diskcipher_alg *algs, int count)
+{
+	int i;
+
+	for (i = count - 1; i >= 0; --i)
+		crypto_unregister_diskcipher(algs + i);
+}
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index d990eba..348dafcb 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -30,6 +30,7 @@
 #include <crypto/rng.h>
 #include <crypto/drbg.h>
 #include <crypto/akcipher.h>
+#include <crypto/diskcipher.h>
 #include <crypto/kpp.h>
 #include <crypto/acompress.h>
 #include <crypto/internal/simd.h>
@@ -2291,6 +2292,146 @@ static int test_aead(const char *driver, int enc,
 	return 0;
 }
 
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+static int __test_diskcipher(struct crypto_diskcipher *tfm, int enc,
+			const struct cipher_testvec *template,
+			unsigned int tcount, const int align_offset)
+{
+	const char *algo =
+		crypto_tfm_alg_driver_name(crypto_diskcipher_tfm(tfm));
+	unsigned int i, j;
+	char *q;
+	struct scatterlist sg[8];
+	struct scatterlist sgout[8];
+	const char *e = (enc == ENCRYPT) ? "encryption" : "decryption";
+	void *data;
+	char iv[MAX_IVLEN];
+	char *xbuf[XBUFSIZE];
+	char *xoutbuf[XBUFSIZE];
+	int ret = -ENOMEM;
+	unsigned int ivsize = crypto_diskcipher_ivsize(tfm);
+	struct diskcipher_test_request req;
+	const char *input, *result;
+
+	if (testmgr_alloc_buf(xbuf))
+		goto out_nobuf;
+
+	if (testmgr_alloc_buf(xoutbuf))
+		goto out_nooutbuf;
+
+	j = 0;
+	for (i = 0; i < tcount; i++) {
+		if (template[i].np && !template[i].also_non_np)
+			continue;
+
+		if (template[i].fips_skip)
+			continue;
+
+		if (template[i].iv)
+			memcpy(iv, template[i].iv, ivsize);
+		else
+			memset(iv, 0, MAX_IVLEN);
+
+		input  = enc ? template[i].ptext : template[i].ctext;
+		result = enc ? template[i].ctext : template[i].ptext;
+		j++;
+		ret = -EINVAL;
+		if (WARN_ON(align_offset + template[i].len > PAGE_SIZE))
+			goto out;
+
+		ret = crypto_diskcipher_setkey(tfm, template[i].key,
+					     template[i].klen, 0);
+		if (ret == -ENOKEY) {
+			pr_err("alg: diskcipher: no support %d keylen for
%s. skip it\n",
+			       template[i].klen, algo);
+			continue;
+		} else if (ret) {
+			pr_err("alg: diskcipher: setkey failed on test %d
for %s\n",
+				   j, algo);
+			goto out;
+		}
+
+		data = xbuf[0];
+		data += align_offset;
+		memcpy(data, input, template[i].len);
+		sg_init_one(&sg[0], data, template[i].len);
+
+		data = xoutbuf[0];
+		data += align_offset;
+		sg_init_one(&sgout[0], data, template[i].len);
+
+		diskcipher_request_set_crypt(&req, sg, sgout,
+				template[i].len, iv, enc ? 1 : 0);
+		ret = diskcipher_do_crypt(tfm, &req);
+		if (ret) {
+			pr_err("alg: diskcipher: %s failed on test %d for
%s: ret=%d\n",
+				   e, j, algo, -ret);
+			goto out;
+		}
+
+		q = data;
+		if (memcmp(q, result, template[i].len)) {
+			pr_err("alg: diskcipher: Test %d failed (invalid
result) on %s for %s\n",
+			       j, e, algo);
+			hexdump(q, template[i].len);
+			ret = -EINVAL;
+			goto out;
+		}
+	}
+	ret = 0;
+
+out:
+	testmgr_free_buf(xoutbuf);
+out_nooutbuf:
+	testmgr_free_buf(xbuf);
+out_nobuf:
+	return ret;
+}
+
+static int test_diskcipher(struct crypto_diskcipher *tfm, int enc,
+			 const struct cipher_testvec *template,
+			 unsigned int tcount)
+{
+	int ret;
+
+	ret = __test_diskcipher(tfm, enc, template, tcount, 0);
+	if (ret)
+		return ret;
+
+	/* test unaligned buffers, check with one byte offset */
+	ret = __test_diskcipher(tfm, enc, template, tcount, 1);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int alg_test_diskcipher(const struct alg_test_desc *desc,
+			     const char *driver, u32 type, u32 mask)
+{
+	struct crypto_diskcipher *tfm;
+	const struct cipher_test_suite *suite = &desc->suite.cipher;
+	int err = 0;
+
+	tfm = crypto_alloc_diskcipher(driver, type | CRYPTO_ALG_INTERNAL,
+					mask, 0);
+	if (!tfm || IS_ERR(tfm)) {
+		pr_err("alg: diskcipher: Failed to load transform for %s:
%ld\n",
+			driver, PTR_ERR(tfm));
+		return PTR_ERR(tfm);
+	}
+
+	err = test_diskcipher(tfm, ENCRYPT, suite->vecs, suite->count);
+	if (err)
+		goto out;
+
+	err = test_diskcipher(tfm, DECRYPT, suite->vecs, suite->count);
+out:
+	crypto_free_diskcipher(tfm);
+	return err;
+}
+#endif
+
 static int alg_test_aead(const struct alg_test_desc *desc, const char
*driver,
 			 u32 type, u32 mask)
 {
@@ -4029,6 +4170,14 @@ static const struct alg_test_desc alg_test_descs[] =
{
 		.suite = {
 			.cipher = __VECS(aes_cbc_tv_template)
 		},
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+	}, {
+		.alg = "cbc(aes)-disk",
+		.test = alg_test_diskcipher,
+		.suite = {
+			.cipher = __VECS(aes_cbc_tv_template)
+		}
+#endif
 	}, {
 		.alg = "cbc(anubis)",
 		.test = alg_test_skcipher,
@@ -5035,6 +5184,14 @@ static const struct alg_test_desc alg_test_descs[] =
{
 		.suite = {
 			.cipher = __VECS(aes_xts_tv_template)
 		}
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+	}, {
+		.alg = "xts(aes)-disk",
+		.test = alg_test_diskcipher,
+		.suite = {
+			.cipher = __VECS(aes_xts_tv_template)
+		}
+#endif
 	}, {
 		.alg = "xts(camellia)",
 		.generic_driver = "xts(ecb(camellia-generic))",
diff --git a/include/crypto/diskcipher.h b/include/crypto/diskcipher.h
new file mode 100644
index 0000000..a0a9879
--- /dev/null
+++ b/include/crypto/diskcipher.h
@@ -0,0 +1,245 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2017 Samsung Electronics Co., Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef _DISKCIPHER_H_
+#define _DISKCIPHER_H_
+
+#include <linux/crypto.h>
+#include <linux/blk_types.h>
+
+struct diskcipher_alg;
+
+enum iv_mode {
+	IV_MODE_LBA, /* dm-dcrypt/ext4 uses it for more blk merge */
+	IV_MODE_DUN, /* f2fs should use it for garbeage colloection */
+};
+
+struct crypto_diskcipher {
+	u32 algo;
+	unsigned int ivsize;
+	struct inode *inode;
+	/* for crypto_free_req_diskcipher */
+	atomic_t status;
+	struct crypto_tfm base;
+	enum iv_mode ivmode;
+};
+
+struct diskcipher_test_request {
+	unsigned int cryptlen;
+	const u8 *iv;
+	struct scatterlist *src;
+	struct scatterlist *dst;
+	bool enc;
+};
+
+/**
+ * struct diskcipher_alg - disk cipher definition
+ * for inline crypto engine on disk host device
+ *
+ * @setkey
+ * @clearkey
+ * @crypt
+ * @clear
+ * @do_crypt
+ * @base:	Common crypto API algorithm data structure.
+ *
+ * Diskcipher supports APIs to set crypto information for dm-crypt and
fscrypt
+ * And pass the crypto information to disk host device via bio.
+ * Crypt operation executes on inline crypto on disk host device.
+ */
+struct diskcipher_alg {
+	int (*init)(struct crypto_diskcipher *tfm);
+	int (*exit)(struct crypto_diskcipher *tfm);
+	int (*setkey)(struct crypto_diskcipher *tfm, const char *key,
+			u32 keylen, bool persistent);
+	int (*clearkey)(struct crypto_diskcipher *tfm);
+	int (*crypt)(struct crypto_diskcipher *tfm, void *req);
+	int (*clear)(struct crypto_diskcipher *tfm, void *req);
+	int (*do_crypt)(struct crypto_diskcipher *tfm,
+			struct diskcipher_test_request *req);
+	struct device *dev;
+	struct crypto_alg base;
+};
+
+static inline unsigned int crypto_diskcipher_ivsize(
+		struct crypto_diskcipher *tfm)
+{
+	return tfm->ivsize;
+}
+
+static inline struct crypto_tfm *crypto_diskcipher_tfm(
+		struct crypto_diskcipher *tfm)
+{
+	return &tfm->base;
+}
+
+static inline struct diskcipher_alg *__crypto_diskcipher_alg(
+		struct crypto_alg *alg)
+{
+	return container_of(alg, struct diskcipher_alg, base);
+}
+static inline struct diskcipher_alg *crypto_diskcipher_alg(
+		struct crypto_diskcipher *tfm)
+{
+	return
__crypto_diskcipher_alg(crypto_diskcipher_tfm(tfm)->__crt_alg);
+}
+
+static inline struct crypto_diskcipher *__crypto_diskcipher_cast(
+	struct crypto_tfm *tfm)
+{
+	return container_of(tfm, struct crypto_diskcipher, base);
+}
+
+int crypto_register_diskcipher(struct diskcipher_alg *alg);
+void crypto_unregister_diskcipher(struct diskcipher_alg *alg);
+int crypto_register_diskciphers(struct diskcipher_alg *algs, int count);
+void crypto_unregister_diskciphers(struct diskcipher_alg *algs, int count);
+
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+/**
+ * crypto_alloc_diskcipher() - allocate disk cipher running on disk device
+ * @alg_name: is the cra_name / name or cra_driver_name / driver name of
the
+ *	      skcipher cipher
+ * @type: specifies the type of the cipher
+ * @mask: specifies the mask for the cipher
+ * @force: add diskcipher postfix '-disk' on algo_name
+ *
+ * Allocate a cipher handle for an diskcipher. The returned struct
+ * crypto_diskcipher is the cipher handle that is required for any
subsequent
+ * API invocation for that diskcipher.
+ *
+ * Return: allocated cipher handle in case of success; IS_ERR() is true in
case
+ *	   of an error, PTR_ERR() returns the error code.
+ */
+struct crypto_diskcipher *crypto_alloc_diskcipher(const char *alg_name,
+			  u32 type, u32 mask, bool force);
+
+/**
+ * crypto_free_diskcipher() - zeroize and free cipher handle
+ * @tfm: cipher handle to be freed
+ */
+void crypto_free_diskcipher(struct crypto_diskcipher *tfm);
+
+/**
+ * crypto_diskcipher_get() - get diskcipher from bio
+ * @bio: bio structure
+ */
+struct crypto_diskcipher *crypto_diskcipher_get(struct bio *bio);
+
+/**
+ * crypto_diskcipher_set() - set diskcipher to bio
+ * @bio: bio structure to contain diskcipher
+ * @tfm: cipher handle
+ *
+ * This functions set thm to bio->bi_aux_private to pass it to host driver.
+ *
+ */
+void crypto_diskcipher_set(struct bio *bio, struct crypto_diskcipher *tfm,
+			const struct inode *inode, u64 dun);
+
+/**
+ * crypto_diskcipher_setkey() - set key for cipher
+ * @tfm: cipher handle
+ * @key: buffer holding the key
+ * @keylen: length of the key in bytes
+ * @persistent: option of key storage option
+ *
+ * The caller provided key is set for the skcipher referenced by the cipher
+ * handle.
+ *
+ * Return: 0 if the setting of the key was successful; < 0 if an error
occurred
+ */
+int crypto_diskcipher_setkey(struct crypto_diskcipher *tfm, const char
*key,
+			     u32 keylen, bool persistent);
+
+/**
+ * crypto_diskcipher_clearkey() - clear key
+ * @tfm: cipher handle
+ */
+int crypto_diskcipher_clearkey(struct crypto_diskcipher *tfm);
+
+/**
+ * crypto_diskcipher_set_crypt() - set crypto info for inline crypto engine
+ * @tfm: cipher handle
+ * @req: request handle. it's specific structure for inline crypt hardware
+ *
+ * Return: 0 if the setting of the key was successful; < 0 if an error
occurred
+ */
+int crypto_diskcipher_set_crypt(struct crypto_diskcipher *tfm, void *req);
+
+/**
+ * crypto_diskcipher_clear_crypt() - clear crypto info on inline crypt
hardware
+ * @tfm: cipher handle
+ * @req: request handle. it's specific structure for inline crypt hardware
+ *
+ * Return: 0 if the setting of the key was successful; < 0 if an error
occurred
+ */
+int crypto_diskcipher_clear_crypt(struct crypto_diskcipher *tfm, void
*req);
+
+/**
+ * diskcipher_do_crypt() - execute crypto for test
+ * @tfm: cipher handle
+ * @req: diskcipher_test_request handle
+ *
+ * The caller uses this function to request crypto
+ * Diskcipher_algo allocates the block area for test and then request block
I/O
+ *
+ */
+int diskcipher_do_crypt(struct crypto_diskcipher *tfm,
+				struct diskcipher_test_request *req);
+
+/**
+ * diskcipher_request_set_crypt() - fill diskcipher_test_requeust
+ * @req: request handle
+ * @src: source scatter / gather list
+ * @dst: destination scatter / gather list
+ * @cryptlen: number of bytes to process from @src
+ * @iv: IV for the cipher operation which must comply with the IV size
defined
+ *      by crypto_skcipher_ivsize
+ * @enc: encrypt(1) / decrypt(0)
+ *
+ * This function allows setting of the source data and destination data
+ * scatter / gather lists.
+ *
+ * For encryption, the source is treated as the plaintext and the
+ * destination is the ciphertext. For a decryption operation, the use is
+ * reversed - the source is the ciphertext and the destination is the
plaintext.
+ */
+static inline void diskcipher_request_set_crypt(
+	struct diskcipher_test_request *req,
+	struct scatterlist *src, struct scatterlist *dst,
+	unsigned int cryptlen, void *iv, bool enc)
+{
+	req->src = src;
+	req->dst = dst;
+	req->cryptlen = cryptlen;
+	req->iv = iv;
+	req->enc = enc;
+}
+
+/**
+ * crypto_diskcipher_blk_mergeble() - check the crypt option of bios and
decide
+ * whether to merge or not
+ * @bio1: a bio to be mergeable
+ * @bio2: a bio to be mergeable
+ */
+bool crypto_diskcipher_blk_mergeble(struct bio *bio1, struct bio *bio2);
+
+#else
+
+#define crypto_alloc_diskcipher(a, b, c, d) ((void *)NULL)
+#define crypto_free_diskcipher(a) ((void)0)
+#define crypto_diskcipher_get(a) ((void *)NULL)
+#define crypto_diskcipher_set(a, b, c, d) ((void)0)
+#define crypto_diskcipher_clearkey(a) ((void)0)
+#define crypto_diskcipher_setkey(a, b, c, d) (-EINVAL)
+#define crypto_diskcipher_blk_mergeble(a, b) (0)
+#endif
+#endif	/* _DISKCIPHER_H_ */
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index 19ea3a3..3a8be78 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -44,6 +44,7 @@
 #define CRYPTO_ALG_TYPE_BLKCIPHER	0x00000004
 #define CRYPTO_ALG_TYPE_ABLKCIPHER	0x00000005
 #define CRYPTO_ALG_TYPE_SKCIPHER	0x00000005
+#define CRYPTO_ALG_TYPE_DISKCIPHER      0x00000007
 #define CRYPTO_ALG_TYPE_KPP		0x00000008
 #define CRYPTO_ALG_TYPE_ACOMPRESS	0x0000000a
 #define CRYPTO_ALG_TYPE_SCOMPRESS	0x0000000b
-- 
2.7.4

