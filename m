Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7D9A257DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Aug 2020 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgHaPqt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Aug 2020 11:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgHaPqs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:46:48 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B27C061573
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 08:46:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v12so7237713ljc.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2020 08:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AoMEfgYRxQkncZxnPbeI2rx7pGrsAFC42S72eCBWIc=;
        b=abrgTriqszl9wlmYoiAi460uozclBt//bwVG6oUCXIYMaa47WhwIZ5OK0cldnL8eqx
         kNKaDE2trDqOmVr2v/5ZmMIBj2c5PslJlv2Elxb/ggWXIl4U516/Abqy0/HIN11cbHzC
         h8C0QuQWNNXaJFVu9EOU4Qi0NTNySPdoHprKNcyWCbK9chZpfcUvtCbiRjiPab6dcFod
         cFZFGqvlQJm9x3ZyscjpjPZ69FH2ahfgHP/+UCwH1Y5lgf1ncOpukzXYqKZ78eqI2EBq
         7lhaKLnGzzeilsmbuB5IrcJQGGm0tySPQBMaTkEq/xFYC2aa8zaYOqufmsUAWhTl1Ena
         7ICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AoMEfgYRxQkncZxnPbeI2rx7pGrsAFC42S72eCBWIc=;
        b=r5MiDIEHzq0eYzbrWqLvZ18YaT1r6IpdhD17YNnU9DAClX11ptGCu6/nW8iIxCfERQ
         RdYedP2OeRHN0wEvt0i2PoIyOmocjt8WZxTf1dlrJIOQN6EI5lxspm6s5+77JigYwQjz
         jls+cypko1jcl4zQG1LRLTydN/iaMF0ReLG2UbDDJGRN/dyBmMv86SwgZJYkvnrnyJFW
         Ur2QxWRYcqurtm7QYhWbuWUgtJ5VZKaCVkRY4IncMPRq+yXUCkQqGcoKIVJoCXe5jJ19
         LsZqF2CW2wd/zg0j2Eu7kGW8XLJVVVMLVcikp/8hdGcse3dlSDYLboDHZjztLIOmTZ8i
         bY8A==
X-Gm-Message-State: AOAM532icn0bOnC53Cj7s4f7kvUgQLBlRkUr3pwCCP7x6KcXIH4Tlz6Q
        JfR3KByRgqmAVKqfFpxhNjhLG+dv0RfM6FQy4ngLVg==
X-Google-Smtp-Source: ABdhPJw8ICUjRfg1psgk3VeEEbjk3V7kQYtrfhITr5IhGR+QFzandviK26WiXtH9qc+8aQaXY2IApqpO+DdwQrzFP68=
X-Received: by 2002:a2e:9990:: with SMTP id w16mr872000lji.156.1598888805568;
 Mon, 31 Aug 2020 08:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200831153207.GO3265@brightrain.aerifal.cx>
In-Reply-To: <20200831153207.GO3265@brightrain.aerifal.cx>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 31 Aug 2020 17:46:19 +0200
Message-ID: <CAG48ez39WNuoxYO=RaW5OeVGSOy=uEAZ+xW_++TP7yjkUKGqkg@mail.gmail.com>
Subject: Re: [PATCH v2] vfs: add RWF_NOAPPEND flag for pwritev2
To:     Rich Felker <dalias@libc.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 31, 2020 at 5:32 PM Rich Felker <dalias@libc.org> wrote:
> The pwrite function, originally defined by POSIX (thus the "p"), is
> defined to ignore O_APPEND and write at the offset passed as its
> argument. However, historically Linux honored O_APPEND if set and
> ignored the offset. This cannot be changed due to stability policy,
> but is documented in the man page as a bug.
>
> Now that there's a pwritev2 syscall providing a superset of the pwrite
> functionality that has a flags argument, the conforming behavior can
> be offered to userspace via a new flag. Since pwritev2 checks flag
> validity (in kiocb_set_rw_flags) and reports unknown ones with
> EOPNOTSUPP, callers will not get wrong behavior on old kernels that
> don't support the new flag; the error is reported and the caller can
> decide how to handle it.
>
> Signed-off-by: Rich Felker <dalias@libc.org>

Reviewed-by: Jann Horn <jannh@google.com>

Note that if this lands, Michael Kerrisk will probably be happy if you
send a corresponding patch for the manpage man2/readv.2.

Btw, I'm not really sure whose tree this should go through - VFS is
normally Al Viro's turf, but it looks like the most recent
modifications to this function have gone through Jens Axboe's tree?

> ---
>
> Changes in v2: I've added a check to ensure that RWF_NOAPPEND does not
> override O_APPEND for S_APPEND (chattr +a) inodes, and fixed conflicts
> with 1752f0adea98ef85, which optimized kiocb_set_rw_flags to work with
> a local copy of flags. Unfortunately the same optimization does not
> work for RWF_NOAPPEND since it needs to remove flags from the original
> set at function entry.
>
> If desired, I could further change this so that kiocb_flags is
> initialized to ki->ki_flags, with assignment-back in place of |= at
> the end of the function. This would allow the same local variable
> pattern in the RWF_NOAPPEND code path, which might be more elegant,
> but I'm not sure if the emitted code would improve or get worse.
>
>
>  include/linux/fs.h      | 7 +++++++
>  include/uapi/linux/fs.h | 5 ++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 7519ae003a08..924e17ac8e7e 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3321,6 +3321,8 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>                 return 0;
>         if (unlikely(flags & ~RWF_SUPPORTED))
>                 return -EOPNOTSUPP;
> +       if (unlikely((flags & RWF_APPEND) && (flags & RWF_NOAPPEND)))
> +               return -EINVAL;
>
>         if (flags & RWF_NOWAIT) {
>                 if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
> @@ -3335,6 +3337,11 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, rwf_t flags)
>                 kiocb_flags |= (IOCB_DSYNC | IOCB_SYNC);
>         if (flags & RWF_APPEND)
>                 kiocb_flags |= IOCB_APPEND;
> +       if ((flags & RWF_NOAPPEND) && (ki->ki_flags & IOCB_APPEND)) {
> +               if (IS_APPEND(file_inode(ki->ki_filp)))
> +                       return -EPERM;
> +               ki->ki_flags &= ~IOCB_APPEND;
> +       }
>
>         ki->ki_flags |= kiocb_flags;
>         return 0;
> diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
> index f44eb0a04afd..d5e54e0742cf 100644
> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -300,8 +300,11 @@ typedef int __bitwise __kernel_rwf_t;
>  /* per-IO O_APPEND */
>  #define RWF_APPEND     ((__force __kernel_rwf_t)0x00000010)
>
> +/* per-IO negation of O_APPEND */
> +#define RWF_NOAPPEND   ((__force __kernel_rwf_t)0x00000020)
> +
>  /* mask of flags supported by the kernel */
>  #define RWF_SUPPORTED  (RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
> -                        RWF_APPEND)
> +                        RWF_APPEND | RWF_NOAPPEND)
>
>  #endif /* _UAPI_LINUX_FS_H */
> --
> 2.21.0
>
