Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CBE51FBCC
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 May 2022 13:57:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233537AbiEIMAf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 08:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiEIMAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 08:00:34 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABF0242188
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 04:56:40 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220509115639euoutp02ce448b98c35cc86aa5731b8b752d87c0~tbdTOUL6w2232022320euoutp02B
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 May 2022 11:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220509115639euoutp02ce448b98c35cc86aa5731b8b752d87c0~tbdTOUL6w2232022320euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652097399;
        bh=LRw79LxnO+9lbHN5Ml0ZeqPIsgf1kk4KqFqaSsEFqNo=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=enqvCLLH4SeYtRwOftszp1xVyY2IeY2vfBGT/0OXMVifQ881bdIl84yQXa9igowxt
         IeDBapekR5etPpyxsZ3sdHWFnth9HxjvqdGv7p6znCA4TesCy7jzljpHybIAvnds7p
         Jp96xy2jU1USyCXe61JgEV+m/pAfki6Ef+e3XVVk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220509115636eucas1p1ba44cde73ab43d615481bea150694fcf~tbdRLKZ0w1215112151eucas1p1s;
        Mon,  9 May 2022 11:56:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 8C.64.09887.47109726; Mon,  9
        May 2022 12:56:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220509115636eucas1p1d9d67f3b9235d3e46aaa11101bf4f991~tbdQzeA2G2169921699eucas1p1X;
        Mon,  9 May 2022 11:56:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220509115636eusmtrp219909889bd5adfa8058b3746a9437256~tbdQwWRk81410514105eusmtrp2J;
        Mon,  9 May 2022 11:56:36 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-fe-62790174fcd9
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C2.02.09404.47109726; Mon,  9
        May 2022 12:56:36 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220509115636eusmtip1e0015a7f6905dc16565c6158d4e6d90e~tbdQiOQ_y0902209022eusmtip1T;
        Mon,  9 May 2022 11:56:36 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 9 May 2022 12:56:34 +0100
Message-ID: <9f1385a3-b471-fcd9-2c0c-61f544fbc855@samsung.com>
Date:   Mon, 9 May 2022 13:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        <jaegeuk@kernel.org>, <hare@suse.de>, <dsterba@suse.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <snitzer@kernel.org>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        <bvanassche@acm.org>, <linux-fsdevel@vger.kernel.org>,
        <matias.bjorling@wdc.com>, Jens Axboe <axboe@fb.com>,
        <gost.dev@samsung.com>, <jonathan.derrick@linux.dev>,
        <jiangbo.365@bytedance.com>, <linux-nvme@lists.infradead.org>,
        <dm-devel@redhat.com>, Naohiro Aota <naohiro.aota@wdc.com>,
        <linux-kernel@vger.kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Alasdair Kergon <agk@redhat.com>,
        <linux-block@vger.kernel.org>, Chaitanya Kulkarni <kch@nvidia.com>,
        Keith Busch <kbusch@kernel.org>, <linux-btrfs@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2cPK+DhV/seJNIOMxYQhhff0ji78/IRLby87jw6oyFP
        sIMN2qA08sIBdqC4sROkzUKR3z9EGKFDoI4zmAKxc0JzhgJuHUIgOMq4BeR4tOO/1/v7/vy+
        L4X7GshASirPYhVySbqIFBAdfUu/RmSBI0lRs+NRqOVGH45Wu/pI1DimJlHZ/BKOtOpyPnIN
        DeOoe07PQ+Z/jmGoq1KLofrGXzBkb9Hh6OTP8wSqz5/A0b8TW9DEoo1A2t5RgBwjOgx1215D
        N+/X8VFX93UCWTrPkqiixsFHmuN/4ciqcQBU0m/goYszDwlksgXtCGIst/YwK6YmkinJm+Mz
        w3dbCcYylM20NRSSzPncUpwxVH3DXL2dSzLFeXMkYyy4x2Me9oyQTEv7CMEYBnIYjaGVxzjb
        gvf5JAi2J7Pp0i9YxeuxnwpSjUujZGbtC4ebK4fxXHBaUAQ8KEhvhQumcX4REFC+dB2AbRdN
        BCcWATxnHMc54QRQNTVHPEtxzE8BzqgFcECvwv6PGjbbn6Z0AvinxV3Zg/KkY+FE8R3czQQd
        CissUzj37gOvf2dfKxtAH4BlukHSzX50HPzt71rMzTgthDZ7xVoHf7oBwKYZF+kWOF3Ng5eu
        9DxxKIqkxfBY4VozD/o9WDpczOOSw2DBZRef443w8uxZ3B0OaRHUWyK5dY7C5r5BPsd2AdTd
        EXO8E5rum0mO/eB0f/vTmJfgqrEC4zgHOqyutYUhnQ+g2thCcvW3wVOD6Ry+C3tqgjn0gtZZ
        H24YL6jtOINrwCbdukPo1i2sWze/bt385wDRAIRstlKWwirfkLNfRiolMmW2PCXyUIasDTz5
        1wMr/YtXQO30QmQvwCjQCyCFi/w9fzp1OMnXM1ly5CtWkZGoyE5nlb0giCJEQs9D0ksSXzpF
        ksWmsWwmq3jmYpRHYC62Wybwjon6sPxBXGdh6ItZSSduvx/qfbXsnTB99EjCHn1Kmf/+Hzq+
        /p0WucJ3sAkrPVtlPX/orzkU0fpY5+Bo9YWqo6WbrSdXveMfhWsSf1yOHUCJ4d7it4SbZkLw
        V0w3tF1vNn100Cu5ZvZCmHmZjlYtU4/buz/IiAidJJIDZPWZqXGqtH3VB2zlldKoKqHz1W/P
        BGhU8rd3BplqxuZPR4jvBaYV7AIrsYrljSFmpm/8Y+fj5qIH8UAdumE633q3riKk/PsT4dLN
        z88Ojd3auzBmmlTnHT/vte2mOeeTvamtHZ83Pnp5F+U3tqD6rKQ5xuc51/YNMe1J+69NTR6M
        t+1ODBYRylTJFjGuUEr+A4YMLVFGBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJKsWRmVeSWpSXmKPExsVy+t/xu7oljJVJBseuC1msP3WM2eL/nmNs
        Fqvv9rNZTPvwk9liUv8MdovfZ88zW+x9N5vV4sKPRiaLPYsmMVmsXH2UyeLJ+lnMFj0HPrBY
        rGx5yGzx56GhxcMvt1gsJh26xmjx9OosJou9t7QtLj1ewW6xZ+9JFovLu+awWcxf9pTdYkLb
        V2aLGxOeMlpMPL6Z1WLd6/csFiduSTtIe1y+4u3x78QaNo+Jze/YPc7f28jicflsqcemVZ1s
        HgsbpjJ7bF5S77H7ZgObR2/zOzaPna33WT3e77vK5rF+y1UWj82nqz0mbN7I6vF5k1yAYJSe
        TVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJexs6f19gK
        lvNUrF10nrmBcQpXFyMnh4SAicTTDy8Yuxi5OIQEljJK3G/oZIdIyEh8uvIRyhaW+HOtiw2i
        6COjxM/FfawQzi5GiWsnG5hAqngF7CQe9t5mBrFZBFQk5l9+wQwRF5Q4OfMJC4gtKhAh8WD3
        WVYQW1jAS+L6t+VgvcwC4hK3nsxnAhkqIrCKUWLN699g65gFFrNKXJz9DuwOIYHXTBJHr1V1
        MXJwsAloSTRCnMop4CYx9XwvK8QgTYnW7b/ZIWx5ie1v5zCDlEsIKEnMvqwH8U2txKv7uxkn
        MIrOQnLeLCRnzEIyaRaSSQsYWVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIEprltx35u2cG4
        8tVHvUOMTByMhxglOJiVRHj391UkCfGmJFZWpRblxxeV5qQWH2I0BYbRRGYp0eR8YKLNK4k3
        NDMwNTQxszQwtTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgEutdsvUh29SNayYI3bn3
        XC3v6aKnx0zvfPf5q2d68d+BkI5jy+N9pI4xa0xJUpRuvcc1tdPIRyXifMRvz6/W3QY9Xya9
        429XWcOcNIFRp+5Z++EeDVXtyNJLisonHt8QC2yd7igXahLx/HxpW8TupR133r0yTa5c67Lm
        kOweo56QH63/qiq/am256bbl8YvNBhsV90rZ67W+ySiIu6WTG7D6AKvaoU+b3Xlf3L5trmnZ
        4qM1b3VUm99ix8cS1x4unJiU/ez89GzLCJFtQdHKzOYeWR+Pyiy2KnfYpRJ+cL7Wmw6lBPXY
        mpIHzQLMZ++KPZqwVvpGvNVWFruELVFTOGWOWVU17XiYovX1sGmxEktxRqKhFnNRcSIAtvwA
        yPwDAAA=
X-CMS-MailID: 20220509115636eucas1p1d9d67f3b9235d3e46aaa11101bf4f991
X-Msg-Generator: CA
X-RootMTR: 20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098
References: <20220506081105.29134-1-p.raghav@samsung.com>
        <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
        <20220506081105.29134-11-p.raghav@samsung.com>
        <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
        <aef68bcf-4924-8004-3320-325e05ca9b20@samsung.com>
        <9eb00b42-ca5b-c94e-319d-a0e102b99f02@opensource.wdc.com>
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


On 2022-05-09 13:31, Damien Le Moal wrote:
>>>> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
>>>> index dae54dd1a..00c34e65e 100644
>>>> --- a/drivers/block/null_blk/zoned.c
>>>> +++ b/drivers/block/null_blk/zoned.c
>>>> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>>>>  
>>>>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>>>>  {
>>>> -	return sect >> ilog2(dev->zone_size_sects);
>>>> +	if (is_power_of_2(dev->zone_size_sects))
>>>> +		return sect >> ilog2(dev->zone_size_sects);
>>>
>>> As a separate patch, I think we should really have ilog2(dev->zone_size_sects)
>>> as a dev field to avoid doing this ilog2 for every call..
>>>
>> I don't think that is possible because `zone_size_sects` can also be non
>> po2.
> 
> But when it is we can optimize that. All we need is add a "zone_size_sect_shift"
> field that is initialized when zone_size_sects is set when the device is
> created. Then, you can have code like:
> 
> 	if (dev->zone_size_sect_shift))
> 		return sect >> dev->zone_size_sect_shift;
> 
My only concern was confusing people who are reading the code where they
might implicitly assume that it can only be po2 as we have shift_sects.

Even though I am not sure if this optimization will directly add value
looking at my experiments with the current change, I can fold this in
with a comment on top of zone_size_sect_shifts variable stating that
size can be npo2 and this variable is only meaningful for the po2 size
scenario.
