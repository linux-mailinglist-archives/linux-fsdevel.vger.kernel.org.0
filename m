Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFBFC27AEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2019 12:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730331AbfEWKmo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 May 2019 06:42:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34600 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728518AbfEWKmo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 May 2019 06:42:44 -0400
Received: by mail-ed1-f66.google.com with SMTP id p27so8590390eda.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2019 03:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7G7KMOV6g3j20R/ypsMh4LtnKSKhlC+I/Mtee6H3XzM=;
        b=SDlsxNUZ/CIEihxMH5EaxK8uvKSOcRfyJe0/2tao19I9okNaAeVF8G431fwJDiJ+Du
         yIu2wRZeDxt4o2dTbsTIHod9g0eTR+mtbE7M1YN+HcB7VgCoqftONu8dnIKIzzncDQNZ
         ph4t5K6Df51X8mj+1tViYQka1wgxpAyKhFfzM5o5lIecQvmX7sNkc7xAt0ghz3rf5HXv
         w14HiPKnP1pgwVnFRPSJccQlk+P3U+XVSr54hkwlXYrTTlK5YIdnUghc0UPeW/YSMVdE
         aItJGw8ouWlp5NruA2/ijz7o5Z5abhRjMWie+jDxySOOac/k6fT2+S8C4HNNz02DDGo1
         YuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7G7KMOV6g3j20R/ypsMh4LtnKSKhlC+I/Mtee6H3XzM=;
        b=E1ARblGMt4SdeYJpspc9SFCJmDC5MiLEj5N0/ZBG09yYWqR19SCdmUPkVUJLeoNlfL
         LZkoLXwpaja4NoWPY1IPqoo945/Vg3zR06f1u/XmlWVAQwlit3vDxyTFCipyWmmvXAUs
         SDIkJqprUd4lUMguGcxzCl4zxcqiFq8CRG4F3Q1mIu18FTopXuq+FKeMRatQze8Dj/Qb
         AQmJvwUFINqQhRgLclPe/ugH3GajhEVLALbbtmGU1iPESnoqCWQEIwfQqvYd7X6IM4uD
         DtZgxojEIKPoGLXU80T6bMXDS3chY/5eYYL20RsUUeheJEtr/RULpIGySs4H9x3qB08/
         8+fA==
X-Gm-Message-State: APjAAAXYU6PR3tXiu48TAhBb4LTVwN76gudZr+2PZM5mZunuVVq7zAFg
        D6iRgczuJqqjquH2DVttS2a2ag==
X-Google-Smtp-Source: APXvYqzN6+LHawhNQbZh3C32p4pC9Pi4N3wSY5vZzUbEY1CaF2uw9XPRIUPRj+lUvwNp44q6Nu5sbg==
X-Received: by 2002:a50:8ec7:: with SMTP id x7mr95579350edx.175.1558608162215;
        Thu, 23 May 2019 03:42:42 -0700 (PDT)
Received: from brauner.io (178-197-142-46.pool.kielnet.net. [46.142.197.178])
        by smtp.gmail.com with ESMTPSA id l43sm7946861eda.70.2019.05.23.03.42.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 03:42:41 -0700 (PDT)
Date:   Thu, 23 May 2019 12:42:40 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: [PATCH] fanotify: remove redundant capable(CAP_SYS_ADMIN)s
Message-ID: <20190523104239.u63u2uth4yyuuufs@brauner.io>
References: <20190522163150.16849-1-christian@brauner.io>
 <CAOQ4uxjV=7=FXuyccBK9Pu1B7o-w-pbc1FQXJxY4q6z8E93KOg@mail.gmail.com>
 <EB97EF04-D44F-4320-ACDC-C536EED03BA4@brauner.io>
 <CAOQ4uxhodqVw0DVfcvXYH5vBf4LKcv7t388ZwXeZPBTcEMzGSw@mail.gmail.com>
 <20190523095506.nyei5nogvv63lm4a@brauner.io>
 <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiBeAzsE+b=tE7+9=25-qS7ohuTdEswYOt8DrCp6eAMuw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 23, 2019 at 01:25:08PM +0300, Amir Goldstein wrote:
> On Thu, May 23, 2019 at 12:55 PM Christian Brauner <christian@brauner.io> wrote:
> >
> > On Wed, May 22, 2019 at 11:00:22PM +0300, Amir Goldstein wrote:
> > > On Wed, May 22, 2019 at 9:57 PM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > On May 22, 2019 8:29:37 PM GMT+02:00, Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >On Wed, May 22, 2019 at 7:32 PM Christian Brauner
> > > > ><christian@brauner.io> wrote:
> > > > >>
> > > > >> This removes two redundant capable(CAP_SYS_ADMIN) checks from
> > > > >> fanotify_init().
> > > > >> fanotify_init() guards the whole syscall with capable(CAP_SYS_ADMIN)
> > > > >at the
> > > > >> beginning. So the other two capable(CAP_SYS_ADMIN) checks are not
> > > > >needed.
> > > > >
> > > > >It's intentional:
> > > > >
> > > > >commit e7099d8a5a34d2876908a9fab4952dabdcfc5909
> > > > >Author: Eric Paris <eparis@redhat.com>
> > > > >Date:   Thu Oct 28 17:21:57 2010 -0400
> > > > >
> > > > >    fanotify: limit the number of marks in a single fanotify group
> > > > >
> > > > >There is currently no limit on the number of marks a given fanotify
> > > > >group
> > > > >can have.  Since fanotify is gated on CAP_SYS_ADMIN this was not seen
> > > > >as
> > > > >a serious DoS threat.  This patch implements a default of 8192, the
> > > > >same as
> > > > >inotify to work towards removing the CAP_SYS_ADMIN gating and
> > > > >eliminating
> > > > >    the default DoS'able status.
> > > > >
> > > > >    Signed-off-by: Eric Paris <eparis@redhat.com>
> > > > >
> > > > >There idea is to eventually remove the gated CAP_SYS_ADMIN.
> > > > >There is no reason that fanotify could not be used by unprivileged
> > > > >users
> > > > >to setup inotify style watch on an inode or directories children, see:
> > > > >https://patchwork.kernel.org/patch/10668299/
> > > > >
> > > > >>
> > > > >> Fixes: 5dd03f55fd2 ("fanotify: allow userspace to override max queue
> > > > >depth")
> > > > >> Fixes: ac7e22dcfaf ("fanotify: allow userspace to override max
> > > > >marks")
> > > > >
> > > > >Fixes is used to tag bug fixes for stable.
> > > > >There is no bug.
> > > > >
> > > > >Thanks,
> > > > >Amir.
> > > >
> > > > Interesting. When do you think the gate can be removed?
> > >
> > > Nobody is working on this AFAIK.
> > > What I posted was a simple POC, but I have no use case for this.
> > > In the patchwork link above, Jan has listed the prerequisites for
> > > removing the gate.
> > >
> > > One of the prerequisites is FAN_REPORT_FID, which is now merged.
> > > When events gets reported with fid instead of fd, unprivileged user
> > > (hopefully) cannot use fid for privilege escalation.
> > >
> > > > I was looking into switching from inotify to fanotify but since it's not usable from
> > > > non-initial userns it's a no-no
> > > > since we support nested workloads.
> > >
> > > One of Jan's questions was what is the benefit of using inotify-compatible
> > > fanotify vs. using inotify.
> > > So what was the reason you were looking into switching from inotify to fanotify?
> > > Is it because of mount/filesystem watch? Because making those available for
> >
> > Yeah. Well, I would need to look but you could probably do it safely for
> > filesystems mountable in user namespaces (which are few).
> > Can you do a bind-mount and then place a watch on the bind-mount or is
> > this superblock based?
> >
> 
> Either.
> FAN_MARK_MOUNT was there from day 1 of fanotify.
> FAN_MARK_FILESYSTEM was merged to Linux Linux 4.20.
> 
> But directory modification events that are supported since v5.1 are
> not available
> with FAN_MARK_MOUNT, see:

Because you're worried about unprivileged users spying on events? Or
something else?
Because if you can do a bind-mount there's nothing preventing an
unprivileged user to do a hand-rolled recursive inotify that would
amount to the same thing anyway.
(And btw, v5.1 really is a major step forward and I would really like to
 use this api tbh.)

Christian

> https://github.com/amir73il/man-pages/blob/fanotify_fid/man2/fanotify_init.2#L97
> 
> Matthew,
> 
> Perhaps this fact is worth a mention in the linked entry for FAN_REPORT_FID
> in fanotify_init.2 in addition to the comment on the entry for FAN_MARK_MOUNT
> in fanotify_mark.2.
> 
> Thanks,
> Amir.
