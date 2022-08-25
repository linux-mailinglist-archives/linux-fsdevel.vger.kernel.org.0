Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E06395A0804
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Aug 2022 06:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbiHYE2F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Aug 2022 00:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiHYE2D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Aug 2022 00:28:03 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A802077566
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Aug 2022 21:28:00 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220825042758epoutp0490e4ce52ee42c15720938fdd0a30b6fc~OfAY_NYP61508515085epoutp04i
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Aug 2022 04:27:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220825042758epoutp0490e4ce52ee42c15720938fdd0a30b6fc~OfAY_NYP61508515085epoutp04i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1661401678;
        bh=JJuWaWBA983uY23liNhORH0Mh82FAHzv6ulhPTviZ4A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n9oBHfGGh+dkZw6T4Io5SHFr1XXKVRF/mMRgEwvfnDdUBor+yfIL6dKEuQ5lYvk3A
         L0VZVc9Vk0vkbFyRMr1srFUHWdbD10Jnro+hDB1IGnu01dcbuEmUv9YgBOCo+dvCa1
         SBXWQJLGuQmEkhohtf1teWiOuBmP/9Ex4D9SrYDU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220825042757epcas5p37271c9b4890ba1ae41c96fc192d5a2a5~OfAYFXIPb2043620436epcas5p31;
        Thu, 25 Aug 2022 04:27:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4MCqhD1C4Cz4x9Q4; Thu, 25 Aug
        2022 04:27:56 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.C0.25709.C4AF6036; Thu, 25 Aug 2022 13:27:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220825042755epcas5p1b74cb6accae9ec3f25cc8d15d313fcbc~OfAWHl5GF0167101671epcas5p1C;
        Thu, 25 Aug 2022 04:27:55 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220825042755epsmtrp222750ad10fa10264323e48d4d19a62bd~OfAWGkW9b1831518315epsmtrp2L;
        Thu, 25 Aug 2022 04:27:55 +0000 (GMT)
X-AuditID: b6c32a49-a71ff7000000646d-d3-6306fa4caa0c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.EA.14392.B4AF6036; Thu, 25 Aug 2022 13:27:55 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220825042753epsmtip22acbe0211b824db0a2630278fd0ae467~OfAUcmvsI0868208682epsmtip29;
        Thu, 25 Aug 2022 04:27:53 +0000 (GMT)
Date:   Thu, 25 Aug 2022 09:48:13 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "hare@suse.de" <hare@suse.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [ANNOUNCE] CFP: Zoned Storage Microconference - Linux Plumbers
 Conference 2022
Message-ID: <20220825041813.GA32607@test-zns>
MIME-Version: 1.0
In-Reply-To: <589cb29e-d2aa-085f-db83-fa718f4fbef2@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHJsWRmVeSWpSXmKPExsWy7bCmhq7PL7Zkg4mX2CymH1a0mPbhJ7PF
        77PnmS32vpvNarFn0SQmi723tC0uPV7BbrFn70kWi8u75rBZTGj7ymxxY8JTRgduj8tXvD02
        repk89jZep/V4/2+q2wefVtWMXpsPl3t8XmTnEf7gW6mAI6obJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoCuVFMoSc0qBQgGJxcVK+nY2RfmlJakK
        GfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCFCdkZv9rvsBccF6iY/OY0UwPjbL4u
        Rk4OCQETiVun37F0MXJxCAnsZpTYtH0eK0hCSOATo0T3Fy2IxDdGiQ2r57LAdLQ+28AGkdjL
        KLG27TwThPOMUeLMr0WMIFUsAqoSB641AdkcHGwCmhIXJpeChEUETCXe9rSCrWMW+MMssfT2
        MWaQhLBArMT6jjVMIDavgK7E1F9f2CBsQYmTM5+AbeYUcJOY9XU3WFxUQFniwLbjYIslBNZy
        SBxuvckEcZ6LxOpFX5khbGGJV8e3sEPYUhKf3+1lg7CTJS7NPAdVXyLxeM9BKNteovVUP1gv
        s0CGxKUV3VA2n0Tv7ydMIM9ICPBKdLQJQZQrStyb9JQVwhaXeDhjCZTtIfGyqZcdHnR3Vs1h
        ncAoNwvJP7OQrICwrSQ6PzSxzgJawSwgLbH8HweEqSmxfpf+AkbWVYySqQXFuempxaYFhnmp
        5fBITs7P3cQITrhanjsY7z74oHeIkYmD8RCjBAezkgiv1TGWZCHelMTKqtSi/Pii0pzU4kOM
        psD4mcgsJZqcD0z5eSXxhiaWBiZmZmYmlsZmhkrivFO0GZOFBNITS1KzU1MLUotg+pg4OKUa
        mCJqHvjydb5d96hSzHhFxmW9vWdjnTYsyY9YKOMSEbJ2wu0FvN6b3m+v+rROqcJJobQvKWb7
        73Ux3h+ZQrcc31x2fPWrxdzGrOfunE7z3bX7kkHG1/MaET72YueWPbD8s/bm/spG6bVzNYum
        zjjoIx/FW6Hy4rHLWuHLTnodXi+17076dFehI1027sVRv5SyH2/LXPX4PgeVvjJcvU2NSSNY
        2UjvQ+2SS01a8ecqXF+EvVzoY2865z77ryP8my7MabKKs2USkLO+N39T+oMpB9Tbth003XrI
        5NCiSUtcUha95d1zQM/ZJaXqfZ7YQp4t+0UXqb6b7L3I79PH84mM871u32s66vqM/XVG7vwP
        +0OVWIozEg21mIuKEwFJCHwWQQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWy7bCSvK73L7Zkg1vrVS2mH1a0mPbhJ7PF
        77PnmS32vpvNarFn0SQmi723tC0uPV7BbrFn70kWi8u75rBZTGj7ymxxY8JTRgduj8tXvD02
        repk89jZep/V4/2+q2wefVtWMXpsPl3t8XmTnEf7gW6mAI4oLpuU1JzMstQifbsEroybf76z
        F/zkrbjwML+B8Tl3FyMnh4SAiUTrsw1sXYxcHEICuxkl1jfcZINIiEs0X/vBDmELS6z89xzM
        FhJ4wijRs84UxGYRUJU4cK2JsYuRg4NNQFPiwuRSkLCIgKnE255WFpCZzAINLBJvTl9nBUkI
        C8RKrO9YwwRi8wroSkz99QVq8TdGibb9GxghEoISJ2c+YQGxmQXMJOZtfsgMsoBZQFpi+T8O
        kDCngJvErK+7we4UFVCWOLDtONMERsFZSLpnIemehdC9gJF5FaNkakFxbnpusWGBYV5quV5x
        Ym5xaV66XnJ+7iZGcPxoae5g3L7qg94hRiYOxkOMEhzMSiK8VsdYkoV4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgmiAaerlQqOTmN07t33MV3aJO1P+z
        sWuZdsv4cpr2um3ZV/pY1t5s5fkgpBGxgYn1eLNqTOwX9ua/AZciLWe9eWzizfF++qacsm+f
        Z1dnWzXFnO/z/q7Hy3Orsc8iJZJns8D0NhmGhm4jle1+2zs5ujLcuO5d/TNJIHXG+2ntAU6H
        PIurt18M2t0tPmPiqRMHwl3aZsRn671vO5d6YjK/2ZtTTN+rHeo4zpYEfZXZr/966aYyM/FZ
        WY7WZ9Vczh2UdTfc/ftQxuJVwf1G6vcWeslzKGcc2px3dn+WWc/317tKnOt1k/c+Cf+sy838
        ePuFv+5Z6xf4la91M66ZHr30KEc4x91HJxsXVK69sqRNiaU4I9FQi7moOBEAaSYJoQ4DAAA=
X-CMS-MailID: 20220825042755epcas5p1b74cb6accae9ec3f25cc8d15d313fcbc
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_a7674_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2
References: <CGME20220522220139uscas1p1e3426b4457e0753c701e9917fe3ec6d2@uscas1p1.samsung.com>
        <20220522220128.GA347919@bgt-140510-bm01>
        <89b2bb4b-1848-22cc-9814-6cb6726afc18@acm.org>
        <589cb29e-d2aa-085f-db83-fa718f4fbef2@opensource.wdc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_a7674_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Aug 24, 2022 at 05:15:28PM -0700, Damien Le Moal wrote:
>On 2022/08/24 16:43, Bart Van Assche wrote:
>> On 5/22/22 15:01, Adam Manzanares wrote:
>>> Zoned Storage Devices (SMR HDDs and ZNS SSDs) have demonstrated that they can
>>> improve storage capacity, throughput, and latency over conventional storage
>>> devices for many workloads. Zoned storage technology is deployed at scale in
>>> some of the largest data centers in the world. There's already a
>>> well-established set of storage vendors with increasing device availability and
>>> a mature software foundation for interacting with zoned storage devices is
>>> available. Zoned storage software support is evolving and their is room for
>>> increased file-system support and additional userspace applications.
>>>
>>> The Zoned Storage microconference focuses on evolving the Linux zoned
>>> storage ecosystem by improving kernel support, file systems, and applications.
>>> In addition, the forum allows us to open the discussion to incorporate and grow
>>> the zoned storage community making sure to meet everyone's needs and
>>> expectations. Finally, it is an excellent opportunity for anyone interested in
>>> zoned storage devices to meet and discuss how we can move the ecosystem forward
>>> together.
>>
>> Hi Adam,
>>
>> On https://protect2.fireeye.com/v1/url?k=755e6c2c-14d5791a-755fe763-000babff9b5d-6defb9d76a932655&q=1&e=e97b90a0-a315-4359-9fee-2976775b532e&u=https%3A%2F%2Flpc.events%2Fevent%2F16%2Fcontributions%2F1147%2F I see four speakers
>> but no agenda? Will an agenda be added before the microconference starts?
>
>And the speaker list is not up-to-date either. I am a speaker too :)

This page shows the agenda: https://lpc.events/event/16/sessions/149/#20220914

------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_a7674_
Content-Type: text/plain; charset="utf-8"


------_GKj2UxOoZMooFpgW.UaNJF5RnPKrhbpXXK.PgNceyCDa.V5=_a7674_--
