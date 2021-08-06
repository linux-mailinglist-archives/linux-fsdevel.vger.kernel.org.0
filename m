Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877FD3E28C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 12:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbhHFKhW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 06:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245198AbhHFKhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:37:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A46DC061799
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 03:37:04 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f13so12362324edq.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 03:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohHKSh+HZImpSVaLM9TW5relpABftXO5BlsVkkQC4Nk=;
        b=XYiFbQ2l+Q6VnSuV3mymGTcQZDcTePXH6XonuZpjEeql1yzQTM9ZnH8pilXV4DIuID
         wDH6SxZ84yHVSzT+rneEwPYnY764gFXIXf+HhKFw7pmiVPSjBq66l4ZgWjUYSTCwwRHD
         IPUSw5iy2QAwSXR9NEQ5CBeG7ZOJ+tyXlrZf35KtgHVSkmO5gEgpWhPREtxIAigx7Q54
         /hu2yhPbubYXMAm1n8gepSozQnWaaEkBbWQywVgce/BXCouIbuLE2sAWeH61kwRES3zS
         fHjzaJPB1ce1I3VvVfSeTCjBvFwjrnOijjBB/6aF9nibTWs7Gs7GGnIyfOOz03U6K9Op
         uzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ohHKSh+HZImpSVaLM9TW5relpABftXO5BlsVkkQC4Nk=;
        b=ZqxqBeLFl4EeW9C6z8WiwB2LTpSnF5taNGuXRlCJaJoHGQ6zlv+7a5QSb4dlJrwdjC
         9r2N67BiKgc9aKQ86uNxp6JAXBvdFobzn3iGi7ln0l/gpfhKCz/ViW8d20/BJ/zqEHtG
         9kwggi5oqw5aD69mnVOSMfrgkHqNk4VHVbSxGtRZTCt0jsvo0b9mqkg51hzZ1wl/J2Kv
         yObdpzHnlnac/kPoBbgaaQ/GRKf6KnwznOtqohb4mPjGAOa5Cmo76zNRQCaYk0Fh3zkW
         yVDqMTzEhyenODi9NVEIcIIpHlU8PP616ompix+aI93o+VUC52CFa4q1fmsxPjxuMva7
         BS2A==
X-Gm-Message-State: AOAM533/fbKKAXGr90o+yDdNzYycIki9yFfCNGDbq1uv5aC+gXkHcn8m
        WRIlnfz/FUP7zu6ZNaDyMXv1G10oHKfecXrRBsOVLQ==
X-Google-Smtp-Source: ABdhPJwngALTFtP2SGuhZhQaLpak7jWhSExOZMtTGHS+YF1ZqsrJ8bWECzb9vFagDm+wJhPNQAl8V06+xBILBLJxK/U=
X-Received: by 2002:aa7:c805:: with SMTP id a5mr11962205edt.23.1628246222536;
 Fri, 06 Aug 2021 03:37:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210730062854.3601635-1-svens@linux.ibm.com> <YQn+GomdRCoYc/E8@Ryzen-9-3900X.localdomain>
 <875ywlat5e.fsf@disp2133> <94478003-8259-4b57-6d93-5a07e0750946@kernel.org>
 <87v94jalck.fsf@disp2133> <56b7c0fe-f2e1-7c4f-eb1b-1d9793dea5a8@kernel.org>
In-Reply-To: <56b7c0fe-f2e1-7c4f-eb1b-1d9793dea5a8@kernel.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 6 Aug 2021 16:06:51 +0530
Message-ID: <CA+G9fYv+Azmu+_YUv6+C6RRM990k0FhUc0hgSJKssubmsWfvhA@mail.gmail.com>
Subject: Re: [PATCH v3] ucounts: add missing data type changes
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, linux-fsdevel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 6 Aug 2021 at 00:56, Nathan Chancellor <nathan@kernel.org> wrote:
>
> On 8/5/2021 9:48 AM, Eric W. Biederman wrote:
> > Nathan Chancellor <nathan@kernel.org> writes:
> >
> >> Hi Eric,
> >>
> >> On 8/4/2021 12:47 PM, Eric W. Biederman wrote:
> >>> Nathan Chancellor <nathan@kernel.org> writes:
> >>>
> >>>> On Fri, Jul 30, 2021 at 08:28:54AM +0200, Sven Schnelle wrote:
> >>>>> commit f9c82a4ea89c3 ("Increase size of ucounts to atomic_long_t")
> >>>>> changed the data type of ucounts/ucounts_max to long, but missed to
> >>>>> adjust a few other places. This is noticeable on big endian platforms
> >>>>> from user space because the /proc/sys/user/max_*_names files all
> >>>>> contain 0.
> >>>>>
> >>>>> Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> >>>>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> >>>>
> >>>> This patch in -next as commit e43fc41d1f7f ("ucounts: add missing data type
> >>>> changes") causes Windows Subsystem for Linux to fail to start:

On Linux next-20210802..next-20210805 we have been noticing
that LTP syscalls inotify06 test case getting failed all architectures.

BAD:
  Linux next-20210802
  inotify06.c:57: TBROK: Failed to close FILE
'/proc/sys/fs/inotify/max_user_instances': EINVAL (22)
  inotify06.c:107: TWARN: Failed to close FILE
'/proc/sys/fs/inotify/max_user_instances': EINVAL (22)

GOOD:
  Linux next-20210730
  inotify06.c:92: TPASS: kernel survived inotify beating

Investigation:
Following changes found between good and bad Linux next tags under fs/notify
git log --oneline --stat next-20210730..next-20210802 fs/notify
e43fc41d1f7f ucounts: add missing data type changes
 fs/notify/fanotify/fanotify_user.c | 10 ++++++----
 fs/notify/inotify/inotify_user.c   | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

Conclusion:
We have confirmed this patch caused the LTP syscalls inotify06 test failure.

After applying your proposed fix patch [1] the reported test getting pass.
However, I have to run full test plan to confirm this do not cause regressions.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

[1] https://lore.kernel.org/lkml/87v94jalck.fsf@disp2133/


> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> > index 6576657a1a25..28b67cb9458d 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -54,6 +54,9 @@ static int fanotify_max_queued_events __read_mostly;
> >
> >   #include <linux/sysctl.h>
> >
> > +static long ft_zero = 0;
> > +static long ft_int_max = INT_MAX;
> > +
> >   struct ctl_table fanotify_table[] = {
> >       {
> >               .procname       = "max_user_groups",
> > @@ -61,8 +64,8 @@ struct ctl_table fanotify_table[] = {
> >               .maxlen         = sizeof(long),
> >               .mode           = 0644,
> >               .proc_handler   = proc_doulongvec_minmax,
> > -             .extra1         = SYSCTL_ZERO,
> > -             .extra2         = SYSCTL_INT_MAX,
> > +             .extra1         = &ft_zero,
> > +             .extra2         = &ft_int_max,
> >       },
> >       {
> >               .procname       = "max_user_marks",
> > @@ -70,8 +73,8 @@ struct ctl_table fanotify_table[] = {
> >               .maxlen         = sizeof(long),
> >               .mode           = 0644,
> >               .proc_handler   = proc_doulongvec_minmax,
> > -             .extra1         = SYSCTL_ZERO,
> > -             .extra2         = SYSCTL_INT_MAX,
> > +             .extra1         = &ft_zero,
> > +             .extra2         = &ft_int_max,
> >       },
> >       {
> >               .procname       = "max_queued_events",
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> > index 55fe7cdea2fb..62051247f6d2 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -55,6 +55,9 @@ struct kmem_cache *inotify_inode_mark_cachep __read_mostly;
> >
> >   #include <linux/sysctl.h>
> >
> > +static long it_zero = 0;
> > +static long it_int_max = INT_MAX;
> > +
> >   struct ctl_table inotify_table[] = {
> >       {
> >               .procname       = "max_user_instances",
> > @@ -62,8 +65,8 @@ struct ctl_table inotify_table[] = {
> >               .maxlen         = sizeof(long),
> >               .mode           = 0644,
> >               .proc_handler   = proc_doulongvec_minmax,
> > -             .extra1         = SYSCTL_ZERO,
> > -             .extra2         = SYSCTL_INT_MAX,
> > +             .extra1         = &it_zero,
> > +             .extra2         = &it_int_max,
> >       },
> >       {
> >               .procname       = "max_user_watches",
> > @@ -71,8 +74,8 @@ struct ctl_table inotify_table[] = {
> >               .maxlen         = sizeof(long),
> >               .mode           = 0644,
> >               .proc_handler   = proc_doulongvec_minmax,
> > -             .extra1         = SYSCTL_ZERO,
> > -             .extra2         = SYSCTL_INT_MAX,
> > +             .extra1         = &it_zero,
> > +             .extra2         = &it_int_max,
> >       },
> >       {
> >               .procname       = "max_queued_events",
> > diff --git a/kernel/ucount.c b/kernel/ucount.c
> > index 260ae7da815f..bb51849e6375 100644
> > --- a/kernel/ucount.c
> > +++ b/kernel/ucount.c
> > @@ -58,14 +58,17 @@ static struct ctl_table_root set_root = {
> >       .permissions = set_permissions,
> >   };
> >
> > +static long ue_zero = 0;
> > +static long ue_int_max = INT_MAX;
> > +
> >   #define UCOUNT_ENTRY(name)                                  \
> >       {                                                       \
> >               .procname       = name,                         \
> >               .maxlen         = sizeof(long),                 \
> >               .mode           = 0644,                         \
> >               .proc_handler   = proc_doulongvec_minmax,       \
> > -             .extra1         = SYSCTL_ZERO,                  \
> > -             .extra2         = SYSCTL_INT_MAX,               \
> > +             .extra1         = &ue_zero,                     \
> > +             .extra2         = &ue_int_max,                  \
> >       }
> >   static struct ctl_table user_table[] = {
> >       UCOUNT_ENTRY("max_user_namespaces"),


--
Linaro LKFT
https://lkft.linaro.org
