Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540533F93F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Aug 2021 07:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbhH0FFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Aug 2021 01:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244218AbhH0FFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Aug 2021 01:05:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E89C0613D9
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 22:04:27 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so3196787plh.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Aug 2021 22:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=nFc3sdoCByIwYxggk+AQ1a3lDorwtem5TNHN34NU5Jc=;
        b=LgiKD4Zo3v0mLVNslAx3ru3XtLkSlizC6BQHy54CHr1TxM3DHOu8L6d9ohwdHl5jFZ
         LkcpZVu3aeWV1BX8/WFgZg1yawyzpq8FRD5EBw7PgkylUIhyTGYix6wr2qwhNnngONqR
         0KEMJ1c1HG4X4r9v8ML+NuRn40w61WyyPUGqLvzFkC62+nmMKhUUfuMWrU18/421ViQw
         qFNP/c7LIRCkO8UxTd8/rAJ/bKWN642/FNsp6dFY0IbLVvkYKT9H1q/Fr2eYwf6Wktjf
         Nu3mNKm9t+SZYpDwmalLqn/R31CQX0b42gZapFrwVOZEwfLcUvhSXcOfnpyRdxw2a61t
         npiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=nFc3sdoCByIwYxggk+AQ1a3lDorwtem5TNHN34NU5Jc=;
        b=rHR4z9ecUqYoc7PXGrO52IeZsfxglLCOAC4McVECnyrXrRfM242KUFl7sUXeebDyFw
         +6aHakHE6XQiL3W3G1Xrgybxh+2q66xAA1f3z52RlQSo6QEc5U5RtMS6mKBQPQnoVQdy
         9F3j1EMDQyblPT5QreeC+Z0NN2EZtTGYiUUlZPS0GONsRwhpxYYJk4jdeIcPb/SKAwmG
         RZZmOOpHG3oNzu/ldKtY3hLIyjuuyTNAN5NG2ttG0I9IYY7I/IIB43Au2Hg6ufioTACO
         vakNYclht1dRqun5v2RyRXyw21rSXU04dxL9B7ZZ9rEZJ2+vjB5R+TaxH1RiVVyZIJ3A
         WUUQ==
X-Gm-Message-State: AOAM533fggyEy//peLOKpv6h6hmjqTDZUbhEGHzpBQzUKvjIW67jxHHP
        16CS1pr9YfzuTWO/UnEoMmA59FsB7T56icWRlpPlQw==
X-Google-Smtp-Source: ABdhPJxvR/6WuE0nuMIGGz2Pojzx66g7oICbrEpMke2L3VvjgMUVihqBqiOP0icctaqTxFJqBEFwX39hG1MdjiOxRvM=
X-Received: by 2002:a17:902:e550:b0:137:734f:1d84 with SMTP id
 n16-20020a170902e55000b00137734f1d84mr6796413plf.27.1630040666934; Thu, 26
 Aug 2021 22:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
 <20210816060359.1442450-8-ruansy.fnst@fujitsu.com> <CAPcyv4jbi=p=SjFYZcHnEAu+KY821pW_k_yA5u6hya4jEfrTUg@mail.gmail.com>
 <c7e68dc8-5a43-f727-c262-58dcf244c711@fujitsu.com> <CAPcyv4jM86gy-T5EEZf6M2m44v4MiGqYDhxisX59M5QJii6DVg@mail.gmail.com>
 <32fa5333-b14e-2060-d659-d77f6c75ff16@fujitsu.com>
In-Reply-To: <32fa5333-b14e-2060-d659-d77f6c75ff16@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 26 Aug 2021 22:04:16 -0700
Message-ID: <CAPcyv4h801eipbvOpzSnw_GnUcuSxcm6eUfJdoHNW2ZmZgzW=Q@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] fsdax: Introduce dax_iomap_ops for end of reflink
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        david <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 26, 2021 at 8:30 PM Shiyang Ruan <ruansy.fnst@fujitsu.com> wrot=
e:
>
>
>
> On 2021/8/20 23:18, Dan Williams wrote:
> > On Thu, Aug 19, 2021 at 11:13 PM ruansy.fnst <ruansy.fnst@fujitsu.com> =
wrote:
> >>
> >>
> >>
> >> On 2021/8/20 =E4=B8=8A=E5=8D=8811:01, Dan Williams wrote:
> >>> On Sun, Aug 15, 2021 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.co=
m> wrote:
> >>>>
> >>>> After writing data, reflink requires end operations to remap those n=
ew
> >>>> allocated extents.  The current ->iomap_end() ignores the error code
> >>>> returned from ->actor(), so we introduce this dax_iomap_ops and chan=
ge
> >>>> the dax_iomap_*() interfaces to do this job.
> >>>>
> >>>> - the dax_iomap_ops contains the original struct iomap_ops and fsdax
> >>>>       specific ->actor_end(), which is for the end operations of ref=
link
> >>>> - also introduce dax specific zero_range, truncate_page
> >>>> - create new dax_iomap_ops for ext2 and ext4
> >>>>
> >>>> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> >>>> ---
> >>>>    fs/dax.c               | 68 +++++++++++++++++++++++++++++++++++++=
-----
> >>>>    fs/ext2/ext2.h         |  3 ++
> >>>>    fs/ext2/file.c         |  6 ++--
> >>>>    fs/ext2/inode.c        | 11 +++++--
> >>>>    fs/ext4/ext4.h         |  3 ++
> >>>>    fs/ext4/file.c         |  6 ++--
> >>>>    fs/ext4/inode.c        | 13 ++++++--
> >>>>    fs/iomap/buffered-io.c |  3 +-
> >>>>    fs/xfs/xfs_bmap_util.c |  3 +-
> >>>>    fs/xfs/xfs_file.c      |  8 ++---
> >>>>    fs/xfs/xfs_iomap.c     | 36 +++++++++++++++++++++-
> >>>>    fs/xfs/xfs_iomap.h     | 33 ++++++++++++++++++++
> >>>>    fs/xfs/xfs_iops.c      |  7 ++---
> >>>>    fs/xfs/xfs_reflink.c   |  3 +-
> >>>>    include/linux/dax.h    | 21 ++++++++++---
> >>>>    include/linux/iomap.h  |  1 +
> >>>>    16 files changed, 189 insertions(+), 36 deletions(-)
> >>>>
> >>>> diff --git a/fs/dax.c b/fs/dax.c
> >>>> index 74dd918cff1f..0e0536765a7e 100644
> >>>> --- a/fs/dax.c
> >>>> +++ b/fs/dax.c
> >>>> @@ -1348,11 +1348,30 @@ static loff_t dax_iomap_iter(const struct io=
map_iter *iomi,
> >>>>           return done ? done : ret;
> >>>>    }
> >>>>
> >>>> +static inline int
> >>>> +__dax_iomap_iter(struct iomap_iter *iter, const struct dax_iomap_op=
s *ops)
> >>>> +{
> >>>> +       int ret;
> >>>> +
> >>>> +       /*
> >>>> +        * Call dax_iomap_ops->actor_end() before iomap_ops->iomap_e=
nd() in
> >>>> +        * each iteration.
> >>>> +        */
> >>>> +       if (iter->iomap.length && ops->actor_end) {
> >>>> +               ret =3D ops->actor_end(iter->inode, iter->pos, iter-=
>len,
> >>>> +                                    iter->processed);
> >>>> +               if (ret < 0)
> >>>> +                       return ret;
> >>>> +       }
> >>>> +
> >>>> +       return iomap_iter(iter, &ops->iomap_ops);
> >>>
> >>> This reorganization looks needlessly noisy. Why not require the
> >>> iomap_end operation to perform the actor_end work. I.e. why can't
> >>> xfs_dax_write_iomap_actor_end() just be the passed in iomap_end? I am
> >>> not seeing where the ->iomap_end() result is ignored?
> >>>
> >>
> >> The V6 patch[1] was did in this way.
> >> [1]https://lore.kernel.org/linux-xfs/20210526005159.GF202144@locust/T/=
#m79a66a928da2d089e2458c1a97c0516dbfde2f7f
> >>
> >> But Darrick reminded me that ->iomap_end() will always take zero or
> >> positive 'written' because iomap_apply() handles this argument.
> >>
> >> ```
> >>          if (ops->iomap_end) {
> >>                  ret =3D ops->iomap_end(inode, pos, length,
> >>                                       written > 0 ? written : 0,
> >>                                       flags, &iomap);
> >>          }
> >> ```
> >>
> >> So, we cannot get actual return code from CoW in ->actor(), and as a
> >> result, we cannot handle the xfs end_cow correctly in ->iomap_end().
> >> That's where the result of CoW was ignored.
> >
> > Ah, thank you for the explanation.
> >
> > However, this still seems like too much code thrash just to get back
> > to the original value of iter->processed. I notice you are talking
> > about iomap_apply(), but that routine is now gone in Darrick's latest
> > iomap-for-next branch. Instead iomap_iter() does this:
> >
> >          if (iter->iomap.length && ops->iomap_end) {
> >                  ret =3D ops->iomap_end(iter->inode, iter->pos, iomap_l=
ength(iter),
> >                                  iter->processed > 0 ? iter->processed =
: 0,
>
> As you can see, here is the same logic as the old iomap_apply(): the
> negative iter->processed won't be passed into ->iomap_end().
>
> >                                  iter->flags, &iter->iomap);
> >                  if (ret < 0 && !iter->processed)
> >                          return ret;
> >          }
> >
> >
> > I notice that the @iomap argument to ->iomap_end() is reliably coming
> > from @iter. So you could do the following in your iomap_end()
> > callback:
> >
> >          struct iomap_iter *iter =3D container_of(iomap, typeof(*iter),=
 iomap);
> >          struct xfs_inode *ip =3D XFS_I(inode);
> >          ssize_t written =3D iter->processed;
>
> The written will be 0 or positive.  The original error code is ingnored.

Correct, but you can use container_of() to get back to the iter and
consider the raw untranslated value of iter->processed. As Christoph
mentioned this needs a comment explaining the layering violation, but
that's a cleaner change than the dax_iomap_ops approach.
