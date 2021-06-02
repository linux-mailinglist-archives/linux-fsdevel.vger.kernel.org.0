Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E2B398779
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 12:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhFBLAB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 07:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbhFBK7X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:59:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE66C061763
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Jun 2021 03:57:07 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 6so1917725pgk.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 03:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lmmH1YVsApD8IrCpjCu8hFSwfXjpWeiwJFBuGtREMK4=;
        b=BeOZ3w26TPzdY4CTOyNmns3AO50CXYoArnETG1mx583Zjs2bsVo725nZxsTgDE85Uu
         eJvRg1pukUOijvNcIBkWbMSLTbBIriaNCtPeJyhrvbK6TCsYGuAZ+8ChvpEGk7dK0dPA
         bhCSVxVb7yBdaQbMv55BTwmGdl70mjmD0886hqiSuiLS8tDKE5qknFjjAALvLa7bGQkp
         d2O8TVu/sh7lZJzVLzXXSDF5lJ8yxSVpVG3HViabIOmAFUMELYGCxzhPcvfJDxICtza+
         qqbP7Rnbhz/dxi+2YWMjokd44gzDpBQmysQls4+gnk5FSme8fuENvCXKw9MvMv916HQ3
         q2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lmmH1YVsApD8IrCpjCu8hFSwfXjpWeiwJFBuGtREMK4=;
        b=dB8l2jggkHxia4WaHW7rbD7K/pwRNxzMrwHyQqd/sgKE5heruuhpFHw19qk2bP3QOC
         Mi9hnjH2pXasL/i5REc5OalbiciOPhQ/QF0wGpSkC+2LdrRBj2JloLPy9n8jTU85MpOd
         qrqCULuTbFDzNI271pkvxrIPLzqwJy3fRPRcK0xSwgDXCDoyGRDgwdTM5K9G2qxEnGkr
         iVsY4+c5k6aQ2k6C4T0Ht59s7awkN1YGmwSaKqFCmvVBkh93tKMZuPE6SWfTTABe7+VG
         XUeH56gbOkj/qmM5fAEjvtoX/ULAA0Nrs8ZL4IJZzh55562yjx3xsee2y/0H1t8HvHkv
         Sqdw==
X-Gm-Message-State: AOAM530k3fF7ncAN5HyRxjAJJP2X1LylsCz4U8BvRNLvF47zhvrKPF0X
        uhGOw1eV+H4nN18Z1IWxitJRYw==
X-Google-Smtp-Source: ABdhPJzoEBoBeFtpKM/xpZQ4NR5Kyyy9vGra6iX/1FVqD6BMj4bgXPYlPdQL4hl9LKeRIUZkr0diQg==
X-Received: by 2002:a65:6899:: with SMTP id e25mr16811516pgt.393.1622631427191;
        Wed, 02 Jun 2021 03:57:07 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3f5b:c29c:c9af:dde7])
        by smtp.gmail.com with ESMTPSA id ft19sm4612193pjb.48.2021.06.02.03.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 03:57:06 -0700 (PDT)
Date:   Wed, 2 Jun 2021 20:56:54 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YLdj9pk4Jpz1qqVl@google.com>
References: <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com>
 <20210526180529.egrtfruccbioe7az@wittgenstein>
 <YLYT/oeBCcnbfMzE@google.com>
 <20210601114628.f3w33yyca5twgfho@wittgenstein>
 <YLcliQRh4HRGt4Mi@google.com>
 <CAOQ4uxieRQ3s5rWA55ZBDr4xm6i9vXyWx-iErMgYzGCE5nYKcA@mail.gmail.com>
 <20210602084854.sokpeqr2wgz7ci4a@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602084854.sokpeqr2wgz7ci4a@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 10:48:54AM +0200, Christian Brauner wrote:
> On Wed, Jun 02, 2021 at 10:18:36AM +0300, Amir Goldstein wrote:
> > On Wed, Jun 2, 2021 at 9:30 AM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > On Tue, Jun 01, 2021 at 01:46:28PM +0200, Christian Brauner wrote:
> > > > On Tue, Jun 01, 2021 at 09:03:26PM +1000, Matthew Bobrowski wrote:
> > > > > On Wed, May 26, 2021 at 08:05:29PM +0200, Christian Brauner wrote:
> > > > > > On Wed, May 26, 2021 at 09:20:55AM +1000, Matthew Bobrowski wrote:
> > > > > > > On Tue, May 25, 2021 at 12:31:33PM +0200, Christian Brauner wrote:
> > > > > > > > On Mon, May 24, 2021 at 10:47:46AM +0200, Jan Kara wrote:
> > > > > > > > > On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> > > > > > > > > > On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > > > > > > > > > > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > > > > > > > > > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > > > > > > > > > > There's one thing that I'd like to mention, and it's something in
> > > > > > > > > > > > regards to the overall approach we've taken that I'm not particularly
> > > > > > > > > > > > happy about and I'd like to hear all your thoughts. Basically, with
> > > > > > > > > > > > this approach the pidfd creation is done only once an event has been
> > > > > > > > > > > > queued and the notification worker wakes up and picks up the event
> > > > > > > > > > > > from the queue processes it. There's a subtle latency introduced when
> > > > > > > > > > > > taking such an approach which at times leads to pidfd creation
> > > > > > > > > > > > failures. As in, by the time pidfd_create() is called the struct pid
> > > > > > > > > > > > has already been reaped, which then results in FAN_NOPIDFD being
> > > > > > > > > > > > returned in the pidfd info record.
> > > > > > > > > > > >
> > > > > > > > > > > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > > > > > > > > > > creation earlier on i.e. in the event allocation stages? This way, the
> > > > > > > > > > > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > > > > > > > > > > returned in the pidfd info record because the struct pid has been
> > > > > > > > > > > > already reaped, userspace application will atleast receive a valid
> > > > > > > > > > > > pidfd which can be used to check whether the process still exists or
> > > > > > > > > > > > not. I think it'll just set the expectation better from an API
> > > > > > > > > > > > perspective.
> > > > > > > > > > >
> > > > > > > > > > > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > > > > > > > > > > be sure the original process doesn't exist anymore. So is it useful to
> > > > > > > > > > > still receive pidfd of the dead process?
> > > > > > > > > >
> > > > > > > > > > Well, you're absolutely right. However, FWIW I was approaching this
> > > > > > > > > > from two different angles:
> > > > > > > > > >
> > > > > > > > > > 1) I wanted to keep the pattern in which the listener checks for the
> > > > > > > > > >    existence/recycling of the process consistent. As in, the listener
> > > > > > > > > >    would receive the pidfd, then send the pidfd a signal via
> > > > > > > > > >    pidfd_send_signal() and check for -ESRCH which clearly indicates
> > > > > > > > > >    that the target process has terminated.
> > > > > > > > > >
> > > > > > > > > > 2) I didn't want to mask failed pidfd creation because of early
> > > > > > > > > >    process termination and other possible failures behind a single
> > > > > > > > > >    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
> > > > > > > > > >    listener can take clear corrective branches as what's to be done
> > > > > > > > > >    next if a race is to have been detected, whereas simply returning
> > > > > > > > > >    FAN_NOPIDFD at this stage can mean multiple things.
> > > > > > > > > >
> > > > > > > > > > Now that I've written the above and keeping in mind that we'd like to
> > > > > > > > > > refrain from doing anything in the event allocation stages, perhaps we
> > > > > > > > > > could introduce a different error code for detecting early process
> > > > > > > > > > termination while attempting to construct the info record. WDYT?
> > > > > > > > >
> > > > > > > > > Sure, I wouldn't like to overengineer it but having one special fd value for
> > > > > > > > > "process doesn't exist anymore" and another for general "creating pidfd
> > > > > > > > > failed" looks OK to me.
> > > > > > > >
> > > > > > > > FAN_EPIDFD -> "creation failed"
> > > > > > > > FAN_NOPIDFD -> "no such process"
> > > > > > >
> > > > > > > Yes, I was thinking something along the lines of this...
> > > > > > >
> > > > > > > With the approach that I've proposed in this series, the pidfd
> > > > > > > creation failure trips up in pidfd_create() at the following
> > > > > > > condition:
> > > > > > >
> > > > > > >         if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > > > > > >                  return -EINVAL;
> > > > > > >
> > > > > > > Specifically, the following check:
> > > > > > >         !pid_has_task(pid, PIDTYPE_TGID)
> > > > > > >
> > > > > > > In order to properly report either FAN_NOPIDFD/FAN_EPIDFD to
> > > > > > > userspace, AFAIK I'll have to do one of either two things to better
> > > > > > > distinguish between why the pidfd creation had failed:
> > > > > >
> > > > > > Ok, I see. You already do have a reference to a struct pid and in that
> > > > > > case we should just always return a pidfd to the caller. For
> > > > > > pidfd_open() for example we only report an error when
> > > > > > find_get_pid(<pidnr>) doesn't find a struct pid to refer to. But in your
> > > > > > case here you already have a struct pid so I think we should just keep
> > > > > > this simple and always return a pidfd to the caller and in fact do
> > > > > > burden them with figuring out that the process is gone via
> > > > > > pidfd_send_signal() instead of complicating our lives here.
> > > > >
> > > > > Ah, actually Christian... Before, I go ahead and send through the updated
> > > > > series. Given what you've mentioned above I'm working with the assumption
> > > > > that you're OK with dropping the pid_has_task() check from pidfd_create()
> > > > > [0]. Is that right?
> > > > >
> > > > > If so, I don't know how I feel about this given that pidfd_create() is now
> > > > > to be exposed to the rest of the kernel and the pidfd API, as it stands,
> > > > > doesn't support the creation of pidfds for non-thread-group leaders. I
> > > > > suppose what I don't want is other kernel subsystems, if any, thinking it's
> > > > > OK to call pidfd_create() with an arbitrary struct pid and setting the
> > > > > expectation that a fully functional pidfd will be returned.
> > > > >
> > > > > The way I see it, I think we've got two options here:
> > > > >
> > > > > 1) Leave the pid_has_task() check within pidfd_create() and perform another
> > > > >    explicit pid_has_task() check from the fanotify code before calling
> > > > >    pidfd_create(). If it returns false, we set something like FAN_NOPIDFD
> > > > >    indicating to userspace that there's no such process when the event was
> > > > >    created.
> > > > >
> > > > > 2) Scrap using pidfd_create() all together and implement a fanotify
> > > > >    specific pidfd creation wrapper which would allow for more
> > > > >    control. Something along the lines of what you've done in kernel/fork.c
> > > > >    [1]. Not the biggest fan of this idea just yet given the possibility of
> > > > >    it leading to an API drift over time.
> > > > >
> > > > > WDYT?
> > > >
> > > > Hm, why would you have to drop the pid_has_task() check again?
> > >
> > > Because of the race that I brielfy decscribed here [0]. The race exists
> > 
> > Sorry for being thich. I still don't understand what's racy about this.
> > Won't the event reader get a valid pidfd?
> > Can't the event reader verify that the pidfd points to a dead process?
> > I don't mind returning FAN_NOPIDFD for convenience, but user
> > will have to check the pidfd that it got anyway, because process
> > can die at any time between reading the event and acting on the
> > pidfd.
> 
> (Replying to this part of the thread so we don't have to many parallel
> replies.)
> 
> Hm, so quoting from link [0] Matthew posted so we all have some context
> here:
> "Basically, with this approach the pidfd creation is done only once an
> event has been queued and the notification worker wakes up and picks up
> the event from the queue processes it. There's a subtle latency
> introduced when taking such an approach which at times leads to pidfd
> creation failures. As in, by the time pidfd_create() is called the
> struct pid has already been reaped, which then results in FAN_NOPIDFD
> being returned in the pidfd info record."
> 
> I don't think that's a race and even if I don't think that it's a
> meaningful one. So when the event is queued the process is still alive
> but when the notification is actually delivered the process is dead.
> 
> And your point, Matthew, seems to be that the caller should always get a
> pidfd back even if the process has already exited _and_ been reaped,
> i.e. is dead because it was alive when the event was generated.
> 
> I think that's no how it needs to work and I have a hard time seeing
> this as a good argument. What's problematic about just returning
> FAN_NOPIDFD in that case? After all the process is gone. All the caller
> can do with such a pidfd is to send it a signal and immediately realize
> that the process is gone, i.e. -ESRCH anyway.

To get things straight, there's no argument here. There's a discussion
about what the best approach is for communicating to the event listener
that a process has been killed prior to a pidfd being created by/from
fanotify. I have no issues with communicating FAN_NOPIDFD to the event
listener in such cases. I just want to make sure everyone else is OK with
it.

> > > because we perform the pidfd creation during the notification queue
> > > processing and not in the event allocation stages (for reasons that Jan has
> > > already covered here [1]). So, tl;dr there is the case where the fanotify
> > > calls pidfd_create() and the check for pid_has_task() fails because the
> > > struct pid that we're hanging onto within an event no longer contains a
> > > task of type PIDTYPE_TGID...
> > >
> > > [0] https://www.spinics.net/lists/linux-api/msg48630.html
> > > [1] https://www.spinics.net/lists/linux-api/msg48632.html

/M
