Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4FD97295
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfHUGmh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:42:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10267 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfHUGmh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:37 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821064234epoutp0107761e50929f67ac24419c3ac15d853e~83P5AUZtT1005410054epoutp01P
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821064234epoutp0107761e50929f67ac24419c3ac15d853e~83P5AUZtT1005410054epoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369755;
        bh=lXH3d3b7N+K3mylwot5v8bTO+J7LAkcQhHDSqMe7C/M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=TuEd8Kw0zTaI7r4uZxnSqmJVW4fzUnL/LG1UWCso2OV8NSVcJIP5eWeRkwcT1zClX
         wP3b+6scxLvqa3gsV7yksHye4RuOc+mULYe/3smLGMGNIPwz6R6ksjYYoU8pK9MsvN
         MUzdzgDOpw8tkrflUCrlFA4hTjKyDVDwBF07TI9I=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20190821064234epcas2p489f837a13ef14307261c52ca8b5cc5c7~83P4Otjor1664116641epcas2p4d;
        Wed, 21 Aug 2019 06:42:34 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.189]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46CylC3sMHzMqYkW; Wed, 21 Aug
        2019 06:42:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        93.FD.04156.7D7EC5D5; Wed, 21 Aug 2019 15:42:31 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20190821064230epcas2p1ad7301f2b1331bcab3126e6e37c0e272~83P1P4DLo0242202422epcas2p13;
        Wed, 21 Aug 2019 06:42:30 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190821064230epsmtrp199195e636f4cb974d74d7f324f642ead~83P1Oh0Pg2011020110epsmtrp1g;
        Wed, 21 Aug 2019 06:42:30 +0000 (GMT)
X-AuditID: b6c32a45-df7ff7000000103c-8b-5d5ce7d7c3ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        02.12.03706.6D7EC5D5; Wed, 21 Aug 2019 15:42:30 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064230epsmtip269d9197aa07172ce59821d07762311d0~83P0vUduR2463324633epsmtip2F;
        Wed, 21 Aug 2019 06:42:30 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Alasdair Kergon'" <agk@redhat.com>,
        "'Mike Snitzer'" <snitzer@redhat.com>, <dm-devel@redhat.com>,
        <linux-kernel@vger.kernel.org>
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
Subject: [PATCH 6/9] dm crypt: support diskcipher
Date:   Wed, 21 Aug 2019 15:42:30 +0900
Message-ID: <004201d557eb$9b0a4410$d11ecc30$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6H6LclDwZf4gTNyTqFNYN8nzeA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf0wTZxjO17veVUbdWRl+q5vrjpmgptB2a/ehsJDMH+fmEhaXLHEQdoFb
        Yeuv9FpRl01HXCnKVow22gMZbsRtqPxoOySs7RZwIlNWJ9ENAroIborR8VOEDLe2Jxn/Pd/z
        Ps/3vG/evDJMIZBKWanFwdktrIkmkvC2rjUG9W9/5RdowtOpaHrKjaPmn89j6NSQh0AXvb0S
        VBvdj6Pw/RopOhP6B0MHR59BI80Chn6fc0mRZ/guhqLRFhL5h69JUXhgHbpxfVaCfHWDBLry
        5RY0WvcAR6FwD476OmoJdO5fD0DHohEJcrVOA/Rp1SyJus+8nfs0E/y2X8LsD5QxbT+uZvp6
        nYy/sZJgBq+FCCbQsJf5vn5SwpRf+glj/o5cJZjPg42AmfSvykveYcou4dhizq7iLEXW4lKL
        MYd+fXvhq4V6g0ar1mahl2mVhTVzOfTGbXnqzaWm2Oy0aidrcsaoPJbn6cxXsu1Wp4NTlVh5
        Rw7N2YpNNq3WlsGzZt5pMWYUWc3rtRqNTh9TvmsqGf9jEred3Lpr5usQvg/c2nAALJFB6iU4
        f6KFPACSZAqqHcCh29VS8TEB4GW/gMdVCuoBgK397y84poauEyIfBrDat0c03AFwRDhCxgsE
        tQ4GuhtBvJBCuQGsO9KfyMCoRyQcmehMfLuc0sKeihoQxzi1GjZExhO8nMqCY0f7gIiXwR7f
        SILHqOfg2Xu1mNiGCrb33k1oUqgMWB8oB6ImBdZUurB4GKTmSfjJIR8hGjbCG99VSkW8HI52
        B0kRK+Edj+sx3guvnvyKFM1VAF6aWyi8CIU/K2IJsljCGtjckRmHkEqD5wYe97YUurvmSZGW
        Q7dLIRpfgMcn+iQirYRjVR+LNAPDJy5KqsHzwqIhhUVDCouGEf6PrQd4I0jlbLzZyPE6m3bx
        sv0gcRdrN7WDY79s6wSUDNDJ8tn8/AKFlN3J7zZ3AijD6BT5rtodBQp5Mbt7D2e3FtqdJo7v
        BPrYDg5hyqeKrLErszgKtXqdwaDJ0iO9QYfoFfLAE/35CsrIOrgPOM7G2Rd8EtkS5T7w1soL
        lyuUH0VzS99oS3vvh2BPRys5JizVrPrC2IQdjsgPNq1Qa6rfFNI+S09Vq77pRd7hliuPPkzy
        3gv6Bm5Peecix92ed1Qh3eax09mHt+Y+NN9/0p2sSS8bvznjPn3L215u/7Vr0/kZ+fpnz7Lp
        bYMbmrbU5C27cLMhs2GmTPJagMb5Ela7FrPz7H9WNVOBLQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCSvO615zGxBgsmGlt8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlfHzwmaVgmWfF9+V7WBoYn1p3MXJy
        SAiYSHy5e4+ti5GLQ0hgN6PE6+vtLBAJKYmt7XuYIWxhifstR1ghip4zSsx90sAIkmAT0JbY
        fHwVI0hCRKCHUeL5rd9gHcwC0zgkdn0QB7GFBQwlTrbPBmtgEVCVWLLvI9gGXgFLiQ/TLzNC
        2IISJ2c+AYpzAPXqSbRtZIQYIy+x/e0cqCMUJHacfQ0WFwEqWbC5CapGRGJ2ZxvzBEbBWUgm
        zUKYNAvJpFlIOhYwsqxilEwtKM5Nzy02LDDMSy3XK07MLS7NS9dLzs/dxAhOA1qaOxgvL4k/
        xCjAwajEw7vjZnSsEGtiWXFl7iFGCQ5mJRHeijlRsUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        n+YdixQSSE8sSc1OTS1ILYLJMnFwSjUw8jptKBfLLF1seeqra83FCxqBsgte5j2X2rq33pdp
        qun1uybnfFY8mqqx4FZdh/Wl0OOB0843e8dpJC5+eS8usD1XpEPjou+bjfmtiSsWtwmazr03
        LSf4oYpHVuSFSf6f8/svFMzKmHB4zoGYEt0jOybb8s2cnlqpNn0P050Lh7QuxiqVBZ4qUWIp
        zkg01GIuKk4EAEdkX0f/AgAA
X-CMS-MailID: 20190821064230epcas2p1ad7301f2b1331bcab3126e6e37c0e272
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064230epcas2p1ad7301f2b1331bcab3126e6e37c0e272
References: <CGME20190821064230epcas2p1ad7301f2b1331bcab3126e6e37c0e272@epcas2p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch supports dm-crypt to use diskcipher in a specific ivmode
(disk or fmp).
Dm-crypt allocates diskcipher and sets the key on it.
Then, dm-crypt sets diskcipher into BIO and submits the BIO without
any additional data encryption.

Cc: Alasdair Kergon <agk@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: dm-devel@redhat.com
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 drivers/md/dm-crypt.c | 112
++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 103 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index 9f8b654..271cfcc 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -37,6 +37,7 @@
 #include <keys/user-type.h>
 
 #include <linux/device-mapper.h>
+#include <crypto/diskcipher.h>
 
 #define DM_MSG_PREFIX "crypt"
 
@@ -130,6 +131,8 @@ enum flags { DM_CRYPT_SUSPENDED, DM_CRYPT_KEY_VALID,
 enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cihper
*/
 	CRYPT_IV_LARGE_SECTORS,		/* Calculate IV from sector_size,
not 512B sectors */
+	CRYPT_MODE_DISKCIPHER,
+	CRYPT_MODE_SKCIPHER,
 };
 
 /*
@@ -170,6 +173,7 @@ struct crypt_config {
 	union {
 		struct crypto_skcipher **tfms;
 		struct crypto_aead **tfms_aead;
+		struct crypto_diskcipher **tfms_diskc;
 	} cipher_tfm;
 	unsigned tfms_count;
 	unsigned long cipher_flags;
@@ -955,6 +959,17 @@ static bool crypt_integrity_hmac(struct crypt_config
*cc)
 	return crypt_integrity_aead(cc) && cc->key_mac_size;
 }
 
+static bool crypt_mode_diskcipher(struct crypt_config *cc)
+{
+	return test_bit(CRYPT_MODE_DISKCIPHER, &cc->cipher_flags);
+}
+
+static bool crypt_mode_skcipher(struct crypt_config *cc)
+{
+	return test_bit(CRYPT_MODE_SKCIPHER, &cc->cipher_flags);
+}
+
+
 /* Get sg containing data */
 static struct scatterlist *crypt_get_sg_data(struct crypt_config *cc,
 					     struct scatterlist *sg)
@@ -1573,13 +1588,13 @@ static void crypt_endio(struct bio *clone)
 	/*
 	 * free the processed pages
 	 */
-	if (rw == WRITE)
+	if ((rw == WRITE) && !crypt_mode_diskcipher(cc))
 		crypt_free_buffer_pages(cc, clone);
 
 	error = clone->bi_status;
 	bio_put(clone);
 
-	if (rw == READ && !error) {
+	if (rw == READ && !error && !crypt_mode_diskcipher(cc)) {
 		kcryptd_queue_crypt(io);
 		return;
 	}
@@ -1618,6 +1633,11 @@ static int kcryptd_io_read(struct dm_crypt_io *io,
gfp_t gfp)
 	crypt_inc_pending(io);
 
 	clone_init(io, clone);
+
+	if (crypt_mode_diskcipher(cc))
+		crypto_diskcipher_set(clone,
+			cc->cipher_tfm.tfms_diskc[0], NULL, 0);
+
 	clone->bi_iter.bi_sector = cc->start + io->sector;
 
 	if (dm_crypt_integrity_io_alloc(io, clone)) {
@@ -1907,10 +1927,29 @@ static void crypt_free_tfms_skcipher(struct
crypt_config *cc)
 	cc->cipher_tfm.tfms = NULL;
 }
 
+static void crypt_free_tfms_diskcipher(struct crypt_config *cc)
+{
+	if (!crypt_mode_diskcipher(cc))
+		return;
+
+	if (cc->cipher_tfm.tfms_diskc[0] &&
+		!IS_ERR(cc->cipher_tfm.tfms_diskc[0])) {
+		crypto_diskcipher_clearkey(cc->cipher_tfm.tfms_diskc[0]);
+		crypto_free_diskcipher(cc->cipher_tfm.tfms_diskc[0]);
+		cc->cipher_tfm.tfms_diskc[0] = NULL;
+	}
+
+	kfree(cc->cipher_tfm.tfms_diskc);
+	cc->cipher_tfm.tfms_diskc = NULL;
+}
+
+
 static void crypt_free_tfms(struct crypt_config *cc)
 {
 	if (crypt_integrity_aead(cc))
 		crypt_free_tfms_aead(cc);
+	else if (crypt_mode_diskcipher(cc))
+		crypt_free_tfms_diskcipher(cc);
 	else
 		crypt_free_tfms_skcipher(cc);
 }
@@ -1934,6 +1973,7 @@ static int crypt_alloc_tfms_skcipher(struct
crypt_config *cc, char *ciphermode)
 			return err;
 		}
 	}
+	set_bit(CRYPT_MODE_SKCIPHER, &cc->cipher_flags);
 
 	/*
 	 * dm-crypt performance can vary greatly depending on which crypto
@@ -1965,10 +2005,34 @@ static int crypt_alloc_tfms_aead(struct crypt_config
*cc, char *ciphermode)
 	return 0;
 }
 
+static int crypt_alloc_tfms_diskcipher(struct crypt_config *cc,
+				char *ciphermode)
+{
+	int err;
+
+	cc->cipher_tfm.tfms = kmalloc(sizeof(struct crypto_aead *),
GFP_KERNEL);
+	if (!cc->cipher_tfm.tfms)
+		return -ENOMEM;
+
+	cc->cipher_tfm.tfms_diskc[0] =
+	    crypto_alloc_diskcipher(ciphermode, 0, 0, 1);
+	if (IS_ERR(cc->cipher_tfm.tfms_diskc[0])) {
+		err = PTR_ERR(cc->cipher_tfm.tfms_diskc[0]);
+		crypt_free_tfms(cc);
+		pr_err("%s: no diskcipher with %s\n", __func__, ciphermode);
+		return err;
+	}
+	pr_info("%s is done with %s\n", __func__, ciphermode);
+
+	return 0;
+}
+
 static int crypt_alloc_tfms(struct crypt_config *cc, char *ciphermode)
 {
 	if (crypt_integrity_aead(cc))
 		return crypt_alloc_tfms_aead(cc, ciphermode);
+	else if (crypt_mode_diskcipher(cc))
+		return crypt_alloc_tfms_diskcipher(cc, ciphermode);
 	else
 		return crypt_alloc_tfms_skcipher(cc, ciphermode);
 }
@@ -2030,6 +2094,11 @@ static int crypt_setkey(struct crypt_config *cc)
 			r = crypto_aead_setkey(cc->cipher_tfm.tfms_aead[i],
 					       cc->key + (i * subkey_size),
 					       subkey_size);
+		else if (crypt_mode_diskcipher(cc))
+			r = crypto_diskcipher_setkey(
+
cc->cipher_tfm.tfms_diskc[i],
+						cc->key + (i * subkey_size),
+						subkey_size, 1);
 		else
 			r = crypto_skcipher_setkey(cc->cipher_tfm.tfms[i],
 						   cc->key + (i *
subkey_size),
@@ -2510,7 +2579,7 @@ static int crypt_ctr_cipher_new(struct dm_target *ti,
char *cipher_in, char *key
 			return -ENOMEM;
 		}
 		cc->iv_size = crypto_aead_ivsize(any_tfm_aead(cc));
-	} else
+	} else if (crypt_mode_skcipher(cc))
 		cc->iv_size = crypto_skcipher_ivsize(any_tfm(cc));
 
 	ret = crypt_ctr_blkdev_cipher(cc);
@@ -2560,6 +2629,9 @@ static int crypt_ctr_cipher_old(struct dm_target *ti,
char *cipher_in, char *key
 	chainmode = strsep(&tmp, "-");
 	*ivmode = strsep(&tmp, ":");
 	*ivopts = tmp;
+	if (*ivmode)
+		if (!strcmp(*ivmode, "disk") || !strcmp(*ivmode, "fmp"))
+			set_bit(CRYPT_MODE_DISKCIPHER, &cc->cipher_flags);
 
 	/*
 	 * For compatibility with the original dm-crypt mapping format, if
@@ -2621,9 +2693,11 @@ static int crypt_ctr_cipher(struct dm_target *ti,
char *cipher_in, char *key)
 		return ret;
 
 	/* Initialize IV */
-	ret = crypt_ctr_ivmode(ti, ivmode);
-	if (ret < 0)
-		return ret;
+	if (!crypt_mode_diskcipher(cc)) {
+		ret = crypt_ctr_ivmode(ti, ivmode);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Initialize and set key */
 	ret = crypt_set_key(cc, key);
@@ -2654,6 +2728,11 @@ static int crypt_ctr_cipher(struct dm_target *ti,
char *cipher_in, char *key)
 	if (cc->key_string)
 		memset(cc->key, 0, cc->key_size * sizeof(u8));
 
+	pr_info("%s with ivmode:%s, ivopts:%s, aead:%d, diskcipher:%d(%p),
skcipher:%d\n",
+			__func__, ivmode, ivopts, crypt_integrity_aead(cc),
+			crypt_mode_diskcipher(cc),
cc->cipher_tfm.tfms_diskc[0],
+			crypt_mode_skcipher(cc));
+
 	return ret;
 }
 
@@ -2788,11 +2867,15 @@ static int crypt_ctr(struct dm_target *ti, unsigned
int argc, char **argv)
 	ret = crypt_ctr_cipher(ti, argv[0], argv[1]);
 	if (ret < 0)
 		goto bad;
-
 	if (crypt_integrity_aead(cc)) {
 		cc->dmreq_start = sizeof(struct aead_request);
 		cc->dmreq_start += crypto_aead_reqsize(any_tfm_aead(cc));
 		align_mask = crypto_aead_alignmask(any_tfm_aead(cc));
+	} else if (crypt_mode_diskcipher(cc)) {
+		cc->per_bio_data_size = ti->per_io_data_size =
+			ALIGN(sizeof(struct dm_crypt_io),
+			ARCH_KMALLOC_MINALIGN);
+		goto get_bio;
 	} else {
 		cc->dmreq_start = sizeof(struct skcipher_request);
 		cc->dmreq_start += crypto_skcipher_reqsize(any_tfm(cc));
@@ -2836,6 +2919,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned
int argc, char **argv)
 		goto bad;
 	}
 
+get_bio:
 	ret = bioset_init(&cc->bs, MIN_IOS, 0, BIOSET_NEED_BVECS);
 	if (ret) {
 		ti->error = "Cannot allocate crypt bioset";
@@ -2893,6 +2977,12 @@ static int crypt_ctr(struct dm_target *ti, unsigned
int argc, char **argv)
 		goto bad;
 	}
 
+	if (crypt_mode_diskcipher(cc)) {
+		cc->crypt_queue = NULL;
+		cc->write_thread = NULL;
+		goto out;
+	}
+
 	if (test_bit(DM_CRYPT_SAME_CPU, &cc->flags))
 		cc->crypt_queue = alloc_workqueue("kcryptd/%s",
 						  WQ_HIGHPRI |
WQ_CPU_INTENSIVE | WQ_MEM_RECLAIM,
@@ -2918,6 +3008,7 @@ static int crypt_ctr(struct dm_target *ti, unsigned
int argc, char **argv)
 	}
 	wake_up_process(cc->write_thread);
 
+out:
 	ti->num_flush_bios = 1;
 
 	return 0;
@@ -2981,10 +3072,10 @@ static int crypt_map(struct dm_target *ti, struct
bio *bio)
 
 	if (crypt_integrity_aead(cc))
 		io->ctx.r.req_aead = (struct aead_request *)(io + 1);
-	else
+	else if (crypt_mode_skcipher(cc))
 		io->ctx.r.req = (struct skcipher_request *)(io + 1);
 
-	if (bio_data_dir(io->base_bio) == READ) {
+	if ((bio_data_dir(io->base_bio) == READ) ||
crypt_mode_diskcipher(cc)) {
 		if (kcryptd_io_read(io, GFP_NOWAIT))
 			kcryptd_queue_read(io);
 	} else
@@ -3143,6 +3234,9 @@ static void crypt_io_hints(struct dm_target *ti,
struct queue_limits *limits)
 	limits->physical_block_size =
 		max_t(unsigned, limits->physical_block_size,
cc->sector_size);
 	limits->io_min = max_t(unsigned, limits->io_min, cc->sector_size);
+
+	if (crypt_mode_diskcipher(cc))
+		limits->logical_block_size = PAGE_SIZE;
 }
 
 static struct target_type crypt_target = {
-- 
2.7.4

