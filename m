Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA738C2FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhEUJXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236261AbhEUJXf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:23:35 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6D2C0613CE
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 02:22:12 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id 22so14086238pfv.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 May 2021 02:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CxcTdu4LEVK1X/qRcHTkFo5KF6re61xKqQsQu0+20VA=;
        b=fuF9lJwWpElOc/XGr5eY5YkzEltYO7J5XJRKZyyh3o2BdKErPel1MXWr46lnr8TEpz
         E3480QIFoRAvIb9LRAujLMlqULXVcFnqvYYRxbQ8PArsZiKixeC2frV27hdUT5TjQ9K+
         QZycriB9W251AOmP6tMkt1wnMSsQn2Pbl6P5b4rpmoR/6NCjNT3N1TiU6PC+iMq4PaGF
         DWF8e3AfFAr0DuQ/hpqJe2IdIvCnPDSezmJYSDNE9HuEtug9yLKsOBXAU2uAxaUeThlF
         b/s08M+YQ83Z8JvUZWo1Fst8Fa/RvHzR7MNpj3O0tbygwYRBt74fse5jHu0B0c05Ep7Y
         0SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CxcTdu4LEVK1X/qRcHTkFo5KF6re61xKqQsQu0+20VA=;
        b=X1dchpDPQ6luSab1TWb2oWyyN5NMDZvEX4xInu4BzNtpVJvE0f2TnaG89EEk+izMG3
         SGcFRK4VDpw3+IbSwFPYy4wXhuh7NC7PeikORxiQfIPEb2cS0uY1kvl3fM4pSnH8i/LF
         syjfh4De+B7ZegSwTDPjhBaRnJYmCu2wWli/mOI0oClONPqNcXnOA9s/pY8cyn7fTewN
         S8zgwoEDK8Xg4/TprGQ+XqWxfEojw1m1qqDn5eom+mQsLSdxeYCF+8xRxDM2cJkF0wEM
         YZCAvEvKQ2SWh4/CMJGLV+ewteBtbZ5Vn8FaVKTq+mkG8CdtJ7IddT4R86vCHH6AtfFJ
         NQfQ==
X-Gm-Message-State: AOAM532GHkQvnaV4Y6Uw7QzcqxjcmKm9dkWyUhi9jpHO9hAY8HjocuEJ
        pqbdD6R+J8en/WWVFzZ3rMbzmoOztdJFoA==
X-Google-Smtp-Source: ABdhPJzimlABILKzoBWqV1SWIty9xnWuSqybYsJEn+raC6hR/Sac9mzgpOYZQvZx35SLAPMfbigXpg==
X-Received: by 2002:a63:1224:: with SMTP id h36mr8995715pgl.296.1621588931756;
        Fri, 21 May 2021 02:22:11 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:42b2:c084:8468:626a])
        by smtp.gmail.com with ESMTPSA id 80sm4139071pgc.23.2021.05.21.02.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 02:22:11 -0700 (PDT)
Date:   Fri, 21 May 2021 19:21:58 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
Message-ID: <YKd7tqiVd9ny6+oD@google.com>
References: <cover.1621473846.git.repnop@google.com>
 <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein>
 <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hey Amir/Christian,

On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > +     sizeof(struct fanotify_event_info_pidfd)
> > >
> > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > >  {
> > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > >       if (fh_len)
> > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > >
> > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > +
> > >       return info_len;
> > >  }
> > >
> > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > >       return info_len;
> > >  }
> > >
> > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > +                                char __user *buf,
> > > +                                size_t count)
> > > +{
> > > +     struct fanotify_event_info_pidfd info = { };
> > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > +
> > > +     if (WARN_ON_ONCE(info_len > count))
> > > +             return -EFAULT;
> > > +
> > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > +     info.hdr.len = info_len;
> > > +
> > > +     info.pidfd = pidfd_create(pid, 0);
> > > +     if (info.pidfd < 0)
> > > +             info.pidfd = FAN_NOPIDFD;
> > > +
> > > +     if (copy_to_user(buf, &info, info_len))
> > > +             return -EFAULT;
> >
> > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > fd table and when the copy_to_user() failed they won't know what fd it
> 
> Good catch!

Super awesome catch Christian, thanks pulling this up!

> But I prefer to solve it differently, because moving fd_install() to the
> end of this function does not guarantee that copy_event_to_user()
> won't return an error one day with dangling pidfd in fd table.

I can see the angle you're approaching this from...

> It might be simpler to do pidfd_create() next to create_fd() in
> copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> pidfd can be closed on error along with fd on out_close_fd label.
> 
> You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> (even though fanotify_init() does check for that).

I didn't really understand the need for this check here given that the
administrative bits are already being checked for in fanotify_init()
i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
thus never walking any of the pidfd_mode paths. Is this just a defense
in depth approach here, or is it something else that I'm missing?

> Anyway, something like:
> 
>         if (!capable(CAP_SYS_ADMIN) &&
>             task_tgid(current) != event->pid)
>                 metadata.pid = 0;
> +      else if (pidfd_mode)
> +              pidfd = pidfd_create(pid, 0);
> 
> [...]
> 
> +       if (pidfd_mode)
> +               ret = copy_pidfd_info_to_user(pidfd, buf, count);
> 
>         return metadata.event_len;
> 
> out_close_fd:
> +        if (pidfd != FAN_NOPIDFD) {
> ...

The early call to pidfd_create() and clean up in copy_event_to_user()
makes most sense to me.

> And in any case, it wrong to call copy_pidfd_info_to_user() from
> copy_info_to_user(). It needs to be called once from copy_event_to_user()
> because copy_pidfd_info_to_user() may be called twice to report both
> FAN_EVENT_INFO_TYPE_FID and FAN_EVENT_INFO_TYPE_DFID
> records for the same event.

Right, as mentioned in patch 4 of this series, copy_info_to_user() has
been repurposed to account for the double call into
copy_fid_info_to_user() when reporting FAN_EVENT_INFO_TYPE_FID and
FAN_EVENT_INFO_TYPE_DFID.

/M
