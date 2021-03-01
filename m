Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742E23276C2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 05:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhCAE7L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 23:59:11 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:23221 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbhCAE7J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 23:59:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614574750; x=1646110750;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=9vC9iIdCtQcnsi30gaVjoF2yU6hKJpuznKwhI8fRwYw=;
  b=dtarEE2m9Zv6/EuQcO9lmzcEKdd7TCKn/AY4NVqBh5kAgXyrR8LBveuI
   k4kPyYBND6Un2uYgU8jEWiWaat8HwXmfu+VZegAR85sZV6hCA9pkYUxCx
   hhWjOR8FLaLyfK91Pdyz9AhDqDC+/x3fU6WQ4zZRdbhXE3KIZgD9QHFHJ
   Cyed9iNIoMv868RIJ/WYUAJZjKot+TCjMUIQSR+s0fAAyMpQaIafPx7sp
   SwsHjM05OTyRUwnr1BJ+TGsrcQ0OUVBdPN9LQTSJ++CefD6XNI6zxnrL9
   KqZExfZBmisjhhQOW4DNsMKSrFHQQ3Ge08ntn5FEJyyxyMj2EffZToaHz
   A==;
IronPort-SDR: RLvOzBgDK0F2XXDVASArPmzpP/Uz/9dNyEr5Laj3j5D9nUER16jJy2RQjZQzbKhEGBCB/aD3FV
 6jBq/hDan4NpD65nsTm4uKAeG9wQ3f8st567HO7sUycw5xFIo1GKuMpx/nOcVdFi7hy9DpN8MT
 y73RqBs//GZaKUMJuXSddtvZtzmWkmJmOqJ6Yz93flFdZF29m7tAYLypTcmpwucn9KKbO/1E+b
 RmADv87Cluwb72/SJJ1bUfYJ/ynnnFfnA6wDzeUgTV1lSoG/vJvsQHXKivQrHyXb0jMXN5Ctv2
 2J8=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="162200950"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 12:55:51 +0800
IronPort-SDR: 56UT7LqdYFca2hA1N7akaeRRXHXSVfAfoU6P783sKgmSpfnXXhkzTknHB0zO3EQ+8apntBQMAg
 YGgs+6f9hG/qtiTnjgbCIOPtNRbdq5gKEWVvBu4kWIHC/zG6baxNdA2bnEGjH4X5E1THNDGyaX
 7CjsqnpLSUSjkgHN+3krC78mzOC9HPyHTcO/Tf9Fl6XunMnbPJfOV+e+rLBn17D9cNGu1Cu6jJ
 fiu1RWky9UakaXh6UcrM4aqQfMfqS11XCbWR3NyhsPUPE1ZSXGxQLumZ5r7Qx3nQk8FUwexW2r
 PLdZnO8oenMwsQqIBYZ4kkdo
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 20:37:08 -0800
IronPort-SDR: RChYY+3QClU3mq5Y/5WM7AQSldWMBGqO+aYTWaG6t2/pSBFETCAQkXA13UpNLgs1SR52gGzo/B
 Mg/ohsDZbMzMQUp+Qo9ogkNlLJ0v6jJv4myyPSDg3bwRVsUdQxsFPPHKrEhbpCOAMn3gBAiRXb
 QFB9DNXbPbXMp33U6gSn/rSe2CB4+TqRm0EtTFaUywc1qE+bWt23tUFlsrMhpYj04TR39CPPvL
 RbbuyAClyFALzRzICz5cpzfZX3vI85UM0FBudIa57PiTDtfZa79kkmSxrTwRZkCvjP2JP0erNP
 giI=
WDCIronportException: Internal
Received: from 4bypzw2.ad.shared (HELO naota-xeon) ([10.225.48.68])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 20:55:49 -0800
Date:   Mon, 1 Mar 2021 13:55:48 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Message-ID: <20210301045548.zirmwk56almxgint@naota-xeon>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
 <20210226191130.GR7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226191130.GR7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:11:30PM +0100, David Sterba wrote:
> On Fri, Feb 26, 2021 at 06:34:36PM +0900, Naohiro Aota wrote:
> > This commit moves the location of superblock logging zones basing on the
> > static address instead of the static zone number.
> > 
> > The following zones are reserved as the circular buffer on zoned btrfs.
> >   - The primary superblock: zone at LBA 0 and the next zone
> >   - The first copy: zone at LBA 16G and the next zone
> >   - The second copy: zone at LBA 256G and the next zone
> 
> This contains all the important information but somehow feels too short
> given how many mails we've exchanged and all the reasoning why we do
> that

Yep, sure. I'll expand the description and repost.

> > 
> > We disallow zone size larger than 8GB not to overlap the superblock log
> > zones.
> > 
> > Since the superblock zones overlap, we disallow zone size larger than 8GB.
> 
> or why we chose 8G to be the reasonable upper limit for the zone size.
> 
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/zoned.c | 21 +++++++++++++++------
> >  1 file changed, 15 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 9a5cf153da89..40cb99854844 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -112,10 +112,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
> >  
> >  /*
> >   * The following zones are reserved as the circular buffer on ZONED btrfs.
> > - *  - The primary superblock: zones 0 and 1
> > - *  - The first copy: zones 16 and 17
> > - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> > - *                     the following one
> > + *  - The primary superblock: zone at LBA 0 and the next zone
> > + *  - The first copy: zone at LBA 16G and the next zone
> > + *  - The second copy: zone at LBA 256G and the next zone
> >   */
> >  static inline u32 sb_zone_number(int shift, int mirror)
> >  {
> > @@ -123,8 +122,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >  
> >  	switch (mirror) {
> >  	case 0: return 0;
> > -	case 1: return 16;
> > -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> > +	case 1: return 1 << (const_ilog2(SZ_16G) - shift);
> > +	case 2: return 1 << (const_ilog2(SZ_1G) + 8 - shift);
> 
> This ilog(SZ_1G) + 8 is confusing, it should have been 256G for clarity,
> as it's a constant it'll get expanded at compile time.

I'd like to use SZ_256G here, but linux/sizes.h does not define
it. I'll define one for us and use it in the next version.

> >  	}
> >  
> >  	return 0;
> > @@ -300,6 +299,16 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
> >  		zone_sectors = bdev_zone_sectors(bdev);
> >  	}
> >  
> > +	/* We don't support zone size > 8G that SB log zones overlap. */
> > +	if (zone_sectors > (SZ_8G >> SECTOR_SHIFT)) {
> > +		btrfs_err_in_rcu(fs_info,
> > +				 "zoned: %s: zone size %llu is too large",
> > +				 rcu_str_deref(device->name),
> > +				 (u64)zone_sectors << SECTOR_SHIFT);
> > +		ret = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	nr_sectors = bdev_nr_sectors(bdev);
> >  	/* Check if it's power of 2 (see is_power_of_2) */
> >  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
> > -- 
> > 2.30.1
