Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2259F35C8D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Apr 2021 16:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241427AbhDLOf1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Apr 2021 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbhDLOf1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Apr 2021 10:35:27 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E90C061574;
        Mon, 12 Apr 2021 07:35:09 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id b17so11182653ilh.6;
        Mon, 12 Apr 2021 07:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nl+e8gruZE2jm3U6Sm5K1rbed6F1G7jwfaUBg/d7wnQ=;
        b=GEMfpQ63psb9h6jsOfJpCEamzHSC5KM6k6vvRkDUI9IH9wYf2vk0LAaZkhrDP5uqJP
         9re2EwPVlFlea8z1dP7DMq08Hkb4+lj/tUSRLs/1bu+vp5kF+WEOn/bASDlbEvfJ7qhW
         TlWimpek6XvxG+fPQApyWIlsa4gY3UMXD0CGekbaxI2O9nC2BkaWssIiIgM1Ko9hug7C
         up/g+Ahu5aAAgcAOkP9rxOVRJINfo5vYUVYAr32YtS3Cn/Y/qD5hCyLC7Q/RxewJ26OE
         4dWVYcA6NZn12wcJSGE7iUpBUs02nrhr/MQn5bid2/JRu4tb3w1285QRXJUb0EEhZTko
         bhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nl+e8gruZE2jm3U6Sm5K1rbed6F1G7jwfaUBg/d7wnQ=;
        b=F+xQW/Pe5r1XMdqRR/xSv/fb0FsgHNCHzzuEE+Arx5O4X4ntfYor1yQK9I7HbyT34a
         Tv2r2If/8Ep+rQC2aNdvn+/VbNB2pW/npXiQJpvB4QSkCyfu9Huo03WQwwSISSBMy8Wo
         /l+CDHezXQ4CVZOD0fYk1OpMlVnGYdkGprfN+77TVidDGPWqb4o/EJkQyupHs+9gv5fn
         EDHDcZdKrv57ZxEVnEBa9VA6VoGjERnglcwMfUIEtOWkdNzCSkYkllF8uDd5se1LWknz
         B5iqVrW4UavVq5DrS1n/63CMtEUnRXuekUqHlcSPACi6aDKUugIJt18xEWSG76e5aMo1
         DxGw==
X-Gm-Message-State: AOAM531JsO1wa49hkx5D9r8KhkXE0HqtGAiV21vIYos2dgcp8bxFzS0v
        O3R6H5ONe4fFv6JGeNQzNFMYsnUuXPsA/WGY7ao=
X-Google-Smtp-Source: ABdhPJzIyljg2UrVufiKLCV4AtEnX0lojUYHBV69oqiVNW99rdpYudFQX35/feDopBRdXXdq5MJ1SOwFrLXrR9vCLQU=
X-Received: by 2002:a05:6e02:11a9:: with SMTP id 9mr13004896ilj.288.1618238107878;
 Mon, 12 Apr 2021 07:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
 <CGME20210219124603epcas5p33add0f2c1781b2a4d71bf30c9e1ac647@epcas5p3.samsung.com>
 <20210219124517.79359-3-selvakuma.s1@samsung.com> <BL0PR04MB6514EA91680D33A5890ECE16E7839@BL0PR04MB6514.namprd04.prod.outlook.com>
 <CAHqX9vb6GgaU9QdTQaq3=dGuoNCuWorLrGCF8gC5LEdFBESFcA@mail.gmail.com> <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
In-Reply-To: <BL0PR04MB6514B34000467FABFD6BF385E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
From:   Selva Jove <selvajove@gmail.com>
Date:   Mon, 12 Apr 2021 20:04:55 +0530
Message-ID: <CAHqX9vYvtOaVL4LG0gAGCMz+a8uha8czH==Dgg3eG+TWA+xeVQ@mail.gmail.com>
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

On Mon, Apr 12, 2021 at 5:55 AM Damien Le Moal <Damien.LeMoal@wdc.com> wrote:
>
> On 2021/04/07 20:33, Selva Jove wrote:
> > Initially I started moving the dm-kcopyd interface to the block layer
> > as a generic interface.
> > Once I dig deeper in dm-kcopyd code, I figured that dm-kcopyd is
> > tightly coupled with dm_io()
> >
> > To move dm-kcopyd to block layer, it would also require dm_io code to
> > be moved to block layer.
> > It would cause havoc in dm layer, as it is the backbone of the
> > dm-layer and needs complete
> > rewriting of dm-layer. Do you see any other way of doing this without
> > having to move dm_io code
> > or to have redundant code ?
>
> Right. Missed that. So reusing dm-kcopyd and making it a common interface will
> take some more efforts. OK, then. For the first round of commits, let's forget
> about this. But I still think that your emulation could be a lot better than a
> loop doing blocking writes after blocking reads.
>

Current implementation issues read asynchronously and once all the reads are
completed, then the write is issued as whole to reduce the IO traffic
in the queue.
I agree that things can be better. Will explore another approach of
sending writes
immediately once reads are completed and with  plugging to increase the chances
of merging.

> [...]
> >>> +int blkdev_issue_copy(struct block_device *src_bdev, int nr_srcs,
> >>> +             struct range_entry *src_rlist, struct block_device *dest_bdev,
> >>> +             sector_t dest, gfp_t gfp_mask, int flags)
> >>> +{
> >>> +     struct request_queue *q = bdev_get_queue(src_bdev);
> >>> +     struct request_queue *dest_q = bdev_get_queue(dest_bdev);
> >>> +     struct blk_copy_payload *payload;
> >>> +     sector_t bs_mask, copy_size;
> >>> +     int ret;
> >>> +
> >>> +     ret = blk_prepare_payload(src_bdev, nr_srcs, src_rlist, gfp_mask,
> >>> +                     &payload, &copy_size);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     bs_mask = (bdev_logical_block_size(dest_bdev) >> 9) - 1;
> >>> +     if (dest & bs_mask) {
> >>> +             return -EINVAL;
> >>> +             goto out;
> >>> +     }
> >>> +
> >>> +     if (q == dest_q && q->limits.copy_offload) {
> >>> +             ret = blk_copy_offload(src_bdev, payload, dest, gfp_mask);
> >>> +             if (ret)
> >>> +                     goto out;
> >>> +     } else if (flags & BLKDEV_COPY_NOEMULATION) {
> >>
> >> Why ? whoever calls blkdev_issue_copy() wants a copy to be done. Why would that
> >> user say "Fail on me if the device does not support copy" ??? This is a weird
> >> interface in my opinion.
> >>
> >
> > BLKDEV_COPY_NOEMULATION flag was introduced to allow blkdev_issue_copy() callers
> > to use their native copying method instead of the emulated copy that I
> > added. This way we
> > ensure that dm uses the hw-assisted copy and if that is not present,
> > it falls back to existing
> > copy method.
> >
> > The other users who don't have their native emulation can use this
> > emulated-copy implementation.
>
> I do not understand. Emulation or not should be entirely driven by the device
> reporting support for simple copy (or not). It does not matter which component
> is issuing the simple copy call: an FS to a real device, and FS to a DM device
> or a DM target driver. If the underlying device reported support for simple
> copy, use that. Otherwise, emulate with read/write. What am I missing here ?
>

blkdev_issue_copy() api will generally complete the copy-operation,
either by using
offloaded-copy or by using emulated-copy. The caller of the api is not
required to
figure the type of support. However, it can opt out of emulated-copy
by specifying
the flag BLKDEV_NOEMULATION. This is helpful for the case when the
caller already
has got a sophisticated emulation (e.g. dm-kcopyd users).

>
> [...]
> >>> @@ -565,6 +569,12 @@ int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
> >>>       if (b->chunk_sectors)
> >>>               t->chunk_sectors = gcd(t->chunk_sectors, b->chunk_sectors);
> >>>
> >>> +     /* simple copy not supported in stacked devices */
> >>> +     t->copy_offload = 0;
> >>> +     t->max_copy_sectors = 0;
> >>> +     t->max_copy_range_sectors = 0;
> >>> +     t->max_copy_nr_ranges = 0;
> >>
> >> You do not need this. Limits not explicitely initialized are 0 already.
> >> But I do not see why you can't support copy on stacked devices. That should be
> >> feasible taking the min() for each of the above limit.
> >>
> >
> > Disabling stacked device support was feedback from v2.
> >
> > https://patchwork.kernel.org/project/linux-block/patch/20201204094659.12732-2-selvakuma.s1@samsung.com/
>
> Right. But the initialization to 0 is still not needed. The fields are already
> initialized to 0.
>
>
> --
> Damien Le Moal
> Western Digital Research
