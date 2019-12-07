Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047AD115C3F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 13:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfLGMg4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Dec 2019 07:36:56 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53411 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfLGMg4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Dec 2019 07:36:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so10174988wmd.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 07 Dec 2019 04:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/1fo2XhdDa7x6BbsNYfcQbzULMVANVgDdDP9WFFVDPk=;
        b=ZdyR4hOVS/nOQLGESnGUTuKTNBY8KLCQqsXSOiwBNdbqtP5SxGahpLrAVaX9xGD+Nm
         matFluxcTlQz+NgeXu0A2v3Ir8cx43IB7YjIg9l7PGA1VWxo5Irg/ocuRsHi67okjh1s
         9sLV6zMV6WDIpZnhwY3cbZ0b/lwz6Lh6r0PfHv8gYEBHgKGYfPEC8T4T39+qgrs4Jou1
         oIj5R/hy6upXhU1nvK8pieu1jMQpdMar+RUuMUO0wIlTNBr4KJt89XLGWJF1Hcr2eEir
         p18qg7nwq73AZtqMpaawKG8Nj1aBnL8d61AN7ISIBHmFMVfvlrgoYXcRcF61XYNJw92d
         oyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/1fo2XhdDa7x6BbsNYfcQbzULMVANVgDdDP9WFFVDPk=;
        b=KSedyaMZJWcseb6gdP4HHn9U8padbqkNG0ld8OmBr7eQFeRw8N18AIsJs5f0glAmwn
         qpWIbKouE00fP7VtSeBTY1719HYOjvLEEzCSgvoCPYW/FRw0W+V5oclIECl0gaRwdutj
         nVAhIcHGk4u20e+rwccq3fLvxPSQ4XBqlROUYZCOHiRHbpDyZuiIQYKVYsyTN5QIoblw
         5a4zFglgzhxbMDxY1bpFDc3DnnOkVjqHV2CBO1Ut6m8onzdFquaanP8VwCuPJG1VJ7/G
         fJnUTiLkdDrP4XgNoSm7Wb5oJB3eCsalHecMNa83yqaJXdKSUYnIpwBlVefRZZ5HgwSX
         1sNA==
X-Gm-Message-State: APjAAAXuPRj6TUP8fKZsF6jOeBr3yATkqhvpeWsZZh3KJJ+48bbmEwZv
        tRKB6+zUr23cRdMu+mxrxTaej98Uh3Tk1eJdH1o=
X-Google-Smtp-Source: APXvYqxe9lPzHaGvUwPzBWHQmZnMkHN0Iyp0l2ZYpUQ0Z2ZhUOFA3iymPT+qm9kCXGtbgkOIo+HrdDkNQpnho0n5lVU=
X-Received: by 2002:a1c:23ca:: with SMTP id j193mr14712270wmj.83.1575722213054;
 Sat, 07 Dec 2019 04:36:53 -0800 (PST)
MIME-Version: 1.0
References: <CADKPpc2RuncyN+ZONkwBqtW7iBb5ep_3yQN7PKe7ASn8DpNvBw@mail.gmail.com>
 <CAOQ4uxiKqEq9ts4fEq_husQJpus29afVBMq8P1tkeQT-58RBFg@mail.gmail.com>
 <CADKPpc33UGcuRB9p64QoF8g88emqNQB=Z03f+OnK4MiCoeVZpg@mail.gmail.com> <20191204173455.GJ8206@quack2.suse.cz>
In-Reply-To: <20191204173455.GJ8206@quack2.suse.cz>
From:   Mo Re Ra <more7.rev@gmail.com>
Date:   Sat, 7 Dec 2019 16:06:41 +0330
Message-ID: <CADKPpc2EU6ijG=2bs6t8tXr32pB1ufBJCjEirPyoHdMtMr83hw@mail.gmail.com>
Subject: Re: File monitor problem
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Jan,

On Wed, Dec 4, 2019 at 9:04 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Mohammad,
>
> On Wed 04-12-19 17:54:48, Mo Re Ra wrote:
> > On Wed, Dec 4, 2019 at 4:23 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > On Wed, Dec 4, 2019 at 12:03 PM Mo Re Ra <more7.rev@gmail.com> wrote:
> > > > I don`t know if this is the correct place to express my issue or not.
> > > > I have a big problem. For my project, a Directory Monitor, I`ve
> > > > researched about dnotify, inotify and fanotify.
> > > > dnotify is the worst choice.
> > > > inotify is a good choice but has a problem. It does not work
> > > > recursively. When you implement this feature by inotify, you would
> > > > miss immediately events after subdir creation.
> > > > fanotify is the last choice. It has a big change since Kernel 5.1. But
> > > > It does not meet my requirement.
> > > >
> > > > I need to monitor a directory with CREATE, DELETE, MOVE_TO, MOVE_FROM
> > > > and CLOSE_WRITE events would be happened in its subdirectories.
> > > > Filename of the events happened on that (without any miss) is
> > > > mandatory for me.
> > > >
> > > > I`ve searched and found a contribution from @amiril73 which
> > > > unfortunately has not been merged. Here is the link:
> > > > https://github.com/amir73il/fsnotify-utils/issues/1
> > > >
> > > > I`d really appreciate it If you could resolve this issue.
> > > >
> > >
> > > Hi Mohammad,
> > >
> > > Thanks for taking an interest in fanotify.
> > >
> > > Can you please elaborate about why filename in events are mandatory
> > > for your application.
> > >
> > > Could your application use the FID in FAN_DELETE_SELF and
> > > FAN_MOVE_SELF events to act on file deletion/rename instead of filename
> > > information in FAN_DELETE/FAN_MOVED_xxx events?
> > >
> > > Will it help if you could get a FAN_CREATE_SELF event with FID information
> > > of created file?
> > >
> > > Note that it is NOT guarantied that your application will be able to resolve
> > > those FID to file path, for example if file was already deleted and no open
> > > handles for this file exist or if file has a hardlink, you may resolve the path
> > > of that hardlink instead.
> > >
> > > Jan,
> > >
> > > I remember we discussed the optional FAN_REPORT_FILENAME [1] and
> > > you had some reservations, but I am not sure how strong they were.
> > > Please refresh my memory.
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://github.com/amir73il/linux/commit/d3e2fec74f6814cecb91148e6b9984a56132590f
> >
>
> > Fanotify project had a big change since Kernel 5.1 but did not meet
> > some primiry needs.
> > For example in my application, I`m watching on a specific directory to
> > sync it (through a socket connection and considering some policies)
> > with a directory in a remote system which a user working on that. Some
> > subdirectoires may contain two milions of files or more. I need these
> > two directoires be synced completely as soon as possible without any
> > missed notification.
> > So, I need a syscall with complete set of flags to help to watch on a
> > directory and all of its subdirectories recuresively without any
> > missed notification.
> >
> > Unfortuantely, in current version of Fanotify, the notification just
> > expresses a change has been occured in a directory but dot not
> > specifiy which file! I could not iterate over millions of file to
> > determine which file was that. That would not be helpful.
>
> The problem is there's no better reliable way. For example even if fanotify
> event provided a name as in the Amir's commit you reference, this name is
> not very useful. Because by the time your application gets to processing
> that fanotify event, the file under that name need not exist anymore, or
> there may be a different file under that name already. That is my main
> objection to providing file names with fanotify events - they are not
> reliable but they are reliable enough that application developers will use
> them as a reliable thing which then leads to hard to debug bugs. Also
> fanotify was never designed to guarantee event ordering so it is impossible
> to reconstruct exact state of a directory in userspace just by knowing some
> past directory state and then "replaying" changes as reported by fanotify.
>
> I could imagine fanotify events would provide FID information of the target
> file e.g. on create so you could then use that with open_by_handle() to
> open the file and get reliable access to file data (provided the file still
> exists). However there still remains the problem that you don't know the
> file name and the problem that directory changes while you are looking...
>
> So changing fanotify to suit your usecase requires more than a small tweak.
>
> For what you want, it seems e.g. btrfs send-receive functionality will
> provide what you need but then that's bound to a particular filesystem.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

I understand your concerns about reliablity. But I think functionality
and reliablity are two different things in this case. We`d better
entrust the reliability to the user.
Consider a user just want monitor all of filesystem changes but does
not intend to do anything according the received notifications.
I think we do not make decision for users by restricting them and
ignoring their necessary demands. We shuold introduce the best
available tools with all of concerns about them (which are
documented). So, we would put the user in charge of organizing his
projects. The user may care or not according his demands.
To sum up, I think Fanotify is the best available tools. But we are
really looking forward to addressing the mentioned concerns or
introducing a better alternative.

Thanks,
Mohammad Reza.
