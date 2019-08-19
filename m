Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4911692081
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 11:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbfHSJiK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 05:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSJiJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 05:38:09 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63459C00F7E6
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 09:38:09 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id y18so1986838oto.21
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 02:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=60rRVige5JMKARBYqg7mGnVhhfClBN8pbmqimK57PFo=;
        b=twXgGuZ+GENLVFT62n9pcBwxEt5Mq/PDdC6xQSp3jHcf8rIKZqe404AAOossCtNuoG
         scpbOg8uSTwxvNi8ALgdp009bmVGgzjGJzbuj4eJUw7NS+lYcka5Vh4qUzLSp1vfUm7E
         0hUlUSXtXApXToIXRSFN/ENvG1Iu8Tt53IAA5JdEaW+ij8MxflY9yAZj/e3DbyvHN0nt
         4hy0CHEiTTO38TdTnz6GWdQSiP/eI1gZ2SJOdYOjFJBtjNYLiwyOIeqVxqdJbexXJ2T7
         F6W4efe7jZG8GtORJTxAK/sx9QKE76n+nJk8hG5DjlC+OZ04MrYVUkRLMPNUp1Q739CS
         m5bA==
X-Gm-Message-State: APjAAAWqRzKwwl3zeeIUAg/1zX4m4gDX2j/VVR5VXBeeBmUZFdbILE2Y
        dLpmUlR0EAN4Vu+AjuB5XhsnJwuVTyH1VimnaSGmaX6LmGaqXuxQHimPXvm6YwhP0H/bdtkWPi5
        1jxklJwqCYCXSyTYYEDSZNNVxI8hqqDs8oAUmL63tkA==
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr16486576otc.58.1566207488756;
        Mon, 19 Aug 2019 02:38:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyu7VWpm/ykQLhkCx5IuTRbTXVXAVHJxIU8g8KdVoHhsAoxNxwhFjKCfa+WWEcSsyKU+NovpXcf+CMXuqXBX3c=
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr16486561otc.58.1566207488604;
 Mon, 19 Aug 2019 02:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190814204259.120942-1-arnd@arndb.de> <20190814204259.120942-4-arnd@arndb.de>
 <CAHc6FU5n9rBZuH=chOdmGCwyrX-B-Euq8oFrnu3UHHKSm5A5gQ@mail.gmail.com>
 <CAK8P3a3kiyytayaSs2LB=deK0OMs42Ayn4VErhjL6eM3FTGtpw@mail.gmail.com>
 <CAHpGcMJ2EScNiPapyugC_fz+AEhdpKmx3VmYjTH_2me8WLxB2A@mail.gmail.com> <CAK8P3a3iOnsW43qt9yjD8Tyv800svBZF8ZEnqvk-F56vv5yqtw@mail.gmail.com>
In-Reply-To: <CAK8P3a3iOnsW43qt9yjD8Tyv800svBZF8ZEnqvk-F56vv5yqtw@mail.gmail.com>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 19 Aug 2019 11:37:57 +0200
Message-ID: <CAHc6FU77RO3YJgc3mVoRtec6Gmb=TYY46zL3BFennxDUfogm0A@mail.gmail.com>
Subject: Re: [PATCH v5 03/18] gfs2: add compat_ioctl support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Bob Peterson <rpeterso@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Jan Kara <jack@suse.cz>, NeilBrown <neilb@suse.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 19, 2019 at 11:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Sun, Aug 18, 2019 at 10:17 PM Andreas Grünbacher
> <andreas.gruenbacher@gmail.com> wrote:
> > Am So., 18. Aug. 2019 um 21:32 Uhr schrieb Arnd Bergmann <arnd@arndb.de>:
> > > On Fri, Aug 16, 2019 at 7:32 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
> > > > On Wed, Aug 14, 2019 at 10:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > > > +       /* These are just misnamed, they actually get/put from/to user an int */
> > > > > +       switch(cmd) {
> > > > > +       case FS_IOC32_GETFLAGS:
> > > > > +               cmd = FS_IOC_GETFLAGS;
> > > > > +               break;
> > > > > +       case FS_IOC32_SETFLAGS:
> > > > > +               cmd = FS_IOC_SETFLAGS;
> > > > > +               break;
> > > >
> > > > I'd like the code to be more explicit here:
> > > >
> > > >         case FITRIM:
> > > >         case FS_IOC_GETFSLABEL:
> > > >               break;
> > > >         default:
> > > >               return -ENOIOCTLCMD;
> > >
> > > I've looked at it again: if we do this, the function actually becomes
> > > longer than the native gfs2_ioctl(). Should we just make a full copy then?
> >
> > I don't think the length of gfs2_compat_ioctl is really an issue as
> > long as the function is that simple.
>
> True. The most important goal should just be to make it easy to
> add the correct handler the next time another command is added
> to the ioctl function.
>
> Just let me know which version you want for that:
>
> 1. my original patch
> 2. the version from your reply

That one, please.

> 3. my version below with compat_ptr() added
> 4. ...
>
> > > static long gfs2_compat_ioctl(struct file *filp, unsigned int cmd,
> > > unsigned long arg)
> > > {
> > >         switch(cmd) {
> > >         case FS_IOC32_GETFLAGS:
> > >                 return gfs2_get_flags(filp, (u32 __user *)arg);
> > >         case FS_IOC32_SETFLAGS:
> > >                 return gfs2_set_flags(filp, (u32 __user *)arg);
> > >         case FITRIM:
> > >                 return gfs2_fitrim(filp, (void __user *)arg);
> > >         case FS_IOC_GETFSLABEL:
> > >                 return gfs2_getlabel(filp, (char __user *)arg);
> > >         }
> > >
> > >         return -ENOTTY;
> > > }
> >
> > Don't we still need the compat_ptr conversion? That seems to be the
> > main point of having a compat_ioctl operation.
>
> Right, of course. Fixed now in my tree.
>
>          Arnd

Thanks,
Andreas
