Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF33F2EB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Aug 2021 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbhHTPTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Aug 2021 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240964AbhHTPTk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Aug 2021 11:19:40 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38360C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 08:18:56 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so2163007pjb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Aug 2021 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=e7Os9VAnizBXv51HC/2jWtdqVC6IT3MX2PEly7Hzllc=;
        b=M+ibRtOTQAZRmC0FnL3AMilGRh2mUgMJmWUfg9JNOtAKXFs9lFLPXucpaO7ELUpNDb
         EGbzGydfkHCtIjzQLeNz+1/fIOA2rFhRJv3yC4ZhYvpISJH4iNfkhazi5Hz/Nq0fpYXO
         QpGdn8L+8PdTFb0E+p78qZDHRXkUnXo7JNSYlGQecnF0IhE5VtdC/Y+7Y9yUsL+y7PV3
         5x4ObvPPy0AxrVohJG1gL8vPnbME69k1gCKAA1GyMrEqgR+PWW/PMthly7voCniXVW59
         FcwvvH0AWzl2X+1XFpdijT2XoPDvNcAXBc2pyggbrImBdT+vil40sbH7g0dNEEtf0bPA
         hjMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=e7Os9VAnizBXv51HC/2jWtdqVC6IT3MX2PEly7Hzllc=;
        b=V1d3NL2skTpdsddRtVFqLFe3kyFwdcwJBp/V3Dd1FOJhzfO2DU58GnHXmh3aesZBha
         FFd3xDIBMP8WBMe8DOVKREQ+3mycOpM6NTIfj5q6ym/EeRdDoCTMRfzeFmcRUkdafei+
         jX78/QrXJifRowrROJnEm3uYGOIlTDfJAEkc/9UPZlHA0g7RwHgeRWUgYkZpiOz/NHlr
         OkBKiIyB49p+cu61dtPSgXcPkIxKhvhmFaMYogiGy371fUWiiuSDCOx65OEF5N0hg5TO
         kqY9LT1uqmErzMXjeCivD5jInZHtlC6HUSzM87jicQb3MIZUHPNOUV1bhaHDqyeO8JIT
         rzsg==
X-Gm-Message-State: AOAM532ZBBviIBL2qv2Q7pu3pCZxNivf6wkDQkzzmwifJ6tORNqiPzwS
        w1jEMD38GDQUQkV50gppUlI25Mu2Un8Uk+RCdUBayk6lMsAgLQ==
X-Google-Smtp-Source: ABdhPJzh0Gic3915Mh1iFhrG9Et6Tc2pawPckB/akGEtXtIixYmIi3AnAExi5rU0t9vJgG3HUdy+9gqyxaTkb99WGQ0=
X-Received: by 2002:a17:90a:708c:: with SMTP id g12mr5224172pjk.13.1629472735668;
 Fri, 20 Aug 2021 08:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210816060359.1442450-1-ruansy.fnst@fujitsu.com>
 <20210816060359.1442450-8-ruansy.fnst@fujitsu.com> <CAPcyv4jbi=p=SjFYZcHnEAu+KY821pW_k_yA5u6hya4jEfrTUg@mail.gmail.com>
 <c7e68dc8-5a43-f727-c262-58dcf244c711@fujitsu.com>
In-Reply-To: <c7e68dc8-5a43-f727-c262-58dcf244c711@fujitsu.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 20 Aug 2021 08:18:44 -0700
Message-ID: <CAPcyv4jM86gy-T5EEZf6M2m44v4MiGqYDhxisX59M5QJii6DVg@mail.gmail.com>
Subject: Re: [PATCH v7 7/8] fsdax: Introduce dax_iomap_ops for end of reflink
To:     "ruansy.fnst" <ruansy.fnst@fujitsu.com>
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

On Thu, Aug 19, 2021 at 11:13 PM ruansy.fnst <ruansy.fnst@fujitsu.com> wrot=
e:
>
>
>
> On 2021/8/20 =E4=B8=8A=E5=8D=8811:01, Dan Williams wrote:
> > On Sun, Aug 15, 2021 at 11:05 PM Shiyang Ruan <ruansy.fnst@fujitsu.com>=
 wrote:
> >>
> >> After writing data, reflink requires end operations to remap those new
> >> allocated extents.  The current ->iomap_end() ignores the error code
> >> returned from ->actor(), so we introduce this dax_iomap_ops and change
> >> the dax_iomap_*() interfaces to do this job.
> >>
> >> - the dax_iomap_ops contains the original struct iomap_ops and fsdax
> >>      specific ->actor_end(), which is for the end operations of reflin=
k
> >> - also introduce dax specific zero_range, truncate_page
> >> - create new dax_iomap_ops for ext2 and ext4
> >>
> >> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> >> ---
> >>   fs/dax.c               | 68 +++++++++++++++++++++++++++++++++++++---=
--
> >>   fs/ext2/ext2.h         |  3 ++
> >>   fs/ext2/file.c         |  6 ++--
> >>   fs/ext2/inode.c        | 11 +++++--
> >>   fs/ext4/ext4.h         |  3 ++
> >>   fs/ext4/file.c         |  6 ++--
> >>   fs/ext4/inode.c        | 13 ++++++--
> >>   fs/iomap/buffered-io.c |  3 +-
> >>   fs/xfs/xfs_bmap_util.c |  3 +-
> >>   fs/xfs/xfs_file.c      |  8 ++---
> >>   fs/xfs/xfs_iomap.c     | 36 +++++++++++++++++++++-
> >>   fs/xfs/xfs_iomap.h     | 33 ++++++++++++++++++++
> >>   fs/xfs/xfs_iops.c      |  7 ++---
> >>   fs/xfs/xfs_reflink.c   |  3 +-
> >>   include/linux/dax.h    | 21 ++++++++++---
> >>   include/linux/iomap.h  |  1 +
> >>   16 files changed, 189 insertions(+), 36 deletions(-)
> >>
> >> diff --git a/fs/dax.c b/fs/dax.c
> >> index 74dd918cff1f..0e0536765a7e 100644
> >> --- a/fs/dax.c
> >> +++ b/fs/dax.c
> >> @@ -1348,11 +1348,30 @@ static loff_t dax_iomap_iter(const struct ioma=
p_iter *iomi,
> >>          return done ? done : ret;
> >>   }
> >>
> >> +static inline int
> >> +__dax_iomap_iter(struct iomap_iter *iter, const struct dax_iomap_ops =
*ops)
> >> +{
> >> +       int ret;
> >> +
> >> +       /*
> >> +        * Call dax_iomap_ops->actor_end() before iomap_ops->iomap_end=
() in
> >> +        * each iteration.
> >> +        */
> >> +       if (iter->iomap.length && ops->actor_end) {
> >> +               ret =3D ops->actor_end(iter->inode, iter->pos, iter->l=
en,
> >> +                                    iter->processed);
> >> +               if (ret < 0)
> >> +                       return ret;
> >> +       }
> >> +
> >> +       return iomap_iter(iter, &ops->iomap_ops);
> >
> > This reorganization looks needlessly noisy. Why not require the
> > iomap_end operation to perform the actor_end work. I.e. why can't
> > xfs_dax_write_iomap_actor_end() just be the passed in iomap_end? I am
> > not seeing where the ->iomap_end() result is ignored?
> >
>
> The V6 patch[1] was did in this way.
> [1]https://lore.kernel.org/linux-xfs/20210526005159.GF202144@locust/T/#m7=
9a66a928da2d089e2458c1a97c0516dbfde2f7f
>
> But Darrick reminded me that ->iomap_end() will always take zero or
> positive 'written' because iomap_apply() handles this argument.
>
> ```
>         if (ops->iomap_end) {
>                 ret =3D ops->iomap_end(inode, pos, length,
>                                      written > 0 ? written : 0,
>                                      flags, &iomap);
>         }
> ```
>
> So, we cannot get actual return code from CoW in ->actor(), and as a
> result, we cannot handle the xfs end_cow correctly in ->iomap_end().
> That's where the result of CoW was ignored.

Ah, thank you for the explanation.

However, this still seems like too much code thrash just to get back
to the original value of iter->processed. I notice you are talking
about iomap_apply(), but that routine is now gone in Darrick's latest
iomap-for-next branch. Instead iomap_iter() does this:

        if (iter->iomap.length && ops->iomap_end) {
                ret =3D ops->iomap_end(iter->inode, iter->pos, iomap_length=
(iter),
                                iter->processed > 0 ? iter->processed : 0,
                                iter->flags, &iter->iomap);
                if (ret < 0 && !iter->processed)
                        return ret;
        }


I notice that the @iomap argument to ->iomap_end() is reliably coming
from @iter. So you could do the following in your iomap_end()
callback:

        struct iomap_iter *iter =3D container_of(iomap, typeof(*iter), ioma=
p);
        struct xfs_inode *ip =3D XFS_I(inode);
        ssize_t written =3D iter->processed;
        bool cow =3D xfs_is_cow_inode(ip);

        if (cow) {
                if (written <=3D 0)
                        xfs_reflink_cancel_cow_range(ip, pos, length, true)
        }
