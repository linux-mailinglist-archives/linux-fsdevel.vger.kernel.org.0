Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E36B37ED
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 08:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCJH7i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 02:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCJH7f (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 02:59:35 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96806E1923
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 23:59:33 -0800 (PST)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230310075930euoutp01cc89b599aa434ea0f1a125b1eec5ab29~K-_UN2UAW1047410474euoutp01a
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Mar 2023 07:59:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230310075930euoutp01cc89b599aa434ea0f1a125b1eec5ab29~K-_UN2UAW1047410474euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678435170;
        bh=PimTtV2xHIocHqP2C+En+WnmhKxhh5/j7Aded0ia+kU=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=SHMtnsauZtuZy7eARn+dgLJ19MXzT0UwfR5HtREwtRIhNNuKt7WKSY7NlEiWli1Oa
         l6bPN4YbTnfcMaG0woEsMYKspTn1T/ek8afIzbRDJRLAQkYY2sQW17zr3u/M8IdLFG
         CFCpKgNDUto0dGuoIoFSFkDRO5DapC6hosB2PgWg=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230310075930eucas1p16d3608cbea90732ba9c3387ace884cbf~K-_T_7dH41088410884eucas1p1A;
        Fri, 10 Mar 2023 07:59:30 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 70.F0.09503.263EA046; Fri, 10
        Mar 2023 07:59:30 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230310075929eucas1p1063b67e2f0f2d37e4ab75b16b8cf19d5~K-_TpDcqu1087110871eucas1p15;
        Fri, 10 Mar 2023 07:59:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230310075929eusmtrp181b7c3da465b447c055e25d0be4afea0~K-_Tob8dA3126731267eusmtrp1j;
        Fri, 10 Mar 2023 07:59:29 +0000 (GMT)
X-AuditID: cbfec7f2-e8fff7000000251f-b8-640ae362ed3c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E5.A0.09583.163EA046; Fri, 10
        Mar 2023 07:59:29 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230310075929eusmtip1b52b89013e48dc68c336ce29feecca38~K-_TdcQgG1058610586eusmtip1x;
        Fri, 10 Mar 2023 07:59:29 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 10 Mar 2023 07:59:28 +0000
Date:   Fri, 10 Mar 2023 08:59:28 +0100
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        <lsf-pc@lists.linux-foundation.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-block@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] Cloud storage optimizations
Message-ID: <20230310075928.zcuiep3f2vpxbfdo@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djP87pJj7lSDNp2sljsWTSJyWJjP4fF
        pEPXGC323tK22LP3JIvFvTX/WS32vd7LbHFjwlNGi9aen+wWv3/MYXPg8pg26RSbx+YVWh6b
        VnWyeWz6NIndY/KN5YweTWeOMntsPl3t8XmTXABHFJdNSmpOZllqkb5dAlfGhQkfmQqeKVZM
        7P3I0sD4XqqLkZNDQsBE4ta0DrYuRi4OIYEVjBK9K4+zQjhfGCWurDkJ5XxmlNjf9pUZpmXl
        kkfMEInljBJf3zUxwlU1H3sONWwLo8S/F91MIC0sAqoSTy6uYwOx2QTsJS4tuwU2SkTAWuLL
        qgVg3cwC/5gk9nxsYgVJCAMlNs3awwhi8wrYSnx8tpYZwhaUODnzCQuIzSxgJdH5AaSeA8iW
        llj+jwMiLC/RvHU2M0iYUyBYYl1LLsTVShKPX7xlhLBrJU5tucUEslZCYDanxOmfK5kgEi4S
        L28cY4OwhSVeHd/CDmHLSJye3MMCYWdLXDzTDQ2KEonF74+B7ZIAOrnvTA5E2FHia+8TJogw
        n8SNt4IQl/FJTNo2HaqaV6KjTWgCo8osJG/NQvLWLIS3ZiF5awEjyypG8dTS4tz01GLDvNRy
        veLE3OLSvHS95PzcTYzAtHX63/FPOxjnvvqod4iRiYPxEKMEB7OSCO93KY4UId6UxMqq1KL8
        +KLSnNTiQ4zSHCxK4rzatieThQTSE0tSs1NTC1KLYLJMHJxSDUyL6vL3fN1wmOtmtvuahOm+
        J1Jipj968pwx/U2AY+mzKwIP9r0+37Tpm+2GtT8jK/0bmnYVV/bO9ws+JBzLZpibdvlj0YvA
        DcL9v9a4WZquChTIyc++r1A3dY2y0+0lHHMu7f85YXGSleW+ioib55PPMbcKbvz7dnbGFoUn
        sqIb7NtilHcefx6wa06C1pFiPetPun7cCdrWdvfcbyys1D7uutXonPIrxpYHtfpWK1cseX33
        QKTP9Hkf1bbKzmP0Ubr57sqFZ1PO8/5TWLGE99ZiZp3yuO1X5d9nnnMVvt9auazsXGwBpym3
        fgqj2XaTK3EOU/36cyed8z94g/ei3ilW/VWhgt3vTnjd1tAQaTurxFKckWioxVxUnAgA7418
        2soDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsVy+t/xu7qJj7lSDM5s17LYs2gSk8XGfg6L
        SYeuMVrsvaVtsWfvSRaLe2v+s1rse72X2eLGhKeMFq09P9ktfv+Yw+bA5TFt0ik2j80rtDw2
        repk89j0aRK7x+Qbyxk9ms4cZfbYfLra4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MCxM+MhU8U6yY2PuRpYHxvVQXIyeHhICJxMol
        j5i7GLk4hASWMkrcPnaaGSIhI/Hpykd2CFtY4s+1LjaIoo+MEtM6OlghnC2MEuuPnADrYBFQ
        lXhycR0biM0mYC9xadktsLiIgLXEl1ULGEEamAX+MUks33mJFSQhDJTYNGsPI4jNK2Ar8fHZ
        Wqg7lrNIXDn0lgUiIShxcuYTMJtZwEJi5vzzQA0cQLa0xPJ/HBBheYnmrbOZQcKcAsES61py
        Ia5Wknj84i0jhF0r8fnvM8YJjCKzkAydhWToLIShs5AMXcDIsopRJLW0ODc9t9hIrzgxt7g0
        L10vOT93EyMwsrcd+7llB+PKVx/1DjEycTAeYpTgYFYS4f0uxZEixJuSWFmVWpQfX1Sak1p8
        iNEUGEQTmaVEk/OBqSWvJN7QzMDU0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNT
        qoGpk+UNa+2sTgcf1+enO0/f022fUMrIq5IzS7u+596EP2wC3J4F2ydOD+5dlfEsZP6vBz5M
        N5jMP1S92yW+3Oid+JRZxhonm3fwS8s6ZzY7CnUGsfw6aVtweBfv1t3p7zT6zTUY0368dJ1v
        tVPoaPbfHlHzsxqnbqUnfDpw4GZy11vz/S1qS/fZZSmenyK01TQ6avPbT1OZ/PLWNbKHhkSr
        hjtyZ4t+r7TXnOSe4fLaVWX6jCzm2xPeVRd1Wtg/sK5+Z/bzxMIfF2RnLpvWo/w96uellZx6
        JQu4+aOacg+d4jrZ0TpDLU8+9dOLFuOzVxev3LRLft+7qGpl3ZP6s2MPemzt+vlO5LAq1ySf
        f15KLMUZiYZazEXFiQALT+uKdQMAAA==
X-CMS-MailID: 20230310075929eucas1p1063b67e2f0f2d37e4ab75b16b8cf19d5
X-Msg-Generator: CA
X-RootMTR: 20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a
References: <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
        <ZAOF3p+vqA6pd7px@casper.infradead.org>
        <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
        <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
        <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
        <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
        <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
        <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
        <260064c68b61f4a7bc49f09499e1c107e2a28f31.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 09.03.2023 08:11, James Bottomley wrote:
>On Thu, 2023-03-09 at 09:04 +0100, Javier González wrote:
>> On 08.03.2023 13:13, James Bottomley wrote:
>> > On Wed, 2023-03-08 at 17:53 +0000, Matthew Wilcox wrote:
>> > > On Mon, Mar 06, 2023 at 11:12:14AM -0500, Theodore Ts'o wrote:
>> > > > What HDD vendors want is to be able to have 32k or even 64k
>> > > > *physical* sector sizes.  This allows for much more efficient
>> > > > erasure codes, so it will increase their byte capacity now that
>> > > > it's no longer easier to get capacity boosts by squeezing the
>> > > > tracks closer and closer, and their have been various
>> > > > engineering tradeoffs with SMR, HAMR, and MAMR.  HDD vendors
>> > > > have been asking for this at LSF/MM, and in othervenues for
>> > > > ***years***.
>> > >
>> > > I've been reminded by a friend who works on the drive side that a
>> > > motivation for the SSD vendors is (essentially) the size of
>> > > sector_t. Once the drive needs to support more than 2/4 billion
>> > > sectors, they need to move to a 64-bit sector size, so the amount
>> > > of memory consumed by the FTL doubles, the CPU data cache becomes
>> > > half as effective, etc. That significantly increases the BOM for
>> > > the drive, and so they have to charge more.  With a 512-byte LBA,
>> > > that's 2TB; with a 4096-byte LBA, it's at 16TB and with a 64k
>> > > LBA, they can keep using 32-bit LBA numbers all the way up to
>> > > 256TB.
>> >
>> > I thought the FTL operated on physical sectors and the logical to
>> > physical was done as a RMW through the FTL?  In which case sector_t
>> > shouldn't matter to the SSD vendors for FTL management because they
>> > can keep the logical sector size while increasing the physical one.
>> > Obviously if physical size goes above the FS block size, the drives
>> > will behave suboptimally with RMWs, which is why 4k physical is the
>> > max currently.
>> >
>>
>> FTL designs are complex. We have ways to maintain sector sizes under
>> 64 bits, but this is a common industry problem.
>>
>> The media itself does not normally oeprate at 4K. Page siges can be
>> 16K, 32K, etc.
>
>Right, and we've always said if we knew what this size was we could
>make better block write decisions.  However, today if you look what
>most NVMe devices are reporting, it's a bit sub-optimal:
>
>jejb@lingrow:/sys/block/nvme1n1/queue> cat logical_block_size
>512
>jejb@lingrow:/sys/block/nvme1n1/queue> cat physical_block_size
>512
>jejb@lingrow:/sys/block/nvme1n1/queue> cat optimal_io_size
>0
>
>If we do get Linux to support large block sizes, are we actually going
>to get better information out of the devices?

We already have this through the NVMe Optimal Performance parameters
(see Dan's response for this). Note that these values are already
implemented in the kernel. If I recall properly, Bart was the one doing
this work.

More over, from the vendor side, it is a challenge to expose larger LBAs
without wide support in OSs. I am confident that if we are pushing for
this work and we see it fits existing FSs, we will see vendors exposing
new LBA formats in the beginning (same as we have 512b and 4K in the
same drive), and eventually focusing only on larger LBA sizes.

>
>>  Increasing the block size would allow for better host/device
>> cooperation. As Ted mentions, this has been a requirement for HDD and
>> SSD vendor for years. It seems to us that the time is right now and
>> that we have mechanisms in Linux to do the plumbing. Folios is
>> ovbiously a big part of this.
>
>Well a decade ago we did a lot of work to support 4k sector devices.
>Ultimately the industry went with 512 logical/4k physical devices
>because of problems with non-Linux proprietary OSs but you could still
>use 4k today if you wanted (I've actually still got a working 4k SCSI
>drive), so why is no NVMe device doing that?

Most NVMe devices report 4K today. Actually 512b is mostly an
optimization targeted at read-heavy workloads.

>
>This is not to say I think larger block sizes is in any way a bad idea
>... I just think that given the history, it will be driven by
>application needs rather than what the manufacturers tell us.

I see more and more that this deserves a session at LSF/MM
