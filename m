Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A04AE706A98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 16:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjEQOKo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 10:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjEQOKn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 10:10:43 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7023C1E
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 07:10:41 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230517141038euoutp020776ea25328bfb8266485026753195fe~f85xqGqX92848528485euoutp02U
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 May 2023 14:10:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230517141038euoutp020776ea25328bfb8266485026753195fe~f85xqGqX92848528485euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684332638;
        bh=fSUGBWEOANyW/Vd4t6CfRE1QGm0GQPrvGJcdROwIVqg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=fNl0h3C1hZ+nGrZl++y+bBgSekUmpp8SlIIEz7mPD1N7aIeE02zgwzfTx9X9Q81O+
         vl7vewHSPvMR+/BYxbI7yXnc+Ez9u1xMJt57drq0b+G9ACNaFixXMOqDEHvOB6skEG
         mQd9KtCdGhTAtWLXbcE9bBzUIsQNCU14kVssptcE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230517141038eucas1p293f58fc03a209708ab90c7e52d79adf6~f85xkSAPZ0791107911eucas1p2F;
        Wed, 17 May 2023 14:10:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 64.DB.42423.E50E4646; Wed, 17
        May 2023 15:10:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230517141038eucas1p2571e1922590aa30a21d7c0fcdcfb1cf7~f85xV1Ahx3104331043eucas1p2_;
        Wed, 17 May 2023 14:10:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230517141038eusmtrp1879024d97bf8613375dac8878e8a591c~f85xVRMyV3195231952eusmtrp1B;
        Wed, 17 May 2023 14:10:38 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-03-6464e05ea066
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0B.5B.14344.E50E4646; Wed, 17
        May 2023 15:10:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230517141038eusmtip24dcef5a47f82a0857bf3c83af65df262~f85xESINC2284722847eusmtip2j;
        Wed, 17 May 2023 14:10:38 +0000 (GMT)
Received: from localhost (106.110.32.140) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 17 May 2023 15:10:37 +0100
Date:   Wed, 17 May 2023 16:10:36 +0200
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     <phillip@squashfs.org.uk>, <akpm@linux-foundation.org>,
        <squashfs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <p.raghav@samsung.com>
Subject: Re: [PATCH] squashfs: don't include buffer_head.h
Message-ID: <20230517141036.iwipagublvjca2sc@localhost>
MIME-Version: 1.0
In-Reply-To: <20230517071622.245151-1-hch@lst.de>
X-Originating-IP: [106.110.32.140]
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7djP87pxD1JSDBrvqFrMWb+GzWLl6qNM
        Fnv2nmSxuLxrDpvF0Z7NbBZXd9U7sHmcmPGbxWP3gs9MHrtvNrB5TPn6nNnj8ya5ANYoLpuU
        1JzMstQifbsErowTT8oLfrBUNO7qY2lgXMvSxcjJISFgIjHlw0L2LkYuDiGBFYwSs26eZoRw
        vjBKnNv2mwnC+cwosf72fSaYlpnTb0AlljNKbLuwkgWu6u6Za8wQzhZGiSWfe5lBWlgEVCXu
        PfkOtIWDg01AS6Kxkx0kLCKgJPH01VmwfcwC+xkl/pz/zwZSIyxgJXGwlw2khlfAXGL76nXM
        ELagxMmZT8AO5xQwlPj56SEzxEVKEg2bz0A9VCuxt/kA2EMSAnc4JH7MvMQIkXCROPZ8ExuE
        LSzx6vgWdghbRuL05B6o5mqJpzd+M0M0tzBK9O9cD3aQhIC1RN+ZHJAaZoFMiW/v37FC1DtK
        tF7ZxwhRwidx460gRAmfxKRt05khwrwSHW1CENVqEqvvvWGBCMtInPvEN4FRaRaSx2YhmQ9h
        60gs2P2JbRZQB7OAtMTyfxwQpqbE+l36CxhZVzGKp5YW56anFhvmpZbrFSfmFpfmpesl5+du
        YgSmotP/jn/awTj31Ue9Q4xMHIyHGCU4mJVEeAP7klOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ
        82rbnkwWEkhPLEnNTk0tSC2CyTJxcEo1MOUELO44vzx489+tF40FHIoCdoudYXRLEFm97l9C
        U5fY21cCzTXcrT7ViQcymVq3cp7ViyyefkTS4/P8P5XPxLevdd3q8vrPmuygGS+7PO4+naph
        GaE4S2+9zXz+TbOEjv7IV71/a2uMB9dtDw2PZ1WuXkH+ORI19uq93zyU+9x220Tcvd5zastr
        lUUf1//vLj/svTlq7Z4bz4XDVeebfvaJy124JzzJ7le9w95/inwP0pkl01YYTHgkvsXU4aCV
        6+ude2dXvWR8elXP/PXE7O/Nz7fOWy63wkzlxvJLV6K39AtEuEuVPHU/6Ta59kToyl/3qg/W
        iDrN5drJtZvrwerUXQc234lQn6RiqBR7JlyJpTgj0VCLuag4EQCv7oAatAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOIsWRmVeSWpSXmKPExsVy+t/xe7pxD1JSDCZ+4LeYs34Nm8XK1UeZ
        LPbsPclicXnXHDaLoz2b2Syu7qp3YPM4MeM3i8fuBZ+ZPHbfbGDzmPL1ObPH501yAaxRejZF
        +aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehlf5n9gLdjK
        VLHxyXLWBsZmpi5GTg4JAROJmdNvANlcHEICSxklel9PYYZIyEhs/HKVFcIWlvhzrYsNxBYS
        +MgosehXPETDFkaJzu9/wCaxCKhK3Hvynb2LkYODTUBLorGTHSQsIqAk8fTVWUaQemaB/YwS
        f87/ZwOpERawkjjYCzaTV8BcYvvqdcwQ8w0klvZPYoeIC0qcnPmEBcRmFtCRWLD7E1grs4C0
        xPJ/HCBhTgFDiZ+fHkKdrCTRsPkMC4RdK9H56jTbBEbhWUgmzUIyaRbCpAWMzKsYRVJLi3PT
        c4uN9IoTc4tL89L1kvNzNzECY2zbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd7AvuQUId6UxMqq
        1KL8+KLSnNTiQ4ymwICYyCwlmpwPjPK8knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU
        1ILUIpg+Jg5OqQYmF5tySxYDvrdHzp3o/JPCu6e96fbxxaHhc2q2GNXbsvxZ/9JPe75KQfE6
        B3P+PeLJcVs//M9SYj7Cxt79lt3vl/yUoAY/ZzlD4Tkyc7IP5i6Va/lksU6UUWSC7+01H99V
        cl2Zvmzm49gtQVfO9aoZ9q6aURkveGnD9DyRL72O2XNmhHr8WKqy/qv96qTq/Qbr1qa88Sla
        5aNz0GTTphuFqm579s1yi+4O5/B86VYb1GZ1ZLaH16r+M2nfPxRvFHPPiX/Vdmp5n/eBJKn+
        l2ZlF79IuB/Mnx1wtoS1TC0yVu6PXVFqmRjzQdWJnw+0F8hGyFx9wdiaue5SiZSp8D9OJ8Y6
        /1fJfX8Opi87H6zEUpyRaKjFXFScCACVjb6DOgMAAA==
X-CMS-MailID: 20230517141038eucas1p2571e1922590aa30a21d7c0fcdcfb1cf7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c023e_"
X-RootMTR: 20230517141038eucas1p2571e1922590aa30a21d7c0fcdcfb1cf7
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230517141038eucas1p2571e1922590aa30a21d7c0fcdcfb1cf7
References: <20230517071622.245151-1-hch@lst.de>
        <CGME20230517141038eucas1p2571e1922590aa30a21d7c0fcdcfb1cf7@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c023e_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, May 17, 2023 at 09:16:22AM +0200, Christoph Hellwig wrote:
> Squashfs has stopped using buffers heads in 93e72b3c612adcaca1
> ("squashfs: migrate from ll_rw_block usage to BIO").
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>

------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c023e_
Content-Type: text/plain; charset="utf-8"


------nt9vO67.b8K_looarrbd7-OVwn-OXfZhK5OxcWyp3fprDND4=_1c023e_--
