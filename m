Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CFA361A52
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDPHGb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 03:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbhDPHGb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 03:06:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AECC061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 00:06:07 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id w10so18612263pgh.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Apr 2021 00:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vjpmuxHyMjii3r2pm6DpdE7TeaKlqyvT0ovLNJZFYZA=;
        b=aJ6jBdnF+6xQkJnDM4iQgXqcrhFKbJVxWGQcuu1gd/ekHTy5/C17MQU63Si/P3PyrO
         gK/8eyfBAEXZkUqXLSE7D9AX8BlskX3RhOwM6fe3rOGgIVUZr0D/BzFYs2ABeime/UGX
         236t2FI9gWwNTf5EAUfjkkYCx9VhLjdG2RF1yW8PRK5Ry68bmXT0vDTKR2n2Ew9XsXv1
         9gNyk82tLzCepjjwsC+VSqAJhPPkIZOD0fGTWTes3V1yuXmA/+WUUwmskTYwfUo292UK
         qWBw+T0FieFKRqvMxTu4wDYy7NR0NrpUnP3Ieqn8Nb+2OvQbutCaZKtJQlJ8V6s6kbIo
         6ixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vjpmuxHyMjii3r2pm6DpdE7TeaKlqyvT0ovLNJZFYZA=;
        b=X6R6cvf5pwLNQ9rfPwW/dzZTa91dG+Ekkpw2D7EvBi4kJJtKgZ4nUSZOznakGrG1eI
         e+2eYVDwZ1f/3B2bMxYzW1sjQRfj8ehr97wennMgk73L3H2ttCb2eMcqvM4S2ygazOHa
         fiVP/+dMGUNP+CecUCASBTlKz1KUJqjyNl3cx0LjAfhUuPFzQZO350DQP8LmFHunAnUq
         sOH38pLlxyPIg3051RrrPUtJrxFbVmUgzMLgOEkbU9wn2pGQ+JfyMiPVf1BgKFy5WL21
         6lUSRh8lce3sN7PUiC8UWdGLne8NOA1Mpe1n21Cvr8aMh9Xx3l3+GqgkjXRnnfy5JxY3
         w6Jw==
X-Gm-Message-State: AOAM533M6MFVmNMOhT5NSqy+efxIi++tfePkjz7e5ctMYsDSyDpQQ1Ab
        izlmVW0HW6GMuiRyav6E9rYezoyDC6MdAS+8
X-Google-Smtp-Source: ABdhPJy25PJ0W0eXCOiMU+JG3LcxQC0Ab/oHOHP5vxieTOXX1iUgoMtmYRBLxPoPytfxr7XRajOiYw==
X-Received: by 2002:a05:6a00:1386:b029:24b:6967:117f with SMTP id t6-20020a056a001386b029024b6967117fmr6800095pfg.26.1618556766494;
        Fri, 16 Apr 2021 00:06:06 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:c78c:fbb:2641:bc93])
        by smtp.gmail.com with ESMTPSA id h8sm4426746pjp.37.2021.04.16.00.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 00:06:05 -0700 (PDT)
Date:   Fri, 16 Apr 2021 17:05:54 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 2/2] fanotify: Add pidfd support to the fanotify API
Message-ID: <YHk3Uko0feh3ud/X@google.com>
References: <cover.1618527437.git.repnop@google.com>
 <e6cd967f45381d20d67c9d5a3e49e3cb9808f65b.1618527437.git.repnop@google.com>
 <CAOQ4uxhWicqpKQxvuN5=WiULwNRozFvxQKgTDMOL-UxKpnk-WQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhWicqpKQxvuN5=WiULwNRozFvxQKgTDMOL-UxKpnk-WQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 16, 2021 at 09:27:03AM +0300, Amir Goldstein wrote:
> On Fri, Apr 16, 2021 at 2:22 AM Matthew Bobrowski <repnop@google.com> wrote:
> >
> > Introduce a new flag FAN_REPORT_PIDFD for fanotify_init(2) which
> > allows userspace applications to control whether a pidfd is to be
> > returned instead of a pid for `struct fanotify_event_metadata.pid`.
> >
> > FAN_REPORT_PIDFD is mutually exclusive with FAN_REPORT_TID as the
> > pidfd API is currently restricted to only support pidfd generation for
> > thread-group leaders. Attempting to set them both when calling
> > fanotify_init(2) will result in -EINVAL being returned to the
> > caller. As the pidfd API evolves and support is added for tids, this
> > is something that could be relaxed in the future.
> >
> > If pidfd creation fails, the pid in struct fanotify_event_metadata is
> > set to FAN_NOPIDFD(-1).
> 
> Hi Matthew,
> 
> All in all looks good, just a few small nits.

Thanks for feedback Amir! :)

> > Falling back and providing a pid instead of a
> > pidfd on pidfd creation failures was considered, although this could
> > possibly lead to confusion and unpredictability within userspace
> > applications as distinguishing between whether an actual pidfd or pid
> > was returned could be difficult, so it's best to be explicit.
> 
> I don't think this should have been even "considered" so I see little
> value in this paragraph in commit message.

Fair point. I will discard this sentence for all subsequent iterations
of this patch series. I guess the idea was that this patch series was
meant to be labeled as being "RFC", so some extra thoughts had been
noted.
 
> > Signed-off-by: Matthew Bobrowski <repnop@google.com>
> > ---
> >  fs/notify/fanotify/fanotify_user.c | 33 +++++++++++++++++++++++++++---
> >  include/linux/fanotify.h           |  2 +-
> >  include/uapi/linux/fanotify.h      |  2 ++
> >  3 files changed, 33 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 9e0c1afac8bd..fd8ae88796a8 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -329,7 +329,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         struct fanotify_info *info = fanotify_event_info(event);
> >         unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> >         struct file *f = NULL;
> > -       int ret, fd = FAN_NOFD;
> > +       int ret, pidfd, fd = FAN_NOFD;
> >         int info_type = 0;
> >
> >         pr_debug("%s: group=%p event=%p\n", __func__, group, event);
> > @@ -340,7 +340,25 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
> >         metadata.vers = FANOTIFY_METADATA_VERSION;
> >         metadata.reserved = 0;
> >         metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> > -       metadata.pid = pid_vnr(event->pid);
> > +
> > +       if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> > +               pid_has_task(event->pid, PIDTYPE_TGID)) {
> > +               /*
> > +                * Given FAN_REPORT_PIDFD is to be mutually exclusive with
> > +                * FAN_REPORT_TID, panic here if the mutual exclusion is ever
> > +                * blindly lifted without pidfds for threads actually being
> > +                * supported.
> > +                */
> > +               WARN_ON(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> 
> Better WARN_ON_ONCE() the outcome of this error is not terrible.
> Also in the comment above I would not refer to this warning as "panic".

ACK.

> > +
> > +               pidfd = pidfd_create(event->pid, 0);
> > +               if (unlikely(pidfd < 0))
> > +                       metadata.pid = FAN_NOPIDFD;
> > +               else
> > +                       metadata.pid = pidfd;
> > +       } else {
> > +               metadata.pid = pid_vnr(event->pid);
> > +       }
> 
> You should rebase your work on:
> git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git fsnotify
> and resolve conflicts with "unprivileged listener" code.

ACK.

> Need to make sure that pidfd is not reported to an unprivileged
> listener even if group was initialized by a privileged process.
> This is a conscious conservative choice that we made for reporting
> pid info to unprivileged listener that can be revisited in the future.

OK, I see. In that case, I guess I can add the FAN_REPORT_PIDFD check
above the current conditional [0]:

...
if (!capable(CAP_SYS_ADMIN) && task_tgid(current) != event->pid)
        metadata.pid = 0;
...

That way, AFAIK even if it is an unprivileged listener the pid info
will be overwritten as intended.

> >
> >         if (path && path->mnt && path->dentry) {
> >                 fd = create_fd(group, path, &f);
> > @@ -941,6 +959,15 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
> >  #endif
> >                 return -EINVAL;
> >
> > +       /*
> > +        * A pidfd can only be returned for a thread-group leader; thus
> > +        * FAN_REPORT_TID and FAN_REPORT_PIDFD need to be mutually
> > +        * exclusive. Once the pidfd API supports the creation of pidfds on
> > +        * individual threads, then we can look at removing this conditional.
> > +        */
> > +       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> > +               return -EINVAL;
> > +
> >         if (event_f_flags & ~FANOTIFY_INIT_ALL_EVENT_F_BITS)
> >                 return -EINVAL;
> >
> > @@ -1312,7 +1339,7 @@ SYSCALL32_DEFINE6(fanotify_mark,
> >   */
> >  static int __init fanotify_user_setup(void)
> >  {
> > -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
> > +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 11);
> >         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
> >
> >         fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index 3e9c56ee651f..894740a6f4e0 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -21,7 +21,7 @@
> >  #define FANOTIFY_FID_BITS      (FAN_REPORT_FID | FAN_REPORT_DFID_NAME)
> >
> >  #define FANOTIFY_INIT_FLAGS    (FANOTIFY_CLASS_BITS | FANOTIFY_FID_BITS | \
> > -                                FAN_REPORT_TID | \
> > +                                FAN_REPORT_TID | FAN_REPORT_PIDFD | \
> >                                  FAN_CLOEXEC | FAN_NONBLOCK | \
> >                                  FAN_UNLIMITED_QUEUE | FAN_UNLIMITED_MARKS)
> >
> 
> FAN_REPORT_PIDFD should be added to FANOTIFY_ADMIN_INIT_FLAGS
> from fsnotify branch.

ACK.

Before sending any other version of this patch series through I will
see what Jan and Christian have to say.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/tree/fs/notify/fanotify/fanotify_user.c?h=fsnotify&id=7cea2a3c505e87a9d6afc78be4a7f7be636a73a7#n427  

/M
