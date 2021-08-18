Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A7B3F0828
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 17:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhHRPip (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 11:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhHRPio (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:38:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B8C061764;
        Wed, 18 Aug 2021 08:38:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d16so5879371ljq.4;
        Wed, 18 Aug 2021 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w3ll9rEluHSDama/Ed30duPlqRRIZoR05Nb3hLVOtx8=;
        b=SZVyg6lcsl/zo5CQqmnYbxPEke1lmc5Wz/0/h3x/snSVKlDBfFRhOlIulTvCvq3CmL
         2AyUcVNoWh6fT8Y2mzqhstEN0tBtfFcE/FmFdS2YeoYgZP2b9jP6bLJqHtTqeK7LjYth
         pRLrydLxUCJwpDery90ZnH7XK18jSm3UmpaULXrq8FN1Q9fA2ppL0RbXETVAC4qX+HDX
         ZCmhAqQ1sxilJpxz1gjjW/rx7y41x5IBLvJ1cZXL5mBrMFbis7YA4Y65Om1Vd47DRa+L
         25KZv4FSH7L7dHotSmtqSHaWg64HeTwEl2H+LAKT55KNTpgshS/Y8Upz7gDN6yFevoJr
         2vCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w3ll9rEluHSDama/Ed30duPlqRRIZoR05Nb3hLVOtx8=;
        b=bTDiSFknckwblYYvm9OG0QEsXgXWWrIMDuG/1rtM3kUvMpdryJ8nbHW3b2yNnOUVNb
         ypsPn3gn2ruRZZIcEPySEnx3UvTVczmA2/ViyKYGZW1pDcfUhMooGmCET3+MFXTJrU59
         EbA7F2x20J2L28t4YHaCbleklKOXjNJ+yj/HP041KI0ly+fxKVweUApk6popAyOn9u2V
         2QsPBoxe8AdAFr3qTwD4ZKcuJjGtVQXsuYch9maVg9QmyRXkxRYZp12tVe/WvuHgFqR6
         UegCXOC6pJnKCl2JU7bPYv3pb8ReyLwwfewVoNe2Q5DaSa/rUrubcNv4S2aTKSbl8nfm
         MoRA==
X-Gm-Message-State: AOAM532v2zGXBMQcBzkQg8duCcpfTC5cQ1Aczmgt367WYKi7n/osiE4c
        lm6lvwvZVDQkHW8rANzJpR1x59uZwS+Ca3C+78Y=
X-Google-Smtp-Source: ABdhPJyHlvwEZDvtVg7ECPybOIfKBF9lejw9ydLmJNwCaSnodUkhQwT38M17ag35N8pXpz0/br0Ro2/VbLkmdjAWlpM=
X-Received: by 2002:a2e:a37a:: with SMTP id i26mr3352203ljn.466.1629301087484;
 Wed, 18 Aug 2021 08:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
 <CGME20210817101803epcas5p10cda1d52f8a8f1172e34b1f9cf8eef3b@epcas5p1.samsung.com>
 <20210817101423.12367-5-selvakuma.s1@samsung.com> <20210817233613.GA12597@magnolia>
In-Reply-To: <20210817233613.GA12597@magnolia>
From:   Nitesh Shetty <nitheshshetty@gmail.com>
Date:   Wed, 18 Aug 2021 21:07:54 +0530
Message-ID: <CAOSviJ2+deUdDXTWbWXaSxNX2t6cnhPg7KCDA4C2qm74KD9vdQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] block: Introduce a new ioctl for simple copy
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     SelvaKumar S <selvakuma.s1@samsung.com>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, snitzer@redhat.com,
        agk@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com, javier.gonz@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 5:06 AM Darrick J. Wong <djwong@kernel.org> wrote:
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
> > +     if (!rlist)
> > +             return -ENOMEM;
> > +
> > +     if (copy_from_user(rlist, (void __user *)crange.range_list,
> > +                             sizeof(*rlist) * crange.nr_range)) {
> > +             ret = -EFAULT;
> > +             goto out;
> > +     }
> > +
> > +     ret = blkdev_issue_copy(bdev, crange.nr_range, rlist, bdev, crange.dest,
> > +                     GFP_KERNEL, 0);
> > +out:
> > +     kfree(rlist);
> > +     return ret;
> > +}
> > +
> >  static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
> >               unsigned long arg)
> >  {
> > @@ -468,6 +499,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
> >       case BLKSECDISCARD:
> >               return blk_ioctl_discard(bdev, mode, arg,
> >                               BLKDEV_DISCARD_SECURE);
> > +     case BLKCOPY:
> > +             return blk_ioctl_copy(bdev, mode, arg);
> >       case BLKZEROOUT:
> >               return blk_ioctl_zeroout(bdev, mode, arg);
> >       case BLKGETDISKSEQ:
> > diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> > index 7a97b588d892..4183688ff398 100644
> > --- a/include/uapi/linux/fs.h
> > +++ b/include/uapi/linux/fs.h
> > @@ -76,6 +76,13 @@ struct range_entry {
> >       __u64 len;
> >  };
> >
> > +struct copy_range {
> > +     __u64 dest;
> > +     __u64 nr_range;
>
> If the maximum number of elements in the range list is 1<<12, there's no
> need for this to be larger than a u16, right?
>
> > +     __u64 range_list;
>
> Pointers embedded in a structure are /not/ a good idea, because this
> will create a lot of compatibility headaches for 32-bit binaries running
> on 64-bit kernels.  Please just make the size of this header structure
> a multiple of 8 bytes and put the range_entry list immediately after it.
>
> struct copy_range {
>         __s64 dest_offset;
>         __u32 nr_range_entries;
>         __u32 flags;
>         __u64 reserved[2];
> };
>
> struct __user range_entry *re = ((struct range_entry *)(copyhead + 1));
>
> copy_from_user(&urk, re...);
>
> --D
>
Thanks, this is better. 'Reserved' field was there to be used for
future extension of the interface.
Now that you mentioned 'flags', it seems we can do away with
'reserved' fields altogether?

Regards,
Nitesh Shetty
