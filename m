Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CABF5235BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 May 2022 16:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238891AbiEKOjf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 May 2022 10:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiEKOjf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 May 2022 10:39:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EE256413
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 07:39:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220511143924euoutp022c6d87c02dde08b04c1d3b0dbea04366~uE9_4rFep0608306083euoutp02U
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 May 2022 14:39:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220511143924euoutp022c6d87c02dde08b04c1d3b0dbea04366~uE9_4rFep0608306083euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652279964;
        bh=EUaYeqrDCZdYIk1QARpzTYuomNghhQ2OqPnaqXtUYXI=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=cckO2daDpiVhFX6qpoQYbYH6llh83054qsmL/8fX4xsl//rh5oxEEQcsIU0wxEzN8
         xPcjDha5le5ZiqVkoxD+PkgW+pYaKSajomW6x4BXGIpo680Bn11YENWOCckJ8aKbi2
         4iFTqaIZqXzehfl096ccaQwYo2n6fkUvKh14nO70=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220511143924eucas1p1114e84104a5c6c0eb50e67f8777969a5~uE9_R-fHL3194531945eucas1p1W;
        Wed, 11 May 2022 14:39:24 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 60.2A.10009.C9ACB726; Wed, 11
        May 2022 15:39:24 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220511143923eucas1p2e3a3e929d5d66bce874b5a9f7d7fd067~uE99xcdbm0496104961eucas1p2y;
        Wed, 11 May 2022 14:39:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220511143923eusmtrp1fc902ac2cae0a49dc35e360306028ac3~uE99wDcd41329413294eusmtrp1g;
        Wed, 11 May 2022 14:39:23 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-24-627bca9c0b1d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.16.09404.B9ACB726; Wed, 11
        May 2022 15:39:23 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220511143923eusmtip1f71a6b406fa85da0c0332d11c8d4d4aa~uE99juOBx3226832268eusmtip1E;
        Wed, 11 May 2022 14:39:23 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.174) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 11 May 2022 15:39:18 +0100
Message-ID: <d8e86c32-f122-01df-168e-648179766c55@samsung.com>
Date:   Wed, 11 May 2022 16:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes
 are allowed
Content-Language: en-US
To:     <dsterba@suse.cz>, <jaegeuk@kernel.org>, <hare@suse.de>,
        <dsterba@suse.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <snitzer@kernel.org>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        <bvanassche@acm.org>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        <gost.dev@samsung.com>, <jonathan.derrick@linux.dev>,
        <jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
        <dm-devel@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        "Sagi Grimberg" <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        "Keith Busch" <kbusch@kernel.org>, <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <20220509185432.GB18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.174]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTVxzHc3pv772tVC4V5QTYw4K4IUMbl+y4KWGZ4M3cdLIQlw03C94U
        YinSFmQSGQ4kBaU8FIQOpStuPidDCA95jFUe5aGCrFpqdDAoTBmFAYsgC85yceG/z+/7+37P
        +f1ODoWJawlPKkapYVVKmUJCCPHqtrnbb5V0JkduSrsvQOWdbRh63tBGoCsPcwhUODmHofyc
        IhLN37qDoUbHd3zUM3uMh8rmn+KowZjPQ5eutPLQcLkeQyebJ3F0KX0QQ/8OStHgjA1H+aZ7
        ANkteh5qtG1Ad4cukqihsQNHfTdKCFT6o51EuRn/YMiaawcor72Sj66NTeDIbPMK9mb6ftvJ
        LJivEkxemoNk7jyqwJm+WwnM9cuZBPN9agHGVJ7/hqnvTyWY7DQHwdQd/53PTDRZCKa8yoIz
        3YYWkqnsSmZyKyv4n4g/F249wCpiElnVxqD9wujTo7fxQwXCJG1xUioooLKAgIL027Be1wKc
        LKYvApj9TJ4FhC94BkBtmQlwxTSAz3s6sJeJoa4eHte4AOCzmw/x/126auNSUQ9gb5txMSKi
        g+C9uQLcyTi9Dp6veQw43Q12FA8v6qvpz2Chvptw8ip6L2xpNSxmMdoD2oZLF69zpy0ETM8f
        4WcBiiJof3gsk3R6BPRmWFd2AnD+N+HxmnmS49dgzXjJ0tg+cGKgCef4KPyprZt0nglpixCe
        mTECrrEdWgqKCI5XwSftVSTH3rDr1MmlcDK0W+cxLpwOYE5dOeEcCNLvQV23gvO8D422PwEn
        r4TWcTdunpUwv/oMxskiqM0Q5wJf/bKX0C/bWL9sG/2ybQwAvww82AR1rJxVS5Xs4UC1LFad
        oJQHRsXFXgcvPnfXQvtULTj75O9AE+BRwAQghUncRb/okiLFogOyr4+wqrivVAkKVm0CXhQu
        8RBFxfwsE9NymYY9yLKHWNXLLo8SeKby+EfMa3CJutPsCKurZ/8aXnst0Pddu4UcKz71h0aj
        CfXzCxo9F+xVu94lYERdK4hXUpuUE1bPiAdePuumzXmZiSvwG7WajDyf9PV5rx+M3N7U2Xr3
        1aLxcNGKV2ZD+VJwelddxH7N4y0LFQNbpURrr3ti/Dths5+eCGkKHUhhV9/coPAt3eVtiOBv
        VlwFMzv9XePcUqa27bN/IHe58GWhJDvkcPCUcsGwRxdsjSLnPp6OfrCn/6PJ9n17A5oVDgbt
        2BYQ0drv4hJ/jnY0z45M7earJ9cwP0SEu255w08X9mtKQMioee0XveXh97XaR+FDPlVHp8a+
        3Sjl53xoD0dP9a4SXB0tk/pjKrXsP9KMJ4lLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsVy+t/xu7qzT1UnGbx+qmSx/tQxZov/e46x
        Way+289mMe3DT2aLSf0z2C1+nz3PbLH33WxWiws/GpksFv/+zmKxZ9EkJouVq48yWTxZP4vZ
        oufABxaLlS0PmS3+PDS0ePjlFovFpEPXGC2eXp3FZLH3lrbFpccr2C327D3JYnF51xw2i/nL
        nrJbTGj7ymxxY8JTRouJxzezWqx7/Z7F4sQtaQcZj8tXvD3+nVjD5jGx+R27x/l7G1k8Lp8t
        9di0qpPNY2HDVGaPzUvqPXbfbGDz6G1+x+axs/U+q8f7fVfZPNZvucricWbBEXaPzaerPSZs
        3sgaIBSlZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5eg
        lzHl+TmWgqlcFR0zKxoYp3J0MXJySAiYSDw+fYGpi5GLQ0hgKaNE74O/zBAJGYlPVz6yQ9jC
        En+udbFBFH1klJiwZzkzhLMbqKO7kQmkilfATuLaz6ksIDaLgKrEku0vGSHighInZz4Bi4sK
        REg82H2WFcQWFgiXWPN2C1gNs4C4xK0n88HOEBG4yibRMukZK8SG54wS7x+fB6ri4GAT0JJo
        7AQ7iVPAWGLn4m6oZk2J1u2/2SFseYntb+dAvaAs8f7BPhYIu1bi1f3djBMYRWYhuWkWkt2z
        kIyahWTUAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIGpbduxn1t2MK589VHvECMTB+Mh
        RgkOZiUR3v19FUlCvCmJlVWpRfnxRaU5qcWHGE2BATORWUo0OR+YXPNK4g3NDEwNTcwsDUwt
        zYyVxHk9CzoShQTSE0tSs1NTC1KLYPqYODilGpg4qpNc0ydsyn0tv9U52nlJ4pMJW09kzrB8
        enyejAfDqWt3FF26cs5+OjyJl/PEBPVC/SReEStbr8CsOydXtDpGrL2y7JJEqr9hTKXtrtmG
        E+NeKL9cWBJZn3Q9+8WRwl1+rELmca9LVzprvjJoEPt6rlFk6+84hW/Oxpltcr77t3OmiAlW
        Zv9kmdTooNbYM0vst+e1mMgi/lsbr3+3cFmu8OF1O8fmG2qn5igEHXpcd8Kj8K7JvMO7Tjme
        6AtrOXtV8ZkYY+RRX85TSQ/Te65q/dFeftqJe9LM+h/XTPKWT/i8yz709x4umTCZowc+fcve
        nl06I4uRw3tKkWv2Bof/S7OdtNbUux/X5d1q/EKJpTgj0VCLuag4EQANVqpY9gMAAA==
X-CMS-MailID: 20220511143923eucas1p2e3a3e929d5d66bce874b5a9f7d7fd067
X-Msg-Generator: CA
X-RootMTR: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
        <20220506081105.29134-12-p.raghav@samsung.com>
        <20220509185432.GB18596@twin.jikos.cz>
X-Spam-Status: No, score=-8.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi David,

On 2022-05-09 20:54, David Sterba wrote:>> diff --git
a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
>> index 3e7b1fe15..27dc4ddf2 100644
>> --- a/drivers/md/dm-zone.c
>> +++ b/drivers/md/dm-zone.c
>> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>>  	struct request_queue *q = md->queue;
>>  	unsigned int noio_flag;
>>  	int ret;
>> +	struct block_device *bdev = md->disk->part0;
>> +	sector_t zone_sectors;
>> +	char bname[BDEVNAME_SIZE];
>> +
>> +	zone_sectors = bdev_zone_sectors(bdev);
>> +
>> +	if (!is_power_of_2(zone_sectors)) {
> 
> is_power_of_2 takes 'unsigned long' and sector_t is u64, so this is not
> 32bit clean and we had an actual bug where value 1<<48 was not
> recognized as power of 2.
> 
Good catch. Now I understand why btrfs has a helper for is_power_of_two_u64.

But the zone size can never be more than 32bit value so the zone size
sect will never greater than unsigned long.

With that said, we have two options:

1.) We can put a comment explaining that even though it is 32 bit
unsafe, zone size sect can never be a 32bit value

or

2) We should move the btrfs only helper `is_power_of_two_u64` to some
common header and use it everywhere.

Let me know your thoughts.

