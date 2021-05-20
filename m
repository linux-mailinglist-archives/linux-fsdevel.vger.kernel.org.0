Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA2838B042
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 May 2021 15:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbhETNpX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 May 2021 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233043AbhETNpW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 May 2021 09:45:22 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76327C061760;
        Thu, 20 May 2021 06:44:00 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a11so16661325ioo.0;
        Thu, 20 May 2021 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJ/cu409TSJac+Q3bvDnyR+oNvORf0Y0D/jOokgZy7M=;
        b=kXMiOBc9L77rdxQ9G3AJcgEMyHG3l82zJoh1xcOMiypjlFhkViabkhko5120nizPat
         j98AtPtObxJFwHzZ6wUfFj4F7g1IYsyEaHBBgDvQDaw1O4mZS3lbd/QhzZhlzIpiEBRf
         ET+0Ef65di7Ao7EPR9UPMAQbyMWzVx1CWRnK5GzEbOYkeC9A+3JKbf7uYrYUMSEuh2gK
         WeO7OCvBCc2n3CCMhyrCmgCDg73mvP7OBcaA9AH7YevskNholsJ/ypQ7UmCOZ5D+TrxP
         PecL3U7Y+OKz7yyxxaSKFtL9GHLHMV0A05UQdhUf/azrzu182S+3dl9clrzK5vzTTV44
         OjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJ/cu409TSJac+Q3bvDnyR+oNvORf0Y0D/jOokgZy7M=;
        b=h6cxGNn0txUZySNghDaMiDxjQZcvUxXu051A4CQEUwquZfKErhtyxZZDdA5cNCHW57
         EOdEGq2ebk720bD1ssD89mVBuq5CyxVwIGTDE31JdcDc+KYdu7w11USHfQcSsupTXL88
         3++SyiCFMJANxaI1fzrSHvlivNDp/54/QjJsL2gRhdbBhrF4vgPqyuEk3KcSxRJR1K3R
         p+rGj04EIiUNJ8k4740MxN3NsX72WqLnVZS9KIP3IeYtDHuVpa3zD8iA9LqDiByHDDkR
         n3rLtqmdrETijgA8yKpeEdN9nTQvDT7bI9IZL0K8l9oNrwIF/tsHwk4NSaMygu+SFfgV
         5dWQ==
X-Gm-Message-State: AOAM5310wpbcYQOW9X6eqJO6YuqxAsvMlTHlVzO8QhNRizxsfpw2iEI7
        GIohER/jVR1giaxBmi9Dl8cz59XGwI5NgEV6btKKjgCRUDk=
X-Google-Smtp-Source: ABdhPJxmpM2qe5j8I7dHGJC1zvVE0IZcdNudt4VXf/u7oihEuGUgQl8Bq1eHNfO+vQWkJKbqZCyEA6qt2KRCcqRjoLU=
X-Received: by 2002:a6b:3119:: with SMTP id j25mr4978177ioa.64.1621518239736;
 Thu, 20 May 2021 06:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1621473846.git.repnop@google.com> <48d18055deb4617d97c695a08dca77eb573097e9.1621473846.git.repnop@google.com>
 <20210520081755.eqey4ryngngt4yqd@wittgenstein>
In-Reply-To: <20210520081755.eqey4ryngngt4yqd@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 20 May 2021 16:43:48 +0300
Message-ID: <CAOQ4uxhvD2w1i3ia=8=4iCNEYDJ3wfps6AOLdUBXVi-H9Xu-OQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] fanotify: Add pidfd info record support to the
 fanotify API
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 20, 2021 at 11:17 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Thu, May 20, 2021 at 12:11:51PM +1000, Matthew Bobrowski wrote:
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd info record
> > containing a pidfd is to be returned with each event.
> >
> > If FAN_REPORT_PIDFD is enabled for a notification group, an additional
> > struct fanotify_event_info_pidfd object will be supplied alongside the
> > generic struct fanotify_event_metadata within a single event. This
> > functionality is analogous to that of FAN_REPORT_FID in terms of how
> > the event structure is supplied to the userspace application. Usage of
> > FAN_REPORT_PIDFD with FAN_REPORT_FID/FAN_REPORT_DFID_NAME is
> > permitted, and in this case a struct fanotify_event_info_pidfd object
> > will follow any struct fanotify_event_info_fid object.
> >
> > Usage of FAN_REPORT_TID is not permitted with FAN_REPORT_PIDFD as the
> > pidfd API only supports the creation of pidfds for thread-group
> > leaders. Attempting to do so will result with a -EINVAL being returned
> > when calling fanotify_init(2).
> >
> > If pidfd creation fails via pidfd_create(), the pidfd field within
> > struct fanotify_event_info_pidfd is set to FAN_NOPIDFD.
> >
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 65 +++++++++++++++++++++++++++---
> >  include/linux/fanotify.h           |  3 +-
> >  include/uapi/linux/fanotify.h      | 12 ++++++
> >  3 files changed, 74 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 1e15f3222eb2..bba61988f4a0 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -106,6 +106,8 @@ struct kmem_cache *fanotify_perm_event_cachep __read_mostly;
> >  #define FANOTIFY_EVENT_ALIGN 4
> >  #define FANOTIFY_FID_INFO_HDR_LEN \
> >       (sizeof(struct fanotify_event_info_fid) + sizeof(struct file_handle))
> > +#define FANOTIFY_PIDFD_INFO_HDR_LEN \
> > +     sizeof(struct fanotify_event_info_pidfd)
> >
> >  static int fanotify_fid_info_len(int fh_len, int name_len)
> >  {
> > @@ -141,6 +143,9 @@ static int fanotify_event_info_len(unsigned int info_mode,
> >       if (fh_len)
> >               info_len += fanotify_fid_info_len(fh_len, dot_len);
> >
> > +     if (info_mode & FAN_REPORT_PIDFD)
> > +             info_len += FANOTIFY_PIDFD_INFO_HDR_LEN;
> > +
> >       return info_len;
> >  }
> >
> > @@ -401,6 +406,29 @@ static int copy_fid_info_to_user(__kernel_fsid_t *fsid,
> >       return info_len;
> >  }
> >
> > +static int copy_pidfd_info_to_user(struct pid *pid,
> > +                                char __user *buf,
> > +                                size_t count)
> > +{
> > +     struct fanotify_event_info_pidfd info = { };
> > +     size_t info_len = FANOTIFY_PIDFD_INFO_HDR_LEN;
> > +
> > +     if (WARN_ON_ONCE(info_len > count))
> > +             return -EFAULT;
> > +
> > +     info.hdr.info_type = FAN_EVENT_INFO_TYPE_PIDFD;
> > +     info.hdr.len = info_len;
> > +
> > +     info.pidfd = pidfd_create(pid, 0);
> > +     if (info.pidfd < 0)
> > +             info.pidfd = FAN_NOPIDFD;
> > +
> > +     if (copy_to_user(buf, &info, info_len))
> > +             return -EFAULT;
>
> Hm, well this kinda sucks. The caller can end up with a pidfd in their
> fd table and when the copy_to_user() failed they won't know what fd it

Good catch!
But I prefer to solve it differently, because moving fd_install() to the
end of this function does not guarantee that copy_event_to_user()
won't return an error one day with dangling pidfd in fd table.

It might be simpler to do pidfd_create() next to create_fd() in
copy_event_to_user() and pass pidfd to copy_pidfd_info_to_user().
pidfd can be closed on error along with fd on out_close_fd label.

You also forgot to add CAP_SYS_ADMIN check before pidfd_create()
(even though fanotify_init() does check for that).

Anyway, something like:

        if (!capable(CAP_SYS_ADMIN) &&
            task_tgid(current) != event->pid)
                metadata.pid = 0;
+      else if (pidfd_mode)
+              pidfd = pidfd_create(pid, 0);

[...]

+       if (pidfd_mode)
+               ret = copy_pidfd_info_to_user(pidfd, buf, count);

        return metadata.event_len;

out_close_fd:
+        if (pidfd != FAN_NOPIDFD) {
...


And in any case, it wrong to call copy_pidfd_info_to_user() from
copy_info_to_user(). It needs to be called once from copy_event_to_user()
because copy_pidfd_info_to_user() may be called twice to report both
FAN_EVENT_INFO_TYPE_FID and FAN_EVENT_INFO_TYPE_DFID
records for the same event.

Thanks,
Amir.
