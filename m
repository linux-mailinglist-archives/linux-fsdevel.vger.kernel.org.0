Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6382F28B5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 08:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391825AbhALHMP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 02:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391757AbhALHMP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 02:12:15 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C4AC061575;
        Mon, 11 Jan 2021 23:11:34 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q75so1046746wme.2;
        Mon, 11 Jan 2021 23:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Eb5RjUdvsaJoaHaCzpdgtojGaEokAS+4OO3nSTY9j9c=;
        b=rjjB/JJWczy+jxbhzpEnKdl1C1ieu9dRSfGxwLauplIck1Bk1VV0PgGZO0B0XQY9+W
         SG04+j8DxQnttkv996JxICx+7AVeZhDm1mbzdrP2/Z5rMz0R7lVs6PgUkEr5jVbxfGy9
         XdY5XTXZaY6E8sFdwZSocOTfqlBKYJmq/hxQESOZ+JFV1UvOpi429vlIJC+7bk0yeS6I
         agHA3sCB3wtgYZUJslbOXLxJG78iC80a4lAiMb1hOsvd5JXw45cZiRsmKAfimCNCU4/z
         a/GNAl0qNw77MLFNapy5Ua7iwy3OwluRqUmbdTBxNu0Gwckz6Tokynh8ks7xkbolr9UR
         IPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Eb5RjUdvsaJoaHaCzpdgtojGaEokAS+4OO3nSTY9j9c=;
        b=RR2OyJCWZY6rIB2a044tavT/NTdS+czk5tsWb9I9m0UrgBuFdJbuP43hfSWO2HFoGI
         SPAJGw1nBsX1zBMV5fc3sLon8KKC7hk3voEEqGbP5xVQbsgejmsakdDm0zS/P55TINUF
         PWygLQlx3yIuxARr+j4ryixLPvaP+ktW5Xrz2H/0/tY4Yg6XzF5yW4dLotkMoUMdwxsP
         Bjq3tYGmRFiK/DStxEYLJNhF7xEZop4QjSsp0P3dKluxrmqzSSxw+DQz59+aB7KfyWXU
         ShUw6EPJ7W/k0sM2U0pjP3B+RMZ1WpKt5sSniwzz/Om6JJM3ZyTG2OPNkwpj14UuOwNT
         e6jw==
X-Gm-Message-State: AOAM532LLH5B40+cKbMaao48ME35JwNRjGBlInSRFzSJ1PMvFPS450cv
        7OHpcwhZFyhHDPEEamPVcyE=
X-Google-Smtp-Source: ABdhPJyOBSu8i4jrjS04H/WODSIcX7Mam2pUCavU8CK4+W+I7p1e5OB/rPYzHwhZIRF0PeC1mfiLHg==
X-Received: by 2002:a1c:1fc4:: with SMTP id f187mr2073830wmf.107.1610435493259;
        Mon, 11 Jan 2021 23:11:33 -0800 (PST)
Received: from ?IPv6:2001:a61:244d:fe01:9fb1:d962:461a:45e8? ([2001:a61:244d:fe01:9fb1:d962:461a:45e8])
        by smtp.gmail.com with ESMTPSA id t1sm3361572wro.27.2021.01.11.23.11.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jan 2021 23:11:32 -0800 (PST)
Cc:     mtk.manpages@gmail.com, linux-fsdevel@vger.kernel.org,
        Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH manpages] epoll_wait.2: add epoll_pwait2
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        linux-man@vger.kernel.org
References: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <f0e614e6-1534-3355-c69c-834865802fa8@gmail.com>
Date:   Tue, 12 Jan 2021 08:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210112004820.4013953-1-willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello Willem,

On 1/12/21 1:48 AM, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Expand the epoll_wait page with epoll_pwait2, an epoll_wait variant
> that takes a struct timespec to enable nanosecond resolution timeout.
> 
>     int epoll_pwait2(int fd, struct epoll_event *events,
>                      int maxevents,
>                      const struct timespec *timeout,
>                      const sigset_t *sigset);
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

Thank you for the patch. And thanks for fixing epoll_(p)wait!
Patch applied.

Cheers,

Michael

> ---
> 
> This is the same as an RFC sent earlier.
> 
> epoll_pwait2 is now merged in 5.11-rc1.
> 
> I'm not sure whether to send for manpages inclusion before 5.11
> reaches stable ABI, or after. Erring on the side of caution. It
> could still be reverted before then, of course.
> ---
>  man2/epoll_wait.2 | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/man2/epoll_wait.2 b/man2/epoll_wait.2
> index 36001e02bde3..21d63503a87f 100644
> --- a/man2/epoll_wait.2
> +++ b/man2/epoll_wait.2
> @@ -22,7 +22,7 @@
>  .\"
>  .TH EPOLL_WAIT 2 2020-04-11 "Linux" "Linux Programmer's Manual"
>  .SH NAME
> -epoll_wait, epoll_pwait \- wait for an I/O event on an epoll file descriptor
> +epoll_wait, epoll_pwait, epoll_pwait2 \- wait for an I/O event on an epoll file descriptor
>  .SH SYNOPSIS
>  .nf
>  .B #include <sys/epoll.h>
> @@ -32,6 +32,9 @@ epoll_wait, epoll_pwait \- wait for an I/O event on an epoll file descriptor
>  .BI "int epoll_pwait(int " epfd ", struct epoll_event *" events ,
>  .BI "               int " maxevents ", int " timeout ,
>  .BI "               const sigset_t *" sigmask );
> +.BI "int epoll_pwait2(int " epfd ", struct epoll_event *" events ,
> +.BI "                int " maxevents ", const struct timespec *" timeout ,
> +.BI "                const sigset_t *" sigmask );
>  .fi
>  .SH DESCRIPTION
>  The
> @@ -170,6 +173,25 @@ argument may be specified as NULL, in which case
>  .BR epoll_pwait ()
>  is equivalent to
>  .BR epoll_wait ().
> +.SS epoll_pwait2 ()
> +The
> +.BR epoll_pwait2 ()
> +system call is equivalent to
> +.BR epoll_pwait ()
> +except for the
> +.I timeout
> +argument. It takes an argument of type
> +.I timespec
> +to be able to specify nanosecond resolution timeout. This argument functions
> +the same as in
> +.BR pselect (2)
> +and
> +.BR ppoll (2).
> +If
> +.I timeout
> +is NULL, then
> +.BR epoll_pwait2 ()
> +can block indefinitely.
>  .SH RETURN VALUE
>  On success,
>  .BR epoll_wait ()
> @@ -217,6 +239,9 @@ Library support is provided in glibc starting with version 2.3.2.
>  .BR epoll_pwait ()
>  was added to Linux in kernel 2.6.19.
>  Library support is provided in glibc starting with version 2.6.
> +.PP
> +.BR epoll_pwait2 ()
> +was added to Linux in kernel 5.11.
>  .SH CONFORMING TO
>  .BR epoll_wait ()
>  and
> @@ -269,7 +294,9 @@ this means that timeouts greater than 35.79 minutes are treated as infinity.
>  .SS C library/kernel differences
>  The raw
>  .BR epoll_pwait ()
> -system call has a sixth argument,
> +and
> +.BR epoll_pwait2 ()
> +system calls have a sixth argument,
>  .IR "size_t sigsetsize" ,
>  which specifies the size in bytes of the
>  .IR sigmask
> 


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
