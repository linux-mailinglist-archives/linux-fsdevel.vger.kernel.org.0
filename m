Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6401838C29B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 May 2021 11:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhEUJH4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 May 2021 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234628AbhEUJHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 May 2021 05:07:54 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347D2C061574;
        Fri, 21 May 2021 02:06:31 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id c4so272073iln.7;
        Fri, 21 May 2021 02:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOSLP82Ez+kx0oIloOtL79Asfs1CDEhRsGH99eTYvPw=;
        b=nm5r1mtytT5B5L8p0bJPZN8aIqCjc0Gk3jUqLorWnFV2tx2ZnsxuqVaEU/m/Rt/C67
         Poe5FkAri0W6HbQimZk2QSPxmAim1WHZPOzNyqeTuWSYh0IM4h4hZ//vSpez7MOlnjS3
         VNsY2nQdZZLQvVQjaP3PlpuonMFdNuogODbSnb9umS9vvcD+PgDCbkizjFYfYGtXAXGL
         w/KyTOCtiEU1X7Py9i4Bnzr45IZZhAiHRJVWU5e1btGtQTfCCPfXj2/tKdVK4cO6cDIL
         +gMxyiqPdtGjIqaXtB72f0v+wXeoAjb0KLnHQXj4G6wnw1vYjW4ws6iynSmLArTNOEwZ
         JcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOSLP82Ez+kx0oIloOtL79Asfs1CDEhRsGH99eTYvPw=;
        b=G5+sAdTh9PXXA1b5PMn3FoSTnoVf/tUgcIoINGkxupNJ18Tkacw/6D/SM4hZmRI4Ba
         NGPSGwX9bo5NSZzGur22EdwxagviIbJuYng5W2jatifDIFLy9lg+67Xqt/7yqCnMB9cU
         G5dNlDhg5cbGwEocXjlQVrXrfU8FpLBBY9/QItO46Efwi289PtbgXkHSuovBBMhaIWUI
         nmnnjDwf0kDsNHqatxhVbYAoUutZQbXOLG53G1R8lQV5C8dzCB/AaYgeyx1fXVdRmSka
         VXK8yBrESOBG4pf0tSClgVE7Iwxx+IKlHC1dtZylsiI0fjkEnGBE6caSe5ox4Ln6Stjd
         +wyA==
X-Gm-Message-State: AOAM530a1dd87D9SnxODJCs5L/jBhy1X2wP+v07IkBxfhrqcb54AsLuT
        zk1QnceUG56e3G9lwR3V8/hIs8Suk6JwUbCQNSA=
X-Google-Smtp-Source: ABdhPJw7YVkipLITeiej1vE7i3KuxNmwloLTOlMAuSvONol9bRFQjr6vVbl/J/WLLQ/KlJJIbLVt6spNDJUrU+i6Nkk=
X-Received: by 2002:a92:cc43:: with SMTP id t3mr11753988ilq.250.1621587989830;
 Fri, 21 May 2021 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210521024134.1032503-1-krisman@collabora.com> <20210521024134.1032503-5-krisman@collabora.com>
In-Reply-To: <20210521024134.1032503-5-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 21 May 2021 12:06:18 +0300
Message-ID: <CAOQ4uxj4bREBYPZTBTgZ5LiSx+SosrUS8W-G_ea634M1nXs=wQ@mail.gmail.com>
Subject: Re: [PATCH 04/11] fanotify: Expose fanotify_mark
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     kernel@collabora.com, "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.com>,
        David Howells <dhowells@redhat.com>,
        Khazhismel Kumykov <khazhy@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 21, 2021 at 5:42 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_ERROR will require an error structure to be stored per mark.
> Therefore, wrap fsnotify_mark in a fanotify specific structure in
> preparation for that.
>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> ---
>  fs/notify/fanotify/fanotify.c      |  4 +++-
>  fs/notify/fanotify/fanotify.h      | 10 ++++++++++
>  fs/notify/fanotify/fanotify_user.c | 14 +++++++-------
>  3 files changed, 20 insertions(+), 8 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 711b36a9483e..34e2ee759b39 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -869,7 +869,9 @@ static void fanotify_freeing_mark(struct fsnotify_mark *mark,
>
>  static void fanotify_free_mark(struct fsnotify_mark *fsn_mark)
>  {
> -       kmem_cache_free(fanotify_mark_cache, fsn_mark);
> +       struct fanotify_mark *mark = FANOTIFY_MARK(fsn_mark);
> +
> +       kmem_cache_free(fanotify_mark_cache, mark);
>  }
>
>  const struct fsnotify_ops fanotify_fsnotify_ops = {
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
> index 4a5e555dc3d2..a399c5e2615d 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -129,6 +129,16 @@ static inline void fanotify_info_copy_name(struct fanotify_info *info,
>                name->name);
>  }
>
> +struct fanotify_mark {
> +       struct fsnotify_mark fsn_mark;
> +       struct fanotify_error_event *error_event;

I don't think fanotify_error_event is defined at this point in the series.
You can add this field later in the series.

> +};
> +
> +static inline struct fanotify_mark *FANOTIFY_MARK(struct fsnotify_mark *mark)
> +{
> +       return container_of(mark, struct fanotify_mark, fsn_mark);
> +}
> +
>  /*
>   * Common structure for fanotify events. Concrete structs are allocated in
>   * fanotify_handle_event() and freed when the information is retrieved by
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 9cc6c8808ed5..00210535a78e 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -914,7 +914,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>                                                    __kernel_fsid_t *fsid)
>  {
>         struct ucounts *ucounts = group->fanotify_data.ucounts;
> -       struct fsnotify_mark *mark;
> +       struct fanotify_mark *mark;
>         int ret;
>
>         /*
> @@ -926,20 +926,20 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
>             !inc_ucount(ucounts->ns, ucounts->uid, UCOUNT_FANOTIFY_MARKS))
>                 return ERR_PTR(-ENOSPC);
>
> -       mark = kmem_cache_alloc(fanotify_mark_cache, GFP_KERNEL);
> +       mark = kmem_cache_zalloc(fanotify_mark_cache, GFP_KERNEL);
>         if (!mark) {
>                 ret = -ENOMEM;
>                 goto out_dec_ucounts;
>         }
>
> -       fsnotify_init_mark(mark, group);
> -       ret = fsnotify_add_mark_locked(mark, connp, type, 0, fsid);
> +       fsnotify_init_mark(&mark->fsn_mark, group);
> +       ret = fsnotify_add_mark_locked(&mark->fsn_mark, connp, type, 0, fsid);
>         if (ret) {
> -               fsnotify_put_mark(mark);
> +               fsnotify_put_mark(&mark->fsn_mark);
>                 goto out_dec_ucounts;
>         }
>
> -       return mark;
> +       return &mark->fsn_mark;
>
>  out_dec_ucounts:
>         if (!FAN_GROUP_FLAG(group, FAN_UNLIMITED_MARKS))
> @@ -1477,7 +1477,7 @@ static int __init fanotify_user_setup(void)
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) != 10);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) != 9);
>
> -       fanotify_mark_cache = KMEM_CACHE(fsnotify_mark,
> +       fanotify_mark_cache = KMEM_CACHE(fanotify_mark,
>                                          SLAB_PANIC|SLAB_ACCOUNT);

Thinking out loud:

Do we want to increase the size of all fanotify marks or just the size of
sb marks?

In this WIP branch [1], I took the latter approach.

The greater question is, do we want/need to allow setting FAN_ERROR
on inode marks mask at all?

My feeling is that we should not allow that at this time, because the
use case of watching for critical errors on a specific inode is a
non-requirement IMO.

OTOH, if we treat this change as a stepping stone towards adding
writeback error events in the future then we should also think about
whether watching specific files for writeback error in a sensible use case
I don't think that it is, because when application can always keep an open
fd for file of interest and fysnc on any reported writeback error on the
filesystem, as those events are supposed to be rare.

Another point to consider - in future revisions of [1] fanotify sb marks
may grow more fields (e.g. subtree_root, userns), so while adding a single
pointer field to all fanotify inode marks may not be the end of the world,
going forward, we will need to have a separate kmem_cache for sb marks
anyway, so maybe better to split it now already.

Thoughts?

Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_idmapped
