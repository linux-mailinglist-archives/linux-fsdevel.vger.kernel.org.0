Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBE2CDFDBE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2019 08:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730930AbfJVGkZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Oct 2019 02:40:25 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:40572 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfJVGkZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Oct 2019 02:40:25 -0400
Received: by mail-yb1-f193.google.com with SMTP id s7so4812081ybq.7;
        Mon, 21 Oct 2019 23:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6DBniHEARPZeGwGYnc355+KIj9ZRD5tMQT/2Xpydu0=;
        b=aHgaLAf71slYYTx/hYGwS/WXowCRmtq5KqrInt9pJprA729NHL7hdaMjj2upKbcqXD
         2tmIp02JKNgzUef0f+65fMZvh8LkTNv1Lcqsc/tihzeFfPEJA7CyysFbz9IdS8Y5N3QE
         jfaQGVdJ+t5lbLdDRWDppQ6kdRJFl2zKaNL56EDSVNKiuaL4QSbAnz/CH1FVjYYSktX3
         whWxbRZMKtBBOCQE6Q+83QCZ7MJZvaLU0Ya7HRR6P1Y58ejxL1zkykuNrJpD1RxKrJMy
         OMN+ajpeZn/4fJP38HNOieIHDAggXU6qotp4fBEOjLYKHQ2aLpGB8xVc5N05/lAFmM9c
         MjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6DBniHEARPZeGwGYnc355+KIj9ZRD5tMQT/2Xpydu0=;
        b=AbzfHTOfjpgszNMcydvGqEnGn+VU4XDCFzIz0yfiLkbhZMFDrI7X919CWF/9YVRh+q
         X9jfK1eyQthLb2fWwme4lZtTD+Fq6nylM6bXEyHraxxD11BDWq2YAtFEUN/FrwAtNwCL
         Dfhsrt7y3UZw0MMLodX74b00VVaMZ8Uwj/nSShE0zvt37UFfnLZ5dJg68iyHp/SUUDjS
         xMYhJ4dz4xOTSO18Ngvi0nLh04+SUhh3a96lgcnD+7/Ljd6NQAPtExFcdwAldyTZ/Je6
         tt7rjgah5Q5dae24h33NR2OmiJtocjbUZCFN1UZ+PTmJwY9HNbe3JRCJAQZXAj1xUmv3
         dEFQ==
X-Gm-Message-State: APjAAAWiXi0OT6pMQsQtDbEITaW4xTfYZlSIl6d8hlwQYJ9KSSYZOZmo
        WuKHMx/edMrSOg5piX9wmwIfyVlWC7jAoMuDgHxcKd8q
X-Google-Smtp-Source: APXvYqyxF3fk1aWupBySMytZi5EPMpogXQvn80/lZjXqy9f6uhfXXuxv9tRdVFN+om3FBVrvmluHcVP+PnotafsSNyk=
X-Received: by 2002:a25:6607:: with SMTP id a7mr1313993ybc.144.1571726423693;
 Mon, 21 Oct 2019 23:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571164762.git.osandov@fb.com> <c7e8f93596fee7bb818dc0edf29f484036be1abb.1571164851.git.osandov@fb.com>
 <CAOQ4uxh_pZSiMmD=46Mc3o0GE+svXuoC155P_9FGJXdsE4cweg@mail.gmail.com> <20191021185356.GB81648@vader>
In-Reply-To: <20191021185356.GB81648@vader>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 22 Oct 2019 09:40:12 +0300
Message-ID: <CAOQ4uxgm6MWwCDO5stUwOKKSq7Ot4-Sc96F1Evc6ra5qBE+-wA@mail.gmail.com>
Subject: Re: [PATCH man-pages] Document encoded I/O
To:     Omar Sandoval <osandov@osandov.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Btrfs <linux-btrfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Linux API <linux-api@vger.kernel.org>, kernel-team@fb.com,
        Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 21, 2019 at 9:54 PM Omar Sandoval <osandov@osandov.com> wrote:
>
> On Mon, Oct 21, 2019 at 09:18:13AM +0300, Amir Goldstein wrote:
> > CC: Ted
> >
> > What ever happened to read/write ext4 encrypted data API?
> > https://marc.info/?l=linux-ext4&m=145030599010416&w=2
> >
> > Can we learn anything from the ext4 experience to improve
> > the new proposed API?
>
> I wasn't aware of these patches, thanks for pointing them out. Ted, do
> you have any thoughts about making this API work for fscrypt?
>
> > On Wed, Oct 16, 2019 at 12:29 AM Omar Sandoval <osandov@osandov.com> wrote:
> > >
> > > From: Omar Sandoval <osandov@fb.com>
> > >
> > > This adds a new page, rwf_encoded(7), providing an overview of encoded
> > > I/O and updates fcntl(2), open(2), and preadv2(2)/pwritev2(2) to
> > > reference it.
> > >
> > > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > > ---
> > >  man2/fcntl.2       |  10 +-
> > >  man2/open.2        |  13 ++
> > >  man2/readv.2       |  46 +++++++
> > >  man7/rwf_encoded.7 | 297 +++++++++++++++++++++++++++++++++++++++++++++
> > >  4 files changed, 365 insertions(+), 1 deletion(-)
> > >  create mode 100644 man7/rwf_encoded.7
> > >
> > > diff --git a/man2/fcntl.2 b/man2/fcntl.2
> > > index fce4f4c2b..76fe9cc6f 100644
> > > --- a/man2/fcntl.2
> > > +++ b/man2/fcntl.2
> > > @@ -222,8 +222,9 @@ On Linux, this command can change only the
> > >  .BR O_ASYNC ,
> > >  .BR O_DIRECT ,
> > >  .BR O_NOATIME ,
> > > +.BR O_NONBLOCK ,
> > >  and
> > > -.B O_NONBLOCK
> > > +.B O_ENCODED
> > >  flags.
> > >  It is not possible to change the
> > >  .BR O_DSYNC
> > > @@ -1803,6 +1804,13 @@ Attempted to clear the
> > >  flag on a file that has the append-only attribute set.
> > >  .TP
> > >  .B EPERM
> > > +Attempted to set the
> > > +.B O_ENCODED
> > > +flag and the calling process did not have the
> > > +.B CAP_SYS_ADMIN
> > > +capability.
> > > +.TP
> > > +.B EPERM
> > >  .I cmd
> > >  was
> > >  .BR F_ADD_SEALS ,
> > > diff --git a/man2/open.2 b/man2/open.2
> > > index b0f485b41..cdd3c549c 100644
> > > --- a/man2/open.2
> > > +++ b/man2/open.2
> > > @@ -421,6 +421,14 @@ was followed by a call to
> > >  .BR fdatasync (2)).
> > >  .IR "See NOTES below" .
> > >  .TP
> > > +.B O_ENCODED
> > > +Open the file with encoded I/O permissions;
> >
> > 1. I find the name of the flag confusing.
> > Yes, most people don't read documentation so carefully (or at all)
> > so they will assume O_ENCODED will affect read/write or that it
> > relates to RWF_ENCODED in a similar way that O_SYNC relates
> > to RWF_SYNC (i.e. logical OR and not logical AND).
> >
> > I am not good at naming and to prove it I will propose:
> > O_PROMISCUOUS, O_MAINTENANCE, O_ALLOW_ENCODED
>
> Agreed, the name is misleading. I can't think of anything better than
> O_ALLOW_ENCODED, so I'll go with that unless someone comes up with
> something better :)
>
> > 2. While I see no harm in adding O_ flag to open(2) for this
> > use case, I also don't see a major benefit in adding it.
> > What if we only allowed setting the flag via fcntl(2) which returns
> > an error on old kernels?
> > Since unlike most O_ flags, O_ENCODED does NOT affect file
> > i/o without additional opt-in flags, it is not standard anyway and
> > therefore I find that setting it only via fcntl(2) is less error prone.
>
> If I make this fcntl-only, then it probably shouldn't be through
> F_GETFL/F_SETFL (it'd be pretty awkward for an O_ flag to not be valid
> for open(), and also awkward to mix some non-O_ flag with O_ flags for
> F_GETFL/F_SETFL). So that leaves a couple of options:
>
> 1. Get/set it with F_GETFD/F_SETFD, which is currently only used for
>    FD_CLOEXEC. That also silently ignores unknown flags, but as with the
>    O_ flag option, I don't think that's a big deal for FD_ALLOW_ENCODED.
> 2. Add a new fcntl command (F_GETFD2/F_SETFD2?). This seems like
>    overkill to me.
>
> However, both of these options are annoying to implement. Ideally, we
> wouldn't have to add another flags field to struct file. But, to reuse
> f_flags, we'd need to make sure that FD_ALLOW_ENCODED doesn't collide
> with other O_ flags, and we'd probably want to hide it from F_GETFL. At
> that point, it might as well be an O_ flag.
>
> It seems to me that it's more trouble than it's worth to make this not
> an O_ flag, but please let me know if you see a nice way to do so.
>

No, I see why you choose to add the flag to open(2).
I have no objection.

I once had a crazy thought how to add new open flags
in a non racy manner without adding a new syscall,
but as you wrote, this is not relevant for O_ALLOW_ENCODED.

Something like:

/*
 * Old kernels silently ignore unsupported open flags.
 * New kernels that gets __O_CHECK_NEWFLAGS do
 * the proper checking for unsupported flags AND set the
 * flag __O_HAVE_NEWFLAGS.
 */
#define O_FLAG1 __O_CHECK_NEWFLAGS|__O_FLAG1
#define O_HAVE_FLAG1 __O_HAVE_NEWFLAGS|__O_FLAG1

fd = open(path, O_FLAG1);
if (fd < 0)
    return -errno;
flags = fcntl(fd, F_GETFL, 0);
if (flags < 0)
    return flags;
if ((flags & O_HAVE_FLAG1) != O_HAVE_FLAG1) {
    close(fd);
    return -EINVAL;
}

Not pretty, but hidden inside libc, end-users won't need to
be aware of this.

Cheers,
Amir.
