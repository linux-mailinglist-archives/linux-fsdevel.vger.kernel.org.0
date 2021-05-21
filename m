Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E197238C56F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhEULMJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233908AbhEULMI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 07:12:08 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809C9C061574;
        Fri, 21 May 2021 04:10:44 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e10so16255166ilu.11;
        Fri, 21 May 2021 04:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gaKn4yGjT9gaj7YKUAqK9J1HfqHrQHS/iU/uvw9DBb0=;
        b=a6ZXlKZCquLwJcVAmZRVx+96M8koKy6YuTLFcvx7yJ4l5wJOivdGIXA0C/RLnxOhUu
         PEtdb2J0opXvLrF+a4uAENoo0tg465jRDXYDzXbm93Ot4qx49k5VwEuVOiRiGZYXZXDF
         iTW6DG2BP4jpqhaBdw8D81FhAICzV6x+20wJ6GLNzJnlFdqowErx9wwWTsDI6bunxi4z
         4PF41GFPg6u4bBNS10AbkGmqhIPITjmiYgODfaBv5br/KMyVRIU68H9G8HQ5O/49MVU9
         QvXdHbup5u8xiyFI++lRs5FDUTPzcvyiYBV2tCMRefWiFxkIxmnYxbqTN/UceDRwF4mh
         EecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gaKn4yGjT9gaj7YKUAqK9J1HfqHrQHS/iU/uvw9DBb0=;
        b=FeMBUC5INMQ9Bh2/uBV0WvMdnGI07Ijyi+KU0+arCDWBidyJHh1OyOHr2tHJwF84UX
         ItuO6wYcSeoSBKpkdjWkMc6Exz7W2lmu7Fnj7PTqSvw7PTfpbMPoPHmzY3sqvu9GpugC
         Ju//djoWjTyUAN1zWUYgiUYweqJIIBuUemA04P9FmjLNiK8xD0Q5bayHTUA+CL2zQNH0
         FntZ5Qs8JV3GiqqNogTtQbMVf2AucIdP68X49PLLVUIn0Q6uM7JOLAMCDjodv8fgsOe1
         HPdSUlKpxxxMNPAkHEH2zW+zQM92C8qWuRU3nfoasuYJd1+TZ8N18QCPzzzpxb8LkaRw
         wIfw==
X-Gm-Message-State: AOAM533/oqc2P9ZwjcM3PRRL/fbX21OI3clsjFyaQWigwkmBTHkdkn6B
        1s7Jirf4d79E1jlAhFuMQJ7MU7XRoVdHOjT8btGWlFvKDwo=
X-Google-Smtp-Source: ABdhPJz7msUGwKbiOfh4Is5lgqtcO3hN5qM98wvzIOOcJZzjdThoWm7xKOtt+5EbsGu9SyAtkYga+LgPK6oANvQCjlQ=
X-Received: by 2002:a05:6e02:1a67:: with SMTP id w7mr9500501ilv.137.1621595443846;
 Fri, 21 May 2021 04:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621473846.git.repnop@google.com> <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein> <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com> <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
 <20210521102418.GF18952@quack2.suse.cz>
In-Reply-To: <20210521102418.GF18952@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 14:10:32 +0300
Message-ID: <CAOQ4uxh84uXAQzz2w+TD1OeDtVwBX8uhM3Pumm46YvP-Wkndag@mail.gmail.com>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 21-05-21 12:41:51, Amir Goldstein wrote:
> > On Fri, May 21, 2021 at 12:22 PM Matthew Bobrowski <repnop@google.com> wrote:
> > >
> > > Hey Amir/Christian,
> > >
> > > On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> > > > On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > > > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > > > > +     sizeof(struct fanotify_event_info_pidfd)
> > > > > >
> > > > > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > > > > >  {
> > > > > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > > > > >       if (fh_len)
> > > > > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > > > > >
> > > > > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > > > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > +
> > > > > >       return info_len;
> > > > > >  }
> > > > > >
> > > > > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > > > > >       return info_len;
> > > > > >  }
> > > > > >
> > > > > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > > > > +                                char __user *buf,
> > > > > > +                                size_t count)
> > > > > > +{
> > > > > > +     struct fanotify_event_info_pidfd info = { };
> > > > > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > +
> > > > > > +     if (WARN_ON_ONCE(info_len > count))
> > > > > > +             return -EFAULT;
> > > > > > +
> > > > > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > > > > +     info.hdr.len = info_len;
> > > > > > +
> > > > > > +     info.pidfd = pidfd_create(pid, 0);
> > > > > > +     if (info.pidfd < 0)
> > > > > > +             info.pidfd = FAN_NOPIDFD;
> > > > > > +
> > > > > > +     if (copy_to_user(buf, &info, info_len))
> > > > > > +             return -EFAULT;
> > > > >
> > > > > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > > > > fd table and when the copy_to_user() failed they won't know what fd it
> > > >
> > > > Good catch!
> > >
> > > Super awesome catch Christian, thanks pulling this up!
> > >
> > > > But I prefer to solve it differently, because moving fd_install() to the
> > > > end of this function does not guarantee that copy_event_to_user()
> > > > won't return an error one day with dangling pidfd in fd table.
> > >
> > > I can see the angle you're approaching this from...
> > >
> > > > It might be simpler to do pidfd_create() next to create_fd() in
> > > > copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> > > > pidfd can be closed on error along with fd on out_close_fd label.
> > > >
> > > > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > > > (even though fanotify_init() does check for that).
> > >
> > > I didn't really understand the need for this check here given that the
> > > administrative bits are already being checked for in fanotify_init()
> > > i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> > > thus never walking any of the pidfd_mode paths. Is this just a defense
> > > in depth approach here, or is it something else that I'm missing?
> > >
> >
> > We want to be extra careful not to create privilege escalations,
> > so even if the fanotify fd is leaked or intentionally passed to a less
> > privileged user, it cannot get an open pidfd.
> >
> > IOW, it is *much* easier to be defensive in this case than to prove
> > that the change cannot introduce any privilege escalations.
>
> I have no problems with being more defensive (it's certainly better than
> being too lax) but does it really make sence here? I mean if CAP_SYS_ADMIN
> task opens O_RDWR /etc/passwd and then passes this fd to unpriviledged
> process, that process is also free to update all the passwords.
> Traditionally permission checks in Unix are performed on open and then who
> has fd can do whatever that fd allows... I've tried to follow similar
> philosophy with fanotify as well and e.g. open happening as a result of
> fanotify path events does not check permissions either.
>

Agreed.

However, because we had this issue with no explicit FAN_REPORT_PID
we added the CAP_SYS_ADMIN check for reporting event->pid as next
best thing. So now that becomes weird if priv process created fanotify fd
and passes it to unpriv process, then unpriv process gets events with
pidfd but without event->pid.

We can change the code to:

        if (!capable(CAP_SYS_ADMIN) && !pidfd_mode &&
            task_tgid(current) != event->pid)
                metadata.pid = 0;

So the case I decscribed above ends up reporting both pidfd
and event->pid to unpriv user, but that is a bit inconsistent...

Thanks,
Amir.
