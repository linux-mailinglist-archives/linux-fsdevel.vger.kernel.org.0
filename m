Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5D23EEEC6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238070AbhHQOtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 10:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237387AbhHQOtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 10:49:01 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09F0C061764;
        Tue, 17 Aug 2021 07:48:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z2so41934333lft.1;
        Tue, 17 Aug 2021 07:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkI5q0Ud7n3yU60UTm3c6JeteGC7wMUAGiEejPjFM0g=;
        b=Vnd8MvzcyIJss0OkwpMOukq2mHc6qzT3i2r3F2v8Rq3m4IyAu38H3oi2pVyzXM9G+s
         9VecOZWA8UAF+urrr+2W519JaLBlHuWQzG+UDOngpQkbSQIj0M/0ws8PZhy6xLhG07Wa
         Vz/DJoYr8NWlmQtvDqIea+oR7xpJHXXiqxGFF3SOwH7uyLdNstSbjKZJ2uXuFYYwEX4r
         fr0NXkker9zxQM8m6Q9vTdYWONIUCHPKEIJ0MuujaeG25SlMoKnMoV0oCv6SIjnOz5rU
         sugq1U8oav7TjjWnQTEBM/oIZ7yUGwYL0iDYaL2+yIIAxr4gb+Bxv6Th8TCaf6NRLBLn
         4brg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkI5q0Ud7n3yU60UTm3c6JeteGC7wMUAGiEejPjFM0g=;
        b=ggeSSe0+VIq09hlpo4BnoMUHHT3bZBNwS1pnkZhFgn8LsuzApV/CIaOsXK1UfqNqCI
         iZDlHh2UQG93phNS//zmaFeLfwKxrNPfP8nDRF3vgTGaesyERXp/8Aw3XpMvbjVpP0c7
         6VdddArZpu5kV34sr0ZnQjV1EClbPqR1VLSrBZgxb5BDlMPXTxjwM8RMEA38dr0WyVDk
         V1tkD3Jw0Z6fLUNaWoGhgkJcQCCdu+Ie55Qe7xjGyBdOOcc4SayEmt9tYdt0jQ4OgY2d
         lm9iJ68tK+grP/YjiJEexs0EFyQ0ohKUwxawfxI1A8holxDa4PAid5mX4pPwAlSs+Q8g
         BKTw==
X-Gm-Message-State: AOAM531TDoc2yCzxAZs6yaq1yo1Y8T3nICzL3SG1YpzDqSc3wfGf8I5q
        SbCGT/HltTeAKuLaAwW2Pn0fwggIkx4Vnqw0EPA=
X-Google-Smtp-Source: ABdhPJy78VibbpwFw9aY9bJD6KbF0FN0r9oY1sz4LqrxVQ5ggLWZJqClrS+h2E/ukIwkOys47vQF7tDbHI+OS3kdo5Q=
X-Received: by 2002:ac2:4573:: with SMTP id k19mr2666539lfm.459.1629211705214;
 Tue, 17 Aug 2021 07:48:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com> <YRu1WFImFulfpk7s@kroah.com>
In-Reply-To: <YRu1WFImFulfpk7s@kroah.com>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Tue, 17 Aug 2021 20:18:13 +0530
Message-ID: <CAOSviJ2q-y8h=Pf4t7oUZoL7WHdYeFQQOnoeN6Ta07iPNjX-wg@mail.gmail.com>
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
To:     Greg KH <greg@kroah.com>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 17, 2021 at 6:40 PM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Aug 17, 2021 at 03:44:20PM +0530, SelvaKumar S wrote:
> > From: Nitesh Shetty <nj.shetty@samsung.com>
> >
> > Add new BLKCOPY ioctl that offloads copying of one or more sources ranges
> > to a destination in the device. COPY ioctl accepts a 'copy_range'
> > structure that contains destination (in sectors), no of sources and
> > pointer to the array of source ranges. Each source range is represented by
> > 'range_entry' that contains start and length of source ranges (in sectors)
> >
> > MAX_COPY_NR_RANGE, limits the number of entries for the IOCTL and
> > MAX_COPY_TOTAL_LENGTH limits the total copy length, IOCTL can handle.
> >
> > Example code, to issue BLKCOPY:
> > /* Sample example to copy three source-ranges [0, 8] [16, 8] [32,8] to
> >  * [64,24], on the same device */
> >
> > int main(void)
> > {
> >       int ret, fd;
> >       struct range_entry source_range[] = {{.src = 0, .len = 8},
> >               {.src = 16, .len = 8}, {.src = 32, .len = 8},};
> >       struct copy_range cr;
> >
> >       cr.dest = 64;
> >       cr.nr_range = 3;
> >       cr.range_list = (__u64)&source_range;
> >
> >       fd = open("/dev/nvme0n1", O_RDWR);
> >       if (fd < 0) return 1;
> >
> >       ret = ioctl(fd, BLKCOPY, &cr);
> >       if (ret < 0) printf("copy failure\n");
> >
> >       close(fd);
> >
> >       return ret;
> > }
> >
> > Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> > Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
> > Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> > ---
> >  block/ioctl.c           | 33 +++++++++++++++++++++++++++++++++
> >  include/uapi/linux/fs.h |  8 ++++++++
> >  2 files changed, 41 insertions(+)
> >
> > diff --git a/block/ioctl.c b/block/ioctl.c
> > index eb0491e90b9a..2af56d01e9fe 100644
> > --- a/block/ioctl.c
> > +++ b/block/ioctl.c
> > @@ -143,6 +143,37 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
> >                                   GFP_KERNEL, flags);
> >  }
> >
> > +static int blk_ioctl_copy(struct block_device *bdev, fmode_t mode,
> > +             unsigned long arg)
> > +{
> > +     struct copy_range crange;
> > +     struct range_entry *rlist;
> > +     int ret;
> > +
> > +     if (!(mode & FMODE_WRITE))
> > +             return -EBADF;
> > +
> > +     if (copy_from_user(&crange, (void __user *)arg, sizeof(crange)))
> > +             return -EFAULT;
> > +
> > +     rlist = kmalloc_array(crange.nr_range, sizeof(*rlist),
> > +                     GFP_KERNEL);
>
> No error checking for huge values of nr_range?  Is that wise?  You
> really want userspace to be able to allocate "all" of the kernel memory
> in the system?
>
> thanks,
>
> greg k-h

We added a kernel imposed limit MAX_COPY_NR_RANGE for that purpose,
but missed adding the check here.
Will have that fixed. Thanks for pointing this out.

Nitesh Shetty
