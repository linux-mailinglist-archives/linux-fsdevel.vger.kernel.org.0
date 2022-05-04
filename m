Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C355199EC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 May 2022 10:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346510AbiEDIjH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 May 2022 04:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346458AbiEDIiu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 May 2022 04:38:50 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491BF2494C
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 01:35:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220504083509euoutp0112768e8c1100aeb0b3cb38c451aba164~r2e8u1SRV2986429864euoutp01K
        for <linux-fsdevel@vger.kernel.org>; Wed,  4 May 2022 08:35:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220504083509euoutp0112768e8c1100aeb0b3cb38c451aba164~r2e8u1SRV2986429864euoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651653309;
        bh=dRT7i+B2Yov3mR9oGnGvAueqIkGXxxHVKRrgzcNI3cU=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=dK2hgskREF92TYEpkqKsDjmkEjYwPK7wzzP1oiVva6bhCt79G74yWIFfuFfHSrERf
         fdgw42C1GDIKRj1T8l+6mqOTjxQ64hGvvb5aOLVawjptknwzmOiEqKcAN68byJrlMZ
         1QYABbNq2ARnlq98jANcweeMCqJlFE72UlInrMxU=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220504083509eucas1p1bf302755e2c37837eba93e0b599d169b~r2e8Q2IW10045900459eucas1p1g;
        Wed,  4 May 2022 08:35:09 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.F1.10260.DBA32726; Wed,  4
        May 2022 09:35:09 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220504083508eucas1p2b13cd91f8b71fcf1a929d098c710ed9e~r2e7a28PG0925109251eucas1p2Z;
        Wed,  4 May 2022 08:35:08 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220504083508eusmtrp1cf71a20db9e2f38cdbb8f13ea104ef26~r2e7ZXh5Y3254032540eusmtrp1W;
        Wed,  4 May 2022 08:35:08 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-a9-62723abdce8d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id B3.74.09404.CBA32726; Wed,  4
        May 2022 09:35:08 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220504083508eusmtip2e7e8bbafdd96bdd30b9c5ab3df5cab58~r2e7M-lMY2662026620eusmtip2R;
        Wed,  4 May 2022 08:35:08 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 4 May 2022 09:35:05 +0100
Message-ID: <a55665f1-26ae-c19f-5e2e-cf733e8f7fef@samsung.com>
Date:   Wed, 4 May 2022 10:35:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 01/16] block: make blkdev_nr_zones and blk_queue_zone_no
 generic for npo2 zsze
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, <jaegeuk@kernel.org>,
        <axboe@kernel.dk>, <snitzer@kernel.org>, <hch@lst.de>,
        <mcgrof@kernel.org>, <naohiro.aota@wdc.com>, <sagi@grimberg.me>,
        <damien.lemoal@opensource.wdc.com>, <dsterba@suse.com>,
        <johannes.thumshirn@wdc.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
        <clm@fb.com>, <gost.dev@samsung.com>, <chao@kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>, <josef@toxicpanda.com>,
        <jonathan.derrick@linux.dev>, <agk@redhat.com>,
        <kbusch@kernel.org>, <kch@nvidia.com>,
        <linux-nvme@lists.infradead.org>, <dm-devel@redhat.com>,
        <jiangbo.365@bytedance.com>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CTdRzm+77v3r0swZch8Y15dAf5RxoYRd330kxOjff6ddbxR5d3wYA3
        4IBJGwuVQ0b80CHKZE5lWDOxRKyWwLYAh7ZwDDYcASOaSnGCFsmAQwgaSIwXO/57Ps/nee77
        PJ/7UrjQQIZRGZJcVioRZ0WQAsJonXdGmV+TJr/4s5pA+i4rjq7crSTR6cl5HNk13RiqqjzL
        R95uJ47Mnhoe6pkrwtDlKzcxNKLX4qjixiSBFsuHlrmSYRwtDMegKssAQKMuLYbM7i2o914d
        H/VeiEfXzJ0E6ms5RyLdN6N8pCqbwdGgahSgkx2NPPT93xMEsrlFO0VMX//bzGPbtyRzstjD
        Z5xDVwmmr1vONNQrSeYrhQZnGi8WMq3npzGm9TcFyRwv9pBMc+nvPGaizUUy+iYXwagar/KY
        6YbwvUEfCbanslkZn7HSrTuSBOl3R+7gOT3rD7g09XwF+CKgHPhTkI6F+ul2ohwIKCFdB+B4
        9zWSGx4BOHuujc8N0wBe/vIh/4nFNKDGuMUlAO3tJt7/qt4/P1+1tAA4o3GQPksAvQM6um6v
        YIJ+DnYcO4NzfBDsrB4hfDiE/hCe1vr0FBVMp0K3Lc5H43QodI/oVl7bQJ/CoFl1D/cNON2D
        w6VHg3yfgaQ3wyLlSjx/ehusnKgmOfPzsNTk5XP4WVhsqMG5CpFQPdiPcbgAfmd1rISG9B8C
        qFjUrop2Q/vxrlUcDMc6mlb7b4R2dQXB4Xw4OujFOXMJgJXN+pUGcDnFCUcWp4mDinbDKh0I
        B8eDuDyBsMp4BleBTdo1p9Cu6axdU0G7psJ5QNSDUFYuy05jZS9L2LxomThbJpekRafsz24A
        yz/b/rhj5kdQNzYVbQEYBSwAUnjEhoBdX+ckCwNSxQcPsdL9iVJ5FiuzABFFRIQGpGT8IBbS
        aeJcNpNlc1jpky1G+YcpMNOlj9vuJ8SJVZnbk4zrw73ZT3tefzA5kBCWsNXxQUNiW6A73bvH
        XDZnPYblOF9lbJ1+zW+oKgxHdLPzpve3bUoEvyZlW235Uy9Z5LE1JZ+EHdbYDoQcuX5zLEaX
        utAUWTurGj+MTb638SedekskdTQzN6U646kTJQ9KQ3bXA9ettxDvlbJ/34zfM2aIdCtB88Ls
        cGCNsr/6AjqUH9IerN0VPhFb/I/4zjOVt/Naat21n1pu+YfPLb4z9K6zNccjKTQaXb/U7VsX
        VWS5rjT4iYb3FoRenMqMWso1EWcfLimXzImiG4XxXv+8gt51B4/et+sEQstA8guu/L8cLpff
        zox9EYQsXRyzGZfKxP8BTb8GHEgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsVy+t/xe7p7rIqSDO58YrdYf+oYs8Xqu/1s
        FtM+/GS2OD31LJPFpP4Z7Ba/z55nttj7bjarxYUfjUwWK1cfZbJ4sn4Ws0XPgQ8sFn+77gHF
        Wh4yW/x5aGgx6dA1RounV2cxWey9pW1x6fEKdotLi9wt9uw9yWJxedccNov5y56yW0xo+8ps
        cWPCU0aLicc3s1qse/2exeLELWkHaY/LV7w9/p1Yw+Yxsfkdu8f5extZPC6fLfXYtKqTzWNh
        w1Rmj81L6j12L/jM5LH7ZgObR2/zOzaPna33WT3e77vK5rF+y1UWjwmbN7J6fN4kFyAYpWdT
        lF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+XoJdx98kd5oIL
        /BVXp65ib2Ccy9vFyMkhIWAisf3aZKYuRi4OIYGljBK3Js1lhUjISHy68pEdwhaW+HOtiw2i
        6COjxMze+cwQzi5GicPfbjOCVPEK2EmcOXWbDcRmEVCRON49nRkiLihxcuYTFhBbVCBC4sHu
        s0AbODiEBVIkbp1wBAkzC4hL3HoyH+wKEYEpTBJ7JzwGW8AscIFZ4v+XG+wQ2z4wSvxbdpsF
        pJtNQEuisRPsPE4Ba4n+9zPZICZpSrRu/80OYctLNG+dzQzxgrLE5BtXmCDsWolX93czTmAU
        nYXkvllIDpmFZNQsJKMWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECEx024793LKDceWr
        j3qHGJk4GA8xSnAwK4nwOi8tSBLiTUmsrEotyo8vKs1JLT7EaAoMpInMUqLJ+cBUm1cSb2hm
        YGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE08fEwSnVwLRa1t7kd9eegNsCFdISYmUm
        9WmGrxVPBwjoNdfaR/Oe4550+JKWszP/ru4PizX6LY/8UbnpnnzgrP9sjSiOYLP/J3a2Nqdv
        27jBPlnJ/nRqtf+elTwv9JZoHVt5nz32dOahKfMe9504dW3738Kn9epn7+dbz05zuceWLLL5
        /2oplX9/3eM2Xd+QXdq3PZFf2ej6/aqfVTHX7tnzVJbsXa62TeWVZWu/+XuxArPfu5xefC2V
        9bs/fY1R45vwVVHmJ5yvNLNOdQzvF3ETuqL26+XLit+sNxRiN/slCvx7WiMXmKBl/eLIq8Si
        KoGJ+rPn+5WveXx+Z5RxfphXsCDvB46aTMH+afozv4luUmJeq8RSnJFoqMVcVJwIAKUYqwP9
        AwAA
X-CMS-MailID: 20220504083508eucas1p2b13cd91f8b71fcf1a929d098c710ed9e
X-Msg-Generator: CA
X-RootMTR: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895
References: <20220427160255.300418-1-p.raghav@samsung.com>
        <CGME20220427160257eucas1p21fb58d0129376a135fdf0b9c2fe88895@eucas1p2.samsung.com>
        <20220427160255.300418-2-p.raghav@samsung.com>
        <3a178153-62c0-e298-ccb0-0edfd41b7ee2@acm.org>
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-03 18:37, Bart Van Assche wrote:
>>       sector_t zone_sectors = blk_queue_zone_sectors(disk->queue);
>> +    sector_t capacity = get_capacity(disk);
>>         if (!blk_queue_is_zoned(disk->queue))
>>           return 0;
>> -    return (get_capacity(disk) + zone_sectors - 1) >>
>> ilog2(zone_sectors);
>> +
>> +    if (is_power_of_2(zone_sectors))
>> +        return (capacity + zone_sectors - 1) >>
>> +               ilog2(zone_sectors);
>> +
>> +    return div64_u64(capacity + zone_sectors - 1, zone_sectors);
>>   }
>>   EXPORT_SYMBOL_GPL(blkdev_nr_zones);
> 
> Does anyone need support for more than 4 billion sectors per zone? If
> not, do_div() should be sufficient.
> 
You are absolutely right but blk_queue_zone_sectors explicitly changed
the return type to uint32_t to sector_t in this commit:
'113ab72  block: Fix potential overflow in blk_report_zones()'.

I initially did have a do_div but later changed to div64_u64 to avoid
any implicit down casting even though zone_sectors will be always
limited to an unsigned int.
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 60d016138997..c4e4c7071b7b 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -665,9 +665,15 @@ static inline unsigned int
>> blk_queue_nr_zones(struct request_queue *q)
>>   static inline unsigned int blk_queue_zone_no(struct request_queue *q,
>>                            sector_t sector)
>>   {
>> +    sector_t zone_sectors = blk_queue_zone_sectors(q);
>> +
>>       if (!blk_queue_is_zoned(q))
>>           return 0;
>> -    return sector >> ilog2(q->limits.chunk_sectors);
>> +
>> +    if (is_power_of_2(zone_sectors))
>> +        return sector >> ilog2(zone_sectors);
>> +
>> +    return div64_u64(sector, zone_sectors);
>>   }
> 
> Same comment here.
> 
> Thanks,
> 
> Bart.
