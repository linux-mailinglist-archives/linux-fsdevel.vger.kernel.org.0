Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA8827E37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 15:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730643AbfEWNf0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 09:35:26 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33423 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWNf0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 09:35:26 -0400
Received: by mail-io1-f65.google.com with SMTP id z4so4886599iol.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 06:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/7i3oLt0uS0U3BJ8Vo+88z1lvdyu8OdJPDSaCcWNFRM=;
        b=V+asts04UroP8pLt1ozor3qRC0irU7J0A+4TMxexQ80A0l6lfDsxYgTfZt0CrrD3cP
         qrbURWRGYBT5Lol1AGQSXiuzMpAcZ4nzoFt0VRGmm0S1Cm48kHuUD/U5bDj6QtqoXXD5
         e8gmpeQrO65Otwff+wZD1DzoI8yDVtzGUMcqQfNYji+GfdrQwfk/EUzmdOvJtmYUx1pK
         uCnqjydTeUZNCD/H+yJoPuFyGp9xuGxMQeux7YSwCNNCsGvoroTsAs1+wPjdIo8IYtdR
         yPfHXcIMXV0BZ88QX+Y1k8TupYOXREwDayuO1t5VvtFT8y7W8wGGJ0RoIgjD5jh+coDS
         e6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/7i3oLt0uS0U3BJ8Vo+88z1lvdyu8OdJPDSaCcWNFRM=;
        b=o/R1SMY15kH6JZtkC/HYIqvTdWiTb9SX2OMRkmXPaho+Bc6cfMdwqyvcOhj+IoogRZ
         3o/YNHhQ6qgqxm0SoQgVnz40niu6ZlxwHgm2enTMeQ2KZRLNd+cdXIVPtIr7H49Walsc
         N6QHFxfvb25TROSF9J7klfBl6JqCCx2MVNO5bPjRd+BEeEhYmHKz+M0aEtQVj70tNLqc
         5ORv3ACW0KT0EysHe8sXmWB318/oaUFLIGg6YKXM4nn73G+N8PqJgdzU6fIKv8T+onIR
         gE4SNQ5jGO2bh/Dxvp+vckRLGIuSmGrcLBuTilatY9yIfpEaRo8Gs9+7cYCGwZMImAzt
         4iJg==
X-Gm-Message-State: APjAAAWPFj/NTZtbWxkCjTVi4redGRAkNwz4TX/eb4/9aid+HJxK2S/C
        NunZ/J0rq/f0pg5WbxOf6fK+A5g+i4/TFA==
X-Google-Smtp-Source: APXvYqxTtRpfut/Z/ru2oeRxDNg2iC/phXp9o2eWaAR27h25vEHFlNyxkuOvngkzWq5trQQ1vn74qw==
X-Received: by 2002:a6b:8ec4:: with SMTP id q187mr26014832iod.280.1558618525068;
        Thu, 23 May 2019 06:35:25 -0700 (PDT)
Received: from brauner.io ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id h20sm5373723iog.6.2019.05.23.06.35.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 06:35:23 -0700 (PDT)
Date:   Thu, 23 May 2019 15:35:18 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523133516.6734wclswqr6vpeg@brauner.io>
References: <20190522163150.16849-1-christian@brauner.io>
 <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io>
 <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
 <20190523115845.w7neydaka5xivwyi@brauner.io>
 <CAOQ4uxgJXLyZe0Bs=q60=+pHpdGtnCdKKZKdr-3iTbygKCryRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgJXLyZe0Bs=q60=+pHpdGtnCdKKZKdr-3iTbygKCryRA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 04:16:24PM +0300, Amir Goldstein wrote:
> On Thu, May 23, 2019 at 2:58 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Thu, May 23, 2019 at 02:40:39PM +0300, Amir Goldstein wrote:
> > > On Thu, May 23, 2019 at 1:42 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Thu, May 23, 2019 at 01:25:08PM +0300, Amir Goldstein wrote:
> > > > > On Thu, May 23, 2019 at 12:55 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > >
> > > > > > On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> > > > > > > On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > > > >
> > > > > > > > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > > > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > > > > > > > ><christian@brauner.io> wrote:
> > > > > > > > >>
> > > > > > > > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > > > > > > > >> fanotify_init().
> > > > > > > > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > > > > > > > >at the
> > > > > > > > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > > > > > > > >needed.
> > > > > > > > >
> > > > > > > > >It's intentional:
> > > > > > > > >
> > > > > > > > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > > > > > > > >Author: Eric Paris <eparis@redhat.com>
> > > > > > > > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > > > > > > > >
> > > > > > > > >    fanotify: limit the number of marks in a single fanotify group
> > > > > > > > >
> > > > > > > > >There is currently no limit on the number of marks a given fanotify
> > > > > > > > >group
> > > > > > > > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > > > > > > > >as
> > > > > > > > >a serious DoS threat.  This patch implements a default of 8192, the
> > > > > > > > >same as
> > > > > > > > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > > > > > > > >eliminating
> > > > > > > > >    the default DoS'able status.
> > > > > > > > >
> > > > > > > > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > > > > > > > >
> > > > > > > > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > > > > > > > >There is no reason that fanotify could not be used by unprivileged
> > > > > > > > >users
> > > > > > > > >to setup inotify style watch on an inode or directories children, see:
> > > > > > > > >https://patchwork.kernel.org/patch/10668299/
> > > > > > > > >
> > > > > > > > >>
> > > > > > > > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > > > > > > > >depth")
> > > > > > > > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > > > > > > > >marks")
> > > > > > > > >
> > > > > > > > >Fixes is used to tag bug fixes for stable.
> > > > > > > > >There is no bug.
> > > > > > > > >
> > > > > > > > >Thanks,
> > > > > > > > >Amir.
> > > > > > > >
> > > > > > > > Interesting. When do you think the gate can be removed?
> > > > > > >
> > > > > > > Nobody is working on this AFAIK.
> > > > > > > What I posted was a simple POC, but I have no use case for this.
> > > > > > > In the patchwork link above, Jan has listed the prerequisites for
> > > > > > > removing the gate.
> > > > > > >
> > > > > > > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > > > > > > When events gets reported with fid instead of fd, unprivileged user
> > > > > > > (hopefully) cannot use fid for privilege escalation.
> > > > > > >
> > > > > > > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > > > > > > non-initial userns it's a no-no
> > > > > > > > since we support nested workloads.
> > > > > > >
> > > > > > > One of Jan's questions was what is the benefit of using inotify-compatible
> > > > > > > fanotify vs. using inotify.
> > > > > > > So what was the reason you were looking into switching from inotify to fanotify?
> > > > > > > Is it because of mount/filesystem watch? Because making those available for
> > > > > >
> > > > > > Yeah. Well, I would need to look but you could probably do it safely for
> > > > > > filesystems mountable in user namespaces (which are few).
> > > > > > Can you do a bind-mount and then place a watch on the bind-mount or is
> > > > > > this superblock based?
> > > > > >
> > > > >
> > > > > Either.
> > > > > FAN_MARK_MOUNT was there from day 1 of fanotify.
> > > > > FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.
> > > > >
> > > > > But directory modification events that are supported since v5.1 are
> > > > > not available
> > > > > with FAN_MARK_MOUNT, see:
> > > >
> > > > Because you're worried about unprivileged users spying on events? Or
> > > > something else?
> > >
> > > Something else. The current fsnotify_move/create/delete() VFS hooks
> > > have no path/mount information, so it is not possible to filter them by
> > > mount only by inode/sb.
> > > Fixing that would not be trivial, but first a strong use case would need
> > > to be presented.
> > >
> > > > Because if you can do a bind-mount there's nothing preventing an
> > > > unprivileged user to do a hand-rolled recursive inotify that would
> > > > amount to the same thing anyway.
> > >
> > > There is. unprivileged user cannot traverse into directories it is not
> > > allowed to read/search.
> >
> > Right, I should've mentioned: when you're userns root and you have
> > access to all files. The part that is interesting to me is getting rid
> > of capable(CAP_SYS_ADMIN).
> 
> Indeed. so part of removing the gated capable(CAP_SYS_ADMIN)
> is figuring out the permission checks needed for individual features.
> I agree that for FAN_MARK_MOUNT/FILESYSTEM,
> capabale(CAP_SYS_ADMIN) is too strong.
> ns_capable(sb->s_user_ns, CAP_DAC_READ_SEARCH)
> is probably enough.
> 
> >
> > >
> > > > (And btw, v5.1 really is a major step forward and I would really like to
> > > >  use this api tbh.)
> > > >
> > >
> > > You haven't answered my question. What is the reason you are interested
> > > in the new API? What does it provide that the old API does not?
> > > I know the 2 APIs differ. I just want to know which difference interests *you*,
> > > because without a strong use case, it will be hard for me to make progress
> > > upstream.
> > >
> > > Is what you want really a "bind-mount" watch or a "subtree watch"?
> > > The distinction is important. I am thinking about solutions for the latter,
> > > although there is no immediate solution in the horizon - only ideas.
> >
> > Both cases would be interesting. But subtree watch is what would
> > probably help a lot already. So let me explain.
> > For LXD - not sure if you know what that is -
> I do
> 
> >  we allow user to "hotplug"
> > mounts or certain whitelisted devices into a user namespace container.
> > One of the nifty features is that we let users specify a "required"
> > property. When "required" is "false" the user can give us a path, e.g.
> > /bla/bla/bla/target and then we place a watch on the closest existing
> > ancestor of my-device. When the target shows up we hotplug it for the
> > user. Now, as you imagine maintaining that cache until "target" shows up
> > is a royal pain.
> 
> You lost me there. Are you looking for notifications when device files appear?

Just when that file is created. fanotify doesn't need to do anything
special for device files. As long as a file (device or
otherwise) and directory creation/deletion triggers an event we're good.
I can then just stat the file and check that it's the device I expect.

> When directory is created? Please give a concrete example.
> What part of /bla/bla/bla/target appears, when and how.

So let's say the user tells me:
- When the "/A/B/C/target" file appears on the host filesystem,
  please give me access to "target" in the container at a path I tell
  you.
What I do right now is listen for the creation of the "target" file.
But at the time the user gives me instructions to listen for
"/A/B/C/target" only /A might exist and so I currently add a watch on A/
and then wait for the creation of B/, then wait for the creation of C/
and finally for the creation of "target" (Of course, I also need to
handle B/ and C/ being removed again an recreated and so on.). It would
be helpful, if I could specify, give me notifications, recursively for
e.g. A/ without me having to place extra watches on B/ and C/ when they
appear. Maybe that's out of scope...

> fanotify does not give notifications when mounts are mounted.
> I have seen a proposal by David Howells for mount change notifications.

David's going to send this out soon, I think.

Thanks!
Christian
