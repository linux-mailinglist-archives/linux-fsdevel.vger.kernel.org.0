Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8DAF12398E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLQWTL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:19:11 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:53763 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfLQWRm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:42 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1N8GEY-1hdQgS2Y64-014F6s; Tue, 17 Dec 2019 23:17:28 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 12/27] compat_ioctl: move CDROMREADADIO to cdrom.c
Date:   Tue, 17 Dec 2019 23:16:53 +0100
Message-Id: <20191217221708.3730997-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:SEzk2cE2KU/nNwoHfidkX8tSUvACbWH8uSk5lxoIuhKQ5CztWxi
 bOWwXOzfL6LJLGSTM7iwROz0sna6duXBrCFvKGwnOsrAzq9Tg9pU9s7afIMaCaRpVGbyCN/
 XwRKj4yFepn9WVTWTnBK2V3XIX2hZwlo+sFykVTcsN1BtuwMYi2wx4Oohc65URen5wcBFuc
 kGOwA5NDRqz4uDUVqyHtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:HlEXxuefKnQ=:q2hK5YnnOvqsUKbyH+4ygI
 M+1LtTx6gRiGNH5cwDteqBKUew+WRP30dnsjs1CqXSY5tcG2Ji+XYJQ9fg74Lh/YtmFcIiDxi
 Wd5mr4n7Dob36GOioVZ0rnSOECG1wbZhlMDMr20rDGsI+87xKTZtYTgNG4DHoebf0r++6ZJFx
 D3cGh07tox4ZvxJp5blgH4rwItQP0lDSge2TLKnrbsF7/Azz4nQHzpzqIvAcOI45ni78YD7Q/
 TGeD61+btd80HC99gaucfPqQHmud6suE08GOy/2X/2EzpfSHV2b+FFZHpAVW9n4BYDZY6E/o2
 DlvTXTFpcVae8SsQm5vKEwO7KrhOm8iUBoD8hEIHOPuXLmNAMnRjC0z+M6eRZ23vwGbXFthBy
 SXLwKf4vDWdI1j2I5Hm+RmAuKnEnLqh/CxpZOJL8urWW6jmQD0BCso1Pr42qY6hntHQmClUZe
 2uQM56dK/NVQe8Z9OwvO46PA+5OC/sRA2bQu548EgWAO/pLfXGWxOHcED0Wc2he6FlQYVIF1r
 DM+osZMXSMnLONmXnpSzJYHexkHQwDcD6Ilm4aSR0Bafc4LAqh3U904vhglbnuSXTBy4v28bG
 k+/bwy8R/clnpebnl0zPoUbXXhF71AMTm5PvJZZ9s1ugzjQwrwmk5VQ9AoKJGWUQSE18oxo0q
 cEe2qQy9AaufAKJ6c2Fr21LA3uqpwQ2CX1KJDBjvuVzkAhNRXV1iQFElVh1yeR03B+eFTPByi
 CpcpUkCYw7zZ7MEQQenSPWy/XRHmamdibRDpOvPyV9ZHYarpKVQ/JO/WHS2i2LowlZfjOhW92
 9DvUema4JwLbhqhT3zOrL+qYxejCVGAPJhd1tDrKBuLXdyxrDxVziqd7Knxe6ltNa1Gjc+jDU
 a3jFykHFY1cSFNebaT1Q==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Again, there is only one file that needs this, so move the conversion
handler into the native implementation.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/compat_ioctl.c  | 36 ------------------------------------
 drivers/cdrom/cdrom.c | 28 +++++++++++++++++++++++++---
 2 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 578e04f94619..cf136bc2c9fc 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -95,40 +95,6 @@ static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
 	return error;
 }
 
-struct compat_cdrom_read_audio {
-	union cdrom_addr	addr;
-	u8			addr_format;
-	compat_int_t		nframes;
-	compat_caddr_t		buf;
-};
-
-static int compat_cdrom_read_audio(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, unsigned long arg)
-{
-	struct cdrom_read_audio __user *cdread_audio;
-	struct compat_cdrom_read_audio __user *cdread_audio32;
-	__u32 data;
-	void __user *datap;
-
-	cdread_audio = compat_alloc_user_space(sizeof(*cdread_audio));
-	cdread_audio32 = compat_ptr(arg);
-
-	if (copy_in_user(&cdread_audio->addr,
-			 &cdread_audio32->addr,
-			 (sizeof(*cdread_audio32) -
-			  sizeof(compat_caddr_t))))
-		return -EFAULT;
-
-	if (get_user(data, &cdread_audio32->buf))
-		return -EFAULT;
-	datap = compat_ptr(data);
-	if (put_user(datap, &cdread_audio->buf))
-		return -EFAULT;
-
-	return __blkdev_driver_ioctl(bdev, mode, cmd,
-			(unsigned long)cdread_audio);
-}
-
 struct compat_blkpg_ioctl_arg {
 	compat_int_t op;
 	compat_int_t flags;
@@ -178,8 +144,6 @@ static int compat_blkdev_driver_ioctl(struct block_device *bdev, fmode_t mode,
 	case HDIO_GET_ADDRESS:
 	case HDIO_GET_BUSSTATE:
 		return compat_hdio_ioctl(bdev, mode, cmd, arg);
-	case CDROMREADAUDIO:
-		return compat_cdrom_read_audio(bdev, mode, cmd, arg);
 
 	/*
 	 * No handler required for the ones below, we just need to
diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index eebdcbef0578..48095025e588 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -3017,9 +3017,31 @@ static noinline int mmc_ioctl_cdrom_read_audio(struct cdrom_device_info *cdi,
 	struct cdrom_read_audio ra;
 	int lba;
 
-	if (copy_from_user(&ra, (struct cdrom_read_audio __user *)arg,
-			   sizeof(ra)))
-		return -EFAULT;
+#ifdef CONFIG_COMPAT
+	if (in_compat_syscall()) {
+		struct compat_cdrom_read_audio {
+			union cdrom_addr	addr;
+			u8			addr_format;
+			compat_int_t		nframes;
+			compat_caddr_t		buf;
+		} ra32;
+
+		if (copy_from_user(&ra32, arg, sizeof(ra32)))
+			return -EFAULT;
+
+		ra = (struct cdrom_read_audio) {
+			.addr		= ra32.addr,
+			.addr_format	= ra32.addr_format,
+			.nframes	= ra32.nframes,
+			.buf		= compat_ptr(ra32.buf),
+		};
+	} else
+#endif
+	{
+		if (copy_from_user(&ra, (struct cdrom_read_audio __user *)arg,
+				   sizeof(ra)))
+			return -EFAULT;
+	}
 
 	if (ra.addr_format == CDROM_MSF)
 		lba = msf_to_lba(ra.addr.msf.minute,
-- 
2.20.0

