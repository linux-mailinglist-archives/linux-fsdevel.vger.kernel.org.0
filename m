Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B06A134BCB8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Mar 2021 16:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhC1O6Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Mar 2021 10:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhC1O6V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Mar 2021 10:58:21 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C10C061756;
        Sun, 28 Mar 2021 07:58:21 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k25so10219034iob.6;
        Sun, 28 Mar 2021 07:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/eYAix15FgjxUSXJCP4qXmQFhnSMzpr5Egrrumal1u8=;
        b=Y8KM+cjVd84KZATQrDTkyTJPx6mLM7c3K9+phsFU3TaozxwS8gMI0MRM1M9zCCXwtx
         rki+3X4L9qt6W3KqzDj24fmaqR9TBp9LUomKTLKLOR151OchjgKEVNuuQf39EFMYW9mT
         A3cijqfrOF5lz0uAPxkDrJVu+KeBne9AZ0cwa/6bDQ1KlrsvL6o48VQ61zz2N8uutD9P
         Ycydsa/Yr2IAqcVGEZlS94wq4kf9FY0dLHFuixjI0UTq8FNgdZdPn8/J+37eRARLoZ2Y
         89xuaFAgBsJbjlKpZ6vcpC9QO65/3zOZJjequ7ksxdp5qZ/JEWHmjtIizMi6jz7pk3tF
         pnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/eYAix15FgjxUSXJCP4qXmQFhnSMzpr5Egrrumal1u8=;
        b=rXgUgmtW8KjMDMMhEljoXsM1LAwRscJ99k3g9eAAZmwafZRGoYklqSvopQ6gO1Ur5n
         p6PHpAyQKCBQYVF141Ktt/WkTYMpurxQpXfD0+WbDoYcL/e8ym6yoTKOGSjcZGjUiiAO
         Eg6YxWmAXWK45y0EBNgQLW92hSUAPMrGcyryIaGauKalvn/U4Dbmu9YcD7Y/nExf3IZ4
         agCFQtE054WEGN3qkdPN8n1IVlbEycbHikbCvx9iVxAxRUL9sLSAd0rp2kLja9vtKbam
         SUXhu1yX4PPYBU80XHFrpmWBY+JQi8FmWlzEkDWeExFO2SBO4gT65lk3udHJ/62scAke
         T7KA==
X-Gm-Message-State: AOAM533m1sqAzeceGs253IFi6MmjeNcw79FV6F1itC0RCqk3ewCzUNXf
        lhkb20nQPbBynoFV+tSxcH3dX5w9z09Rd6yEUqIodYz0cyI=
X-Google-Smtp-Source: ABdhPJzownYsFpeh9ldQnfS9yNG5OF2XNqqVF0IX+rwqYANkfuq3ROPpQspx2ebPBviNUCVfOgWIcCZRoPiWo95Uzvo=
X-Received: by 2002:a02:ccb2:: with SMTP id t18mr19953035jap.123.1616943500906;
 Sun, 28 Mar 2021 07:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com>
 <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
 <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
 <20210324143230.y36hga35xvpdb3ct@wittgenstein> <CAOQ4uxiPYbEk1N_7nxXMP7kz+KMnyH+0GqpJS36FR+-v9sHrcg@mail.gmail.com>
 <20210324162838.spy7qotef3kxm3l4@wittgenstein> <CAOQ4uxjcCEtuqyawNo7kCkb3213=vrstMupZt-KnGyanqKv=9Q@mail.gmail.com>
 <20210325111203.5o6ovkqgigxc3ihk@wittgenstein> <CAOQ4uxhdJWWRZSa0FfEiryQoBJYcGSADGoE7UZF8W=5-tcX9xg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhdJWWRZSa0FfEiryQoBJYcGSADGoE7UZF8W=5-tcX9xg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 28 Mar 2021 17:58:09 +0300
Message-ID: <CAOQ4uxje-zV2nWGa9juWUBzW29dgZBTnJR=jWGxjAJ4haiYTog@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] unprivileged fanotify listener
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > The limitations of FAN_MARK_MOUNT as I now understand them are indeed
> > unpleasant. If we could get FAN_MARK_MOUNT with the same event support
> > as FAN_MARK_INODE that would be great.
> > I think the delegation model that makes sense to me is to allow
> > FAN_MARK_MOUNT when the caller is ns_capable(mnt->mnt_userns) and of
> > course ns_capable() in the userns they called fanotify_init() in. That
> > feels ok and supportable.
>
> I present to you a demo [1][2] of FAN_MARK_MOUNT on idmapped mount that:
>
> 1. Can subscribe and receive FAN_LINK (new) events
> 2. Is capable of open_by_handle() if fid is under mount root
>
> FAN_LINK (temp name) is an event that I wanted to add anyway [3] and
> AFAIK it's the only event that you really need in order to detect when a dir
> was created for the use case of injecting a bind mount into a container.

Scratch that part about the new event.
I found a way to make FAN_CREATE available for FAN_MARK_MOUNT.
Will post an RFC patch.
Same demo instructions. Different branches [1][2]:

>
> The kernel branch [1] intentionally excludes the controversial patch that
> added support for userns filtered sb marks.
>
> Therefore, trying to run the demo script as is on an idmapped mount
> inside userns will auto-detect UID 0, try to setup an sb mark and fail.
>
> Instead, the demo script should be run as follows to combine a
> mount mark and recursive inode marks:
>
> ./test_demo.sh <idmapped-mount-path> 1
>
> For example:

~# ./test_demo.sh /vdf 1
+ WD=/vdf
+ ID=1
...
+ inotifywatch --fanotify --recursive -w --timeout -2 /vdf
Establishing watches...
...
+ mkdir -p a/dir0 a/dir1 a/dir2/A/B/C/
+ touch a/dir2/A/B/C/file2
...
[fid=94847cf7.d74a50ab.30000c2;name='dir2'] /mnt/a/dir2
Adding recursive watches on directory '/mnt/a/dir2/'...
[fid=94847cf7.d74a50ab.87;name='A'] /mnt/a/dir2/A
Adding recursive watches on directory '/mnt/a/dir2/A/'...
[fid=94847cf7.d74a50ab.1000087;name='B'] /mnt/a/dir2/A/B
Adding recursive watches on directory '/mnt/a/dir2/A/B/'...
[fid=94847cf7.d74a50ab.20073e5;name='C'] /mnt/a/dir2/A/B/C
Adding recursive watches on directory '/mnt/a/dir2/A/B/C/'...
[fid=94847cf7.d74a50ab.30000c9;name='file2'] /mnt/a/dir2/A/B/C/file2

Hope that helps.

Thanks,
Amir.

[1] https://github.com/amir73il/linux/commits/fanotify_userns
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns
