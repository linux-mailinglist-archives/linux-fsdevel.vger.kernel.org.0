Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A631257B32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 16:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHaOWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 10:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgHaOVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:21:50 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECEDC061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:21:49 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r13so2041165uah.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 07:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SzR2oNRwYCvP+9DL3XtTBjoyzVtXN0GMk3EfT65aEnI=;
        b=f49bgNjOYZvpA90D7L71n2Q6rN73V2PtfexNudAJ3b3FWO6zCGl4WXf3dTcpMS+6WF
         vHrKeKikIhJwexY+d0zDIidLtM8tgw0XseM06Qlh55FESWULrMFL5vysxuID+xO9T4CB
         Q1nq9HNnTnbqnKr1lzCt/bOM95WcmfK9ZJ0tY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SzR2oNRwYCvP+9DL3XtTBjoyzVtXN0GMk3EfT65aEnI=;
        b=FmUCek5wYB8CA+6lMzFYQA24EiNDXj7GIL2QHtVCScW+o4aB0N5G1S5QuoQV5Lh58E
         dtWPfWRlSSlCTPZfeoccb0I/gE3A1gUgES0h+iqunCqCQh7myU/Jd/q2NbxEac+KTM0e
         6beTJe6BLacYuPT9bF4PiAdrJmHWSrVJVJCkOvFUUSuIPT8aGOX7uBqULO1HhEuUVHGo
         b7ZhgcNPz/6zo4+u/D9yUbaUujGLSNoePgUJNALVl/UsHzpTReRBmzOVMDulJX4dVsbm
         /GV0Pq2bASRo49b6TsL/Et7Ak/l2mj69QityxV98AyuML6Z3ZR3XZRypRbxKkxKITqHk
         crNA==
X-Gm-Message-State: AOAM530f2w70sAk24aLt4/M6jQetTvbDld/b2K7C6+Nc7sDqwjtwfaMj
        8BSmhKFl/OyvORoNaLzrCaPoKGpJOWFmTOqDWVvK3g==
X-Google-Smtp-Source: ABdhPJzbfswt4jWwD7XMPxikVbKVeurhrDKX9Aihke9vQFVNS1+uaIXUeEGPLrMbqnkNDgqLUIDwqx6HNrh6iaYlEVY=
X-Received: by 2002:ab0:32d:: with SMTP id 42mr1044446uat.107.1598883708242;
 Mon, 31 Aug 2020 07:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200829161358.GP1236603@ZenIV.linux.org.uk> <CAJfpegu2R21CF9PEoj2Cw6x01xmJ+qsff5QTcOcY4G5KEY3R0w@mail.gmail.com>
 <20200829180448.GQ1236603@ZenIV.linux.org.uk> <CAJfpegsn-BKVkMv4pQHG7tER31m5RSXrJyhDZ-Uzst1CMBEbEw@mail.gmail.com>
 <20200829192522.GS1236603@ZenIV.linux.org.uk> <CAJfpegt7a_YHd0iBjb=8hST973dQQ9czHUSNvnh-9LR_fqktTA@mail.gmail.com>
 <20200830191016.GZ14765@casper.infradead.org> <CAJfpegv9+o8QjQmg8EpMCm09tPy4WX1gbJiT=s15Lz8r3HQXJQ@mail.gmail.com>
 <20200831113705.GA14765@casper.infradead.org> <CAJfpegvqvns+PULwyaN2oaZAJZKA_SgKxqgpP=nvab2tuyX4NA@mail.gmail.com>
 <20200831132339.GD14765@casper.infradead.org>
In-Reply-To: <20200831132339.GD14765@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 31 Aug 2020 16:21:36 +0200
Message-ID: <CAJfpegvRgvU-RYf0i6ChC_v7aHonimLKe-5MuUa+JXqUHiPEpg@mail.gmail.com>
Subject: Re: xattr names for unprivileged stacking?
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dave Chinner <david@fromorbit.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Greg Kurz <groug@kaod.org>, linux-fsdevel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 3:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Aug 31, 2020 at 01:51:20PM +0200, Miklos Szeredi wrote:
> > On Mon, Aug 31, 2020 at 1:37 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > As I said to Dave, you and I have a strong difference of opinion here.
> > > I think that what you are proposing is madness.  You're making it too
> > > flexible which comes with too much opportunity for abuse.
> >
> > Such as?
>
> One proposal I saw earlier in this thread was to do something like
> $ runalt /path/to/file ls
> which would open_alt() /path/to/file, fchdir to it and run ls inside it.
> That's just crazy.

Indeed, I have said numerous times that fchdir() on those objects must
not happen.  But there's no law (that I know of) that says all
hierarchies of files must allow fchdir().

> > >  I just want
> > > to see alternate data streams for the same filename in order to support
> > > existing use cases.  You seem to be able to want to create an entire
> > > new world inside a file, and that's just too confusing.
> >
> > To whom?  I'm sure users of ancient systems with a flat directory
> > found directory trees very confusing.  Yet it turned out that the
> > hierarchical system beat the heck out of the flat one.
>
> Which doesn't mean that multiple semi-hidden hierarchies are going to
> be better than one visible hierarchy.

Look how metadata interfaces for inodes are already fragmented:

 - stat (zillions of versions due to field sizes)
 - statx (hopefully good for some time)
 - getxattr
 - FS_IOC_GETFLAGS
 - FS_IOC_FSGETXATTR (nothing to do with the "other" xattr)
 - FS_IOC_FIEMAP
 - all the filesystem specific stuff (encryption, compression, whatever)

And now you are proposing to add yet another interface specific to ADS.

What about a generic interface instead for most future use cases as
well as possibly duplicating some of the existing ones?  This would
simplify userspace tooling and allow for a single generic internal
interface as well.

Thanks,
Miklos
