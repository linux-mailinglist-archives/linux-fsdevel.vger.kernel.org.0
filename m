Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFAB510E5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356872AbiD0CC2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 22:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353190AbiD0CC1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 22:02:27 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC137175DF2
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651024757; x=1682560757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5s6rb7iS9ZQjJBwQh3UukXPumTzLR7t4Lra1wK50blY=;
  b=U6/VHG3Suap8S4ZyQjrE/2nXABAHXCt/XuWqKC9RNbPBavAOoD8uLMOE
   paolF8XzLrLxJ66DPNNUbl6LLUaKm/WyTJ8mRBmw12o7On+ZJVSgMpJA7
   XgxIgPdg3vmyWTkutF6qJ1pYWEa4y6zJJ5+tgt/Kx2rTS7mySMwdLpPnh
   1b10eGowfuhHcPKI8BF4oovdVQIYfHzYAmOeBdzojX5oVQs3YAoaEwrAO
   J5bgn8WSMSXFzHpatP1KtRbDKvtc/xIUUn8TV2KtihO0Fopz0nI4JaRhn
   bCMnmm6PzbDxj9osHATX1dxsmEccu4XLcMYyKjN97isZ8yWmNm3L/tLXO
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="310879653"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 09:59:15 +0800
IronPort-SDR: EeOYW8CEGL0b2DqlGPMp1XwKv89CCmlOSk0bKd5Uaspw9KCuYCGUzfvLHCwP7lZC/Ty4t83ySs
 zsHGdAdAg/mheVSCrWYU33S3jI62qeQFgsGBy5e+VveIxyjfTeuabCZntMRxrW35J5HHiTWEjV
 fchhqljGhbzdWDm5XEkN8VUi+WUDMaiqWuSzqQzkS78WQVLhiZ3MptR1VGGApQv9jRBQOnCuNg
 c+82e4/HRWPJnH3bzYgVd1DgJ7Geybx9dE8NBPtPohKDsW147jhS4n3AfHvd2ROvYk7DVQN+Dr
 zZvE/BysHrncUpIeMdpOBJMg
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:29:26 -0700
IronPort-SDR: Q0PyoyX+fJteWlgqCTipZ7PYwIwOJCjD9xU6fER7ARIg6rxGom96os6qubKYtxLs9hag31hxBi
 Gke6an8ZWqrNv92MyTffNGzGi4Y3HK02UqxLt/LaP59SMGjhX179DyKnrKghNzQ2kmBKRAOrwK
 VNvRCqeYzUCtfH3T3rrgOaW1E3NgfgtvmVE3keVEHaNAc6o27rBEgXU8bBPQtPRoLH2Wj7K1QU
 GF5JvmfAuWcVhsVet7g1NdZ/DhfELmkZYpc4rRLDurfck6crUwgPdi8FcqHwZYSTu8nsjR9mZB
 4ls=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Apr 2022 18:59:16 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kp2435FBlz1Rvlx
        for <linux-fsdevel@vger.kernel.org>; Tue, 26 Apr 2022 18:59:15 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651024752; x=1653616753; bh=5s6rb7iS9ZQjJBwQh3UukXPumTzLR7t4Lra
        1wK50blY=; b=Je/3F02ce0dAn1y76sJecKOAf4VwoFFrlY0zxmW/vT0xWymnAwk
        MTwA30WIbaDmAcO6AT62lwXUDMYEHzM2xx1P92po1qky0fr/5DqBm61a77IOfAOC
        JtIAt8/w7f7thjNvO0D258Tzk6W6zYsO7sZrlscfOGnvhfFHQQ8USXxhagvGmZh5
        D9KGpkgkhgJaXtz3KyrzBSukrU0orxL/39wNI5ItdX0ivBDFaxjMcz/ZOw1Ufa4S
        Oa1gBZd2vNrXSOUpetgKp5bDylySKHiDzPPHT9grTDNPh7JIjKntladx1VnGAqyr
        rflZyMR80ADFlszelRnCYl4F4u5poUu7b4Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id DSBitrhLWfU4 for <linux-fsdevel@vger.kernel.org>;
        Tue, 26 Apr 2022 18:59:12 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kp23p3D6Gz1Rvlc;
        Tue, 26 Apr 2022 18:59:02 -0700 (PDT)
Message-ID: <0d52ad34-ab75-9672-321f-34053421c0c4@opensource.wdc.com>
Date:   Wed, 27 Apr 2022 10:59:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4 01/10] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To:     Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Kanchan Joshi <joshi.k@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20220426101241.30100-1-nj.shetty@samsung.com>
 <CGME20220426101910epcas5p4fd64f83c6da9bbd891107d158a2743b5@epcas5p4.samsung.com>
 <20220426101241.30100-2-nj.shetty@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220426101241.30100-2-nj.shetty@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/26/22 19:12, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_hw_bytes (RO)
>         - copy_max_range_bytes (RW)
>         - copy_max_range_hw_bytes (RO)
>         - copy_max_nr_ranges (RW)
>         - copy_max_nr_ranges_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload, used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_range_bytes: maximum length in a single entry.
> copy_max_nr_ranges: maximum number of entries in a payload.
> copy_max_*_hw_*: Reflects the device supported maximum limits.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
> ---
>  Documentation/ABI/stable/sysfs-block |  83 ++++++++++++++++
>  block/blk-settings.c                 |  59 ++++++++++++
>  block/blk-sysfs.c                    | 138 +++++++++++++++++++++++++++
>  include/linux/blkdev.h               |  13 +++
>  4 files changed, 293 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index e8797cd09aff..65e64b5a0105 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -155,6 +155,89 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_offload
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] When read, this file shows whether offloading copy to
> +		device is enabled (1) or disabled (0). Writing '0' to this
> +		file will disable offloading copies for this device.
> +		Writing any '1' value will enable this feature.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] While 'copy_max_hw_bytes' is the hardware limit for the
> +		device, 'copy_max_bytes' setting is the software limit.
> +		Setting this value lower will make Linux issue smaller size
> +		copies.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_hw_bytes
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Devices that support offloading copy functionality may have
> +		internal limits on the number of bytes that can be offloaded
> +		in a single operation. The `copy_max_hw_bytes`
> +		parameter is set by the device driver to the maximum number of
> +		bytes that can be copied in a single operation. Copy
> +		requests issued to the device must not exceed this limit.
> +		A value of 0 means that the device does not
> +		support copy offload.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_nr_ranges
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] While 'copy_max_nr_ranges_hw' is the hardware limit for the
> +		device, 'copy_max_nr_ranges' setting is the software limit.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_nr_ranges_hw
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Devices that support offloading copy functionality may have
> +		internal limits on the number of ranges in single copy operation
> +		that can be offloaded in a single operation.
> +		A range is tuple of source, destination and length of data
> +		to be copied. The `copy_max_nr_ranges_hw` parameter is set by
> +		the device driver to the maximum number of ranges that can be
> +		copied in a single operation. Copy requests issued to the device
> +		must not exceed this limit. A value of 0 means that the device
> +		does not support copy offload.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_range_bytes
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] While 'copy_max_range_hw_bytes' is the hardware limit for
> +		the device, 'copy_max_range_bytes' setting is the software
> +		limit.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_range_hw_bytes
> +Date:		April 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Devices that support offloading copy functionality may have
> +		internal limits on the size of data, that can be copied in a
> +		single range within a single copy operation.
> +		A range is tuple of source, destination and length of data to be
> +		copied. The `copy_max_range_hw_bytes` parameter is set by the
> +		device driver to set the maximum length in bytes of a range
> +		that can be copied in an operation.
> +		Copy requests issued to the device must not exceed this limit.
> +		Sum of sizes of all ranges in a single opeartion should not
> +		exceed 'copy_max_hw_bytes'. A value of 0 means that the device
> +		does not support copy offload.
> +
> +
>  What:		/sys/block/<disk>/queue/crypto/
>  Date:		February 2022
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 6ccceb421ed2..70167aee3bf7 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -57,6 +57,12 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->misaligned = 0;
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
> +	lim->max_hw_copy_sectors = 0;

For readability, I would keep "hw" next to sectors/nr_ranges:

max_copy_hw_sectors
max_copy_sectors
max_copy_hw_nr_ranges
max_copy_nr_ranges
max_copy_range_hw_sectors
max_copy_range_sectors

> +	lim->max_copy_sectors = 0;
> +	lim->max_hw_copy_nr_ranges = 0;
> +	lim->max_copy_nr_ranges = 0;
> +	lim->max_hw_copy_range_sectors = 0;
> +	lim->max_copy_range_sectors = 0;
>  }
>  EXPORT_SYMBOL(blk_set_default_limits);
>  
> @@ -81,6 +87,12 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_hw_copy_sectors = ULONG_MAX;
> +	lim->max_copy_sectors = ULONG_MAX;
> +	lim->max_hw_copy_range_sectors = UINT_MAX;
> +	lim->max_copy_range_sectors = UINT_MAX;
> +	lim->max_hw_copy_nr_ranges = USHRT_MAX;
> +	lim->max_copy_nr_ranges = USHRT_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -177,6 +189,45 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_max_copy_sectors - set max sectors for a single copy payload
> + * @q:  the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + **/
> +void blk_queue_max_copy_sectors(struct request_queue *q,

This should be blk_queue_max_copy_hw_sectors().

> +		unsigned int max_copy_sectors)
> +{
> +	q->limits.max_hw_copy_sectors = max_copy_sectors;
> +	q->limits.max_copy_sectors = max_copy_sectors;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors);
> +
> +/**
> + * blk_queue_max_copy_range_sectors - set max sectors for a single range, in a copy payload
> + * @q:  the request queue for the device
> + * @max_copy_range_sectors: maximum number of sectors to copy in a single range
> + **/
> +void blk_queue_max_copy_range_sectors(struct request_queue *q,

And this should be blk_queue_max_copy_range_hw_sectors(). Etc for the
other ones below.

> +		unsigned int max_copy_range_sectors)
> +{
> +	q->limits.max_hw_copy_range_sectors = max_copy_range_sectors;
> +	q->limits.max_copy_range_sectors = max_copy_range_sectors;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_range_sectors);
> +
> +/**
> + * blk_queue_max_copy_nr_ranges - set max number of ranges, in a copy payload
> + * @q:  the request queue for the device
> + * @max_copy_nr_ranges: maximum number of ranges
> + **/
> +void blk_queue_max_copy_nr_ranges(struct request_queue *q,
> +		unsigned int max_copy_nr_ranges)
> +{
> +	q->limits.max_hw_copy_nr_ranges = max_copy_nr_ranges;
> +	q->limits.max_copy_nr_ranges = max_copy_nr_ranges;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_nr_ranges);
> +
>  /**
>   * blk_queue_max_secure_erase_sectors - set max sectors for a secure erase
>   * @q:  the request queue for the device
> @@ -572,6 +623,14 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
>  	t->max_segment_size = min_not_zero(t->max_segment_size,
>  					   b->max_segment_size);
>  
> +	t->max_copy_sectors = min(t->max_copy_sectors, b->max_copy_sectors);
> +	t->max_hw_copy_sectors = min(t->max_hw_copy_sectors, b->max_hw_copy_sectors);
> +	t->max_copy_range_sectors = min(t->max_copy_range_sectors, b->max_copy_range_sectors);
> +	t->max_hw_copy_range_sectors = min(t->max_hw_copy_range_sectors,
> +						b->max_hw_copy_range_sectors);
> +	t->max_copy_nr_ranges = min(t->max_copy_nr_ranges, b->max_copy_nr_ranges);
> +	t->max_hw_copy_nr_ranges = min(t->max_hw_copy_nr_ranges, b->max_hw_copy_nr_ranges);
> +
>  	t->misaligned |= b->misaligned;
>  
>  	alignment = queue_limit_alignment_offset(b, start);
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 88bd41d4cb59..bae987c10f7f 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -212,6 +212,129 @@ static ssize_t queue_discard_zeroes_data_show(struct request_queue *q, char *pag
>  	return queue_var_show(0, page);
>  }
>  
> +static ssize_t queue_copy_offload_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(blk_queue_copy(q), page);
> +}
> +
> +static ssize_t queue_copy_offload_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long copy_offload;
> +	ssize_t ret = queue_var_store(&copy_offload, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_offload && !q->limits.max_hw_copy_sectors)
> +		return -EINVAL;
> +
> +	if (copy_offload)
> +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> +	else
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> +
> +	return ret;
> +}
> +
> +static ssize_t queue_copy_max_hw_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n",
> +		(unsigned long long)q->limits.max_hw_copy_sectors << 9);
> +}
> +
> +static ssize_t queue_copy_max_show(struct request_queue *q, char *page> +{
> +	return sprintf(page, "%llu\n",
> +		(unsigned long long)q->limits.max_copy_sectors << 9);
> +}
> +
> +static ssize_t queue_copy_max_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long max_copy;
> +	ssize_t ret = queue_var_store(&max_copy, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;
> +
> +	max_copy >>= 9;
> +	if (max_copy > q->limits.max_hw_copy_sectors)
> +		max_copy = q->limits.max_hw_copy_sectors;
> +
> +	q->limits.max_copy_sectors = max_copy;
> +	return ret;
> +}
> +
> +static ssize_t queue_copy_range_max_hw_show(struct request_queue *q, char *page)
> +{
> +	return sprintf(page, "%llu\n",
> +		(unsigned long long)q->limits.max_hw_copy_range_sectors << 9);
> +}
> +
> +static ssize_t queue_copy_range_max_show(struct request_queue *q,
> +		char *page)
> +{
> +	return sprintf(page, "%llu\n",
> +		(unsigned long long)q->limits.max_copy_range_sectors << 9);
> +}
> +
> +static ssize_t queue_copy_range_max_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long max_copy;
> +	ssize_t ret = queue_var_store(&max_copy, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_copy & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;
> +
> +	max_copy >>= 9;
> +	if (max_copy > UINT_MAX)

On 32-bits arch, unsigned long and unsigned int are the same so this test
is useless for these arch. Better have max_copy declared as unsigned long
long.

> +		return -EINVAL;
> +
> +	if (max_copy > q->limits.max_hw_copy_range_sectors)
> +		max_copy = q->limits.max_hw_copy_range_sectors;
> +
> +	q->limits.max_copy_range_sectors = max_copy;
> +	return ret;
> +}
> +
> +static ssize_t queue_copy_nr_ranges_max_hw_show(struct request_queue *q, char *page)
> +{
> +	return queue_var_show(q->limits.max_hw_copy_nr_ranges, page);
> +}
> +
> +static ssize_t queue_copy_nr_ranges_max_show(struct request_queue *q,
> +		char *page)
> +{
> +	return queue_var_show(q->limits.max_copy_nr_ranges, page);
> +}
> +
> +static ssize_t queue_copy_nr_ranges_max_store(struct request_queue *q,
> +				       const char *page, size_t count)
> +{
> +	unsigned long max_nr;
> +	ssize_t ret = queue_var_store(&max_nr, page, count);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (max_nr > USHRT_MAX)
> +		return -EINVAL;
> +
> +	if (max_nr > q->limits.max_hw_copy_nr_ranges)
> +		max_nr = q->limits.max_hw_copy_nr_ranges;
> +
> +	q->limits.max_copy_nr_ranges = max_nr;
> +	return ret;
> +}
> +
>  static ssize_t queue_write_same_max_show(struct request_queue *q, char *page)
>  {
>  	return queue_var_show(0, page);
> @@ -596,6 +719,14 @@ QUEUE_RO_ENTRY(queue_nr_zones, "nr_zones");
>  QUEUE_RO_ENTRY(queue_max_open_zones, "max_open_zones");
>  QUEUE_RO_ENTRY(queue_max_active_zones, "max_active_zones");
>  
> +QUEUE_RW_ENTRY(queue_copy_offload, "copy_offload");
> +QUEUE_RO_ENTRY(queue_copy_max_hw, "copy_max_hw_bytes");
> +QUEUE_RW_ENTRY(queue_copy_max, "copy_max_bytes");
> +QUEUE_RO_ENTRY(queue_copy_range_max_hw, "copy_max_range_hw_bytes");
> +QUEUE_RW_ENTRY(queue_copy_range_max, "copy_max_range_bytes");
> +QUEUE_RO_ENTRY(queue_copy_nr_ranges_max_hw, "copy_max_nr_ranges_hw");
> +QUEUE_RW_ENTRY(queue_copy_nr_ranges_max, "copy_max_nr_ranges");
> +
>  QUEUE_RW_ENTRY(queue_nomerges, "nomerges");
>  QUEUE_RW_ENTRY(queue_rq_affinity, "rq_affinity");
>  QUEUE_RW_ENTRY(queue_poll, "io_poll");
> @@ -642,6 +773,13 @@ static struct attribute *queue_attrs[] = {
>  	&queue_discard_max_entry.attr,
>  	&queue_discard_max_hw_entry.attr,
>  	&queue_discard_zeroes_data_entry.attr,
> +	&queue_copy_offload_entry.attr,
> +	&queue_copy_max_hw_entry.attr,
> +	&queue_copy_max_entry.attr,
> +	&queue_copy_range_max_hw_entry.attr,
> +	&queue_copy_range_max_entry.attr,
> +	&queue_copy_nr_ranges_max_hw_entry.attr,
> +	&queue_copy_nr_ranges_max_entry.attr,
>  	&queue_write_same_max_entry.attr,
>  	&queue_write_zeroes_max_entry.attr,
>  	&queue_zone_append_max_entry.attr,
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1b24c1fb3bb1..3596fd37fae7 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -270,6 +270,13 @@ struct queue_limits {
>  	unsigned int		discard_alignment;
>  	unsigned int		zone_write_granularity;
>  
> +	unsigned long		max_hw_copy_sectors;
> +	unsigned long		max_copy_sectors;
> +	unsigned int		max_hw_copy_range_sectors;
> +	unsigned int		max_copy_range_sectors;
> +	unsigned short		max_hw_copy_nr_ranges;
> +	unsigned short		max_copy_nr_ranges;
> +
>  	unsigned short		max_segments;
>  	unsigned short		max_integrity_segments;
>  	unsigned short		max_discard_segments;
> @@ -574,6 +581,7 @@ struct request_queue {
>  #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
>  #define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
>  #define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
> +#define QUEUE_FLAG_COPY		30	/* supports copy offload */
>  
>  #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
>  				 (1 << QUEUE_FLAG_SAME_COMP) |		\
> @@ -596,6 +604,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
>  	test_bit(QUEUE_FLAG_STABLE_WRITES, &(q)->queue_flags)
>  #define blk_queue_io_stat(q)	test_bit(QUEUE_FLAG_IO_STAT, &(q)->queue_flags)
>  #define blk_queue_add_random(q)	test_bit(QUEUE_FLAG_ADD_RANDOM, &(q)->queue_flags)
> +#define blk_queue_copy(q)	test_bit(QUEUE_FLAG_COPY, &(q)->queue_flags)
>  #define blk_queue_zone_resetall(q)	\
>  	test_bit(QUEUE_FLAG_ZONE_RESETALL, &(q)->queue_flags)
>  #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
> @@ -960,6 +969,10 @@ extern void blk_queue_chunk_sectors(struct request_queue *, unsigned int);
>  extern void blk_queue_max_segments(struct request_queue *, unsigned short);
>  extern void blk_queue_max_discard_segments(struct request_queue *,
>  		unsigned short);
> +extern void blk_queue_max_copy_sectors(struct request_queue *q, unsigned int max_copy_sectors);
> +extern void blk_queue_max_copy_range_sectors(struct request_queue *q,
> +		unsigned int max_copy_range_sectors);
> +extern void blk_queue_max_copy_nr_ranges(struct request_queue *q, unsigned int max_copy_nr_ranges);
>  void blk_queue_max_secure_erase_sectors(struct request_queue *q,
>  		unsigned int max_sectors);
>  extern void blk_queue_max_segment_size(struct request_queue *, unsigned int);


-- 
Damien Le Moal
Western Digital Research
