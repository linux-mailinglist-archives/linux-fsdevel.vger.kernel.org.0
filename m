Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790C9530C21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 May 2022 11:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiEWIZk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 May 2022 04:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiEWIZh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 May 2022 04:25:37 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EF2D1F8
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 01:25:32 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220523082529euoutp02abdc781bedb26665289b19589d09275e~xrm7x_j0x1641416414euoutp02B
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 May 2022 08:25:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220523082529euoutp02abdc781bedb26665289b19589d09275e~xrm7x_j0x1641416414euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653294329;
        bh=Xt3i2bDFzBoorS3pe19S78Qefpbzo5XCAIUGcGfIhmU=;
        h=Date:Subject:To:From:In-Reply-To:References:From;
        b=pbZxOALzpbvOAVqWm2uE0bAuZIH+KJzmehFyc2QnKErw7ZsOgIqtZ1fu+S22Sb4bo
         VGjILQ+5ju1nd2mbjZNLkKjtBD5NRikIopIvgzSNfMW13PkaOWbSwDzbGKgjD6DhCV
         AN9vrskz6I5W3PQqxeJDEAs5zK0cizli6jvHPkSc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220523082529eucas1p16589ffdf204dbfad55d0aefbf2f68dc4~xrm7SFYkL1415614156eucas1p1n;
        Mon, 23 May 2022 08:25:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AD.47.10260.9F44B826; Mon, 23
        May 2022 09:25:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220523082528eucas1p154de304dc76b15b99d571399400530f3~xrm6ymVAt2444124441eucas1p1a;
        Mon, 23 May 2022 08:25:28 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220523082528eusmtrp2fe33f2de7b5f28c5c3c8fa8198f3e58b~xrm6xlJgz1491314913eusmtrp2F;
        Mon, 23 May 2022 08:25:28 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-7d-628b44f9a9ab
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1B.D1.09522.8F44B826; Mon, 23
        May 2022 09:25:28 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220523082528eusmtip137c716859f4c05ff6297ff5668064f79~xrm6ktjUt2896028960eusmtip1F;
        Mon, 23 May 2022 08:25:28 +0000 (GMT)
Received: from [106.110.32.130] (106.110.32.130) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 23 May 2022 09:25:23 +0100
Message-ID: <43bac47d-5ef6-2b6c-e747-58e5a2fb7b52@samsung.com>
Date:   Mon, 23 May 2022 10:25:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
        Thunderbird/91.8.1
Subject: Re: [dm-devel] [PATCH v4 00/13] support non power of 2 zoned
 devices
Content-Language: en-US
To:     <dsterba@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier.gonz@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
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
In-Reply-To: <20220520171830.GR18596@twin.jikos.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.110.32.130]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xbVRzHPbeXey+NhbuC4YSxqnXOiFpqIMtJ9tB1GK5PmBofxMjuypU1
        K2VpV3yQRZiWt8BKgllhlDDdsN1ESwF5TVYpjNC6aWEryMbMYI/ihgiMlQq49m6G/z6/8/t+
        c77fk0MJxEVELKXSHOC0GlYtJYR4W7//3HP+5LI98qPjBLJeqiRQwH1OgHpu14ah83cLMHQs
        sIij7kYjhr6zOjE02WwSoPLev3G0XHoZQ0bHBYB6xp5Bv19tIlF3zyCOPJ11BDIfnyKRt2oK
        oJOjUzgq/HEBIEO5n3wxmlk5e5JgOkyXSMbj1jM2SwnBtHzzOdM1mk8wh1xOAdNhmAhjZk6P
        EEyzfQRnXA19JNMylMfM2SRMUW8ZlhaRLtyayalVuZw2Yftu4V6v5xDYb8Q/mXGcCMsHxwSl
        IJyCdBI0X5vES4GQEtNNAN6x+jF+mAdwZtQcxg9zAJ6Z7sEfWFar/yX4xQkAb7prif9VluVV
        kh+6AJydrQlZRPR2aJswEEHG6SehvaKY4M/XwcEjkyHNI/R7sMbkCp1H0anwcOd4iAV0DByb
        NIdCRdOtFDzfVn3vBooi6HhYUEIGNeF0Irx85SrJ65+GhvbAfX4Utt+qEwTlkJbCWo+Mb3AQ
        nup3hXJC+ogQmk934bwmGfbVR/KaKOgbsJM8x8HVjmCEIOfBKW9AwHu/BLCyo5ngvVtghUvN
        4w5Y4NzFYwT03lrHh4mAxrav74cRweJCcRXYaFrzDKY1dU1rqpjWVGkAuAXEcHpddhanS9Rw
        H8t0bLZOr8mSKXOybeDeXx1aGVj4CTT5ZmUOgFHAASAlkEaL2tniPWJRJvvpZ5w2J0OrV3M6
        B1hP4dIYkVL1Ayums9gD3D6O289pH2wxKjw2HzMoMi+Ul2iM7upX0x7u9n7R+tjC7jnJ98Nx
        yhtv/jkY7yl4Ac4ffv8lyZZtVUs+e/1D/fa4LDixil3Ji60Fv+0cWOp+x9t7UaV+vGR69on1
        9b4PkpMWG1ZsAXbDrkLwbq5s5PpMZ0oGWdmfUHNcuWKR30j9ZXORzbIvY975lPG1zXfdMuWO
        wVSV9Lr7muLlXO/trz5K23hzvMI3YZSnWH9NX8xpbmwcfns5SZstCf/DZrRfvKNjWvuc3NlM
        keLZKGyo7pV5xwbVwb/Gf27Vp06/Jdw0lPLPGC45sy1yk/DoG5HTO7fKxz70JyhfbymzwsXK
        JaX8VP6wIrExQVE5zH6rTJfiur3s8/ECrY79Dy66qUsaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsVy+t/xu7o/XLqTDC5+UrRYfbefzeL32fPM
        FnvfzWa1uPCjkcli8e/vLBZ7Fk1isli5+iiTxZP1s5gteg58YLH423WPyWLSoWuMFntvaVtc
        eryC3WLP3pMsFpd3zWGzmL/sKbvFjQlPGS3W3HzKYtG28SujRWvPT3YHEY9/J9aweeycdZfd
        4/LZUo9NqzrZPDYvqffYfbOBzaPpzFFmj52t91k93u+7yuaxfstVFo8zC46we2w+Xe3xeZOc
        R/uBbqYAvig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07m5TUnMyy1CJ9
        uwS9jBuXmxgLJrFUvD+0nLWBcTFzFyMnh4SAicT/yX/Yuhi5OIQEljJKzDp1jBEiISPx6cpH
        dghbWOLPtS6ooo+MEvumHmUCSQgJ7GaU6FshB2LzCthJbLrfygZiswioSmzp62CDiAtKnJz5
        hAXEFhWIkHiw+ywriC0s4CtxdcobsDizgLjErSfzmUAWiAhs5pD49W8Z1IItrBIvX+Z1MXJw
        sAloSTR2gh3EKWAsce/BY3aIXk2J1u2/oWx5ie1v5zCDlEsIKEnMvqwHcX+txKv7uxknMIrM
        QnLRLCSbZyGZNAvJpAWMLKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzEC0862Yz8372Cc9+qj
        3iFGJg7GQ4wSHMxKIrzbEzuShHhTEiurUovy44tKc1KLDzGaAoNlIrOUaHI+MPHllcQbmhmY
        GpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0MXFwSjUwxe17x7rj/5vnH5fG9B80T49V
        MX0zYfXp/e7Bs+y9lk3//vFU8l+WfX2xZ5cvPV76p0pb99ieS9pTK38pezHJfV4YuKl8lXPj
        UxvbjE7NCtU5/9s37jL5mLR+SkcRr7Be/6Pv1h/k4yX/Lj0VL+pjvH3jzSaNWJ7Vs6cv+HH4
        4dVLiy/k5Tg9mZKm9+ZoZPCZSC/bB3/NZZ4miFUeO9xafesCa9CrugdLTgdu+WrI1TLjUvEU
        jeyNte2OH1kZlrOv22NxScJ+tsoXIW/1jfv0Vvkosf/kjt0uf/S5+g7fAG77HXp+KbP3PKuN
        2LaRa9euN/eMH308WmH35q2Ixc+Atk7ul4ey6xwZTU5+PX2wTkOJpTgj0VCLuag4EQB2tdxI
        xAMAAA==
X-CMS-MailID: 20220523082528eucas1p154de304dc76b15b99d571399400530f3
X-Msg-Generator: CA
X-RootMTR: 20220520172257eucas1p1b94b150d71352587ced5d46b8c3f3537
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220520172257eucas1p1b94b150d71352587ced5d46b8c3f3537
References: <YoPAnj9ufkt5nh1G@mit.edu>
        <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
        <20220519031237.sw45lvzrydrm7fpb@garbanzo>
        <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
        <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
        <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
        <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
        <be429864-09cb-e3fb-2afe-46a3453c4d73@opensource.wdc.com>
        <aee22e8a-b89b-378c-3d5b-238c1215b01d@samsung.com>
        <CGME20220520172257eucas1p1b94b150d71352587ced5d46b8c3f3537@eucas1p1.samsung.com>
        <20220520171830.GR18596@twin.jikos.cz>
X-Spam-Status: No, score=-11.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 5/20/22 19:18, David Sterba wrote:
>> I see that many people in the community feel it is better to target the
>> dm layer for the initial support of npo2 devices. I can give it a shot
>> and maintain a native out-of-tree support for FSs for npo2 devices and
>> merge it upstream as we see fit later.
> 
> Some of the changes from your patchset are cleanups or abstracting the
> alignment and zone calculations, so this can be merged to minimize the
> out of tree code.
Sounds good. I will send it separately. Thanks.
