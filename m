Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958E152E57B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 09:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346127AbiETG7u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 02:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346123AbiETG7r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 02:59:47 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420E614FCAB
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 May 2022 23:59:44 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220520065942euoutp0201bd5c87ea28dfe16b2c22df03cfa135~wvgLp6Hj23223932239euoutp02V
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 06:59:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220520065942euoutp0201bd5c87ea28dfe16b2c22df03cfa135~wvgLp6Hj23223932239euoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653029983;
        bh=mJkxTYPikvkdqTMnJ+Lh+vfvviEKxyPCWIK29LAgqws=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fwZzgxhR8r0aDLdv917/Pc2QFVtY1YINgZWiGwTQOzlISvRHGfrFqFdQBJ+AhRx8x
         yao5q7WVWBFdm0noVfvJFkQ46ta/DM69753qC+shGo9aJ/Iwsy4JdIZepUH3ZiUF4O
         HsjWXQRZnYlVb0Gsf5+wr1IBVe/J59F8oAqQNay0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220520065942eucas1p2c8721732b62af59ccfc2110b4655da17~wvgLVSAmh0722907229eucas1p2_;
        Fri, 20 May 2022 06:59:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9C.29.10260.E5C37826; Fri, 20
        May 2022 07:59:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520065941eucas1p105cf273ede995dc4bf92f3245fad09b1~wvgKPDE413192831928eucas1p1m;
        Fri, 20 May 2022 06:59:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520065941eusmtrp119cec5b2f3eb4133ff4c909e1066456d~wvgKM9niN0344103441eusmtrp19;
        Fri, 20 May 2022 06:59:41 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-c5-62873c5e7aec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F4.76.09522.D5C37826; Fri, 20
        May 2022 07:59:41 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220520065941eusmtip2778dbf13ef9c02edb6e5f1e63237ea6b~wvgKAjsFg2107821078eusmtip2U;
        Fri, 20 May 2022 06:59:41 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 20 May 2022 07:59:40 +0100
Date:   Fri, 20 May 2022 08:59:39 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
        Pankaj Raghav <p.raghav@samsung.com>,
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
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned
 devices
Message-ID: <20220520065939.yjqlgsxs3qchpgzo@mpHalley-2.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xTZxjG851bDzUlh+rgHTq3ISabOtCo29F6YRku5x8G2T+iTkehZ0Bo
        i+ttg41ZblMoA2QLbIXgMhDQegsKEQdbZWuxAURoOinjoqHFDURBIRSnOMvRjf9+3/s8z/t9
        T/LRuPQBGUqnqnW8Ri1XhlFiotk+3/PWoR1HEzeWT6xiLUMlFPtPdw/Ott2rJNkbvmyMbf2p
        DGNPWWwY6zlvxtki6xTBPikcxti2gfVs32iDiG1tcxCs80oVxZ6o84rY/lIvYs+4vQSbXzQv
        igriFq6dobgW85CIc3brucbTBRR3sfYI97PbSHE5XTaca8kfIbn7v7go7vwlF8Fd7PyCe9i4
        mjtqNWFxkv3iHQpemWrgNZG7EsQpg1cH8MO21z+vscySRvQ4tBAF0MBsgUn7DaoQiWkp04Cg
        ZnwQ+QUpM4PAeT1TEB4iGL5dK3qR+N5TjQShHoHn3hT6z5VjySWEQxOC6tFszB8hmLVQ98cE
        7meK2Q19dQOLvILZCpNF+YsBnLlDQZ0zh/QLy5lYOH5lkPKzhImG7ptPCYGDwPGDZ5FxZjsU
        TPn99DNeCfULtDB+FXKbKhf3BzDvw+UJJ+a3ALMG6itihAZZcNbeJfJfC8yjAHhc5aIEIRoq
        TAtI4OUw3nHpeeVV0PltESFwGvR2mXCBdVBz344L+2VQ3KUUxu/CufwSShgHQv9kkPCyQChr
        rnjulsCxr6WlKNy8pJZ5SS3z/7XMS2r9iIjTKITXa1XJvHazmv8sQitXafXq5IikdFUjevYt
        Oxc6Zi+jhvHpiHaE0agdAY2HrZAgVV6iVKKQZ2TymvSPNXolr21HK2kiLESSlHpBLmWS5To+
        jecP85oXKkYHhBqxN8669P2kwRMMzQdXv3lnzJm4VbxNYc3FNMF5LbH4oLPW/sF09ElRa4Li
        6ga0mx+xpm0Xgel3dkbZc7c7yvfhLJC3quYOzZHmGXH8Xxv3pMorsyLSs7V7P32vXJEhXdb7
        6JtiW9aEdVfksrsjjqdxke2h3t/c3k8mZXtePuAL7+tdqxoP37Dvz+vH/naLh+ZqGmbJkp3m
        jLz1+6qJ8gLfS9iQWpN4arh5NObLlCgU/wANlJGS7+Y7Qhodrl8NbxvcTZm1N2+PXYu0+G5t
        VmWkHNkrM2TGHgx0GF4jdPxJY85H72ySTSd4q7cUnwveZpR9FZM0EzetKx2Lt+18xfQkjNCm
        yDetwzVa+b9FxuryBQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsVy+t/xe7qxNu1JBj9nC1msvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uPR4BbvFnr0nWSwu
        75rDZjF/2VN2ixsTnjJarLn5lMWitecnu4Ogx78Ta9g8ds66y+5x+Wypx6ZVnWwem5fUe+y+
        2cDm0XTmKLPHztb7rB7v911l81i/5SqLx+bT1R6fN8l5tB/oZgrgjdKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuHPwFnPBUcWKxau/sjYw/pHq
        YuTkkBAwkZjxZB5jFyMXh5DAUkaJf38Ws0IkZCQ+XfnIDmELS/y51sUGUfSRUeLozslsIAkh
        ga2MEmsulYPYLAKqEsuuvWYGsdkE7CUuLbsFZosImEq87WllAWlmFnjKJnH+3U9GkISwgK/E
        1SlvWEBsXgEXibPX/7NAbFjCInHp41JGiISgxMmZT8CKmAUsJGbOPw8U5wCypSWW/+OACMtL
        NG+dDbaMU8BNYsfry0wgJRICyhLLp/tCPFAr8er+bsYJjCKzkAydhWToLIShs5AMXcDIsopR
        JLW0ODc9t9hQrzgxt7g0L10vOT93EyMwnWw79nPzDsZ5rz7qHWJk4mA8xCjBwawkwsuY25Ik
        xJuSWFmVWpQfX1Sak1p8iNEUGEQTmaVEk/OBCS2vJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUgg
        PbEkNTs1tSC1CKaPiYNTqoEpQNSsz/fuIQbdhzqvWlK3CRjn5c/2c+x4Ycs385PYpcz7fcdW
        Fttc2X3ZJEIz0rlr9ivNI4a9ug217xYvX25flT7RM0//m3tC56tJbVoGR7y3Pn7w5GzL1ca2
        /LgjzaHO99gbPPaHR+Ts5mxbZ6LBfkrCafY84Y9HZ00ROcL26VWOScYXph3nY3d7L79bePum
        Pmv7niiejxPbH6npPtF5Om36va74CRlJJ/Vlgn3aXa0S/sy9WHc10ftm45HNSTYP2mV/VHod
        Y7RJXG7avZjhyrZrJyItE6TObnPxyPwh2v5+gdB1uwnZ6xteGielz3NkmWaYsGbVy7L8qt6e
        lgf3z6za/ZvrwqnsA+LdzNJKLMUZiYZazEXFiQDpv0hasAMAAA==
X-CMS-MailID: 20220520065941eucas1p105cf273ede995dc4bf92f3245fad09b1
X-Msg-Generator: CA
X-RootMTR: 20220520065941eucas1p105cf273ede995dc4bf92f3245fad09b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220520065941eucas1p105cf273ede995dc4bf92f3245fad09b1
References: <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
        <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
        <20220519031237.sw45lvzrydrm7fpb@garbanzo>
        <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
        <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
        <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
        <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
        <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
        <CGME20220520065941eucas1p105cf273ede995dc4bf92f3245fad09b1@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.05.2022 15:41, Damien Le Moal wrote:
>On 5/20/22 15:27, Javier González wrote:
>> On 20.05.2022 08:07, Hannes Reinecke wrote:
>>> On 5/19/22 20:47, Damien Le Moal wrote:
>>>> On 5/19/22 16:34, Johannes Thumshirn wrote:
>>>>> On 19/05/2022 05:19, Damien Le Moal wrote:
>>>>>> On 5/19/22 12:12, Luis Chamberlain wrote:
>>>>>>> On Thu, May 19, 2022 at 12:08:26PM +0900, Damien Le Moal wrote:
>>>>>>>> On 5/18/22 00:34, Theodore Ts'o wrote:
>>>>>>>>> On Tue, May 17, 2022 at 10:10:48AM +0200, Christoph Hellwig wrote:
>>>>>>>>>> I'm a little surprised about all this activity.
>>>>>>>>>>
>>>>>>>>>> I though the conclusion at LSF/MM was that for Linux itself there
>>>>>>>>>> is very little benefit in supporting this scheme.  It will massively
>>>>>>>>>> fragment the supported based of devices and applications, while only
>>>>>>>>>> having the benefit of supporting some Samsung legacy devices.
>>>>>>>>>
>>>>>>>>> FWIW,
>>>>>>>>>
>>>>>>>>> That wasn't my impression from that LSF/MM session, but once the
>>>>>>>>> videos become available, folks can decide for themselves.
>>>>>>>>
>>>>>>>> There was no real discussion about zone size constraint on the zone
>>>>>>>> storage BoF. Many discussions happened in the hallway track though.
>>>>>>>
>>>>>>> Right so no direct clear blockers mentioned at all during the BoF.
>>>>>>
>>>>>> Nor any clear OK.
>>>>>
>>>>> So what about creating a device-mapper target, that's taking npo2 drives and
>>>>> makes them po2 drives for the FS layers? It will be very similar code to
>>>>> dm-linear.
>>>>
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
>Yes, and it also allows supporting these new !po2 devices without
>regressions (read lack of) in the support at FS level.
>
>>
>> This said, it seems to me that the changes to the FS are not being a
>> real issue. In fact, we are exposing some bugs while we generalize the
>> zone size support.
>
>Not arguing with that. But since we are still stabilizing btrfs ZNS
>support, adding more code right now is a little painful.
>
>>
>> Could you point out what the challenges in btrfs are in the current
>> patches, that it makes sense to add an extra dm layer?
>
>See above. No real challenge, just needs to be done if a clear agreement
>can be reached on zone size alignment constraints. As mentioned above, the
>btrfs changes timing is not ideal right now though.
>
>Also please do not forget applications that may expect a power of 2 zone
>size. A dm-zsp2 would be a nice solution for these. So regardless of the
>FS work, that new DM target will be *very* nice to have.
>
>>
>> Note that for F2FS there is no blocker. Jaegeuk picked the initial
>> patches, and he agreed to add native support.
>
>And until that is done, f2fs will not work with these new !po2 devices...
>Having the new dm will avoid that support fragmentation which I personally
>really dislike. With the new dm, we can keep support for *all* zoned block
>devices, albeit needing a different setup depending on the device. That is
>not nice at all but at least there is a way to make things work continuously.

All the above sounds very reasonable. Thanks Damien.

If we all can agree, we can address this in the next version and come
maintain the native FS support off-tree until you see that general btrfs
support for zoned devicse is stable. We will be happy to help with this
too.

