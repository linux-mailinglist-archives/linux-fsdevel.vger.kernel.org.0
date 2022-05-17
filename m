Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0B6529B9D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 May 2022 10:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbiEQIAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 May 2022 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiEQIAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 May 2022 04:00:48 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10CBABAF
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 01:00:44 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220517080042euoutp0246c2f2cf8ce93d312213b91995e9d4ee~v1ZlcPaGs1437014370euoutp029
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 May 2022 08:00:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220517080042euoutp0246c2f2cf8ce93d312213b91995e9d4ee~v1ZlcPaGs1437014370euoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652774442;
        bh=yglOEuSU1lFPYZ9DIoa/RozAcsJgPnXMY812PmqC9rM=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=KdrOyalv2M25US8CNt7D8QdtJI+uk+zopvXERKtIxyLZ14iZYKeb/RCzDavpXrOU8
         /dN12LYP4zNoMVwajK6mOubcCKXa2bVCcwZtzcY1kxDnopyE1vsPAkD9S2jNu1IOXT
         SP1hlK7gHL+B4ui7CdMgmrTEX9L3vbkM/26F7E/Q=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220517080041eucas1p24bc8b50fe287967bcd8dc73669c11d32~v1Zkg2fD-0241602416eucas1p2j;
        Tue, 17 May 2022 08:00:41 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id B6.44.10009.92653826; Tue, 17
        May 2022 09:00:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220517080041eucas1p227e0a5d81f7b9b018c2e8f38b74d3aff~v1ZkEScpL1149811498eucas1p2k;
        Tue, 17 May 2022 08:00:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220517080041eusmtrp25e844b307bbeb73179ae75e18bd42416~v1ZkDZe662741427414eusmtrp2B;
        Tue, 17 May 2022 08:00:41 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-1f-62835629f1a7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 26.48.09522.92653826; Tue, 17
        May 2022 09:00:41 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220517080041eusmtip14c1a1beb38bfd07fa000460be6ca25fa~v1Zj2h0za1378313783eusmtip1b;
        Tue, 17 May 2022 08:00:41 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.7) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 17 May 2022 09:00:39 +0100
Message-ID: <8fc4e862-fa89-2d8d-b340-27a6465b59ca@samsung.com>
Date:   Tue, 17 May 2022 10:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB7416DFEC00A21B533E86110E9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.7]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMKsWRmVeSWpSXmKPExsWy7djPc7qaYc1JBqf3mFisvtvPZvH77Hlm
        i73vZrNaXPjRyGSxcvVRJoueAx9YLP523WOy2HtL2+LS4xXsFnv2nmSxuLxrDpvF/GVP2S3W
        3HzK4sDr8e/EGjaPnbPusntcPlvqsXlJvcfumw1Akdb7rB7v911l81i/5SqLx+dNch7tB7qZ
        AriiuGxSUnMyy1KL9O0SuDJ6dl9gK2jnqli49zdTA+M/9i5GTg4JAROJgzP+MHYxcnEICaxg
        lLjZ84QJwvnCKHF2zTwWCOczo8SGV88YYVrmzPnLCpFYzijx9MQadriqLzsusEE4Oxklrrev
        YwFp4RWwk7gz4SqYzSKgKtE2u4cVIi4ocXLmE7C4qECExLRZZ4CaOTiEBVIkdqwsAgkzC4hL
        3HoynwnEFhGYxiRxdKsVRPwRs8T2I0Eg5WwCWhKNnWD/cArEShyd95YdokRTonX7byhbXmL7
        2znMEA8oStxc+YsNwq6VWHvsDNj9EgLnOCVaGxdDFblI3HzayAphC0u8Or4FGmAyEv93Qtwj
        IVAt8fTGb2aI5hZGif6d68HulxCwlug7kwNR4yhx6dtnZogwn8SNt4IQ9/BJTNo2nXkCo+os
        pICYheTjWUhemIXkhQWMLKsYxVNLi3PTU4sN81LL9YoTc4tL89L1kvNzNzEC093pf8c/7WCc
        ++qj3iFGJg7GQ4wSHMxKIrwGFQ1JQrwpiZVVqUX58UWlOanFhxilOViUxHmTMzckCgmkJ5ak
        ZqemFqQWwWSZODilGpjUrwWtnpxQY3PPcJ1rxL/fRnF1l/6cnsx8vU12nTC75daI3SV/Hp04
        9i7yygrlleyHL/54sOASg1cNy77JT5pPZ/29dfLF3OgP8Tpv/0pbpdV1+ws8PhkQLqPQkvmz
        4v1+jss+0ZbNF+ZEWUy6xlM3M+9rX2Pe9zhzK69ZxSIvan0t3hu+m123aWaJznWhMLu929eI
        P/m8o7bZapPA8rSmfaES69borV+40rtA2v7HW7/d2fwtqeXNnxbNFjVIm1ds1KhieGTH/eCN
        Ptf/Fh1Z9eep/nXO9PoWkdPv7y6oD3plUbkhev6MI0oyjzXK3kglzpjeFcHFw+P1srd4uucR
        6+/V0Y0blXaa7itLM2hUYinOSDTUYi4qTgQAjB1Qu+YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgleLIzCtJLcpLzFFi42I5/e/4XV3NsOYkg4bLQhar7/azWfw+e57Z
        Yu+72awWF340MlmsXH2UyaLnwAcWi79d95gs9t7Strj0eAW7xZ69J1ksLu+aw2Yxf9lTdos1
        N5+yOPB6/Duxhs1j56y77B6Xz5Z6bF5S77H7ZgNQpPU+q8f7fVfZPNZvucri8XmTnEf7gW6m
        AK4oPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYye
        3RfYCtq5Khbu/c3UwPiPvYuRk0NCwERizpy/rCC2kMBSRok5P7kh4jISn658hKoRlvhzrYsN
        ouYjo8T7P8pdjFxA9k5GiSkXzzGBJHgF7CTuTLjKAmKzCKhKtM3uYYWIC0qcnPkELC4qECHx
        YPdZsLiwQIrEo0+zwWxmAXGJW0/mg80REZjGJHF0qxXIAmaBB8wSaw5+YIbYNolJYsaLXqAz
        ODjYBLQkGjvBruMUiJU4Ou8tO8QgTYnW7b+hbHmJ7W/nMEN8oChxc+UvNgi7VuLV/d2MExhF
        ZyG5bxaSO2YhGTULyagFjCyrGEVSS4tz03OLDfWKE3OLS/PS9ZLzczcxApPEtmM/N+9gnPfq
        o94hRiYOxkOMEhzMSiK8BhUNSUK8KYmVValF+fFFpTmpxYcYTYGBNJFZSjQ5H5im8kriDc0M
        TA1NzCwNTC3NjJXEeT0LOhKFBNITS1KzU1MLUotg+pg4OKUamMIdPqa7JbyZpmDiyaW8iMOJ
        ccJv7QAGqdnV8QdjNbZlmxw57cxnVvqwLXTj6b8e899V/Q7fH2J19eJPbpV9VR7b7rwNvsaz
        csbqj9f28Cz7EdN8bvmPKcI/zvJ9eh0x5eXC8xNsI3QDV0+IuFm44NqcgIoL61k31r+94Sv+
        yyZzTtz5HN0szWObGtIPb9fKVLi69I60Ro7/uw8x5lkrzu/4eUKQa86PmHlTRa+6/yr/G/o6
        QPPOJV4H5dduZ6fdryvXKwl9Ej13V0dxqcme3ZnTNn8+McObaUXpVt+rq9j4mnbwfHJj2Ry4
        xLS2V7/U6sbd7eZP7UO53l7Q/RMR96JDW/FO+sLN5xaGLft767ipEktxRqKhFnNRcSIAYEKl
        5JsDAAA=
X-CMS-MailID: 20220517080041eucas1p227e0a5d81f7b9b018c2e8f38b74d3aff
X-Msg-Generator: CA
X-RootMTR: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
        <20220516165416.171196-9-p.raghav@samsung.com>
        <PH0PR04MB7416DFEC00A21B533E86110E9BCE9@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2022-05-17 08:50, Johannes Thumshirn wrote:
> On 16/05/2022 18:55, Pankaj Raghav wrote:
>> Superblocks for zoned devices are fixed as 2 zones at 0, 512GB and 4TB.
>> These are fixed at these locations so that recovery tools can reliably
>> retrieve the superblocks even if one of the mirror gets corrupted.
>>
>> power of 2 zone sizes align at these offsets irrespective of their
>> value but non power of 2 zone sizes will not align.
>>
>> To make sure the first zone at mirror 1 and mirror 2 align, write zero
>> operation is performed to move the write pointer of the first zone to
>> the expected offset. This operation is performed only after a zone reset
>> of the first zone, i.e., when the second zone that contains the sb is FULL.
> 
> Hi Pankaj, stupid question. Npo2 devices still have a zone size being a 
> multiple of 4k don't they?
> 
> If not, we'd need to also have a tail padding of the superblock zones, in order
> to move the WP of these zones to the end, so the sb-log states match up.
Hi Johannes,
NPO2 zoned devices has a minimum alignment requirement of 1MB. See
commit: `btrfs: zoned: relax the alignment constraint for zoned devices`

It will naturally align to 4k. So I don't think we need special handling
there with tail padding.
