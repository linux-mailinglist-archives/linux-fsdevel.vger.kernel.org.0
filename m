Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60C91CE7D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEKV55 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgEKV54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:57:56 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E08DC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:57:56 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id f4so5256539iov.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LOEA6DpSly4GxOVPavYb4GjGMimohHGgAvP4sektv9U=;
        b=nvNQWHeC6T5YiBl/SculRtn6BELdE8yhuPHgAlLRNur/H/jTaAWqsKqcWK08kaFsVV
         RBink8ysbQCqZGVpH1nivHAhuFpVnKRAe/cHQ7nQDQ8H/3Azyk/85g8YyNEEQSKFcZkG
         6ORqci1BlrE6xYxUo/UNGvOdnvzG9NqWrVtCznwiZip2GKHa35gbd91SNKpXV0gvhipn
         jv9ZA4M2ccroLzqbxOJuctlQikw3+vU1xrIUATGfXgUqf4ZvVfbcEEtq7zCbCHQT2TMy
         nNoipVwXZvY6qhsX3wmSMYs5k/E0PWvxpF8lc/vQclHq85xXM+n5qVTL1AygFJrZiqL5
         d7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LOEA6DpSly4GxOVPavYb4GjGMimohHGgAvP4sektv9U=;
        b=sN+2f5G6p3koMzL2Mm53dyCLdVzdO+B/yqFoLa2n4lP/pXBiUudKaqK99XkvmUYqoV
         OclRkJ/26rpR+eEwNLDNYNxUJy/KV230dDkynTf/A70+3QqYN9fsR4u1QkQpIhYcqEd3
         I7jkD8o+etCUOGwy8zDvQEB9tq7niJXWZTuX7E0lq2SVmz0gd2bapYwEqVnETaPvdU7Y
         NwuSvXTIJGvkmYarpdNxfxfsfHL4W01XRfetbM9RCjYy0xA02F3KkYGS2IETo17PMpkD
         L4yO0x45MCZ/hLRfSycibzvYKW5631HPpNEMxkINLAQ5K5X0I5dC7W4rDy4c2qFIunLg
         kwXQ==
X-Gm-Message-State: AGi0Pua9xJoIJeVsyAT+EgMfVtiX0BkHeHKrkBnXhyC+f+4GCCjtW0tG
        s0bZnSDV6csXdt0KNs7bhpTnKGj1rF20D+V4ytGzdg==
X-Google-Smtp-Source: APiQypJPWwCeR9snfx2YNEGMQiY/LwYsyxs5X36iKAIZ7vJaprUEyvJaxFYtlNaJwWUJhHS1x2Kf9mTg+KKe68D9jOE=
X-Received: by 2002:a02:c615:: with SMTP id i21mr7465678jan.30.1589234276037;
 Mon, 11 May 2020 14:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200511180305.215252-1-fabf@skynet.be>
In-Reply-To: <20200511180305.215252-1-fabf@skynet.be>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 00:57:44 +0300
Message-ID: <CAOQ4uxjs-23-sFboCSuVLVKs5jaNzv23TboM6uTP3MFve8E8sg@mail.gmail.com>
Subject: Re: [PATCH 9/9 linux-next] fsnotify: fsnotify_clear_marks_by_group() massage
To:     Fabian Frederick <fabf@skynet.be>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 9:03 PM Fabian Frederick <fabf@skynet.be> wrote:
>
> revert condition and remove clear label
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Definite NACK on this one.
It creates code churn, increases code nesting level and brings
very little value.
Keep up the good work, Fabian
and try to focus on useful cleanups!

Thanks,
Amir.


> ---
>  fs/notify/mark.c | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index 1d96216dffd1..ca2eba786bb6 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -724,28 +724,27 @@ void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
>         LIST_HEAD(to_free);
>         struct list_head *head = &to_free;
>
> -       /* Skip selection step if we want to clear all marks. */
> -       if (type_mask == FSNOTIFY_OBJ_ALL_TYPES_MASK) {
> +       if (type_mask != FSNOTIFY_OBJ_ALL_TYPES_MASK) {
> +              /*
> +               * We have to be really careful here. Anytime we drop mark_mutex,
> +               * e.g. fsnotify_clear_marks_by_inode() can come and free marks.
> +               * Even in our to_free list so we have to use mark_mutex even
> +               * when accessing that list. And freeing mark requires us to drop
> +               * mark_mutex. So we can reliably free only the first mark in the
> +               * list. That's why we first move marks to free to to_free list
> +               * in one go and then free marks in to_free list one by one.
> +               */
> +               mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
> +               list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
> +                       if ((1U << mark->connector->type) & type_mask)
> +                               list_move(&mark->g_list, &to_free);
> +               }
> +               mutex_unlock(&group->mark_mutex);
> +       } else {
> +               /* Skip selection step if we want to clear all marks. */
>                 head = &group->marks_list;
> -               goto clear;
>         }
> -       /*
> -        * We have to be really careful here. Anytime we drop mark_mutex, e.g.
> -        * fsnotify_clear_marks_by_inode() can come and free marks. Even in our
> -        * to_free list so we have to use mark_mutex even when accessing that
> -        * list. And freeing mark requires us to drop mark_mutex. So we can
> -        * reliably free only the first mark in the list. That's why we first
> -        * move marks to free to to_free list in one go and then free marks in
> -        * to_free list one by one.
> -        */
> -       mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
> -       list_for_each_entry_safe(mark, lmark, &group->marks_list, g_list) {
> -               if ((1U << mark->connector->type) & type_mask)
> -                       list_move(&mark->g_list, &to_free);
> -       }
> -       mutex_unlock(&group->mark_mutex);
>
> -clear:
>         while (1) {
>                 mutex_lock_nested(&group->mark_mutex, SINGLE_DEPTH_NESTING);
>                 if (list_empty(head)) {
> --
> 2.26.2
>
