Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F29119270
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 21:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfLJUuC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 15:50:02 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42277 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbfLJUuB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:50:01 -0500
Received: by mail-yw1-f66.google.com with SMTP id w11so7856242ywj.9
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Dec 2019 12:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ttORR/hku84+ocdcb8LP7T5MA+wBluhwAjwe/+PVW2c=;
        b=QlHaQAmfMhcVztkMqGdJoElVmhWdJ/HXs0gGoStZfTeahSlSh4DCumQ+rfJpeVQVxq
         8r7weFQEqxCg8rSAGS6gvObOoMn3tJ5Nivk/PvXfgQ5KGVANpfK8/FfmvYpEweZ2wd7/
         BcJ7e/crUw35/smFvkbpmJmZkT5Vpbzk7x/BLV492YtcbLz7PXnwT111sci5PyrEI2Cr
         pDrKxclUyrqTwLQ3MTvAqgOoClnCYkO1Brn2mThut+CnCzI/VRv6BlyeVNklvyGUAwz/
         Ln5y9oU1GnTgWmKFQYF0djTn4Zu8JIR8He+u04U/F6N8/NWUuyCzazhxGWPoxBSguMiZ
         Pppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ttORR/hku84+ocdcb8LP7T5MA+wBluhwAjwe/+PVW2c=;
        b=e5ZDKxf3njD81jXqFhsj8TT8Hj2MDFdJzo1PlEiPHtWAhJUD9QPyJUZ9+g/gi++gXk
         3i7TBK+B3NmSKvOd+TPr0kXW2Me20PP7HuK18RB10jGDsrOZHhSRIidaLlBSGZ1GKBC8
         KYK15BzJormIctUCziTyXNXIQ0KSRsprYRxcxETu1GlZ5vPX0Bm4wwLbIfDZJaY/YCAa
         xuCCO6UHf9/q5U815ZmeVWahwzYM+uL/RYXoSdUSCCR+dKgmp/b4PugKhT3fwGn0nhxh
         +j4A2x8de6fRLHvZpHB1qBy8BRs5Ws1qZ2TobgOHK+bZCjIU2O//+TZFW0sRhmfkzRTj
         aiCg==
X-Gm-Message-State: APjAAAVKiJS9MANF76+Xk0jomila/mSFRtYBEZ+t7yXWm3KZOTBjwOyH
        NRQaYNott2jlq1IIbksQxdZrzYE2HfzGulIguiPTQuiM
X-Google-Smtp-Source: APXvYqzGbdPbrp9lHD6vbLHYy9z84SuB9pnO7EqDE2KHAD3ZKjZokTIMpSR0uWtXawl9v/U5KJiGne1exuv8Mkwu1VY=
X-Received: by 2002:a81:598b:: with SMTP id n133mr17348086ywb.379.1576011000244;
 Tue, 10 Dec 2019 12:50:00 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com>
 <20191204173455.GJ8206@quack2.suse.cz> <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
 <20191210165538.GK1551@quack2.suse.cz>
In-Reply-To: <20191210165538.GK1551@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 10 Dec 2019 22:49:49 +0200
Message-ID: <CAOQ4uximwdf37JdVVfHuM_bxk=X7pz21hnT3thk01oDs_npfhw@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Mo Re Ra <more7.rev@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Wez Furlong <wez@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc: Watchman maintainer]

> > > I could imagine fanotify events would provide FID information of the target
> > > file e.g. on create so you could then use that with open_by_handle() to
> > > open the file and get reliable access to file data (provided the file still
> > > exists). However there still remains the problem that you don't know the
> > > file name and the problem that directory changes while you are looking...
> > >
> > > So changing fanotify to suit your usecase requires more than a small tweak.
> > >
> > > For what you want, it seems e.g. btrfs send-receive functionality will
> > > provide what you need but then that's bound to a particular filesystem.
> > >
> > >                                                                 Honza
> > > --
> > > Jan Kara <jack@suse.com>
> > > SUSE Labs, CR
> >
> > I understand your concerns about reliablity. But I think functionality
> > and reliablity are two different things in this case. We`d better
> > entrust the reliability to the user.
> > Consider a user just want monitor all of filesystem changes but does
> > not intend to do anything according the received notifications.
> > I think we do not make decision for users by restricting them and
> > ignoring their necessary demands. We shuold introduce the best
> > available tools with all of concerns about them (which are
> > documented). So, we would put the user in charge of organizing his
> > projects. The user may care or not according his demands.
>
> I disgree. This is not how API design works in the Linux kernel. First, you
> have to have a good and sound use case for the functionality (and I
> understand and acknowledge your need to monitor a large directory and
> reliably synchronize changes to another place) and then we try to implement
> API that would fulfil the needs of the usecase.

For the record, although I am the author of filename patches and represent
users that use them, I myself am not fully convinced that we need to
extend the API much further. For the past few months, I have been trying
to convert our in-house filesystem monitor to work without filename in events.
I haven't yet been able to prove (for performance of all interesting workloads)
that more information in events is not needed, but haven't been able to prove
that it is not needed either. CREATE_SELF events are needed for functionality.

I have also been looking at other filesystem monitor implementations to
see if they could be converted to fanotify without any extra information
in events. I mostly focused on Watchman, which looks like the most
promising open source filesystem monitor implementation around.
It was hard for me to figure out myself if Watchman can benefit from
new fanotify API and what it is missing from the new API.

I have already implemented unprivileged fanotify (this was posted
first even before FAN_REPORT_FID), but looking for a way to demo
its usefulness - how it can avoid races compared to inotify.

One way I am considering to tackle the missing information is to
provide  unprivileged access to open_by_handle_at(2) -
Currently, this syscall requires CAP_DAC_READ_SEARCH, because
it can open files without having search access to ancestor directories.

My idea is that if process has no CAP_DAC_READ_SEARCH, then
mountfd argument will be assumed to be the direct parent of the file.
Search access will be verified on mountfd and then a restrictive
acceptable() callback will make sure that only dentry whose parent
is mountfd is decoded. Alternatively a new syscall could be used.

A special variant of exportfs_decode_fh() would be used that take
the parent as argument instead of getting parent from
s_export_op->fh_to_parent() or s_export_op->get_parent().

The end result would be that events could report parent fid and child fid.
If monitor application is watching a single directory or has a map of watched
directories (like inotifywatch does), then child could be found by handle -
as long as the file is still inside the watched directory. If there is a single
hardlink in the directory, the child name would be non ambiguous.

Child fid with FAN_DELETE/FAN_MOVE_FROM would only be useful
if monitor application keeps a map of the files in every watched directory
(I believe Watchman does anyway).

Jan, does that sound like something that would address your concerns?

Does that sound like and API that would provide an added value to users?

Am I missing anything?

Thanks,
Amir.
