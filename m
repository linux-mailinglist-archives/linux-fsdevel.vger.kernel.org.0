Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE873922F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 May 2021 00:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbhEZW4D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 May 2021 18:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229939AbhEZW4C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 May 2021 18:56:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62441C06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 15:54:29 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c12so2120809pfl.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 May 2021 15:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcN1zx+MobYWSdxvowLh202jeQXpkXA2qC49/LZKsjM=;
        b=Jim8IZdEKWy6f7IRNNTsjYHHrBqpNPAqGeMDRgVRplH2aKcRmoDnId2U5AHiWuxZGD
         9MOHLgn1PlOjUMnRuUvbBpjM8/BW/WhMLhwKShZNIoL0glzClRhj0iYfcB55jTXUujbs
         7CIIhcP9zO5jHWSeL7BFOLpuPvfNFEOAWAZ7phDml4ZONXybJULQJ5dBgvtYYbGyta1J
         qMHZp80Kr0BqavduHog8bLt7zhSgq/5VjcI8MaJl611T9fn0vgecT79Lmpkw4MOOWnXE
         qWR1xOsRV+c/SJxGj9elAIdaQDUkIjW/3MfxNOYHvxNWWU2kZsF0XXQf0OrvvOxqNhdH
         rQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcN1zx+MobYWSdxvowLh202jeQXpkXA2qC49/LZKsjM=;
        b=FLnOFs3+G3aZoT2tP53ytPNR2MpjTYeI99/reUBrFxgfsX+tDyciDHreLUWdl+yQch
         LpIz4uN8CqI/loXerJNUpm2y+l6JtiMSMUlhyq/H0Arugly8EASM03yC/KT9f5Nvksf/
         54WHOuUaJLBZkeH3EgUO7XGuP1ujNtI9+7M6tjS1QWFMs9T+jBjeejjCvHk+bafep1bN
         wCleQ+w57TN2wrGBsIQAQ3qIwMm79WZAT9tJ2X9ghKvHMnW3Whp/Xm/nFKG8CDoeGhs/
         AA4264cmt5zBzh0qqkR+F/++Q9X+FEt/6hLPLGWJufClmZnn0cpobHD/uUWmX4r8QUIO
         2k9A==
X-Gm-Message-State: AOAM533jy7NlxtOnpmXn9dl7FGxIksWCyVaZG7lQCzuFLHRjGqo5PfBz
        jGSfNH4Lisk9NVg10r9iK83UqA==
X-Google-Smtp-Source: ABdhPJxKdQElqtNoYsaj6kfpBXxeK/ll/a0Vu7H9N/tWLNr7wNV7EJiqsrk/Hus+zbwHFCH8gv/mdw==
X-Received: by 2002:a63:bf4e:: with SMTP id i14mr784899pgo.277.1622069668555;
        Wed, 26 May 2021 15:54:28 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3fa2:1def:c241:e711])
        by smtp.gmail.com with ESMTPSA id y194sm204984pfb.193.2021.05.26.15.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 15:54:27 -0700 (PDT)
Date:   Thu, 27 May 2021 08:54:16 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YK7RmNYzYDEvhSqb@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
 <20210521104056.GG18952@quack2.suse.cz>
 <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com>
 <20210526180529.egrtfruccbioe7az@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526180529.egrtfruccbioe7az@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 26, 2021 at 08:05:29PM +0200, Christian Brauner wrote:
> On Wed, May 26, 2021 at 09:20:55AM +1000, Matthew Bobrowski wrote:
> > On Tue, May 25, 2021 at 12:31:33PM +0200, Christian Brauner wrote:
> > > On Mon, May 24, 2021 at 10:47:46AM +0200, Jan Kara wrote:
> > > > On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> > > > > On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > > > > > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > > > > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > > > > > There's one thing that I'd like to mention, and it's something in
> > > > > > > regards to the overall approach we've taken that I'm not particularly
> > > > > > > happy about and I'd like to hear all your thoughts. Basically, with
> > > > > > > this approach the pidfd creation is done only once an event has been
> > > > > > > queued and the notification worker wakes up and picks up the event
> > > > > > > from the queue processes it. There's a subtle latency introduced when
> > > > > > > taking such an approach which at times leads to pidfd creation
> > > > > > > failures. As in, by the time pidfd_create() is called the struct pid
> > > > > > > has already been reaped, which then results in FAN_NOPIDFD being
> > > > > > > returned in the pidfd info record.
> > > > > > > 
> > > > > > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > > > > > creation earlier on i.e. in the event allocation stages? This way, the
> > > > > > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > > > > > returned in the pidfd info record because the struct pid has been
> > > > > > > already reaped, userspace application will atleast receive a valid
> > > > > > > pidfd which can be used to check whether the process still exists or
> > > > > > > not. I think it'll just set the expectation better from an API
> > > > > > > perspective.
> > > > > > 
> > > > > > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > > > > > be sure the original process doesn't exist anymore. So is it useful to
> > > > > > still receive pidfd of the dead process?
> > > > > 
> > > > > Well, you're absolutely right. However, FWIW I was approaching this
> > > > > from two different angles:
> > > > > 
> > > > > 1) I wanted to keep the pattern in which the listener checks for the
> > > > >    existence/recycling of the process consistent. As in, the listener
> > > > >    would receive the pidfd, then send the pidfd a signal via
> > > > >    pidfd_send_signal() and check for -ESRCH which clearly indicates
> > > > >    that the target process has terminated.
> > > > > 
> > > > > 2) I didn't want to mask failed pidfd creation because of early
> > > > >    process termination and other possible failures behind a single
> > > > >    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
> > > > >    listener can take clear corrective branches as what's to be done
> > > > >    next if a race is to have been detected, whereas simply returning
> > > > >    FAN_NOPIDFD at this stage can mean multiple things.
> > > > > 
> > > > > Now that I've written the above and keeping in mind that we'd like to
> > > > > refrain from doing anything in the event allocation stages, perhaps we
> > > > > could introduce a different error code for detecting early process
> > > > > termination while attempting to construct the info record. WDYT?
> > > > 
> > > > Sure, I wouldn't like to overengineer it but having one special fd value for
> > > > "process doesn't exist anymore" and another for general "creating pidfd
> > > > failed" looks OK to me.
> > > 
> > > FAN_EPIDFD -> "creation failed"
> > > FAN_NOPIDFD -> "no such process"
> > 
> > Yes, I was thinking something along the lines of this...
> > 
> > With the approach that I've proposed in this series, the pidfd
> > creation failure trips up in pidfd_create() at the following
> > condition:
> > 
> > 	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
> > 	   	 return -EINVAL;
> > 
> > Specifically, the following check:
> > 	!pid_has_task(pid, PIDTYPE_TGID)
> > 
> > In order to properly report either FAN_NOPIDFD/FAN_EPIDFD to
> > userspace, AFAIK I'll have to do one of either two things to better
> > distinguish between why the pidfd creation had failed:
> 
> Ok, I see. You already do have a reference to a struct pid and in that
> case we should just always return a pidfd to the caller. For
> pidfd_open() for example we only report an error when
> find_get_pid(<pidnr>) doesn't find a struct pid to refer to. But in your
> case here you already have a struct pid so I think we should just keep
> this simple and always return a pidfd to the caller and in fact do
> burden them with figuring out that the process is gone via
> pidfd_send_signal() instead of complicating our lives here.

Right, that makes sense to me. In that case let's keep it simple and
lift the pid_has_task() check from pidfd_create() and leave it at
that. As you mentioned, this way we'll still end up returning a pidfd
in the event and FAN_NOPIDFD will resemble other pidfd creation
errors.

> (I think if would be interesting to see perf numbers and how high you
> need to bump the number of open fds sysctl limit to make this useable on
> systems with a lot of events. I'd be interested in that just in case you
> have something there.)

Not yet, but perhaps it's something that I'll be able to provide a
little later on. Jan, Amir and I recently have been discussing how to
go about conducting performance related regressions against fanotify,
so perhaps while at it I can think about this case too. I aim to start
on this after I've wrapped up with this series.

/M
