Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672BF3D6FDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jul 2021 09:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbhG0HDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jul 2021 03:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbhG0HDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jul 2021 03:03:31 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D24C061757;
        Tue, 27 Jul 2021 00:03:32 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id o7so10025105ilh.11;
        Tue, 27 Jul 2021 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sni40V2XRCYvwaTXsgLttxO1MBzdLhmOD1xNruXMr9w=;
        b=TBGt4yyepPyz2WuB3J6F8WDvsSKppxYm3vtF6VlEg9SriP5SblffKJEouCLXpNMRQG
         wVT3AVQAu8P9ZxJjyzyTb0pHhYzgqsErVHV5HQ+Zi1QdOsnXlSyEkmdjtR196IoCAeUA
         3fep1jCn8d7c0GWLOGhq0WWlNULkvyj1odNSqqtv7t0J1Dbn6toihk3J6Aw8+kjV3TdZ
         V57e8LMq7kI0+UJ46P+4dx0M2lW+c1YpcMYR5XfMyl3Im0yUyLXIDoRiub7MqpnZnLRC
         rjWpM8+Vjo1UDgCj8KBQO38g5gVxShAVk4a8esL2T7JWvwleZOfhpzKva/A2FKuAFRqs
         1zNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sni40V2XRCYvwaTXsgLttxO1MBzdLhmOD1xNruXMr9w=;
        b=Idy65eUc8fH8OVVrZlUbbToD6hP4vMULNDr1wFqefEfXWQ5+2/gfXcYC96C1y0yslx
         CkoivBqB6f6yMeDWI/sLnMX5ja4vx2Dt93z6iP+zRjA2xPYBgSsylenc/cnDMgkwbKhE
         7dLqOHP2zkS0t/MBGPvKlqs8R87JF8s5qOYPDADAUUQOs62rcih+ch/7gLHSoT5rrOTQ
         PKaKPJ3X6it4ts9Q4GPCUyPWS7SUrP0le1xwf7btI0QymdQLvQL/q5fLGl+HmukayiKX
         7LBZpGgIEhLGgAYvxZ9hwL34b7mXxYlD5iSowmh0DSpkKX58elZGDS5Qto8gtzFUf6oa
         cuhA==
X-Gm-Message-State: AOAM530AC2hV5vbBg3yJvf+cmtekqdKSeYZKpVcC+wEVqmA3GRLyBnm9
        W8rUyN1CaOJhMYgmPtNArhQYjc7ZCjM47sO3cBo=
X-Google-Smtp-Source: ABdhPJzwFOKexATgjcUHgpepEbksbVgc1+WfGtf+xxjHcRzsb9MYrxsGL7KGuOrGu9MxylaFIqYRIDjYWvHNGvlNCSI=
X-Received: by 2002:a05:6e02:d93:: with SMTP id i19mr15270048ilj.72.1627369411732;
 Tue, 27 Jul 2021 00:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626845287.git.repnop@google.com> <02ba3581fee21c34bd986e093d9eb0b9897fa741.1626845288.git.repnop@google.com>
 <CAG48ez3MsFPn6TsJz75hvikgyxG5YGyT2gdoFwZuvKut4Xms1g@mail.gmail.com>
 <CAOQ4uxhDkAmqkxT668sGD8gHcssGTeJ3o6kzzz3=0geJvfAjdg@mail.gmail.com> <YP+VNZt2y+jP3BNR@google.com>
In-Reply-To: <YP+VNZt2y+jP3BNR@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 27 Jul 2021 10:03:20 +0300
Message-ID: <CAOQ4uxgD3xBzffqtRx-UPbj1wHoi2TXZoWx3DKyknUHspevP1w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] fanotify: add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 27, 2021 at 8:10 AM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Tue, Jul 27, 2021 at 07:19:43AM +0300, Amir Goldstein wrote:
> > On Tue, Jul 27, 2021 at 3:24 AM Jann Horn <jannh@google.com> wrote:
> > >
> > > On Wed, Jul 21, 2021 at 8:21 AM Matthew Bobrowski <repnop@google.com> wrote:
> > > > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > > > allows userspace applications to control whether a pidfd info record
> > > > containing a pidfd is to be returned with each event.
> > > >
> > > > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > > > struct fanotify_event_info_pidfd object will be supplied alongside the
> > > > generic struct fanotify_event_metadata within a single event. This
> > > > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > > > the event structure is supplied to the userspace application. Usage of
> > > > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > > > permitted, and in this case a struct fanotify_event_info_pidfd object
> > > > will follow any struct fanotify_event_info_fid object.
> > > >
> > > > Currently, the usage of FAN_REPORT_TID is not permitted along with
> > > > FAN_REPORT_PIDFD as the pidfd API only supports the creation of pidfds
> > > > for thread-group leaders. Additionally, the FAN_REPORT_PIDFD is
> > > > limited to privileged processes only i.e. listeners that are running
> > > > with the CAP_SYS_ADMIN capability. Attempting to supply either of
> > > > these initialization flags with FAN_REPORT_PIDFD will result with
> > > > EINVAL being returned to the caller.
> > > >
> > > > In the event of a pidfd creation error, there are two types of error
> > > > values that can be reported back to the listener. There is
> > > > FAN_NOPIDFD, which will be reported in cases where the process
> > > > responsible for generating the event has terminated prior to fanotify
> > > > being able to create pidfd for event->pid via pidfd_create(). The
> > > > there is FAN_EPIDFD, which will be reported if a more generic pidfd
> > > > creation error occurred when calling pidfd_create().
> > > [...]
> > > > @@ -524,6 +562,34 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> > > >         }
> > > >         metadata.fd = fd;
> > > >
> > > > +       if (pidfd_mode) {
> > > > +               /*
> > > > +                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mutual
> > > > +                * exclusion is ever lifted. At the time of incoporating pidfd
> > > > +                * support within fanotify, the pidfd API only supported the
> > > > +                * creation of pidfds for thread-group leaders.
> > > > +                */
> > > > +               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> > > > +
> > > > +               /*
> > > > +                * The PIDTYPE_TGID check for an event->pid is performed
> > > > +                * preemptively in attempt to catch those rare instances where
> > > > +                * the process responsible for generating the event has
> > > > +                * terminated prior to calling into pidfd_create() and acquiring
> > > > +                * a valid pidfd. Report FAN_NOPIDFD to the listener in those
> > > > +                * cases. All other pidfd creation errors are represented as
> > > > +                * FAN_EPIDFD.
> > > > +                */
> > > > +               if (metadata.pid == 0 ||
> > > > +                   !pid_has_task(event->pid, PIDTYPE_TGID)) {
> > > > +                       pidfd = FAN_NOPIDFD;
> > > > +               } else {
> > > > +                       pidfd = pidfd_create(event->pid, 0);
> > > > +                       if (pidfd < 0)
> > > > +                               pidfd = FAN_EPIDFD;
> > > > +               }
> > > > +       }
> > > > +
> > >
> > > As a general rule, f_op->read callbacks aren't allowed to mess with
> > > the file descriptor table of the calling process. A process should be
> > > able to receive a file descriptor from an untrusted source and call
> > > functions like read() on it without worrying about affecting its own
> > > file descriptor table state with that.
> > >
> >
> > Interesting. I've never considered this interface flaw.
> > Thanks for bringing this up!
> >
> > > I realize that existing fanotify code appears to be violating that
> > > rule already, and that you're limiting creation of fanotify file
> > > descriptors that can hit this codepath to CAP_SYS_ADMIN, but still, I
> > > think fanotify_read() probably ought to be an ioctl, or something
> > > along those lines, instead of an f_op->read handler if it messes with
> > > the caller's fd table?
> >
> > Naturally, we cannot change the legacy interface.
> > However, since fanotify has a modern FAN_REPORT_FID interface
> > which does not mess with fd table maybe this is an opportunity not
> > to repeat the same mistake for the FAN_REPORT_FID interface.
>
> You mean the FAN_REPORT_PIDFD interface, right?

No, I mean FAN_REPORT_FID.
We have a new interface that does not pollute reader process fd table
with fds of event->fd, so maybe let's try to avoiding regressing this
use case by polluting the reader process fd table with pidfds.

>
> > Matthew, can you explain what is the use case of the consumer
> > application of pidfd. I am guessing this is for an audit user case?
> > because if it were for permission events, event->pid would have been
> > sufficient.
>
> Yes, the primary use case would be for reliable auditing i.e. what actual
> process had accessed what filesystem object of interest. Generally, finding
> what process is a little unreliable at the moment given that the reporting
> event->pid and crawling through /proc based on that has been observed to
> lead to certain inaccuracy in the past i.e. reporting an access that was in
> fact not performed by event->pid.
>
> The permission model doesn't work in this case given that it takes the
> "blocking" approach and not it's not something that can always be
> afforded...
>
> > If that is the case, then I presume that the application does not really
> > need to operate on the pidfd, it only need to avoid reporting wrong
> > process details after pid wraparound?
>
> The idea is that the event listener, or receiver will use the
> pidfd_send_signal(2) and specify event->info->pidfd as one of its arguments
> in order to _reliably_ determine whether the process that generated the
> event is still around. If so, it can freely ascertain further contextual
> information from /proc reliably.
>
> > If that is the case, then maybe a model similar to inode generation
> > can be used to report a "pid generation" in addition to event->pid
> > and export pid generation in /proc/<pid>/stat
>
> TBH, I don't fully understand what you mean by this model...
>

The model is this:

FAN_REPORT_UPID (or something) will report an info record
with a unique identifier of the generating process or thread, because
there is no restriction imposed by pidfd to support only group leaders.

That unique identifier may be obtained from /proc, e.g.:
$ cat /proc/self/upid
633733.0

In this case .0 represents generation 0.
If pid numbers would wrap around in that pid namespace
generation would be bumped and next process to get pid
633733 would have a unique id 633733.1.

There are probably more pid namespace considerations of how
that /proc API will be designed exactly.

IIUC the process generation needs to be stored in struct upid,
because generation is per pid namespace.

Essentially, that is the same concept embodied by FAN_REPORT_FID -
fanotify makes a record of the inode unique identifier and does not keep
any live references on the inode.

The event reader is able to perform a check to determine if the event
happened on the inode in question or not by comparing the FID reported
in the event with the FID that the listener obtains from the suscept target
inode.

Thanks,
Amir.
