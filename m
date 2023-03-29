Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F0D6CD5BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 11:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjC2JBn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjC2JBW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:01:22 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F88940E7
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 02:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680080454; x=1711616454;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mpI+Cy2tgI3Sd1AkHMVOE9U08MyGWDToEs92pFOGeZg=;
  b=So/cSDehp2JHC0sHQSMjNEphHRIEHy3kLvZkYob8Qoo5xwbQN6qvg43f
   hc9DEJH5t3wnO+pGbFXqy4RXrf9nbKffrfHvIA5H7diGIEMhS3iOAsKji
   /bdXxSYVPFjVV3XQWp9iXTVoIIg8GBWTwJh+Tr4zc0Hja3VFU8aYWig7J
   4FCv1Tj5asV2ZZU8R3mV9aGT8W0FS7utBNoiz+ryr4u4UdfR/awaIuqmP
   XY8xSATGEOMLOX7HR7zv5jGmOyYP7DapErxNOl+UVUrFtP7NworVCnp31
   Hq9yWN/aqKqLr1GddcBM0pIGfVStjj7U/ukvEC87oXuswVNCi35rEb3F0
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="338846436"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:59:57 +0800
IronPort-SDR: DF1ufDGW6x8HP6/8j4FXJKM2OgwvKNzd7z/I61fljmgt7DtzuHfiwp67e2cirTOcQH/ZCC2AJ7
 Q47WVpIkNYLYd5iSyQ7NNZ/4g6D31NLrIZiHPQBF1cf91NUuaVv818izWa4L+SRzVQMNgvy2OW
 FJOG/23hgguOKMMe1VGNm8SFzXr21X7LJO1ZsXEQEeRrNW8oUiKaN5UDDcbFzxG/gGmf0LVPaz
 /4VvsIfovDPWPWnCXMByLfYaC9NF67jWIqfW9xRAcdIoL9izP8e/dpJK6u/IO+NzpkRhHXtAcO
 WXQ=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:10:26 -0700
IronPort-SDR: 2msjZws8qvYyO9tZvY9518pLCd6G3fwCtKczGxKn/Ymd0XXCj6vx3XIi8uQ3A55i6Fp44dxxht
 zi7rQXmY7ZhcPKuzopkDb1gYrONPbnkRFc5F/biB6qB5hxolEGDy6qxdEwKj3KvJNsNtuogkZP
 fb0U6Ay9CMGjhq+rXsCsgvSTnmFQtL6wj5KBYvGbRWFPl2fqd3y+MdEZzRsIDIjinCjd4fyTLG
 agPYtBqlKTLbq3faNhGrbz+PvCh4aPBllTHYfNWaL4CS6uqfT/ULFIoZRDoX9BMgAj+Bix6XtM
 F6s=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:59:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4PmgVN6hyjz1RtVt
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:59:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680080395; x=1682672396; bh=mpI+Cy2tgI3Sd1AkHMVOE9U08MyGWDToEs9
        2pFOGeZg=; b=jcA6R8w0f8nggQrY15fdmioM4vd6K9ucvDPviggTbMcc5D+R+mz
        WxRE9kc+NB8WJ7XesRJdqSiZ7EEFQS6D8YVbMqCH7eYRq1KJmFV5g349K2+kGFG2
        sxEJol007A2MSQjSeUe5TU415ipKxEx4E3vHyRiRvtWF308X3dbIrFN55Epe2pH3
        sqLRzfNySW0Z6t6IcWt5hKhFmLfCevlB38k6ltXlF0A4xVQJ/poKNgtyXJh1BruG
        9pa9V6zHfPcX5kLwDWjOZkbyJ9nQTy8E5zz4Y8bEDiK7kdIdplZE1XoF3dTAI8re
        HqtBDKUrT5zHIF28yATUjlPVexijyfWNEig==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id apTUip-YAHxH for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 01:59:55 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4PmgVH0M2xz1RtVm;
        Wed, 29 Mar 2023 01:59:50 -0700 (PDT)
Message-ID: <3b9adeb6-4295-6e6a-9e93-7c5a06441830@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 17:59:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 7/9] dm: Add support for copy offload.
Content-Language: en-US
To:     Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084312epcas5p377810b172aa6048519591518f8c308d0@epcas5p3.samsung.com>
 <20230327084103.21601-8-anuj20.g@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-8-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/27/23 17:40, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 

Drop the period at the end of the patch title.

> Before enabling copy for dm target, check if underlying devices and
> dm target support copy. Avoid split happening inside dm target.
> Fail early if the request needs split, currently splitting copy
> request is not supported.
> 
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> ---
>  drivers/md/dm-table.c         | 42 +++++++++++++++++++++++++++++++++++
>  drivers/md/dm.c               |  7 ++++++
>  include/linux/device-mapper.h |  5 +++++
>  3 files changed, 54 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 7899f5fb4c13..45e894b9e3be 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -1863,6 +1863,39 @@ static bool dm_table_supports_nowait(struct dm_table *t)
>  	return true;
>  }
>  
> +static int device_not_copy_capable(struct dm_target *ti, struct dm_dev *dev,
> +				      sector_t start, sector_t len, void *data)
> +{
> +	struct request_queue *q = bdev_get_queue(dev->bdev);
> +
> +	return !blk_queue_copy(q);
> +}
> +
> +static bool dm_table_supports_copy(struct dm_table *t)
> +{
> +	struct dm_target *ti;
> +	unsigned int i;
> +
> +	for (i = 0; i < t->num_targets; i++) {
> +		ti = dm_table_get_target(t, i);
> +
> +		if (!ti->copy_offload_supported)
> +			return false;
> +
> +		/*
> +		 * target provides copy support (as implied by setting
> +		 * 'copy_offload_supported')
> +		 * and it relies on _all_ data devices having copy support.
> +		 */
> +		if (!ti->type->iterate_devices ||
> +		     ti->type->iterate_devices(ti,
> +			     device_not_copy_capable, NULL))
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>  static int device_not_discard_capable(struct dm_target *ti, struct dm_dev *dev,
>  				      sector_t start, sector_t len, void *data)
>  {
> @@ -1945,6 +1978,15 @@ int dm_table_set_restrictions(struct dm_table *t, struct request_queue *q,
>  		q->limits.discard_misaligned = 0;
>  	}
>  
> +	if (!dm_table_supports_copy(t)) {
> +		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
> +		/* Must also clear copy limits... */

Not a useful comment. The code is clear.

> +		q->limits.max_copy_sectors = 0;
> +		q->limits.max_copy_sectors_hw = 0;
> +	} else {
> +		blk_queue_flag_set(QUEUE_FLAG_COPY, q);
> +	}
> +
>  	if (!dm_table_supports_secure_erase(t))
>  		q->limits.max_secure_erase_sectors = 0;
>  
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 2d0f934ba6e6..08ec51000af8 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1693,6 +1693,13 @@ static blk_status_t __split_and_process_bio(struct clone_info *ci)
>  	if (unlikely(ci->is_abnormal_io))
>  		return __process_abnormal_io(ci, ti);
>  
> +	if ((unlikely(op_is_copy(ci->bio->bi_opf)) &&
> +			max_io_len(ti, ci->sector) < ci->sector_count)) {
> +		DMERR("Error, IO size(%u) > max target size(%llu)\n",
> +			ci->sector_count, max_io_len(ti, ci->sector));
> +		return BLK_STS_IOERR;
> +	}
> +
>  	/*
>  	 * Only support bio polling for normal IO, and the target io is
>  	 * exactly inside the dm_io instance (verified in dm_poll_dm_io)
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 7975483816e4..44969a20295e 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -380,6 +380,11 @@ struct dm_target {
>  	 * bio_set_dev(). NOTE: ideally a target should _not_ need this.
>  	 */
>  	bool needs_bio_set_dev:1;
> +
> +	/*
> +	 * copy offload is supported
> +	 */
> +	bool copy_offload_supported:1;
>  };
>  
>  void *dm_per_bio_data(struct bio *bio, size_t data_size);

-- 
Damien Le Moal
Western Digital Research

