Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C817511A40
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 16:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237989AbiD0Ofh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 10:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiD0Oe2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:34:28 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9845418347
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 07:31:08 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220427143103epoutp01879fc7f9510ad07a13d10ede5169971f~px0sV57XE2068920689epoutp01h
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Apr 2022 14:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220427143103epoutp01879fc7f9510ad07a13d10ede5169971f~px0sV57XE2068920689epoutp01h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651069863;
        bh=MH0TUpJmd6Xn0TDs3wbYY50xoN/FUQag8q/ZfmgP1iI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i8ZdI+gKcT3sdt3HmnIHuvWHcj0t0iZH0pVj6s8dOYLz4OX21bPI8MzjwoWXvqsTw
         yL/Qy955dY/q43hOORMoDzvBM0e49Xl5IeZc6S9tWA3nvZh7PO4qc2hsJ7kGGlmhS2
         NRBP6upHgZYAFU+rwn0NdJjY680lNBBCp5qW0Y20=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220427143102epcas5p29b596e5d8e6e014fbed587a068543a20~px0rRj7Yu2595925959epcas5p2B;
        Wed, 27 Apr 2022 14:31:02 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4KpLlR0WZ2z4x9Pp; Wed, 27 Apr
        2022 14:30:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        46.88.09762.2A359626; Wed, 27 Apr 2022 23:30:58 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220427125500epcas5p189ef3a038115f13840f8992a79fb2e3d~pwg002FDZ1031610316epcas5p1G;
        Wed, 27 Apr 2022 12:55:00 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220427125500epsmtrp18381e20d6e38ffd4eb28b8ea3234fa63~pwg0y5X4H2300323003epsmtrp1O;
        Wed, 27 Apr 2022 12:55:00 +0000 (GMT)
X-AuditID: b6c32a4b-1fdff70000002622-70-626953a2579d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0D.34.08853.42D39626; Wed, 27 Apr 2022 21:55:00 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220427125459epsmtip19208f23035104a9c8446a86c8c32dcd3~pwgzmZAtj1493614936epsmtip1J;
        Wed, 27 Apr 2022 12:54:58 +0000 (GMT)
Date:   Wed, 27 Apr 2022 18:19:51 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, nitheshshetty@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add Copy offload support
Message-ID: <20220427124951.GA9558@test-zns>
MIME-Version: 1.0
In-Reply-To: <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDJsWRmVeSWpSXmKPExsWy7bCmpu6i4Mwkg3fbLS1+nz3PbLH33WxW
        i723tC327D3JYnF51xw2i/nLnrJbdF/fwWax40kjowOHx85Zd9k9Ni+p99jZep/V4/2+q2we
        nzfJBbBGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXm
        AF2ipFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwKdArTswtLs1L18tLLbEyNDAw
        MgUqTMjOmPj9CnPBOY6Knz1vGBsY+9i7GDk5JARMJF7e7WXsYuTiEBLYzSgxce1zVgjnE6PE
        8nX72SCcb4wSjZeuscK0tGw9B1W1l1Fi26zjUP3PGCWWte5nBKliEVCVWLRuPlMXIwcHm4C2
        xOn/HCBhEQFTibc9rSwg9cwCZxgl2t/vAjtEWMBMYnVnKxuIzSugI3Hzy19WCFtQ4uTMJywg
        NqeAm0THgUnMILaogLLEgW3HmUAGSQhM5ZA4sWsFC8R5LhIf7s1hhrCFJV4d3wL1qZTEy/42
        KLtcYnvbAqjmFkaJrlOnoJrtJS7u+csEYjMLZEj8fzkV6mdZiamn1kHF+SR6fz9hgojzSuyY
        B2MrS6xZv4ANwpaUuPa9Ecr2kNj5cSU0vE4Bg3jlHMYJjPKzkHw3C8m+WcAQYxbQlFi/Sx8i
        LC/RvHU2M0RYWmL5Pw4kFQsY2VYxSqYWFOempxabFhjnpZbDoz85P3cTIzjZannvYHz04IPe
        IUYmDsZDjBIczEoivF92ZyQJ8aYkVlalFuXHF5XmpBYfYjQFRtxEZinR5Hxgus8riTc0sTQw
        MTMzM7E0NjNUEuc9lb4hUUggPbEkNTs1tSC1CKaPiYNTqoFJ/sXyv8flM4vyjuwxY1rg5f7V
        /9PC2qtRz00K7tQGHgyfd79y+q5Vt3ZZqa4/z7Qjwv34g2nb7mf/KvrDs2J35YPFBls+phh5
        Kj4wmWk8c92//z4WkbdfvuB8+tAlU3BHDpfP2+OPuVJ+P9tsYnzRb3PUYo8jWy8zXz5fe2Ti
        FtsGP7Wgfr0snydfjEP/vps92+n9qjUCjnP89QRXz98z2dewxrpyqfUSO++Pcx7VzXEJsLQT
        +vRNM9tSM+ax6YE9b6eZRam4a00uF7nkk7i7eW765hPLglMWajFIRC/cp11Wuslml6sQX+xN
        qV/2CcdjHh0S1RCKq1l3x91Wdr3cJfbdPFuPX1bvWu5gOXtRmRJLcUaioRZzUXEiAJsamEE/
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSnK6KbWaSwZMuIYvfZ88zW+x9N5vV
        Yu8tbYs9e0+yWFzeNYfNYv6yp+wW3dd3sFnseNLI6MDhsXPWXXaPzUvqPXa23mf1eL/vKpvH
        501yAaxRXDYpqTmZZalF+nYJXBnv1l9kLPjAWrGkYRZTA+MZli5GTg4JAROJlq3nWEFsIYHd
        jBJXf/pBxCUllv09wgxhC0us/PecvYuRC6jmCaNEx5HH7CAJFgFViUXr5jN1MXJwsAloS5z+
        zwESFhEwlXjb08oCUs8scIZRov39LrB6YQEzidWdrWwgNq+AjsTNL39ZIYaeYpTofHqRFSIh
        KHFy5hOw65gF1CX+zLvEDLKAWUBaYvk/DoiwvETz1tlgx3EKuEl0HJgEZosKKEsc2HacaQKj
        0Cwkk2YhmTQLYdIsJJMWMLKsYpRMLSjOTc8tNiwwzEst1ytOzC0uzUvXS87P3cQIjhwtzR2M
        21d90DvEyMTBeIhRgoNZSYT3y+6MJCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeW
        pGanphakFsFkmTg4pRqY3E4HJove7NU0V7A9sZ11R157x+KgZU7PWx9lvNdqnSV0Katz3/bd
        qxRYBTvLRENTZxnWXox4ta7whvj/268VGQ23TZG9+Ovy0izWsn8LH2hrJ208VLHiIMukjZdf
        9Au12G5aLub9wmBp/ox8xxkX9JROneMWa826cC7U7v2Rf29EjD/Mjf7q8u7e9ZR4hXPJStwa
        bdcXLfU8YqS+VM9WKSJ8ncP5U5znSri7t5ntLJk/WXVnqaa52nEvD6+zhitE5z9oDbMJk9j+
        /KKyG4/iPNGIIp2zMpulRDnvb6lUS5Xjjt681vBMiceTFU7rvM5v+zVdvozz4vuXNw+q7fp2
        VODNqvlHDuVrcp976l+rqcRSnJFoqMVcVJwIAPtAlfYLAwAA
X-CMS-MailID: 20220427125500epcas5p189ef3a038115f13840f8992a79fb2e3d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_1770c_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
        <20220426101241.30100-1-nj.shetty@samsung.com>
        <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_1770c_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
> On 4/26/22 19:12, Nitesh Shetty wrote:
> > The patch series covers the points discussed in November 2021 virtual call
> > [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
> > We have covered the Initial agreed requirements in this patchset.
> > Patchset borrows Mikulas's token based approach for 2 bdev
> > implementation.
> > 
> > Overall series supports –
> > 
> > 1. Driver
> > - NVMe Copy command (single NS), including support in nvme-target (for
> >     block and file backend)
> 
> It would also be nice to have copy offload emulation in null_blk for testing.
>

We can plan this in next phase of copy support, once this series settles down.

--
Nitesh Shetty

------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_1770c_
Content-Type: text/plain; charset="utf-8"


------SFNbypxiwiYv2mFj5qNI3mkL0EyMW--LFKYa8svGKq9OOQ6W=_1770c_--
