Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CD16B1D48
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Mar 2023 09:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCIIEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Mar 2023 03:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCIIEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:04:42 -0500
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AEC61ABC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 00:04:38 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230309080436euoutp0203466c55b978aba05a004438cfb2267d~KsZe4-KjX3198031980euoutp02t
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Mar 2023 08:04:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230309080436euoutp0203466c55b978aba05a004438cfb2267d~KsZe4-KjX3198031980euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678349076;
        bh=JuaC8xy+LESWr72k9kG7on+4+U/x14WcXmhVPg6qWoY=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=BGReSbmPjwLCXUUAlVMN02h7+J8fuglVW1do27w6KijZ9XXUrNJAPcHtt7smrTp1+
         kYOx0SHqORCoiTOYX95Gi52ccwocQnrdL5gr8SzPmhUrvWYuQHfKvTN+U7LgIWQtJq
         0KEC85OLkIQgpYJhaX/eUNeSmQGB7VeNCRYejajw=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230309080436eucas1p2976b5a51e92d229a32b814e06789ae17~KsZeqbn1f0485004850eucas1p2Z;
        Thu,  9 Mar 2023 08:04:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2C.8F.10014.31399046; Thu,  9
        Mar 2023 08:04:36 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230309080435eucas1p27d38e373074eeedee7e01db6dc6bac63~KsZeTeRsW0485404854eucas1p2f;
        Thu,  9 Mar 2023 08:04:35 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230309080435eusmtrp24d695ac77fe86041d6800de52629a7e5~KsZeSbJ_e1984219842eusmtrp2L;
        Thu,  9 Mar 2023 08:04:35 +0000 (GMT)
X-AuditID: cbfec7f5-b8bff7000000271e-81-6409931331c7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 2A.06.08862.31399046; Thu,  9
        Mar 2023 08:04:35 +0000 (GMT)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230309080435eusmtip2e00b4ae933e6792446c2c2e348367c28~KsZeGEsC43221532215eusmtip2C;
        Thu,  9 Mar 2023 08:04:35 +0000 (GMT)
Received: from localhost (106.110.32.122) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 9 Mar 2023 08:04:34 +0000
Date:   Thu, 9 Mar 2023 09:04:34 +0100
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
Message-ID: <20230309080434.tnr33rhzh3a5yc5q@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
X-Originating-IP: [106.110.32.122]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGc2fa6W2T6rSC3qBobHgCRUWiA7hhiPbFRENAY6JS6UjBUrCL
        4o4IKOCCJYqWRggiVETQQhWTooJSaCEqahRQIUJxAyyLAoYIdhiMvH3n/P+5Of/JhbjYwvWC
        sSotrVbJlBJCwLlv+/18qUcOX768wgkoa6Eeo+5dhJS+7i2gatr9KGuNnUN1lE1yqUe9NTjV
        mt0DqLRzv3nU+JiR2CCQXtE7CGmlyVdqLs0gpOYhPU+a01oCpCnN9bi0sumodNi8cCvcKVgj
        p5WxB2n1snVRAkXhpB0kVoiSOvPKuclgUJgJ+BCRgUh/v5jIBAIoJk0AGZ/kYmzxE6DelkaC
        cYnJYYBaK5WZAE5NJJsWsp4SgNLtqdMDbk9PlZHHFpUAXR64SDATHNIHFacqmIcIcj16VdyO
        M+xBhqCfpQWA8ePkBIasgylcRpjjFswGK2BYSK5F3WVXeCyLkP2ak8MwTgajjAHGD908H5VM
        QLa9CJ225E29zyfDUVf+V4KNKUHdX/sBy8eRo6p9amlE5vPReP4HLiuEIceQEWd5DvreUMVj
        eQGafJiPsbwftTRnTXu06IbLhrNXCUEXmpVsOxT9Ou/E2PYs1NovYleb5b507rRbiM6mi7OB
        j2FGLsOMXIb/uQwzchUATimYR+s08TG0ZqWKPuSvkcVrdKoY/+iEeDNw/6ymiYZf1cD0fdC/
        DmAQ1AEEcYmHcNQLysVCuezwEVqdsEetU9KaOjAfciTzhH5r7dFiMkampffTdCKt/qdikO+V
        jEGHR1CGf3pbVx/fVRsaXV3g2hla0Wmrj420BMo2Pcl6IEy361Xvon1F3kVZu4B3U1BRYLWn
        4HSDMznNcvWO4aUtorAq5cDcsADPjz7PUt9sHu7Y/l42N/JBQNveDrOO+LLZWBtw9+noaFTh
        dr/GoRXV4dldLwKDFqTt7hxrt6621x/Rms/vKDq2tXEkZ+zx+yiX7l78uZLeZ2fkESLbyEHv
        k547ujeeMK3y5kcGr/t8c8/R8teXFsdt+PF5iWOkZxscaLn8qelpouW2Zjzpeh9M2/fn0cnZ
        ivXKF4r61FWPUxLsmMgQtrhztK9td+iXOC9H5i19V7cisUDrHB5xnTqw5ZuEo1HIVvjiao3s
        L69qhQDIAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsVy+t/xe7rCkzlTDGadUbXYs2gSk8XGfg6L
        SYeuMVrsvaVtsWfvSRaLe2v+s1rse72X2eLGhKeMFq09P9ktfv+Yw+bA5TFt0ik2j80rtDw2
        repk89j0aRK7x+Qbyxk9ms4cZfbYfLra4/MmuQCOKD2bovzSklSFjPziElulaEMLIz1DSws9
        IxNLPUNj81grI1MlfTublNSczLLUIn27BL2MRf9PMhasF6y4P3sdawPjR94uRg4OCQETiYYV
        cl2MXBxCAksZJVb1LGLpYuQEistIfLrykR3CFpb4c62LDaLoI6PEqeV7mCGczYwSc753sIFM
        YhFQkVjWkgHSwCZgL3Fp2S1mEFtEwFriy6oFjCD1zAL/mCSW77zECpIQBkpsmrWHEcTmFbCV
        eLxmGjvE0FYWibcfVzJDJAQlTs58AnYSs4CFxMz55xlBljELSEss/8cBEZaXaN46G6ycUyBY
        4tH8F2wQVytJPH7xlhHCrpX4/PcZ4wRGkVlIps5CMnUWwtRZSKYuYGRZxSiSWlqcm55bbKhX
        nJhbXJqXrpecn7uJERjX24793LyDcd6rj3qHGJk4GA8xSnAwK4nwfpfiSBHiTUmsrEotyo8v
        Ks1JLT7EaAoMoonMUqLJ+cDEklcSb2hmYGpoYmZpYGppZqwkzutZ0JEoJJCeWJKanZpakFoE
        08fEwSnVwNTbPul96YWtFZdkX1s+vX/46lTf+/vty5k2JB7XFeDtEdkWovbSuKbx4P/cl/e1
        0s+ez9uol/nfpuqLENdDuX8RmpLS698v+pZgdNB43fLG3tUGh9fvy5p53H1RYrZHtsqTgIBS
        kznyyd+v3O81P/coaF/tLpU7GVvWskZvLD/fFCWxXGjqM7XmZ3ZvdoReXMJyW/GWbfqeBqEN
        LqxCtSIzq51U//1tSc03O/9Qb6q38fq5Wjee217ts/4uVOzv0zmL8dipZbd8ixuaggX1ZaON
        Dp++rHuZydkn8/+TxAP2HTr9SmGVyzW5XSJXOLrXBsuEGdjGXzANqvl3QHcL24Qtpxxu8s3t
        9Gh/6L8xSomlOCPRUIu5qDgRAM/sJkF0AwAA
X-CMS-MailID: 20230309080435eucas1p27d38e373074eeedee7e01db6dc6bac63
X-Msg-Generator: CA
X-RootMTR: 20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a
References: <c9f6544d-1731-4a73-a926-0e85ae9da9df@suse.de>
        <ZAN2HYXDI+hIsf6W@casper.infradead.org>
        <edac909b-98e5-cb6d-bb80-2f6a20a15029@suse.de>
        <ZAOF3p+vqA6pd7px@casper.infradead.org>
        <0b70deae-9fc7-ca33-5737-85d7532b3d33@suse.de>
        <ZAWi5KwrsYL+0Uru@casper.infradead.org> <20230306161214.GB959362@mit.edu>
        <ZAjLhkfRqwQ+vkHI@casper.infradead.org>
        <CGME20230308181355eucas1p1c94ffee59e210fb762540c888e8eae8a@eucas1p1.samsung.com>
        <1367983d4fa09dcb63e29db2e8be3030ae6f6e8c.camel@HansenPartnership.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 08.03.2023 13:13, James Bottomley wrote:
>On Wed, 2023-03-08 at 17:53 +0000, Matthew Wilcox wrote:
>> On Mon, Mar 06, 2023 at 11:12:14AM -0500, Theodore Ts'o wrote:
>> > What HDD vendors want is to be able to have 32k or even 64k
>> > *physical* sector sizes.  This allows for much more efficient
>> > erasure codes, so it will increase their byte capacity now that
>> > it's no longer easier to get capacity boosts by squeezing the
>> > tracks closer and closer, and their have been various engineering
>> > tradeoffs with SMR, HAMR, and MAMR.  HDD vendors have been asking
>> > for this at LSF/MM, and in othervenues for ***years***.
>>
>> I've been reminded by a friend who works on the drive side that a
>> motivation for the SSD vendors is (essentially) the size of sector_t.
>> Once the drive needs to support more than 2/4 billion sectors, they
>> need to move to a 64-bit sector size, so the amount of memory
>> consumed by the FTL doubles, the CPU data cache becomes half as
>> effective, etc. That significantly increases the BOM for the drive,
>> and so they have to charge more.  With a 512-byte LBA, that's 2TB;
>> with a 4096-byte LBA, it's at 16TB and with a 64k LBA, they can keep
>> using 32-bit LBA numbers all the way up to 256TB.
>
>I thought the FTL operated on physical sectors and the logical to
>physical was done as a RMW through the FTL?  In which case sector_t
>shouldn't matter to the SSD vendors for FTL management because they can
>keep the logical sector size while increasing the physical one.
>Obviously if physical size goes above the FS block size, the drives
>will behave suboptimally with RMWs, which is why 4k physical is the max
>currently.
>

FTL designs are complex. We have ways to maintain sector sizes under 64
bits, but this is a common industry problem.

The media itself does not normally oeprate at 4K. Page siges can be 16K,
32K, etc. Increasing the block size would allow for better host/device
cooperation. As Ted mentions, this has been a requirement for HDD and
SSD vendor for years. It seems to us that the time is right now and that
we have mechanisms in Linux to do the plumbing. Folios is ovbiously a
big part of this.

