Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3297A326BD8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Feb 2021 06:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhB0FmN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Feb 2021 00:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhB0FmL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Feb 2021 00:42:11 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02BCC06174A;
        Fri, 26 Feb 2021 21:41:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v15so10615993wrx.4;
        Fri, 26 Feb 2021 21:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1RH7kOprlcYCkHIz9337og2jIDcCDQatwXLX3f0ckQ=;
        b=qSzafnsK33iUZyV7k2SyXkgfZxwaNqqx442mNFv/5kLws0kDnigmE90q63d1VQOBTH
         JPEga9SEq58hgI5GnTMMC4AjxzFvJl4SJH/9lp0xWJ7uNMi9BERRXokUBMeV0xwk24LU
         2l2AOAOW8mA2Q7+DDnPIApOgBVbfI6VS7zQyd+9pyuX9Vdd3UvsWlHVNtU+0nvFpp2kK
         tdbUOZ8AKnXREKAdVY1C5dzT3ijCJgRxRZ2aXIbl0v29bNv9Wn5wOZB7KzTjz6FPpQoo
         vlciKdXH2KUfhtTNjZh25E65TCHViUbMBJ4XH/cNeuXPfmZav9ZGJqrPcCR6HObuuYpV
         X+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1RH7kOprlcYCkHIz9337og2jIDcCDQatwXLX3f0ckQ=;
        b=JA2Zm0+n6sSDToZ5E6wDYT7lQmRtoVuFkSMLgFWL9FyVWYVTUuzfLdHgGeF0v3WauO
         8/vbmknCXf62Xw58a3xwqkp6lKaqleQRNLNT/IfQvAszUhSfnTCOWf/XUjxYE6NMLNoE
         0BSU20LkFrRVhFpIlAZ5+4eHwIS5t5jzLZ1jVVO/GiIT/d9YPb7DuQ1FDk/4pPxpJiqS
         d/K725a89dYc32zMj/yKAHVtKs7AGcrvzMjLcpah6NlkKouNpvtV31ldrlReaSYsJUsd
         B0XtzMMlgJsDvby4H9Yh2b2l7HSLLCWxJjhw/wu6Sg4s3yBY2UKdMZtv9XoXIkK/gTRH
         YjcQ==
X-Gm-Message-State: AOAM533v4pMqmrAfiAzCO964+H+GdbWQnk4ERQb2lRocM192EyTUgXEd
        Yvwf0gxVrDxLwbvCboDsHePd6VKByO/TZ4wBhAY=
X-Google-Smtp-Source: ABdhPJz4DaeIHyU9NFWTqNtqUY7RSg6mU7q9XcHyLsWkYyLn51TaLcx0MJ5TpNf8MSUsYBhW1a9Hup+qDkuyCrz+Q7U=
X-Received: by 2002:a5d:6b03:: with SMTP id v3mr6334029wrw.371.1614404489364;
 Fri, 26 Feb 2021 21:41:29 -0800 (PST)
MIME-Version: 1.0
References: <20210222102456.6692-1-lhenriques@suse.de> <20210224142307.7284-1-lhenriques@suse.de>
 <CAOQ4uxi3-+tOgHV_GUnWtJoQXbV5ZS9qDZsLsd9sJxX5Aftyew@mail.gmail.com> <6b896b29-6fc1-0586-ef31-f2f3298b56b0@gmail.com>
In-Reply-To: <6b896b29-6fc1-0586-ef31-f2f3298b56b0@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 27 Feb 2021 07:41:18 +0200
Message-ID: <CAOQ4uxgFCBNwRD7e1srwaVrZMGfOE_JXENL4Q2En52srdj2AYA@mail.gmail.com>
Subject: Re: [PATCH] copy_file_range.2: Kernel v5.12 updates
To:     "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
Cc:     Luis Henriques <lhenriques@suse.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Olga Kornievskaia <aglo@umich.edu>,
        Christoph Hellwig <hch@infradead.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Feb 27, 2021 at 12:19 AM Alejandro Colomar (man-pages)
<alx.manpages@gmail.com> wrote:
>
> Hello Amir, Luis,
>
> On 2/24/21 5:10 PM, Amir Goldstein wrote:
> > On Wed, Feb 24, 2021 at 4:22 PM Luis Henriques <lhenriques@suse.de> wrote:
> >>
> >> Update man-page with recent changes to this syscall.
> >>
> >> Signed-off-by: Luis Henriques <lhenriques@suse.de>
> >> ---
> >> Hi!
> >>
> >> Here's a suggestion for fixing the manpage for copy_file_range().  Note that
> >> I've assumed the fix will hit 5.12.
> >>
> >>   man2/copy_file_range.2 | 10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/man2/copy_file_range.2 b/man2/copy_file_range.2
> >> index 611a39b8026b..b0fd85e2631e 100644
> >> --- a/man2/copy_file_range.2
> >> +++ b/man2/copy_file_range.2
> >> @@ -169,6 +169,9 @@ Out of memory.
> >>   .B ENOSPC
> >>   There is not enough space on the target filesystem to complete the copy.
> >>   .TP
> >> +.B EOPNOTSUPP
>
> I'll add the kernel version here:
>
> .BR EOPNOTSUPP " (since Linux 5.12)"

Error could be returned prior to 5.3 and would be probably returned
by future stable kernels 5.3..5.12 too

>
> >> +The filesystem does not support this operation >> +.TP
> >>   .B EOVERFLOW
> >>   The requested source or destination range is too large to represent in the
> >>   specified data types.
> >> @@ -187,7 +190,7 @@ refers to an active swap file.
> >>   .B EXDEV
> >>   The files referred to by
> >>   .IR fd_in " and " fd_out
> >> -are not on the same mounted filesystem (pre Linux 5.3).
> >> +are not on the same mounted filesystem (pre Linux 5.3 and post Linux 5.12).
>
> I'm not sure that 'mounted' adds any value here.  Would you remove the
> word here?

See rename(2). 'mounted' in this context is explained there.
HOWEVER, it does not fit here.
copy_file_range() IS allowed between two mounts of the same filesystem instance.

To make things more complicated, it appears that cross mount clone is not
allowed via FICLONE/FICLONERANGE ioctl, so ioctl_ficlonerange(2) man page
also uses the 'mounted filesystem' terminology for EXDEV

As things stand now, because of the fallback to clone logic,
copy_file_range() provides a way for users to clone across different mounts
of the same filesystem instance, which they cannot do with the FICLONE ioctl.

Fun :)

BTW, I don't know if preventing cross mount clone was done intentionally,
but as I wrote in a comment in the code once:

        /*
         * FICLONE/FICLONERANGE ioctls enforce that src and dest files are on
         * the same mount. Practically, they only need to be on the same file
         * system.
         */

>
> It reads as if two separate devices with the same filesystem type would
> still give this error.
>
> Per the LWN.net article Amir shared, this is permitted ("When called
> from user space, copy_file_range() will only try to copy a file across
> filesystems if the two are of the same type").
>
> This behavior was slightly different before 5.3 AFAICR (was it?) ("until
> then, copy_file_range() refused to copy between files that were not
> located on the same filesystem.").  If that's the case, I'd specify the
> difference, or more probably split the error into two, one before 5.3,
> and one since 5.12.
>

True.

> >
> > I think you need to drop the (Linux range) altogether.
>
> I'll keep the range.  Users of 5.3..5.11 might be surprised if the
> filesystems are different and they don't get an error, I think.
>
> I reworded it to follow other pages conventions:
>
> .BR EXDEV " (before Linux 5.3; or since Linux 5.12)"
>
> which renders as:
>
>         EXDEV (before Linux 5.3; or since Linux 5.12)
>                The files referred to by fd_in and fd_out are not on
>                the same mounted filesystem.
>

drop 'mounted'

>
> > What's missing here is the NFS cross server copy use case.
> > Maybe:
> >
> > ...are not on the same mounted filesystem and the source and target filesystems
> > do not support cross-filesystem copy.
>
> Yes.
>
> Again, this wasn't true before 5.3, right?
>

Right.
Actually, v5.3 provides the vfs capabilities for filesystems to support
cross fs copy. I am not sure if NFS already implements cross fs copy in
v5.3 and not sure about cifs. Need to get input from nfs/cis developers
or dig in the release notes for server-side copy.

> >
> > You may refer the reader to VERSIONS section where it will say which
> > filesystems support cross-fs copy as of kernel version XXX (i.e. cifs and nfs).
> >
> >>   .SH VERSIONS
> >>   The
> >>   .BR copy_file_range ()
> >> @@ -202,6 +205,11 @@ Applications should target the behaviour and requirements of 5.3 kernels.
> >>   .PP
> >>   First support for cross-filesystem copies was introduced in Linux 5.3.
> >>   Older kernels will return -EXDEV when cross-filesystem copies are attempted.
> >> +.PP
> >> +After Linux 5.12, support for copies between different filesystems was dropped.
> >> +However, individual filesystems may still provide
> >> +.BR copy_file_range ()
> >> +implementations that allow copies across different devices.
> >
> > Again, this is not likely to stay uptodate for very long.
> > The stable kernels are expected to apply your patch (because it fixes
> > a regression)
> > so this should be phrased differently.
> > If it were me, I would provide all the details of the situation to
> > Michael and ask him
> > to write the best description for this section.
>
> I'll look into more detail at this part in a later review.
>
>
> On 2/26/21 11:34 AM, Amir Goldstein wrote:
>  > Is this detailed enough? ;-)
>  >
>  > https://lwn.net/Articles/846403/
>
> Yes, it is!
>

Thanks to LWN :)

Thanks,
Amir.
