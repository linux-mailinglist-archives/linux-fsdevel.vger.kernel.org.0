Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056035180B2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 May 2022 11:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbiECJPq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 May 2022 05:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbiECJPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 May 2022 05:15:44 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E739D1835B
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 02:12:11 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220503091209euoutp01c11affcfb71328f0336275009a1eecc1~rjV90HdSr0895608956euoutp01u
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 May 2022 09:12:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220503091209euoutp01c11affcfb71328f0336275009a1eecc1~rjV90HdSr0895608956euoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651569129;
        bh=IRf3vJRWgQgo7b9PQAgoElxFlgi3dHo9QSeeAL1/pvk=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=WAUeVszzWW7un0rLGOvQSUtwgzJkT0zfV3lFsVfU6kwYM7/aDAPK4K7wZHzft66kP
         TL19ob1LB4LKvFJj/eQjwYYagvBXwfUgfr0qrImN747RpJYIy+DJfkY8rrMNKtns3l
         daNko/D0mFUsNo3pdE0LpsG8NUXL7zGYLOxXT0Hk=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220503091208eucas1p1ad5c611652cba012530519c5e24823cc~rjV9RGgOw0201902019eucas1p16;
        Tue,  3 May 2022 09:12:08 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 64.C8.09887.8E1F0726; Tue,  3
        May 2022 10:12:08 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220503091208eucas1p1cea931169fd910bd02f1de6d79a10d3c~rjV82hCoz0339703397eucas1p1h;
        Tue,  3 May 2022 09:12:08 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220503091208eusmtrp2c917ae498f4cf3801576f009a47b084c~rjV8zlopc1059410594eusmtrp2Z;
        Tue,  3 May 2022 09:12:08 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-65-6270f1e8de5e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 23.F9.09522.8E1F0726; Tue,  3
        May 2022 10:12:08 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220503091208eusmtip159597f8d3e9ac33c0b07ef5f593ee926~rjV8kr5Ci1917519175eusmtip1Z;
        Tue,  3 May 2022 09:12:08 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.170) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 3 May 2022 10:12:05 +0100
Message-ID: <a702c7f7-9719-9f3e-63de-1e96f2912432@samsung.com>
Date:   Tue, 3 May 2022 11:12:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH 00/16] support non power of 2 zoned devices
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "dsterba@suse.com" <dsterba@suse.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "clm@fb.com" <clm@fb.com>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "jonathan.derrick@linux.dev" <jonathan.derrick@linux.dev>,
        "agk@redhat.com" <agk@redhat.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "kch@nvidia.com" <kch@nvidia.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        =?UTF-8?Q?Matias_Bj=c3=b8rling?= <Matias.Bjorling@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB74167FC8BA634A3DA09586489BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.170]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0xTZxje13N6eqjWHaobn8WAgc0NFio6E78EAls08yjhIrtETIwUPFKy
        UrGFTSE4WHHMjktB7baKwowDBOXaCEVgG4Sb0NVwG+CsNW0j3koJlQxxMMrBhX/P8z7v877v
        8+UjMaGeEJHJ8jRGIZfI/Ag+fqtn/s+gqZnUhOC2l2JUd6cHQzX3iwikdc5jaOCikYNKin7i
        oQWjCUPtjktcdPefHA66XtPNQbY6HYbyf3fi6F+1ebmW+xBDrx7uQCWdYwDZR3Uc1D75ARqy
        VvHQ0NV9qK29H0fDraUEKquw85DmuxcYGtfYASrubeKi2qfTOOqb9P7Imx4eiaAX+24QdLHK
        waNN5gacHjam043V5wj6l+yLGN107Rv6dvksh749kU3QBSoHQRvOPuDS0x2jBF2nH8VpTVMD
        l55t9InxPMwPPcbIkr9iFNvD4vnS+h+e4al9glPO+gYsG6jWqYEHCald8LJmAlMDPimkqgC8
        fP4KlyUuAAeqKwmWzAKY21zDeW1prewCbiykKgFsefnZ/01XH1u5rNAK4AtHhBsLqDCY12Fe
        MeDUO9BQbOSxdU/Y/7MNd+O3qENQqxsk3HgjFQ5vtrpWlmGUF5y0lXHcCzZRLRicKLmBuwlG
        dfNg7auqZUKSBBUIc86tDPWgjsCK61qMNQfAs80LPBb7wubnpRibwB+eHx9ZTZMFb/YM8twz
        IWXhwzt3XavCXtjUqiVYvBE+6dXzWLwFLhnKVnsyoX18AWPNuQAWGeoI90GQCoGFgzK252No
        KbBx2fIGOP7ck71nAyy59SOmAe/q1ryFbk1m3ZoIujURygFeDbyYdGVKEqPcKWe+FislKcp0
        eZI48URKI1j+2AOLva4WUPlkRtwJOCToBJDE/DYJ9vyamiAUHJOczmAUJ44q0mWMshN4k7if
        lyAxuV4ipJIkacyXDJPKKF6rHNJDlM3J2PxFkDXbIZ2bD45WffLeVMibuwe21eQRkWEHrL1F
        enPs4z2Bn4emaeOuNS8eMEjDCym7/3Dc0r0zIv/JU9+Xh57M+wNcCO9biBbxG2o884NC1umi
        17syhQJLlGl77BF5573aeGQMWdw/59nuY4tdyg12xriMXuoAUV6p76fCmAdO9f2OMybQZvpw
        r8g5158Q231QxFUP1W/j0wFRskstb+viD78xmJORL+eHVO88FDmTeTzqW/NYYfe+9VmV4oou
        xd/6rJHIhqmtidODT1vi/lI+K39/9gJVYLYe79oda/nNawbzUfuqYrYEp3T5PqqF+UctJ0vH
        T49tlkbsekTu98OVUsmOQEyhlPwHcH1JrkcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsVy+t/xu7ovPhYkGey8x2+x/tQxZovVd/vZ
        LKZ9+MlscXrqWSaLSf0z2C1+nz3PbLH33WxWiws/GpksVq4+ymTxZP0sZoueAx9YLP523QOK
        tTxktvjz0NBi0qFrjBZPr85isth7S9vi0uMV7BaXFrlb7Nl7ksXi8q45bBbzlz1lt5jQ9pXZ
        4saEp4wWE49vZrVY9/o9i8WJW9IO0h6Xr3h7/Duxhs1jYvM7do/z9zayeFw+W+qxaVUnm8fC
        hqnMHpuX1HvsXvCZyWP3zQY2j97md2weO1vvs3q833eVzWP9lqssHhM2b2T1+LxJLkAwSs+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9jQ/cbloIT
        vBUfNmxkbmBs5u5i5OSQEDCR2LX8MGMXIxeHkMBSRonzD9qYIBIyEp+ufGSHsIUl/lzrYoMo
        +sgocXbLAmYIZxejxMrWpWAdvAJ2Eu377jGC2CwCKhI7J55lh4gLSpyc+YQFxBYViJB4sPss
        K4gtLGAvsXbXF7BeZgFxiVtP5jOBDBUR2MYssXbKebANzAKH2SU+7t3MDrHuIaPE7Pczgco4
        ONgEtCQaO8E2cArESixbOY0ZYpKmROv23+wQtrzE9rdzmCF+UJaYfOMK1G+1Eq/u72acwCg6
        C8mBs5AcMgvJqFlIRi1gZFnFKJJaWpybnltsqFecmFtcmpeul5yfu4kRmOq2Hfu5eQfjvFcf
        9Q4xMnEwHmKU4GBWEuF1XlqQJMSbklhZlVqUH19UmpNafIjRFBhKE5mlRJPzgck2ryTe0MzA
        1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qBSWv7S9WNHwXkQ2z7F83ZZLb5
        2irRmZo7P8496uVr/nVSLqdho0HPxgBj67s8H7fdNTCbcTA3+ssq/ryO1rBPdx6I2x8/FmS8
        xljyQvJqx/Pvb0YvbZj+v9ropMHcP+VL+q4aMWhxn+t3cJK/tLrtdo0Av9GO87tKG5k1Pcov
        Nre3s6/gVarldBFnq9admtpzP7cvUPbUS8n/fbwRros02bw598+3XP5e+8Hxto8nVI4snW4e
        rbH8VXtySDTj38m89QoFcjfzXn5cu9n8g6VElsl85tNVzLvrnXQCN264e/+qsf35TNW777yP
        a3scy60TDRVj0o5Yecbxx5tbt+2v37C8+0Bxin2KcX2ctvF6JZbijERDLeai4kQArWmSZP4D
        AAA=
X-CMS-MailID: 20220503091208eucas1p1cea931169fd910bd02f1de6d79a10d3c
X-Msg-Generator: CA
X-RootMTR: 20220427160256eucas1p2db2b58792ffc93026d870c260767da14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220427160256eucas1p2db2b58792ffc93026d870c260767da14
References: <CGME20220427160256eucas1p2db2b58792ffc93026d870c260767da14@eucas1p2.samsung.com>
        <20220427160255.300418-1-p.raghav@samsung.com>
        <PH0PR04MB74167FC8BA634A3DA09586489BC19@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Johannes,
On 2022-05-03 00:07, Johannes Thumshirn wrote:
>> There was an effort previously [1] to add support to non po2 devices via
>> device level emulation but that was rejected with a final conclusion
>> to add support for non po2 zoned device in the complete stack[2].
> 
> Hey Pankaj,
> 
> One thing I'm concerned with this patches is, once we have npo2 zones (or to be precise 
> not fs_info->sectorsize aligned zones) we have to check on every allocation if we still 
> have at least have fs_info->sectorsize bytes left in a zone. If not we need to 
> explicitly finish the zone, otherwise we'll run out of max active zones. 
> 
This commit: `btrfs: zoned: relax the alignment constraint for zoned
devices` makes sure the zone size is BTRFS_STRIPE_LEN aligned (64K). So
even the npo2 zoned device should be aligned to `fs_info->sectorsize`,
which is typically 4k.

This was one of the comment that came from David Sterba:
https://lore.kernel.org/all/20220315142740.GU12643@twin.jikos.cz/
where he suggested to have some sane alignment for the zone sizes.

> This is a problem for zoned btrfs at the moment already but it'll be even worse
> with npo2, because we're never implicitly finishing zones.
> 
> See also 
> https://lore.kernel.org/linux-btrfs/42758829d8696a471a27f7aaeab5468f60b1565d.1651157034.git.naohiro.aota@wdc.com
> 
I did take a look at this few days back and the patch should work fine
also for npo2 zoned device as we allow only zone sizes that are
BTRFS_STRIPE_LEN aligned. So even the max nodesize for METADATA BGs is
only 64k and it should be aligned correctly to implicitly finish the zone.

Let me know your thoughts and if I am missing something.

Regards,
Pankaj
