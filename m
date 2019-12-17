Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 173F912346D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 19:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbfLQSIq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 13:08:46 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:45278 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfLQSIq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 13:08:46 -0500
Received: by mail-io1-f66.google.com with SMTP id i11so8937762ioi.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Dec 2019 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIJyvkgniYTRbfVXcX1GxMAL0QR6Z8+gBwpFH9B/c4o=;
        b=XlMSk7A88wGRbKPmBiK+0N9lxDaruaINHiTIT+XEKts5pKGzy9dnHPdZZo2HouzJj2
         UezX+XPJHeZ+F5CfDjtpJ5XdSDJtZ+koIOi7Sd+bzyL9Qgqr54KjVIz1Gz+5DB8dDNcj
         qxT42ZDVS8ut17EXMMS23SKbC0c62AVtHHDsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIJyvkgniYTRbfVXcX1GxMAL0QR6Z8+gBwpFH9B/c4o=;
        b=pZ3f7AcO8IEc9sNeaI6MnaAio55hN1YLogsNwbIw93j+g++k98l3cosgdRbG5/21Ji
         2dNgH5mnqu2Fl69Ve7a31XadZfFcy+c09/1YMoc/AKjN/EMHeI22a9leJiK6Pjf/aJg+
         eF/ffCRlA6WPf49KROhahLF7fPz4lMxD7CHK1SIba2m/34gqeY76DZalNvQmHzocgBQd
         C0VjhxEQZqqGR8CeWD5+TK/WHXkBMjHLW9eb3GMSGLU3jaYDFMwbdQSrUNC/kQMw6XZU
         CSLjAoJ4rBG9JDymOCzkBpWcaNHoGkUo6FgZo02BTR6zh0P3v1Mlyolvqcc2BPwP3QQE
         4BLw==
X-Gm-Message-State: APjAAAUfqlk6rvZSIKqobzlCqLYt+E8J/3/73vN5HScKQeaUZN7e1iAY
        PT3HnQh2OJv5mVxzLs+DYCgtYASPxz9x+ymrNGo0wA==
X-Google-Smtp-Source: APXvYqxRQov73i2S2wI8koP3gXNvUCrtrWmcjpiZqNtU+6+fSqNO+yoiT72worXPzEwwctA/CUwaC06tsekviuWP3Kc=
X-Received: by 2002:a6b:6f07:: with SMTP id k7mr4799644ioc.174.1576606125798;
 Tue, 17 Dec 2019 10:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20191212145042.12694-1-labbott@redhat.com> <CAOi1vP9E2yLeFptg7o99usEi=x3kf=NnHYdURXPhX4vTXKCTCQ@mail.gmail.com>
 <fbe90a0b-cf24-8c0c-48eb-6183852dfbf1@redhat.com> <CAHk-=wh7Wuk9QCP6oH5Qc1a89_X6H1CHRK_OyB4NLmX7nRYJeA@mail.gmail.com>
 <cf4c9634-1503-d182-cb12-810fb969bc96@redhat.com> <20191212213609.GK4203@ZenIV.linux.org.uk>
 <CAJfpegv_zY6w6=pOL0x=sjuQmGae0ymOafZXjyAdNEHj+EKyNA@mail.gmail.com> <32253.1576604947@warthog.procyon.org.uk>
In-Reply-To: <32253.1576604947@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 17 Dec 2019 19:08:34 +0100
Message-ID: <CAJfpeguwy+dyPmad8RE5JmUce8ecze8Kccj--YgXaEHThxeT4g@mail.gmail.com>
Subject: Re: [PATCH] vfs: Don't reject unknown parameters
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Laura Abbott <labbott@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeremi Piotrowski <jeremi.piotrowski@gmail.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 17, 2019 at 6:49 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > > So you could bloody well just leave recognition (and handling) of "source"
> > > to the caller, leaving you with just this:
> > >
> > >         if (strcmp(param->key, "source") == 0)
> > >                 return -ENOPARAM;
> > >         /* Just log an error for backwards compatibility */
> > >         errorf(fc, "%s: Unknown parameter '%s'", fc->fs_type->name, param->key);
> > >         return 0;
> >
> > Which is fine for the old mount(2) interface.
> >
> > But we have a brand new API as well; do we really need to carry these
> > backward compatibility issues forward?  I mean checking if a
> > param/flag is supported or not *is* useful and lacking that check is
> > the source of numerous headaches in legacy interfaces (just take the
> > open(2) example and the introduction of O_TMPFILE).
>
> The problem with what you're suggesting is that you can't then make
> /sbin/mount to use the new syscalls because that would change userspace
> behaviour - unless you either teach /sbin/mount which filesystems discard
> which errors from unrecognised options or pass a flag to the kernel to shift
> into or out of 'strict' mode.

The latter has minor cost, so we can add it easily.  Long term I think
it makes sense to move this mess up to userspace, and hence let
util-linux deal with it.

Thanks,
Miklos
