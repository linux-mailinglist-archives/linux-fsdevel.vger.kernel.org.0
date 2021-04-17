Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1419362CE6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Apr 2021 04:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhDQCd5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 22:33:57 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:17957 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbhDQCdz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 22:33:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618626810; x=1650162810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=najxIh+FXOHZ7dZhad+BaMtkrWLrGz6Zvppn8AQJSQc=;
  b=rYvMR5AQ2it0KKJoe5OxrMDUZpg94CQUAIEGALNYcjeWoIVmrQb+E5eH
   Xv/R9f6CQmacNzy0JDLhQnAdeahOVgFs4Xsxds7JXkc8TxtDULCDUF6b9
   umuUH/aMf1W/jZb6p1Ctjid8mNYeBFM1m1JMyhIQr0dnkPSMDXgqp5rIo
   ajK+Qrh2YN3EJ6LqiDCYfZbXTyrLkDXscC1V5XffBv6QExGUs7M8NTB10
   qysNYfXeFFnKseanY1InisasK4ovAC8WcAhkq7/+TJdgv43wLxjQVBO4w
   5qe0aqooa6L7e1sceZORB6okXQuIuWPV4vabGc+KERCAhQfSJRMp8UY0Q
   g==;
IronPort-SDR: BSmFvG9aaKJUkrXpSO63RbdKZk0kL3uibY0thF77F56zcV8SMyaRIf3sYiA2smdWmqxNpT81oU
 knSXr1dBs11lk2gQiDJ5MM01y0sQXkyERB2YIOi+vZkxvU27k0D14g/TAL8xldT/r7KBh5GusL
 UTOT0BaMUk47hsBG3MPsbt0sA4911s04Xdcdx0dmQE/7sCNmJZdY/UDWEY4GdZTcizmARZ2twO
 VSNZz0KenJtKxRmcMVYFdyuS/K2oiffMfu37bluKeCpEFYpmJ0dyIkZLJuaadBeY/UcvJ7ZOD2
 Uvg=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; 
   d="scan'208";a="165193275"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:29 +0800
IronPort-SDR: VM05/6arzp0Phxd5wg2j4IEb4Ww2CGyHKfs59xgQVOh6aBMifWxwgcV8GExhCWS2uv7/UyTE4x
 7I0v0NQkPuxYJQhQa3SQHwlQWbGJ18HdXDtv31DgjTABZehtx6a3zHxzf2x2TvZ4SGh7zabpIA
 1JE4ZPbZjZv7rDYkul90+V5SJ/qJTTn4aR2rGIhlahRiKMqILU1ziwBU9/+v1n58i86EY7VaIm
 Uf32vVivnmO2xXRRClN4LLr2QYMKkaasGD9o+qr6txrpR7lnd7J25xo9Iv+ma2Y5lN26wdoDpT
 ioZF4dvAgsgP0SxhJ1X+YQvy
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2021 19:12:43 -0700
IronPort-SDR: xIOtvDVVUoEgifhjwweuy0fDdzV0M33C9Q/9LAS60QbO2JgzCZQNnvvYqoXOtCsotU6X1Tq9qR
 fRdbluZIbVpVm7Kdm6M6AbxvVhXX7+gHfj7VFjUlI7ggjslKXnRGbmZJfxt6CaVyEs8yLLb2ap
 xcl4sfWnLREwFWWruNSyclYXh1u8MnxTlEANLAvHw5TsltOSm4gZTenFH5kwSSxriR+VFF6G7y
 W2tjR8E/oS3cFvaD2JFJzrVxFbgRKyUn3dhoGIoRLiEMlr6hZwjTvpgEuHhNk35wxgqQnQFfPH
 QTg=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:29 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 2/3] dm crypt: Fix zoned block device support
Date:   Sat, 17 Apr 2021 11:33:22 +0900
Message-Id: <20210417023323.852530-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Zone append BIOs (REQ_OP_ZONE_APPEND) always specify the start sector of
the zone to be written instead of the actual location sector to write.
The write location is determined by the device and returned to the host
upon completion of the operation. This interface, while simple and
efficient for writing into sequential zones of a zoned block device, is
incompatible with the use of sector values to calculate a cypher block
IV. All data written in a zone end up using the same IV values
corresponding to the first sectors of the zone, but read operation will
specify any sector within the zone, resulting in an IV mismatch between
encryption and decryption.

Using a single sector value (e.g. the zone start sector) for all read
and writes into a zone can solve this problem, but at the cost of
weakening the cypher chosen by the user. Instead, to solve this
problem, explicitly disable support for zone append operations using
the zone_append_not_supported field of struct dm_target if the IV mode
used is sector-based, that is for all IVs modes except null and random.

The cypher flag CRYPT_IV_NO_SECTORS iis introduced to indicate that the
cypher does not use sector values. This flag is set in
crypt_ctr_ivmode() for the null and random IV modes and checked in
crypt_ctr() to set to true zone_append_not_supported if
CRYPT_IV_NO_SECTORS is not set for the chosen cypher.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Fixes: 8e225f04d2dd ("dm crypt: Enable zoned block device support")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 49 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..6ef35bb29ce5 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -137,6 +137,7 @@ enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cipher */
 	CRYPT_IV_LARGE_SECTORS,		/* Calculate IV from sector_size, not 512B sectors */
 	CRYPT_ENCRYPT_PREPROCESS,	/* Must preprocess data for encryption (elephant) */
+	CRYPT_IV_ZONE_APPEND,		/* IV mode supports zone append operations */
 };
 
 /*
@@ -2750,9 +2751,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 	}
 
 	/* Choose ivmode, see comments at iv code. */
-	if (ivmode == NULL)
+	if (ivmode == NULL) {
 		cc->iv_gen_ops = NULL;
-	else if (strcmp(ivmode, "plain") == 0)
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "plain") == 0)
 		cc->iv_gen_ops = &crypt_iv_plain_ops;
 	else if (strcmp(ivmode, "plain64") == 0)
 		cc->iv_gen_ops = &crypt_iv_plain64_ops;
@@ -2762,9 +2764,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->iv_gen_ops = &crypt_iv_essiv_ops;
 	else if (strcmp(ivmode, "benbi") == 0)
 		cc->iv_gen_ops = &crypt_iv_benbi_ops;
-	else if (strcmp(ivmode, "null") == 0)
+	else if (strcmp(ivmode, "null") == 0) {
 		cc->iv_gen_ops = &crypt_iv_null_ops;
-	else if (strcmp(ivmode, "eboiv") == 0)
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "eboiv") == 0)
 		cc->iv_gen_ops = &crypt_iv_eboiv_ops;
 	else if (strcmp(ivmode, "elephant") == 0) {
 		cc->iv_gen_ops = &crypt_iv_elephant_ops;
@@ -2791,6 +2794,7 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->key_extra_size = cc->iv_size + TCW_WHITENING_SIZE;
 	} else if (strcmp(ivmode, "random") == 0) {
 		cc->iv_gen_ops = &crypt_iv_random_ops;
+		set_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags);
 		/* Need storage space in integrity fields. */
 		cc->integrity_iv_size = cc->iv_size;
 	} else {
@@ -3281,14 +3285,32 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	}
 	cc->start = tmpll;
 
-	/*
-	 * For zoned block devices, we need to preserve the issuer write
-	 * ordering. To do so, disable write workqueues and force inline
-	 * encryption completion.
-	 */
 	if (bdev_is_zoned(cc->dev->bdev)) {
+		/*
+		 * For zoned block devices, we need to preserve the issuer write
+		 * ordering. To do so, disable write workqueues and force inline
+		 * encryption completion.
+		 */
 		set_bit(DM_CRYPT_NO_WRITE_WORKQUEUE, &cc->flags);
 		set_bit(DM_CRYPT_WRITE_INLINE, &cc->flags);
+
+		/*
+		 * All zone append writes to a zone of a zoned block device will
+		 * have the same BIO sector (the start of the zone). When the
+		 * cypher IV mode uses sector values, all data targeting a
+		 * zone will be encrypted using the first sector numbers of the
+		 * zone. This will not result in write errors but will
+		 * cause most reads to fail as reads will use the sector values
+		 * for the actual data locations, resulting in IV mismatch.
+		 * To avoid this problem, allow zone append operations only when
+		 * the selected IV mode indicated that zone append operations
+		 * are supported, that is, IV modes that do not use sector
+		 * values (null and random IVs).
+		 */
+		if (!test_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags)) {
+			DMWARN("Zone append is not supported with the selected IV mode");
+			ti->zone_append_not_supported = true;
+		}
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
@@ -3356,6 +3378,15 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	struct dm_crypt_io *io;
 	struct crypt_config *cc = ti->private;
 
+	/*
+	 * For zoned targets, we should not see any zone append operation if
+	 * the cypher IV mode selected does not support them. In the unlikely
+	 * case we do see one such operation, warn and fail the request.
+	 */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND &&
+			 !test_bit(CRYPT_IV_ZONE_APPEND, &cc->cipher_flags)))
+		return DM_MAPIO_KILL;
+
 	/*
 	 * If bio is REQ_PREFLUSH or REQ_OP_DISCARD, just bypass crypt queues.
 	 * - for REQ_PREFLUSH device-mapper core ensures that no IO is in-flight
-- 
2.30.2

