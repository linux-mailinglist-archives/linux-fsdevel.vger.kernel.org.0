Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7248327176
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Feb 2021 08:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhB1HqA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Feb 2021 02:46:00 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:63795 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhB1HqA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Feb 2021 02:46:00 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 11S7ixkK020061;
        Sun, 28 Feb 2021 16:45:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 11S7ixkK020061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1614498300;
        bh=DaK0zdF1pDCQb/m8EdzHuxdkTgRyS8/NR/dRs6CxQVQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CPN0NWDLl8CMgvVDdgkU9LJ/fR8GxtUMeG8tjlA9s0d7P/3aBUggx0B07Z2l6dJYY
         oMJER/l6lrJnP1veRWQAzXmn5bWksEmGrVMosmk9mAwxPChk9JPJOSinLp6QjTk7RN
         LU8IzRKazssbTg1O8NWhvO5zGvwffGmiZDpFPw1JeZBO62ftDFEyb0ULQZJPqJyXat
         M+IWfjMQ4oRDJT81yNmSFWqlWuMSOFrFRz5fAXeXyvbSX42BtJMZmNjWBMXcMkIZpS
         6FeTPAPTSRsuXQfdauNFD6i7zGZKAUUhMeN189l5Mcu4psgg002MAKZCrEJrMGqyz0
         vVVlfQNWtI5Ug==
X-Nifty-SrcIP: [209.85.216.54]
Received: by mail-pj1-f54.google.com with SMTP id c19so8521745pjq.3;
        Sat, 27 Feb 2021 23:44:59 -0800 (PST)
X-Gm-Message-State: AOAM530rCFgByuUOT4N1qm4/WmjHmXznWPl+xxu88P8UYMhFZ0NeVY+4
        qs0+5TP7cjmrKh6aygBDBtSMbR0Co4JqkWMwVTw=
X-Google-Smtp-Source: ABdhPJwuMFCU2KtqRh3yEc1CvcvmwCJivIfwJkV56KyDYTKnwzD4xZqEWNFrRf7yKka/doaNMycaqnlFTATqxIUPF+o=
X-Received: by 2002:a17:902:e891:b029:e4:20d3:3d5c with SMTP id
 w17-20020a170902e891b02900e420d33d5cmr10517559plg.71.1614498299143; Sat, 27
 Feb 2021 23:44:59 -0800 (PST)
MIME-Version: 1.0
References: <20210104083221.21184-1-masahiroy@kernel.org>
In-Reply-To: <20210104083221.21184-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Feb 2021 16:44:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNARXy_puE7KZp2vjzn_KcW5uZ_ba3O5zFX46yGULjNhpZg@mail.gmail.com>
Message-ID: <CAK7LNARXy_puE7KZp2vjzn_KcW5uZ_ba3O5zFX46yGULjNhpZg@mail.gmail.com>
Subject: Re: [PATCH] sysctl: use min() helper for namecmp()
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

(CC: Andrew Morton)

A friendly reminder.


This is just a minor clean-up.

If nobody picks it up,
I hope perhaps Andrew Morton will do.

This patch:
https://lore.kernel.org/patchwork/patch/1360092/





On Mon, Jan 4, 2021 at 5:33 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Make it slightly readable by using min().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  fs/proc/proc_sysctl.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 317899222d7f..86341c0f0c40 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -94,14 +94,9 @@ static void sysctl_print_dir(struct ctl_dir *dir)
>
>  static int namecmp(const char *name1, int len1, const char *name2, int len2)
>  {
> -       int minlen;
>         int cmp;
>
> -       minlen = len1;
> -       if (minlen > len2)
> -               minlen = len2;
> -
> -       cmp = memcmp(name1, name2, minlen);
> +       cmp = memcmp(name1, name2, min(len1, len2));
>         if (cmp == 0)
>                 cmp = len1 - len2;
>         return cmp;
> --
> 2.27.0
>


-- 
Best Regards
Masahiro Yamada
