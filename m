Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC46F52E84A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 11:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiETJHG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 05:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347546AbiETJHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 05:07:03 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A42713C357
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 02:07:01 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220520090659euoutp0259007e3c9ccf421f0d1549751df6f7e4~wxPTi0Aja1108711087euoutp028
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 09:06:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220520090659euoutp0259007e3c9ccf421f0d1549751df6f7e4~wxPTi0Aja1108711087euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653037619;
        bh=7sUENLoCJCYs1MSYcCbbd75YbMDrAHaelawSM1l7SHo=;
        h=Date:Subject:To:CC:From:In-Reply-To:References:From;
        b=U83b2tqKHnKKza0eNrjooK0Gqmpuqkt3920Uitjbn4gdgQQdjZU7jem4VnboYRXna
         ArdQRocEFlAEG9LIitKHQtNlq0D5G5/Ak6NfWqOGBVJb4fDDI0Upxui8KlE5l8dwMd
         AfAQPCPWAr0TiU9OVIrPc60cAsNJb9StPy9f8Ous=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220520090658eucas1p19241042c1d4d4bf5821401c597a1af02~wxPTNJ9M-0637606376eucas1p1x;
        Fri, 20 May 2022 09:06:58 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 42.2D.10009.23A57826; Fri, 20
        May 2022 10:06:58 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520090658eucas1p1b33f4cb964566691674c4b015509ceec~wxPS0eI0V3138931389eucas1p1D;
        Fri, 20 May 2022 09:06:58 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520090658eusmtrp1fc09ac06a8697122e1bebb8cc020ff52~wxPSzj_us2148821488eusmtrp1T;
        Fri, 20 May 2022 09:06:58 +0000 (GMT)
X-AuditID: cbfec7f2-e7fff70000002719-2a-62875a32e7b5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.BC.09522.23A57826; Fri, 20
        May 2022 10:06:58 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520090658eusmtip198be26f25d7bc7783e6b666edad5d54a~wxPSqRLcC1273112731eusmtip1c;
        Fri, 20 May 2022 09:06:58 +0000 (GMT)
Received: from [192.168.8.130] (106.210.248.20) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 20 May 2022 10:06:56 +0100
Message-ID: <2252c3b2-0f65-945e-dc39-c0726bce72e8@samsung.com>
Date:   Fri, 20 May 2022 11:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [PATCH v4 08/13] btrfs:zoned: make sb for npo2 zone devices
 align with sb log offsets
Content-Language: en-US
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>,
        "pankydev8@gmail.com" <pankydev8@gmail.com>,
        "dsterba@suse.com" <dsterba@suse.com>, "hch@lst.de" <hch@lst.de>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "jiangbo.365@bytedance.com" <jiangbo.365@bytedance.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
From:   Pankaj Raghav <p.raghav@samsung.com>
In-Reply-To: <PH0PR04MB7416FF84CE207FEC3ED8912F9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.210.248.20]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFKsWRmVeSWpSXmKPExsWy7djP87pGUe1JBi9uGVusvtvPZvH77Hlm
        i73vZrNaXPjRyGSx+Pd3FouVq48yWfQc+MBi8bfrHpPF3lvaFpcer2C32LP3JIvF5V1z2Czm
        L3vKbrHm5lMWBz6PfyfWsHnsnHWX3ePy2VKPzUvqPXbfbACKtN5n9Xi/7yqbx/otV1k8ziw4
        wu7xeZOcR/uBbqYA7igum5TUnMyy1CJ9uwSujL9f7jMVnOKuWLbqIksD40TOLkYODgkBE4kz
        P7O6GLk4hARWMEocOzSLDcL5wiix+PURFgjnM6PEtv/3gDKcYB3fT/2CqlrOKDHjbD8bXNXt
        TV+YIJxdjBKTlz5mB2nhFbCTeLS1A8xmEVCVWLNwJSNEXFDi5MwnLCC2qECExLRZZ9hAjhIW
        SJHYsbIIJMwsIC5x68l8JpCwiECUxK93ASDjmQUOs0psOnuOFSTOJqAl0djJDmJyCsRKfP/h
        C9GpKdG6/Tc7hC0vsf3tHGaIj5Uktv0ygXilVmLtsTPsIBMlBO5xSky88Y0dIuEisX/2IyYI
        W1ji1fEtUHEZidOTe1gg7GqJpzd+M0M0tzBK9O9czwaxwFqi70wORI2jxKVvn6H28knceCsI
        cQ6fxKRt05knMKrOQgqGWUj+nYXkg1lIPljAyLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/
        dxMjMPmd/nf80w7Gua8+6h1iZOJgPMQowcGsJMLLmNuSJMSbklhZlVqUH19UmpNafIhRmoNF
        SZw3OXNDopBAemJJanZqakFqEUyWiYNTqoEpQ2Dqnx+JRanq3I1XvVZM2b/zQnodu4NsqUmX
        XmqfK8uDX5JOAs+Vc+YemHcy2eK67v+wuSrft+w3+LvQOc6W81LyAX7tt7WnGvdwsEa8nhp7
        KSCKYyPrcl6bQPsrUf1F/itWen26xrZJKk6Q9522cO+04ohnlis+Xg4xsXofoxSsv0Al+Yht
        U4n5xGZL3mKOpfn7tqQ8b7FMiHm+NveK05xlEzou+27+7vRlj+mPd9+qOBx2briXzNZqe5y5
        VHrXIxWriUKyW9Q9OrzVOgVblvmezw7xNc57w1c2kTevkd9ZfK9gyNwJXJPmxQr6yLB2hR36
        2ZTSV6T2carCujez14vdzwj4nPtzRtYpDSWW4oxEQy3mouJEAI6rGDvtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42I5/e/4XV2jqPYkg7ezpC1W3+1ns/h99jyz
        xd53s1ktLvxoZLJY/Ps7i8XK1UeZLHoOfGCx+Nt1j8li7y1ti0uPV7Bb7Nl7ksXi8q45bBbz
        lz1lt1hz8ymLA5/HvxNr2Dx2zrrL7nH5bKnH5iX1HrtvNgBFWu+zerzfd5XNY/2WqyweZxYc
        Yff4vEnOo/1AN1MAd5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJext8v95kKTnFXLFt1kaWBcSJnFyMnh4SAicT3U7/Yuhi5OIQEljJKzDy7hh0i
        ISPx6cpHKFtY4s+1LjYQW0jgI6PEuhfKEA27GCUWnO8GK+IVsJN4tLUDzGYRUJVYs3AlI0Rc
        UOLkzCcsILaoQITEg91nWUFsYYEUiUefZoPZzALiEreezGfqYuTgEBGIkvj1LgAifJhVYtcS
        cYhdH5gkHt+axgJSwyagJdHYyQ5icgrESnz/4QtRrinRuv03O4QtL7H97RxmkBIJASWJbb9M
        ID6plXh1fzfjBEbRWUhum4XkhllIJs1CMmkBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT83E2M
        wJSx7djPzTsY5736qHeIkYmD8RCjBAezkggvY25LkhBvSmJlVWpRfnxRaU5q8SFGU2AATWSW
        Ek3OByatvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpuhgPda3
        v54fzDnk17HzgM7sJXNPscZfP5Eh/EB7efPOEtOQn9XV1zy+fyr/d4Dr7tqTy59YC5oe+n5x
        9vI5OUm3eKYdkbabvm67x4Nv37ddC+lXlgp5s2ftbgPOma8zprFs0o4O3j4l9v0BJk4tywL9
        KcdaPO+8D/khVXjqWffhv1NOhF/+J+TBrR7F/YvvIGf+Vu4HzyQcPq//kmZc03uSIaYjzDVp
        xvu+6gm//fZ4u557nDol7bdqwr79l36u+Pax9c7igDkmMmlqVzTbZhZM/rEs8ejcjTZ/toRL
        vzXiOi/VZqZvmV51drLJUrO3kZsu7M/mzT3r5+Zkt/VtxwJVCR37c4pTXulc82EJ29StxFKc
        kWioxVxUnAgA6L2ujKIDAAA=
X-CMS-MailID: 20220520090658eucas1p1b33f4cb964566691674c4b015509ceec
X-Msg-Generator: CA
X-RootMTR: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165429eucas1p272c8b4325a488675f08f2d7016aa6230@eucas1p2.samsung.com>
        <20220516165416.171196-9-p.raghav@samsung.com>
        <20220517124257.GD18596@twin.jikos.cz>
        <717a2c83-0678-9310-4c75-9ad5da0472f6@samsung.com>
        <PH0PR04MB7416FF84CE207FEC3ED8912F9BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/19/22 09:57, Johannes Thumshirn wrote:
>> Unfortunately it is not possible to just move the WP in zoned devices.
>> The only alternative that I could use is to do write zeroes which are
>> natively supported by some devices such as ZNS. It would be nice to know
>> if someone had a better solution to this instead of doing write zeroes
>> in zoned devices.
>>
> 
> I have another question. In case we need to pad the sb zone with a write
> zeros and have a power fail between the write-zeros and the regular 
> super-block write, what happens? I know this padding is only done for the
> backup super blocks, never the less it can happen and it can happen when
> the primary super block is also corrupted.
> 
> AFAIU we're then trying to reach out for a backup super block, look at the
> write pointer and it only contains zeros but no super block, as only the 
> write-zeros has reached the device and not the super block write.
> 
> How is this situation handled?
> 
That is a very good point. I did think about this situation while adding
padding to the mirror superblock with write zeroes. If the drive is
**less than 4TB** and with the **primary superblock corrupted**, then it
will be an issue with the situation you have described for npo2 drives.
That situation is not handled here. Ofc this is not an issue when we
have the second mirror at 4TB for bigger drives. Do you have some ideas
in mind for this failure mode?
> Thanks,
> 	Johannes
