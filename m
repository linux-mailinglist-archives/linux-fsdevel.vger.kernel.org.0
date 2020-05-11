Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22A71CE7CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgEKVyc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727932AbgEKVy3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:54:29 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E603C061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:54:28 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w6so10285073ilg.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aPa5e0ewGF0+g7t4q9Z6TUX7qzgQDWrwC6JLoi/D8Hg=;
        b=Qe1flitVC8NJlm1PBURT/348ONTqRt+Ootq4yZE/3KHeCLlDB8UNISCXNcRJVptWNS
         ye5XjVAq11vpCYzye7ffXo/v35K51uyEp64uvqr6thirVrtRbI+IM3oVx5RSV24ajzTq
         qLtULWOAnXVb1xCnmnkp0t2KDK2ELRUUrNmHcGKi3bKyV6HgM45UZMAQOuIgj2gPea5i
         M9oelcMyOUdpcZIVAHAwiis129qXsIXKCbJl1eM9Ky9Tw5s0OXNuY26neNQjbtgHtKMO
         b8LdNC4s4/Y17SHhbmpGVh6nOItCLdeeO+gPR6q1LSz3Cb3OcsHwb4UTBO30Fb2Mhl6R
         9RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aPa5e0ewGF0+g7t4q9Z6TUX7qzgQDWrwC6JLoi/D8Hg=;
        b=WRmklvVGgq1YeCIZzsB+Ls1r3ETYImniVtnUr6cKoUmVrHwlWck9xz7tWHP9rdEPaE
         fJeeCpRJT6s5UKSL2aHrLoY6S6oapXSzmcRdVHDIO0EMbrIV8Buk/qhwtIqv5JaU7YFf
         +adD8i/YgNrPILAQK9t2zEZr4DTWiOwZdsXB5DfrpMwPIDfo13kR2zsdKu72C/wDYkd0
         ujWMjT89MuTZdMtvk496L8+8CWIRBQs58nAFOZsNW5GaUzgec47knnrYNW5D6OiMCjCm
         alE9bZt6aX9YFskG2n6Asu2ge0h9GnPOTdPJ7Sdmy423xTPH08pCXAZzK/7Qf0J0NQRf
         bWLg==
X-Gm-Message-State: AGi0PuaZvFp3z4EX0+CgKB15IsZJ/cIXEfFvJuTpJ6yGDXhh4vztpbUV
        9RhrIks7LaH7EXGgaoG8zhyUaGOYCymYAU7I4V5xDA==
X-Google-Smtp-Source: APiQypJRy/FQZYMKm5MARaKs3uE8tTBal/SeUZfb8KmnYhnrnugOdEw2WXefVpeVpGU3rU+21hsOXsa3QvX3VghOdz4=
X-Received: by 2002:a92:b69b:: with SMTP id m27mr18147681ill.250.1589234067769;
 Mon, 11 May 2020 14:54:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200511180245.215198-1-fabf@skynet.be>
In-Reply-To: <20200511180245.215198-1-fabf@skynet.be>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 00:54:15 +0300
Message-ID: <CAOQ4uxhMNdStEn=qmMFkxV54NKx+YjsDAh3AUaiX-+D4k=yE2w@mail.gmail.com>
Subject: Re: [PATCH 8/9 linux-next] fanotify: clarify mark type extraction
To:     Fabian Frederick <fabf@skynet.be>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 9:02 PM Fabian Frederick <fabf@skynet.be> wrote:
>
> mark type is resolved from flags but is not itself bitwise.
> That means user could send a combination and never note
> only one value was taken in consideration. This patch clarifies
> that fact in bit definitions.
>
> Thanks to Amir for explanations.
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>
> ---
>  include/uapi/linux/fanotify.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index a88c7c6d0692..675bf6bbbe50 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -71,7 +71,12 @@
>  #define FAN_MARK_FLUSH         0x00000080
>  /* FAN_MARK_FILESYSTEM is      0x00000100 */
>
> -/* These are NOT bitwise flags.  Both bits can be used togther.  */
> +/*
> + * These are NOT bitwise flags.  Both bits can be used together.
> + * IOW if someone does FAN_MARK_INODE | FAN_MARK_FILESYSTEM
> + * it will be considered FAN_MARK_FILESYSTEM and user won't be
> + * notified.

Sorry, I don't find that those added lines add information.
They are stating something obvious.
Especially, in uapi file, I rather not say anything at all then say
confusing things.

Thanks,
Amir.

> + */
>  #define FAN_MARK_INODE         0x00000000
>  #define FAN_MARK_MOUNT         0x00000010
>  #define FAN_MARK_FILESYSTEM    0x00000100
> --
> 2.26.2
>
