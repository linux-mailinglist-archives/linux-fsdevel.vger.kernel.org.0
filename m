Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240242FD25F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 15:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731636AbhATOJq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390100AbhATNk2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 08:40:28 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D04C061575
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 05:39:48 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id d13so43627493ioy.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Jan 2021 05:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=FM37ipdlLykh82wOaMeonjfMEHwci4vUHpTC97P767A=;
        b=rOWwKG0ZAiK1X30AudSIn50Xfyklr+HXuFqGhgcR7QyAU2YMos1q33iV3Gmobqti7f
         t6JF6Z6yxq38b3JJUyQCpA/5DFtJ8OLar05WxCI/v229aZO+pwBPksLWH/rwyqhPskPx
         pZxkmXcSWZFlL/Zb3VPJxMTNNGhhbdfmiP6WCJbg59bpp1FjgSNnem6X/ZpQxBH/0/7m
         WetdLltV8lKJ6sdhuyaiv0EP0ZQ2zuvmQ8Cros/i9O+efQrCTE15lO5Ttm6xD8PvNsOx
         HVTq31Yur71rzgSIA7Fihj/oDjkKmCbLOk9MuePvSpMnOsAfrNvE3tt5NXdx3cUVRl6f
         DfSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=FM37ipdlLykh82wOaMeonjfMEHwci4vUHpTC97P767A=;
        b=GKrBPwPbAMGl4Lb7QCOSmdAH4YjheDw2acu8eWvNMJtOANOVumLaY3eecBJThg6XCO
         5VuSpraOVujwAibDNZqpOKZVIpNVleuqF3z/C31Lbv9sS0YsvvQVj8mafE/yVVH9p3Fi
         k13p+DBZYWkIxxAlOHZ51fIWLEiep9Sy4Cr//4nUESdWa0YWzmoNDNb/C8eQBlU5WT6+
         1RS1QzxIfpoP0bhQ4twwm6Ol+CKURNVjToLPJHd36W6RHzZdIB0WtATs7TXZiMW+yiZp
         rayCAS8X1cvwx8PfBry9/KeHLzaqZbbcnSCf8AklPhIRm8oEG9M2OvZ/rivrtDr4gqyQ
         eP1w==
X-Gm-Message-State: AOAM533MacnxXzZTSNldZAhToQjuZFbroxMqnBm/GLiNpLlP6GkUxCdo
        ynJwAs/pxqzpQdiSYxwYq5eSyLb3XO3BAIENog8=
X-Received: by 2002:a92:cccd:: with SMTP id u13mt8060867ilq.273.1611149987592;
 Wed, 20 Jan 2021 05:39:47 -0800 (PST)
MIME-Version: 1.0
References: <20210120130233.15932-1-ericcurtin17@gmail.com>
In-Reply-To: <20210120130233.15932-1-ericcurtin17@gmail.com>
From:   Eric Curtin <ericcurtin17@gmail.com>
Date:   Wed, 20 Jan 2021 13:39:36 +0000
Message-ID: <CANpvso7mbc9C=xjxLDivb6Qm8_FDu2fLjA-StMw4Z-209PHLqw@mail.gmail.com>
Subject: Re: [PATCH] Increase limit of max_user_watches from 1/25 to 1/16
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:FILESYSTEMS (VFS and infrastructure)" 
        <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 20 Jan 2021 at 13:02, Eric Curtin <ericcurtin17@gmail.com> wrote:
>
> The current default value for  max_user_watches  is the 1/16 (6.25%) of
> the available low memory, divided for the "watch" cost in bytes.
>
> Tools like inotify-tools and visual studio code, seem to hit these
> limits a little to easy.
>
> Also amending the documentation, it referred to an old value for this.
>
> Signed-off-by: Eric Curtin <ericcurtin17@gmail.com>
> ---
>  Documentation/admin-guide/sysctl/fs.rst | 4 ++--
>  fs/eventpoll.c                          | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
> index f48277a0a850..f7fe45e69c41 100644
> --- a/Documentation/admin-guide/sysctl/fs.rst
> +++ b/Documentation/admin-guide/sysctl/fs.rst
> @@ -380,5 +380,5 @@ This configuration option sets the maximum number of "watches" that are
>  allowed for each user.
>  Each "watch" costs roughly 90 bytes on a 32bit kernel, and roughly 160 bytes
>  on a 64bit one.
> -The current default value for  max_user_watches  is the 1/32 of the available
> -low memory, divided for the "watch" cost in bytes.
> +The current default value for  max_user_watches  is the 1/16 (6.25%) of the
> +available low memory, divided for the "watch" cost in bytes.
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a829af074eb5..de9ef8f6d0b2 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -2352,9 +2352,9 @@ static int __init eventpoll_init(void)
>
>         si_meminfo(&si);
>         /*
> -        * Allows top 4% of lomem to be allocated for epoll watches (per user).
> +        * Allows top 6.25% of lomem to be allocated for epoll watches (per user).
>          */
> -       max_user_watches = (((si.totalram - si.totalhigh) / 25) << PAGE_SHIFT) /
> +       max_user_watches = (((si.totalram - si.totalhigh) / 16) << PAGE_SHIFT) /
>                 EP_ITEM_COST;
>         BUG_ON(max_user_watches < 0);
>
> --
> 2.25.1
>

Please ignore this, this is the wrong limit (an epoll one), I sent
another patch just
to update the documentation to be correct. Weiman Long already kindly solved the
issue in 92890123749bafc317bbfacbe0a62ce08d78efb7

Separate patch is titled "[PATCH] Update
Documentation/admin-guide/sysctl/fs.rst"
