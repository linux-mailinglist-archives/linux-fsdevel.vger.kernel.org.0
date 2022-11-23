Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EFE0635C89
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 13:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236712AbiKWMN5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 07:13:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbiKWMNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:13:54 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889E71160
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 04:13:53 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20221123121351epoutp040717e7e8cb3066e76be7c82193264335~qNa2s-a_e1846018460epoutp04K
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 12:13:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20221123121351epoutp040717e7e8cb3066e76be7c82193264335~qNa2s-a_e1846018460epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669205631;
        bh=J8tJEajcNf43feZbPcC3jSH5tMqTd3EkJBwiSz4CDnw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LiaE24cvhu6uEr0MGdbJkpfOGT/HN6/NU/vvftuXXV32C7gcOThk8EKw+WkzPhx6z
         a9Fb9csPSp23UUV1ejHfqaB8uPjtbEzdz7AtvqEnVekyZjzIU7Sc/LdOu9jS0uXUvu
         Z4pZqAcy8TSEJgrjbH1GGFMoR4yqUwGpGRwpNzbc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221123121351epcas5p2b1c4ec4c767ca49c4e4c22515d4b6365~qNa19qxrx0517605176epcas5p2E;
        Wed, 23 Nov 2022 12:13:51 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4NHKmF2gWwz4x9Py; Wed, 23 Nov
        2022 12:13:49 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.06.01710.D7E0E736; Wed, 23 Nov 2022 21:13:49 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20221123101836epcas5p4667a420daae5e33c26477d62249e75ce~qL2OFxVYW2457124571epcas5p4F;
        Wed, 23 Nov 2022 10:18:36 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221123101836epsmtrp241b68ada4fc9176c1bb90e275bba4cf5~qL2OEsCR32111421114epsmtrp2B;
        Wed, 23 Nov 2022 10:18:36 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-6d-637e0e7dfd17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        49.2F.18644.C73FD736; Wed, 23 Nov 2022 19:18:36 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221123101832epsmtip1f15b1bdd3ebf147c9a3fe238fea17ca1~qL2Kkjd961036210362epsmtip1D;
        Wed, 23 Nov 2022 10:18:32 +0000 (GMT)
Date:   Wed, 23 Nov 2022 15:37:12 +0530
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 02/10] block: Add copy offload support infrastructure
Message-ID: <20221123100712.GA26377@test-zns>
MIME-Version: 1.0
In-Reply-To: <Y33UAp6ncSPO84XI@T590>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHc+4tt4UIu+O1A3OIZWYCUqgWPDw1uGwXhYRsmjl0YV17eYTS
        Nm3ZYHM8BmUIYbznqIOxwEAeAQTGgA7DMLOAIipQBOkeCpgNB4PqkDDAwi1m/33O9/f95ffK
        4eC2ZWxnTrxURSukQgmXsGJ1fut+wOu8TarIR/3jLtQy9B2OLhSu46jRUECgteERHPUufGmB
        Jvu6MVTfeBdD2utLGLq7+YRAD/+eYqHifj1As+MaDPVOeaLbvYMsNNpzlUDXamfZqL8kE0NF
        unYL1DWTAZDxRhYbNc8vstDA1F40sq6zeHcPpbk/TFDdGgObGrn3NYsaHU6i2ho+J6j2mjRK
        O5lOUPmZCyaD+r4FtfjNOEFd6mgAlLHNhbrYl4dRbTNPsEibqISgOFoophWutFQkE8dLY4O5
        HxyNfi/a18+H78X3R29zXaXCRDqYezA80utQvMQ0P9f1tFCSZJIihUol1zskSCFLUtGucTKl
        KphLy8USuUDOUwoTlUnSWJ6UVgXwfXze9DUZTybE3axpIuR3HJILnrHSwdjuXGDJgaQAZtyZ
        xXOBFceW1AL4eDUHYx7LANYasswRI4C/3qzEdlJKs/PZTKAHwL/Gi80pcwDqfqlgb7lY5GtQ
        v1TBygUcDkF6wu83OVuyPcmFBkPjtgUn01lwdpLcYjsyHOZudBBbbE16wbJ7MzjDu+Fg+Qxr
        iy3J/fCnkb5t3YF0g32duu26kGyxhJU9ayymu4NQe40pAEk7+FjXYWZnaFzoJRg+A+tLvyKY
        5CwANRMawATegeqhApzpLg6uzI/gjL4Plg01Y4xuA/PXZsyrsIZdlTvsBptaqswFnKB+JcPM
        FBx7egMwG5oAMHOlmV0IXtG8MJ3mhXoMvwGrtMuExrQ8nNwL6zY4DLrDlh7vKmDRAJxouTIx
        llb6yvlS+sz/FxfJEtvA9v/wCOsChgdPef0A44B+ADk41946Lewzka21WJhyllbIohVJElrZ
        D3xNxyrCnR1EMtMHk6qi+QJ/H4Gfn5/A/y0/PnePdfUVD5EtGStU0Qk0LacVO3kYx9I5HQPO
        r+9b6/4TOUasjhWJn0msHJrPhVxX/FxSVnpoXn2Ul2XZGX4iwLH3w2PdMSrtXHb1+uUjp1bc
        NdLyXco40qmAF/E8LPSll/l56o8uHiuvjnEk/j0J5V98eitXnb1/OjLTsazv1Uv6wB4x+/Bo
        gmXUOO+534OG6ZALscbDUxPKf06Xp+WMaaMeppyvsFsMsk9Lq/5t+ZxL7NgjgYtbiK75qliw
        WV9TyQ8sSR202fQo/OPARl2AZyK/deK494DIdyAoRnJFYBWYk6q/pQ5e9bk8GrpUfOST6YrF
        39/v6DQGtN7uSSn/uLCpbmOlfT00YiJJ35p39tGp2jn/5NATPyRbTbsf57KUcUK+B65QCv8D
        8SoGrKgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTcRjG+Z9zdnZcacdL+N+staZFWVqTPvyjiIqIY/ShIguVLtNOLryt
        TctspebsslBXZtjsZqiha4naRLOpnfJW6bqQpaJlrSJKy7YiEWdtFvXt4f09z/u88FK4zwtC
        RO1LSmFVSfIEKSkg6u5JxSEa+5HYpaZib1T1oA1Hx/QTODIO5JNovMuKI8tIMQ/1tjRgqMLY
        iqHGklEMtU4Ok2jI0Uegs1wPQO+eGzBk6VuE7lg6CfTs9kUSXSl/x0dcQTaGzrTX8lC9LQsg
        e5mWj25++kKgjr4AZJ1o5632ZwyvukimwTDAZ6yD1QTzrCuVqak8RTK1pRlMY28myeRmj/w2
        5LziMV+anpNM3q1KwNhrxMyJltMYU2MbxjZ5RQlW7mET9h1gVUtW7RYoKgaLcGWWb5r55zie
        CUwzdMCDgvQyeO54Ll8HBJQPXQ+g+UIJNgWEsHziPj6lfWGF88Mfkw3A0tFcngsQ9DzYM3qJ
        0AGKIulF8OEk5Rr70VI4MGB0+3H6GAEv9/STLuBLb4Q65y239qRDYOGgDZ9a2gugsaSZPwW8
        YecFG+HSOB0MXzo/Yq4CnA6A153uAg86CD62triPm0kHwpa6dkwPvA3/pQ3/pQ3/0lcBXgmE
        rFKdGJeolinDktiDoWp5ojo1KS40NjmxBrh/HxxcD+5Ufg3lAEYBDkAKl/p5ZoRrYn0898gP
        pbOq5F2q1ARWzYEAipD6ez7Wde7yoePkKWw8yypZ1V+KUR6iTCyow286qzGuJvvfzj85NmYb
        E7RaHHPoB5FvSjxSMC/JtB9Naw4X98REU++dh00LCpLNe7eIyzfKOsz+EdSyLO0N7ujd78K+
        Rnt3f65jrfzuCok5bX9Z9I7WzvzNVJS2tDuuwCQMbOSWpre9XpHTUBQpfCqqyjuor/bv1k/u
        MB3f1r7YYpSErTU2CR0OzcLyGIOsYH1M+NmhrSJOlNC/7nPzt+3WS7UrH3HZ+JMD7M5NP0fm
        1p55KonxEhdeE8V/025Qvwj8rpF+zalKYyrC9Ao0K6I642Jzs3bwFBzOz85QDCnOh0fX1eeN
        y5a3zS6yCgNnYJFVEgGuFD+xF6VLCbVCLgvGVWr5L4XDK6BqAwAA
X-CMS-MailID: 20221123101836epcas5p4667a420daae5e33c26477d62249e75ce
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_667d6_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061017epcas5p246a589e20eac655ac340cfda6028ff35
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
        <20221123055827.26996-3-nj.shetty@samsung.com> <Y33UAp6ncSPO84XI@T590>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_667d6_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Wed, Nov 23, 2022 at 04:04:18PM +0800, Ming Lei wrote:
> On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > and an array of (source, destination and copy length) tuples.
> > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > bio pair with a token as payload and submitted to the device in order.
> > Read request populates token with source specific information which
> > is then passed with write request.
> > This design is courtesy Mikulas Patocka's token based copy
> 
> I thought this patchset is just for enabling copy command which is
> supported by hardware. But turns out it isn't, because blk_copy_offload()
> still submits read/write bios for doing the copy.
> 
> I am just wondering why not let copy_file_range() cover this kind of copy,
> and the framework has been there.
> 

Main goal was to enable copy command, but community suggested to add
copy emulation as well.

blk_copy_offload - actually issues copy command in driver layer.
The way read/write BIOs are percieved is different for copy offload.
In copy offload we check REQ_COPY flag in NVMe driver layer to issue
copy command. But we did missed it to add in other driver's, where they
might be treated as normal READ/WRITE.

blk_copy_emulate - is used if we fail or if device doesn't support native
copy offload command. Here we do READ/WRITE. Using copy_file_range for
emulation might be possible, but we see 2 issues here.
1. We explored possibility of pulling dm-kcopyd to block layer so that we 
can readily use it. But we found it had many dependecies from dm-layer.
So later dropped that idea.
2. copy_file_range, for block device atleast we saw few check's which fail
it for raw block device. At this point I dont know much about the history of
why such check is present.

> When I was researching pipe/splice code for supporting ublk zero copy[1], I
> have got idea for async copy_file_range(), such as: io uring based
> direct splice, user backed intermediate buffer, still zero copy, if these
> ideas are finally implemented, we could get super-fast generic offload copy,
> and bdev copy is really covered too.
> 
> [1] https://lore.kernel.org/linux-block/20221103085004.1029763-1-ming.lei@redhat.com/
> 

Seems interesting, We will take a look into this.

> 
> 

Thanks,
Nitesh

------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_667d6_
Content-Type: text/plain; charset="utf-8"


------G62UEJgdyo2JOumF_Do4Y7B7G39M5PuLVzFwfXKQiOy3iUJg=_667d6_--
