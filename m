Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54CD3971FF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jun 2021 13:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhFALFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Jun 2021 07:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFALFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Jun 2021 07:05:22 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48152C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue,  1 Jun 2021 04:03:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso1215114pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Jun 2021 04:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/GksUVltJ6s29hzs/A+jMHzCCdCGNsvm+wEFX0vbmZ0=;
        b=H2QHDNvIoEiRBDmCFCuEWTYlh4s7tJ8suD0HNA2NO6w+uSfVcEqr55KcafZ0ZoIikf
         7GG3QHEVXPupN96W8wx+W4MAjjliWJI9vmyxRd9QgO/grr3+asT9B7CxAvKsypRMo8uD
         OWG5AGaj3TgiptWV9hqz6ylsuPX0GTZizBt/trpi5hqkDCfNF9y3nKxfXN0UtU3Adsvw
         12+AtOHlQni7OvFV/HfYe9wQPJnNatSTrLRs9Y8HBa/X4hqqpizBMVXCrBn+xiciHmVm
         RhxUNrT2819tsy3iWHNgl3WbzD4xSwh4fhoazqczS5fdD/pNJ0v1XvNFJGbBjLiCxcFq
         SRJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/GksUVltJ6s29hzs/A+jMHzCCdCGNsvm+wEFX0vbmZ0=;
        b=j+fQ1KXkJ7yOciPWDfrp/VQ1ysDgia0fLSCyOzNbPmEgjsqsdiFdRgrTpZozhMcqs2
         qXA6JcUyZjGYWEPQtTPf0QLPsVP+u0uemFT8hzuya2C15vvxVLor8MrQ7M96fj3akMKO
         ONrWVJnzSwKRiR/TrVGQDiJEzfGqsCl2Zlt9pQSkWZlexi/XgJ9cY3w+/UOY0Y1lF/wy
         /ueHnuJIKUT6Uvkrc2MKF57O4J9JE64yvpHzo9mHSDA3HNPcvuY1034T+aFGAVPrAsmj
         WiNQge4uevF13Ap/fbQAvIDbNxMa30NSz0xlFlAiPTUSgb7d2eRXc1q7MbIggTz1ii0M
         c0pw==
X-Gm-Message-State: AOAM532BLGiG/Fbt63EPf1SK/UeE/u2+xNa/aOurzRJWI8IFfHNdHB1k
        sjyub40iTjKIwQVq3te/ouAv3Q==
X-Google-Smtp-Source: ABdhPJwK3pGNP4QcBqI+YD/SZkxB+C0XFBiP2O0CSI1dK7PelRZBq8JqjRYsH/YdRPnjdlY7EmwB7A==
X-Received: by 2002:a17:902:e903:b029:108:d6d0:c1d1 with SMTP id k3-20020a170902e903b0290108d6d0c1d1mr1683552pld.67.1622545419433;
        Tue, 01 Jun 2021 04:03:39 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:10ae:a700:2fce:6fd6])
        by smtp.gmail.com with ESMTPSA id h1sm13306414pfh.72.2021.06.01.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 04:03:38 -0700 (PDT)
Date:   Tue, 1 Jun 2021 21:03:26 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YLYT/oeBCcnbfMzE@google.com>
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

Ah, actually Christian... Before, I go ahead and send through the updated
series. Given what you've mentioned above I'm working with the assumption
that you're OK with dropping the pid_has_task() check from pidfd_create()
[0]. Is that right?

If so, I don't know how I feel about this given that pidfd_create() is now
to be exposed to the rest of the kernel and the pidfd API, as it stands,
doesn't support the creation of pidfds for non-thread-group leaders. I
suppose what I don't want is other kernel subsystems, if any, thinking it's
OK to call pidfd_create() with an arbitrary struct pid and setting the
expectation that a fully functional pidfd will be returned.

The way I see it, I think we've got two options here:

1) Leave the pid_has_task() check within pidfd_create() and perform another
   explicit pid_has_task() check from the fanotify code before calling
   pidfd_create(). If it returns false, we set something like FAN_NOPIDFD
   indicating to userspace that there's no such process when the event was
   created.

2) Scrap using pidfd_create() all together and implement a fanotify
   specific pidfd creation wrapper which would allow for more
   control. Something along the lines of what you've done in kernel/fork.c
   [1]. Not the biggest fan of this idea just yet given the possibility of
   it leading to an API drift over time.

WDYT?

[0] https://www.spinics.net/lists/linux-api/msg48568.html
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/fork.c#n2171  

/M
