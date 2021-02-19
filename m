Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26B831F548
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Feb 2021 08:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhBSHGa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 02:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhBSHG1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 02:06:27 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3369C061574;
        Thu, 18 Feb 2021 23:05:46 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id r2so2846472plr.10;
        Thu, 18 Feb 2021 23:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mo642UNhBZOGrESDSD7VA17YvksfQZNArxt+9RM+fX0=;
        b=HHbnH3Nzoj1bEMuNhRehRR71gR1zKZnOHHE14YlyTZCIjfbGhPSPAcIJ0yu75w5zOb
         KzzKAqw+zWPY3LXv477XFpamkG7fE4WFKiH0lkRKWXKahzb+WJmZLGN7eCEkBkGmdS9B
         M0TcsR+7aOMXNNjiBiEaALIIkwGwaVU4Wsc0nkLS4QnOkO0M/6eqcItLR1792Ih7/jyO
         bFECPKjh+GP6SyxQp7VWBNR0WxbiGAKSx+YdbnkfdG4zVBm0EKEAuIb1sh1Wgw3N6b0+
         +tZT2YOzt9BPsJdAguv8rUhv3Gv5JOwQSFAF3QMRfsrgneFFtffH4aVILBNvDgeuuIcy
         eWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mo642UNhBZOGrESDSD7VA17YvksfQZNArxt+9RM+fX0=;
        b=q/MPR8XvxL6X8gX433CwiOGQnPY3qJO6CkGHB+g06nDI6hRyEDg9uuUnylBl2MNa8h
         nBUa9/d6MNVlaKQ6G6sIq9tGRgpvZoqdDd9P0tMf4NaxeJsssMvoa2yaDx8CyU16MPdU
         s8k0NFj/GVTWF7AZ7vTervik0Y6gVd/eziTwhPLLE8ZAcdBYwRtEF5tlQJmMxQJH3Ao/
         oSkJTRypl/dCTJljDs9aIGIHu+GtDnFOzcwoZsd0wswLMTu7b8odiyQ90c+Bac0GpOo+
         qx2GHx0ZdYSRdvRBdr6c2e5qOneLZm9am/LDebjtCA5nV9ov9yYQQYcmoPNKAl5/v6v1
         v4oA==
X-Gm-Message-State: AOAM532H9hZQcBGzo/y29K66mz0Cg+bAYlRgZh8RsI6sQifcsyEgN1Zu
        M3eP6ilEWPMFQIWfVfyQLFR+VsZq67dDEcryVsg=
X-Google-Smtp-Source: ABdhPJxfghJ78QI8QqCMdivAKnLNH5Kxp0XdgrmKCeMTQVJXkqb5i73JdN7dqX5FGlVQSPrJL6m2/xZm/hhkg3Bko74=
X-Received: by 2002:a17:90a:8906:: with SMTP id u6mr7829714pjn.223.1613718346031;
 Thu, 18 Feb 2021 23:05:46 -0800 (PST)
MIME-Version: 1.0
References: <20210125153057.3623715-1-balsini@android.com> <20210125153057.3623715-4-balsini@android.com>
 <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
In-Reply-To: <CAJfpegs4=NYn9k4F4HvZK3mqLehhxCFKgVxctNGf1f2ed0gfqg@mail.gmail.com>
From:   Peng Tao <bergwolf@gmail.com>
Date:   Fri, 19 Feb 2021 15:05:35 +0800
Message-ID: <CA+a=Yy5=4SJJoDLOPCYDh-Egk8gTv0JgCU-w-AT+Hxhua3_B2w@mail.gmail.com>
Subject: Re: [PATCH RESEND V12 3/8] fuse: Definitions and ioctl for passthrough
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Alessio Balsini <balsini@android.com>,
        Akilesh Kailash <akailash@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Antonio SJ Musumeci <trapexit@spawn.link>,
        David Anderson <dvander@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Martijn Coenen <maco@android.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Lawrence <paullawrence@google.com>,
        Stefano Duo <duostefano93@gmail.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, wuyan <wu-yan@tcl.com>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        kernel-team <kernel-team@android.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 9:41 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, Jan 25, 2021 at 4:31 PM Alessio Balsini <balsini@android.com> wrote:
> >
> > Expose the FUSE_PASSTHROUGH interface to user space and declare all the
> > basic data structures and functions as the skeleton on top of which the
> > FUSE passthrough functionality will be built.
> >
> > As part of this, introduce the new FUSE passthrough ioctl, which allows
> > the FUSE daemon to specify a direct connection between a FUSE file and a
> > lower file system file. Such ioctl requires user space to pass the file
> > descriptor of one of its opened files through the fuse_passthrough_out
> > data structure introduced in this patch. This structure includes extra
> > fields for possible future extensions.
> > Also, add the passthrough functions for the set-up and tear-down of the
> > data structures and locks that will be used both when fuse_conns and
> > fuse_files are created/deleted.
> >
> > Signed-off-by: Alessio Balsini <balsini@android.com>
>
> [...]
>
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index 54442612c48b..9d7685ce0acd 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -360,6 +360,7 @@ struct fuse_file_lock {
> >  #define FUSE_MAP_ALIGNMENT     (1 << 26)
> >  #define FUSE_SUBMOUNTS         (1 << 27)
> >  #define FUSE_HANDLE_KILLPRIV_V2        (1 << 28)
> > +#define FUSE_PASSTHROUGH       (1 << 29)
>
> This header has a version and a changelog.  Please update those as well.
>
> >
> >  /**
> >   * CUSE INIT request/reply flags
> > @@ -625,7 +626,7 @@ struct fuse_create_in {
> >  struct fuse_open_out {
> >         uint64_t        fh;
> >         uint32_t        open_flags;
> > -       uint32_t        padding;
> > +       uint32_t        passthrough_fh;
>
> I think it would be cleaner to add a FOPEN_PASSTHROUGH flag to
> explicitly request passthrough instead of just passing a non-null
> value to passthrough_fh.
>
> >  };
> >
> >  struct fuse_release_in {
> > @@ -828,6 +829,13 @@ struct fuse_in_header {
> >         uint32_t        padding;
> >  };
> >
> > +struct fuse_passthrough_out {
> > +       uint32_t        fd;
> > +       /* For future implementation */
> > +       uint32_t        len;
> > +       void            *vec;
> > +};
>
> I don't see why we'd need these extensions.    The ioctl just needs to
> establish an ID to open file mapping that can be referenced on the
> regular protocol, i.e. it just needs to be passed an open file
> descriptor and return an unique ID.
>
> Mapping the fuse file's data to the underlying file's data is a
> different matter.  That can be an identity mapping established at open
> time (this is what this series does) or it can be an arbitrary extent
> mapping to one or more underlying open files, established at open time
> or on demand.  All of these can be done in band using the fuse
> protocol, no need to involve the ioctl mechanism.
>
> So I think we can just get rid of "struct fuse_passthrough_out"
> completely and use "uint32_t *" as the ioctl argument.
>
> What I think would be useful is to have an explicit
> FUSE_DEV_IOC_PASSTHROUGH_CLOSE ioctl, that would need to be called
> once the fuse server no longer needs this ID.   If this turns out to
> be a performance problem, we could still add the auto-close behavior
> with an explicit FOPEN_PASSTHROUGH_AUTOCLOSE flag later.
Hi Miklos,

W/o auto closing, what happens if user space daemon forgets to call
FUSE_DEV_IOC_PASSTHROUGH_CLOSE? Do we keep the ID alive somewhere?

Thanks,
Tao
-- 
Into Sth. Rich & Strange
