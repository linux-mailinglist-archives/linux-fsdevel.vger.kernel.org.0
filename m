Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843B634E764
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhC3MVT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 08:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231434AbhC3MUt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:20:49 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154F1C061574;
        Tue, 30 Mar 2021 05:20:49 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id z3so16162153ioc.8;
        Tue, 30 Mar 2021 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I7+hHuSfWzBSREBjQCyIh3OziZ+h51BaonfO3+V/nmQ=;
        b=ABy1ybAgu2qfPeaPa0+ULq7Hq87WYARER0OPvvhjf6We9O3TxS6tb+uHldLyq1O6An
         X4UuGwDI2HYC2yB8TIlwIVBvqZDmsvdlkdMgXVxSz14l9X/UCfES+kQgNKzBewqlL/hY
         1UxdzqIQFdt/sxtcO/fH0vmH7IXxYeiiCALTV5S0c0BCzrDLj04P9gUWmsZJ89srPeAW
         iclP5PPUOFb8UI/mIt7A8hjH8vE0Tj9vOp6tG/UvX/ef42JMYVqlsLLGlkpNX4TlRgCw
         fJjy8gxVNJTDKpLSnTi3g59eMy3Gypiz8ORz89MCDfJHy6jdye/OWMn8/Y9sKM0gYYEl
         LIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I7+hHuSfWzBSREBjQCyIh3OziZ+h51BaonfO3+V/nmQ=;
        b=JBhoBqQ5OF/ZknAqZTlV5ogzqAOt782a6yA6M6iLZFW7wd+0Ce9p3u1TlC/KNHQwTe
         4GWYbYK84uHZFmjC+kyXNrnOfQCXf3cxebG8fPOq9RnbsROAyuG3EeOORJ/G1EX9n1dK
         tiSUKuZl7hZtRlFbOUhCZivcVXoppXqA73Kp7KGXmyFzvkSW5YW9b6LSoGEoPOp7vxQ4
         w3L6zyBY3unebeBO+7eAgf+C5b5pkYYJlCfOAhEDicNrjCtUmEA/z7ffGEQqOnf43uLB
         H+FZ+a3raml8akEuRj/lhONQfVZckAuOgT7W34fjwaAA55e7foF/MML61856aYplV3/x
         y13w==
X-Gm-Message-State: AOAM533DVnP5c9MkHMI5Yy+/syjhkgKyOrRoA+abENy9gSWVwE6mOlw+
        SDQ1ll35NBdI1PniKISnuztQEfx3s6e8lcGADmpWTqQw
X-Google-Smtp-Source: ABdhPJxwlnGn1JV4Sy4Y1Wj/TGXD+t2ouqz5H8e5o9BKmSIhOOBEgFHntBBLgLrp9w1/Dr36RjkqwMixR5a7Ux4H/aQ=
X-Received: by 2002:a05:6638:218b:: with SMTP id s11mr7461559jaj.81.1617106848544;
 Tue, 30 Mar 2021 05:20:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com>
In-Reply-To: <20210328155624.930558-1-amir73il@gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 15:20:37 +0300
Message-ID: <CAOQ4uxiSqG24sTnNQzjPEtRoUQvRus0ahO_se=Oo9pTU3yfGRQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Mar 28, 2021 at 6:56 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> Add a high level hook fsnotify_path_create() which is called from
> syscall context where mount context is available, so that FAN_CREATE
> event can be added to a mount mark mask.
>
> This high level hook is called in addition to fsnotify_create(),
> fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> context is not available.
>
> In the context where fsnotify_path_create() will be called, a dentry flag
> flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> level hooks.
>
> This functionality was requested by Christian Brauner to replace
> recursive inotify watches for detecting when some path was created under
> an idmapped mount without having to monitor FAN_CREATE events in the
> entire filesystem.
>
> In combination with more changes to allow unprivileged fanotify listener
> to watch an idmapped mount, this functionality would be usable also by
> nested container managers.
>
> Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Jan,
>
> After trying several different approaches, I finally realized that
> making FAN_CREATE available for mount marks is not that hard and it could
> be very useful IMO.
>
> Adding support for other "inode events" with mount mark, such as
> FAN_ATTRIB, FAN_DELETE, FAN_MOVE may also be possible, but adding support
> for FAN_CREATE was really easy due to the fact that all call sites are
> already surrounded by filename_creat()/done_path_create() calls.
>

FWIW, adding support for FAN_DELETE and FAN_MOVE_SELF was not
so hard. The move event at least will also be needed for the use case
where watching when a negative path is instantiated.

https://github.com/amir73il/linux/commits/fsnotify_path_hooks

Thanks,
Amir.
