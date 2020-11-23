Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87AF2C18C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Nov 2020 23:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbgKWWrE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 17:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731570AbgKWWrD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 17:47:03 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98881C0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 14:46:55 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id f24so6967583ljk.13
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Nov 2020 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jasiak-xyz.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2kFEjBabQcANouc2ZtbSNLTwqyFoPLbdSDW7PtNlwTQ=;
        b=qzWD0WCyEO/aZMoVIpmH8IJW7lS97cszkL/eiEVPOao15KtWDx3DaJkvIeYFf94U3q
         0nEcY4V2ZomYm4kcvBS/QKgCfcU6/3acoyRWKvHlRiNIARIPoK69avlVHHA18FUaG12S
         MC90WC+T2VMmAIRk6VhVNOtg6/3YR2ei9RGtUZG7bGRur4GMasLkMZcBSztAtXFGswyR
         pso00tVooCYKLXh+RQc1WqF8jgRHU/7PrYlsfbLJpRdP0F09fVLMywQxhOI/ngONKa0/
         CVMWa9nSSE5Qia1OZpUwbdaOax3maWzSVUfFZTqoGek28VT7a0QD+0jOiJrYGXlw5HN6
         NwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2kFEjBabQcANouc2ZtbSNLTwqyFoPLbdSDW7PtNlwTQ=;
        b=exagHaDL6ls4NgbCq8YRhGjknS2cWMyr6BFlnGywico2M+abJN+t8LhzNECkdu1q7X
         UwI05OW5KOuSKO8+LUOhofY8yZg33wGvX6rPTKilUM4CgKfnqSJQLVFm0aadl2g5Hk7C
         QRs9wp6KTWmv5FqCUspLFWkuSmdzt5DsHYsnUmsgnBsANcNKfMgS1fdvyv9zGbNIVJPQ
         axd1gC9f2UEATCqInhfzC0WudI/c5AVuZwnc0qq824dZ36cKoqIF4waL6bzaSQWwKZV9
         9ZXs0bzr9yTC3I180o/4YFlXmjveZLGQzVi4sO1281L6DYgjaGQjJqddMLqV1AgCx0Cy
         XKkA==
X-Gm-Message-State: AOAM532YsV+hRENh3IvXkSM9X7ch+HUxuGySGdcQToZcHanuNFWcMK51
        eyuzcvMpruGV3f9MA07v5CZLpw==
X-Google-Smtp-Source: ABdhPJy9dza13bOzvfGPMwJQzv1mHh29sk1rDDRWTMNoG0Z8vzv5JBYXNi//UQwxj6VlGg27mr8YFw==
X-Received: by 2002:a2e:580d:: with SMTP id m13mr698751ljb.200.1606171614069;
        Mon, 23 Nov 2020 14:46:54 -0800 (PST)
Received: from gmail.com (wireless-nat-78.ip4.greenlan.pl. [185.56.211.78])
        by smtp.gmail.com with ESMTPSA id q129sm110852ljb.81.2020.11.23.14.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 14:46:53 -0800 (PST)
Date:   Mon, 23 Nov 2020 23:46:51 +0100
From:   =?utf-8?B?UGF3ZcWC?= Jasiak <pawel@jasiak.xyz>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Brian Gerst <brgerst@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: PROBLEM: fanotify_mark EFAULT on x86
Message-ID: <20201123224651.GA27809@gmail.com>
References: <20201101212738.GA16924@gmail.com>
 <20201102122638.GB23988@quack2.suse.cz>
 <20201103211747.GA3688@gmail.com>
 <20201123164622.GJ27294@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201123164622.GJ27294@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 23/11/20, Jan Kara wrote:
> OK, with a help of Boris Petkov I think I have a fix that looks correct
> (attach). Can you please try whether it works for you? Thanks!

Unfortunately I am getting a linker error.

ld: arch/x86/entry/syscall_32.o:(.rodata+0x54c): undefined reference to `__ia32_sys_ia32_fanotify_mark'

> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> From fc9104a50a774ec198c1e3a145372cde77df7967 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Mon, 23 Nov 2020 17:37:00 +0100
> Subject: [PATCH] fanotify: Fix fanotify_mark() on 32-bit archs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Commit converting syscalls taking 64-bit arguments to new scheme of compat
> handlers omitted converting fanotify_mark(2) which then broke the
> syscall for 32-bit ABI. Add missed conversion.
> 
> CC: Brian Gerst <brgerst@gmail.com>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
>  fs/notify/fanotify/fanotify_user.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 0d0667a9fbd7..b2ec6ff88307 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -350,7 +350,7 @@
>  336	i386	perf_event_open		sys_perf_event_open
>  337	i386	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
>  338	i386	fanotify_init		sys_fanotify_init
> -339	i386	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
> +339	i386	fanotify_mark		sys_ia32_fanotify_mark
>  340	i386	prlimit64		sys_prlimit64
>  341	i386	name_to_handle_at	sys_name_to_handle_at
>  342	i386	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 3e01d8f2ab90..e20e7b53a87f 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1293,7 +1293,7 @@ SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
>  }
>  
>  #ifdef CONFIG_COMPAT
> -COMPAT_SYSCALL_DEFINE6(fanotify_mark,
> +SYSCALL_DEFINE6(ia32_fanotify_mark,
>  				int, fanotify_fd, unsigned int, flags,
>  				__u32, mask0, __u32, mask1, int, dfd,
>  				const char  __user *, pathname)
> -- 
> 2.16.4
> 


-- 

Paweł Jasiak
