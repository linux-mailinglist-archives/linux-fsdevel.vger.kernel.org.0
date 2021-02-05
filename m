Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1414A311647
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 00:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhBEXAE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 18:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232294AbhBEMqR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 07:46:17 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF1C0613D6;
        Fri,  5 Feb 2021 04:45:36 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id q7so6952259iob.0;
        Fri, 05 Feb 2021 04:45:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aBRZHcqQUHAqDViM2T71SQ78hCSp5LpTmm912WpFX6Q=;
        b=Rw+hTxuBOGz1hcavzXaKCgHnt3neVdzc10okWQQNZn8v11nswAx/M5JTRyKXY+QS7R
         p2imctQ1MX4J3q+al70RCu9vbzW91Uawh/IQNIHn1fKrJ1tYXEYIL2+GIeilQqvM7pjR
         de2LjFce04TC2qwOBk4dgJwbkaimvePhN7EnZRUwCd5suppbeKzh33Tdcg/mWE9tv+bf
         WQHFylP37eU6lqoqJWI2qPrMlQEY45/N2sThuKudTiFWrW4o/eftoxAEvD/p3RfccrBu
         eCmdEj2H8dnAz4JOnNdDFuSiZrJnQARyc3nCQF7J8VNi2/MRmHzImsaqzp9MNssBBs1h
         ENIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aBRZHcqQUHAqDViM2T71SQ78hCSp5LpTmm912WpFX6Q=;
        b=HJd7maZw69yOWGPvWVXExULEyvuhkEqgEU4gr2sjcbkg4wVaBqtu8E+57YgaYvfyHQ
         Chh1pFBDY11Yd+patOTD0cNbLRhWAHR3ZWzJz7i/cgrPSoVvIiq3aaZ2qDVzKoaENhvy
         GJd8lCDymWVP/+p8pVp9BRn0LBa/renyKm00e3fyWd/q3gOTlOaA5oQDvL8LH4iqPphG
         CvMaCyA+zRzBoeczdITbfRxxQx+JWfHCdZ4F384SR9KI5IziAQPsF8ZMQWsBJEaw1vmm
         tDQUtQPl0J7vG4qprFpRkzjDzGmIq+Q4tRH8wM1Ha+ZMVcK2ykPm51II0VPsf/3KvbHj
         01sw==
X-Gm-Message-State: AOAM531zqJVzt/mftoFPz2Ado6mJXi9D4fBg3IolGI6Ghj4VjcUTtQX2
        xr62vIjhSxxlg7uuOd6typDQ5okC1ianUjjkxqkwkvQzvw4=
X-Google-Smtp-Source: ABdhPJw0fTmoj4tDSH5CcoICcrzpbOwxjl2An5TyzwQCKtnfQddvQ5QgwUoTEIjwY6SiqKRwWo/WQwuu8zM1MSpRHtQ=
X-Received: by 2002:a05:6638:d6:: with SMTP id w22mr4658990jao.93.1612529135950;
 Fri, 05 Feb 2021 04:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20210205122033.1345204-1-unixbhaskar@gmail.com>
In-Reply-To: <20210205122033.1345204-1-unixbhaskar@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 5 Feb 2021 14:45:24 +0200
Message-ID: <CAOQ4uxhy2XG=EBg6f6xwSNZnYU9z0vx0W6Q2pXDT_KOTKWPZ8A@mail.gmail.com>
Subject: Re: [PATCH] fs: notify: inotify: Replace a common bad word with
 better common word
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 2:20 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
>
> s/fucked/messed/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  fs/notify/inotify/inotify_user.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 59c177011a0f..0a9d1a81edf0 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -455,7 +455,7 @@ static void inotify_remove_from_idr(struct fsnotify_group *group,
>         /*
>          * We found an mark in the idr at the right wd, but it's
>          * not the mark we were told to remove.  eparis seriously
> -        * fucked up somewhere.
> +        * messed up somewhere.
>          */
>         if (unlikely(found_i_mark != i_mark)) {
>                 WARN_ONCE(1, "%s: i_mark=%p i_mark->wd=%d i_mark->group=%p "
> --
> 2.30.0
>

Same comment as the previous attempt:

https://lore.kernel.org/linux-fsdevel/20181205094913.GC22304@quack2.suse.cz/

Please remove the part of the comment that adds no valuable information
and fix grammar mistakes.

Thanks,
Amir.
