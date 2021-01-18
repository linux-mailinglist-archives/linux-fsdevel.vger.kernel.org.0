Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01902FA2B3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Jan 2021 15:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392795AbhARORJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Jan 2021 09:17:09 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25246 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392540AbhARORE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Jan 2021 09:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610979423; x=1642515423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WPFB12+j7JeTR4FEpxT97h4iJBU+1lLfEK+SeLNNvgE=;
  b=Q5i7Yv8V48hMG8TOovluPL7bnOW26shuHMV516hnlhao0LJ1q8wP+0aN
   N/dojT0NKcrPuZiHRY8Ppy59Ow3nga7sO2NjiBDr33fiacVTi8rFeW+9Z
   DFkjk8b+w9g9bWaUPAjTzN2Ml/r4zIT/GcogYQcllE2avUV6dygrURdZi
   qlLtglFqoeTV9ONde2/YSJvMnZIpTQtY03chdbOgvSdK+eAUGBcxg6fLG
   g8dqrCD/iwogOvroJDv4Bmw0OjTkQBBjWugr+qyQGJYugEGKvL5U1p8qX
   M54XXZidEKcY1vUqNVEMszSyjOIOypaL9mt8PlMeBqb3HyxNMuhNf8JxQ
   g==;
IronPort-SDR: 6cvwXRNfo9WLS3Z9BvFNfXGjKw++ofhFVL58WEOmdCwbRuN+huRfAbjuU2VDR4b2xO4wrs5bLf
 UhJVWKFZNpDsOuIWpxRbkHR7PLivOa2bTcUpYOcdVGOXyfSDMm03CGzANDzIQKHRrhoIqdTjXq
 hyqg2Bja1Dyq6ACfN5rEvZjxq8oJS03Z/RoRggPKXr0tR3JA9Ypg2tXw7w4NWCQE4Sx5B+IkM2
 tWi9H0sJU/wslM4RjjkaNcYtUlC77tkbQV+kyhbBXjdfNMI/mbQXDaa+TAhgbEsq6CsOJ/7Eed
 rRE=
X-IronPort-AV: E=Sophos;i="5.79,356,1602518400"; 
   d="scan'208";a="162151681"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jan 2021 22:15:57 +0800
IronPort-SDR: RO7sx7AwSqyeEsp0LSlux3TQuTJqAYynXqCAUbaKvvrlaUhVlwy4H6baeKZk7Z7B8RUnSDDJgD
 Og9FdSTVG1xlhGNwtvLcDHWdmXRHw4kkTAZoSJcZwmV7kWmqPZO4uDX1tK8i4CjomEaCUywu39
 buaSdAxgMzSimNVre40S6r9Akf2J1PBPNupxtus6yR9gm0uhtwywTd0eytThC78rCYCm0mg/K/
 7xfY0Tm2ZT5T64ZHAqs8iWsR4i/4LK6plxt0H4HrcH7XyfAdu1tINPiuz4L7jpRdfLrEEI5Q5J
 z5487q18wTN9AgvnwH58CvZF
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2021 05:58:33 -0800
IronPort-SDR: l87k26dtJ+50dt/e1EMziSKGnynUJORDxtS5uWAsHVuCTTKj+7LY+Lize473GBNceM2SxlWaSg
 E8fsZ8kFNp/1HgHe5xNcCJpeemt0xuHhaTh+grj1oaChEHk2vkIARMedbS7pBjpL/x/OsOJYoW
 zNsm+rezVgj/g0GZdgj85JEDHSIjkcpr3A4HaKDMZmnnHQw61XY8ttXIANYt6t/ksSYajPfZNu
 h0ONJxx5BiuVbBbH6qw5I9ZlW67Y3nBuCuUYV8nrIQxZVpUYF6C+fRBF//mdaulrgbvWwURyVD
 uzw=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip01.wdc.com with SMTP; 18 Jan 2021 06:15:57 -0800
Received: (nullmailer pid 2734464 invoked by uid 1000);
        Mon, 18 Jan 2021 14:15:55 -0000
Date:   Mon, 18 Jan 2021 23:15:55 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v12 08/41] btrfs: allow zoned mode on non-zoned block
 devices
Message-ID: <20210118141555.lljrdbuhok4y4d23@naota.dhcp.fujisawa.hgst.com>
References: <cover.1610693036.git.naohiro.aota@wdc.com>
 <b80a551167d92406924050e9ccbcd872f84fa857.1610693037.git.naohiro.aota@wdc.com>
 <e026431f-1cbe-fd28-c4f8-0bee4b26de16@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e026431f-1cbe-fd28-c4f8-0bee4b26de16@toxicpanda.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 15, 2021 at 05:07:26PM -0500, Josef Bacik wrote:
>On 1/15/21 1:53 AM, Naohiro Aota wrote:
>>From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>
>>Run zoned btrfs mode on non-zoned devices. This is done by "slicing
>>up" the block-device into static sized chunks and fake a conventional zone
>>on each of them. The emulated zone size is determined from the size of
>>device extent.
>>
>>This is mainly aimed at testing parts of the zoned mode, i.e. the zoned
>>chunk allocator, on regular block devices.
>>
>>Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/zoned.c | 149 +++++++++++++++++++++++++++++++++++++++++++----
>>  fs/btrfs/zoned.h |  14 +++--
>>  2 files changed, 147 insertions(+), 16 deletions(-)
>>
>>diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
>>index 684dad749a8c..13b240e5db4e 100644
>>--- a/fs/btrfs/zoned.c
>>+++ b/fs/btrfs/zoned.c
>>@@ -119,6 +119,37 @@ static inline u32 sb_zone_number(int shift, int mirror)
>>  	return 0;
>>  }
>>+/*
>>+ * Emulate blkdev_report_zones() for a non-zoned device. It slice up
>>+ * the block device into static sized chunks and fake a conventional zone
>>+ * on each of them.
>>+ */
>>+static int emulate_report_zones(struct btrfs_device *device, u64 pos,
>>+				struct blk_zone *zones, unsigned int nr_zones)
>>+{
>>+	const sector_t zone_sectors =
>>+		device->fs_info->zone_size >> SECTOR_SHIFT;
>>+	sector_t bdev_size = device->bdev->bd_part->nr_sects;
>
>This needs to be changed to bdev_nr_sectors(), it fails to compile on 
>misc-next.  This patch also fails to apply to misc-next as well.  
>Thanks,
>
>Josef

Oh, I'll rebase on the latest misc-next and fix them all in v13. Thanks.
