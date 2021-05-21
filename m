Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CDC38C8B5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhEUNxp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 09:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbhEUNxo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 09:53:44 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E11BC061763;
        Fri, 21 May 2021 06:52:20 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id t11so20141098iol.9;
        Fri, 21 May 2021 06:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/z49A5xjYjstfAwWBD6lDPYDhb3OM0GCCVdyr2X27lk=;
        b=uwfoywKocI8W9RyMdxvN3Fyu2abc+f09wVFGFSqdsFho2MBA+jA3RiTz/L/E1KvtGR
         8T4b7DtDgoH66320z2ekWTUzQWEbKdLSQaS/2sh5kGymWkkxvf3K/VKEjsyTExJISpOL
         PU8PG+FLfbxzHzwQgila4oGvxDH7DxKMmBodYAYwZSNzNF8wFyFsJUcldpYk2xXhFB/M
         sTmMsKCYN7wftxO04wsgyUPgPe8x2imFBAVf+h4Y9ntntF0X4Q+Cs7HR/AeN+WTOT5bC
         kQun7XEPHVR7Jc02L1erks7opluDvO9qmSZk/FcppClHNSVJtJJYR1njb7L6JOM/Bt3J
         Zm9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/z49A5xjYjstfAwWBD6lDPYDhb3OM0GCCVdyr2X27lk=;
        b=puLSHjZE0Ygb3DUBucb34toPrpIzxYOaTGTPi1KkTuwXAlbsEJVK59S/x/FofRKIZx
         gDR2ihXHk1aXdLw4rTz1kVe0iJ0yjBlwfWfZCFs/DXGD5v8JuxjJmO867q1sEbRxIy8Q
         baqesRf7J5f1EI3vdAWIBv9XmZeH+sGf9G11jonrGWdX4dNhmTIad5XJllOJdrd8uB8v
         XWIpnY+gTF1PSBRE1zyTLBRFLiT0/eSIu8zjhu8ZJY1133Fcu3MuL7kd6meRbQBjQD+4
         vmRjd5TXuX5LSpErIVF5R+bwNXYAt+lG2w/IjsLVKpnlpr/aXQLPMkl7mh9VTRsSAN+X
         VsyA==
X-Gm-Message-State: AOAM530IRBdTAZFf8k8Ab+O2ctRcW6xRiIk3pvIjMDUexefTB3lbOsuu
        AWObd0j2N98Y9X5GzTxSVPkuC/uvgYo5zPKp+gzWWpFcd5w=
X-Google-Smtp-Source: ABdhPJx6/UfGhm7BGjDZbtF0JOc1IR8ovWq6nj8EYz3mPzb/CQBAZFEWz0XndpvCe9bLi3pnvXpvCQl9bJ43xz/FtwQ=
X-Received: by 2002:a5d:814d:: with SMTP id f13mr11378158ioo.203.1621605139351;
 Fri, 21 May 2021 06:52:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621473846.git.repnop@google.com> <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein> <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com> <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
 <20210521102418.GF18952@quack2.suse.cz> <CAOQ4uxh84uXAQzz2w+TD1OeDtVwBX8uhM3Pumm46YvP-Wkndag@mail.gmail.com>
 <20210521131917.GM18952@quack2.suse.cz>
In-Reply-To: <20210521131917.GM18952@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 16:52:08 +0300
Message-ID: <CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com>
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

On Fri, May 21, 2021 at 4:19 PM Jan Kara <jack@suse.cz> wrote:
>
> On Fri 21-05-21 14:10:32, Amir Goldstein wrote:
> > On Fri, May 21, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 21-05-21 12:41:51, Amir Goldstein wrote:
> > > > On Fri, May 21, 2021 at 12:22 PM Matthew Bobrowski <repnop@google.com> wrote:
> > > > >
> > > > > Hey Amir/Christian,
> > > > >
> > > > > On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> > > > > > On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> > > > > > <christian.brauner@ubuntu.com> wrote:
> > > > > > > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > > > > > > +     sizeof(struct fanotify_event_info_pidfd)
> > > > > > > >
> > > > > > > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > > > > > > >  {
> > > > > > > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > > > > > > >       if (fh_len)
> > > > > > > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > > > > > > >
> > > > > > > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > > > > > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > > > +
> > > > > > > >       return info_len;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > > > > > > >       return info_len;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > > > > > > +                                char __user *buf,
> > > > > > > > +                                size_t count)
> > > > > > > > +{
> > > > > > > > +     struct fanotify_event_info_pidfd info = { };
> > > > > > > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > > > +
> > > > > > > > +     if (WARN_ON_ONCE(info_len > count))
> > > > > > > > +             return -EFAULT;
> > > > > > > > +
> > > > > > > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > > > > > > +     info.hdr.len = info_len;
> > > > > > > > +
> > > > > > > > +     info.pidfd = pidfd_create(pid, 0);
> > > > > > > > +     if (info.pidfd < 0)
> > > > > > > > +             info.pidfd = FAN_NOPIDFD;
> > > > > > > > +
> > > > > > > > +     if (copy_to_user(buf, &info, info_len))
> > > > > > > > +             return -EFAULT;
> > > > > > >
> > > > > > > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > > > > > > fd table and when the copy_to_user() failed they won't know what fd it
> > > > > >
> > > > > > Good catch!
> > > > >
> > > > > Super awesome catch Christian, thanks pulling this up!
> > > > >
> > > > > > But I prefer to solve it differently, because moving fd_install() to the
> > > > > > end of this function does not guarantee that copy_event_to_user()
> > > > > > won't return an error one day with dangling pidfd in fd table.
> > > > >
> > > > > I can see the angle you're approaching this from...
> > > > >
> > > > > > It might be simpler to do pidfd_create() next to create_fd() in
> > > > > > copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> > > > > > pidfd can be closed on error along with fd on out_close_fd label.
> > > > > >
> > > > > > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > > > > > (even though fanotify_init() does check for that).
> > > > >
> > > > > I didn't really understand the need for this check here given that the
> > > > > administrative bits are already being checked for in fanotify_init()
> > > > > i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> > > > > thus never walking any of the pidfd_mode paths. Is this just a defense
> > > > > in depth approach here, or is it something else that I'm missing?
> > > > >
> > > >
> > > > We want to be extra careful not to create privilege escalations,
> > > > so even if the fanotify fd is leaked or intentionally passed to a less
> > > > privileged user, it cannot get an open pidfd.
> > > >
> > > > IOW, it is *much* easier to be defensive in this case than to prove
> > > > that the change cannot introduce any privilege escalations.
> > >
> > > I have no problems with being more defensive (it's certainly better than
> > > being too lax) but does it really make sence here? I mean if CAP_SYS_ADMIN
> > > task opens O_RDWR /etc/passwd and then passes this fd to unpriviledged
> > > process, that process is also free to update all the passwords.
> > > Traditionally permission checks in Unix are performed on open and then who
> > > has fd can do whatever that fd allows... I've tried to follow similar
> > > philosophy with fanotify as well and e.g. open happening as a result of
> > > fanotify path events does not check permissions either.
> > >
> >
> > Agreed.
> >
> > However, because we had this issue with no explicit FAN_REPORT_PID
> > we added the CAP_SYS_ADMIN check for reporting event->pid as next
> > best thing. So now that becomes weird if priv process created fanotify fd
> > and passes it to unpriv process, then unpriv process gets events with
> > pidfd but without event->pid.
> >
> > We can change the code to:
> >
> >         if (!capable(CAP_SYS_ADMIN) && !pidfd_mode &&
> >             task_tgid(current) != event->pid)
> >                 metadata.pid = 0;
> >
> > So the case I decscribed above ends up reporting both pidfd
> > and event->pid to unpriv user, but that is a bit inconsistent...
>
> Oh, now I see where you are coming from :) Thanks for explanation. And
> remind me please, cannot we just have internal FAN_REPORT_PID flag that
> gets set on notification group when priviledged process creates it and then
> test for that instead of CAP_SYS_ADMIN in copy_event_to_user()? It is
> mostly equivalent but I guess more in the spirit of how fanotify
> traditionally does things. Also FAN_REPORT_PIDFD could then behave in the
> same way...

Yes, we can. In fact, we should call the internal flag FANOTIFY_UNPRIV
as it described the situation better than FAN_REPORT_PID.
This happens to be how I implemented it in the initial RFC [1].

It's not easy to follow our entire discussion on this thread, but I think
we can resurrect the FANOTIFY_UNPRIV internal flag and use it
in this case instead of CAP_SYS_ADMIN.

Thanks,
Amir.

https://lore.kernel.org/linux-fsdevel/20210124184204.899729-3-amir73il@gmail.com/
