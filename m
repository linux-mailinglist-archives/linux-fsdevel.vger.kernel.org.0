Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5066D2AB05B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Nov 2020 05:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgKIE7F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 8 Nov 2020 23:59:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbgKIE7F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 8 Nov 2020 23:59:05 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F55EC0613CF;
        Sun,  8 Nov 2020 20:59:05 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id y17so7142481ilg.4;
        Sun, 08 Nov 2020 20:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4NL1NCgbVYCQehTbE7G2xqXykgisF//g4f3RuFilZ9E=;
        b=CtdSAF/IkW3uB7+Lr5FBSuiNxXsHnNLqurLUCkS2QA8XJm2M6ZibTJ3ZDalJ8++XVn
         bPjIFYzcU3OZoDCek4d7mCthF8kr2qn4pcSNd3RjhP5VoD/uO5KgBXvhZe7d8t1IPrTC
         kIL4uVi9n8WZBva6CGEv9JHRD7rbWKTVjeNzQ2eNZy1KDawAUSwvgIBenDbteDJnJ530
         kh0HbFw4JQRuj+Lsj1n64BTpDm10ean+xsX+9ybSTYos8WFVZl0i99fzicRgu1jFrRZ/
         9qek3j31CUQcfNg9NFiaZ4lo5YKjPm88BxtKiBCuKkJvjcArkHXbOfeOVlNbNL3j55Wt
         DnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4NL1NCgbVYCQehTbE7G2xqXykgisF//g4f3RuFilZ9E=;
        b=OWhwJN2or4VXNhmz3VTRBnQqTrxmHEyebQN1LT8nhNcaZzYFYEoOEu/f524x/G0Nxv
         n2vYidxdayV53Cnz8LvrYp/y4z3TAJGO3sz1Ty8YAqosrdGHumY8vYzJ13INXHpiEDzP
         zJ5B5FWhuQqDRfCoOLOfLTr4y3DVhZkqM/x/Wk0qMIJ6C592JaaC2S0jLA9byoHkvloP
         DV8ZlOrTbNjpMhe3V1WDG3bLLLJa4NeKKtfqNPLun/52+ktHtFIIhFrwJqHgC5PCzx9o
         aWD+2Qg3c+Z/zGIOfZajHrBGm3X9lWryGBLHCBEqjS8Y9wi92433LepxCk9ydpBam9oV
         l8Bw==
X-Gm-Message-State: AOAM532LUnd80qcW1ZWE2Spg3flslmIjUChhsSYwGBuuITp4cVf0upD7
        594VF85m//dhcUFM0EWXHrNdDYgUmlcaC2b6G/CpXdbsgrs=
X-Google-Smtp-Source: ABdhPJxMhg1PLY/uPC9bIG2dDogWQfpNTx1QZi760hBRRZ4NPS5NPTBR/MUyDH91bo/JvuOeM5LBw/OOir/aKvoPXNQ=
X-Received: by 2002:a05:6e02:e51:: with SMTP id l17mr8841831ilk.275.1604897944145;
 Sun, 08 Nov 2020 20:59:04 -0800 (PST)
MIME-Version: 1.0
References: <20201109035931.4740-1-longman@redhat.com>
In-Reply-To: <20201109035931.4740-1-longman@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Nov 2020 06:58:52 +0200
Message-ID: <CAOQ4uxj26Pb_zyErgnpmKeMThrxnRuO5PAF=igt9mvr_80BkCQ@mail.gmail.com>
Subject: Re: [PATCH v4] inotify: Increase default inotify.max_user_watches
 limit to 1048576
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 9, 2020 at 6:00 AM Waiman Long <longman@redhat.com> wrote:
>
> The default value of inotify.max_user_watches sysctl parameter was set
> to 8192 since the introduction of the inotify feature in 2005 by
> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> small for many modern usage. As a result, users have to explicitly set
> it to a larger value to make it work.
>
> After some searching around the web, these are the
> inotify.max_user_watches values used by some projects:
>  - vscode:  524288
>  - dropbox support: 100000
>  - users on stackexchange: 12228
>  - lsyncd user: 2000000
>  - code42 support: 1048576
>  - monodevelop: 16384
>  - tectonic: 524288
>  - openshift origin: 65536
>
> Each watch point adds an inotify_inode_mark structure to an inode to
> be watched. It also pins the watched inode.
>
> Modeled after the epoll.max_user_watches behavior to adjust the default
> value according to the amount of addressable memory available, make
> inotify.max_user_watches behave in a similar way to make it use no more
> than 1% of addressable memory within the range [8192, 1048576].
>
> For 64-bit archs, inotify_inode_mark plus 2 vfs inode have a size that
> is a bit over 1 kbytes (1284 bytes with my x86-64 config).

The sentence above seems out of context (where did the 2 vfs inodes
come from?). Perhaps the comment in the patch should go here above.

> That means
> a system with 128GB or more memory will likely have the maximum value
> of 1048576 for inotify.max_user_watches. This default should be big
> enough for most use cases.
>
> [v3: increase inotify watch cost as suggested by Amir and Honza]

That patch change log usually doesn't belong in the git commit
because it adds little value in git log perspective.

If you think that the development process is relevant to understanding
the patch (like the discussion leading to the formula of the cost)
then a Link: to the discussion on lore.kernel.org would serve the
commit better.

>
> Signed-off-by: Waiman Long <longman@redhat.com>

Apart from this minor nits,
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/inotify/inotify_user.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 186722ba3894..24d17028375e 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -37,6 +37,15 @@
>
>  #include <asm/ioctls.h>
>
> +/*
> + * An inotify watch requires allocating an inotify_inode_mark structure as
> + * well as pinning the watched inode. Doubling the size of a VFS inode
> + * should be more than enough to cover the additional filesystem inode
> + * size increase.
> + */
> +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> +                                2 * sizeof(struct inode))
> +
>  /* configurable via /proc/sys/fs/inotify/ */
>  static int inotify_max_queued_events __read_mostly;
>
> @@ -801,6 +810,18 @@ SYSCALL_DEFINE2(inotify_rm_watch, int, fd, __s32, wd)
>   */
>  static int __init inotify_user_setup(void)
>  {
> +       unsigned long watches_max;
> +       struct sysinfo si;
> +
> +       si_meminfo(&si);
> +       /*
> +        * Allow up to 1% of addressable memory to be allocated for inotify
> +        * watches (per user) limited to the range [8192, 1048576].
> +        */
> +       watches_max = (((si.totalram - si.totalhigh) / 100) << PAGE_SHIFT) /
> +                       INOTIFY_WATCH_COST;
> +       watches_max = clamp(watches_max, 8192UL, 1048576UL);
> +
>         BUILD_BUG_ON(IN_ACCESS != FS_ACCESS);
>         BUILD_BUG_ON(IN_MODIFY != FS_MODIFY);
>         BUILD_BUG_ON(IN_ATTRIB != FS_ATTRIB);
> @@ -827,7 +848,7 @@ static int __init inotify_user_setup(void)
>
>         inotify_max_queued_events = 16384;
>         init_user_ns.ucount_max[UCOUNT_INOTIFY_INSTANCES] = 128;
> -       init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = 8192;
> +       init_user_ns.ucount_max[UCOUNT_INOTIFY_WATCHES] = watches_max;
>
>         return 0;
>  }
> --
> 2.18.1
>
