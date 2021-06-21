Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C3F03AF83A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Jun 2021 00:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbhFUWJY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Jun 2021 18:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFUWJX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:09:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F026C061574
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 15:07:08 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id j62so34400737qke.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Jun 2021 15:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fX+yJFrM+YgrVjCOj6OzIvdUjYyOhfulkOktgGq/PlY=;
        b=FR2yKrF+DGo/PlodcKHQZ/QoUiBzbgjQ8w9XOQzM2f2VMS06xpY9/FEtc310O2Pk5T
         asjGSjxN5FhTn++sepdMoBKSM9a4ACGM6FOeCL50e7cDgeKVx3ank19JDEf/RzbM+AGb
         lFhIAF7pQbRcQvmQu0f3kyT3zPQCjrnQN0QxMogSeXx4qqlypUfrPs+0UXwFO4uPws/H
         RVr77ka2Hbak8Jvkw8RG9kr4NXcnElEwq9BsEXjcVSiql9cPBhYBDHmKF99RGsV8qGx/
         GW4sXzDY54cG3IqvXOdWEsq/BejVEpGq4b2T2DPGk+Da4Vp8gtP/FP741LxrUJ3YyjqG
         gf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fX+yJFrM+YgrVjCOj6OzIvdUjYyOhfulkOktgGq/PlY=;
        b=UEvT4d0b9tl8UOzndkvHkxur5Dd8pinWiX1oFrhm48mWs6fKKyxRrIeS6zZdXxu0Vz
         p+WwR65mPVqnREFj7S+Ax1XHseriloWOhOnKVWkNQDpSq55rF7G6RdixsSXOEjdvwnKY
         tyZo5Xr/pNOQNiWcwo53BoozYK8RAGt261FH3hfrB+mjSJIyiio018tmvJmcBNTfPCxs
         m1r/xNw9wlu6RNBb50jQLsGkRP2sTXAgPJI3ff8Hd+ZOLV9aJeSV5ul2W1k3D+HyC1Un
         ARu+/Z26RTZMQNnqUoqi77o4dSEEEPdp5/4IiQNSIUJrLG48HVspBchSzJ17QwRKYfoj
         Bf3w==
X-Gm-Message-State: AOAM531JLHgqnSrYjz8iet/tqdVXri0m85SWnrWCrZF8wHb4IAnTEHSR
        MyK1l9gZ8mHmt5SDd0SFf57aGM+vXkEFCl4rD4LQYXPO/SLVJQ==
X-Google-Smtp-Source: ABdhPJyB5Yo0/EbFUom3OyDoOnDiFK3t2cDAcX5WOdjF3EgSMLrT8N/yFSCNsQXVX1+jQEfUxWf66pp3UH2a2hvyVWE=
X-Received: by 2002:a25:be44:: with SMTP id d4mr400528ybm.497.1624313227049;
 Mon, 21 Jun 2021 15:07:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210402055745.3690281-1-varmam@google.com>
In-Reply-To: <20210402055745.3690281-1-varmam@google.com>
From:   Manish Varma <varmam@google.com>
Date:   Mon, 21 Jun 2021 15:06:56 -0700
Message-ID: <CAMyCerJ2wjdXeEP3iRaKOgXOm94rdqVkzAf5iy2cwpjMWVj0hA@mail.gmail.com>
Subject: Re: [PATCH v3] fs: Improve eventpoll logging to stop indicting timerfd
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kernel test robot <lkp@intel.com>,
        Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Alexander and Thomas,

Please share if you have any further feedback on this patch, or if
there's any other action required from my end to before this gets
merged.

Thanks,
Manish

On Thu, Apr 1, 2021 at 10:57 PM Manish Varma <varmam@google.com> wrote:
>
> timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
> it names them after the underlying file descriptor, and since all
> timerfd file descriptors are named "[timerfd]" (which saves memory on
> systems like desktops with potentially many timerfd instances), all
> wakesources created as a result of using the eventpoll-on-timerfd idiom
> are called... "[timerfd]".
>
> However, it becomes impossible to tell which "[timerfd]" wakesource is
> affliated with which process and hence troubleshooting is difficult.
>
> This change addresses this problem by changing the way eventpoll
> wakesources are named:
>
> 1) the top-level per-process eventpoll wakesource is now named "epoll:P"
> (instead of just "eventpoll"), where P, is the PID of the creating
> process.
> 2) individual per-underlying-filedescriptor eventpoll wakesources are
> now named "epollitemN:P.F", where N is a unique ID token and P is PID
> of the creating process and F is the name of the underlying file
> descriptor.
>
> All together that should be splitted up into a change to eventpoll and
> timerfd (or other file descriptors).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
> Signed-off-by: Manish Varma <varmam@google.com>
> ---
>  drivers/base/power/wakeup.c | 10 ++++++++--
>  fs/eventpoll.c              | 10 ++++++++--
>  include/linux/pm_wakeup.h   |  4 ++--
>  3 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
> index 01057f640233..3628536c67a5 100644
> --- a/drivers/base/power/wakeup.c
> +++ b/drivers/base/power/wakeup.c
> @@ -216,13 +216,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
>  /**
>   * wakeup_source_register - Create wakeup source and add it to the list.
>   * @dev: Device this wakeup source is associated with (or NULL if virtual).
> - * @name: Name of the wakeup source to register.
> + * @fmt: format string for the wakeup source name
>   */
>  struct wakeup_source *wakeup_source_register(struct device *dev,
> -                                            const char *name)
> +                                            const char *fmt, ...)
>  {
>         struct wakeup_source *ws;
>         int ret;
> +       char name[128];
> +       va_list args;
> +
> +       va_start(args, fmt);
> +       vsnprintf(name, sizeof(name), fmt, args);
> +       va_end(args);
>
>         ws = wakeup_source_create(name);
>         if (ws) {
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 7df8c0fa462b..7c35987a8887 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -312,6 +312,7 @@ struct ctl_table epoll_table[] = {
>  };
>  #endif /* CONFIG_SYSCTL */
>
> +static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
>  static const struct file_operations eventpoll_fops;
>
>  static inline int is_file_epoll(struct file *f)
> @@ -1451,15 +1452,20 @@ static int ep_create_wakeup_source(struct epitem *epi)
>  {
>         struct name_snapshot n;
>         struct wakeup_source *ws;
> +       pid_t task_pid;
> +       int id;
> +
> +       task_pid = task_pid_nr(current);
>
>         if (!epi->ep->ws) {
> -               epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
> +               epi->ep->ws = wakeup_source_register(NULL, "epoll:%d", task_pid);
>                 if (!epi->ep->ws)
>                         return -ENOMEM;
>         }
>
> +       id = atomic_inc_return(&wakesource_create_id);
>         take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
> -       ws = wakeup_source_register(NULL, n.name.name);
> +       ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
>         release_dentry_name_snapshot(&n);
>
>         if (!ws)
> diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
> index aa3da6611533..cb91c84f6f08 100644
> --- a/include/linux/pm_wakeup.h
> +++ b/include/linux/pm_wakeup.h
> @@ -95,7 +95,7 @@ extern void wakeup_source_destroy(struct wakeup_source *ws);
>  extern void wakeup_source_add(struct wakeup_source *ws);
>  extern void wakeup_source_remove(struct wakeup_source *ws);
>  extern struct wakeup_source *wakeup_source_register(struct device *dev,
> -                                                   const char *name);
> +                                                   const char *fmt, ...);
>  extern void wakeup_source_unregister(struct wakeup_source *ws);
>  extern int wakeup_sources_read_lock(void);
>  extern void wakeup_sources_read_unlock(int idx);
> @@ -137,7 +137,7 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
>  static inline void wakeup_source_remove(struct wakeup_source *ws) {}
>
>  static inline struct wakeup_source *wakeup_source_register(struct device *dev,
> -                                                          const char *name)
> +                                                          const char *fmt, ...)
>  {
>         return NULL;
>  }
> --
> 2.31.0.208.g409f899ff0-goog
>


-- 
Manish Varma | Software Engineer | varmam@google.com | 650-686-0858
