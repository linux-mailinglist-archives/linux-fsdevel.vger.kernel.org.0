Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3538C392
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhEUJne (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236941AbhEUJn1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:43:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C49C0613ED;
        Fri, 21 May 2021 02:42:02 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k132so5912019iof.4;
        Fri, 21 May 2021 02:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X9h8lKyVGWC+EpebJ7yOXW04Rqzngxn+39twx2rBfT8=;
        b=t/o67fKGbqG6qdm1Upw16IvB+TTQbXBcD57G2sfTvOW2/gCQAQCeJ7qJVa9qQD6nF9
         iewXuycHCMdkl3SZXVBb6wYMiL2MDe3KH1Jsn4jgnt5YpjGoL1PxFIkWWr72Ct+Fbcxf
         VEtE9Tw94yU3b9zP/eUIrkr0OslgTgN04rKaVwtG7TcH6MoFdwTzIEvsUwQe8Odb33JS
         5ERNsfhux3tuJdDCgdkhog0/Ukg6TxsqLmfoTynPPWuXB7qObKYj20CJrsE+KaiCSB4P
         D7esMl8UGxNLQi/HESOS1Mh85dPY5VCgvLJ9GOVzXBd95veaiUYWDiOAQWpfug2qOjMs
         BoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X9h8lKyVGWC+EpebJ7yOXW04Rqzngxn+39twx2rBfT8=;
        b=Nw1Vq5tOVTQebeDnrb5mBZBNJmvwhnRIP1nAqTuRUthckz+B0Bt+nYBkBK3vAKWDCM
         DAZjP6+xgs410CasW0hCb+wCxy/JlJChnr1SIteQJvz0KDjknqFA6SigK1nKF/H0g6fg
         rneQQ9T8d9r1YhuWdc8oZSO/Xf9s1HSt8XQWaMWMV/0W8aaUE73NWsI5rIMgvH6WUVdH
         AN0tyw7hP4mVypBdWQ1XUHicMp00gGUGlQ1lY0PMU3ZHM7z5MBAR+DPH40fePzl8W0Hz
         /Dw/7ksJsRapG4SniOc6t+59mSEhZFVLrfgV2IRhfNZKCW4ZtBNyKm/PW1tHAFP18Mf8
         t6qQ==
X-Gm-Message-State: AOAM5337J7RZd+C+KOikqy92efoFjIdsL2TISoZxXBAlboMRC8kFqqVF
        xcvMAIUeebYpxxSqWYB1m103e+IH3Tc02LQ6yhBzh7Ef
X-Google-Smtp-Source: ABdhPJwI2hC/bDJFss30dEOy7wfVemiCa7caONpUaDz9iOdm7IOe5G8L6LkkLs13KWhyDr3eMfmjsM/DsqH3jkjEdGw=
X-Received: by 2002:a02:3505:: with SMTP id k5mr3200284jaa.123.1621590122332;
 Fri, 21 May 2021 02:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621473846.git.repnop@google.com> <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein> <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
 <YKd7tqiVd9ny6+oD@google.com>
In-Reply-To: <YKd7tqiVd9ny6+oD@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:41:51 +0300
Message-ID: <CAOQ4uxi6LceN+ETbF6XbbBqfAY3H+K5ZMuky1L-gh_g53TEN1A@mail.gmail.com>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 12:22 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> Hey Amir/Christian,
>
> On Thu, May 20, 2021 at 04:43:48PM +0300, Amir Goldstein wrote:
> > On Thu, May 20, 2021 at 11:17 AM Christian Brauner
> > <christian.brauner@ubuntu.com> wrote:
> > > > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > > > +     sizeof(struct fanotify_event_info_pidfd)
> > > >
> > > >  static int fanotify_fid_info_len(int fh_len, int name_len)
> > > >  {
> > > > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> > > >       if (fh_len)
> > > >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> > > >
> > > > +     if (info_mode & FAN_REPORT_PIDFD)
> > > > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > +
> > > >       return info_len;
> > > >  }
> > > >
> > > > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> > > >       return info_len;
> > > >  }
> > > >
> > > > +static int copy_pidfd_info_to_user(struct pid *pid,
> > > > +                                char __user *buf,
> > > > +                                size_t count)
> > > > +{
> > > > +     struct fanotify_event_info_pidfd info = { };
> > > > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > > > +
> > > > +     if (WARN_ON_ONCE(info_len > count))
> > > > +             return -EFAULT;
> > > > +
> > > > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > > > +     info.hdr.len = info_len;
> > > > +
> > > > +     info.pidfd = pidfd_create(pid, 0);
> > > > +     if (info.pidfd < 0)
> > > > +             info.pidfd = FAN_NOPIDFD;
> > > > +
> > > > +     if (copy_to_user(buf, &info, info_len))
> > > > +             return -EFAULT;
> > >
> > > Hm, well this kinda sucks. The caller can end up with a pidfd in their
> > > fd table and when the copy_to_user() failed they won't know what fd it
> >
> > Good catch!
>
> Super awesome catch Christian, thanks pulling this up!
>
> > But I prefer to solve it differently, because moving fd_install() to the
> > end of this function does not guarantee that copy_event_to_user()
> > won't return an error one day with dangling pidfd in fd table.
>
> I can see the angle you're approaching this from...
>
> > It might be simpler to do pidfd_create() next to create_fd() in
> > copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
> > pidfd can be closed on error along with fd on out_close_fd label.
> >
> > You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
> > (even though fanotify_init() does check for that).
>
> I didn't really understand the need for this check here given that the
> administrative bits are already being checked for in fanotify_init()
> i.e. FAN_REPORT_PIDFD can never be set for an unprivileged listener;
> thus never walking any of the pidfd_mode paths. Is this just a defense
> in depth approach here, or is it something else that I'm missing?
>

We want to be extra careful not to create privilege escalations,
so even if the fanotify fd is leaked or intentionally passed to a less
privileged user, it cannot get an open pidfd.

IOW, it is *much* easier to be defensive in this case than to prove
that the change cannot introduce any privilege escalations.

Thanks,
Amir.
