Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDAF3135C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 15:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhBHOyS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 09:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbhBHOxi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 09:53:38 -0500
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBDAC061793
        for <linux-fsdevel@vger.kernel.org>; Mon,  8 Feb 2021 06:52:38 -0800 (PST)
Received: by mail-vk1-xa30.google.com with SMTP id u22so3188996vke.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Feb 2021 06:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y8cQCEgdPFE8xw1N0t+r/wceVgSKQwGQt1gshTBTA/w=;
        b=alpVJbdMsp+cA4m1fRF7oc91ToOAMiUG3qmsFJvHLTgLEDVe2YKlyNWZjuXEm0+9B5
         tI+v40mJamGojR0eSN1f1NT9DRZGVussJ5bnWO5uayHegaNhE4tZyvQWv5WpRvKBeRnm
         uQQzhETRO/OBzSmXkCgmv1QDy3nprRgWuhNjY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y8cQCEgdPFE8xw1N0t+r/wceVgSKQwGQt1gshTBTA/w=;
        b=Jddp2GQCBIFy/kg8xtT9Na9Gra/QSPM6hbL9GkzftjFZynu0ioazP3LsfWzWk7ZyVa
         PL8ZWWLsBsUHYLLazo0ydayAgLVJyC90MN8rl69UgnGcGQwOo38cfO8yf6uixZLMTdPs
         1U9NWBEp7TWI+2m2WotKjYkt0d73sya72rAX/mKWuVZPD9BRnCTNsNJETG2iBhIoyuLx
         Z745INNiVl7JMY2ykpdyrVeDTjpsIVldTtLxHciVXEFfxXUunFFwulKB5ss9TmyILZyy
         yEzgs0f/ecpIH1kuVbsfEU8KZZbAu1dN+x3BfDnsvB2NvG35Nx25hgmcUVQgY/N3tQrD
         PDhg==
X-Gm-Message-State: AOAM533mdvlN1XZgqLazqdg/JwTErjvn8joesCSlZMAUNp3x75uD3fQW
        gGAExV5Fh+pimvPE01eawxz2jveSEkX8aR2m6vjJtA==
X-Google-Smtp-Source: ABdhPJyQPCy2cA69mGHBT2lFImqi32A7W4sz4zMmBMBHG0ztyW3F8v3uSO92T8TdzGXthZXdEfXnGob2ymMrfjahfQU=
X-Received: by 2002:a1f:1d0e:: with SMTP id d14mr10273523vkd.14.1612795957900;
 Mon, 08 Feb 2021 06:52:37 -0800 (PST)
MIME-Version: 1.0
References: <20210203130501.GY308988@casper.infradead.org> <CAJfpegs3YWybmH7iKDLQ-KwmGieS1faO1uSZ-ADB0UFYOFPEnQ@mail.gmail.com>
 <20210203135827.GZ308988@casper.infradead.org> <CAJfpegvHFHcCPtyJ+w6uRx+hLH9JAT46WJktF_nez-ZZAria7A@mail.gmail.com>
 <20210203142802.GA308988@casper.infradead.org> <CAJfpegtW5-XObARX87A8siTJNxTCkzXG=QY5tTRXVUvHXXZn3g@mail.gmail.com>
 <20210203145620.GB308988@casper.infradead.org> <CAJfpegvV19DT+nQcW5OiLsGWjnp9-DoLAY16S60PewSLcKLTMA@mail.gmail.com>
 <20210208020002.GM4626@dread.disaster.area> <CAJfpeguTt+0099BE6DsVFW_jht_AD8_rtuSyxcz=r+JAnazQGA@mail.gmail.com>
 <20210208140217.GQ308988@casper.infradead.org>
In-Reply-To: <20210208140217.GQ308988@casper.infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 8 Feb 2021 15:52:26 +0100
Message-ID: <CAJfpegvGdA7ZgPvSph8=4Z_57qDH0ss+fYuob7_3n-BjsQqw9w@mail.gmail.com>
Subject: Re: [PATCH 00/18] new API for FS_IOC_[GS]ETFLAGS/FS_IOC_FS[GS]ETXATTR
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Kleikamp <shaggy@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Jan Kara <jack@suse.cz>,
        Joel Becker <jlbec@evilplan.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Richard Weinberger <richard@nod.at>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Tyler Hicks <code@tyhicks.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 8, 2021 at 3:02 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 08, 2021 at 09:25:22AM +0100, Miklos Szeredi wrote:
> > On Mon, Feb 8, 2021 at 3:00 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Wed, Feb 03, 2021 at 04:03:06PM +0100, Miklos Szeredi wrote:
> > > > On Wed, Feb 3, 2021 at 3:56 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > > But let's talk specifics.  What does CIFS need to contact the server for?
> > > > > Could it be cached earlier?
> > > >
> > > > I don't understand what CIFS is doing, and I don't really care.   This
> > > > is the sort of operation where adding a couple of network roundtrips
> > > > so that the client can obtain the credentials required to perform the
> > > > operation doesn't really matter.  We won't have thousands of chattr(1)
> > > > calls per second.
> > >
> > > Incorrect.
> >
> > Okay, I was wrong.
> >
> > Still, CIFS may very well be able to perform these operations without
> > a struct file.   But even if it can't, I'd still only add the file
> > pointer as an *optional hint* from the VFS, not as the primary object
> > as Matthew suggested.
> >
> > I stand by my choice of /struct dentry/ as the object to pass to these
> > operations.
>
> Why the dentry?  This is an inode operation.  Why doesn't it take an
> inode as its primary object?

If we pass struct file to the op, then that limits callers to those
that have an open file.  E.g. it would be difficult to introduce a
path based userspace API for getting/changing these attributes.

Passing a dentry instead of an inode has no such problem, since the
dentry is always available, whether coming from an open file or a
path.  Some inode operations do pass a dentry instead of an inode
(readlink, getattr, setattr) and some filesystems take advantage of
this.

Thanks,
Miklos
