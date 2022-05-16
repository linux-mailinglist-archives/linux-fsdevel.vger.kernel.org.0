Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF93528637
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 16:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbiEPOBS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 10:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243917AbiEPOAx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 10:00:53 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F319FFF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 07:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652709652; x=1684245652;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bpKOdUAAE3c6nvdpBu7z/5CbYlPeXQknBERi9/T0QUU=;
  b=kxvdTOSDTGszFTUG611kRhZnMqrS28TMhSHBFfk3TNCg6nPMWBRa16Xm
   OjLyVoB9F3ho66MKkHx4iKxvjHdL7/dxz4Ab4McTDJBgkJoJgVE67UnCN
   wIOBXWXcO31FCJtO3qFYN8blY26l2LvksmTViv1hk6KAr0mm85F+eMPLP
   aDori6LBPtAde1Nwl3JY1/8FiXVszD/2/IMrclyPtsg9rROpRxIFNViCb
   F/Igvh+ZPP674W0vgLCkxd2HQvQ/dGjGffEkGz1LwXgnGT+8+EFEjzpDW
   q+pmDvdG/wKvau+WY5snLSezpcbzxq6OhDia/PD3Ex7+YUnYP163jzxZG
   A==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647273600"; 
   d="scan'208";a="199259932"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 22:00:52 +0800
IronPort-SDR: Utcdp+L1op4zbbrH8FwoxxOATCqriMrIL2fUa5BKmxGZdXfFdTSZM0pcMThbEKX5wsQrj5KPyq
 N8Yb6nEPObaZ7qX7wpwQQ8hvVB4LBOUh2wDbrK8Kwmj7Ila/zSSzRE/t7+sduJcQNYY5bgIBYR
 LyVeWtOZobO07qh4HaK2E/RIVNvij64AFjD2CD6mz9WKyUGFcpvN8vaNkhIoPGh3RgGLN+Gdrr
 vMPseV2aHjXsxNDlv/yXyHyA8lNuZXbTnzKubSF6wxPBtXVXIsTHgW0CLmzzoeW6xJbXwb2BYp
 sM6IuTqLVH0VtLParFWJiZGN
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 06:24:40 -0700
IronPort-SDR: bExTuu6aG0WjffDd4yQRcAH8o7Y8k221wEYyln7skJbbH+8fG1aICG8l/Jas0ucJ7R4afoom16
 O0O1AlO31ch3H9FsGKJk82ZdhCQs5osiFKqRK6yA6DFMWnrMlnG2544f6BqOAUmiyewJ+eoNiH
 vqqINnbX7pTHOuEhZ7ENFl3veGIFUlipFiiSFHfqhbdZnlCCkzBwX+u4ye5o9W6ddTXggPwGnA
 txonFYbPLFSeg+Br0yJKaPvEO7AkA/fu3kNloLysc1KywMseVJzBFX34YpnFOXZ9fwL8VdzJoI
 iSE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 May 2022 07:00:47 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L219p5JcGz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 07:00:46 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1652709645; x=1655301646; bh=bpKOdUAAE3c6nvdpBu7z/5CbYlPeXQknBER
        i9/T0QUU=; b=uiOrY2snzuNAl371CEb9NgMbWjBySwM7XDAu7Vgrekyt1DLH2Su
        f6Fx7yFy5od5nVQ1DHczENceuzc1elmxQQcVPyj2Elf6igwz1xC4/S/z3BNZCLwc
        /SFqan9xu+Y33XyOyh+kv3xQ4e2LTBHu597+jbZNfXyiorHBFhScPkDua9QOvfzF
        4/5jYk0JLuk0DIZbc8zqWiVEWzmwUjfz1y6T8xueLgQRiEh50mv08ZnT/SYxWkCC
        4mNqF5J9jvNhJUdNFJR2sAs9MgOJnHBCqgzAvXX/a1nFnWuq3Hwz7mEYCbTBvptN
        cdBVkaPB7zuMSyVAhg12rwkQtbWNFg9/YBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7y9rjiV-8iXx for <linux-fsdevel@vger.kernel.org>;
        Mon, 16 May 2022 07:00:45 -0700 (PDT)
Received: from [10.225.1.43] (unknown [10.225.1.43])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L219d6jhvz1Rvlc;
        Mon, 16 May 2022 07:00:37 -0700 (PDT)
Message-ID: <d2fd2554-19c3-6ca3-6175-b8e8563986a5@opensource.wdc.com>
Date:   Mon, 16 May 2022 16:00:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v4 02/13] block: allow blk-zoned devices to have
 non-power-of-2 zone size
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
        Luis Chamberlain <mcgrof@kernel.org>
References: <20220516133921.126925-1-p.raghav@samsung.com>
 <CGME20220516133925eucas1p1414fab2cfa7da1d6258315cbd33e1685@eucas1p1.samsung.com>
 <20220516133921.126925-3-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220516133921.126925-3-p.raghav@samsung.com>
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
> Checking if a given sector is aligned to a zone is a common
> operation that is performed for zoned devices. Add
> blk_queue_is_zone_start helper to check for this instead of opencoding it
> everywhere.
> 
> Convert the calculations on zone size to be generic instead of relying on
> power_of_2 based logic in the block layer using the helpers wherever
> possible.
> 
> The only hot path affected by this change for power_of_2 zoned devices
> is in blk_check_zone_append() but blk_queue_is_zone_start() helper is
> used to optimize the calculation for po2 zone sizes. Note that the append
> path cannot be accessed by direct raw access to the block device but only
> through a filesystem abstraction.
> 
> Finally, allow non power of 2 zoned devices provided that their zone
> capacity and zone size are equal. The main motivation to allow non
> power_of_2 zoned device is to remove the unmapped LBA between zcap and
> zsze for devices that cannot have a power_of_2 zcap.
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-core.c       |  3 +--
>  block/blk-zoned.c      | 27 +++++++++++++++++++++------
>  include/linux/blkdev.h | 22 ++++++++++++++++++++++
>  3 files changed, 44 insertions(+), 8 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index f305cb66c..b7051b7ea 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -634,8 +634,7 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> -	    !blk_queue_zone_is_seq(q, pos))
> +	if (!blk_queue_is_zone_start(q, pos) || !blk_queue_zone_is_seq(q, pos))
>  		return BLK_STS_IOERR;
>  
>  	/*
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 140230134..cfc2fb804 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -289,10 +289,10 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  		return -EINVAL;
>  
>  	/* Check alignment (handle eventual smaller last zone) */
> -	if (sector & (zone_sectors - 1))
> +	if (!blk_queue_is_zone_start(q, sector))
>  		return -EINVAL;
>  
> -	if ((nr_sectors & (zone_sectors - 1)) && end_sector != capacity)
> +	if (!blk_queue_is_zone_start(q, nr_sectors) && end_sector != capacity)
>  		return -EINVAL;
>  
>  	/*
> @@ -490,14 +490,29 @@ static int blk_revalidate_zone_cb(struct blk_zone *zone, unsigned int idx,
>  	 * smaller last zone.
>  	 */
>  	if (zone->start == 0) {
> -		if (zone->len == 0 || !is_power_of_2(zone->len)) {
> -			pr_warn("%s: Invalid zoned device with non power of two zone size (%llu)\n",
> -				disk->disk_name, zone->len);
> +		if (zone->len == 0) {
> +			pr_warn("%s: Invalid zone size",
> +				disk->disk_name);

This fits on one line, no ?

> +			return -ENODEV;
> +		}
> +
> +		/*
> +		 * Don't allow zoned device with non power_of_2 zone size with
> +		 * zone capacity less than zone size.
> +		 */
> +		if (!is_power_of_2(zone->len) &&
> +		    zone->capacity < zone->len) {
> +			pr_warn("%s: Invalid zoned size with non power of 2 zone size and zone capacity < zone size",
> +				disk->disk_name);

Very long... What about:

pr_warn("%s: Invalid zone capacity for non power of 2 zone size",
	disk->disk_name);

>  			return -ENODEV;
>  		}
>  
>  		args->zone_sectors = zone->len;
> -		args->nr_zones = (capacity + zone->len - 1) >> ilog2(zone->len);
> +		/*
> +		 * Division is used to calculate nr_zones for both power_of_2
> +		 * and non power_of_2 zone sizes as it is not in the hot path.
> +		 */

This comment is not very useful.

> +		args->nr_zones = div64_u64(capacity + zone->len - 1, zone->len);
>  	} else if (zone->start + args->zone_sectors < capacity) {
>  		if (zone->len != args->zone_sectors) {
>  			pr_warn("%s: Invalid zoned device with non constant zone size\n",
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 22fe512ee..32d7bd7b1 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -686,6 +686,22 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  	return div64_u64(sector, zone_sectors);
>  }
>  
> +static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
> +{
> +	sector_t zone_sectors = blk_queue_zone_sectors(q);
> +	u64 remainder = 0;
> +
> +	if (!blk_queue_is_zoned(q))
> +		return false;
> +
> +	if (is_power_of_2(zone_sectors))
> +		return IS_ALIGNED(sec, zone_sectors);
> +
> +	div64_u64_rem(sec, zone_sectors, &remainder);
> +	/* if there is a remainder, then the sector is not aligned */

Hmmm... Fairly obvious. Not sure this comment is useful.

> +	return remainder == 0;
> +}
> +
>  static inline bool blk_queue_zone_is_seq(struct request_queue *q,
>  					 sector_t sector)
>  {
> @@ -732,6 +748,12 @@ static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>  {
>  	return 0;
>  }
> +
> +static inline bool blk_queue_is_zone_start(struct request_queue *q, sector_t sec)
> +{
> +	return false;
> +}
> +
>  static inline unsigned int queue_max_open_zones(const struct request_queue *q)
>  {
>  	return 0;


-- 
Damien Le Moal
Western Digital Research
