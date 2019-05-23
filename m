Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4594A27BF9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 13:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfEWLkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 07:40:52 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43962 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbfEWLkw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 07:40:52 -0400
Received: by mail-yw1-f66.google.com with SMTP id t5so2127033ywf.10;
        Thu, 23 May 2019 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mZPCeT1KWTaTnW76kQlp0baoWLW7G56uhM+qyZ4/p84=;
        b=GIrpNiB4I0lCzENT0MMfGDn0s8Db8qHff2eRe5u3eW0hpl3WVFT1//26nYnKVeK7QJ
         c56JZO+Wl6YTEcLD/v9xoyPcwxhqXFGxiO5R0EAIQ1wc6k/w0EaH1EfYWq6dyzwCdIKj
         P7/rd8CpaXFVTop4TC7h3sV/syK2ycVa8zHAub6FsA13toxs4Aj2qh+GG+BrwBrgRwxX
         UbOE/awyN+1l3sGH4ns53BFb4CF1haBnfoTLmaJWVjvB1As72XSlWY6l10dtYAxzDSlt
         AbxMHiPPEzRQ2NdZm3KcfjHnxi1fK4lhzzC1X11ZU+XwjvjrtZuFrOIQOHdCA74Ls5H3
         PlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mZPCeT1KWTaTnW76kQlp0baoWLW7G56uhM+qyZ4/p84=;
        b=optRH4snCxyB79WN0KOEJ1kQlE25pXuYRJijbY1CgvCsc25hKe0VwPlmv266pB6ZSr
         vBFQbRopMJPKHXjn5aA7kMAW3K0jMoOH9y2wivMRki6zFRpIAYsrB/Xo4eARET2XvSJ8
         6II1TcTvLTcYHCG0xr/avayMVsxaZZmiCRhfSQafd/zRZI2n1JXKAh0Tovsgcf+k8lF0
         wPIdR8xwDVrZGdagXVwm+MdvmsD8EHffNaTH3xUb9O33iXBX7l694yq9cT0nyWW6zHVO
         TimA+tpT4yWllr1DfEyaZecbtCyvbiWtp8tAI4NZT6aMEKyurKdQ41WoEv9k9CofHTfx
         2ljw==
X-Gm-Message-State: APjAAAVUdxmeWqtIgZojBATARLGt8Aaxzy8PiyMQyYgXKv7z2nu5nK34
        BirdRsnVpWPh5Tfuh51504V93Zh6Vz72/Dt4T/Y=
X-Google-Smtp-Source: APXvYqyw0UrcdT72uhGAiLj2aLmVfhai6bRl6t4nEBApgFv1vDflr4rZDZdy+6C0LTzkY6SSSZvCvBiNws27Yu9Cpas=
X-Received: by 2002:a81:4f06:: with SMTP id d6mr30652001ywb.379.1558611651025;
 Thu, 23 May 2019 04:40:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190522163150.16849-1-christian@brauner.io> <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io> <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io> <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io>
In-Reply-To: <20190523104239.u63u2uth4yyuuufs@brauner.io>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 23 May 2019 14:40:39 +0300
Message-ID: <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
To:     Christian Brauner <christian@brauner.io>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 1:42 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Thu, May 23, 2019 at 01:25:08PM +0300, Amir Goldstein wrote:
> > On Thu, May 23, 2019 at 12:55 PM Christian Brauner <christian@brauner.io> wrote:
> > >
> > > On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> > > > On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > > >
> > > > > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > > > > ><christian@brauner.io> wrote:
> > > > > >>
> > > > > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > > > > >> fanotify_init().
> > > > > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > > > > >at the
> > > > > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > > > > >needed.
> > > > > >
> > > > > >It's intentional:
> > > > > >
> > > > > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > > > > >Author: Eric Paris <eparis@redhat.com>
> > > > > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > > > > >
> > > > > >    fanotify: limit the number of marks in a single fanotify group
> > > > > >
> > > > > >There is currently no limit on the number of marks a given fanotify
> > > > > >group
> > > > > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > > > > >as
> > > > > >a serious DoS threat.  This patch implements a default of 8192, the
> > > > > >same as
> > > > > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > > > > >eliminating
> > > > > >    the default DoS'able status.
> > > > > >
> > > > > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > > > > >
> > > > > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > > > > >There is no reason that fanotify could not be used by unprivileged
> > > > > >users
> > > > > >to setup inotify style watch on an inode or directories children, see:
> > > > > >https://patchwork.kernel.org/patch/10668299/
> > > > > >
> > > > > >>
> > > > > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > > > > >depth")
> > > > > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > > > > >marks")
> > > > > >
> > > > > >Fixes is used to tag bug fixes for stable.
> > > > > >There is no bug.
> > > > > >
> > > > > >Thanks,
> > > > > >Amir.
> > > > >
> > > > > Interesting. When do you think the gate can be removed?
> > > >
> > > > Nobody is working on this AFAIK.
> > > > What I posted was a simple POC, but I have no use case for this.
> > > > In the patchwork link above, Jan has listed the prerequisites for
> > > > removing the gate.
> > > >
> > > > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > > > When events gets reported with fid instead of fd, unprivileged user
> > > > (hopefully) cannot use fid for privilege escalation.
> > > >
> > > > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > > > non-initial userns it's a no-no
> > > > > since we support nested workloads.
> > > >
> > > > One of Jan's questions was what is the benefit of using inotify-compatible
> > > > fanotify vs. using inotify.
> > > > So what was the reason you were looking into switching from inotify to fanotify?
> > > > Is it because of mount/filesystem watch? Because making those available for
> > >
> > > Yeah. Well, I would need to look but you could probably do it safely for
> > > filesystems mountable in user namespaces (which are few).
> > > Can you do a bind-mount and then place a watch on the bind-mount or is
> > > this superblock based?
> > >
> >
> > Either.
> > FAN_MARK_MOUNT was there from day 1 of fanotify.
> > FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.
> >
> > But directory modification events that are supported since v5.1 are
> > not available
> > with FAN_MARK_MOUNT, see:
>
> Because you're worried about unprivileged users spying on events? Or
> something else?

Something else. The current fsnotify_move/create/delete() VFS hooks
have no path/mount information, so it is not possible to filter them by
mount only by inode/sb.
Fixing that would not be trivial, but first a strong use case would need
to be presented.

> Because if you can do a bind-mount there's nothing preventing an
> unprivileged user to do a hand-rolled recursive inotify that would
> amount to the same thing anyway.

There is. unprivileged user cannot traverse into directories it is not
allowed to read/search.

> (And btw, v5.1 really is a major step forward and I would really like to
>  use this api tbh.)
>

You haven't answered my question. What is the reason you are interested
in the new API? What does it provide that the old API does not?
I know the 2 APIs differ. I just want to know which difference interests *you*,
because without a strong use case, it will be hard for me to make progress
upstream.

Is what you want really a "bind-mount" watch or a "subtree watch"?
The distinction is important. I am thinking about solutions for the latter,
although there is no immediate solution in the horizon - only ideas.

Thanks,
Amir.
