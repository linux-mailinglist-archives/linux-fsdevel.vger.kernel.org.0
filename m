Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AB55399779
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 03:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbhFCB1V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 21:27:21 -0400
Received: from mail-pj1-f50.google.com ([209.85.216.50]:37457 "EHLO
        mail-pj1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbhFCB1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 21:27:21 -0400
Received: by mail-pj1-f50.google.com with SMTP id 22-20020a17090a0c16b0290164a5354ad0so4509270pjs.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Jun 2021 18:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y5eUJ8QAS6dcCgWeBqLCxxRo0PfEK90WScuol0NFsqc=;
        b=JFbvNuwPNb0v9o1rc5jJ1trIdgYiNhiz4I6vVa/rTLlLcbEnnXcULDS+juthYDgeZd
         KLdEdyTi2c7mvWDDZmxViRs8g6zWuJ/KLiNaVqEc4jgpMZ/4GC8NUzMY23qP9v5XTM/E
         qutshpqYZWP4t6X90xCBsPT5xqlgPIyYoP4XPTiYz3ynlG1V77qPa7cfUL6GyGV9hXZK
         Bj689Dl0J+2Bmah/m+sfE/iBnRIhW2hIAFnOhhov/V8ExV6ly9LvZZv1lLsE1pCTYOOp
         ApAQNcJVzqa5toN9iY1kXqUDmUA1D5bmD2tEjzFChUEcu/3zLqDnt67LClH+UJoY0zsF
         M2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y5eUJ8QAS6dcCgWeBqLCxxRo0PfEK90WScuol0NFsqc=;
        b=hseaXdL3AyzYc2gdGHm3VGy/DSyVe/9gsJGhNc3UNXK+lubvmVVXJe+4F5dPvtsJeO
         WXHuKiW7wxdcI/UkQAR1D+hVNw1OSD/NV7Hm6CEMp0/7qwB73XX7MdhvwecCj6hQJsyi
         Fs90pBCW/236CTgHIFpKmz+YxGmCvGu/etMHYxlWUnY3GcYo8qVodLqZGdlgQHe+j5rP
         fZ6bhGk6NE+vfgH0npymwVBuNkwsJmEEGczP+IO1jLd3fvTaPWO66l6So9lCYMCr8izo
         i8frcLnFUdY1o3Ua8WEHiv/U4+RIW8ZOc/cAZw/2m8+QVz0sBLboUc3SpIrimucw3Ydz
         4E8g==
X-Gm-Message-State: AOAM5335uv3Ly5f8HdoBIUl4rRw8S24HdrAvLSJOIvNRCY3qrQ9HlJ0H
        /B/k/4CBeis7J83ggkdpKdhBEw==
X-Google-Smtp-Source: ABdhPJx7C2YnPKFW+2sILLhXA2z9jUGbaSM39biV0SzUELfbi2Yiu9HZ49Kb9o7s9FH+8fgcSmTpDQ==
X-Received: by 2002:a17:90a:c20b:: with SMTP id e11mr8351930pjt.67.1622683461381;
        Wed, 02 Jun 2021 18:24:21 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:3abe:a437:32fb:4e73])
        by smtp.gmail.com with ESMTPSA id n129sm268786pfn.167.2021.06.02.18.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 18:24:20 -0700 (PDT)
Date:   Thu, 3 Jun 2021 11:24:08 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
Message-ID: <YLgvN9MEi+NEgJhh@google.com>
References: <20210524084746.GB32705@quack2.suse.cz>
 <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com>
 <20210526180529.egrtfruccbioe7az@wittgenstein>
 <YLYT/oeBCcnbfMzE@google.com>
 <20210601114628.f3w33yyca5twgfho@wittgenstein>
 <YLcliQRh4HRGt4Mi@google.com>
 <CAOQ4uxieRQ3s5rWA55ZBDr4xm6i9vXyWx-iErMgYzGCE5nYKcA@mail.gmail.com>
 <YLdg7wWQ/GTbe1eh@google.com>
 <CAOQ4uxgWk6pX6U_F1aDRUSd5XRRHiToQL0+741b9RFW85WCxCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgWk6pX6U_F1aDRUSd5XRRHiToQL0+741b9RFW85WCxCQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:18:03PM +0300, Amir Goldstein wrote:
> > > I still don't understand what's racy about this. Won't the event reader
> > > get a valid pidfd?
> >
> > I guess this depends, right?
> >
> > As the logic/implementation currently stands in this specific patch series,
> > pidfd_create() will _NOT_ return a valid pidfd unless the struct pid still
> > holds reference to a task of type PIDTYPE_TGID. This is thanks to the extra
> > pid_hash_task() check that I thought was appropriate to incorporate into
> > pidfd_create() seeing as though:
> >
> >  - With the pidfd_create() declaration now being added to linux/pid.h, we
> >    effectively are giving the implicit OK for it to be called from other
> >    kernel subsystems, and hence why the caller should be subject to the
> >    same restrictions/verifications imposed by the API specification
> >    i.e. "Currently, the process identified by @pid must be a thread-group
> >    leader...". Not enforcing the pid_has_task() check in pidfd_create()
> >    effectively says that the pidfd creation can be done for any struct pid
> >    types i.e. PIDTYPE_PID, PIDTYPE_PGID, etc. This leads to assumptions
> >    being made by the callers, which effectively then could lead to
> >    undefined/unexpected behavior.
> >
> > There definitely can be cases whereby the underlying task(s) associated
> > with a struct pid have been freed as a result of process being killed
> > early. As in, the process is killed before the pid_has_task() check is
> > performed from within pidfd_create() when called from fanotify. This is
> > precisely the race that I'm referring to here, and in such cases as the
> > code currently stands, the event listener will _NOT_ receive a valid pidfd.
> >
> > > Can't the event reader verify that the pidfd points to a dead process?
> >
> > This was the idea, as in, the burden of checking whether a process has been
> > killed before the event listener receives the event should be on the event
> > listener. However, we're trying to come up with a good way to effectively
> > communicate that the above race I've attempted to articulate has actually
> > occurred. As in, do we:
> >
> > a) Drop the pid_has_task() check in pidfd_create() so that a pidfd can be
> >    returned for all passed struct pids? That way, even if the above race is
> >    experienced the caller will still receive a pidfd and the event listener
> >    can do whatever it needs to with it.
> >
> > b) Before calling into pidfd_create(), perform an explicit pid_has_task()
> >    check for PIDTYPE_TGID and if that returns false, then set FAN_NOPIDFD
> >    and save ourselves from calling into pidfd_create() all together. The
> >    event listener in this case doesn't have to perform the signal check to
> >    determine whether the process has already been killed.
> >
> > c) Scrap calling into pidfd_create() all together and write a simple
> >    fanotify wrapper that contains the pidfd creation logic we need.
> >
> > > I don't mind returning FAN_NOPIDFD for convenience, but user
> > > will have to check the pidfd that it got anyway, because process
> > > can die at any time between reading the event and acting on the
> > > pidfd.
> >
> > Well sort of, as it depends on the approach that we decide to go ahead with
> > to report such early process termination cases. If we return FAN_NOPIDFD,
> > which signifies that the process died before a pidfd could be created, then
> > there's no point for the listener to step into checking the pidfd because
> > the pidfd already == FAN_NOPIDFD. If we simply return a pidfd regardless of
> > the early termination of the process, then sure the event listener will
> > need to check each pidfd that is supplied.
> >
> 
> I don't see any problem with the fact that the listener would have to check the
> reported pidfd. I don't see how or why that should be avoided.
> If we already know there is no process, we can be nice and return NOPIDFD,
> because that doesn't add any complexity.

Yes, agree. Going ahead with returning FAN_NOPIDFD for early process
termination i.e. before fanotify calls into pidfd creation code. All other
pidfd creation errors will be reported as FAN_EPIDFD.

> Not to mention that if pid_vnr() returns 0 (process is outside of
> pidns of caller)
> then I think you MUST either report FAN_NOPIDFD or no pid info record,
> because getting 0 event->pid  with a valid pidfd is weird IMO and could be
> considered as a security breach.

Good point. I feel as though reporting FAN_NOPIDFD in such cases would be
more appropriate, rather than leaving off a pidfd info record completely.

> > > > because we perform the pidfd creation during the notification queue
> > > > processing and not in the event allocation stages (for reasons that Jan has
> > > > already covered here [1]). So, tl;dr there is the case where the fanotify
> > > > calls pidfd_create() and the check for pid_has_task() fails because the
> > > > struct pid that we're hanging onto within an event no longer contains a
> > > > task of type PIDTYPE_TGID...
> > > >
> > > > [0] https://www.spinics.net/lists/linux-api/msg48630.html
> > > > [1] https://www.spinics.net/lists/linux-api/msg48632.html
> >
> > Maybe I'm going down a rabbit hole and overthinking this whole thing,
> > IDK... :(
> >
> 
> That is the feeling I get as well.
> Suggestion: write the man page - that will make it clear to yourself
> and to code reviewers if the API is sane and if it is going to end up
> being confusing to end users.

Yeah, that's a good approach. I'll consider doing this for future API
changes.

/M
