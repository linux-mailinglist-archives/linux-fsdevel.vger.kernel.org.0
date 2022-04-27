Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDD75127AA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 01:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiD0XqF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 19:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiD0XqD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 19:46:03 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355C56213C
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651102971; x=1682638971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQc3b82khE=;
  b=J4H1yJftl+l3nNwh+olieyj9MCm68i3O9p8GFeKnCEU3DMO9YsmGEaRN
   FKpe/NgjVcSNRFSbzRpz7h05N3eCxGU4XCWRWuER3Yzq9Y5NxIJre7q28
   h4NVS15cexh7XsLh8DsFE716jL04XCHkP+sgZLxA3817nrcKpfIXFWwPC
   FlXqgAWOZAVa4xQOi6KUXbfEEpDVUa7Wu9x2pcKe6v0dBJuf9MmuUifjl
   YIXHYPyydWSrPkUPtg28d/1WsTzLKlixtsq0Xlgo2dRdxxfu/HFRH1AEu
   W3U/V6J7wKPWUeGB5N55MVv+oUl/JBPjvX9uCBhNehle811Xo+n5GbJEt
   g==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="197844595"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 07:42:49 +0800
IronPort-SDR: oYr3BdZHetGXUW8aGQ7lZPjmht+rIXI7MqYOlEdWTU7Jd3Rmwx0vgc2+gL2pyuHZLjRR9CWHcu
 7PNnIrVKbeAAPwnbqgAGLXHeb/X/UUmISZw/axGkLMMi8RI5+6K0M7DZKfBY699m9KD+GINP49
 XgvKMEOsS2QS/Ib9FDxZW+zWtgJDBNuU9or6N1k2FW+qOEsLzkrYs8DdgpglQsTTwXxEVxAiwg
 uEif2qGQmMV9WwVxRvyEw6L2khwCCGomD4nMWPGoMrKdBQTPETUHtFOKS/yLfiU7b26elStprG
 c8fVwvKacdO8eYR57kW/TZhv
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:13:41 -0700
IronPort-SDR: UQjHjEcoP+LXBLYtAJd6Z0fJFf1jy60ZZVr5gbqOxIKjKdIhbkUoBiWAZDCWdyAMFuVtsayF0T
 5Q8I0dajsI0Gup6eQb9tJCtaCeAM8mfnZE9+66EYQxfR0JXA03n/Zf0VCl44P5/4kJN0YRYFgA
 PnLRbk1olOkop0iAF7e6YVKZjfP17aJyNnKCf5Nv1ffoJe7xcow5jzl3uAZZaF4oVq9ykqBi8Y
 eoazCF0NJNXg8KolPG0XO2CKsn9+IXiLn+B2l7lFRK/tGmy+0CSpyQOYs8a49wWZu/2YL+F1s5
 xIc=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Apr 2022 16:42:50 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kpb091Qncz1SVp3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 16:42:49 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1651102968; x=1653694969; bh=b4PQ+YojFt/Da7JedNLqXswRcZ1DtIMcbUQ
        c3b82khE=; b=aG9U+mpCYTqXLYVrB1nXg30+hvfUJ189J7XQSSmBmeZkvjsxkwu
        zAaurumWJ7fm9SJv5J2FbjspgmG5JAqDow1JiX6iGFfC9Of0kykaaFX4ZDKBNjn7
        c1vaCSsv8uCxbA0qKU1vQr7sjo2GKuQXZlvDLVoxWtDsD0Z1sjM+p8Nwc0CEll4E
        D6XCio2WwJ24l1FBaPYbvh0rG1180xMBAGWn41A2ZxbXvt8f3tjQGcCajxa+bHT1
        FmppUurtfeoO8TjI45cH5MPXNN7fFivo3PY5cobe5YbA6m03HnTor8+NQEiSRl8I
        0/HpjutNT+lHDztsGZq4Q/AuoqjjlZcpVwA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rlgXTPXMfwuJ for <linux-fsdevel@vger.kernel.org>;
        Wed, 27 Apr 2022 16:42:48 -0700 (PDT)
Received: from [10.225.163.27] (unknown [10.225.163.27])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kpb025hPwz1Rvlc;
        Wed, 27 Apr 2022 16:42:42 -0700 (PDT)
Message-ID: <2ffc46c7-945f-ba26-90db-737fccd74fdf@opensource.wdc.com>
Date:   Thu, 28 Apr 2022 08:42:41 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 16/16] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org,
        axboe@kernel.dk, snitzer@kernel.org, hch@lst.de, mcgrof@kernel.org,
        naohiro.aota@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        johannes.thumshirn@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        clm@fb.com, gost.dev@samsung.com, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, josef@toxicpanda.com,
        jonathan.derrick@linux.dev, agk@redhat.com, kbusch@kernel.org,
        kch@nvidia.com, linux-nvme@lists.infradead.org,
        dm-devel@redhat.com, bvanassche@acm.org, jiangbo.365@bytedance.com,
        linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
        linux-block@vger.kernel.org
References: <20220427160255.300418-1-p.raghav@samsung.com>
 <CGME20220427160313eucas1p1feecf74ec15c8c3d9250444710fd1676@eucas1p1.samsung.com>
 <20220427160255.300418-17-p.raghav@samsung.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220427160255.300418-17-p.raghav@samsung.com>
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

On 4/28/22 01:02, Pankaj Raghav wrote:
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 57daa86c19cf..221e0aa0f1a7 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;
> +	}

Why ?

See my previous email about still allowing ZC < ZS for non power of 2 zone
size drives. dm-zoned can easily support non power of 2 zone size as long
as ZC == ZS for all zones.

The problem with dm-zoned is ZC < ZS *AND* potentially variable ZC per
zone. That cannot be supported easily (still not impossible, but
definitely a lot more complex).

>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research
