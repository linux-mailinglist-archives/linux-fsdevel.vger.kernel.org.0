Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB065285FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 15:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiEPNyd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbiEPNyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 09:54:25 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71212ACC
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709264; x=1684245264;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC7iEmOkHc=;
  b=MLvu0V+aiQYQhGfJLAUAsP5ZDcw/08zFA8FvIMuO/BIbxxZWoA75HxKa
   oBOMo4EIelTwlCyqjANq8zNMbTg4WOj1jvMToP4M34i9c3g9y/OUNcwOw
   Is8OJvmCTNnpt1xoF8S9CGCfFTKCqjJCyKapIvILn+VaEhQrCGhUT1zmT
   IZZBAWqYUZPd7DEX878cmYi76UvZOaCORMI4C5ock8adfqqhgzzBOSZSF
   gF3HXpWUWQlg5vMybKicIAwd2A5T0MaGF/t+USGHd3n/UNjDskm9VZ2MN
   K6QcUECXi0WXusRotG0EAcQZ6YAMyAEg+eP+PFJ3ikH0oggnh9hMpOgL/
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="199259475"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 21:54:21 +0800
IronPort-SDR: u6lU9g6hRG2MzaWdPxsHtb6kt0tR4GMDodjsU6KUkir7nszietutpBF0WNMdKG7pxK8MphegnA
 fXg2XQEz2WW3FMGqmSwctgF7qDqqwqVubuevS4wuOeRt2CieBZMOJT/A9rVMe1hsrb/IHG66HA
 b+SlAwhqrHKZSJXWSc1zBsl+Rg0zOarWHKpuQji/aINYN/ZTBI9KmgCr5o3OLFMjzjsG+dtal5
 cIlTgcQUiJt04+OFl36L2jaeFaq7dqutursvdFqkfjPJscm8aaVQHJZyWqCHjwWsoQmw969tLH
 RRYFif5qAnK3KjT2l+eK6OW4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:18:14 -0700
IronPort-SDR: lVvVO0m8CRLcn4UNAued3UWj4GqlKTB+cGQOBbAu3opbOHGzEGTUIXNUQQLYbWU6dzGhTCLKIO
 KcwpSWa1jDoikAm5b9HFdy4xIzZhNeGkiNqK61bU9ozH4zhvREFoyVO/adLkY5gzWwUtFZeqzT
 BfzYB1d0FuTJaNiFQYt5RPlt9CdFDhMPzrp9KB4HQG84r5yvDzlfVnE0aVTwfB2Qq0/3WzPT/s
 UDh/eHpgZbIWJI51+HV2M2oAeCHDnyPX+HhfKFwS0FddyUDvPi8yHoHJfRBzZkfb70PwNMpbop
 DMk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:54:22 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L212N5CX8z1SHwl
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 06:54:20 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709259; x=1655301260; bh=xnJmZYtrUHPz/1pW+2iKsxdcyh17EmGmxKC
        7iEmOkHc=; b=UUHn+1Vyu14CMfOaCMgXraCj/MTu6WqTYOUVrT+4PUwPlX5ziiU
        pSIvphH10gCc67fVq3XGywhvUeUqkqYl3C+JIeYNZL256XrllrM58UhqzOZaujF3
        cbmBklJPJrOqfUwuSurt8JpO1UwMmikJGH4hvh5Qwx4pN/E2XnvxaPmNybMpFT83
        xSpG9RchPPentNTApEt/m2/xRnaVgRJJKjnepi11fq5V05sUwhnpCcvU0f61+fwA
        S+fDCn+IEtVKy285CWS8em7niz60i9Y+TCt+uHgrHXnSyVIC4Q8Mw6/XAy+RhYGq
        bnKvHkQ9zRQTWYTH/DZejGfNQWFm7h+DJZQ==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jET3jrHtwWak for <linux-fsdevel@vger.kernel.org>;
        Mon, 16 May 2022 06:54:19 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L212D5R0Cz1Rvlc;
        Mon, 16 May 2022 06:54:12 -0700 (PDT)
Message-ID: <487c9368-36fe-25ec-7a76-f6aa50c4d3d5@opensource.wdc.com>
Date:   Mon, 16 May 2022 15:54:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 01/13] block: make blkdev_nr_zones and
 blk_queue_zone_no generic for npo2 zsze
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, axboe@kernel.dk,
        naohiro.aota@wdc.com, Johannes.Thumshirn@wdc.com,
        snitzer@kernel.org, dsterba@suse.com, jaegeuk@kernel.org,
        hch@lst.de
Cc:     linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        jonathan.derrick@linux.dev, bvanassche@acm.org,
        Keith Busch <kbusch@kernel.org>, gost.dev@samsung.com,
        linux-nvme@lists.infradead.org,
        Johannes Thumshirn <jth@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>,
        linux-block@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        matias.bjorling@wdc.com, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, dm-devel@redhat.com,
        jiangbo.365@bytedance.com, Chaitanya Kulkarni <kch@nvidia.com>,
        linux-fsdevel@vger.kernel.org, Chris Mason <clm@fb.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133924eucas1p1817f306e3f2442088bf49ab513657cbe@eucas1p1.samsung.com>
 <20220516133921.126925-2-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-2-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022/05/16 15:39, Pankaj Raghav wrote:
> Adapt blkdev_nr_zones and blk_queue_zone_no function so that it can
> also work for non-power-of-2 zone sizes.
> 
> As the existing deployments of zoned devices had power-of-2
> assumption, power-of-2 optimized calculation is kept for those devices.
> 
> There are no direct hot paths modified and the changes just
> introduce one new branch per call.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-zoned.c      | 13 ++++++++++---
>  include/linux/blkdev.h |  8 +++++++-
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 38cd840d8..140230134 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -111,16 +111,23 @@ EXPORT_SYMBOL_GPL(__blk_req_zone_write_unlock);
>   * blkdev_nr_zones - Get number of zones
>   * @disk:	Target gendisk
>   *
> - * Return the total number of zones of a zoned block device.  For a block
> - * device without zone capabilities, the number of zones is always 0.
> + * Return the total number of zones of a zoned block device, including the
> + * eventual small last zone if present. For a block device without zone
> + * capabilities, the number of zones is always 0.
>   */
>  unsigned int blkdev_nr_zones(struct gendisk *disk)
>  {
>  	sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
> +	sector_t capacity = get_capacity(disk);
>  
>  	if (!blk_queue_is_zoned(disk->queue))
>  		return 0;
> -	return (get_capacity(disk) + zone_sectors - 1) >> ilog2(zone_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return (capacity + zone_sectors - 1) >>
> +		       ilog2(zone_sectors);

Why the line break here ? This fits on one line, no ?

> +
> +	return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>  }
>  EXPORT_SYMBOL_GPL(blkdev_nr_zones);
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1b24c1fb3..22fe512ee 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -675,9 +675,15 @@ static inline unsigned int blk_queue_nr_zones(struct request_queue *q)
>  static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  					     sector_t sector)
>  {
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +
>  	if (!blk_queue_is_zoned(q))
>  		return 0;
> -	return sector >> ilog2(q->limits.chunk_sectors);
> +
> +	if (is_power_of_2(zone_sectors))
> +		return sector >> ilog2(zone_sectors);
> +
> +	return div64_u64(sector, zone_sectors);
>  }
>  
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,


-- 
Damien Le Moal
Western Digital Research
