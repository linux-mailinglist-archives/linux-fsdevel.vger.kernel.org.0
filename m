Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709F86CD4DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjC2Ik0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjC2IkU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:40:20 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709F2681
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680079218; x=1711615218;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3jSijsKBSV9BsEzQr1YnSfmWJK8g8o7ns6B3bjeHLM=;
  b=JmUawTmr5bxYpLBHpoJ8BhUf1pHhuRQS0CMFfOD/brL8AvtukEmsbetj
   xok4Q8kvrUOdEj/7VAieJk8AfmSYB+zEa6Hb3SDvx2VvhldPV5X13QpUW
   JJqlJD418YvSM8rXgweP0ilm3qW0Hl0sIOSQkpY1vgWac5Qe7/iYU5JGh
   v79toyBA69fUIxWP2G1PGRcEEXeB2+PkZrylmzHCAVzJWYk0irNbfmZPt
   ia0nEoODAYRV+t32UVW9+9m1955ZFQvwtAhnYJAghz/2TStiGjbPo9uI+
   77t8cmaevuALvuQvTYFedKwBINJydgSYf2ugwbvjUcg1TDTNXKaHdlqj7
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="338845252"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:40:17 +0800
IronPort-SDR: RHjG8ltiOM3+IKgbq5p7MxKiU6+LrHGSSBm5g0FVMk3sSInuMZJHelXMqqG3FwyDhadr5/Zwg5
 rf/BslKI82+dzORKA/CDr1iGGj4Tad8sTTLTcHRbf4VULUyKadeXFIckTBjbQBJpQ5TRT8oN8d
 GQdnus78iNcjmrMvRxlkHE5ZpMYAKJGIG4GpvJKpR6ulu6Lli+Hh2ieoFzYs2q/60y89/ID8IS
 NZqHHzMxsSmUgz3iF0IgZWDgAPBHSO0Upn9g1KBooanOUehdLUt8NVKP/lG2Beiknao4nvInzD
 040=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 00:56:26 -0700
IronPort-SDR: 82wvVbLHKlh15Qsw1h8Iz0ikWmZbJazVoY+PJ5v1ElC9vcr0KNiRGhf1HOltyGDRvKEWolEgSg
 jfT1LjzjOouv0DtSGbFzhKjkf4j2Y6ERlIytGfWdN3YAYB+0vasiq13gU+U4EisFE4yVEUm99D
 DzIXCG5BgQm+HQytpFncHEB6mAPvNBTaSIT1eXQtyv/62BULXSQ13uL+3mZr5Sce9LhIaZ1YpX
 9OOPhW+YyS5A1va9KNFDxOiVSMo2K2FzMoHojwBdYWu2SvZ+KxElpxgZFdGTZ+y2GVU8AUJLLh
 8R8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:40:17 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmg3h3NsVz1RtVv
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:40:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1680079215; x=1682671216; bh=E3jSijsKBSV9BsEzQr1YnSfmWJK8g8o7ns6
        B3bjeHLM=; b=ubojnNRZtniIG4drMxCxpbcUUntc7UVjcuyQDdJq4Y4sJ6P2Jk/
        k8QBkYTtobxjovRwL97Pc69e6lGQwgirLIzioWiy2p3Jz0SYjirs9SQdmSZHzT3K
        /3WMbS6vpWd0887PymxQxyApYp547FWCtFhI6IrU/eOBmbIshIEHOboKDZw7gfQh
        Ftpa4pU/OykstUUR3CAiBB0z+McsaAyRd+hHSFrn4tfUWLYa+IzL93WL2z1O03Pk
        3fMfw8iQf8a88VcuSMAwxMB5p9+NQ2opoKmgeM3osaeh4u18V8DelxYQ26HlS76K
        V967+/rtR1Zczx+Gp7Dk/OcQkfIfDxL09sw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wtMN8kEsHUrj for <linux-fsdevel@vger.kernel.org>;
        Wed, 29 Mar 2023 01:40:15 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmg3Z3bThz1RtVm;
        Wed, 29 Mar 2023 01:40:10 -0700 (PDT)
Message-ID: <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
Date:   Wed, 29 Mar 2023 17:40:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
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
 <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
 <20230327084103.21601-2-anuj20.g@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-2-anuj20.g@samsung.com>
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
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_bytes_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload: used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_bytes_hw: Reflects the device supported maximum limit.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 36 ++++++++++++++++
>  block/blk-settings.c                 | 24 +++++++++++
>  block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
>  include/linux/blkdev.h               | 12 ++++++
>  include/uapi/linux/fs.h              |  3 ++
>  5 files changed, 139 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index c57e5b7cb532..f5c56ad91ad6 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -155,6 +155,42 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_offload
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] When read, this file shows whether offloading copy to
> +		device is enabled (1) or disabled (0). Writing '0' to this

...to a device...

> +		file will disable offloading copies for this device.
> +		Writing any '1' value will enable this feature. If device

If the device does...

> +		does not support offloading, then writing 1, will result in
> +		error.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
> +		device, 'copy_max_bytes' setting is the software limit.
> +		Setting this value lower will make Linux issue smaller size
> +		copies from block layer.

		This is the maximum number of bytes that the block
                layer will allow for a copy request. Must be smaller than
                or equal to the maximum size allowed by the hardware indicated
		by copy_max_bytes_hw. Write 0 to use the default kernel
		settings.

> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Devices that support offloading copy functionality may have
> +		internal limits on the number of bytes that can be offloaded
> +		in a single operation. The `copy_max_bytes_hw`
> +		parameter is set by the device driver to the maximum number of
> +		bytes that can be copied in a single operation. Copy
> +		requests issued to the device must not exceed this limit.
> +		A value of 0 means that the device does not
> +		support copy offload.

		[RO] This is the maximum number of kilobytes supported in a
                single data copy offload operation. A value of 0 means that the
		device does not support copy offload.

> +
> +
>  What:		/sys/block/<disk>/queue/crypto/
>  Date:		February 2022
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..350f3584f691 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->max_copy_sectors_hw = 0;
> +	lim->max_copy_sectors = 0;
>  }
>  
>  /**
> @@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_copy_sectors_hw = ULONG_MAX;
> +	lim->max_copy_sectors = ULONG_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_max_copy_sectors_hw - set max sectors for a single copy payload
> + * @q:  the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + **/
> +void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> +		unsigned int max_copy_sectors)
> +{
> +	if (max_copy_sectors >= MAX_COPY_TOTAL_LENGTH)

Confusing name as LENGTH may be interpreted as bytes. MAX_COPY_SECTORS would be
better.

> +		max_copy_sectors = MAX_COPY_TOTAL_LENGTH;
> +
> +	q->limits.max_copy_sectors_hw = max_copy_sectors;
> +	q->limits.max_copy_sectors = max_copy_sectors;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);


-- 
Damien Le Moal
Western Digital Research

