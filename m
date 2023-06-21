Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1D4738352
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 14:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjFUMDO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 08:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjFUMDF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:03:05 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71841988
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 05:03:01 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621120300euoutp017bef23081b539fcb63aa0b3361691604~qqvUbZwZN0998609986euoutp01Z
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 12:03:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621120300euoutp017bef23081b539fcb63aa0b3361691604~qqvUbZwZN0998609986euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687348980;
        bh=bpZqvimNewWw3UxsMMES8m/knX462j+T+gvCBFQUHEI=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=hCmzQCtP515o5pqve4V/fquSll48inoYHyxNdHJWmobnZYmaKkqOFE+8LunDO2wbL
         cspfIMYn2LxLgEWkcdoKE2MDjYF97hD4UQfvFZbcU3q+CA9/OvN3eAz+qdbk3m0m42
         uUSwYmw3yWv4+nleGhnh0fIHQXT8FZENh3TlSEnQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621120259eucas1p170a06c55866885d903d2b0e48e8626e2~qqvUDC2Pw1538315383eucas1p1c;
        Wed, 21 Jun 2023 12:02:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 13.07.42423.3F6E2946; Wed, 21
        Jun 2023 13:02:59 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621120259eucas1p1f0ed07016243bc2ec48b3622e57483b9~qqvTpeLXn1536715367eucas1p1T;
        Wed, 21 Jun 2023 12:02:59 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621120259eusmtrp298c9aac7b5398a5cc92d1a45db848948~qqvToue1l2679326793eusmtrp2J;
        Wed, 21 Jun 2023 12:02:59 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-ca-6492e6f326ab
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F2.4B.10549.3F6E2946; Wed, 21
        Jun 2023 13:02:59 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621120259eusmtip25a8e9a7a0b25d8e082a564aa74979e59~qqvTaNaeq3272732727eusmtip23;
        Wed, 21 Jun 2023 12:02:59 +0000 (GMT)
Received: from [106.110.32.65] (106.110.32.65) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 13:02:57 +0100
Message-ID: <e9604e71-bfd4-bf72-cb0b-b3dbcc492c3f@samsung.com>
Date:   Wed, 21 Jun 2023 14:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
        Thunderbird/102.11.0
Subject: Re: [RFC 3/4] block: set mapping order for the block cache in
 set_init_blocksize
To:     Hannes Reinecke <hare@suse.de>, <willy@infradead.org>,
        <david@fromorbit.com>
CC:     <gost.dev@samsung.com>, <mcgrof@kernel.org>, <hch@lst.de>,
        <jwong@kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Content-Language: en-US
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <58279efe-141b-5d6b-b319-7bd1a0d5347d@suse.de>
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.65]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87qfn01KMbi/Wd1iy7F7jBZ7Fk1i
        sli5+iiTxbUzPUwWe/aeZLG4vGsOm8WNCU8ZLX7/mMPmwOFxapGEx+YVWh6bVnWyeey+2cDm
        sfl0tcfnTXIBbFFcNimpOZllqUX6dglcGc3v7zMXrGGpWHb3AEsD4yrmLkZODgkBE4lZfZtZ
        uxi5OIQEVjBKzGnYzgjhfGGU6Hp8kx3C+cwosfvcAiaYltk3+5kgEssZJd70bmGCq3q8/wVU
        y05GieUPbrGBtPAK2Em0tR4FSnBwsAioSuz45g4RFpQ4OfMJC4gtKhAt0brsPli5MJC9608z
        K4gtIhAkcbTzFNhMZoFpQDMvXmEESTALiEvcejKfCWQmm4CWRGMnO0iYU8BaYl3zWVaIEnmJ
        7W/nQD2qKDHp5ntWCLtW4tSWW2BHSwh0c0p8nN0E9ZqLROeR7ewQtrDEq+NboGwZif8750PV
        VEs8vfGbGaK5hVGif+d6NpAjJIA2953JATGZBTQl1u/Shyh3lJi88BgLRAWfxI23ghCn8UlM
        2jadeQKj6iykkJiF5LFZSD6YhTB0ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMCU
        dPrf8U87GOe++qh3iJGJg/EQowQHs5IIr+ymSSlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVt
        TyYLCaQnlqRmp6YWpBbBZJk4OKUamAqWyf58dyB7v/M/7+i8q33nfoj/SDP5qZy09JPVg3+/
        DoTJpMirv9ti+VvAfvGW6AcfyxenHctQ+fr+bpP4frHyBXvPWj5oePr0+/Pyc+xNtXMmXuT+
        6+V2f4amzcnoT1a5a6bNiWg/GmyhJVMx3e7N6jM7LF30prQfu7hhT0A4l23Bw3W7/N9xspVp
        KS3jtp+9YGGrdtnev8mil1+cKv62RLp/YyePxMLFky0+Fh/PyNx/NOXJHtl7laUiX1XEF2rf
        OnVj7seMgzs9JnP0z/hVf+h3slZVq0a5j5tA/c+Fomq3a9jKD/woPcohp3VYJFOyjiF4woKC
        juMS3349Y2/i+NC2wLJmCsfHk7tTWNuUWIozEg21mIuKEwFIE/m6uAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsVy+t/xe7qfn01KMfg2gdNiy7F7jBZ7Fk1i
        sli5+iiTxbUzPUwWe/aeZLG4vGsOm8WNCU8ZLX7/mMPmwOFxapGEx+YVWh6bVnWyeey+2cDm
        sfl0tcfnTXIBbFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6Gc3v7zMXrGGpWHb3AEsD4yrmLkZODgkBE4nZN/uZuhi5OIQEljJKfF09kx0iISOx
        8ctVVghbWOLPtS42iKKPjBI7vt6FcnYySlz/tg1sFK+AnURb61Ggbg4OFgFViR3f3CHCghIn
        Zz5hAbFFBaIlVn++ADZUGMje9acZzBYRCJI42nmKHWQms8A0RonlF68wQiy4wSRxsPsNG0gV
        s4C4xK0n85lAFrAJaEk0doJdyilgLbGu+SwrRImmROv23+wQtrzE9rdzoN5UlJh08z3UN7US
        n/8+Y5zAKDoLyX2zkGyYhWTULCSjFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiM5m3H
        fm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeGU3TUoR4k1JrKxKLcqPLyrNSS0+xGgKDKOJzFKiyfnA
        dJJXEm9oZmBqaGJmaWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cDkVO5WKNcjHzQv
        Vc7xzRwOvt/OLlkm2rHh5259elB/5G3mjLnRnT5m4Yc6F2YYTftR1OJVs1i4hanmQPV0+9Wf
        Zxd9ldUvcvJ+UG2/+Ibc1Ltu542sFJn2H1B7K/blzHOOoIITUn80lsznkV38yEDpa/88oakN
        r68+PWQwYxvvzyV/RGrPn5m+ZD2fhOeii7rBJ2es5BaeVnbgYGTBYlb3y1o2674yTz25Ze7F
        3XPCBbcqPmnx5FmzxEhLjvlenLVatvK+w+3dzL8F1sQHv4ndz1B0Pl/kV7e7aKLtrMcf/7EJ
        H8/oC67gmKf+fMcGU/Zvnw7bei85NPHqOtk1jk3KUduiDu9P2Ddvsr7zpJk/lViKMxINtZiL
        ihMB8JOVN28DAAA=
X-CMS-MailID: 20230621120259eucas1p1f0ed07016243bc2ec48b3622e57483b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621083828eucas1p23222cae535297f9536f12dddd485f97b
References: <20230621083823.1724337-1-p.raghav@samsung.com>
        <CGME20230621083828eucas1p23222cae535297f9536f12dddd485f97b@eucas1p2.samsung.com>
        <20230621083823.1724337-4-p.raghav@samsung.com>
        <a25eb5ce-b71c-2a38-d8eb-f8de8b8b449e@suse.de>
        <d275b49a-b6be-a08f-cfd8-d213eb452dd1@samsung.com>
        <58279efe-141b-5d6b-b319-7bd1a0d5347d@suse.de>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


>>
>> Hmm, which aops are you using for the block device? If you are using the old aops, then we will be
>> using helpers from buffer.c and mpage.c which do not support large folios. I am getting a BUG_ON
>> when I don't use iomap based aops for the block device:
>>
> I know. I haven't said that mpage.c / buffer.c support large folios _now_. All I'm saying is that I
> have a patchset enabling it to support large folios :-)
> 

Ah ok! I thought we are not going that route based on the discussion we had in LSF.

> Cheers,
> 
> Hannes
> 
