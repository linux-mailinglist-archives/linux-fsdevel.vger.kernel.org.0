Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7643276C5
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 06:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbhCAFBE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 00:01:04 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53000 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhCAFBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614574862; x=1646110862;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=BwDcBgRCdU5sQw+8D3yJawASvWDBZEZaQnkXK76I0qk=;
  b=kX+l1dUE1AFQnpYwafc9kLiFjM1BuDpvCw3FFmPeOa/LZsVElt+YUXQo
   +XAgNI0xegDTfFtatE/xjDylXTcz63vvVDWnArdSwNEFG5qsC4Gg5pZ+M
   lZwhcoyc3GJIxyvBSELE6sQwQUbV97s4RaqGZEOw6pFDMpnJwROUVJnnm
   f7BuRW2cTaBQIOmHI4m6/VMDVR/8S3mlQKsrJRfc2YGcmNCyM1WgJNvS7
   QfDFo4E580yEJ/5nuQT5Lcr8STRoQUqdJtzVB0TLly17+Kpx444mnptJC
   Nor/i89emfADBnn8HzdFoSNjrejd577y5V8z1C6DaQ1gLJkAKNr1cjwGC
   g==;
IronPort-SDR: k4JL+MqKMlL/ZzNhMBjSN8LdojReJvxIbE0vu8DcIwNjjFJsehkR5W1ozhPOCnazT6gcWdLeou
 QCupk8vYb9EgQOP9n9pFfvphej8bt8oMDIwQxN8ElTSf3+55Hnqc9XbaaxHwH1CbrZGgLqwdDW
 3dzySeVlPbSLsrrVRQnRVMv5gOH6fm6danutXeED9Hppq3WRCxAyPhkPCYCfSuhVDtE2XRJcxX
 K4/1L6k0CGhfSlNcGKQxbYF8gebJ/ntNdTRdhHm53jvZqSZeg5inYfzr4qGrzGVUdsRLJeLVq1
 1U0=
X-IronPort-AV: E=Sophos;i="5.81,214,1610380800"; 
   d="scan'208";a="271625847"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2021 12:57:45 +0800
IronPort-SDR: CscbAZSMvPOCyxCJD3vAbLFTd8/gIlD8VZ/U+JWCTeIeKOAxLd493V9FTpe3IXs6HXMPPSmW8H
 1tLF+MGJUdNrof+iidH9iE4Y5gu721moqLOgG5NvyLwjgUpivtjuyaTvKiLSxLrIukL5tO/iGa
 9bLg+z1b3CANYw/fBsKtKhLO8Pf2bswxaJTZAyXCxFiybXdaCnQFRh7L8N107Ttro99OAXeflc
 zhnekm+fA5MoMxEzTQ/HQymcgMMHbpbHFUCm/kGvaLShTb+IoDafApagcHxaVsqUMjmYlwGosg
 1GDhwv9i0A/UPoV86VpaEfil
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 20:39:03 -0800
IronPort-SDR: ErFomcOHyzzLXU4yN4lPccE1Y1Uja6lyq/wYdG/9rq8mdCl1Eibe5p1DE2KDebhDieIESLrNWE
 2qXbRJy5nC4MRSXnkGHSqzmtawHaNw/ne2GeCURXp5L3AjCNfmnJL4fn3ll120iFp+OUxUGsmY
 BJZ1858PNHC71M8Hl1MgexedNQdea8GQB7qFhxuY8+ibK/28AYnIvl0j6+kMKCdB83FTwbUScm
 k1u1g9r2tvi55lj1uRj/08ALA+MRo3tAkYzKT9jkyTLlBS+ck2xMcDr1Z7Tx2Rf8zTpatT0dRr
 OIA=
WDCIronportException: Internal
Received: from 4bypzw2.ad.shared (HELO naota-xeon) ([10.225.48.68])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2021 20:57:44 -0800
Date:   Mon, 1 Mar 2021 13:57:43 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     dsterba@suse.cz, linux-btrfs@vger.kernel.org, dsterba@suse.com,
        hare@suse.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] btrfs: zoned: add missing type conversion
Message-ID: <20210301045743.24veuvqolbor447m@naota-xeon>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <e6519c3681550015fbeeb0565f707d72705a39f1.1614331998.git.naohiro.aota@wdc.com>
 <20210226191858.GS7604@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226191858.GS7604@twin.jikos.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 26, 2021 at 08:18:58PM +0100, David Sterba wrote:
> On Fri, Feb 26, 2021 at 06:34:37PM +0900, Naohiro Aota wrote:
> > We need to cast zone_sectors from u32 to u64 when setting the zone_size, or
> > it set the zone size = 0 when the size >= 4G.
> > 
> > Fixes: 5b316468983d ("btrfs: get zone information of zoned block devices")
> > Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> > ---
> >  fs/btrfs/zoned.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> > index 40cb99854844..4de82da39c10 100644
> > --- a/fs/btrfs/zoned.c
> > +++ b/fs/btrfs/zoned.c
> > @@ -312,7 +312,7 @@ int btrfs_get_dev_zone_info(struct btrfs_device *device)
> >  	nr_sectors = bdev_nr_sectors(bdev);
> >  	/* Check if it's power of 2 (see is_power_of_2) */
> >  	ASSERT(zone_sectors != 0 && (zone_sectors & (zone_sectors - 1)) == 0);
> > -	zone_info->zone_size = zone_sectors << SECTOR_SHIFT;
> > +	zone_info->zone_size = (u64)zone_sectors << SECTOR_SHIFT;
> 
> That should be fixed by changing type to sector_t, it's already so in
> other functions (btrfs_reset_sb_log_zones, emulate_report_zones).
> 
> In btrfs_get_dev_zone_info thers's already a type mismatch near line
> 300:
> 
> 	zone_sectors = bdev_zone_sectors(bdev);
> 
> linux/blkdev.h:
> static inline sector_t bdev_zone_sectors(struct block_device *bdev)

Ah, yes, I forgot that point. I'll repost by fixing the type of
zone_sectors.

> >  	zone_info->zone_size_shift = ilog2(zone_info->zone_size);
> >  	zone_info->max_zone_append_size =
> >  		(u64)queue_max_zone_append_sectors(queue) << SECTOR_SHIFT;
> > -- 
> > 2.30.1
