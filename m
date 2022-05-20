Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E9E52E9B9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 12:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348025AbiETKQU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 06:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346515AbiETKQS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 06:16:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F3050014
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 03:16:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220520101612euoutp024b35bf9ecd8192f2b805f8940cafe43b~wyLvIfR1N2207422074euoutp02A
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 May 2022 10:16:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220520101612euoutp024b35bf9ecd8192f2b805f8940cafe43b~wyLvIfR1N2207422074euoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1653041772;
        bh=FtiPxxeAqMIydXwHrRmAPLbmQRTffpcOCZWfzxgX4dc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=lbsQvIKjmr7DQm90bC35XjusJN3VDdtxYqakSNKuWhxjpVZM3XI8N8B5gb36z8DIB
         6w+vF34ajTMKNRA2/wDSKjxb1YUOSlpaTjlsviiSRmfCATSwUXtjhTUVZxqj1gsZOP
         4+IeCbocrVHw7VRQL61WYU1TZtaKhRO0ogqy8tZ4=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220520101611eucas1p13dd922345f7e91a0211cced9694b3ca9~wyLuh2GuU0792907929eucas1p1Q;
        Fri, 20 May 2022 10:16:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 07.A9.10009.B6A67826; Fri, 20
        May 2022 11:16:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220520101610eucas1p1822ca6014e2a1d55ae74476f83c4de1d~wyLuEwPad0813608136eucas1p1M;
        Fri, 20 May 2022 10:16:10 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220520101610eusmtrp1b047ec44358d3e2d4b2d8fd18217aacf~wyLuDudnP3260932609eusmtrp1e;
        Fri, 20 May 2022 10:16:10 +0000 (GMT)
X-AuditID: cbfec7f2-e95ff70000002719-0a-62876a6b4f0d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 76.A7.09522.A6A67826; Fri, 20
        May 2022 11:16:10 +0100 (BST)
Received: from CAMSVWEXC01.scsc.local (unknown [106.1.227.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220520101610eusmtip1c7c8b787f20b055e8d604b8a9c64259c~wyLt1hgig2764527645eusmtip1t;
        Fri, 20 May 2022 10:16:10 +0000 (GMT)
Received: from localhost (106.210.248.142) by CAMSVWEXC01.scsc.local
        (2002:6a01:e347::6a01:e347) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 20 May 2022 11:16:09 +0100
Date:   Fri, 20 May 2022 12:16:08 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier.gonz@samsung.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
CC:     Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220520101608.m6lngep5bvp22k6p@ArmHalley.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR04MB741634259FDCF264BF1CA7259BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
X-Originating-IP: [106.210.248.142]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAKsWRmVeSWpSXmKPExsWy7djPc7rZWe1JBi+milmsvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uPR4BbvFnr0nWSwu
        75rDZjF/2VN2ixsTnjJarLn5lMWitecnu4Ogx78Ta9g8ds66y+5x+Wypx6ZVnWwem5fUe+y+
        2cDm0XTmKLPHztb7rB7v911l81i/5SqLx+bT1R6fN8l5tB/oZgrgjeKySUnNySxLLdK3S+DK
        uHnwD1vBep6KJbM+MzcwNnN1MXJySAiYSHRN+cXYxcjFISSwglHi2cKVLBDOF0aJX/OXQjmf
        GSXWTNjKAtPSeWMJM0RiOaPEwrfTWEESYFVPHptCJLYySkx985qti5GDg0VAVeLpI22QGjYB
        e4lLy24xg4RFBIwlfq6zBilnFnjOJrH01w92kBphAX+JibvusIHYvAK2Esd2NjBD2IISJ2c+
        ATuCWcBKovNDEyvIHGYBaYnl/zggwvISzVtng5VzCsRKtD5ZAFYiIaAssXy6L8T5tRJrj51h
        B1krIfCJU6L1SCMTRMJFor/3CCOELSzx6vgWdghbRuL05B6o37MlLp7pZoawSyQWvz/GDDHf
        WqLvTA5E2FFi16T/jBBhPokbbwUhLuOTmLRtOlQ1r0RHm9AERpVZSN6aheStWQhvzULy1gJG
        llWM4qmlxbnpqcWGeanlesWJucWleel6yfm5mxiBifL0v+OfdjDOffVR7xAjEwfjIUYJDmYl
        EV7G3JYkId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzJmRsShQTSE0tSs1NTC1KLYLJMHJxSDUyG
        nEIXztz3vhu9S/FVmABz2MlOXaaDKbsD2bYtdfEyLQz+7Pr8jYyjzfrSV4J3EtXtd55n9NDU
        vfO8svHUHd7DJTesQ3LTL05oPO3rNEdm2pwY5wrVfz+ezSwsqJoVtPvSQ+Eb8sI36367rpv8
        OUszwsj6d2Dit5po1e1fdd88W3muat/9OW89w4RLJ+k8sHmdJ7Xp8ami/cYyvierZucv/yXk
        JLr31ZfgH0dfrKg7+tX8RtyVDz1SeQceyhfdtOoyqTgSfL9HZ664sYjwlNYDcx7c8na996c/
        6UX/qYOLIz6J3+UqZbm19NkXz9kve/bsvrz2q9Ox0Pp1BxLU/9zdEOP/fN5V/ndFC2cZGxvL
        KrEUZyQaajEXFScCAP71JLADBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsVy+t/xu7pZWe1JBm9uGVisvtvPZvH77Hlm
        i73vZrNaXPjRyGSxZ9EkJouVq48yWTxZP4vZoufABxaLv133mCz23tK2uPR4BbvFnr0nWSwu
        75rDZjF/2VN2ixsTnjJarLn5lMWitecnu4Ogx78Ta9g8ds66y+5x+Wypx6ZVnWwem5fUe+y+
        2cDm0XTmKLPHztb7rB7v911l81i/5SqLx+bT1R6fN8l5tB/oZgrgjdKzKcovLUlVyMgvLrFV
        ija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLuHnwD1vBep6KJbM+MzcwNnN1
        MXJySAiYSHTeWMLcxcjFISSwlFHi5dU/bBAJGYlPVz6yQ9jCEn+udbFBFH1klPh7/yErhLOV
        UeLJ/DdA7RwcLAKqEk8faYM0sAnYS1xadgssLCJgLPFznTVIObPAUzaJxR9PsIDUCAv4Slyd
        8gbM5hWwlTi2swHqit0sEucXLIVKCEqcnPkEzGYWsJCYOf88I8hQZgFpieX/OCDC8hLNW2cz
        g9icArESrU8WsIKUSAgoSyyf7gtxf63Eq/u7GScwisxCMnQWkqGzEIbOQjJ0ASPLKkaR1NLi
        3PTcYkO94sTc4tK8dL3k/NxNjMBksu3Yz807GOe9+qh3iJGJg/EQowQHs5IIL2NuS5IQb0pi
        ZVVqUX58UWlOavEhRlNgAE1klhJNzgems7ySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU
        7NTUgtQimD4mDk6pBibmupTz6mKn6297tPhpBH5z/B5ZeVtmweyHqhETZLJSC8yqVDfv77e8
        qPJPRajC484M9dSph6Q60lb5T7zUfrWySDxlocBNE4UP4ntUFe98XbZVTeUxU2W1Bae2h4tL
        4FmZS1e+sP5OMuotX35x8vb4h5sufNTOy3RZffpzxfK4pIcfqm4+eJvPt2HvRP4bNXETg48a
        uF05tK5SwKyCs5/z/aV5M/T3cm9S6xWQYq/Yta3rYnLK1gMbDPZP97/p+VDL6qmbQZxl9twD
        cTymGg6xEdLZ7mEKRYa5McqX1rC8vPXhGvMV2eWnG1M0jEtOqE/vOCYn3LJYwWi/RLoAc+jL
        W8mabN/MGBcbbPPfp8RSnJFoqMVcVJwIAH96gSuvAwAA
X-CMS-MailID: 20220520101610eucas1p1822ca6014e2a1d55ae74476f83c4de1d
X-Msg-Generator: CA
X-RootMTR: 20220520101610eucas1p1822ca6014e2a1d55ae74476f83c4de1d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220520101610eucas1p1822ca6014e2a1d55ae74476f83c4de1d
References: <20220517081048.GA13947@lst.de> <YoPAnj9ufkt5nh1G@mit.edu>
        <7f9cb19b-621b-75ea-7273-2d2769237851@opensource.wdc.com>
        <20220519031237.sw45lvzrydrm7fpb@garbanzo>
        <69f06f90-d31b-620b-9009-188d1d641562@opensource.wdc.com>
        <PH0PR04MB74166C87F694B150A5AE0F009BD09@PH0PR04MB7416.namprd04.prod.outlook.com>
        <4a8f0e1b-0acb-1ed4-8d7a-c9ba93fcfd02@opensource.wdc.com>
        <16f3f9ee-7db7-2173-840c-534f67bcaf04@suse.de>
        <20220520062720.wxdcp5lkscesppch@mpHalley-2.localdomain>
        <PH0PR04MB741634259FDCF264BF1CA7259BD39@PH0PR04MB7416.namprd04.prod.outlook.com>
        <CGME20220520101610eucas1p1822ca6014e2a1d55ae74476f83c4de1d@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 20.05.2022 09:30, Johannes Thumshirn wrote:
>On 20/05/2022 08:27, Javier González wrote:
>> So you are suggesting adding support for !PO2 in the block layer and
>> then a dm to present the device as a PO2 to the FS? This at least
>> addresses the hole issue for raw zoned block devices, so it can be a
>> first step.
>>
>> This said, it seems to me that the changes to the FS are not being a
>> real issue. In fact, we are exposing some bugs while we generalize the
>> zone size support.
>>
>> Could you point out what the challenges in btrfs are in the current
>> patches, that it makes sense to add an extra dm layer?
>
>I personally don't like the padding we need to do for the super block.
>
>As I've pointed out to Pankaj already, I don't think it is 100% powerfail
>safe as of now. It could probably be made, but that would also involve
>changing non-zoned btrfs code which we try to avoid as much as we can.
>
>As Damien already said, we still have issues with the general zoned
>support in btrfs, just have a look at the list of open issues [1] we
>have.
>
Sounds good Johannes. I understand that the priority is to make btrfs
stable now, before introducing more variables. Let's stick to this and
then we can bring it back as the list of open issues becomes more
manageable.

>[1] https://protect2.fireeye.com/v1/url?k=f14a1d6f-90c10859-f14b9620-74fe485fffe0-3f1861e7739d8cc7&q=1&e=213fcc28-3f9d-41a1-b653-0dc0e203c718&u=https%3A%2F%2Fgithub.com%2Fnaota%2Flinux%2Fissues%2F

Thanks for sharing this too. It is a good way to where to help
