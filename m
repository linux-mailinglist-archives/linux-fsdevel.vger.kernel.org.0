Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D240E361803
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 05:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237775AbhDPDGF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Apr 2021 23:06:05 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63371 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbhDPDGA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Apr 2021 23:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618542335; x=1650078335;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7xpGw5gOit7hgiXUka877UmTYdM1ZmxbqzhNHdLZabs=;
  b=Tx05KlTGk2/vWIo0d6ssD1I+M6OpOTjM3NCsr0GcEWInENSR/o+hfsXE
   aBTHSXqN3jMrqFsPBT3ozBSl9zcgpGDBPMMSiE/uC07DAoESvUKimEPp/
   mpCplCS+YecAa85W9JxzLbX/U+RrkDDS7jr1QaONZbipro3q7uTixiE+z
   1Cj+gN2EXAh50l9i4nWH168uzKAorP1C7VD5fsFsz484PhkWB/8PWyj3t
   4HBoNS71KjeEvxIB1CjjNUZg6Bp86sIBcW3XWH19vTjtr/+ttzIIud1IU
   g4VMdZhq+2MK2HLys+L5DXTBxFGVi8XA5oeDCkwW8UzQmZ9BJ1sg+Xyjv
   A==;
IronPort-SDR: rtOdSX0tb3/sbl2mwTe9ibEUqbZbeR3GqelApw5evYWj10jqMaRvLG0DZ0CYfm7oAui7f6fE74
 pxsWC/VwQ7BrkN6O5DUYHEAexCOebR9sIARKK5CykSysCBqoPYrm3ki2Zubkz9iBM3awUTg/3+
 PM2wX1SKXrPe4x2ohJQXr9Yk2n/bcjE1pAHbPggFpzqiFgqRFPTsFnFi2+wt+CRSgba+rpkiO6
 r8nFJzRmfskzrn6TEmkUgb3q7DL7I3Fsolib5ibl2kPUrSNAgw5QzbxLBsC9T5We2ATOjfn+rK
 EM0=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; 
   d="scan'208";a="169567883"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:35 +0800
IronPort-SDR: NTf6YD+kTvlYGxs2Gb7w2WGaEojr+5+V8jgErNcIckQr9OuVGebNXY5+Fd+mQySKwnzMsJOMoA
 PQAM0ObdPMW3x+MG/UsngoyxBGBa8e6t1TMGVNxpiJNfOT3nZufjJRrG4gy3XGorvFiyXZaSSy
 C2kkaH66fIXh1DUujuaHEVMDJ1R+Q/Dg2R0w4FOZZjOpFYalgO9wB7hlwbxpES9Wn6Y4TieGkX
 0B5MPa/8jUR3KXS+/BDSr+Y+DgxG0Qe0gX29Dj/0GkHsgiMNVWHv4EBmqz4kWUDR0UTJIRqXEv
 U/7e1tnEACK5+tEwpcwtrdDQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:44:54 -0700
IronPort-SDR: reXaIl08fufcrKmwqlTrWikXVN+K7DeRaEHrim6atgn6l0Yzshs6cwZfuVPyG/kvBFwDZwOrfr
 KS+rIvyqVDxgc7Gk/123Bm8msgUO6s4kvzkQ+qbbMhLQMA2VUtrz2kPI7Uz0wH9p97zvdy+QzB
 dBNntEhDmRfVb+H6+MNJdlgbWRYLOtg4nGCU+7WubVXDhzMhGvHAgjkXjcQHedj6A+mGlgbgKU
 F2qkOL1fodLfhCMmK6ceLxyGqBvX+6LMi073Jjr5TrHhAQGPfhL+ssy2/DyhiIJ0c5n+L76/P5
 VD8=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:35 -0700
From:   Damien Le Moal <damien.lemoal@wdc.com>
To:     dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 2/4] dm crypt: Fix zoned block device support
Date:   Fri, 16 Apr 2021 12:05:26 +0900
Message-Id: <20210416030528.757513-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
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
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/md/dm-crypt.c | 48 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index b0ab080f2567..0a44bc0ff960 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -137,6 +137,7 @@ enum cipher_flags {
 	CRYPT_MODE_INTEGRITY_AEAD,	/* Use authenticated mode for cipher */
 	CRYPT_IV_LARGE_SECTORS,		/* Calculate IV from sector_size, not 512B sectors */
 	CRYPT_ENCRYPT_PREPROCESS,	/* Must preprocess data for encryption (elephant) */
+	CRYPT_IV_NO_SECTORS,		/* IV calculation does not use sectors */
 };
 
 /*
@@ -2750,9 +2751,10 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 	}
 
 	/* Choose ivmode, see comments at iv code. */
-	if (ivmode == NULL)
+	if (ivmode == NULL) {
 		cc->iv_gen_ops = NULL;
-	else if (strcmp(ivmode, "plain") == 0)
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
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
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
+	} else if (strcmp(ivmode, "eboiv") == 0)
 		cc->iv_gen_ops = &crypt_iv_eboiv_ops;
 	else if (strcmp(ivmode, "elephant") == 0) {
 		cc->iv_gen_ops = &crypt_iv_elephant_ops;
@@ -2791,6 +2794,7 @@ static int crypt_ctr_ivmode(struct dm_target *ti, const char *ivmode)
 		cc->key_extra_size = cc->iv_size + TCW_WHITENING_SIZE;
 	} else if (strcmp(ivmode, "random") == 0) {
 		cc->iv_gen_ops = &crypt_iv_random_ops;
+		set_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags);
 		/* Need storage space in integrity fields. */
 		cc->integrity_iv_size = cc->iv_size;
 	} else {
@@ -3281,14 +3285,31 @@ static int crypt_ctr(struct dm_target *ti, unsigned int argc, char **argv)
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
+		 * for the actual data location, resulting in IV mismatch.
+		 * To avoid this problem, allow zone append operations only for
+		 * cyphers with an IV mode not using sector values (null and
+		 * random IVs).
+		 */
+		if (!test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)) {
+			DMWARN("Zone append is not supported with sector-based IV cyphers");
+			ti->zone_append_not_supported = true;
+		}
 	}
 
 	if (crypt_integrity_aead(cc) || cc->integrity_iv_size) {
@@ -3356,6 +3377,15 @@ static int crypt_map(struct dm_target *ti, struct bio *bio)
 	struct dm_crypt_io *io;
 	struct crypt_config *cc = ti->private;
 
+	/*
+	 * For zoned targets using a sector based IV, zone append is not
+	 * supported. We should not see any such operation in that case.
+	 * In the unlikely case we do, warn and fail the request.
+	 */
+	if (WARN_ON_ONCE(bio_op(bio) == REQ_OP_ZONE_APPEND &&
+			 !test_bit(CRYPT_IV_NO_SECTORS, &cc->cipher_flags)))
+		return DM_MAPIO_KILL;
+
 	/*
 	 * If bio is REQ_PREFLUSH or REQ_OP_DISCARD, just bypass crypt queues.
 	 * - for REQ_PREFLUSH device-mapper core ensures that no IO is in-flight
-- 
2.30.2

