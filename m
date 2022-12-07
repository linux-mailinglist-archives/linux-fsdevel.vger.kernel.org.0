Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4F86453F6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Dec 2022 07:26:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiLGG0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Dec 2022 01:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiLGG0G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Dec 2022 01:26:06 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF3959853
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Dec 2022 22:26:02 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20221207062558epoutp01af2e7782baa90e6774920c9f25e7a80f~ubtGqV3Ui0449304493epoutp01b
        for <linux-fsdevel@vger.kernel.org>; Wed,  7 Dec 2022 06:25:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20221207062558epoutp01af2e7782baa90e6774920c9f25e7a80f~ubtGqV3Ui0449304493epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670394358;
        bh=YLI9vWp/DHhjBMibEyo7r+mTdT2CBd7uCE57nJvVqTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XphxXbSbts3ZufFCK+6T2HFIQ/lP0ocnqs/jWbrzKOYZzKUDyZjS+XVubgK2mmGC4
         8RJJX1FUrPS6csdjZOeF83nNOMgeWesAMRbjpvkV4B2xmeoPPXjvX4BvXqBrNLi6IP
         YmCoEHJ/TGe7JImA5m4Xq0zLC+tomJQkEKtHrTRY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20221207062557epcas5p20ab0eef8d1b39310d73ec732fc441a57~ubtGGsaWw2923829238epcas5p2E;
        Wed,  7 Dec 2022 06:25:57 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NRnNM0hK4z4x9QC; Wed,  7 Dec
        2022 06:25:55 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.E3.01710.2F130936; Wed,  7 Dec 2022 15:25:54 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221207060526epcas5p2b0d11f348961e4a396719a5083b5bc9b~ubbLN6Dln0528605286epcas5p2J;
        Wed,  7 Dec 2022 06:05:26 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221207060526epsmtrp151f2654c4f9be1bcdc17e7b08120e6ef~ubbLMyC-o2134921349epsmtrp1u;
        Wed,  7 Dec 2022 06:05:26 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-0f-639031f2280e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A7.1F.18644.62D20936; Wed,  7 Dec 2022 15:05:26 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221207060523epsmtip1078cf23e5c3801d20c040fc8f51d2068~ubbIJbS_c1873818738epsmtip1j;
        Wed,  7 Dec 2022 06:05:23 +0000 (GMT)
Date:   Wed, 7 Dec 2022 11:24:00 +0530
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
Message-ID: <20221207055400.GA6497@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221129114428.GA16802@test-zns>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVRTZRzHz727uxvg6DJBHuFkNMoEhG21rQeBIqPOLakoTp7KU7Sz3QMc
        9tY2UIhqJG+iCAieaDZdCSIvigyUN+HgjBCIqAANbAJHppJH3gOMhAYXOv73+b18fy/P7zxs
        Bvc4y4sdr9JTWpVUwcOdsUtX/XYEzgjzZQJDbwis7vqJAb/Of8SAlbY8HC719DJgy8QJJhxs
        a0RheWU7Cpu/n0Zh+8oDHI7ODWHwmPU6Au0DRhS2DAXAyy2dGOxr+g6Hp87YWdBaeBCFBR21
        TNgwlobA2dJ0Fjx/fxKD14a8Ye+jDma4J2kc7sHJRqONRfbeqsHIvp5E0lJxCCdrS74imwcN
        OJl7cMKRkDHMJCdbB3DyaF0FQs5atpFZbYdR0jL2AI1y/SghNI6SyimtD6WSqeXxqtgw3p7o
        mFdjxBKBMFAYDF/k+aikSiqMFxEZFfh6vMKxP88nSapIdLiipDodj/9SqFadqKd84tQ6fRiP
        0sgVGpEmSCdV6hJVsUEqSr9LKBA8L3YkfpoQd6O7iql5uONA89+DTANS5pODOLEBIQL/2nOx
        VeYSzQg4fS48B3F28AwCjszfxGhjFgF3OgpZG4qKcTNOB5oQ8HDyVwZt3EFAZtbAWi2MeAbc
        G//ToWCzcSIAdK+wV93uBA/YbJVrhRiEAQP2QWKVNxORIGe5Dl9lDrET5N4tZ9LsBjq/HVsr
        6UQEgT+OnVrTehC+oO1SB7raFxDVTmDgXA5OTxcBRidNGM2bwV8ddetTe4HxvMx13g/Ki87i
        tDgdAcYbRoQOvAwyuvIY9HRxoPGCZb3ok+B413mU9ruC3KUxlPZzQMPJDfYFVdXm9fyt4PpC
        2jqToH+qFKFfqB4FK+0mVj7ylPGx7YyP9aN5JzA3zziY7WBvULbMptEPVDfxzQizAtlKaXTK
        WEon1ghV1P7/Ly5TKy3I2v/wf6MBsY1MBVkRlI1YEcBm8Nw592pyZVyOXJqcQmnVMdpEBaWz
        ImLHsQoYXh4yteODqfQxQlGwQCSRSETBL0iEPE9OaVG2jEvESvVUAkVpKO2GDmU7eRlQ0Wdp
        83tLFnyVSVUTV18r+UR1+tmphjx8PsKl/676QPETisKlovpU5whTTr1H8Dv8GdbiPjdld8Jv
        ESVLru5ZAWxh4CsjJlO2nDvXYA/xd44WfCn4J3kk7RZ6+cz2VHteZoylrkA6ePEKM/WEy7Yk
        rxJ3+H4td9+m5bCok4e/4HeFvLf986ayt+Q6w24JWd169gdO1srv4uJdWID5m+J0t7qpCcVC
        3/2Pl4H1gqdvrbsydPoiU8+XmrfYTG/evD3aknyUaZrf2zYa3Zfx47Rp9x4Gf6V7cTjK/vQi
        N3BTgUt469vXUn5xea5myxWs0+XdcHFK9ge3qZ8jx/o91XOl3kf8PuRhujip0J+h1Un/Axlo
        9gGoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0xSYRjH955zOBxZtBN2ecWyQtOipKy23i6j1mo7c11cl63ZB2V2NJco
        46RZdkGtlZRG1taiZrZKA5clmnmBMpKQGtq6WGFoLUmtlBptlaUWsFbffnt+///zfHgoXNRJ
        iKn0zN2sOlORISEFRP19SURsdKwuZYFeG4puPHyAowLdCI6q3CdJ9NPZgSPL0HkeetXSiCFD
        lQ1DzZe+YMg2Nkiit19dBCq1dgLkea7HkMU1F5ktDgI9bbpAoosVHj6yni7E0Cl7LQ819OYD
        5Lt6mI+qP3oJ1OYKRx0jdt6qKYy+x0kyjXo3n+noriGYp85sxmQsIpnaK4eY5lcakikuHPoT
        ONLDY7x3npNMSZ0RMD5TBHO05TjGmHoHsYTxiYIVO9iM9BxWPV+eLNhpbiwgVI3RuRrPVA3Q
        RGhBCAXpxdA4UE5qgYAS0Q0AFg4fxoIiDFaMtOJBDoWG0T5+MNQLYN/99oAg6CjYP/D6j6Ao
        kp4LH41R/vFEWgLd7qpAHqcLCFjW2UX6RSi9DmpH6wIspOfB4j4DL7i0GYMjHywgKCZAx7le
        ws84LYUvRwcw/wGcDoeVo4EDIbQMviy9yPfzJDoSttTbMR2YoP+vrf+vrf/XLge4EYSxKk6Z
        puTiVAsz2T0yTqHksjPTZClZShMIvF4qbQBm42eZFWAUsAJI4ZKJwv6a4hSRcIdi7z5WnZWk
        zs5gOSsIpwjJFOFjrSNJRKcpdrO7WFbFqv9ajAoRa7Bq6aWFNdfkTwy53/tlVs+bY+vkVWPx
        DqlmgadssHROyX6hlB3SlVne2xZbE0QHUu+pj52PXJ3/rPXuJlNP95A5folvMHHNqoEuV6K7
        NEL27NbSM63vPvgOzTFuUjlj673yE+0rRL7JUeMqv5rP5q7vvIlUvFlFqeK3bd66Ty+6kjDd
        5dcx9mspWze0z9zCHuTlOcP3r93YcEYemVw9n1u0zfnGyyXeLskW2GNiZ4ftdc5Qtzbd8Rng
        5LvTU01Xl+jGtwHjN29Mjm1P9K3urJwih3K7a1p8fVzT8NG8X+k9G5fP89WuXBmXgMTXr59K
        tv0Q5kdtXlaem6YS50XeHLZMlRDcTkWcFFdzit8mHo8xaQMAAA==
X-CMS-MailID: 20221207060526epcas5p2b0d11f348961e4a396719a5083b5bc9b
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_154c2_"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061017epcas5p246a589e20eac655ac340cfda6028ff35
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061017epcas5p246a589e20eac655ac340cfda6028ff35@epcas5p2.samsung.com>
        <20221123055827.26996-3-nj.shetty@samsung.com> <Y33UAp6ncSPO84XI@T590>
        <20221123100712.GA26377@test-zns> <Y3607N6lDRK6WU7/@T590>
        <20221129114428.GA16802@test-zns>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_154c2_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Nov 29, 2022 at 05:14:28PM +0530, Nitesh Shetty wrote:
> On Thu, Nov 24, 2022 at 08:03:56AM +0800, Ming Lei wrote:
> > On Wed, Nov 23, 2022 at 03:37:12PM +0530, Nitesh Shetty wrote:
> > > On Wed, Nov 23, 2022 at 04:04:18PM +0800, Ming Lei wrote:
> > > > On Wed, Nov 23, 2022 at 11:28:19AM +0530, Nitesh Shetty wrote:
> > > > > Introduce blkdev_issue_copy which supports source and destination bdevs,
> > > > > and an array of (source, destination and copy length) tuples.
> > > > > Introduce REQ_COPY copy offload operation flag. Create a read-write
> > > > > bio pair with a token as payload and submitted to the device in order.
> > > > > Read request populates token with source specific information which
> > > > > is then passed with write request.
> > > > > This design is courtesy Mikulas Patocka's token based copy
> > > > 
> > > > I thought this patchset is just for enabling copy command which is
> > > > supported by hardware. But turns out it isn't, because blk_copy_offload()
> > > > still submits read/write bios for doing the copy.
> > > > 
> > > > I am just wondering why not let copy_file_range() cover this kind of copy,
> > > > and the framework has been there.
> > > > 
> > > 
> > > Main goal was to enable copy command, but community suggested to add
> > > copy emulation as well.
> > > 
> > > blk_copy_offload - actually issues copy command in driver layer.
> > > The way read/write BIOs are percieved is different for copy offload.
> > > In copy offload we check REQ_COPY flag in NVMe driver layer to issue
> > > copy command. But we did missed it to add in other driver's, where they
> > > might be treated as normal READ/WRITE.
> > > 
> > > blk_copy_emulate - is used if we fail or if device doesn't support native
> > > copy offload command. Here we do READ/WRITE. Using copy_file_range for
> > > emulation might be possible, but we see 2 issues here.
> > > 1. We explored possibility of pulling dm-kcopyd to block layer so that we 
> > > can readily use it. But we found it had many dependecies from dm-layer.
> > > So later dropped that idea.
> > 
> > Is it just because dm-kcopyd supports async copy? If yes, I believe we
> > can reply on io_uring for implementing async copy_file_range, which will
> > be generic interface for async copy, and could get better perf.
> >
> 
> It supports both sync and async. But used only inside dm-layer.
> Async version of copy_file_range can help, using io-uring can be helpful
> for user , but in-kernel users can't use uring.
> 
> > > 2. copy_file_range, for block device atleast we saw few check's which fail
> > > it for raw block device. At this point I dont know much about the history of
> > > why such check is present.
> > 
> > Got it, but IMO the check in generic_copy_file_checks() can be
> > relaxed to cover blkdev cause splice does support blkdev.
> > 
> > Then your bdev offload copy work can be simplified into:
> > 
> > 1) implement .copy_file_range for def_blk_fops, suppose it is
> > blkdev_copy_file_range()
> > 
> > 2) inside blkdev_copy_file_range()
> > 
> > - if the bdev supports offload copy, just submit one bio to the device,
> > and this will be converted to one pt req to device
> > 
> > - otherwise, fallback to generic_copy_file_range()
> >
> 

Actually we sent initial version with single bio, but later community
suggested two bio's is must for offload, main reasoning being
dm-layer,Xcopy,copy across namespace compatibilty.

> We will check the feasibilty and try to implement the scheme in next versions.
> It would be helpful, if someone in community know's why such checks were
> present ? We see copy_file_range accepts only regular file. Was it
> designed only for regular files or can we extend it to regular block
> device.
>

As you suggested we were able to integrate def_blk_ops and
run with user application, but we see one main issue with this approach.
Using blkdev_copy_file_range requires having 2 file descriptors, which
is not possible for in kernel users such as fabrics/dm-kcopyd which has
only bdev descriptors.
Do you have any plumbing suggestions here ?

> > > 
> > > > When I was researching pipe/splice code for supporting ublk zero copy[1], I
> > > > have got idea for async copy_file_range(), such as: io uring based
> > > > direct splice, user backed intermediate buffer, still zero copy, if these
> > > > ideas are finally implemented, we could get super-fast generic offload copy,
> > > > and bdev copy is really covered too.
> > > > 
> > > > [1] https://lore.kernel.org/linux-block/20221103085004.1029763-1-ming.lei@redhat.com/
> > > > 
> > > 
> > > Seems interesting, We will take a look into this.
> > 
> > BTW, that is probably one direction of ublk's async zero copy IO too.
> > 
> > 
> > Thanks, 
> > Ming
> > 
> > 
> 
> 
> Thanks,
> Nitesh

Thanks,
Nitesh Shetty


------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_154c2_
Content-Type: text/plain; charset="utf-8"


------O100lSkHJvpeqAZUg6J-pc56spCM8SnYWoYgfiXYPjbcU737=_154c2_--
