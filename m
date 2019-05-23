Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5546327C4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 13:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbfEWL6u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 07:58:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34094 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbfEWL6u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 07:58:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so8891325eda.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fHMFUKbG6Z1JionWeMJvzS6MHCcIonbFZhZi/HSky6k=;
        b=MgIeKsPrSECQ+KZfe2WcSnzsqjOiLOx/b768LRpunmCRQTDTCaPYK9Lx3g2G+mqVBt
         IKurDIXo/P35C0pA5/93qHk1TjBS7uQecOKn6hGUdlluza8+GRyWqVuUwBYNDMQCPxCY
         Xy1WNvYpoUoS4WoorsGVmWFgobgy981ynbksnDNUNMt4PyF8X+sUX5jhGu35K2VaBTwO
         emvs6kMgf1g1QUc421sf3lMOQlRjO//YPUXkM217ub5pULxJLDv905PxkMWwHU/D0Egg
         tGU0DCZaXCLeLg14W5A2ieIiMr9zlR2rn7GzE4Bh1nJD9c4LYZHypPmSDueV1xhviSjT
         MUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fHMFUKbG6Z1JionWeMJvzS6MHCcIonbFZhZi/HSky6k=;
        b=oTXbzPzueDsU/L1tmvS9LmDCdKlGfm5PSre9HUGcR06rGSkPvNdgXe2JgPw19Fo9qj
         0YEBHtaLezcKTAgMqgP5VKw+LHbcC0cXpJ9Kc1QGqE0N0pVGshAueOdeS0U74LBj5kOH
         wY0Hzniw7kWXqO9z2JoIt9YET0Gg2lRpzfATfkRFxIy0SFYcWmmEW5SSwFaQamHED4FU
         nE+UtsAD80/wGMb1HlcmVKjtGVqxV7iMfq/jTmzRBSHTgLFBQ7eL89JEWIPkNsUVHBdX
         ShO67RAym1ZPs522O8QpdHN+WxYRIYXed11ulBPu998tVpDukdITdgNslbljxDZaLa7Y
         uEtQ==
X-Gm-Message-State: APjAAAWh7bjIY+nX+5lV/I9IOfJabBzjo+GwdFiaQS7GoF8TfiT4Na+7
        kn4Ety2jhqG1T1M68gmfQVYiag==
X-Google-Smtp-Source: APXvYqyFfVt792qDhJmQnvDO74r6Nptq+9Jdiq/Pb+oBz9tuAP8o95P03p3ppFHFMpNQpi2X4q5MKg==
X-Received: by 2002:a50:a3b5:: with SMTP id s50mr96935208edb.149.1558612727834;
        Thu, 23 May 2019 04:58:47 -0700 (PDT)
Received: from brauner.io (178-197-142-46.pool.kielnet.net. [46.142.197.178])
        by smtp.gmail.com with ESMTPSA id l23sm4369446eje.6.2019.05.23.04.58.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 04:58:47 -0700 (PDT)
Date:   Thu, 23 May 2019 13:58:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523115845.w7neydaka5xivwyi@brauner.io>
References: <20190522163150.16849-1-christian@brauner.io>
 <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
 <20190523104239.u63u2uth4yyuuufs@brauner.io>
 <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxji4jRvJnLvXe0yR4Ls7VxM_tjAypX1TqBe5FYr_7GnXw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 02:40:39PM +0300, Amir Goldstein wrote:
> On Thu, May 23, 2019 at 1:42 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Thu, May 23, 2019 at 01:25:08PM +0300, Amir Goldstein wrote:
> > > On Thu, May 23, 2019 at 12:55 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> > > > > On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > > > >
> > > > > > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > > > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > > > > > ><christian@brauner.io> wrote:
> > > > > > >>
> > > > > > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > > > > > >> fanotify_init().
> > > > > > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > > > > > >at the
> > > > > > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > > > > > >needed.
> > > > > > >
> > > > > > >It's intentional:
> > > > > > >
> > > > > > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > > > > > >Author: Eric Paris <eparis@redhat.com>
> > > > > > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > > > > > >
> > > > > > >    fanotify: limit the number of marks in a single fanotify group
> > > > > > >
> > > > > > >There is currently no limit on the number of marks a given fanotify
> > > > > > >group
> > > > > > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > > > > > >as
> > > > > > >a serious DoS threat.  This patch implements a default of 8192, the
> > > > > > >same as
> > > > > > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > > > > > >eliminating
> > > > > > >    the default DoS'able status.
> > > > > > >
> > > > > > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > > > > > >
> > > > > > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > > > > > >There is no reason that fanotify could not be used by unprivileged
> > > > > > >users
> > > > > > >to setup inotify style watch on an inode or directories children, see:
> > > > > > >https://patchwork.kernel.org/patch/10668299/
> > > > > > >
> > > > > > >>
> > > > > > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > > > > > >depth")
> > > > > > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > > > > > >marks")
> > > > > > >
> > > > > > >Fixes is used to tag bug fixes for stable.
> > > > > > >There is no bug.
> > > > > > >
> > > > > > >Thanks,
> > > > > > >Amir.
> > > > > >
> > > > > > Interesting. When do you think the gate can be removed?
> > > > >
> > > > > Nobody is working on this AFAIK.
> > > > > What I posted was a simple POC, but I have no use case for this.
> > > > > In the patchwork link above, Jan has listed the prerequisites for
> > > > > removing the gate.
> > > > >
> > > > > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > > > > When events gets reported with fid instead of fd, unprivileged user
> > > > > (hopefully) cannot use fid for privilege escalation.
> > > > >
> > > > > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > > > > non-initial userns it's a no-no
> > > > > > since we support nested workloads.
> > > > >
> > > > > One of Jan's questions was what is the benefit of using inotify-compatible
> > > > > fanotify vs. using inotify.
> > > > > So what was the reason you were looking into switching from inotify to fanotify?
> > > > > Is it because of mount/filesystem watch? Because making those available for
> > > >
> > > > Yeah. Well, I would need to look but you could probably do it safely for
> > > > filesystems mountable in user namespaces (which are few).
> > > > Can you do a bind-mount and then place a watch on the bind-mount or is
> > > > this superblock based?
> > > >
> > >
> > > Either.
> > > FAN_MARK_MOUNT was there from day 1 of fanotify.
> > > FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.
> > >
> > > But directory modification events that are supported since v5.1 are
> > > not available
> > > with FAN_MARK_MOUNT, see:
> >
> > Because you're worried about unprivileged users spying on events? Or
> > something else?
> 
> Something else. The current fsnotify_move/create/delete() VFS hooks
> have no path/mount information, so it is not possible to filter them by
> mount only by inode/sb.
> Fixing that would not be trivial, but first a strong use case would need
> to be presented.
> 
> > Because if you can do a bind-mount there's nothing preventing an
> > unprivileged user to do a hand-rolled recursive inotify that would
> > amount to the same thing anyway.
> 
> There is. unprivileged user cannot traverse into directories it is not
> allowed to read/search.

Right, I should've mentioned: when you're userns root and you have
access to all files. The part that is interesting to me is getting rid
of capable(CAP_SYS_ADMIN).

> 
> > (And btw, v5.1 really is a major step forward and I would really like to
> >  use this api tbh.)
> >
> 
> You haven't answered my question. What is the reason you are interested
> in the new API? What does it provide that the old API does not?
> I know the 2 APIs differ. I just want to know which difference interests *you*,
> because without a strong use case, it will be hard for me to make progress
> upstream.
> 
> Is what you want really a "bind-mount" watch or a "subtree watch"?
> The distinction is important. I am thinking about solutions for the latter,
> although there is no immediate solution in the horizon - only ideas.

Both cases would be interesting. But subtree watch is what would
probably help a lot already. So let me explain.
For LXD - not sure if you know what that is - we allow user to "hotplug"
mounts or certain whitelisted devices into a user namespace container.
One of the nifty features is that we let users specify a "required"
property. When "required" is "false" the user can give us a path, e.g.
/bla/bla/bla/target and then we place a watch on the closest existing
ancestor of my-device. When the target shows up we hotplug it for the
user. Now, as you imagine maintaining that cache until "target" shows up
is a royal pain.

I think that we can get rid of at least some of the complexity if
subtree watch and bind-mount watches would work.

Thanks!
Christian
