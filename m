Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C493338D2A0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 May 2021 02:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEVAnE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 20:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhEVAnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 20:43:02 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74438C06138C
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 17:41:38 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a7so3147182plh.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 17:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Do8tBe8MKGvYLGV0ouciDO6sfr90+7VufJDC8snUPEk=;
        b=hCTGdwYm3KHmZLXIA1s8Tt3EsWtz80guhJoj3GO2oLO8j5KzTDQq2hlyJrXqAd0zjT
         aPPflvT3D6YRn3NHGIc5bxuqSfybPikU8aLvzX16G2RBA9nAFBbJulcJrjxb+TXal6YY
         /lUkFk9Za8oabPvSiNP0xCi4AxZ5OResG4uAG1TRQyTuuyB6CRhs042hR3I934F1jpQb
         rjiBCHAYSs26BTKg3doorTrc8A6uOd9/YU56ywgcrWWQnP1vN/dIQZj9+ePH9lT0xM9q
         UvOT+Ole23+i1JwUR4NnfHFv+6SjQb+5Nw1/RHl6ketq7o3FBwMdWrV5UjY+5iwEFjSb
         TxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Do8tBe8MKGvYLGV0ouciDO6sfr90+7VufJDC8snUPEk=;
        b=QlLNdenv5Qzy6qr4kiLYeggiK3SbteC0lj9a9x/3es8pTAh1J40T4m1UhsELIrWbso
         l1K9Ye7t+bqMs0zlnowxlffMVmUIE8FRHv6/9jd5ABAGVhZuPsBjh32w62g7V+EqIAp0
         Jp4h8oJDDXVA2601OxVrvLJYltdXYor7BnS8xG7kclcbiikzLFwBvNZgHkc2dofz9CCG
         4x6VWAvncTswO7iIE/FRqAbexplAVpOeRXyPwVPEbYE2QYozpGfad25lSy0ZG37gDOb2
         mrjtXblJ4S4bDZVjB6zEcHyEuK14cW0qettJmSD+KeN47DfYBgDnLPRtb+WJBFc/iTlQ
         aXCw==
X-Gm-Message-State: AOAM530vvy2ksGMd8b4V9zp0UNMyrvGviP+/UYmcIcac6Wbi0vfREAPj
        RltoUXW68d6N+HzWMyNqkwlbjA==
X-Google-Smtp-Source: ABdhPJwruN4mWdld13VPy8AKXxOMTRznaYTadIQjWS3DfaRCZLXeGt3kBdpujYY7DJ1j4bEwdFfZEg==
X-Received: by 2002:a17:902:aa4c:b029:ee:ec17:89f with SMTP id c12-20020a170902aa4cb02900eeec17089fmr14665947plr.11.1621644097595;
        Fri, 21 May 2021 17:41:37 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id x19sm5259561pgj.66.2021.05.21.17.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 17:41:36 -0700 (PDT)
Date:   Sat, 22 May 2021 10:41:24 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
Message-ID: <YKhTNCyQLlqaz3yC@google.com>
References: <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein>
 <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com>
 <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
 <20210521102418.GF18952@quack2.suse.cz>
 <CAOQ4uxh84uXAQzz2w+TD1OeDtVwBX8uhM3Pumm46YvP-Wkndag@mail.gmail.com>
 <20210521131917.GM18952@quack2.suse.cz>
 <CAOQ4uxiA77_P5vtv7e83g0+9d7B5W9ZTE4GfQEYbWmfT1rA=VA@mail.gmail.com>
 <20210521151415.GP18952@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521151415.GP18952@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 05:14:15PM +0200, Jan Kara wrote:
> On Fri 21-05-21 16:52:08, Amir Goldstein wrote:
> > On Fri, May 21, 2021 at 4:19 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Fri 21-05-21 14:10:32, Amir Goldstein wrote:
> > > > On Fri, May 21, 2021 at 1:24 PM Jan Kara <jack@suse.cz> wrote:
> > > > >
> > > > > On Fri 21-05-21 12:41:51, Amir Goldstein wrote:
> > > > > > On Fri, May 21, 2021 at 12:22 PM Matthew Bobrowski <repnop@google.com> wrote:
> > > > > > >
> > > > > > > Hey Amir/Christian,
> > > > > > >
> > > > > > > On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> > > > > > > > On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> > > > > > > > <christian.brauner@ubuntu.com> wrote:
> > > > > > > > > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > > > > > > > > +     sizeof(struct fanotify_event_info_pidfd)
> > > > > > > > > >
> > > > > > > > > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > > > > > > > > >  {
> > > > > > > > > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > > > > > > > > >       if (fh_len)
> > > > > > > > > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > > > > > > > > >
> > > > > > > > > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > > > > > > > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > > > > > +
> > > > > > > > > >       return info_len;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > > > > > > > > >       return info_len;
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > > > > > > > > +                                char __user *buf,
> > > > > > > > > > +                                size_t count)
> > > > > > > > > > +{
> > > > > > > > > > +     struct fanotify_event_info_pidfd info = { };
> > > > > > > > > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > > > > > > > +
> > > > > > > > > > +     if (WARN_ON_ONCE(info_len > count))
> > > > > > > > > > +             return -EFAULT;
> > > > > > > > > > +
> > > > > > > > > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > > > > > > > > +     info.hdr.len = info_len;
> > > > > > > > > > +
> > > > > > > > > > +     info.pidfd = pidfd_create(pid, 0);
> > > > > > > > > > +     if (info.pidfd < 0)
> > > > > > > > > > +             info.pidfd = FAN_NOPIDFD;
> > > > > > > > > > +
> > > > > > > > > > +     if (copy_to_user(buf, &info, info_len))
> > > > > > > > > > +             return -EFAULT;
> > > > > > > > >
> > > > > > > > > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > > > > > > > > fd table and when the copy_to_user() failed they won't know what fd it
> > > > > > > >
> > > > > > > > Good catch!
> > > > > > >
> > > > > > > Super awesome catch Christian, thanks pulling this up!
> > > > > > >
> > > > > > > > But I prefer to solve it differently, because moving fd_install() to the
> > > > > > > > end of this function does not guarantee that copy_event_to_user()
> > > > > > > > won't return an error one day with dangling pidfd in fd table.
> > > > > > >
> > > > > > > I can see the angle you're approaching this from...
> > > > > > >
> > > > > > > > It might be simpler to do pidfd_create() next to create_fd() in
> > > > > > > > copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> > > > > > > > pidfd can be closed on error along with fd on out_close_fd label.
> > > > > > > >
> > > > > > > > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > > > > > > > (even though fanotify_init() does check for that).
> > > > > > >
> > > > > > > I didn't really understand the need for this check here given that the
> > > > > > > administrative bits are already being checked for in fanotify_init()
> > > > > > > i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> > > > > > > thus never walking any of the pidfd_mode paths. Is this just a defense
> > > > > > > in depth approach here, or is it something else that I'm missing?
> > > > > > >
> > > > > >
> > > > > > We want to be extra careful not to create privilege escalations,
> > > > > > so even if the fanotify fd is leaked or intentionally passed to a less
> > > > > > privileged user, it cannot get an open pidfd.
> > > > > >
> > > > > > IOW, it is *much* easier to be defensive in this case than to prove
> > > > > > that the change cannot introduce any privilege escalations.
> > > > >
> > > > > I have no problems with being more defensive (it's certainly better than
> > > > > being too lax) but does it really make sence here? I mean if CAP_SYS_ADMIN
> > > > > task opens O_RDWR /etc/passwd and then passes this fd to unpriviledged
> > > > > process, that process is also free to update all the passwords.
> > > > > Traditionally permission checks in Unix are performed on open and then who
> > > > > has fd can do whatever that fd allows... I've tried to follow similar
> > > > > philosophy with fanotify as well and e.g. open happening as a result of
> > > > > fanotify path events does not check permissions either.
> > > > >
> > > >
> > > > Agreed.
> > > >
> > > > However, because we had this issue with no explicit FAN_REPORT_PID
> > > > we added the CAP_SYS_ADMIN check for reporting event->pid as next
> > > > best thing. So now that becomes weird if priv process created fanotify fd
> > > > and passes it to unpriv process, then unpriv process gets events with
> > > > pidfd but without event->pid.
> > > >
> > > > We can change the code to:
> > > >
> > > >         if (!capable(CAP_SYS_ADMIN) && !pidfd_mode &&
> > > >             task_tgid(current) != event->pid)
> > > >                 metadata.pid = 0;
> > > >
> > > > So the case I decscribed above ends up reporting both pidfd
> > > > and event->pid to unpriv user, but that is a bit inconsistent...
> > >
> > > Oh, now I see where you are coming from :) Thanks for explanation. And
> > > remind me please, cannot we just have internal FAN_REPORT_PID flag that
> > > gets set on notification group when priviledged process creates it and then
> > > test for that instead of CAP_SYS_ADMIN in copy_event_to_user()? It is
> > > mostly equivalent but I guess more in the spirit of how fanotify
> > > traditionally does things. Also FAN_REPORT_PIDFD could then behave in the
> > > same way...
> > 
> > Yes, we can. In fact, we should call the internal flag FANOTIFY_UNPRIV
> > as it described the situation better than FAN_REPORT_PID.
> > This happens to be how I implemented it in the initial RFC [1].
> > 
> > It's not easy to follow our entire discussion on this thread, but I think
> > we can resurrect the FANOTIFY_UNPRIV internal flag and use it
> > in this case instead of CAP_SYS_ADMIN.
> 
> I think at that time we were discussing how to handle opening of fds and
> we decided to not depend on FANOTIFY_UNPRIV and then I didn't see a value
> of that flag because I forgot about pids... Anyway now I agree to go for
> that flag. :)

Resurrection of this flag SGTM! However, it also sounds like we need
to land that series before this PIDFD series or simply incorporate the
UNPRIV flag into this one.

Will chat with Amir to get this done.

/M
