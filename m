Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248763986C8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 12:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFBKqS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbhFBKqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:46:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4BCC06174A
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:44:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id z26so1856662pfj.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 03:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1nhFQzdyGtRCtTrdVrfxKgFfLCRGZl1tkaEAGoLBLh8=;
        b=NHDIc2a2wq3mhoG0vG0Uj0HS84Wlsd8JtmP9oYPi63k8Ia+blmDhe/CHfd0JoQDqWV
         zJ1CJRaIWPzI0vfp0HoWVJAbhI9EgRY8fi6x2svNuNQyMZKDw2VMbnM5k8980ngT5Ovb
         hQqp+UEMwVLiVpiODPBqzZM0SIUhTIZVCGDSZy2Jl3FZUr0lQQWuOOp0Q6G28FabDKpW
         p42b3IBiGMdPcqeYMVSCNNHzmGtRkKw+fN5QOm/Fs49ZUVK8yJUHPY6DwJ/SbrS0GcoN
         2tjXabDOlU53S2DO+nrx9p0sVuOk/sSvkhgsDCPXValuRqcfHYuAmNOH2MGgZZPcC+BY
         tH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1nhFQzdyGtRCtTrdVrfxKgFfLCRGZl1tkaEAGoLBLh8=;
        b=ZUww+3q8zc3r6CmdeRf2batYqMgQvq8Q6p1+4aOWZ3Cxth0Oc/gSqjsBX1arHskHPK
         pJK/dmspVzUwuBXjNUs8rRqPQx0iWBVaDBnuSMSpTfK8FKLUTz4IVpUULXH59JFBRWpA
         pkpA74MfRY8UVNIAswsU0uu2hGwD4TxyuZzAd4LVSyR7kAjp3uQ2RxbRE69R072ryKCZ
         OGkxnKlLOrylXnhkOrT/Zv1QbOBaKOQJIb1lX3qWpRxaHCLbtkJVLUaFbfPzM1OnjGO3
         ahmjswIY6UZAiuCxxhdHLtZkBibv6fS7RSTPcCxoKIZihYMSNB/Nslgy9BpsAqT9bM23
         zURQ==
X-Gm-Message-State: AOAM530k/WJsXnQ/0ObvJPG6nxH7H9Snn5aBkLSrA60q7juk8UhnvJW2
        8a2sGq5ZMvj7KU12t2HPyNE3sQ==
X-Google-Smtp-Source: ABdhPJyaeEw0wo7Aj5AN9AsBdx6Ib1t/izxQCE7GC/UR+PxunhY+jeXDyTqdqK6CM2UnRJYPMGsrhw==
X-Received: by 2002:a05:6a00:882:b029:24b:afda:acfa with SMTP id q2-20020a056a000882b029024bafdaacfamr26823969pfj.72.1622630658141;
        Wed, 02 Jun 2021 03:44:18 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3f5b:c29c:c9af:dde7])
        by smtp.gmail.com with ESMTPSA id m134sm4471360pfd.148.2021.06.02.03.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:44:17 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:43:59 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YLdg7wWQ/GTbe1eh@google.com>
References: <20210521104056.GG18952@quack2.suse.cz>
 <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com>
 <20210526180529.egrtfruccbioe7az@wittgenstein>
 <YLYT/oeBCcnbfMzE@google.com>
 <20210601114628.f3w33yyca5twgfho@wittgenstein>
 <YLcliQRh4HRGt4Mi@google.com>
 <CAOQ4uxieRQ3s5rWA55ZBDr4xm6i9vXyWx-iErMgYzGCE5nYKcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxieRQ3s5rWA55ZBDr4xm6i9vXyWx-iErMgYzGCE5nYKcA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:18:36AM +0300, Amir Goldstein wrote:
> On Wed, Jun 2, 2021 at 9:30 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > On Tue, Jun 01, 2021 at 01:46:28PM +0200, Christian Brauner wrote:
> > > On Tue, Jun 01, 2021 at 09:03:26PM +1000, Matthew Bobrowski wrote:
> > > > On Wed, May 26, 2021 at 08:05:29PM +0200, Christian Brauner wrote:
> > > > > On Wed, May 26, 2021 at 09:20:55AM +1000, Matthew Bobrowski wrote:
> > > > > > On Tue, May 25, 2021 at 12:31:33PM +0200, Christian Brauner wrote:
> > > > > > > On Mon, May 24, 2021 at 10:47:46AM +0200, Jan Kara wrote:
> > > > > > > > On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> > > > > > > > > On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > > > > > > > > > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > > > > > > > > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > > > > > > > > > There's one thing that I'd like to mention, and it's something in
> > > > > > > > > > > regards to the overall approach we've taken that I'm not particularly
> > > > > > > > > > > happy about and I'd like to hear all your thoughts. Basically, with
> > > > > > > > > > > this approach the pidfd creation is done only once an event has been
> > > > > > > > > > > queued and the notification worker wakes up and picks up the event
> > > > > > > > > > > from the queue processes it. There's a subtle latency introduced when
> > > > > > > > > > > taking such an approach which at times leads to pidfd creation
> > > > > > > > > > > failures. As in, by the time pidfd_create() is called the struct pid
> > > > > > > > > > > has already been reaped, which then results in FAN_NOPIDFD being
> > > > > > > > > > > returned in the pidfd info record.
> > > > > > > > > > >
> > > > > > > > > > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > > > > > > > > > creation earlier on i.e. in the event allocation stages? This way, the
> > > > > > > > > > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > > > > > > > > > returned in the pidfd info record because the struct pid has been
> > > > > > > > > > > already reaped, userspace application will atleast receive a valid
> > > > > > > > > > > pidfd which can be used to check whether the process still exists or
> > > > > > > > > > > not. I think it'll just set the expectation better from an API
> > > > > > > > > > > perspective.
> > > > > > > > > >
> > > > > > > > > > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > > > > > > > > > be sure the original process doesn't exist anymore. So is it useful to
> > > > > > > > > > still receive pidfd of the dead process?
> > > > > > > > >
> > > > > > > > > Well, you're absolutely right. However, FWIW I was approaching this
> > > > > > > > > from two different angles:
> > > > > > > > >
> > > > > > > > > 1) I wanted to keep the pattern in which the listener checks for the
> > > > > > > > >    existence/recycling of the process consistent. As in, the listener
> > > > > > > > >    would receive the pidfd, then send the pidfd a signal via
> > > > > > > > >    pidfd_send_signal() and check for -ESRCH which clearly indicates
> > > > > > > > >    that the target process has terminated.
> > > > > > > > >
> > > > > > > > > 2) I didn't want to mask failed pidfd creation because of early
> > > > > > > > >    process termination and other possible failures behind a single
> > > > > > > > >    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
> > > > > > > > >    listener can take clear corrective branches as what's to be done
> > > > > > > > >    next if a race is to have been detected, whereas simply returning
> > > > > > > > >    FAN_NOPIDFD at this stage can mean multiple things.
> > > > > > > > >
> > > > > > > > > Now that I've written the above and keeping in mind that we'd like to
> > > > > > > > > refrain from doing anything in the event allocation stages, perhaps we
> > > > > > > > > could introduce a different error code for detecting early process
> > > > > > > > > termination while attempting to construct the info record. WDYT?
> > > > > > > >
> > > > > > > > Sure, I wouldn't like to overengineer it but having one special fd value for
> > > > > > > > "process doesn't exist anymore" and another for general "creating pidfd
> > > > > > > > failed" looks OK to me.
> > > > > > >
> > > > > > > FAN_EPIDFD -> "creation failed"
> > > > > > > FAN_NOPIDFD -> "no such process"
> > > > > >
> > > > > > Yes, I was thinking something along the lines of this...
> > > > > >
> > > > > > With the approach that I've proposed in this series, the pidfd
> > > > > > creation failure trips up in pidfd_create() at the following
> > > > > > condition:
> > > > > >
> > > > > >         if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > > > > >                  return -EINVAL;
> > > > > >
> > > > > > Specifically, the following check:
> > > > > >         !pid_has_task(pid, PIDTYPE_TGID)
> > > > > >
> > > > > > In order to properly report either FAN_NOPIDFD/FAN_EPIDFD to
> > > > > > userspace, AFAIK I'll have to do one of either two things to better
> > > > > > distinguish between why the pidfd creation had failed:
> > > > >
> > > > > Ok, I see. You already do have a reference to a struct pid and in that
> > > > > case we should just always return a pidfd to the caller. For
> > > > > pidfd_open() for example we only report an error when
> > > > > find_get_pid(<pidnr>) doesn't find a struct pid to refer to. But in your
> > > > > case here you already have a struct pid so I think we should just keep
> > > > > this simple and always return a pidfd to the caller and in fact do
> > > > > burden them with figuring out that the process is gone via
> > > > > pidfd_send_signal() instead of complicating our lives here.
> > > >
> > > > Ah, actually Christian... Before, I go ahead and send through the updated
> > > > series. Given what you've mentioned above I'm working with the assumption
> > > > that you're OK with dropping the pid_has_task() check from pidfd_create()
> > > > [0]. Is that right?
> > > >
> > > > If so, I don't know how I feel about this given that pidfd_create() is now
> > > > to be exposed to the rest of the kernel and the pidfd API, as it stands,
> > > > doesn't support the creation of pidfds for non-thread-group leaders. I
> > > > suppose what I don't want is other kernel subsystems, if any, thinking it's
> > > > OK to call pidfd_create() with an arbitrary struct pid and setting the
> > > > expectation that a fully functional pidfd will be returned.
> > > >
> > > > The way I see it, I think we've got two options here:
> > > >
> > > > 1) Leave the pid_has_task() check within pidfd_create() and perform another
> > > >    explicit pid_has_task() check from the fanotify code before calling
> > > >    pidfd_create(). If it returns false, we set something like FAN_NOPIDFD
> > > >    indicating to userspace that there's no such process when the event was
> > > >    created.
> > > >
> > > > 2) Scrap using pidfd_create() all together and implement a fanotify
> > > >    specific pidfd creation wrapper which would allow for more
> > > >    control. Something along the lines of what you've done in kernel/fork.c
> > > >    [1]. Not the biggest fan of this idea just yet given the possibility of
> > > >    it leading to an API drift over time.
> > > >
> > > > WDYT?
> > >
> > > Hm, why would you have to drop the pid_has_task() check again?
> >
> > Because of the race that I brielfy decscribed here [0]. The race exists
> 
> Sorry for being thich.

You're not being thick at all Amir, and perhaps this is my fault for not
articulating the problem at hand correctly.

> I still don't understand what's racy about this. Won't the event reader
> get a valid pidfd?

I guess this depends, right?

As the logic/implementation currently stands in this specific patch series,
pidfd_create() will _NOT_ return a valid pidfd unless the struct pid still
holds reference to a task of type PIDTYPE_TGID. This is thanks to the extra
pid_hash_task() check that I thought was appropriate to incorporate into
pidfd_create() seeing as though:

 - With the pidfd_create() declaration now being added to linux/pid.h, we
   effectively are giving the implicit OK for it to be called from other
   kernel subsystems, and hence why the caller should be subject to the
   same restrictions/verifications imposed by the API specification
   i.e. "Currently, the process identified by @pid must be a thread-group
   leader...". Not enforcing the pid_has_task() check in pidfd_create()
   effectively says that the pidfd creation can be done for any struct pid
   types i.e. PIDTYPE_PID, PIDTYPE_PGID, etc. This leads to assumptions
   being made by the callers, which effectively then could lead to
   undefined/unexpected behavior.

There definitely can be cases whereby the underlying task(s) associated
with a struct pid have been freed as a result of process being killed
early. As in, the process is killed before the pid_has_task() check is
performed from within pidfd_create() when called from fanotify. This is
precisely the race that I'm referring to here, and in such cases as the
code currently stands, the event listener will _NOT_ receive a valid pidfd.

> Can't the event reader verify that the pidfd points to a dead process?

This was the idea, as in, the burden of checking whether a process has been
killed before the event listener receives the event should be on the event
listener. However, we're trying to come up with a good way to effectively
communicate that the above race I've attempted to articulate has actually
occurred. As in, do we:

a) Drop the pid_has_task() check in pidfd_create() so that a pidfd can be
   returned for all passed struct pids? That way, even if the above race is
   experienced the caller will still receive a pidfd and the event listener
   can do whatever it needs to with it.

b) Before calling into pidfd_create(), perform an explicit pid_has_task()
   check for PIDTYPE_TGID and if that returns false, then set FAN_NOPIDFD
   and save ourselves from calling into pidfd_create() all together. The
   event listener in this case doesn't have to perform the signal check to
   determine whether the process has already been killed.

c) Scrap calling into pidfd_create() all together and write a simple
   fanotify wrapper that contains the pidfd creation logic we need.

> I don't mind returning FAN_NOPIDFD for convenience, but user
> will have to check the pidfd that it got anyway, because process
> can die at any time between reading the event and acting on the
> pidfd.

Well sort of, as it depends on the approach that we decide to go ahead with
to report such early process termination cases. If we return FAN_NOPIDFD,
which signifies that the process died before a pidfd could be created, then
there's no point for the listener to step into checking the pidfd because
the pidfd already == FAN_NOPIDFD. If we simply return a pidfd regardless of
the early termination of the process, then sure the event listener will
need to check each pidfd that is supplied.

> > because we perform the pidfd creation during the notification queue
> > processing and not in the event allocation stages (for reasons that Jan has
> > already covered here [1]). So, tl;dr there is the case where the fanotify
> > calls pidfd_create() and the check for pid_has_task() fails because the
> > struct pid that we're hanging onto within an event no longer contains a
> > task of type PIDTYPE_TGID...
> >
> > [0] https://www.spinics.net/lists/linux-api/msg48630.html
> > [1] https://www.spinics.net/lists/linux-api/msg48632.html

Maybe I'm going down a rabbit hole and overthinking this whole thing,
IDK... :(

/M
