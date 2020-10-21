Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC22946F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Oct 2020 05:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411741AbgJUDZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 23:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411737AbgJUDZ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 23:25:28 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B448BC0613CE;
        Tue, 20 Oct 2020 20:25:28 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id o70so551655ybc.1;
        Tue, 20 Oct 2020 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BgMVuB2N5ltBtKxokUkl8GedhrK39u21aX6B4sBRZa0=;
        b=ZQ7zCHAMvVC/scvMvJZs/aSkZ5Tr2Gm5YWdPIj6/F4rz6Rv2WsRzDBYlhMS8R4Y+15
         H6EGCPHelu+nL7TS2pAamJ+he771sRFp27cboqDGFjO7j809rx9ti/f34BP+9rUpJ6TN
         6psz8AtRovaTxSY/ROnTKGST3G4weu/AblR4vGndPSW9VanopOs5fZOYC0kNfahdvmOI
         Nogx6u16tDmHlVWM5I6LwJjZo2UCiIuFRBX+CfCoBuTxlWq8URJr8kU+jGLpEIzIS3wU
         pE6GQkPpdd+3HyaB+O1QkZuXXLTjz39BBJzywky3NsGKxjRsyrFXYG8rhw+TRQYMepaC
         0OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BgMVuB2N5ltBtKxokUkl8GedhrK39u21aX6B4sBRZa0=;
        b=Noc5OZHyWEW+woAwvUZNpqKWw3TTdskXJs79usS0oHca78/Vs7ObvMP6aT1zAhlHoe
         1qRkWSQm3Ip9ds4AGl3akNoEIVcXQ/PmwQnF9zKSR0+dG3Ollu+kYqqZucOpd2LeGPxe
         4kPBIAk7HIUIOX4lQ3tiuiPezlAF9hXYz/AGQH4tv4b8nKd0QUEIDV2AtfL+KNr4i02c
         J10/B4Vi6fwWbMnN3SLNWPj9Bc6cQhOxl1yagZwfelHeVgYcSmFPIukC4fvqBz4QKj6q
         hH9Eqmz3D9X4hdGhvArE3Zpmg5mOFHmXrMboB5rN0f9xJrhDVuQ8ss/4//Kg95DZ73p7
         WonQ==
X-Gm-Message-State: AOAM533X1cvnLMvmH9tAWwvHESNJHbTM6rx0oI29IkaaulKF8Ype7gNH
        zoHqgXwfVKHG6LhU3kRjw8bC/rd2cQs8VCzt9O8=
X-Google-Smtp-Source: ABdhPJziw2B1ToW4twWYZcXqsXgezDcik3rjW5Z/C62EOwsTefLgSWBsPy2+tyKAOFze15PJvfYiv9o410uuPYcXRVI=
X-Received: by 2002:a25:a468:: with SMTP id f95mr2136912ybi.327.1603250727770;
 Tue, 20 Oct 2020 20:25:27 -0700 (PDT)
MIME-Version: 1.0
References: <CANT5p=pwCHvNbQSqQpH3rdp39ESCXMfxnh9wWrqMaSk9xkdq1g@mail.gmail.com>
 <20201021022118.GH20115@casper.infradead.org>
In-Reply-To: <20201021022118.GH20115@casper.infradead.org>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 21 Oct 2020 08:55:17 +0530
Message-ID: <CANT5p=qQ19iND_54Esj7buyWdJdh5EHFs5uuRYnecsnjKizA=g@mail.gmail.com>
Subject: Re: Linux-cifs readdir behaviour when dir modified
To:     Matthew Wilcox <willy@infradead.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Thanks for the reply.
Sorry if it was unclear in my earlier email. I'm the engineer working
on cifs.ko, who's now trying to understand what's the "standard" way
of handling this which the VFS expects from the underlying filesystem.
And it sounds to me like there's no such standard way. I read this
codepath in a couple of popular filesystems, and each one seems to
have it's own way of handling this.

I wanted to reconfirm that the main issue is in the implementation of
the rm command on this distro, and the way it's using libc.

Regards,
Shyam

On Wed, Oct 21, 2020 at 7:51 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 20, 2020 at 11:14:11AM +0530, Shyam Prasad N wrote:
> > A summary of the issue:
> > With alpine linux containers (which uses the musl implementation of
> > libc), the "rm -Rf" command could fail depending upon the dir size.
> > The Linux cifs client filesystem behaviour is compared against ext4
> > behaviour.
> [...]
> > Now the question is whether cifs.ko is doing anything wrong?
> > @Steve French pointed me to this readdir documentation:
> > https://pubs.opengroup.org/onlinepubs/9699919799/functions/readdir_r.html
> >
> > If a file is removed from or added to the directory after the most
> > recent call to opendir() or rewinddir(), whether a subsequent call to
> > readdir() returns an entry for that file is unspecified.
> >
> > So I guess the documents don't specify the behaviour in this case.
>
> Or rather, your implementation of 'rm' is relying on unspecified
> behaviour.  If it's doing rm -rf, it can keep calling readdir() [1]
> but before it tries to unlink() the directory, it should rewinddir()
> and see if it can find any more entries.  It shouldn't rely on the kernel
> to fix this up.  ie:
>
>         DIR *dirp = opendir(n);
>         bool first = true;
>
>         for (;;) {
>                 struct dirent *de = readdir(dirp);
>
>                 if (!de) {
>                         if first)
>                                 break;
>                         rewinddir(dirp);
>                         continue;
>                 }
>                 first = false;
>                 unlink(de.d_name);
>         }
>         unlink(n);
>
> ... only with error checking and so on.
>
> [1] Use readdir() rather than readdir_r() -- see the glibc 2.24+
> documentation for details.



-- 
-Shyam
