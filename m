Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5E9197D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Aug 2019 22:17:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfHRURS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Aug 2019 16:17:18 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:44224 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbfHRURS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Aug 2019 16:17:18 -0400
Received: by mail-io1-f66.google.com with SMTP id j4so16422577iop.11;
        Sun, 18 Aug 2019 13:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNISD0jbBrhgxwSGll6SKBIMRJhUTsI0mcKzXG+2Cc8=;
        b=iVpCn1z/h2TF4mRwQPNkEisgatFJRWBal3DSkHLn1QVjcVUgekKqpFVSU2DCvxrlmT
         vGXTO0ol2HwdETUX1wm0qbKkeB0VIfvv8giDwxzi0jsC+kULBCy5QxaVmp+QGLKtxuQu
         /lkXZk47NBpXwQqrvTt3iOzzYYg3YFytrNxQA6OZaDU+h+r6Xod1blkv1WyM7KSPMzML
         3XiW9GXm8v3nDm6W2ydkdZp9wVE9sYCowMui+vQhfgonptPHoQxiVNsSNo68u6Oaz4wM
         D7Byzhg5G8LHUGf76KqEVABv+Ts7meyYVMTXtXJ+vPVR3PLKEcOeswrCFZ7HlQoyNbOa
         v2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNISD0jbBrhgxwSGll6SKBIMRJhUTsI0mcKzXG+2Cc8=;
        b=cLADlreqwlM0cLgI5ZP/bnyP3t/XNRY8qvcrwjRJtbWIDqQn1v2mcGlKJTAy9PK1fw
         fRzQ+F/v/F19fVIVIAkHvyknhGlC4kaTv+0krRGF/FKo5QLnojLAmvwgIcCW3gmM02AK
         hOOeWDiEmjeSGy9wOJQYr49hYNH6KJblP+Xl4J8xk0LnzzgTqFBbUk/velJ6uZ6Ptbsy
         39DY5yIRYJB4EvSWsv/0oBiXQZjwe/ECUIkCal5YhPoiQ4+PxIjValf/oHBUeor+NSts
         YREiAuEAB3snN76YVkUwL5fji2ZyiFB/J5qufT+UoV/gvdlRlYwz6e2FulHZ2u1br/FW
         5VQg==
X-Gm-Message-State: APjAAAUBMahMNIJCO4AX5fS7MfBCF1dbWKfXXFsSiPwqj4aL6HFWlvtK
        WiC4BBMCksFvj9D8madR+PTzmjX6sovGaPHOQP4=
X-Google-Smtp-Source: APXvYqyYNT7iiadEEHagIO89R2wXrr0zR0cbwnvgD1ZwZGmfKR4PBCtyJZZiJHa2uk5JBnitLb5xOxeeuqIu3jpL6hs=
X-Received: by 2002:a5d:8194:: with SMTP id u20mr18741598ion.193.1566159437361;
 Sun, 18 Aug 2019 13:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
 <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com> <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com>
In-Reply-To: <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Sun, 18 Aug 2019 22:17:06 +0200
Message-ID: <CAHpGcMJ2EScNiPapyugC_fz+AEhdpKmx3VmYjTH_2me8WLxB2A@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am So., 18. Aug. 2019 um 21:32 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
> On Fri, Aug 16, 2019 at 7:32 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > +       /* These are just misnamed, they actually get/put from/to user an int */
> > > +       switch(cmd) {
> > > +       case FS_IOC32_GETFLAGS:
> > > +               cmd = FS_IOC_GETFLAGS;
> > > +               break;
> > > +       case FS_IOC32_SETFLAGS:
> > > +               cmd = FS_IOC_SETFLAGS;
> > > +               break;
> >
> > I'd like the code to be more explicit here:
> >
> >         case FITRIM:
> >         case FS_IOC_GETFSLABEL:
> >               break;
> >         default:
> >               return -ENOIOCTLCMD;
>
> I've looked at it again: if we do this, the function actually becomes
> longer than the native gfs2_ioctl(). Should we just make a full copy then?

I don't think the length of gfs2_compat_ioctl is really an issue as
long as the function is that simple.

> static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd,
> unsigned long arg)
> {
>         switch(cmd) {
>         case FS_IOC32_GETFLAGS:
>                 return gfs2_get_flags(filp, (u32 __user *)arg);
>         case FS_IOC32_SETFLAGS:
>                 return gfs2_set_flags(filp, (u32 __user *)arg);
>         case FITRIM:
>                 return gfs2_fitrim(filp, (void __user *)arg);
>         case FS_IOC_GETFSLABEL:
>                 return gfs2_getlabel(filp, (char __user *)arg);
>         }
>
>         return -ENOTTY;
> }

Don't we still need the compat_ptr conversion? That seems to be the
main point of having a compat_ioctl operation.

> > Should we feed this through the gfs2 tree?
>
> A later patch that removes the FITRIM handling from fs/compat_ioctl.c
> depends on it, so I'd like to keep everything together.

Ok, fine for me.

Thanks,
Andreas
