Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4E3B280F7E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Oct 2020 11:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgJBJHA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 05:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgJBJHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:07:00 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A379C0613D0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 02:07:00 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id f15so625559ilj.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 02 Oct 2020 02:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3eHeAWhSl/FS+BE1XBpVOXWFB1Qt+eewr4L4cMVEiQ=;
        b=unZnUIWYH2AXkgwcrvJJQqbl0lkXFtXP9cLkeUp8NbValaqU0G12jb7evX3i5bqYuq
         6ns6uC80dRaT+Yp7WfFchnqUrUYOwji9MAFIBe6w3OQ2SFuVPLFq5aI/1G6x11tlSinc
         Hy2T9pxYVxSXFvz6XY2b+9iA7RFJzGwZW+94F0og4fNEX2BSCji76a8bvu6dyjVblFIl
         EHoJj9rD2/f6hiPHDBJ90YDAJHAa7qoY6MDJW+nb/pCLrrbZVqPgk+soLv6lg1WCp+wo
         WTrV5aOocmNlslee/O+sgUOnvgSMd0RZiV6U3Ygy7NRg/PXK8ClC+T8tdeTs8+EM6ro4
         GYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3eHeAWhSl/FS+BE1XBpVOXWFB1Qt+eewr4L4cMVEiQ=;
        b=MNGZ2aO80O0aWW8UtvNsS325hjE7HLA+0k+klvXzPvcsI/HrdVN3n9yaoMf9HYycpU
         iTbnZUrnTwNyTxtMvAzZQnJP7sX1c9S7oq9hy6rZZsX/8QVRCFFKuleimi7+No21Ynh7
         Ae1MhfQm09nb8OCFEdR5U3lAuSh49k5Yn9T9RBFfbnSz04GXYW8eKzpWL5S792jmr6GB
         DxLNgXH4C3Ijlbg7AbTzPnqthiiPjgu2EfAeRtbH65ZPDufTwB7nMQTrK8idwwI202uA
         IAbymEyyXiET1CsAmZ4niUZmXhKMu7Efsfy2QEmGJD3mMGhXbiPhqXMuEE4wAwoy/+IR
         gOeg==
X-Gm-Message-State: AOAM533ap4Fd0Wiv1jyr7sRZ9tisl3QZuD5xqFJMpotB28k+b33EmdNo
        xrZJKBSPNvoUYqsUKMK0ISo5D0rJmm5MhDrNZdUUtlAGp78=
X-Google-Smtp-Source: ABdhPJwEAfQ91QGuRuvPz/mKflWF28+OnPlYAXacZ3rGUEHN+Ld/JrFSr2J+GU/pe3BNjRtokF5XNkc4iYmbC0NFWHs=
X-Received: by 2002:a92:5f89:: with SMTP id i9mr1072878ill.250.1601629619280;
 Fri, 02 Oct 2020 02:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200914172737.GA5011@192.168.3.9> <20200915070841.GF4863@quack2.suse.cz>
 <CAOQ4uxjxNmem7dwSMcqefGt5qaxwtHTYQ-k_kxuoMX_vJeTGOg@mail.gmail.com>
 <20201001110058.GG17860@quack2.suse.cz> <CAOQ4uxh3cgzEZJhYVMqtVB5kig1O57WaUkxPnxnpQHm5TGjmfg@mail.gmail.com>
 <20201002082719.GA17963@quack2.suse.cz>
In-Reply-To: <20201002082719.GA17963@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 2 Oct 2020 12:06:48 +0300
Message-ID: <CAOQ4uxiUS7PCpwMHYGYZM=3-R=4VMQMww=F=BL+fw+JTE=8zEQ@mail.gmail.com>
Subject: Re: FAN_UNPRIVILEGED
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 2, 2020 at 11:27 AM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 01-10-20 16:08:50, Amir Goldstein wrote:
> > On Thu, Oct 1, 2020 at 2:00 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > I'm sorry for late reply on this one...
> > >
> > > On Tue 15-09-20 11:33:41, Amir Goldstein wrote:
> > > > On Tue, Sep 15, 2020 at 10:08 AM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Tue 15-09-20 01:27:43, Weiping Zhang wrote:
> > > > > > Now the IN_OPEN event can report all open events for a file, but it can
> > > > > > not distinguish if the file was opened for execute or read/write.
> > > > > > This patch add a new event IN_OPEN_EXEC to support that. If user only
> > > > > > want to monitor a file was opened for execute, they can pass a more
> > > > > > precise event IN_OPEN_EXEC to inotify_add_watch.
> > > > > >
> > > > > > Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
> > > > >
> > > > > Thanks for the patch but what I'm missing is a justification for it. Is
> > > > > there any application that cannot use fanotify that needs to distinguish
> > > > > IN_OPEN and IN_OPEN_EXEC? The OPEN_EXEC notification is for rather
> > > > > specialized purposes (e.g. audit) which are generally priviledged and need
> > > > > to use fanotify anyway so I don't see this as an interesting feature for
> > > > > inotify...
> > > >
> > > > That would be my queue to re- bring up FAN_UNPRIVILEGED [1].
> > > > Last time this was discussed [2], FAN_UNPRIVILEGED did not have
> > > > feature parity with inotify, but now it mostly does, short of (AFAIK):
> > > > 1. Rename cookie (*)
> > > > 2. System tunables for limits
> > > >
> > > > The question is - should I pursue it?
> > >
> > > So I think that at this point some form less priviledged fanotify use
> > > starts to make sense. So let's discuss how it would look like... What comes
> > > to my mind:
> > >
> > > 1) We'd need to make max_user_instances, max_user_watches, and
> > > max_queued_events configurable similarly as for inotify. The first two
> > > using ucounts so that the configuration is actually per-namespace as for
> > > inotify.
> > >
> > > 2) I don't quite like the FAN_UNPRIVILEDGED flag. I'd rather see the checks
> > > being done based on functionality requested in fanotify_init() /
> > > fanotify_mark(). E.g. FAN_UNLIMITED_QUEUE or permission events will require
> > > CAP_SYS_ADMIN, mount/sb marks will require CAP_DAC_READ_SEARCH, etc.
> > > We should also consider which capability checks should be system-global and
> > > which can be just user-namespace ones...
> >
> > OK. That is not a problem to do.
> > But FAN_UNPRIVILEDGED flag also impacts:
> >
> >     An unprivileged event listener does not get an open file descriptor in
> >     the event nor the process pid of another process.
>
> Well, are these really sensitive that they should be forbidden? If we allow
> only inode marks and given inode is opened in the context of process
> reading the event, I don't see how fd would be any sensitive? And similarly
> for pid I'd say...
>

Because I was under the impression that we are going to allow a dir watch
on children, just like inotify and process may have permission to access dir,
but no permission to open a child.

That said, it's true that we can decide whether or not to export a RDONLY
open fd based on CAP_DAC_READ_SEARCH of the reader process.

Regarding exposing pid, I am not familiar with the capabilities required to
"spy" on another process' actions using other facilities, so I thought we
should take a conservative approach and require at least CAP_SYS_PTRACE
to expose information about the process generating the event.

> > Obviously, I can check CAP_SYS_ADMIN on fanotify_init() and set the
> > FAN_UNPRIVILEDGED flag as an internal flag.
> >
> > The advantage of explicit FAN_UNPRIVILEDGED flag is that a privileged process
> > can create an unprivileged listener and pass the fd to another process.
> > Not a critical functionality at this point.
>
> I'd prefer to keep the flag internal if you're convinced we need one - but
> I'm not yet convinced we need even internal FAN_UNPRIVILEDGED flag because
> I don't think this will end up being a yes/no thing. I imagine that
> depending on exact process capabilities, different kinds of fanotify
> functionality will be allowed as I outlined in 2). So we'll be checking
> against current process capabilities at the time of action and not against
> some internal fanotify flag...

Fair enough. I take a swing at getting rid of the flag entirely.
It may take me a while though to context switch back to fanotify.

Thanks,
Amir.
