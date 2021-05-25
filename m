Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FB9390CE9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 01:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbhEYXWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 19:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbhEYXWj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 19:22:39 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8675DC061574
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 16:21:08 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q15so23983097pgg.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 May 2021 16:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N9pRtcpwEgIj6sC0tHqwYGJBlDf6VjtQs2mfFfUfl6g=;
        b=eM5f6HsI/GmdQGh0ezMqwI/wS6K88p5V+4+nkKfgg7z9bCJVxfabyrOhNmdw00kB33
         tCk9CY+4PJEK82DpKSgc/nd/RIW7ux57thwYKIx29lVMv+6qOXK8DT3ufc79lKKWA8vR
         9Mc/u7M7h1ZmFQzmKYjHQSTnxQpIOZBC0Mp3Fu0/LDUIlheg42ubaR+aV9VlDKemejyv
         iAcpZ8Zxl7NKRsUvQe/IjPsINfN2wzvmp4JAezHdvy9SeN802OHAWjHZLIpxTANGwLeL
         /uucrr9tIwGKayjHp7CRnA0eWe9b1P36Fsgip83lycGpNuwzqEPLqPa9i/AHF2txImAS
         uZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N9pRtcpwEgIj6sC0tHqwYGJBlDf6VjtQs2mfFfUfl6g=;
        b=Xq8F2ArVvKM9HZTzSeKda0Q+nV1qhJkjQJ+zZZyxHQFhfeqkjt0+ssjHFNe8G4MYu+
         5CWj8q7or7CY2zvrAmo27weB75SMakCkh5u3jfDrA4aanJqbHpuSq+fsKalO4HxgjT0Y
         a5X28kDpD5XgM+0O38lqgLILcPSKxtBqIXLBpemFvF1iv6Q6dzo3ioqjzPvFZbMbl2mK
         RayIdUYEZXyKDQiB1mU4/KPoB6fHEKgt1C/Yb9JlkZpQfJtXfr1/3bk/5RG3/Obg1Mv7
         ODTHYwzPSh4drX9uq/3dU+JhvRgbSV0c3LHtGWjRvIDb0Y21vgDSVR3+LQ7XsfLL1uEe
         nH5w==
X-Gm-Message-State: AOAM531bh7wATiZsnD1a9P7ijk6UDm2J3GCtQRommxt3uPD/++Dkf5N0
        sVaZiXY8F3UPoK0Y1WjQe98EgQ==
X-Google-Smtp-Source: ABdhPJzTaM1dRCFm8Mp7aPTQuQDnu9Zc4/Lrm8xw3bO2GrfQex+U+F4LYKC8FIWuLHWi9Xykyn29xQ==
X-Received: by 2002:a65:48c2:: with SMTP id o2mr21347245pgs.376.1621984867810;
        Tue, 25 May 2021 16:21:07 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:a122:6bc0:d8f6:9eea])
        by smtp.gmail.com with ESMTPSA id k20sm119872pgl.72.2021.05.25.16.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 16:21:06 -0700 (PDT)
Date:   Wed, 26 May 2021 09:20:55 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YK2GV7hLamMpcO8i@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <20210520135527.GD18952@quack2.suse.cz>
 <YKeIR+LiSXqUHL8Q@google.com>
 <20210521104056.GG18952@quack2.suse.cz>
 <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525103133.uctijrnffehlvjr3@wittgenstein>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 12:31:33PM +0200, Christian Brauner wrote:
> On Mon, May 24, 2021 at 10:47:46AM +0200, Jan Kara wrote:
> > On Sat 22-05-21 09:32:36, Matthew Bobrowski wrote:
> > > On Fri, May 21, 2021 at 12:40:56PM +0200, Jan Kara wrote:
> > > > On Fri 21-05-21 20:15:35, Matthew Bobrowski wrote:
> > > > > On Thu, May 20, 2021 at 03:55:27PM +0200, Jan Kara wrote:
> > > > > There's one thing that I'd like to mention, and it's something in
> > > > > regards to the overall approach we've taken that I'm not particularly
> > > > > happy about and I'd like to hear all your thoughts. Basically, with
> > > > > this approach the pidfd creation is done only once an event has been
> > > > > queued and the notification worker wakes up and picks up the event
> > > > > from the queue processes it. There's a subtle latency introduced when
> > > > > taking such an approach which at times leads to pidfd creation
> > > > > failures. As in, by the time pidfd_create() is called the struct pid
> > > > > has already been reaped, which then results in FAN_NOPIDFD being
> > > > > returned in the pidfd info record.
> > > > > 
> > > > > Having said that, I'm wondering what the thoughts are on doing pidfd
> > > > > creation earlier on i.e. in the event allocation stages? This way, the
> > > > > struct pid is pinned earlier on and rather than FAN_NOPIDFD being
> > > > > returned in the pidfd info record because the struct pid has been
> > > > > already reaped, userspace application will atleast receive a valid
> > > > > pidfd which can be used to check whether the process still exists or
> > > > > not. I think it'll just set the expectation better from an API
> > > > > perspective.
> > > > 
> > > > Yes, there's this race. OTOH if FAN_NOPIDFD is returned, the listener can
> > > > be sure the original process doesn't exist anymore. So is it useful to
> > > > still receive pidfd of the dead process?
> > > 
> > > Well, you're absolutely right. However, FWIW I was approaching this
> > > from two different angles:
> > > 
> > > 1) I wanted to keep the pattern in which the listener checks for the
> > >    existence/recycling of the process consistent. As in, the listener
> > >    would receive the pidfd, then send the pidfd a signal via
> > >    pidfd_send_signal() and check for -ESRCH which clearly indicates
> > >    that the target process has terminated.
> > > 
> > > 2) I didn't want to mask failed pidfd creation because of early
> > >    process termination and other possible failures behind a single
> > >    FAN_NOPIDFD. IOW, if we take the -ESRCH approach above, the
> > >    listener can take clear corrective branches as what's to be done
> > >    next if a race is to have been detected, whereas simply returning
> > >    FAN_NOPIDFD at this stage can mean multiple things.
> > > 
> > > Now that I've written the above and keeping in mind that we'd like to
> > > refrain from doing anything in the event allocation stages, perhaps we
> > > could introduce a different error code for detecting early process
> > > termination while attempting to construct the info record. WDYT?
> > 
> > Sure, I wouldn't like to overengineer it but having one special fd value for
> > "process doesn't exist anymore" and another for general "creating pidfd
> > failed" looks OK to me.
> 
> FAN_EPIDFD -> "creation failed"
> FAN_NOPIDFD -> "no such process"

Yes, I was thinking something along the lines of this...

With the approach that I've proposed in this series, the pidfd
creation failure trips up in pidfd_create() at the following
condition:

	if (!pid || !pid_has_task(pid, PIDTYPE_TGID))
	   	 return -EINVAL;

Specifically, the following check:
	!pid_has_task(pid, PIDTYPE_TGID)

In order to properly report either FAN_NOPIDFD/FAN_EPIDFD to
userspace, AFAIK I'll have to do one of either two things to better
distinguish between why the pidfd creation had failed:

1) Implement an additional check in pidfd_create() that effectively
   checks whether provided pid still holds reference to a struct pid
   that isn't in the process of being cleaned up. If it is being
   cleaned up, then return something like -ESRCH instead of -EINVAL so
   that the caller, in this case fanotify, can check and set
   FAN_NOPIDFD if -ESRCH is returned from pidfd_create(). I definitely
   don't feel as though returning -ESRCH from the !pid_has_task(pid,
   PIDTYPE_TGID) would be appropriate. In saying that, I'm not aware
   of a helper by which would allow us to perform such an in-flight
   check? Perhaps something needs to be introduced here, IDK...

2) Refrain from performing any further changes to pidfd_create()
   i.e. as proposed in option 1), and manually perform the pidfd
   creation from some kind of new fanotify helper, as suggested by you
   here [0]. However, I'm not convinved that I like this approach as
   we may end up slowly drifting away from pidfd creation semantics
   over time.

[0] https://www.spinics.net/lists/linux-fsdevel/msg195556.html 

/M
