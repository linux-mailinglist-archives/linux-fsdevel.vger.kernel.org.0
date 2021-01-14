Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC5B2F63DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Jan 2021 16:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbhANPLe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Jan 2021 10:11:34 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8246 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbhANPLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610637093; x=1642173093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1k0qgbblaaWf0EI2DMXS5oak/Zxu2YMt05VPfitItB8=;
  b=ErT/3TU3jv+q0hi2TjLzJXZ2UF95h9LXknAEZff7fCigmiYaKjqGyoRc
   qFk4X4L6GPXWyveYNddTm+RWG2wDufnmuGcgSXNq/4O4UPrIsmfp0jN0e
   xeSCFdJIrYKb5zhpGlOlbOcMk5TwpxhfWnVW1LelIhjlaEnlAcx+2xlky
   QM5ltR8XmqcFUxD5HIExwUuBy268WT1WVZ3tUAwmTS66+14Gr+uRyjbYy
   IYS6JqjA8gEEydgEUrpgb7e2LrttT8AYtInSCcIxfnWKSjkGLIDxFDplV
   rK1WX7oKVTDmNnOzwvGvubXczAAghKmAZ92Bw4AyXsYuIjQnz21fQqhqn
   Q==;
IronPort-SDR: 0Bou7UbXgibHacCsT9NP3ZJUOVV67KtLm4TnhdvnEZs00D0yw4R3RCrbUJR1+NAg85+sIu4vXq
 JHq6JhSfzbetI0Eujk6nFmpZzPFtroz04gTtOtqczJb+LLrfugK0jijotqR8soIQIinB4Qq/oe
 cyxiZkeUwHJk4Hy44X3hoo4xnlA6pb2056atumeyA9MtQoz4Tr3tCtuuEIn7w6D3ZrtEHfAD+j
 TqHSrjFSoNaluXrUwrLFBbNbvSr3ItJfClrmGlvaPpQIbaJMjRAnxBu+wkyngJtT2SD4wIuKIX
 QCQ=
X-IronPort-AV: E=Sophos;i="5.79,347,1602518400"; 
   d="scan'208";a="158599004"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jan 2021 23:10:27 +0800
IronPort-SDR: 8r37v3WcFvfYhyY/ktQ2mKC4bPu1aMeHH/gn9BSvEfGEgShTtoVEvuxK5PkN821MyzeWEy9O5s
 bxPxNDO739geTTK2QKKIVPVNtmfQastTtpLvOucNF0fGRXDIWGVw++wddbxFeRqotGTD8lHblu
 3NgmFWVoahIOoBANV/nQGWPxT9ym7UwImh9ig19Pf60Q2xTMn2ul1scKQU2g35hGTGeE8DRbMv
 5kqMTZbCkxfiYXRwgSGD5SuvO070bi6U5q2v4pFe9iyyvtYPG+392yjmjZytYPr82dPoM53LF0
 0rPgUU8EhBVugHLS1iAaGFL+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2021 06:53:14 -0800
IronPort-SDR: eHqtSpse+62cNRiojh0ouGqPLgU0LJDU0C73a2FRHyCmEFTX2Wabc3EJelSlMr0SrDVN+5uojO
 xK47FLmbbERT0hZUN8p8uIROPkWx6Iovz7tAQVd/K2jEPJbQwSJsPy9ahLeQfUaftC5+3jMlOC
 OOpAI43OtAvTRutpFf/SPRFtjv4uA29Kg/v/AeQiJYIdLyKfEfIFy6RbNPy21yZzTcpN4VtVjI
 V+CNp6XF4ycaRFSyTzYZXFsQIC5s1YplfXitw3tgXlFGj0mmvRN6exjznuRgpBaegJOZJBjoVP
 uZw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 14 Jan 2021 07:10:26 -0800
Received: (nullmailer pid 1313840 invoked by uid 1000);
        Thu, 14 Jan 2021 15:10:25 -0000
Date:   Fri, 15 Jan 2021 00:10:25 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH v11 04/40] btrfs: change superblock location on
 conventional zone
Message-ID: <20210114151025.4n4jv25gi37ougay@naota.dhcp.fujisawa.hgst.com>
References: <06add214bc16ef08214de1594ecdfcc4cdcdbd78.1608608848.git.naohiro.aota@wdc.com>
 <42c1712556e6865837151ad58252fb5f6ecff8f7.1608608848.git.naohiro.aota@wdc.com>
 <83c5e084-dbee-a0ae-4a1b-38fa271701a2@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <83c5e084-dbee-a0ae-4a1b-38fa271701a2@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 02:47:26PM -0500, Josef Bacik wrote:
>On 12/21/20 10:48 PM, Naohiro Aota wrote:
>>We cannot use log-structured superblock writing in conventional zones since
>>there is no write pointer to determine the last written superblock
>>position. So, we write a superblock at a static location in a conventional
>>zone.
>>
>>The written position is at the beginning of a zone, which is different from
>>an SB position of regular btrfs. This difference causes a "chicken-and-egg
>>problem" when supporting zoned emulation on a regular device. To know if
>>btrfs is (emulated) zoned btrfs, we need to load an SB and check the
>>feature flag. However, to load an SB, we need to know that it is zoned
>>btrfs to load it from a different position.
>>
>>This patch moves the SB location on conventional zones so that the first SB
>>location will be the same as regular btrfs.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/zoned.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index 90b8d1d5369f..e5619c8bcebb 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -465,7 +465,8 @@ static int sb_log_location(struct block_device *bdev, struct blk_zone *zones,
>>  	int ret;
>>  	if (zones[0].type == BLK_ZONE_TYPE_CONVENTIONAL) {
>>-		*bytenr_ret = zones[0].start << SECTOR_SHIFT;
>>+		*bytenr_ret = (zones[0].start << SECTOR_SHIFT) +
>>+			btrfs_sb_offset(0);
>>  		return 0;
>>  	}
>
>I'm confused, we call btrfs_sb_log_location_bdev(), which does
>
>        if (!bdev_is_zoned(bdev)) {
>                *bytenr_ret = btrfs_sb_offset(mirror);
>                return 0;
>        }
>
>so how does the emulation work, if we short circuit this if the block 
>device isn't zoned?  And then why does it matter where in the 
>conventional zone that we put the super block?  Can't we just emulate 
>a conventional zone that starts at offset 0, and then the 
>btrfs_sb_offset() will be the same as zones[0].start + 
>btrfs_sb_offset(0)?  Thanks,
>
>Josef

I'm sorry for the confusion. Yes, it's really confusing we get
btrfs_sb_log_location() != btrfs_sb_log_location_bdev() with zoned btrfs on
regular devices.

What I'd like to do here is to place the primary SB at the same position as
regular btrfs. Then, we can read the SB on a regular device at mount time
without knowing if the btrfs is zoned or not.

But, I noticed this solution is not working for SB mirrors and confusing to
have different location between btrfs_sb_log_location() vs
btrfs_sb_log_location_bdev().

So, I'll replace this patch in the next version with a patch to use the
regular btrfs' SB locations on non-zoned devices. Since it is non-zoned
device, so we can just write SBs at the regular locations without
consulting the emulated zones... And, we'll have the same results from
btrfs_sb_log_location() and btrfs_sb_log_location_bdev().

I think this change will solve the confusion.

Regards,
