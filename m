Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD18152E8CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiETJaX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 05:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbiETJaV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 05:30:21 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38F413C0A0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 02:30:18 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220520093016euoutp01b47704b560e523092bd596c69eeadd1c~wxjourp0G0794807948euoutp01-
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 09:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220520093016euoutp01b47704b560e523092bd596c69eeadd1c~wxjourp0G0794807948euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653039016;
        bh=vAZzIiKGtzLph1c5bgWAoA6BkNu+uSouEMHm/FmJjYM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=HABm8G8AlqCv+3bWkAh2iBbci9UsSVWGX3X8GFVCvEa8GWtOtHqXSQ1m02AG+g/RQ
         1OIkLVASdXnXNzWsfLng7G4xhZRccGRxGrS092ejlsVK49TZC7vdvpBprWjhjm42K2
         yEQMgvJZvw5splKOtdk8D6QxI6cVKFPbDKkM5wvI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220520093015eucas1p28fa395b4d8335a5d020fa99543301444~wxjoTWiMT1631716317eucas1p2L;
        Fri, 20 May 2022 09:30:15 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 82.1C.09887.7AF57826; Fri, 20
        May 2022 10:30:15 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220520093015eucas1p2dcc087b20f5173d8edfd45259c255138~wxjn0ZfEm0183701837eucas1p2F;
        Fri, 20 May 2022 09:30:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220520093015eusmtrp2043f1a2f3fc4fc8ec250258aa9dbc8e3~wxjnzZXuh0483004830eusmtrp2m;
        Fri, 20 May 2022 09:30:15 +0000 (GMT)
X-AuditID: cbfec7f4-471ff7000000269f-f0-62875fa799e3
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 55.96.09404.7AF57826; Fri, 20
        May 2022 10:30:15 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520093015eusmtip137654dbfcd65cc97ccae5dbc46c28914~wxjnnPNey3102231022eusmtip1p;
        Fri, 20 May 2022 09:30:15 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 20 May 2022 10:30:10 +0100
Message-ID: <aee22e8a-b89b-378c-3d5b-238c1215b01d@samsung.com>
Date:   Fri, 20 May 2022 11:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned
 devices
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUxTZxTG9957e++lpt2lZeNNnXVpYpYBlin88RoM4kbkxriwLdmymGWu
        wA10o0X7wTaYDhY+ZjFK2QKzwADB1aGkUBuktd0QkMqksFA7+XZRGhYNoog6+Zzl4sJ/zznn
        +Z2c581L45JVgYxWaw2cTqvKVpBCor332cB266HStLeK3HHo/MQpEi36BnHkuV8tQH/+W4gh
        95kKDP16/iqGpmwWHJ3ofECgZdMkhiq6/gLIMxqNhu6co5Db00cgv6uGRHW/BCk0XB4E6MJI
        kEAlbY8BKj7xjEqSsivXLpCs0zJBsX6fkbU3HyfZi03fspdHCkj2u/6rOOssviVgZ38LkKzN
        ESDYi9fz2Ud2OVvaWYa9Jzoo3J3BZatzOV1s4mfCrJk26vBN+JXVfEtQAH6XmkAYDZl4OFlY
        j5uAkJYw5wBs7LVjfDEP4JC5EvDFIwCnXV7iBVI/66L4gRVAS3kt+b+ro9q0zrsA7DnbA0KI
        iEmENYErWEgTzDZ41j2y3g+Hfaen1ta+wnwMKy39ZEhLmVRodo2vaZyJhKNTdWtLI5gyDM6V
        rApCBc5UkfCfJ4HnNE2TTBQsPE6FgDBmH+y458d4+E1YfGmR4vVWeGmmBg/ZIaOA7QvxfJyj
        sKW3fy0OZE4L4c+XG0jekwyDvnd5jxTe9TooXr8GV511GK/zYXB4EefZIgBPOW3rbAI82Z/N
        e/bC0lEPxbfFcHgmnL9GDCvaq/BysM2y4SUsGxJbNgSwbAhQD4hmEMkZ9ZpMTr9Ty32p1Ks0
        eqM2U5meo7GD53/0+op3vgNY7z5UdgGMBl0A0rgiQgQ0RWkSUYbq6zxOl3NIZ8zm9F1gM00o
        IkXp6laVhMlUGbgvOO4wp3sxxegwWQGmSBTH59yu3TV9NGnsDBtbktzwtHHTkfS5GH/c/T5f
        AhF/TCZ3ytSDRxwJYzubM715xVv1y/LtKXpzytzTaBMuXW1aTrr9pGWFTVY6nEPWG1E1YdXM
        9OaBm9KMD8jx6V174hpilN6ljP1Lsd0x82LBgd4EuT/daI3+4+3K/Ds/nEzZXSRuzPvwmNzW
        2rBHbq7eO3HvYPjLubafYr+ZLWmVlyV/bhzSdLet1BrkWSLTfnzB+fcO9UcR/nfSKprf6Hz1
        0x8luaamTb7Rx2Oz7xcMPkhdWNiyBLU5D/NTeqh9Ww6w1wYMHakex+vulnHxS5+IbuR2q2YC
        V9wxVZMyA2X/XkHos1Q7onCdXvUf9V8ubRIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsVy+t/xu7rL49uTDJ6+ErFYfbefzeL32fPM
        FnvfzWa1uPCjkcliz6JJTBYrVx9lsniyfhazRc+BDywWf7vuMVlMOnSN0WLvLW2LS49XsFvs
        2XuSxeLyrjlsFvOXPWW3uDHhKaPFmptPWSzaNn5ltGjt+cnuIOzx78QaNo+ds+6ye1w+W+qx
        aVUnm8fmJfUeu282sHk0nTnK7LGz9T6rx/t9V9k81m+5yuKx+XS1x+dNch7tB7qZAnij9GyK
        8ktLUhUy8otLbJWiDS2M9AwtLfSMTCz1DI3NY62MTJX07WxSUnMyy1KL9O0S9DLebmQvuC5R
        sXzifdYGxv3CXYycHBICJhIL3u9i72Lk4hASWMooMffWHjaIhIzEpysf2SFsYYk/17rA4kIC
        HxklutrrIRp2MUpM7b/JDJLgFbCTmHP1IBOIzSKgKrF0z01GiLigxMmZT1hAbFGBCIkHu8+y
        gtjCAr4SV6e8AYszC4hL3HoynwlkqIhAN5NE/9OjLCAOs8B0NokX366yQKxbziqx8s0SoDIO
        DjYBLYnGTrDzOAXcJHa8vswEMUlTonX7b3YIW15i+9s5zCDlEgJKEtt+mUB8Uyvx6v5uxgmM
        orOQ3DcLyR2zkEyahWTSAkaWVYwiqaXFuem5xUZ6xYm5xaV56XrJ+bmbGIHJZ9uxn1t2MK58
        9VHvECMTB+MhRgkOZiURXsbcliQh3pTEyqrUovz4otKc1OJDjKbAQJrILCWanA9Mf3kl8YZm
        BqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUyL1tYq7bTsea4Ye+Q965yK
        923SSqdqWNxb63q+1s41/hx5LurM5U0Owb/K9srfPHDhzTTTf4pCYkE57z3EtFfPCilWmLgr
        bDb/1WePnoscaFzjrTtlGdu1+vlGl1aeWOtRN/epxXNGzbDrR2/rXe4oXZTGtNmax3yXioOr
        +yn1CTVr736qbHQXfOdg7HFG+c+tk8eUmO/9tTvGur6+3nrddD7rm/Ne2t98KsjU4+be3vau
        3U9STpTzo/3My/F2sopv/+YL+37gnBwnybn5ysL1TAVm20xfT9biyZgf/enHJV9ff6MeE2HV
        uVevSC6b12XOu2bjk2ah5Zlq4YduzWpwsX7F5F769Jn1fLUAi2QlluKMREMt5qLiRADUu03a
        xwMAAA==
X-CMS-MailID: 20220520093015eucas1p2dcc087b20f5173d8edfd45259c255138
X-Msg-Generator: CA
X-RootMTR: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef
References: <CGME20220516165418eucas1p2be592d9cd4b35f6b71d39ccbe87f3fef@eucas1p2.samsung.com>
        <20220516165416.171196-1-p.raghav@samsung.com>
        <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
        <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
        <20220519031237.sw45lvzrydrm7fpb@garbanzo>
        <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
        <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
        <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
        <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
        <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/22 08:41, Damien Le Moal wrote:
>>>>>
>>>>> So what about creating a device-mapper target, that's taking npo2 drives and
>>>>> makes them po2 drives for the FS layers? It will be very similar code to
>>>>> dm-linear.
>>>>
Keith and Adam had a similar suggestion to go create a device mapper
(dm-unholy) when we tried the po2 emulation[1].
>>>> +1
>>>>
>>>> This will simplify the support for FSes, at least for the initial drop (if
>>>> accepted).
>>>>
>>>> And more importantly, this will also allow addressing any potential
>>>> problem with user space breaking because of the non power of 2 zone size.
>>>>
>>> Seconded (or maybe thirded).
>>>
>>> The changes to support npo2 in the block layer are pretty simple, and 
>>> really I don't have an issue with those.
>>> Then adding a device-mapper target transforming npo2 drives in po2 
>>> block devices should be pretty trivial.
>>>
>>> And once that is in you can start arguing with the the FS folks on 
>>> whether to implement it natively.
>>>
>>
>> So you are suggesting adding support for !PO2 in the block layer and
>> then a dm to present the device as a PO2 to the FS? This at least
>> addresses the hole issue for raw zoned block devices, so it can be a
>> first step.
> 
> Yes, and it also allows supporting these new !po2 devices without
> regressions (read lack of) in the support at FS level.
> 
>>
>> This said, it seems to me that the changes to the FS are not being a
>> real issue. In fact, we are exposing some bugs while we generalize the
>> zone size support.
> 
> Not arguing with that. But since we are still stabilizing btrfs ZNS
> support, adding more code right now is a little painful.
> 
>>
>> Could you point out what the challenges in btrfs are in the current
>> patches, that it makes sense to add an extra dm layer?
> 
> See above. No real challenge, just needs to be done if a clear agreement
> can be reached on zone size alignment constraints. As mentioned above, the
> btrfs changes timing is not ideal right now though.
> 
> Also please do not forget applications that may expect a power of 2 zone
> size. A dm-zsp2 would be a nice solution for these. So regardless of the
> FS work, that new DM target will be *very* nice to have.
> 
>>
>> Note that for F2FS there is no blocker. Jaegeuk picked the initial
>> patches, and he agreed to add native support.
> 
> And until that is done, f2fs will not work with these new !po2 devices...
> Having the new dm will avoid that support fragmentation which I personally
> really dislike. With the new dm, we can keep support for *all* zoned block
> devices, albeit needing a different setup depending on the device. That is
> not nice at all but at least there is a way to make things work continuously.
> 

I see that many people in the community feel it is better to target the
dm layer for the initial support of npo2 devices. I can give it a shot
and maintain a native out-of-tree support for FSs for npo2 devices and
merge it upstream as we see fit later.

[1]
https://lore.kernel.org/all/20220311223032.GA2439@dhcp-10-100-145-180.wdc.com/
