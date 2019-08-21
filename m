Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7495A972B3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbfHUGnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Aug 2019 02:43:05 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10324 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfHUGmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Aug 2019 02:42:45 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190821064241epoutp018f807e9154aca2a652e7f8f39356e491~83P_0zv-B1114111141epoutp01S
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Aug 2019 06:42:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190821064241epoutp018f807e9154aca2a652e7f8f39356e491~83P_0zv-B1114111141epoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1566369761;
        bh=nePUznyEzQN2tvbKGNQVLTfqjckap+uH4JSQl4+ch64=;
        h=From:To:Cc:Subject:Date:References:From;
        b=idcoeYfTBC26p7Bs0H2u7rIF85oHBnNl8TRRMx+p8x7RqhMLT7LG/pgu3kvIv3NCT
         RY9CtviB5HNhLxGly4+IWB6aKGFhdi5bHI7or/zna8Z03UIC4eLfy3jWy3crFDAzJ1
         iYU38G+AB3qhPe6Q5fe3BX1snc7JxgAU4iT1qx5A=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20190821064240epcas2p20900643c8de55a181c2996aac1b0833a~83P_NaVe12515525155epcas2p29;
        Wed, 21 Aug 2019 06:42:40 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.191]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 46CylL0jTBzMqYkV; Wed, 21 Aug
        2019 06:42:38 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.53.04068.DD7EC5D5; Wed, 21 Aug 2019 15:42:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20190821064237epcas2p4d8bc4858fda55be213eb51b19e52fc71~83P7Z1Gqi1664116641epcas2p4j;
        Wed, 21 Aug 2019 06:42:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190821064237epsmtrp270332e118998ecd0be549cd882da5d56~83P7Y218Z2242122421epsmtrp2g;
        Wed, 21 Aug 2019 06:42:37 +0000 (GMT)
X-AuditID: b6c32a47-5a1ff70000000fe4-b9-5d5ce7dd8159
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.E2.03638.DD7EC5D5; Wed, 21 Aug 2019 15:42:37 +0900 (KST)
Received: from KORDO035251 (unknown [12.36.165.204]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190821064236epsmtip19eaf3f73889496a58e92a8bc022c5984~83P61ZcSp0421904219epsmtip1l;
        Wed, 21 Aug 2019 06:42:36 +0000 (GMT)
From:   "boojin.kim" <boojin.kim@samsung.com>
To:     "'Theodore Y. Ts'o'" <tytso@mit.edu>,
        "'Jaegeuk Kim'" <jaegeuk@kernel.org>,
        "'Eric Biggers'" <ebiggers@kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
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
Subject: [PATCH 7/9] fscrypt: support diskcipher
Date:   Wed, 21 Aug 2019 15:42:36 +0900
Message-ID: <004301d557eb$9ef2c8e0$dcd85aa0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdVX6NYYas7Ah3LbRl6gWv/zKu666g==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOLsWRmVeSWpSXmKPExsWy7bCmme695zGxBmcSLb5+6WCxWH/qGLPF
        6rv9bBanp55lsphzvoXFYu+72awWa/f8YbbofiVj8WT9LGaLG7/aWC36H79mtjh/fgO7xabH
        11gt9t7Strh/7yeTxcx5d9gsLi1yt3g17xuLxZ69J1ksLu+aw2Zx5H8/o8WM8/uYLNo2fmW0
        aO35yW5xfG24g6THlpU3mTxaNpd7bDug6nH5bKnHplWdbB53ru1h89i8pN5j94LPTB5NZ44y
        e7zfd5XNo2/LKkaPz5vkAniicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTy
        EnNTbZVcfAJ03TJzgF5XUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BQYGhboFSfm
        Fpfmpesl5+daGRoYGJkCVSbkZMw7/5O5YGZkxcz7CxgbGKd7djFyckgImEgsO/aBvYuRi0NI
        YAejxJ6mJiYI5xOjxOzvF6Ccb4wSnz7vYodpOXPhChtEYi+jxKXpa6Ccl4wS618vZgOpYhPQ
        lth8fBUjSEJE4B6jxK4lM8GqmAX+sUs8+XSIBaRKWMBA4sClHjCbRUBVYv6cyUBFHBy8ApYS
        P86Wg4R5BQQlTs58AlbCLCAvsf3tHGaIMxQkdpx9zQhSLiKgJ/GiSwaiRERidmcbVEkrh8SR
        7hoI20Xix98eNghbWOLV8S1Q30hJfH63FypeL3F12WJwYEgI9DBKnPnVBlVkLDHrWTvYLmYB
        TYn1u/RBTAkBZYkjt6Au45PoOPyXHSLMK9HRJgTRqCIx99NlJoiwlMSHnjoI00PidhPTBEbF
        WUg+nIXkw1lIXpmFsHUBI8sqRrHUguLc9NRiowJj5KjexAjOFFruOxi3nfM5xCjAwajEw5tw
        PTpWiDWxrLgy9xCjBAezkghvxZyoWCHelMTKqtSi/Pii0pzU4kOMpsDwn8gsJZqcD8xieSXx
        hqZGZmYGlqYWpmZGFkrivJu4b8YICaQnlqRmp6YWpBbB9DFxcEo1MO5nitrMvedP2a3tiZmb
        7RfeVw3iE5t5rCvkj4F/0c9P6n93Jsnl/WWZ12sv9lPuy5UfZoJRtUlRl2PzMrXz1yQz+4mI
        PNBc5Ni+XWpTOfMZJn5bX06vnwd6pyz4GKnwx8rjqbYMw4VrkR9O5pwxvH/zpsEfEefbngbX
        DxYKVW+5VSRrJvIvTImlOCPRUIu5qDgRALv6JuYqBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7bCSnO7d5zGxBjv2yFh8/dLBYrH+1DFm
        i9V3+9ksTk89y2Qx53wLi8Xed7NZLdbu+cNs0f1KxuLJ+lnMFjd+tbFa9D9+zWxx/vwGdotN
        j6+xWuy9pW1x/95PJouZ8+6wWVxa5G7xat43Fos9e0+yWFzeNYfN4sj/fkaLGef3MVm0bfzK
        aNHa85Pd4vjacAdJjy0rbzJ5tGwu99h2QNXj8tlSj02rOtk87lzbw+axeUm9x+4Fn5k8ms4c
        ZfZ4v+8qm0ffllWMHp83yQXwRHHZpKTmZJalFunbJXBlzDv/k7lgZmTFzPsLGBsYp3t2MXJy
        SAiYSJy5cIWti5GLQ0hgN6PEuWMHWCESUhJb2/cwQ9jCEvdbjrBCFD1nlFjQ8IcdJMEmoC2x
        +fgqRpCEiMAjRon/LxeAJZgFpnFI7PogDmILCxhIHLjUwwJiswioSsyfMxloHQcHr4ClxI+z
        5SBhXgFBiZMzn7CAhJkF9CTaNjJCTJGX2P52DtQNChI7zr5mBCkRASp50SUDUSIiMbuzjXkC
        o+AsJINmIQyahWTQLCQdCxhZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBKcALa0d
        jCdOxB9iFOBgVOLh3XEzOlaINbGsuDL3EKMEB7OSCG/FnKhYId6UxMqq1KL8+KLSnNTiQ4zS
        HCxK4rzy+ccihQTSE0tSs1NTC1KLYLJMHJxSDYzSXX/3Xt60OXLd8k2d33IeCFlefJUwnamu
        pS5k77/dBWGz9bZmCnAsjt978jWvSbFwYnmzZpL05kvH8hp+qN3+pdHFv/R4n5viBR5j0RuT
        NsyrqzKR3sxdtXLr5E3v9204xJLvdmDaCxeLzrci35/wnL1y5S6vn+mJpR4+3538uTa6H2RI
        O3dGiaU4I9FQi7moOBEAcCg2h/0CAAA=
X-CMS-MailID: 20190821064237epcas2p4d8bc4858fda55be213eb51b19e52fc71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190821064237epcas2p4d8bc4858fda55be213eb51b19e52fc71
References: <CGME20190821064237epcas2p4d8bc4858fda55be213eb51b19e52fc71@epcas2p4.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch support fscrypt to use diskcipher in a specific crypto mode
(FSCRYPT_MODE_PRIVATE).
Fscrypt allocates diskcipher and sets the key on diskcipher.
Fscrypt doesn't handle additional data encryption when using diskcipher.

Cc: Theodore Y. Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Boojin Kim <boojin.kim@samsung.com>
---
 fs/buffer.c                   |  2 ++
 fs/crypto/bio.c               | 43 ++++++++++++++++++++++++++-----
 fs/crypto/fscrypt_private.h   | 28 +++++++++++++++++++-
 fs/crypto/keysetup.c          | 60
+++++++++++++++++++++++++++++++++++++++++--
 fs/crypto/keysetup_v1.c       |  2 +-
 include/linux/fscrypt.h       | 19 ++++++++++++++
 include/uapi/linux/fscrypt.h  |  2 ++
 tools/include/uapi/linux/fs.h |  1 +
 8 files changed, 147 insertions(+), 10 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 131d39e..a7de079 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3129,6 +3129,8 @@ static int submit_bh_wbc(int op, int op_flags, struct
buffer_head *bh,
 		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
 	}
 
+	if (bio->bi_opf & REQ_CRYPT)
+		bio->bi_aux_private = bh->b_private;
 	submit_bio(bio);
 	return 0;
 }
diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
index 82da251..9e4bf9b 100644
--- a/fs/crypto/bio.c
+++ b/fs/crypto/bio.c
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/bio.h>
 #include <linux/namei.h>
+#include <crypto/diskcipher.h>
 #include "fscrypt_private.h"
 
 static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
@@ -81,13 +82,19 @@ int fscrypt_zeroout_range(const struct inode *inode,
pgoff_t lblk,
 	if (!ciphertext_page)
 		return -ENOMEM;
 
-	while (len--) {
-		err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
-					  ZERO_PAGE(0), ciphertext_page,
-					  blocksize, 0, GFP_NOFS);
-		if (err)
-			goto errout;
+	if (__fscrypt_disk_encrypted(inode)) {
+		memset(page_address(ciphertext_page), 0, PAGE_SIZE);
+		ciphertext_page->mapping = inode->i_mapping;
+	}
 
+	while (len--) {
+		if (!__fscrypt_disk_encrypted(inode))  {
+			err = fscrypt_crypt_block(inode, FS_ENCRYPT, lblk,
+						  ZERO_PAGE(0),
ciphertext_page,
+						  blocksize, 0, GFP_NOFS);
+			if (err)
+				goto errout;
+		}
 		bio = bio_alloc(GFP_NOWAIT, 1);
 		if (!bio) {
 			err = -ENOMEM;
@@ -103,6 +110,7 @@ int fscrypt_zeroout_range(const struct inode *inode,
pgoff_t lblk,
 			err = -EIO;
 			goto errout;
 		}
+		fscrypt_set_bio(inode, bio, 0);
 		err = submit_bio_wait(bio);
 		if (err == 0 && bio->bi_status)
 			err = -EIO;
@@ -118,3 +126,26 @@ int fscrypt_zeroout_range(const struct inode *inode,
pgoff_t lblk,
 	return err;
 }
 EXPORT_SYMBOL(fscrypt_zeroout_range);
+
+int fscrypt_disk_encrypted(const struct inode *inode)
+{
+	return __fscrypt_disk_encrypted(inode);
+}
+
+void fscrypt_set_bio(const struct inode *inode, struct bio *bio, u64 dun)
+{
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	if (__fscrypt_disk_encrypted(inode))
+		crypto_diskcipher_set(bio, inode->i_crypt_info->ci_dtfm,
+					inode, dun);
+#endif
+}
+
+void *fscrypt_get_diskcipher(const struct inode *inode)
+{
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	if (fscrypt_has_encryption_key(inode))
+		return inode->i_crypt_info->ci_dtfm;
+#endif
+	return NULL;
+}
diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
index e84efc0..d2b5fb6 100644
--- a/fs/crypto/fscrypt_private.h
+++ b/fs/crypto/fscrypt_private.h
@@ -163,6 +163,10 @@ struct fscrypt_info {
 	/* The actual crypto transform used for encryption and decryption */
 	struct crypto_skcipher *ci_ctfm;
 
+	/* Cipher for inline encryption engine */
+#ifdef CONFIG_CRYPTO_DISKCIPHER
+	struct crypto_diskcipher *ci_dtfm;
+#endif
 	/*
 	 * Cipher for ESSIV IV generation.  Only set for CBC contents
 	 * encryption, otherwise is NULL.
@@ -226,6 +230,10 @@ static inline bool fscrypt_valid_enc_modes(u32
contents_mode,
 	    filenames_mode == FSCRYPT_MODE_ADIANTUM)
 		return true;
 
+	if (contents_mode == FSCRYPT_MODE_PRIVATE &&
+		filenames_mode == FSCRYPT_MODE_AES_256_CTS)
+		return true;
+
 	return false;
 }
 
@@ -438,13 +446,19 @@ extern int __init fscrypt_init_keyring(void);
 
 /* keysetup.c */
 
+enum cipher_flags {
+	CRYPT_MODE_SKCIPHER,
+	CRYPT_MODE_ESSIV,
+	CRYPT_MODE_DISKCIPHER,
+};
+
 struct fscrypt_mode {
 	const char *friendly_name;
 	const char *cipher_str;
 	int keysize;
 	int ivsize;
 	bool logged_impl_name;
-	bool needs_essiv;
+	enum cipher_flags flags;
 };
 
 static inline bool
@@ -453,6 +467,18 @@ fscrypt_mode_supports_direct_key(const struct
fscrypt_mode *mode)
 	return mode->ivsize >= offsetofend(union fscrypt_iv, nonce);
 }
 
+static inline int __fscrypt_disk_encrypted(const struct inode *inode)
+{
+#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
+#if IS_ENABLED(CONFIG_CRYPTO_DISKCIPHER)
+	if (inode && inode->i_crypt_info)
+		return S_ISREG(inode->i_mode) &&
+			(inode->i_crypt_info->ci_dtfm != NULL);
+#endif
+#endif
+	return 0;
+}
+
 extern struct crypto_skcipher *
 fscrypt_allocate_skcipher(struct fscrypt_mode *mode, const u8 *raw_key,
 			  const struct inode *inode);
diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
index d71c2d6..06d9609 100644
--- a/fs/crypto/keysetup.c
+++ b/fs/crypto/keysetup.c
@@ -11,6 +11,7 @@
 #include <crypto/aes.h>
 #include <crypto/sha.h>
 #include <crypto/skcipher.h>
+#include <crypto/diskcipher.h>
 #include <linux/key.h>
 
 #include "fscrypt_private.h"
@@ -35,7 +36,7 @@ static struct fscrypt_mode available_modes[] = {
 		.cipher_str = "cbc(aes)",
 		.keysize = 16,
 		.ivsize = 16,
-		.needs_essiv = true,
+		.flags = CRYPT_MODE_ESSIV,
 	},
 	[FSCRYPT_MODE_AES_128_CTS] = {
 		.friendly_name = "AES-128-CTS-CBC",
@@ -49,6 +50,13 @@ static struct fscrypt_mode available_modes[] = {
 		.keysize = 32,
 		.ivsize = 32,
 	},
+	[FSCRYPT_MODE_PRIVATE] = {
+		.friendly_name = "AES-256-XTS-DISK",
+		.cipher_str = "xts(aes)-disk",
+		.keysize = 64,
+		.ivsize = 16,
+		.flags = CRYPT_MODE_DISKCIPHER,
+	},
 };
 
 static struct fscrypt_mode *
@@ -111,6 +119,35 @@ struct crypto_skcipher
*fscrypt_allocate_skcipher(struct fscrypt_mode *mode,
 	return ERR_PTR(err);
 }
 
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+/* Create a diskcipher cipher object for the given encryption mode and key
*/
+static struct crypto_diskcipher *fscrypt_allocate_diskcipher(
+		struct fscrypt_mode *mode, const u8 *raw_key,
+			   const struct inode *inode)
+{
+	struct crypto_diskcipher *tfm;
+	int err;
+	bool force = (mode->flags == CRYPT_MODE_DISKCIPHER) ? 0 : 1;
+
+	tfm = crypto_alloc_diskcipher(mode->cipher_str, 0, 0, force);
+	if (IS_ERR(tfm)) {
+		fscrypt_warn(inode->i_sb,
+				 "error allocating '%s' transform for inode
%lu: %ld",
+				 mode->cipher_str, inode->i_ino,
PTR_ERR(tfm));
+		return tfm;
+	}
+	err = crypto_diskcipher_setkey(tfm, raw_key, mode->keysize, 0);
+	if (err)
+		goto err_free_dtfm;
+
+	return tfm;
+
+err_free_dtfm:
+	crypto_free_diskcipher(tfm);
+	return ERR_PTR(err);
+}
+#endif
+
 static int derive_essiv_salt(const u8 *key, int keysize, u8 *salt)
 {
 	struct crypto_shash *tfm = READ_ONCE(essiv_hash_tfm);
@@ -187,13 +224,29 @@ int fscrypt_set_derived_key(struct fscrypt_info *ci,
const u8 *derived_key)
 	struct crypto_skcipher *ctfm;
 	int err;
 
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+	if (S_ISREG(ci->ci_inode->i_mode) &&
+		(mode->flags == CRYPT_MODE_DISKCIPHER)) {
+		ci->ci_dtfm = fscrypt_allocate_diskcipher(mode, derived_key,
+
ci->ci_inode);
+		if (IS_ERR(ci->ci_dtfm)) {
+			fscrypt_warn(ci->ci_inode,
+				     "Error allocating Diskcipher: %p",
+				     PTR_ERR(ci->ci_dtfm));
+			ci->ci_dtfm = NULL;
+			return -EINVAL;
+		}
+		return 0;
+	}
+#endif
+
 	ctfm = fscrypt_allocate_skcipher(mode, derived_key, ci->ci_inode);
 	if (IS_ERR(ctfm))
 		return PTR_ERR(ctfm);
 
 	ci->ci_ctfm = ctfm;
 
-	if (mode->needs_essiv) {
+	if (mode->flags == CRYPT_MODE_ESSIV) {
 		err = init_essiv_generator(ci, derived_key, mode->keysize);
 		if (err) {
 			fscrypt_warn(ci->ci_inode,
@@ -394,6 +447,9 @@ static void put_crypt_info(struct fscrypt_info *ci)
 		   !fscrypt_is_direct_key_policy(&ci->ci_policy)) {
 		crypto_free_skcipher(ci->ci_ctfm);
 		crypto_free_cipher(ci->ci_essiv_tfm);
+#if defined(CONFIG_CRYPTO_DISKCIPHER)
+		crypto_free_diskcipher(ci->ci_dtfm);
+#endif
 	}
 
 	key = ci->ci_master_key;
diff --git a/fs/crypto/keysetup_v1.c b/fs/crypto/keysetup_v1.c
index 0727251..22d0330 100644
--- a/fs/crypto/keysetup_v1.c
+++ b/fs/crypto/keysetup_v1.c
@@ -271,7 +271,7 @@ static int setup_v1_file_key_direct(struct fscrypt_info
*ci,
 	}
 
 	/* ESSIV implies 16-byte IVs which implies !DIRECT_KEY */
-	if (WARN_ON(mode->needs_essiv))
+	if (WARN_ON(mode->flags == CRYPT_MODE_ESSIV))
 		return -EINVAL;
 
 	dk = fscrypt_get_direct_key(ci, raw_master_key);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index f622f74..e0f99db 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -274,6 +274,11 @@ static inline void fscrypt_set_ops(struct super_block
*sb,
 {
 	sb->s_cop = s_cop;
 }
+
+void fscrypt_set_bio(const struct inode *inode, struct bio *bio, u64 dun);
+void *fscrypt_get_diskcipher(const struct inode *inode);
+int fscrypt_disk_encrypted(const struct inode *inode);
+
 #else  /* !CONFIG_FS_ENCRYPTION */
 
 static inline bool fscrypt_has_encryption_key(const struct inode *inode)
@@ -556,6 +561,20 @@ static inline void fscrypt_set_ops(struct super_block
*sb,
 {
 }
 
+static inline int fscrypt_disk_encrypted(const struct inode *inode)
+{
+	return 0;
+}
+
+static inline void fscrypt_set_bio(const struct inode *inode,
+					struct bio *bio, u64 dun)
+{
+}
+
+static inline void *fscrypt_get_diskcipher(const struct inode *inode)
+{
+	return NULL;
+}
 #endif	/* !CONFIG_FS_ENCRYPTION */
 
 /**
diff --git a/include/uapi/linux/fscrypt.h b/include/uapi/linux/fscrypt.h
index 39ccfe9..b9978c4 100644
--- a/include/uapi/linux/fscrypt.h
+++ b/include/uapi/linux/fscrypt.h
@@ -25,6 +25,7 @@
 #define FSCRYPT_MODE_AES_128_CBC		5
 #define FSCRYPT_MODE_AES_128_CTS		6
 #define FSCRYPT_MODE_ADIANTUM			9
+#define FSCRYPT_MODE_PRIVATE			127
 #define __FSCRYPT_MODE_MAX			9
 
 /*
@@ -173,6 +174,7 @@ struct fscrypt_get_key_status_arg {
 #define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
 #define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
 #define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
+#define FS_ENCRYPTION_MODE_PRIVATE	FSCRYPT_MODE_PRIVATE
 #define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
 #define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
 #define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 2a616aa..dd3566a 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -237,6 +237,7 @@ struct fsxattr {
 #define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
 #define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
 #define FS_ENCRYPTION_MODE_ADIANTUM		9
+#define FS_ENCRYPTION_MODE_PRIVATE		127
 
 struct fscrypt_policy {
 	__u8 version;
-- 
2.7.4

