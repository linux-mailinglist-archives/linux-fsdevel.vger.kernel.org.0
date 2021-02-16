Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810CB31CBFD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Feb 2021 15:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhBPOcS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Feb 2021 09:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhBPOcQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:32:16 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FC0C061756
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 06:31:36 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v9so8024112edw.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Feb 2021 06:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-powerpc-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Cwp0GvNwrAKCsxhmN2M2a4yWcZ0QuLL5twK22get2lQ=;
        b=qJlG9FlA7//SkKP/KnlTJeFd6JUIm4cekamkBIQ/iXSOVyrdk18xUSllNJ4yqhudNj
         0T0x2Lgq/YuugQp4tqCIVxr5a5x1SIES65IWUxlfEnQH0KZUFz+zdymaLQ0384Dj53Dm
         0zTYT+CPtNsDSqDxlb5EqzolLdigLgLZHpm49UEm/hYLZeG+AqlyfYLgD9CVblwWFEaJ
         nHo57+pnHaKALVgGE6gghdqaPz9uZa9mbzZFOyOp+gSOv2G7wkg8EovSY4fGuYWvZCUe
         y21vzEydXuDUw/ARNI7vcaXaQ5LHaHiUcbYQ4iFIo7Oz2VBK95wJMPLXt7njAuGITUwd
         UA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Cwp0GvNwrAKCsxhmN2M2a4yWcZ0QuLL5twK22get2lQ=;
        b=ae+IVNP/KhIuLPLKfDLMbOIjae2am263V4AT1361r7iWZhqzLcK7k09xH3v7LgLBBk
         BpJAv0TwGFIG2nPN1+evI0295mmMr0iVZa49h7G8QUeJ3peydWgF5IrVIh+0iqhCCalb
         +nCTL5Rlqgh4GxNUzLPe6wTCvRx7hYSJK/U1IxDJyfkugFqMkQwoREM2Cya08nfkL67z
         91SaY6bI2hTU7u+bTbgJk5L/zMrf5xb0LTG9CjdNkOh8b7fgYeo7O7+CCs/ZTHuAZfch
         yfJJgHz3AtgPhE/mgznRjuqugxSb6sHrShjuP17xvgFA/UiiJjnLSNhce0BWHjtbvp+K
         OpfA==
X-Gm-Message-State: AOAM532OfErV8hqeJHMC8YNhBr/7iL7I4OKiHvE60QAebpCVfSnfxmsz
        s7Zv6LI1GHunzAZBb+sBK5C4kUlCxVaWFCjO0/HJOQ==
X-Google-Smtp-Source: ABdhPJysJT0RF7U5yKNSmD/jkMS3xj72OfKUlQ8vlUlq2ZOgMW5AzeNvFj4Rde7f7LSsNc5ePhNzOSjpLi1FnchyB8Q=
X-Received: by 2002:a50:a6ce:: with SMTP id f14mr20984271edc.346.1613485894678;
 Tue, 16 Feb 2021 06:31:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a50:6cc7:0:0:0:0:0 with HTTP; Tue, 16 Feb 2021 06:31:33
 -0800 (PST)
X-Originating-IP: [5.35.34.67]
In-Reply-To: <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
References: <20210125154937.26479-1-kda@linux-powerpc.org> <20210127175742.GA1744861@infradead.org>
 <CAOJe8K0MC-TCURE2Gpci1SLnLXCbUkE7q6SS0fznzBA+Pf-B8Q@mail.gmail.com>
 <20210129082524.GA2282796@infradead.org> <CAOJe8K0iG91tm8YBRmE_rdMMMbc4iRsMGYNxJk0p9vEedNHEkg@mail.gmail.com>
 <20210129131855.GA2346744@infradead.org> <YClpVIfHYyzd6EWu@zeniv-ca.linux.org.uk>
From:   Denis Kirjanov <kda@linux-powerpc.org>
Date:   Tue, 16 Feb 2021 17:31:33 +0300
Message-ID: <CAOJe8K00srtuD+VAJOFcFepOqgNUm0mC8C=hLq2=qhUFSfhpuw@mail.gmail.com>
Subject: Re: [PATCH] fs: export kern_path_locked
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/14/21, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Fri, Jan 29, 2021 at 01:18:55PM +0000, Christoph Hellwig wrote:
>> On Fri, Jan 29, 2021 at 04:11:05PM +0300, Denis Kirjanov wrote:
>> > Do you mean just:
>>
>> We'll still need to lock the parent inode.
>
> Not just "lock", we wouldd need to have the lock _held_ across the
> entire sequence.  Without that there's no warranty that it will refer
> to the same object we'd created.
>
> In any case, unlink in any potentially public area is pretty much
> never the right approach.  Once mknod has happened, that's it - too
> late to bail out.
>
> IIRC, most of the PITA in that area is due to unix_autobind()
> iteractions.  Basically, we try to bind() an unbound socket and
> another thread does sendmsg() on the same while we are in the
> middle of ->mknod().  Who should wait for whom?
>
> ->mknod() really should be a point of no return - any games with
> "so we unlink it" are unreliable in the best case, and that's
> only if we do _not_ unlock the parent through the entire sequence.
>
> Seeing that we have separate bindlock and iolock now...  How about
> this (completely untested) delta?

We had a change like that:
Author: WANG Cong <xiyou.wangcong@gmail.com>
Date:   Mon Jan 23 11:17:35 2017 -0800

    af_unix: move unix_mknod() out of bindlock

    Dmitry reported a deadlock scenario:

    unix_bind() path:
    u->bindlock ==> sb_writer

    do_splice() path:
    sb_writer ==> pipe->mutex ==> u->bindlock

    In the unix_bind() code path, unix_mknod() does not have to
    be done with u->bindlock held, since it is a pure fs operation,
    so we can just move unix_mknod() out.


>
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index 41c3303c3357..c21038b15836 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -1034,6 +1034,14 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  		goto out;
>  	addr_len = err;
>
> +	err = mutex_lock_interruptible(&u->bindlock);
> +	if (err)
> +		goto out;
> +
> +	err = -EINVAL;
> +	if (u->addr)
> +		goto out_up;
> +
>  	if (sun_path[0]) {
>  		umode_t mode = S_IFSOCK |
>  		       (SOCK_INODE(sock)->i_mode & ~current_umask());
> @@ -1041,18 +1049,10 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  		if (err) {
>  			if (err == -EEXIST)
>  				err = -EADDRINUSE;
> -			goto out;
> +			goto out_up;
>  		}
>  	}
>
> -	err = mutex_lock_interruptible(&u->bindlock);
> -	if (err)
> -		goto out_put;
> -
> -	err = -EINVAL;
> -	if (u->addr)
> -		goto out_up;
> -
>  	err = -ENOMEM;
>  	addr = kmalloc(sizeof(*addr)+addr_len, GFP_KERNEL);
>  	if (!addr)
> @@ -1090,7 +1090,6 @@ static int unix_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  	spin_unlock(&unix_table_lock);
>  out_up:
>  	mutex_unlock(&u->bindlock);
> -out_put:
>  	if (err)
>  		path_put(&path);
>  out:
>
