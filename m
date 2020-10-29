Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38329F330
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Oct 2020 18:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgJ2R1U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Oct 2020 13:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgJ2R1U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Oct 2020 13:27:20 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBAF9C0613CF;
        Thu, 29 Oct 2020 10:27:19 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id k6so3869070ilq.2;
        Thu, 29 Oct 2020 10:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YCM9eeSlF+1Jtw1IHwwjrNN64amsn3vj+QDkHX36dEI=;
        b=NKnKC6h3xdQl4ty4cdzyup15DmnF4kjXRf65f+lR5OgAs6Rnj4FSMujiHj79L2ZYk/
         /Ugu6Z9fpMUZ7rP01gENB9gylCNxt55+q/fKHjtPYi/Rrho73Eq3+N2HitM+8ZnjwTwk
         wSwt+NdoYPo5SxnFrJyuWomFuaDflM+KhAhxGNBw1vzstrUYInah3B2+UpE7rckUc16G
         TnTSXaASg9yYKvbqW9B5qiFTHRH82qomXzfSPUTNDkZAWkM5grPSlEYpfa64pQpvn46I
         eQ+/Gf5P0Rmq45X6ZfNKFvAU+rRlnO4CQguB2xauBltiop4GwozvrpkGc5BZnvV1tK+x
         EQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YCM9eeSlF+1Jtw1IHwwjrNN64amsn3vj+QDkHX36dEI=;
        b=Haoi6dbnfe11u5dGfK4Xr7kwiXhCjJhh0GSJ3lM6W9/eaB6KRKBaG4RREZa4pPRMT0
         dYbRQTHldBANH9B+8IajATIVVPy6NiAoNIeasACXHuuvQVGgf1jr0FkMi4vVgDdPd43z
         LTUx/2wQOJx4Dm/F4dczbViB8NjyXaUi6QzALecfKlbjdwvexIti4BoX/djgpYMs129Y
         q+vTg8U8vjDByXzFw/FwZBop7SntE/Jh+EYsvh+HG4z4l3ivIJmse/SYBy6OPbLBQACW
         ZikGbjct3Wa2GBQxaoQWWHs923PAxL/+jBjyxLjQLV7KRSHGunBUJyKyE6610V3hxvxK
         o/VA==
X-Gm-Message-State: AOAM531Zpx3r7swfuf2tf//CbacPT0317hV18CqEoq7ewBwd6tNGH4zj
        TF9ehoa9TOuaXTI6k6+Q+Y3rkbdiQhFejGPXtj4=
X-Google-Smtp-Source: ABdhPJzNTUamixF2CmgQL9tEZ4fdoI7rQxxPeiDRJxUtqBgVORiVSgkouUORSbqbtRtuMxRxd+9eCopOAk5qHwZSNAM=
X-Received: by 2002:a92:d30f:: with SMTP id x15mr2359202ila.9.1603992439274;
 Thu, 29 Oct 2020 10:27:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201029154535.2074-1-longman@redhat.com>
In-Reply-To: <20201029154535.2074-1-longman@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 29 Oct 2020 19:27:08 +0200
Message-ID: <CAOQ4uxjT8rWLr1yCBPGkhJ7Rr6n3+FA7a0GmZaMBHMzk9t1Sag@mail.gmail.com>
Subject: Re: [PATCH v2] inotify: Increase default inotify.max_user_watches
 limit to 1048576
To:     Waiman Long <longman@redhat.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Luca BRUNO <lucab@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 29, 2020 at 5:46 PM Waiman Long <longman@redhat.com> wrote:
>
> The default value of inotify.max_user_watches sysctl parameter was set
> to 8192 since the introduction of the inotify feature in 2005 by
> commit 0eeca28300df ("[PATCH] inotify"). Today this value is just too
> small for many modern usage. As a result, users have to explicitly set
> it to a larger value to make it work.
>
> After some searching around the web, these are the
> inotify.max_user_watches values used by some projects:
>  - vscode:  524288
>  - dropbox support: 100000
>  - users on stackexchange: 12228
>  - lsyncd user: 2000000
>  - code42 support: 1048576
>  - monodevelop: 16384
>  - tectonic: 524288
>  - openshift origin: 65536
>
> Each watch point adds an inotify_inode_mark structure to an inode to
> be watched. It also pins the watched inode as well as an inotify fdinfo
> procfs file.
>
> Modeled after the epoll.max_user_watches behavior to adjust the default
> value according to the amount of addressable memory available, make
> inotify.max_user_watches behave in a similar way to make it use no more
> than 1% of addressable memory within the range [8192, 1048576].
>
> For 64-bit archs, inotify_inode_mark plus 2 inode have a size close
> to 2 kbytes. That means a system with 196GB or more memory should have
> the maximum value of 1048576 for inotify.max_user_watches. This default
> should be big enough for most use cases.
>
> With my x86-64 config, the size of xfs_inode, proc_inode and
> inotify_inode_mark is 1680 bytes. The estimated INOTIFY_WATCH_COST is
> 1760 bytes.
>
> [v2: increase inotify watch cost as suggested by Amir and Honza]
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  fs/notify/inotify/inotify_user.c | 24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
> index 186722ba3894..37d9f09c226f 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -37,6 +37,16 @@
>
>  #include <asm/ioctls.h>
>
> +/*
> + * An inotify watch requires allocating an inotify_inode_mark structure as
> + * well as pinning the watched inode and adding inotify fdinfo procfs file.

Maybe you misunderstood me.
There is no procfs file per watch.
There is a procfs file per inotify_init() fd.
The fdinfo of that procfile lists all the watches of that inotify instance.

> + * The increase in size of a filesystem inode versus a VFS inode varies
> + * depending on the filesystem. An extra 512 bytes is added as rough
> + * estimate of the additional filesystem inode cost.
> + */
> +#define INOTIFY_WATCH_COST     (sizeof(struct inotify_inode_mark) + \
> +                                2 * sizeof(struct inode) + 512)
> +

I would consider going with double the sizeof inode as rough approximation for
filesystem inode size.

It is a bit less arbitrary than 512 and it has some rationale behind it -
Some kernel config options will grow struct inode (debug, smp)
The same config options may also grow the filesystem part of the inode.

And this approximation can be pretty accurate at times.
For example, on Ubuntu 18.04 kernel 5.4.0:
inode_cache        608
nfs_inode_cache      1088
btrfs_inode            1168
xfs_inode              1024
ext4_inode_cache   1096


Thanks,
Amir.
