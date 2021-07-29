Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9A3DA407
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 15:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237432AbhG2NZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237344AbhG2NZ4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:25:56 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55881C061765;
        Thu, 29 Jul 2021 06:25:53 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id nb11so10731361ejc.4;
        Thu, 29 Jul 2021 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0yqI1c2xw6Ag4eb0/wFVzwBfqXP1l2U+gD4rpUuRLoc=;
        b=rBzqcLkQUSK/5Xxs67ffLOpTFT5R7Lgl8aYDi8EIGc3wNbbGhsKCgH6E6buXmf+D71
         ezaPl7v8a3PFO117edsBvpz3i7LaFpArjdii14swjFFY7nlYB3SC3JzB18urKI6f6xOR
         VVh2upVCSS0AXzHPsGlbo1qiv8cPl5ABZDFOb39wUFaYIQRa1JXM7/ERZ9XIPqDd0sth
         Ae6pW5ERAFJZf3S3sBeZ57wFI/5GZGf8JrsIvmmPB9X7uT1xaRqyCGYacVlIm+EzLUwf
         NeDV4GLuigXikY+FrxJlWDfS6Bf52rd6JzyFd3tXpSUuoBngecUT8v2tHKcfQICiyq8V
         DJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0yqI1c2xw6Ag4eb0/wFVzwBfqXP1l2U+gD4rpUuRLoc=;
        b=cL0d8AVSs3JHk0WI4bhYfq/AgPVWPWumZoZPaVCHTIDi2JvJEDB4gEoW5wvK1eNzUA
         P9hh/8ecrJxbDcSO3tpoBBU+SA8xQ0NJ21nq0gRwcQ4+uRwnGYx0osuzCT/KSAtfyenf
         piRnAkQEQGSlE6+OzE/zphbHGJV74ZlaF2sIxSXcwz6FRg2dFq/qFdXfdJNs5qk7jELW
         J3ym/7oz2mhzwaaS/x58CKJ5+FpQIPE/LNGdOJGwBUKHTTF98WhNMs2CSlft6Dpve//I
         sn2qICVr+ywi4UvXtyn35qTilY3Zg0P0DQxbGqmPNWDIJLnDx5SbFCZTFm+GtkMK6B4/
         onwQ==
X-Gm-Message-State: AOAM532ek4sohpDZCJgqxmG9KnZziPSV5N1VflXcw5yqAwv7cxYgx8p/
        cUSpdQctoFnB+filQuXhbVY+uWaYEA+BwCDvkZ4=
X-Google-Smtp-Source: ABdhPJx1gOhljOB1Dl3tZLRJDmAsBaEumKcoFb6pN85XzBviPWkXKr7euYXCy0Mr6I0AoYuuuQ04uaXw3MPCPyxjt6A=
X-Received: by 2002:a17:906:3915:: with SMTP id f21mr4712718eje.178.1627565151886;
 Thu, 29 Jul 2021 06:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn> <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein> <20210607121524.GB3896@www>
 <20210617035756.GA228302@www> <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
 <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com>
 <20210727123701.zlcrrf4p2fsmeeas@wittgenstein> <YQEQTO+AwC67BT4u@alley>
In-Reply-To: <YQEQTO+AwC67BT4u@alley>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 29 Jul 2021 21:25:40 +0800
Message-ID: <CADxym3a3=Xjj4LkRDMyiCnFm3BfG7s_iGoR1EjNWA9ytoS2tSQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for initramfs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, johan@kernel.org,
        ojeda@kernel.org, jeyu@kernel.org, masahiroy@kernel.org,
        joe@perches.com, Jan Kara <jack@suse.cz>, hare@suse.de,
        Jens Axboe <axboe@kernel.dk>, tj@kernel.org,
        gregkh@linuxfoundation.org, song@kernel.org,
        NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Barret Rhoden <brho@google.com>, f.fainelli@gmail.com,
        palmerdabbelt@google.com, wangkefeng.wang@huawei.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>, vbabka@suse.cz,
        Alexander Potapenko <glider@google.com>,
        johannes.berg@intel.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, jojing64@gmail.com,
        terrelln@fb.com, geert@linux-m68k.org,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, arnd@arndb.de,
        Chris Down <chris@chrisdown.name>, mingo@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Josh Triplett <josh@joshtriplett.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

On Wed, Jul 28, 2021 at 4:07 PM Petr Mladek <pmladek@suse.com> wrote:
>
[...]
>
> I guess that you have seen the following message printed by
> console_on_rootfs():
>
>       "Warning: unable to open an initial console."
>
> This function is responsible for opening stdin, stdout, stderr
> file to be used by the init process.
>
> I am not sure how this is supposed to work with the pivot_root
> and initramfs.
>
>
> Some more details:
>
> console_on_rootfs() tries to open /dev/console. It is created
> by tty_init(). The open() callback calls:
>
>   + tty_kopen()
>     + tty_lookup_driver()
>       + console_device()
>
> , where console_device() iterates over all registered consoles
>   and returns the first with tty binding.
>
> There is ttynull_console that might be used as a fallback. But I
> am not sure if this is what you want.

I didn't figure out the relation between initramfs and initial console,
could you please tell me how this warning came up? I can't
reproduce it in qemu with this command:

qemu-system-x86_64 -nographic -m 2048M -smp cores=4,sockets=1 -s
-kernel ./bzImage -initrd ./rootfs.cpio -append "rdinit=/init
console=ttyS0"

Thanks!
Menglong Dong

>
> Best Regards,
> Petr
