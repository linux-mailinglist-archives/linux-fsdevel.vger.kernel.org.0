Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79ABD155422
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 10:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgBGJA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Feb 2020 04:00:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:55428 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgBGJA0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:00:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581066026; x=1612602026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Nl0KgVHX2hrjGcAYSG+OYijzdNnUClnaz1tyuDfMXkQ=;
  b=YjRJhF7XEjy+R77vq3CYx1IMjHP7/Amehr8IuimAOBEIU+kZudWTI3Mg
   Et1HwnhjJGHU7w/CJ3eG9cH1KnMmyBv2Ng2c2llo8rZwCFbMovCkY4UnJ
   PUaXOLaWWYFIQPrL6BzODre5EEUjtJ9SMBD+NZpGnLstdnxWq1S+u3Sv9
   +bolGRZ4eR2ceMHq/kZM9bOz0QTiXccM/0WgkoSfwnqtYgbwzOlO1PUr0
   Blk4twRt0MrrhHXVEkFZc04tNqIUsZe2Y0omakvCmec7z2D7TKm5ssBr/
   ucgIFPa/wYVjc5YBVNzmBCInJsJeTodSSH33KLmj0fl5EaQpPBsJqovYK
   g==;
IronPort-SDR: 57WWw3usUREeI6XcfIJ2Cg3exvrtU0A2Xz2dxALalXG2Phy6W0/LV7dKYXVVfAjcknLG9E8qOl
 jT679JGpTsIoMTT+PfmGzAe5xg6CJT1P2l1RT2r73YbgFWdDRryaI4dkMKtvGNBtqDg4y/tTUW
 dJoPlX6vVPrOp2bejizKXKSq3bCfE/G+/GDj2YPvW0zCQ8lqs+DiWEm1flLWue5a7QqUAftIGh
 1j5/RkS0AnmTufYXbOVMp9FJVqe/uwgY3RxGoyG71mzI83iMyIxVuP05pL2ljWFxANSr9qSsqw
 KvM=
X-IronPort-AV: E=Sophos;i="5.70,412,1574092800"; 
   d="scan'208";a="129890195"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 17:00:25 +0800
IronPort-SDR: jO0sAXwATQ25aojn9XNQTrtY1SuPv5YooQhHyRF6+eTv+PsDCLNv/Taf6z2liAPZEDRjDJVUh7
 QN5L3lKTp3KGZoijIHdbF9VzCozVrEZRmRHSnKOjNdsHk8up8/vh7DXVyN+oI8tvss+DX/5fgg
 gPUI4cqSNsDIwWkFL/DSuvYqO6pR83y24JbByDFAgPBPVJGtHpelb+cQcPCBzsey0FMXgL7RUv
 7ul4HKQLG/FTxjct3xVnkTJjtm7159n5Zg96FdhmkGtofNAFld27oVRLK3Z5NjbbLeoAh44Ffy
 D6INBxCb3qTIPLbRXTL0Dwy1
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 00:53:22 -0800
IronPort-SDR: +8lq1i67ClDhys3D9umTpxQhXKcrmqVRYQTT3GEtkvp3aVKNSKyyaVW2NzXBcarK4j888dw7rk
 WMl8q4Yc9ZLN+f+PrhDVgf3hYTgdGes+Ft5JLCXG60J5KOGiWZnI7HcM6ZYdFP3OKcS6h59d72
 26zadE16bYJA0dgGmHMuNkcmlRF0hZkhhA/c9oh73p0cm58RyQpTLFAOmKFNPvRJmGwlLur2qx
 xcbdvUDzp4YvIEjQwCrLEHogHrwvFmtadZZJ+btcpQj0b+DVZcE2h0GMjzw12L+McQMThUiswM
 3IQ=
WDCIronportException: Internal
Received: from naota.dhcp.fujisawa.hgst.com ([10.149.52.155])
  by uls-op-cesaip02.wdc.com with SMTP; 07 Feb 2020 01:00:24 -0800
Received: (nullmailer pid 906540 invoked by uid 1000);
        Fri, 07 Feb 2020 09:00:22 -0000
Date:   Fri, 7 Feb 2020 18:00:22 +0900
From:   Naohiro Aota <naohiro.aota@wdc.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 09/20] btrfs: parameterize dev_extent_min
Message-ID: <20200207090022.wqes5ig5xxoyni5c@naota.dhcp.fujisawa.hgst.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-10-naohiro.aota@wdc.com>
 <b8c284f3-520c-5777-9309-0fb913227824@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b8c284f3-520c-5777-9309-0fb913227824@toxicpanda.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:52:19AM -0500, Josef Bacik wrote:
>On 2/6/20 5:42 AM, Naohiro Aota wrote:
>>Currently, we ignore a device whose available space is less than
>>"BTRFS_STRIPE_LEN * dev_stripes". This is a lower limit for current
>>allocation policy (to maximize the number of stripes). This commit
>>parameterizes dev_extent_min, so that other policies can set their own
>>lower limitation to ignore a device with an insufficient space.
>>
>>Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
>>---
>>  fs/btrfs/volumes.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>>diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
>>index 15837374db9c..4a6cc098ee3e 100644
>>--- a/fs/btrfs/volumes.c
>>+++ b/fs/btrfs/volumes.c
>>@@ -4836,6 +4836,7 @@ struct alloc_chunk_ctl {
>>  				   store parity information */
>>  	u64 max_stripe_size;
>>  	u64 max_chunk_size;
>>+	u64 dev_extent_min;
>>  	u64 stripe_size;
>>  	u64 chunk_size;
>>  	int ndevs;
>>@@ -4868,6 +4869,7 @@ static void set_parameters_regular(struct btrfs_fs_devices *fs_devices,
>>  	/* We don't want a chunk larger than 10% of writable space */
>>  	ctl->max_chunk_size = min(div_factor(fs_devices->total_rw_bytes, 1),
>>  				  ctl->max_chunk_size);
>>+	ctl->dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>>  }
>>  static void set_parameters(struct btrfs_fs_devices *fs_devices,
>>@@ -4903,7 +4905,6 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>  	struct btrfs_device *device;
>>  	u64 total_avail;
>>  	u64 dev_extent_want = ctl->max_stripe_size * ctl->dev_stripes;
>>-	u64 dev_extent_min = BTRFS_STRIPE_LEN * ctl->dev_stripes;
>>  	int ret;
>>  	int ndevs = 0;
>>  	u64 max_avail;
>>@@ -4931,7 +4932,7 @@ static int gather_device_info(struct btrfs_fs_devices *fs_devices,
>>  			total_avail = 0;
>>  		/* If there is no space on this device, skip it. */
>>-		if (total_avail == 0)
>>+		if (total_avail < ctl->dev_extent_min)
>
>This isn't correct, dev_extent_min is the total size with all stripes 
>added up, not the size of a single stripe.  Thanks,

Hm, I can revert here, but isn't it no use to search into a device
whose available bytes is less than dev_extent_min (= BTRFS_STRIPE_LEN
* ctl->dev_stripes)? Since max_avail can only be less than
dev_extent_min, we anyway skip such device with the below "if
(max_avail < dev_extent_min) { ... }" part.
