Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB42A245D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Nov 2020 06:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgKBFez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Nov 2020 00:34:55 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:27403 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgKBFez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Nov 2020 00:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604295295; x=1635831295;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8gp7ono4TQhc9qFJHAUNmWP/7AkLluWRfDSc3wD/4CI=;
  b=Zf5k2TjGAE2XHYvy6bTS3o/tqId6RssDxUlkLI1D69sRMWbNrX0g0S//
   1phYRmQk+Tjk6BuP/UKLK6GEsWbwE2nhmYW+705KTzl5pyksL0eeNz8dv
   Tn9W/IkmzJ9b/Vj8rNJQ7nYct+Bs2M2xgqN1BWdg6/e1DZ5k41/DUOBm/
   2pYypiGYCCPwBFO8nadCT0DRK+5Iu7sptPTBgfmsVQ1+i/TCkFGAgEuUv
   ZgXh2gkqkPP3CsTNphQf6uH/hgCiHm6kz3UGlcTfZs1FlKczUeQf2oiFz
   QEFb62h6uJW6X8HEDy7gJ0fHoWeJVEiz+s6VT1ehIf0lx7HOGs5ufP4XZ
   g==;
IronPort-SDR: YTzWTInozS0OgRZ01WIdoKU9jTRxH13SGobWEV3YByWStIP15AwF1sUxA2blZzBXAnSASfUiQN
 boqvG1WI4XPacgbAl/nQFQwXTLwdB9s+NtIKLTgKdJTRFFDQqbI2M/Ye4JqKBgvt3Gy44gCN7N
 g7Mj+JQIMxvL17Cy0RyXLSVLoiB5uNihbPIb8mENRhEc62HoArVsMPt9TFpb8vsEmPhQKJMDhd
 lD5+66a+hW1cLEt08ZVljqZApwODeccj1BUYqX4Gk8Rs1eo0ziWiJZdN51jVxmyTRV1kaqRsJq
 5tk=
X-IronPort-AV: E=Sophos;i="5.77,444,1596470400"; 
   d="scan'208";a="151425550"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2020 13:34:54 +0800
IronPort-SDR: HQQbc9F6K8UF7yzh1ELeodmWv7qj752LsRMfvKLY53otbjAZlGiBMHOcqS6iBTxYqfLdCDPL2/
 jJI4aU5gsIAWMgdWtcrpwL7u6WhpwE0MEUM64tKVUAcXynxeFAsRJnXPs3GqHHBC9Op1qcAhm2
 xgwg1yTkNpfB3cc9qwDXuFPq+AZ/IrQgHfzEjF3tCm/L8rFeLM27oZtFV71EDi1Z0Hn9sLEAlD
 h586W26UbzSyUTmL6BQE0zfFWESUqMWLKyDbsxmlamAxRWWbb5ZDlS252I745ynH8qp/oOPvIq
 D7lIgcb3H2k67upI4YTi7JON
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2020 21:19:55 -0800
IronPort-SDR: JprUtGgfjDRjcMtjvaZAyz10Vy2INJRwxmw2Bx6mnpZo1/BTDs1V9fyZW1mRJu9qFXNgSxsnMV
 4cbngTu6bR4FnKoRv2GJ4oCycXSc3JRBXCM0aDl4J+n931RFPD/YvdHJHHJ7tsnv3EX8UIElq3
 NbsZ8jUVXgTS7N33Gwg9ciyYV8OnZb5J6FUG/TRTKOgd//j6ecWqpnkIOHz7wTosd7VKW8tFi0
 3G+YcY1/MSoJEzD5/8iwIWuPtgqt1P01sONdlxeBo5HzRPWKEV5s2Kj48T7uKX7CDjO5l7M2GR
 Axk=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 01 Nov 2020 21:34:54 -0800
Received: (nullmailer pid 3283058 invoked by uid 1000);
        Mon, 02 Nov 2020 05:34:52 -0000
Date:   Mon, 2 Nov 2020 14:34:52 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     linux-btrfs@vger.kernel.org, dsterba@suse.com
Cc:     hare@suse.com, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v9 02/41] iomap: support REQ_OP_ZONE_APPEND
Message-ID: <20201102053452.do3ojoarm6u5jqho@naota.dhcp.fujisawa.hgst.com>
References: <d9a0a445560db3a9eb240c6535f8dd1bbd0abd96.1604065694.git.naohiro.aota@wdc.com>
 <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cb409918a22b8f15ec20d7efad2281cb4c99d18c.1604065694.git.naohiro.aota@wdc.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Note: this patch is for this series.

https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/T/

The patch below uses IOMAP_F_ZONE_APPEND flag to make the iomap bio to be
REQ_OP_ZONE_APPEND.

https://lore.kernel.org/linux-btrfs/cover.1604065156.git.naohiro.aota@wdc.com/T/#m7b3f2d01ab554ea4cba244608655268211928799

On Fri, Oct 30, 2020 at 10:51:09PM +0900, Naohiro Aota wrote:
>A ZONE_APPEND bio must follow hardware restrictions (e.g. not exceeding
>max_zone_append_sectors) not to be split. bio_iov_iter_get_pages builds
>such restricted bio using __bio_iov_append_get_pages if bio_op(bio) ==
>REQ_OP_ZONE_APPEND.
>
>To utilize it, we need to set the bio_op before calling
>bio_iov_iter_get_pages(). This commit introduces IOMAP_F_ZONE_APPEND, so
>that iomap user can set the flag to indicate they want REQ_OP_ZONE_APPEND
>and restricted bio.
>
>Cc: Christoph Hellwig <hch@infradead.org>
>Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
>Cc: linux-xfs@vger.kernel.org
>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>---
> fs/iomap/direct-io.c  | 22 ++++++++++++++++------
> include/linux/iomap.h |  1 +
> 2 files changed, 17 insertions(+), 6 deletions(-)
>
>diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
>index c1aafb2ab990..e534703c5594 100644
>--- a/fs/iomap/direct-io.c
>+++ b/fs/iomap/direct-io.c
>@@ -210,6 +210,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> 	struct bio *bio;
> 	bool need_zeroout = false;
> 	bool use_fua = false;
>+	bool zone_append = false;
> 	int nr_pages, ret = 0;
> 	size_t copied = 0;
> 	size_t orig_count;
>@@ -241,6 +242,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> 			use_fua = true;
> 	}
>
>+	zone_append = iomap->flags & IOMAP_F_ZONE_APPEND;
>+
> 	/*
> 	 * Save the original count and trim the iter to just the extent we
> 	 * are operating on right now.  The iter will be re-expanded once
>@@ -278,6 +281,19 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> 		bio->bi_private = dio;
> 		bio->bi_end_io = iomap_dio_bio_end_io;
>
>+		if (dio->flags & IOMAP_DIO_WRITE) {
>+			bio->bi_opf = (zone_append ? REQ_OP_ZONE_APPEND : REQ_OP_WRITE) |
>+				      REQ_SYNC | REQ_IDLE;
>+			if (use_fua)
>+				bio->bi_opf |= REQ_FUA;
>+			else
>+				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
>+		} else {
>+			WARN_ON_ONCE(zone_append);
>+
>+			bio->bi_opf = REQ_OP_READ;
>+		}
>+
> 		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
> 		if (unlikely(ret)) {
> 			/*
>@@ -292,14 +308,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
>
> 		n = bio->bi_iter.bi_size;
> 		if (dio->flags & IOMAP_DIO_WRITE) {
>-			bio->bi_opf = REQ_OP_WRITE | REQ_SYNC | REQ_IDLE;
>-			if (use_fua)
>-				bio->bi_opf |= REQ_FUA;
>-			else
>-				dio->flags &= ~IOMAP_DIO_WRITE_FUA;
> 			task_io_account_write(n);
> 		} else {
>-			bio->bi_opf = REQ_OP_READ;
> 			if (dio->flags & IOMAP_DIO_DIRTY)
> 				bio_set_pages_dirty(bio);
> 		}
>diff --git a/include/linux/iomap.h b/include/linux/iomap.h
>index 4d1d3c3469e9..1bccd1880d0d 100644
>--- a/include/linux/iomap.h
>+++ b/include/linux/iomap.h
>@@ -54,6 +54,7 @@ struct vm_fault;
> #define IOMAP_F_SHARED		0x04
> #define IOMAP_F_MERGED		0x08
> #define IOMAP_F_BUFFER_HEAD	0x10
>+#define IOMAP_F_ZONE_APPEND	0x20
>
> /*
>  * Flags set by the core iomap code during operations:
>-- 
>2.27.0
>
