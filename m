Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE040EEFF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 03:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242526AbhIQB7n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Sep 2021 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhIQB7m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Sep 2021 21:59:42 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D82CC061574;
        Thu, 16 Sep 2021 18:58:21 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g21so23971015edw.4;
        Thu, 16 Sep 2021 18:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=avIIapDTLmGXo38SX42D/9erFS1h/0wzUYg4aqKVx1o=;
        b=YpW7z7rQ/DbpMDxYo9EM+A8//B+X6d8czmk4TX8kr9QX2Gp9kPfhKYteuZZA+nqz0Z
         YCBGINvXScYO7y4ePOzhPhHDVACGX5l4rIpPHpCjRlS/cMQtYNTgttK5SUWmY5dIDEsY
         iKPAezp9D9b/Xmb3Pk9EBfES1+i9J7rUsMTsA/XBGW0dFhP0tM6oiK9AavuE8R/WyxPB
         PWlkzUTzTcW9NgDnn6nf+7zcaPN8Tw1PQxmxe0wvmqQfEjIYN86lCpYx+YQJLuN25QNu
         LbWg1Czf72rPLailtg5J2dMBW62TymX4oe/8ovTc4IdCC46wBk4a1Y1KvydmKBC9Gh9H
         arvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=avIIapDTLmGXo38SX42D/9erFS1h/0wzUYg4aqKVx1o=;
        b=FZJh+YMk17QeKuhm9iVQXH+BG4o9gVqvtPu2rGDMTOCwBD3ted0hDetzi20kSp3tvw
         B5p+ZBKzGg3EVgjqp3L7xzo0msCwWjBQWuFM1Fpm25rIxaGe1SNs8qxaqQiVeNLbyO6E
         OqvqcFXdcskv5nzHRSTSfK7abM+ELb7gJTzyFqK9D9VE9kgRbDxkEPSQ/iDdCqQskDus
         jP1xEJZlTfWYoSiQ8sJzA36e+StwPRdnJKGH8eASTBAOu+fO1E+cFgTSDSw3+t56h9Hh
         m7J7CWZe3+MO6a9uSIhqHOuaPVCLKa5ndgWqSXw88tpOcVgrjDCmJVpU//7UPodltBrI
         WSTg==
X-Gm-Message-State: AOAM530BgiqksEfx82K5dYeH+9ozQDK91rt4NNFE4Ytwdv/4MvLKxbID
        RJ42ztB39G/1R2ViIzwCQOf7+0KYZpmdAWYguTs=
X-Google-Smtp-Source: ABdhPJwyvpnmZ76jVQtEQvqR5BMtghiLRxO1SK+QRZzDt8m4ZnzDe4uwtAQq/2IpIWcOISNyQDmbXvuZ+5MUwQMxPn0=
X-Received: by 2002:a17:906:3983:: with SMTP id h3mr9488725eje.249.1631843899899;
 Thu, 16 Sep 2021 18:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210605034447.92917-1-dong.menglong@zte.com.cn>
 <20210605034447.92917-3-dong.menglong@zte.com.cn> <20210605115019.umjumoasiwrclcks@wittgenstein>
 <CADxym3bs1r_+aPk9Z_5Y7QBBV_RzUbW9PUqSLB7akbss_dJi_g@mail.gmail.com>
 <20210607103147.yhniqeulw4pmvjdr@wittgenstein> <20210607121524.GB3896@www>
 <20210617035756.GA228302@www> <20210617143834.ybxk6cxhpavlf4gg@wittgenstein>
 <CADxym3aLQNJaWjdkMVAjuVk_btopv6jHrVjtP+cKwH8x6R7ojQ@mail.gmail.com> <20210727123701.zlcrrf4p2fsmeeas@wittgenstein>
In-Reply-To: <20210727123701.zlcrrf4p2fsmeeas@wittgenstein>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Fri, 17 Sep 2021 09:58:04 +0800
Message-ID: <CADxym3YxBAJmXr1qmJ+3ELrT6RKY-UoFmpaPH5iYmbEa1H+03Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] init/do_mounts.c: create second mount for initramfs
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
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
        Petr Mladek <pmladek@suse.com>, johannes.berg@intel.com,
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

On Tue, Jul 27, 2021 at 8:37 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
[...]
>
> Yep, sorry.
> When I tested this early during the merge window it regressed booting a
> regular system for me meaning if I compiled a kernel with this feature
> enabled it complained about not being being able to open an initial
> console and it dropped me right into initramfs instead of successfully
> booting. I haven't looked into what this is caused or how to fix it for
> lack of time.

Our team has fully tested this feature, and no abnormalities have been
found yet.
What's more, this feature has been used in the product of our company. So if
there is any potential bug, as you mentioned above, I'd appreciate it if you can
spend some time on looking into it.

What's more, besides the problem that this feature solved, it has some more
benefits: saving memory. The amount of 'mnt_cache' is up to 50k when 180 docker
containers are created without this feature. However, only 15k 'mnt_cache' are
used with this feature enabled. Each 'mnt_cache' eats 320 bytes, so about 11M
memory is saved in this situation.

Please let me know if this feature is illogical or if there is any
better solution, thanks~

Best Wishes!
Menglong Dong
