Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2524133F43
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 11:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgAHK0H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 05:26:07 -0500
Received: from mail-il1-f179.google.com ([209.85.166.179]:37416 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbgAHK0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:26:07 -0500
Received: by mail-il1-f179.google.com with SMTP id t8so2240028iln.4;
        Wed, 08 Jan 2020 02:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tyB3mOjJSrqsONVsfz+3VJfm9oi9nwp6r77cUhFGmWs=;
        b=emsIw5nTLQgoJ5U5y9FPsPIDZ+SCATb3XciZ3ntV046jVJg6CtjENgnxFdqg6OeJnV
         wR3DX1bEdpvq9pQ5MXFbcn2ikCLvcmrtQJAgH/Ue8PCROcXByhrV4YfEwuMXjDkxH+SD
         pMT11T4/aQF2bSMiyi86PYhiQmfIP24qAH3ztjUxFta8dsvNF1Prmmw0MoRpgfg1ZVGo
         J25hg24V8rvHkRs72ZkX9G5unb6b/3AvFE26vH7UipD7yFpsiija6kGVgnaEapVsxLK2
         TSro/xCUMCYPoidBkS6Bc7a2fA6w4bsKPvzlt+/r+WDBVwN0JfeBkk2+v1dIiCrppvLQ
         GjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tyB3mOjJSrqsONVsfz+3VJfm9oi9nwp6r77cUhFGmWs=;
        b=DGnwHPWvFIdP5bDjvhEoeOYXtG20S1jkkAVxTOekvfCSDSurksnj+EoXGDpKx0wKXL
         t6nF9vqL8wWqkvhgQKKJofnR3QuIoc3k7Wmu/FDHnhiIS/r0Pi+EvgpzEfv4UfN1JdSJ
         6jjC005NFM/5NDOqd2hxFSbHkDDORYDnyRfkGxQvVw7JvyDLq2j841B0oUS9zl9CLmFV
         +lHuqVdqz+zi0jJaclmzX8AhPpuFRw3g1abNSx7z2Yo9FPFZJ67jJ009BYxHrycRYkYW
         TeaBHOQxDZ/nQ/lRMX0yxviUhPi0A/j3oiwIR2ou6D6R6pQFXy/9aNMWz9xrHRjD7zR+
         NLYg==
X-Gm-Message-State: APjAAAXqfUq0xVV+Z7920cm7T0FaEyQUIZl0+90W1O5eC8WLLQuHxMlM
        vVVhLzfEpyiEtDxdf9KH5XehN+wvapMTcdEfgp4=
X-Google-Smtp-Source: APXvYqz/GR6mi1GJBIIaXnDHQqIqSM76RT/EaCZ3iyjPJuavyY1FToRbRed45nxoZ9YQHKqzERww7hRmclph5on09Ls=
X-Received: by 2002:a92:5c8a:: with SMTP id d10mr3397276ilg.137.1578479167003;
 Wed, 08 Jan 2020 02:26:07 -0800 (PST)
MIME-Version: 1.0
References: <CAOQ4uxiZWKCUKcpBt-bHOcnHoFAq+nghWmf94rJu=3CTc5VhRA@mail.gmail.com>
 <20191211100604.GL1551@quack2.suse.cz> <CAOQ4uxij13z0AazCm7AzrXOSz_eYBSFhs0mo6eZFW=57wOtwew@mail.gmail.com>
 <CAOQ4uxiKzom5uBNbBpZTNCT0XLOrcHmOwYy=3-V-Qcex1mhszw@mail.gmail.com>
 <CAOQ4uxgBcLPGxGVddjFsfWJvcNH4rT+GrN6-YhH8cz5K-q5z2g@mail.gmail.com>
 <20191223181956.GB17813@quack2.suse.cz> <CAOQ4uxhUGCLQyq76nqREETT8kBV9uNOKsckr+xmJdR9Xm=cW3Q@mail.gmail.com>
 <CAOQ4uxjwy4_jWitzHc9hSaBJwVZM68xxJTub50ZfrtgFSZFH8A@mail.gmail.com>
 <20200107171014.GI25547@quack2.suse.cz> <CAOQ4uxjx_n3f44yu9_2dGxtBGy3WssG0xfZykwjQ+n=Wcii2-w@mail.gmail.com>
 <20200108090434.GA20521@quack2.suse.cz>
In-Reply-To: <20200108090434.GA20521@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jan 2020 12:25:55 +0200
Message-ID: <CAOQ4uxjPyaMs0dvObkJR49kjf6zga553wEFRsWDBA28Vta-FnQ@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > What I like about the fact that users don't need to choose between
> > 'parent fid' and 'object fid' is that it makes some hard questions go away:
> > 1. How are "self" events reported? simple - just with 'object id'
> > 2. How are events on disconnected dentries reported? simple - just
> > with 'object id'
> > 3. How are events on the root of the watch reported? same answer
> >
> > Did you write 'directory fid' as opposed to 'parent fid' for a reason?
> > Was it your intention to imply that events on directories (e.g.
> > open/close/attrib) are
> > never reported with 'parent fid' , 'name in directory'?
>
> Yes, that was what I thought.
>
> > I see no functional problem with making that distinction between directory and
> > non-directory, but I have a feeling that 'parent fid', 'name in
> > directory', 'object id',
> > regardless of dir/non-dir is going to be easier to document and less confusing
> > for users to understand, so this is my preference.
>
> Understood. The reason why I decided like this is that for a directory,
> the parent may be actually on a different filesystem (so generating fid
> will be more difficult) and also that what you get from dentry->d_parent
> need not be the dir through which you actually reached the directory (think
> of bind mounts) which could be a bit confusing. So I have no problem with
> always providing 'parent fid' if we can give good answers to these
> questions...
>

Actually, my current code in branch fanotify_name already takes care of
some of those cases and it is rather easy to deal with the bind mount case
if path is available:

      if (path && path->mnt->mnt_root != dentry)
               mnt = real_mount(path->mnt);

      /* Not reporting parent fid + name for fs root, bind mount root and
         disconnected dentry */
      if (!IS_ROOT(dentry) && (!path || mnt))
               marks_mask |= fsnotify_watches_children(
                                               dentry->d_sb->s_fsnotify_mask);
      if (mnt)
               marks_mask |= fsnotify_watches_children(
                                               mnt->mnt_fsnotify_mask);

Note that a non-dir can also be bind mounted, so the concern you raised is
actually not limited to directories.
It is true that with the code above, FAN_ATTRIB and FAN_MODIFY (w/o path)
could still be reported to sb mark with the parent/name under the bind mount,
but that is not wrong at all IMO - I would say that is the expected behavior for
a filesystem mark.

IOW, the answer to your question, phrased in man page terminology is:
(parent fid + name) information is not guarantied to be available except for
FAN_DIR_MODIFY, but it may be available as extra info in addition to object fid
for events that are possible on child.

For example, an application relying on (parent fid + name) information for
FAN_MODIFY (e.g. for remote mirror) simply cannot get this information when
nfsd opens a file with a disconnected dentry and writes to it.

TBH, I am not convinced myself that reporting (parent fid + name) for
directories
is indeed easier to document/implement than treating directories different that
non-directories, but I am going to try and implement it this way and prepare a
draft man page update to see how it looks - I may yet change my mind after
going through this process...

Thanks,
Amir.
