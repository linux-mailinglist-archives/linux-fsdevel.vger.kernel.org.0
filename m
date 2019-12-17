Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2481C122327
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 05:31:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbfLQE3F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Dec 2019 23:29:05 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40405 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfLQE3F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Dec 2019 23:29:05 -0500
Received: by mail-io1-f67.google.com with SMTP id x1so399727iop.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Dec 2019 20:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=io9LsV6YTgxAJjSDHvqRcOZBqjMA6kYZPrCLJGTyJS4=;
        b=NtO5xZNVcY6umIUBuUrtrwZ7E7uW6FS+x6OiCfBgWxrlADa5CDy9WH5TAzDLH95uqe
         zWoNj5Z1m3zI9MJChGK4PYKovV21tl5C7tV5cWAvRamjE+SOGkUfS472F2R+cyLTvNTr
         0bY48G1a4BpTQ86hTqT/SvS0lMpeGUmDgNhVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=io9LsV6YTgxAJjSDHvqRcOZBqjMA6kYZPrCLJGTyJS4=;
        b=ZJ6PrxkWQFHkTaNDh3poQPOb9yCEo0wtQUBCQ1cAkNCFX/DRaPmkiyhB1B8fkkPUEE
         XUAegDOx9lAx7B+aVEwfiWcHgfXafYi30XkKjRJuvy8AT/1n6BfH+R2QwtnLpSUTcOVk
         Mvh/+Rp8GnGbppkCu9ENAIkol5Nm4OZYrYcMVkRrrLei7NFHUdf90bFSNKJFLP3yBvpN
         jtHa0PnbQ4pyMBzbRefweDJJayWZ7SbhQ5GVQyG4f039M6EMYVS2F5jgI96QgqYlzYDa
         o6CL63d7TS1F9e3b2/VGFysllRXou4Lz3OiHU4h2pNRuGNQkDgnzwXaAn10pTDyYLzSP
         qFFA==
X-Gm-Message-State: APjAAAWwQgMq0MvOG1JSI9WTZc+XMm1ltZFrhnRp9OGtALS0J6BVU3TR
        U2s0Xz8ByrcmN+4tUbXUBIWCLMNbD2m8IcG5/Vttpg==
X-Google-Smtp-Source: APXvYqzMC0ONHI22FH8i/STQo52i8L5AfzX+22O2Iw+hzIiL3yqVVXgeFLJ0hLBh4XeNlg9rCJr9y92M9nrb2KwvCbA=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr2253754ioc.174.1576556944752;
 Mon, 16 Dec 2019 20:29:04 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com> <20191128155940.17530-13-mszeredi@redhat.com>
 <20191217033721.GS4203@ZenIV.linux.org.uk> <CAJfpegtnyjm_qbfMo0neAvqdMymTPHxT2NZX70XnK_rD5xtKYw@mail.gmail.com>
 <CAJfpegt=QugsQWW7NXGiOpYVSjMVfZRLhJLyq8KTsE47H_tRZg@mail.gmail.com>
 <20191217041945.GW4203@ZenIV.linux.org.uk> <CAJfpegtnYdR39N-iZ5DCnwOEjkpJZ058NDT8iNQNUvDFSO6WOA@mail.gmail.com>
In-Reply-To: <CAJfpegtnYdR39N-iZ5DCnwOEjkpJZ058NDT8iNQNUvDFSO6WOA@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 05:28:53 +0100
Message-ID: <CAJfpegveE5-rh0XHqNFK_QpL_aJLazPFDXCqD0LmFuQac1yGEw@mail.gmail.com>
Subject: Re: [PATCH 12/12] vfs: don't parse "silent" option
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 5:23 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, Dec 17, 2019 at 5:19 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Tue, Dec 17, 2019 at 05:16:58AM +0100, Miklos Szeredi wrote:
> > > On Tue, Dec 17, 2019 at 5:12 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > >
> > > > On Tue, Dec 17, 2019 at 4:37 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > > >
> > > > > On Thu, Nov 28, 2019 at 04:59:40PM +0100, Miklos Szeredi wrote:
> > > > > > While this is a standard option as documented in mount(8), it is ignored by
> > > > > > most filesystems.  So reject, unless filesystem explicitly wants to handle
> > > > > > it.
> > > > > >
> > > > > > The exception is unconverted filesystems, where it is unknown if the
> > > > > > filesystem handles this or not.
> > > > > >
> > > > > > Any implementation, such as mount(8), that needs to parse this option
> > > > > > without failing can simply ignore the return value from fsconfig().
> > > > >
> > > > > Unless I'm missing something, that will mean that having it in /etc/fstab
> > > > > for a converted filesystem (xfs, for example) will fail when booting
> > > > > new kernel with existing /sbin/mount.  Doesn't sound like a good idea...
> > > >
> > > > Nope, the mount(2) case is not changed (see second hunk).
> > >
> > > Wrong, this has nothing to do with mount(2).  The second hunk is about
> > > unconverted filesystems...
> > >
> > > When a filesystem that really needs to handle "silent" is converted,
> > > it can handle that option itself.
> >
> > You know, I had a specific reason to mention XFS...
>
> Will fix.  My bad, I did check filesystems at the time of writing the
> patch, but not when resending...

And BTW this is still not breakage of mount(2) since that code path is
unaffected.  Would need to think  how much the "silent" option makes
sense on the new interface for individual cases specifically.

Thanks,
Miklos
