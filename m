Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C442B35EE12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348469AbhDNG72 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 02:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349591AbhDNG7N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:59:13 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B11C061574;
        Tue, 13 Apr 2021 23:58:52 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id j26so19636423iog.13;
        Tue, 13 Apr 2021 23:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPvXMTpUNl3IxdG2GdqWLZcBOjF3pDi559BGFj5cKe8=;
        b=e5PSEGY9BDrjmpgpr1JDTixtaSfJ7lUkQfQofKGJFTaxWSf77oTAkZfVa/2O+TS5dW
         eKoMP9B+vnaz4hLpdAQWXWwhO25xpQs7hfZJKyS4+7XL71K5E2369zyC/5JZMUDY2/0G
         rcsd5BOHW/WDdWXnB60fXErG4m7mKCiymxzKVlqItMnrhqaF2na8AprV+mUZSSfD2XdZ
         j/XMXdcInl4r0vsmy0rtFemZRTCl8mDtEV0kYcRVD+xDrt45g2qUNZIJr3f4P1dreG8r
         0bCmU1FuJE2EZQsl5ACajy0rLM7hsKYhA6JgpY896xMy/C+GuqNMkUYjIj3itjHf1RRm
         DQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPvXMTpUNl3IxdG2GdqWLZcBOjF3pDi559BGFj5cKe8=;
        b=LKj0mosX6lmQYsSQHd0aUlaX3DjyBFM4ZSF/LzXyLCDQC1GhUFGSVU2ja1pOI0HFRp
         1T/G1kebf64Oaxk9haGIB4SR6uqIQCWD/D30TMxhY1yUQ8gLPylI1B/TFCgmd3QOFjA3
         QAOUEXchxg25B5clcs0JXCmSei6bsbAO/Ilbko0hvwt2/MlE5o3FICvrYEIYKsiclZ7x
         gIJ0MjSULSmCLCXGQ15q/vK/PkPfVq7t0daK6KElSaYACkLk1vOn2jwszKJPVEV0OLUy
         oWRWG5mG3EcmPVHvlEnf5/ehV2nhy/mN7RceKpQxt646Z8cVZp4gAICOCha5NQDsFGEY
         A0gg==
X-Gm-Message-State: AOAM5301NQH0xR4wthgCBtNNRHu/QCYF/YJa6g+2QcpuGfL+kcFMVbP+
        IHBKg5HbVwg0+DOPKTNWLwe85S+S5Svzq68GeyA=
X-Google-Smtp-Source: ABdhPJxVn0379a/e+lrGuK9nJvBnaVZRkG+95gHH+6KyBvsrtfKcHhnhaQQ04D+xJ04y9zRQrXsU7onZw/arekICxKA=
X-Received: by 2002:a6b:f909:: with SMTP id j9mr30365082iog.138.1618383531741;
 Tue, 13 Apr 2021 23:58:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com> <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com>
 <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vYvtOaVL4LG0gAGCMz+a8uha8czH==Dgg3eG+TWA+xeVQ@mail.gmail.com> <BL0PR04MB65146169A9C7527280C15D4AE74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB65146169A9C7527280C15D4AE74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Selva Jove <selvajove@gmail.com>
Date:   Wed, 14 Apr 2021 12:28:39 +0530
Message-ID: <CAHqX9vYPVwYLT5Bdk_GqKZWxpJNib9fYidEmT0j+bRikwyLgKw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 2/4] block: add simple copy support
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "joshiiitr@gmail.com" <joshiiitr@gmail.com>,
        "nj.shetty@samsung.com" <nj.shetty@samsung.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        "javier.gonz@samsung.com" <javier.gonz@samsung.com>,
        "kch@kernel.org" <kch@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I agree with you. Will remove BLKDEV_COPY_NOEMULATION.

On Tue, Apr 13, 2021 at 6:03 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/04/12 23:35, Selva Jove wrote:
> > On Mon, Apr 12, 2021 at 5:55 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
> >>
> >> On 2021/04/07 20:33, Selva Jove wrote:
> >>> Initially I started moving the dm-kcopyd interface to the block layer
> >>> as a generic interface.
> >>> Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is
> >>> tightly coupled with dm_io()
> >>>
> >>> To move dm-kcopyd to block layer, it would also require dm_io code to
> >>> be moved to block layer.
> >>> It would cause havoc in dm layer, as it is the backbone of the
> >>> dm-layer and needs complete
> >>> rewriting of dm-layer. Do you see any other way of doing this without
> >>> having to move dm_io code
> >>> or to have redundant code ?
> >>
> >> Right. Missed that. So reusing dm-kcopyd and making it a common interface will
> >> take some more efforts. OK, then. For the first round of commits, let's forget
> >> about this. But I still think that your emulation could be a lot better than a
> >> loop doing blocking writes after blocking reads.
> >>
> >
> > Current implementation issues read asynchronously and once all the reads are
> > completed, then the write is issued as whole to reduce the IO traffic
> > in the queue.
> > I agree that things can be better. Will explore another approach of
> > sending writes
> > immediately once reads are completed and with  plugging to increase the chances
> > of merging.
> >
> >> [...]
> >>>>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> >>>>> +             struct range_entry *src_rlist, struct block_device *dest_bdev,
> >>>>> +             sector_t dest, gfp_t gfp_mask, int flags)
> >>>>> +{
> >>>>> +     struct request_queue *q = bdev_get_queue(src_bdev);
> >>>>> +     struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> >>>>> +     struct blk_copy_payload *payload;
> >>>>> +     sector_t bs_mask, copy_size;
> >>>>> +     int ret;
> >>>>> +
> >>>>> +     ret = blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
> >>>>> +                     &payload, &copy_size);
> >>>>> +     if (ret)
> >>>>> +             return ret;
> >>>>> +
> >>>>> +     bs_mask = (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> >>>>> +     if (dest & bs_mask) {
> >>>>> +             return -EINVAL;
> >>>>> +             goto out;
> >>>>> +     }
> >>>>> +
> >>>>> +     if (q == dest_q && q->limits.copy_offload) {
> >>>>> +             ret = blk_copy_offload(src_bdev, payload, dest, gfp_mask);
> >>>>> +             if (ret)
> >>>>> +                     goto out;
> >>>>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {
> >>>>
> >>>> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would that
> >>>> user say "Fail on me if the device does not support copy" ??? This is a weird
> >>>> interface in my opinion.
> >>>>
> >>>
> >>> BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() callers
> >>> to use their native copying method instead of the emulated copy that I
> >>> added. This way we
> >>> ensure that dm uses the hw-assisted copy and if that is not present,
> >>> it falls back to existing
> >>> copy method.
> >>>
> >>> The other users who don't have their native emulation can use this
> >>> emulated-copy implementation.
> >>
> >> I do not understand. Emulation or not should be entirely driven by the device
> >> reporting support for simple copy (or not). It does not matter which component
> >> is issuing the simple copy call: an FS to a real device, and FS to a DM device
> >> or a DM target driver. If the underlying device reported support for simple
> >> copy, use that. Otherwise, emulate with read/write. What am I missing here ?
> >>
> >
> > blkdev_issue_copy() api will generally complete the copy-operation,
> > either by using
> > offloaded-copy or by using emulated-copy. The caller of the api is not
> > required to
> > figure the type of support. However, it can opt out of emulated-copy
> > by specifying
> > the flag BLKDEV_NOEMULATION. This is helpful for the case when the
> > caller already
> > has got a sophisticated emulation (e.g. dm-kcopyd users).
>
> This does not make any sense to me. If the user has already another mean of
> doing copies, then that user will not call blkdev_issue_copy(). So I really do
> not understand what the "opting out of emulated copy" would be useful for. That
> user can check the simple copy support glag in the device request queue and act
> accordingly: use its own block copy code when simple copy is not supported or
> use blkdev_issue_copy() when the device has simple copy. Adding that
> BLKDEV_COPY_NOEMULATION does not serve any purpose at all.
>
>
>
> --
> Damien Le Moal
> Western Digital Research
