Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0998438D4AE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 11:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEVJDa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 22 May 2021 05:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbhEVJDa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 22 May 2021 05:03:30 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53EFC061574;
        Sat, 22 May 2021 02:02:04 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id r4so21839907iol.6;
        Sat, 22 May 2021 02:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tl9Mh4LsWp/FMsNNrCZagTwxnYEucPSwMSz+PMRkBIk=;
        b=IEzSB4iw23DmssdrD4a667lzAumdClqp0n0P0qD/JDzNbJXOtd+sNlEfh+EL7gr863
         qBLoXH6ljd+wKt2vbEvhu4UH34IimTtgjIH2JfWPBuvseZ0/wu8BGygNc9xiEH3LmAtW
         qicDflTsae0hxeDanOMji/trSnTEoLJCh474uq5zv3zZLOcY7bRob5zPCxIwSRsZClXf
         KJFBpN1cJ70YGKcSGfkMnEldC9sfWHLqEGhgxx0C4TghHkdlD+ByioVJYOgMlF14G/1i
         0OPNd0Moh9KEkEVf7eatv3ckte3eYI9W06kfPlaLLKmyo+DwOXBBASq9Qn3FYX/konuj
         7FVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tl9Mh4LsWp/FMsNNrCZagTwxnYEucPSwMSz+PMRkBIk=;
        b=mO3pD5RFnJxhuYrcTReBTTk+gSOwQa9Pib7RJZN/NdK6StDjb0P0eGALNDXGhPC70W
         dwE7Lz3yfOLaEeJiN9xebRQqiUBgH+1jh9Y+1skvK4KKjxOBtmU6+eG5Znq4/JtMVOVr
         BiPDdu9h+ORL0MdNpWuMr1UaUB7xwkACevuAzdR/GdZJejkbNPnQ+ijJtX3mD4rH4+ai
         NdCkWi4Eh1Badzz+KtbQQi/V2C+TrzsqqlrHdtZpuMZhGHJrI2wCjdhLyN0vuZUvUQhT
         ReujTL6zPphQT5SEGJ5AKQDCRcWLdm7btSpFe2SKsrH4he34iHMcvbKZKbfEerVwGPJt
         wFjw==
X-Gm-Message-State: AOAM531SJn9tYeqizD26JeZoGhZg9uv/nYf8BfoXXYpRQDO5qKdHNeYV
        8LtT0XNy08b3DXKZn3ndcGtQb7h8VFnmMwxEOcI=
X-Google-Smtp-Source: ABdhPJwj6ViYNtO/Jxfxf9q3X+hItjH18YOs/5PFLO6GNwO2UZfX+K/QTrE2Zepi1u1gpLikow/qmEtKxUTL9zxqWm4=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr3392363ioa.64.1621674123922;
 Sat, 22 May 2021 02:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein> <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com> <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
 <20210521102418.GF18952@quack2.suse.cz> <CAOQ4uxh84uXAQzz2w+TD1OeDtVwBX8uhM3Pumm46YvP-Wkndag@mail.gmail.com>
 <20210521131917.GM18952@quack2.suse.cz> <CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com>
 <20210521151415.GP18952@quack2.suse.cz> <YKhTNCyQLlqaz3yC@google.com>
In-Reply-To: <YKhTNCyQLlqaz3yC@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sat, 22 May 2021 12:01:52 +0300
Message-ID: <CAOQ4uxjeS43SHVB+1UvFnbE4UtMvmOSVHAD7fyxTDyXCi2zHUw@mail.gmail.com>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > > > > > > > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > > > > > > > > (even though fanotify_init() does check for that).
> > > > > > > >
> > > > > > > > I didn't really understand the need for this check here given that the
> > > > > > > > administrative bits are already being checked for in fanotify_init()
> > > > > > > > i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> > > > > > > > thus never walking any of the pidfd_mode paths. Is this just a defense
> > > > > > > > in depth approach here, or is it something else that I'm missing?
> > > > > > > >
> > > > > > >
> > > > > > > We want to be extra careful not to create privilege escalations,
> > > > > > > so even if the fanotify fd is leaked or intentionally passed to a less
> > > > > > > privileged user, it cannot get an open pidfd.
> > > > > > >
> > > > > > > IOW, it is *much* easier to be defensive in this case than to prove
> > > > > > > that the change cannot introduce any privilege escalations.
> > > > > >
> > > > > > I have no problems with being more defensive (it's certainly better than
> > > > > > being too lax) but does it really make sence here? I mean if CAP_SYS_ADMIN
> > > > > > task opens O_RDWR /etc/passwd and then passes this fd to unpriviledged
> > > > > > process, that process is also free to update all the passwords.
> > > > > > Traditionally permission checks in Unix are performed on open and then who
> > > > > > has fd can do whatever that fd allows... I've tried to follow similar
> > > > > > philosophy with fanotify as well and e.g. open happening as a result of
> > > > > > fanotify path events does not check permissions either.
> > > > > >
> > > > >
> > > > > Agreed.
> > > > >
> > > > > However, because we had this issue with no explicit FAN_REPORT_PID
> > > > > we added the CAP_SYS_ADMIN check for reporting event->pid as next
> > > > > best thing. So now that becomes weird if priv process created fanotify fd
> > > > > and passes it to unpriv process, then unpriv process gets events with
> > > > > pidfd but without event->pid.
> > > > >
> > > > > We can change the code to:
> > > > >
> > > > >         if (!capable(CAP_SYS_ADMIN) && !pidfd_mode &&
> > > > >             task_tgid(current) != event->pid)
> > > > >                 metadata.pid = 0;
> > > > >
> > > > > So the case I decscribed above ends up reporting both pidfd
> > > > > and event->pid to unpriv user, but that is a bit inconsistent...
> > > >
> > > > Oh, now I see where you are coming from :) Thanks for explanation. And
> > > > remind me please, cannot we just have internal FAN_REPORT_PID flag that
> > > > gets set on notification group when priviledged process creates it and then
> > > > test for that instead of CAP_SYS_ADMIN in copy_event_to_user()? It is
> > > > mostly equivalent but I guess more in the spirit of how fanotify
> > > > traditionally does things. Also FAN_REPORT_PIDFD could then behave in the
> > > > same way...
> > >
> > > Yes, we can. In fact, we should call the internal flag FANOTIFY_UNPRIV
> > > as it described the situation better than FAN_REPORT_PID.
> > > This happens to be how I implemented it in the initial RFC [1].
> > >
> > > It's not easy to follow our entire discussion on this thread, but I think
> > > we can resurrect the FANOTIFY_UNPRIV internal flag and use it
> > > in this case instead of CAP_SYS_ADMIN.
> >
> > I think at that time we were discussing how to handle opening of fds and
> > we decided to not depend on FANOTIFY_UNPRIV and then I didn't see a value
> > of that flag because I forgot about pids... Anyway now I agree to go for
> > that flag. :)
>
> Resurrection of this flag SGTM! However, it also sounds like we need
> to land that series before this PIDFD series or simply incorporate the
> UNPRIV flag into this one.
>
> Will chat with Amir to get this done.

Let me post this patch as a fix patch to unprivileged group.

Thanks,
Amir.
