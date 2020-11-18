Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC2C2B81A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Nov 2020 17:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgKRQWA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Nov 2020 11:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgKRQWA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Nov 2020 11:22:00 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9BDC061A48
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 08:22:00 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id h185so1308236vsc.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 08:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K8RmJ6583kn36tl0y/pk4VUasnmo3J+EkhpquBGIyPY=;
        b=Su7vdk+6Pxa70+YWzlJJRhYHAX+NkgMlwLd1krqBnxjE8W+xsLtD0Y3jd/v/ltbDJZ
         1ur16lR1idrNj7+br4H30Vh25RwzSDxvJN4rkYApjeXwlGBVTLj+kj4s7ZADOtAZlq4b
         +jLdEsmRUqhweHgdzxzkrIm7M1rwhsFVMegPg+lDK8R1r/kNTdaP8Bjz1iCyLLkHAIUv
         UDkgW4bRqgtNAsznQR2cg1rkWroKPpuKz50g8emoJArV9W8nvzQQ6kgYTO17Sga3UVyB
         ++nqQ9isEzgUJRCrvZ0KI7k6zgNGJAFv73g/ygu3rKn8Rr0ubHeJuLjqZs+yRfFF9aNV
         esuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K8RmJ6583kn36tl0y/pk4VUasnmo3J+EkhpquBGIyPY=;
        b=TBVjiYIw+g1HAPZ9+0EwlwqeVtldUqJtjsWyfPPUWBzrXjM4/OLvtLdOPbkJp9EfeM
         Wz6pvtUORyqg3t1VbxwhaD87RnmAN1yD8KgsDJPcoz/sSeV+AyR7aSxJRsqOnDmAedYh
         IZ7c4b48Uue0dHO4P7R24kno0tmowLdCXQBvGXqf+4QdiU7poRqh3L1C1TjJf7n1E/aA
         DE2t0mTz7SGC2HpsnP2w9DJDFQGIVf/HkU3Vx0u0kJBlv7Oa1tDY9rMGpoXgAwWOy8dB
         uPQy1DI7PPNIeHf3gq26CG76/VcxhjyIDGHTQf3YDU3i9zQyNV3TgD4HAIc8pc5PnFyE
         TROQ==
X-Gm-Message-State: AOAM532AKFBS3JGhrwkJ8rXkzGI4O+QDQZUJ8budyKmixSZVgY1rAPRB
        L90TFzarA4Js5efjJyqWc4ZwJ1uOwqQ=
X-Google-Smtp-Source: ABdhPJxbeLY//WSwLdGzt9nPQq1/gk1XW7uCP6+OmBvN+58YDs2qtYHQ/CgH+4KmedKaTn+soGP8Dg==
X-Received: by 2002:a05:6102:5fb:: with SMTP id w27mr3844375vsf.24.1605716518614;
        Wed, 18 Nov 2020 08:21:58 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id 11sm3002837vkz.42.2020.11.18.08.21.57
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2020 08:21:57 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id q68so856560uaq.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2020 08:21:57 -0800 (PST)
X-Received: by 2002:ab0:16da:: with SMTP id g26mr3072595uaf.122.1605716516969;
 Wed, 18 Nov 2020 08:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20201118144617.986860-1-willemdebruijn.kernel@gmail.com> <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
In-Reply-To: <20201118144617.986860-2-willemdebruijn.kernel@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 18 Nov 2020 11:21:19 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdFTDFwOVyws19CaAP_6+c5gTrvA0ybvDo3LJ-VhPz1eQ@mail.gmail.com>
Message-ID: <CA+FuTSdFTDFwOVyws19CaAP_6+c5gTrvA0ybvDo3LJ-VhPz1eQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] epoll: add nsec timeout support with epoll_pwait2
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Soheil Hassas Yeganeh <soheil.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuo Chen <shuochen@google.com>,
        linux-man@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 18, 2020 at 9:46 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> From: Willem de Bruijn <willemb@google.com>
>
> Add syscall epoll_pwait2, an epoll_wait variant with nsec resolution
> that replaces int timeout with struct timespec. It is equivalent
> otherwise.
>
>     int epoll_pwait2(int fd, struct epoll_event *events,
>                      int maxevents,
>                      const struct timespec *timeout,
>                      const sigset_t *sigset);
>
> The underlying hrtimer is already programmed with nsec resolution.
> pselect and ppoll also set nsec resolution timeout with timespec.
>
> The sigset_t in epoll_pwait has a compat variant. epoll_pwait2 needs
> the same.
>
> For timespec, only support this new interface on 2038 aware platforms
> that define __kernel_timespec_t. So no CONFIG_COMPAT_32BIT_TIME.
>
> Changes
>   v3:
>   - rewrite: add epoll_pwait2 syscall instead of epoll_create1 flag
>   v2:
>   - cast to s64: avoid overflow on 32-bit platforms (Shuo Chen)
>   - minor commit message rewording
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
>
> ---

> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 109e6681b8fa..9a4e8ec207fc 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -447,3 +447,4 @@
>  440    i386    process_madvise         sys_process_madvise
>  441    i386    watch_mount             sys_watch_mount
>  442    i386    memfd_secret            sys_memfd_secret
> +443    i386    epoll_pwait2            sys_epoll_pwait2                compat_sys_epoll_pwait2

I should have caught this sooner, but this does not work as intended.

x86 will still call epoll_pwait2 with old_timespec32.

One approach is a separate epoll_pwait2_time64 syscall, similar to
ppoll_time64. But that was added to work around legacy 32-bit ppoll.
Not needed for a new API.

In libc, ppoll_time64 is declared with type struct __timespec64. That
type is not defined in Linux uapi. Will need to look at this some
more.
