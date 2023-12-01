Return-Path: <linux-fsdevel+bounces-4625-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D770801680
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 23:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E325B1F20FE5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641223F8CC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Dec 2023 22:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="IVV0/RQU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E507B10EF
	for <linux-fsdevel@vger.kernel.org>; Fri,  1 Dec 2023 14:12:03 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-5d7201c9d51so861807b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 Dec 2023 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1701468723; x=1702073523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/160CoL5kD8MZgjTeYrjsK44d+IUTjQMGeYoRwthpu4=;
        b=IVV0/RQUpq6PfW2vzpKtnTuTqS48i4XIvC1SS53Yfm3A8oIPgb6qnkY0t8Vrnkl3Km
         GxwE9OOHAvIXffjjKfiYDqVHVQm4ixgesmQFKtjEeMHXJSmfNMjTdddltU65UOA0i8AB
         OPvP29cAm7cWTpHtCDyPBhb5MjqlAizE61dQ0wE5SrpxGOw0oT+JGT00dloMntcBUZdc
         Lo6jY5Q/taFeCk4ElaIPeQiS5neuS+7u+bxejTIrkSurNqb+qNEoARfnGdJULLLI011b
         kkUwYbaiWYJ3txdJhHWK6/sUK6PrClhjgypi3x6OHEQXAtZatEDaEm8g0j7fq0Q8poCh
         PrAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701468723; x=1702073523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/160CoL5kD8MZgjTeYrjsK44d+IUTjQMGeYoRwthpu4=;
        b=vbGhOvAhr1P6mzbKdJtDGNe36ce0WrBz2pyVuSjEyoBPOehXI3ymnfgp/uM4m7Yfub
         n5wWxGZLgCEzWJcPqcgFNQW5obtsCxXBOU0Pzs+s+KVPWMqMyNI73jcQRGfv7RitcZjR
         DyDWxPdpMNOEDL0cBtTXJqQAP7WaaqK0w/M1AN7Th8PW4vqp451tzC7g1mZnHujTUXHV
         5XhbA+y61r+Y2qaFSfMZyF5DQ54zNNxEzUGsBMOMIokat5ubWGE3nPG5fKCGwC9VlnzR
         uCPltPkDdnJ8sDrL7+ORLDIioJnHpEnOIgN9+VI0qt7Y4Elce+bEfmv380cQ+M5Y5d1o
         e5Ug==
X-Gm-Message-State: AOJu0YwPm0jN2gDxmgzvlocdRLazyAPKqFCeadQHx5HDheykXzL5PmEt
	ChE6Q2Msbo1579ZVBiHgpn3UKg==
X-Google-Smtp-Source: AGHT+IHUIHxJntBti8gl1XBwAdsUkLD3yqGZmVWvvs3bS5g0mp5rWZ1bRaXHVtJ80mRQ23tlAhtV0g==
X-Received: by 2002:a81:ad52:0:b0:5d7:1940:8de2 with SMTP id l18-20020a81ad52000000b005d719408de2mr165456ywk.73.1701468723074;
        Fri, 01 Dec 2023 14:12:03 -0800 (PST)
Received: from localhost (076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id o125-20020a817383000000b005d39a1ae8b3sm1157083ywc.1.2023.12.01.14.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 14:12:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v4 05/46] blk-crypto: add a process bio callback
Date: Fri,  1 Dec 2023 17:11:02 -0500
Message-ID: <eeeea8d462fe739cff8883feeccacd154a10b40b.1701468306.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1701468305.git.josef@toxicpanda.com>
References: <cover.1701468305.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Btrfs does checksumming, and the checksums need to match the bytes on
disk.  In order to facilitate this add a process bio callback for the
blk-crypto layer.  This allows the file system to specify a callback and
then can process the encrypted bio as necessary.

For btrfs, writes will have the checksums calculated and saved into our
relevant data structures for storage once the write completes.  For
reads we will validate the checksums match what is on disk and error out
if there is a mismatch.

This is incompatible with native encryption obviously, so make sure we
don't use native encryption if this callback is set.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-crypto-fallback.c | 40 +++++++++++++++++++++++++++++++++++++
 block/blk-crypto-internal.h |  8 ++++++++
 block/blk-crypto-profile.c  |  2 ++
 block/blk-crypto.c          |  6 +++++-
 fs/crypto/inline_crypt.c    |  3 ++-
 include/linux/blk-crypto.h  |  9 +++++++--
 include/linux/fscrypt.h     | 14 +++++++++++++
 7 files changed, 78 insertions(+), 4 deletions(-)

diff --git a/block/blk-crypto-fallback.c b/block/blk-crypto-fallback.c
index e6468eab2681..1254fed9ffeb 100644
--- a/block/blk-crypto-fallback.c
+++ b/block/blk-crypto-fallback.c
@@ -346,6 +346,15 @@ static bool blk_crypto_fallback_encrypt_bio(struct bio **bio_ptr)
 		}
 	}
 
+	/* Process the encrypted bio before we submit it. */
+	if (bc->bc_key->crypto_cfg.process_bio) {
+		blk_st = bc->bc_key->crypto_cfg.process_bio(src_bio, enc_bio);
+		if (blk_st != BLK_STS_OK) {
+			src_bio->bi_status = blk_st;
+			goto out_free_bounce_pages;
+		}
+	}
+
 	enc_bio->bi_private = src_bio;
 	enc_bio->bi_end_io = blk_crypto_fallback_encrypt_endio;
 	*bio_ptr = enc_bio;
@@ -391,6 +400,24 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	unsigned int i;
 	blk_status_t blk_st;
 
+	/*
+	 * Process the bio first before trying to decrypt.
+	 *
+	 * NOTE: btrfs expects that this bio is the same that was submitted.  If
+	 * at any point this changes we will need to update process_bio to take
+	 * f_ctx->crypt_iter in order to make sure we can iterate the pages for
+	 * checksumming.  We're currently saving this in our btrfs_bio, so this
+	 * works, but if at any point in the future we start allocating a bounce
+	 * bio or something we need to update this callback.
+	 */
+	if (bc->bc_key->crypto_cfg.process_bio) {
+		blk_st = bc->bc_key->crypto_cfg.process_bio(bio, bio);
+		if (blk_st != BLK_STS_OK) {
+			bio->bi_status = blk_st;
+			goto out_no_keyslot;
+		}
+	}
+
 	/*
 	 * Get a blk-crypto-fallback keyslot that contains a crypto_skcipher for
 	 * this bio's algorithm and key.
@@ -440,6 +467,19 @@ static void blk_crypto_fallback_decrypt_bio(struct work_struct *work)
 	bio_endio(bio);
 }
 
+/**
+ * blk_crypto_cfg_supports_process_bio - check if this config supports
+ *					 process_bio
+ * @profile: the profile we're checking
+ *
+ * This is just a quick check to make sure @profile is the fallback profile, as
+ * no other offload implementations support process_bio.
+ */
+bool blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile)
+{
+	return profile == blk_crypto_fallback_profile;
+}
+
 /**
  * blk_crypto_fallback_decrypt_endio - queue bio for fallback decryption
  *
diff --git a/block/blk-crypto-internal.h b/block/blk-crypto-internal.h
index 93a141979694..6664a04cb6ad 100644
--- a/block/blk-crypto-internal.h
+++ b/block/blk-crypto-internal.h
@@ -213,6 +213,8 @@ bool blk_crypto_fallback_bio_prep(struct bio **bio_ptr);
 
 int blk_crypto_fallback_evict_key(const struct blk_crypto_key *key);
 
+bool blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile);
+
 #else /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 static inline int
@@ -235,6 +237,12 @@ blk_crypto_fallback_evict_key(const struct blk_crypto_key *key)
 	return 0;
 }
 
+static inline bool
+blk_crypto_cfg_supports_process_bio(struct blk_crypto_profile *profile)
+{
+	return false;
+}
+
 #endif /* CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK */
 
 #endif /* __LINUX_BLK_CRYPTO_INTERNAL_H */
diff --git a/block/blk-crypto-profile.c b/block/blk-crypto-profile.c
index 7fabc883e39f..5d26d49d9372 100644
--- a/block/blk-crypto-profile.c
+++ b/block/blk-crypto-profile.c
@@ -352,6 +352,8 @@ bool __blk_crypto_cfg_supported(struct blk_crypto_profile *profile,
 		return false;
 	if (profile->max_dun_bytes_supported < cfg->dun_bytes)
 		return false;
+	if (cfg->process_bio && !blk_crypto_cfg_supports_process_bio(profile))
+		return false;
 	return true;
 }
 
diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4d760b092deb..50556952df19 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -321,6 +321,8 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
  * @dun_bytes: number of bytes that will be used to specify the DUN when this
  *	       key is used
  * @data_unit_size: the data unit size to use for en/decryption
+ * @process_bio: the call back if the upper layer needs to process the encrypted
+ *		 bio
  *
  * Return: 0 on success, -errno on failure.  The caller is responsible for
  *	   zeroizing both blk_key and raw_key when done with them.
@@ -328,7 +330,8 @@ int __blk_crypto_rq_bio_prep(struct request *rq, struct bio *bio,
 int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size)
+			unsigned int data_unit_size,
+			blk_crypto_process_bio_t process_bio)
 {
 	const struct blk_crypto_mode *mode;
 
@@ -350,6 +353,7 @@ int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 	blk_key->crypto_cfg.crypto_mode = crypto_mode;
 	blk_key->crypto_cfg.dun_bytes = dun_bytes;
 	blk_key->crypto_cfg.data_unit_size = data_unit_size;
+	blk_key->crypto_cfg.process_bio = process_bio;
 	blk_key->data_unit_size_bits = ilog2(data_unit_size);
 	blk_key->size = mode->keysize;
 	memcpy(blk_key->raw, raw_key, mode->keysize);
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 4eeb75410ba8..57776c548a06 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -168,7 +168,8 @@ int fscrypt_prepare_inline_crypt_key(struct fscrypt_prepared_key *prep_key,
 
 	err = blk_crypto_init_key(blk_key, raw_key, crypto_mode,
 				  fscrypt_get_dun_bytes(ci),
-				  1U << ci->ci_data_unit_bits);
+				  1U << ci->ci_data_unit_bits,
+				  sb->s_cop->process_bio);
 	if (err) {
 		fscrypt_err(inode, "error %d initializing blk-crypto key", err);
 		goto fail;
diff --git a/include/linux/blk-crypto.h b/include/linux/blk-crypto.h
index 5e5822c18ee4..194c1d727013 100644
--- a/include/linux/blk-crypto.h
+++ b/include/linux/blk-crypto.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_BLK_CRYPTO_H
 #define __LINUX_BLK_CRYPTO_H
 
-#include <linux/types.h>
+#include <linux/blk_types.h>
 
 enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_INVALID,
@@ -17,6 +17,9 @@ enum blk_crypto_mode_num {
 	BLK_ENCRYPTION_MODE_MAX,
 };
 
+typedef blk_status_t (blk_crypto_process_bio_t)(struct bio *orig_bio,
+						struct bio *enc_bio);
+
 #define BLK_CRYPTO_MAX_KEY_SIZE		64
 /**
  * struct blk_crypto_config - an inline encryption key's crypto configuration
@@ -31,6 +34,7 @@ struct blk_crypto_config {
 	enum blk_crypto_mode_num crypto_mode;
 	unsigned int data_unit_size;
 	unsigned int dun_bytes;
+	blk_crypto_process_bio_t *process_bio;
 };
 
 /**
@@ -90,7 +94,8 @@ bool bio_crypt_dun_is_contiguous(const struct bio_crypt_ctx *bc,
 int blk_crypto_init_key(struct blk_crypto_key *blk_key, const u8 *raw_key,
 			enum blk_crypto_mode_num crypto_mode,
 			unsigned int dun_bytes,
-			unsigned int data_unit_size);
+			unsigned int data_unit_size,
+			blk_crypto_process_bio_t process_bio);
 
 int blk_crypto_start_using_key(struct block_device *bdev,
 			       const struct blk_crypto_key *key);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 756f23fc3e83..5f5efb472fc9 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -16,6 +16,7 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/blk-crypto.h>
 #include <uapi/linux/fscrypt.h>
 
 /*
@@ -199,6 +200,19 @@ struct fscrypt_operations {
 	 */
 	struct block_device **(*get_devices)(struct super_block *sb,
 					     unsigned int *num_devs);
+
+	/*
+	 * A callback if the file system requires the ability to process the
+	 * encrypted bio.
+	 *
+	 * @orig_bio: the original bio submitted.
+	 * @enc_bio: the encrypted bio.
+	 *
+	 * For writes the enc_bio will be different from the orig_bio, for reads
+	 * they will be the same.  For reads we get the bio before it is
+	 * decrypted, for writes we get the bio before it is submitted.
+	 */
+	blk_crypto_process_bio_t *process_bio;
 };
 
 static inline struct fscrypt_inode_info *
-- 
2.41.0


