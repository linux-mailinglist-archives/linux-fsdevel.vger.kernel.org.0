Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C85398942
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Jun 2021 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbhFBMUL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Jun 2021 08:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhFBMT7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Jun 2021 08:19:59 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880CC06175F;
        Wed,  2 Jun 2021 05:18:15 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id v9so2239951ion.11;
        Wed, 02 Jun 2021 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B89ujZNTPMKCaJ4GW5VIPOZ5LzOhIxTFjXUqNMaUcrE=;
        b=CDbNvtmw21gowkrau6F8aZNb6JXuqlu1/qTki030Qk4OIUy8zSJfDFrqo7tD1t1i54
         tUBNylcYG5TFj5XfE+sfZ/J2seYU6GiPDyT5EVZACNOoCPw914lAlR7ayJ+EFzKI5DNH
         qMBu7sdXs8Rxft364hOpIRXmGDsjd5cTuxPj041NNbfIFfLmqswcaQ9nk0wXXetEzbNO
         DwUP7XzI5CvtmP1X95fDI1UJPUXgVOuvAeacSp+RISgSWV1kHwVwhlZsuWKkKYRtqXVM
         8F6izaXTRDwqRbji7Lh6+3QAFGhTUuP28aJucw4kz1NBQibqnHC8x+OjrCqQk2AbcEan
         a7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B89ujZNTPMKCaJ4GW5VIPOZ5LzOhIxTFjXUqNMaUcrE=;
        b=XbPVGheaQanIK/NrHt7koIZ4DS5IrQb1jdtsiDLtCt9XsIcVJU36YNi0dSxByY5xOe
         aTy8ckhjdlAKN86GxYE6vbJqySJIm3zZwPioe8tlNm3n9l39SJrB88l56QjJuddSb/Fv
         7w0MWLlmkxs/vTSLszZDsQDrDriP/gqIWwqJ1MKd7yKl8oMZvGDuKWphqKIcCWBVthFM
         CMFWQMM7urTiy1ay0eqO+AqRZyzyt/SdmCOxDqmgx5dEtEA9Vce4tgon9soAhQ2q6h59
         1c7VipEymif4oATQcFrnhdbsflkMGO0ViO6ZJsCyVhuRiWVVXCgBEgyS41rctOqgjCrn
         y/pA==
X-Gm-Message-State: AOAM531QQ8L8X+XM5TalC908KIe8R0Xe0TTjhXKAiuh5lXDllXoH8AMD
        WcOP3STFucN5E27pEkmZ9yb467rQJhfve3xN8mWonn+ABeA=
X-Google-Smtp-Source: ABdhPJxEoW+TeHkcd8MWPZK0I0GzV9P9Cpsc/k3WLzEXNKnkD1FqTlmyMKO6D9ESijTaqMQNakTH5W9LPCnnb0HPF6M=
X-Received: by 2002:a05:6602:72f:: with SMTP id g15mr25109238iox.5.1622636294884;
 Wed, 02 Jun 2021 05:18:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210521104056.GG18952@quack2.suse.cz> <YKhDFCUWX7iU7AzM@google.com>
 <20210524084746.GB32705@quack2.suse.cz> <20210525103133.uctijrnffehlvjr3@wittgenstein>
 <YK2GV7hLamMpcO8i@google.com> <20210526180529.egrtfruccbioe7az@wittgenstein>
 <YLYT/oeBCcnbfMzE@google.com> <20210601114628.f3w33yyca5twgfho@wittgenstein>
 <YLcliQRh4HRGt4Mi@google.com> <CAOQ4uxieRQ3s5rWA55ZBDr4xm6i9vXyWx-iErMgYzGCE5nYKcA@mail.gmail.com>
 <YLdg7wWQ/GTbe1eh@google.com>
In-Reply-To: <YLdg7wWQ/GTbe1eh@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 2 Jun 2021 15:18:03 +0300
Message-ID: <CAOQ4uxgWk6pX6U_F1aDRUSd5XRRHiToQL0+741b9RFW85WCxCQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add pidfd support to the fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > I still don't understand what's racy about this. Won't the event reader
> > get a valid pidfd?
>
> I guess this depends, right?
>
> As the logic/implementation currently stands in this specific patch series,
> pidfd_create() will _NOT_ return a valid pidfd unless the struct pid still
> holds reference to a task of type PIDTYPE_TGID. This is thanks to the extra
> pid_hash_task() check that I thought was appropriate to incorporate into
> pidfd_create() seeing as though:
>
>  - With the pidfd_create() declaration now being added to linux/pid.h, we
>    effectively are giving the implicit OK for it to be called from other
>    kernel subsystems, and hence why the caller should be subject to the
>    same restrictions/verifications imposed by the API specification
>    i.e. "Currently, the process identified by @pid must be a thread-group
>    leader...". Not enforcing the pid_has_task() check in pidfd_create()
>    effectively says that the pidfd creation can be done for any struct pid
>    types i.e. PIDTYPE_PID, PIDTYPE_PGID, etc. This leads to assumptions
>    being made by the callers, which effectively then could lead to
>    undefined/unexpected behavior.
>
> There definitely can be cases whereby the underlying task(s) associated
> with a struct pid have been freed as a result of process being killed
> early. As in, the process is killed before the pid_has_task() check is
> performed from within pidfd_create() when called from fanotify. This is
> precisely the race that I'm referring to here, and in such cases as the
> code currently stands, the event listener will _NOT_ receive a valid pidfd.
>
> > Can't the event reader verify that the pidfd points to a dead process?
>
> This was the idea, as in, the burden of checking whether a process has been
> killed before the event listener receives the event should be on the event
> listener. However, we're trying to come up with a good way to effectively
> communicate that the above race I've attempted to articulate has actually
> occurred. As in, do we:
>
> a) Drop the pid_has_task() check in pidfd_create() so that a pidfd can be
>    returned for all passed struct pids? That way, even if the above race is
>    experienced the caller will still receive a pidfd and the event listener
>    can do whatever it needs to with it.
>
> b) Before calling into pidfd_create(), perform an explicit pid_has_task()
>    check for PIDTYPE_TGID and if that returns false, then set FAN_NOPIDFD
>    and save ourselves from calling into pidfd_create() all together. The
>    event listener in this case doesn't have to perform the signal check to
>    determine whether the process has already been killed.
>
> c) Scrap calling into pidfd_create() all together and write a simple
>    fanotify wrapper that contains the pidfd creation logic we need.
>
> > I don't mind returning FAN_NOPIDFD for convenience, but user
> > will have to check the pidfd that it got anyway, because process
> > can die at any time between reading the event and acting on the
> > pidfd.
>
> Well sort of, as it depends on the approach that we decide to go ahead with
> to report such early process termination cases. If we return FAN_NOPIDFD,
> which signifies that the process died before a pidfd could be created, then
> there's no point for the listener to step into checking the pidfd because
> the pidfd already == FAN_NOPIDFD. If we simply return a pidfd regardless of
> the early termination of the process, then sure the event listener will
> need to check each pidfd that is supplied.
>

I don't see any problem with the fact that the listener would have to check the
reported pidfd. I don't see how or why that should be avoided.
If we already know there is no process, we can be nice and return NOPIDFD,
because that doesn't add any complexity.

Not to mention that if pid_vnr() returns 0 (process is outside of
pidns of caller)
then I think you MUST either report FAN_NOPIDFD or no pid info record,
because getting 0 event->pid  with a valid pidfd is weird IMO and could be
considered as a security breach.

> > > because we perform the pidfd creation during the notification queue
> > > processing and not in the event allocation stages (for reasons that Jan has
> > > already covered here [1]). So, tl;dr there is the case where the fanotify
> > > calls pidfd_create() and the check for pid_has_task() fails because the
> > > struct pid that we're hanging onto within an event no longer contains a
> > > task of type PIDTYPE_TGID...
> > >
> > > [0] https://www.spinics.net/lists/linux-api/msg48630.html
> > > [1] https://www.spinics.net/lists/linux-api/msg48632.html
>
> Maybe I'm going down a rabbit hole and overthinking this whole thing,
> IDK... :(
>

That is the feeling I get as well.
Suggestion: write the man page - that will make it clear to yourself
and to code reviewers if the API is sane and if it is going to end up
being confusing to end users.

Thanks,
Amir.
