Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAE02FB19E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2019 14:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727587AbfKMNmp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Nov 2019 08:42:45 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54461 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbfKMNmp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Nov 2019 08:42:45 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MIxBc-1iBhLH3Iba-00KMQj; Wed, 13 Nov 2019 14:42:41 +0100
Received: by mail-qt1-f175.google.com with SMTP id y10so2610389qto.3;
        Wed, 13 Nov 2019 05:42:41 -0800 (PST)
X-Gm-Message-State: APjAAAWQfW+/OR1mX8XKbygHgLaXVnsWKIBBG3NlQf9qUO9Lq2DX4lJI
        NbzfWXaQV06IOxssWHC5f9kWzpMYvIck6i68t4Y=
X-Google-Smtp-Source: APXvYqwOZDETUFXSsZp6Un2T3zj3dpR0fAaTW5TdtNU31TMtfaB+p1In9+F0IJtERqbLq/GvCvC4PG3JRR93oU8tr6M=
X-Received: by 2002:ac8:18eb:: with SMTP id o40mr2661414qtk.304.1573652560627;
 Wed, 13 Nov 2019 05:42:40 -0800 (PST)
MIME-Version: 1.0
References: <20191112120910.1977003-1-arnd@arndb.de> <20191112120910.1977003-2-arnd@arndb.de>
 <20191112141600.GB10922@lst.de> <20191113050628.GS6219@magnolia>
In-Reply-To: <20191113050628.GS6219@magnolia>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Nov 2019 14:42:24 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3c3kCXAPU-sJQvAvDQdAwVnQRiterdmqXufWkFdSSZ+g@mail.gmail.com>
Message-ID: <CAK8P3a3c3kCXAPU-sJQvAvDQdAwVnQRiterdmqXufWkFdSSZ+g@mail.gmail.com>
Subject: Re: [RFC 1/5] xfs: [variant A] avoid time_t in user api
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:tQcCN+uPu60Chpg0Wv8TNBpWv602TgBstegrTL+9Ccvv1FneFuM
 VMBLc3R0ZqxjrhfQp8Y4aw0bivR54GAWXJpr5VLK2dOXyyS1PqTf6rNARXIRgHqMAFMR+DX
 ebO7vr7i/bgqEJ0lMQaJnOAoZbJ8MvoSrCDwJf2vvNl7gYkrlUr1CBsHpmYrHYRisNZ2dIF
 q8blwWzVXP8LBe+o2+Sdw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:97AvqYcQEtc=:Xx8tNEMfXJRcPmyab+spi0
 ovcMw6zlKD7c371/iLXmnG/20MKzx44mPr9vC5KO+8IKwkZxHuhBeFAS3irtWfr9HnpKpxOsv
 5HyA/urWsjz8GA8CukWaMDQeZRbM9lEzb7E9y1VxCoP1nkriBB5wjcfkJrS8pWvqx6GYBrtAR
 JmhGicMY7R+PkmZbrAuVH+AUf7TYn7C82gFGcD0f0mgtKQBcbfQW3pZ8+RCy6CV6uyac7sRSI
 gxOfDwB1X7YGLEJ4G1jcsE8LSdijSg5Ik6PHfHIbfAhxwpk+IAf3vnL0b324RSbadviKn7kWi
 5OSp476EuI7RuJwSOA+SgSQLHPxBQVJrDv6oRvL44LwGIGl8cSaw2wjYAN7dsw0TDC0+nQdNo
 kqb5evu8vIxoRu31Stf9SiNob5g3RFLCbdnCxjBzl4jNGe6jgMKNY3v8qEIhirvIil/6pXHRf
 1ub7bO3ZSJftaCFhDW3haAJlwBPsfaU/NU8T5c1dgTQVTdK71oXHWIlQeu0OSkKLStw4DnRzt
 n14HcnUbyBsuIlYa24y97DOrnMAuW7rkrXyf8B/rniubcAZX3L3DwsayqhJSP2v4o8mqux4wo
 tkEu/sJXK85eqjT8jD3uXlcZhce+Fbm7jco8JE/nbo+SbIgmEbnLlzZoBV+ZFG60oSPsKNirs
 MMNcr2SGMthTUB5aWW4zcudEfTQg4pw/9NZ5/iBRYIi6KbF5AxGmLbTVQHQ0Oo5R4ETXFZkAa
 gEyogRlia0de6q5++Hl+On+zvOeWQCRULeyos3UVgO6lnkrWcVZ+C8Ikv1B40uYY0xZCjtwwk
 d4ZwBhhExqBn8neB8ERUbLSuLB4dc3J0IFpmZPoTHsa82q5uUTMCwBBoivmrqdeMee978Cu/U
 hnhRlwhhDYl9IJCFVT3w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 13, 2019 at 6:08 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> On Tue, Nov 12, 2019 at 03:16:00PM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 12, 2019 at 01:09:06PM +0100, Arnd Bergmann wrote:
> > > However, as long as two observations are true, a much simpler solution
> > > can be used:
> > >
> > > 1. xfsprogs is the only user space project that has a copy of this header
> >
> > We can't guarantee that.
> >
> > > 2. xfsprogs already has a replacement for all three affected ioctl commands,
> > >    based on the xfs_bulkstat structure to pass 64-bit timestamps
> > >    regardless of the architecture
> >
> > XFS_IOC_BULKSTAT replaces XFS_IOC_FSBULKSTAT directly, and can replace
> > XFS_IOC_FSBULKSTAT_SINGLE indirectly, so that is easy.  Most users
> > actually use the new one now through libfrog, although I found a user
> > of the direct ioctl in the xfs_io tool, which could easily be fixed as
> > well.
>
> Agreed, XFS_IOC_BULKSTAT is the replacement for the two FSBULKSTAT
> variants.  The only question in my mind for the old ioctls is whether we
> should return EOVERFLOW if the timestamp would overflow?  Or just
> truncate the results?

I think neither of these would be particularly helpful, the result is that users
see no change in behavior until it's actually too late and the timestamps have
overrun.

If we take variant A and just fix the ABI to 32-bit time_t, it is important
that all user space stop using these ioctls and moves to the v5 interfaces
instead (including SWAPEXT I guess).

Something along the lines of this change would work:

diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d50135760622..87318486c96e 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -830,6 +830,23 @@ xfs_fsinumbers_fmt(
        return xfs_ibulk_advance(breq, sizeof(struct xfs_inogrp));
 }

+/* disallow y2038-unsafe ioctls with CONFIG_COMPAT_32BIT_TIME=n */
+static bool xfs_have_compat_bstat_time32(unsigned int cmd)
+{
+       if (IS_ENABLED(CONFIG_COMPAT_32BIT_TIME))
+               return true;
+
+       if (IS_ENABLED(CONFIG_64BIT) && !in_compat_syscall())
+               return true;
+
+       if (cmd == XFS_IOC_FSBULKSTAT_SINGLE ||
+           cmd == XFS_IOC_FSBULKSTAT ||
+           cmd == XFS_IOC_SWAPEXT)
+               return false;
+
+       return true;
+}
+
 STATIC int
 xfs_ioc_fsbulkstat(
        xfs_mount_t             *mp,
@@ -850,6 +867,9 @@ xfs_ioc_fsbulkstat(
        if (!capable(CAP_SYS_ADMIN))
                return -EPERM;

+       if (!xfs_have_compat_bstat_time32())
+               return -EINVAL;
+
        if (XFS_FORCED_SHUTDOWN(mp))
                return -EIO;

@@ -2051,6 +2071,11 @@ xfs_ioc_swapext(
        struct fd       f, tmp;
        int             error = 0;

+       if (xfs_have_compat_bstat_time32(XFS_IOC_SWAPEXT)) {
+               error = -EINVAL
+               got out;
+       }
+
        /* Pull information for the target fd */
        f = fdget((int)sxp->sx_fdtarget);
        if (!f.file) {

This way, at least users that intentionally turn off CONFIG_COMPAT_32BIT_TIME
run into the broken application right away, which forces them to upgrade or fix
the code to use the v5 ioctl.

> > > Based on those assumptions, changing xfs_bstime to use __kernel_long_t
> > > instead of time_t in both the kernel and in xfsprogs preserves the current
> > > ABI for any libc definition of time_t and solves the problem of passing
> > > 64-bit timestamps to 32-bit user space.
> >
> > As said above their are not entirely true, but I still think this patch
> > is the right thing to do, if only to get the time_t out of the ABI..
> >
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Seconded,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks!

     Arnd
