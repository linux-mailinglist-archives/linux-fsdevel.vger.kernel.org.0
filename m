Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB0340A83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 17:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhCRQs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 12:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhCRQsX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 12:48:23 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AAC06174A;
        Thu, 18 Mar 2021 09:48:23 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n198so2978824iod.0;
        Thu, 18 Mar 2021 09:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wBrswB1dqJ2gf28YDWoGzxyae6lM42mJQXTUfrVVq7M=;
        b=BnPkpB//Vm7SnwUhxb0u+zDtGsI3HjyzUNufzoaORbWFd5A++AWa3OaXGElP8692cI
         eaAB1KuJUBDGB2CApmddhPj69U17HmBhjSzfrDU2mHSBpzW+Y9mp2vpbgrlOvzMzvHZY
         lAiz4iw3MZCoFyF5oFRBFoN05EdwDJwyNBlZ5fxmq7Vmj4dzWEYf+jmxuP2ctaHgRbVK
         PmdYpqgQaci0KDYD84ZWD2dF/2LEkRnQcv225aWOqlThlLQzkQHbI2HZUjKqe/UO0V9G
         z4DdJN1VD5zCeflqlWZJ78NmaMHyGBwUDG7mf7+4of24yhdaIGKNtUqP5FfHPsRzOJuP
         CEsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wBrswB1dqJ2gf28YDWoGzxyae6lM42mJQXTUfrVVq7M=;
        b=DYEcCulOhGQ8borZLqDMIK8DhI3yjYbGeiHoSS+vDmDhOZ3nHAyLiTwXHKny2D2384
         SXX5cN5OPD6V8xTAHcICwUzZqGQ7zQx2rZh3tcPOTEY8eHEseFQoP1Lz8TgSFR4spv4E
         uCuriYktCTXpk9RVWqEB0IlGaYk/qZAdV1/tR9Ym8B+FDduQiy/Go1TEhXJfAgpU1kg3
         uUYCRplhZZ6z0dqGYf/g0qp7DlW14ceYUIvfJOxeaRcJ1MIaMFGqRU0RlFFC/eAXl2jp
         IdUTGQUi/upiu7beOuVF9eBTrOssfhsMUFGIdf+tf+sXFbZ06Id7m4Z+CyO8S7Hdew7b
         M2oA==
X-Gm-Message-State: AOAM531eEm7VnHCJURVgxQcqTRiUK3IkUYDHWOKj0XT5JjBTAOQGxHdc
        ujfxMfZ2zzOnDNsTHQ9So3CCB6HS1/4VE+4Ky9IR/2+YMro=
X-Google-Smtp-Source: ABdhPJzvCRgwCn/muD7kpy6i/kS4vZpOOCFoHfLBsvWh03F+dyDu+puxx/DDM6VpYPUpVeNsEbr7nGCmNPL51aoJP7E=
X-Received: by 2002:a02:ccb2:: with SMTP id t18mr7738326jap.123.1616086103010;
 Thu, 18 Mar 2021 09:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein>
In-Reply-To: <20210318143140.jxycfn3fpqntq34z@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Mar 2021 18:48:11 +0200
Message-ID: <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
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

[...]

I understand the use case.

> I'd rather have something that allows me to mirror
>
> /home/jdoe
>
> recursively directly. But maybe I'm misunderstanding fanotify and it
> can't really help us but I thought that subtree watches might.
>

There are no subtree watches. They are still a holy grale for fanotify...
There are filesystem and mnt watches and the latter support far fewer
events (only events for operations that carry the path argument).

With filesystem watches, you can get events for all mkdirs and you can
figure out the created path, but you'd have to do all the filtering in
userspace.

What I am trying to create is "filtered" filesystem watches and the filter needs
to be efficient enough so the watcher will not incur too big of a penalty
on all the operations in the filesystem.

Thanks to your mnt_userns changes, implementing a filter to intercept
(say) mkdir calles on a specific mnt_userns should be quite simple, but
filtering by "path" (i.e. /home/jdoe/some/path) will still need to happen in
userspace.

This narrows the problem to the nested container manager that will only
need to filter events which happened via mounts under its control.

[...]

> > there shouldn't be a problem to setup userns filtered watches in order to
> > be notified on all the events that happen via those idmapped mounts
> > and filtering by "subtree" is not needed.
> > I am clearly far from understanding the big picture.
>
> I think I need to refamiliarize myself with what "subtree" watches do.
> Maybe I misunderstood what they do. I'll take a look.
>

You will not find them :-)

[...]

> > Currently, (upstream) only init_userns CAP_SYS_ADMIN can setup
> > fanotify watches.
> > In linux-next, unprivileged user can already setup inode watches
> > (i.e. like inotify).
>
> Just to clarify: you mean "unprivileged" as in non-root users in
> init_user_ns and therefore also users in non-init userns. That's what

Correct.

> inotify allows you. This would probably allows us to use fanotify
> instead of the hand-rolled recursive notify watching we currently do and
> that I linked to above.
>

The code that sits in linux-next can give you pretty much a drop-in
replacement of inotify and nothing more. See example code:
https://github.com/amir73il/inotify-tools/commits/fanotify_name_fid

> > If you think that is useful and you want to play with this feature I can
> > provide a WIP branch soon.
>
> I would like to first play with the support for unprivileged fanotify
> but sure, it does sound useful!

Just so you have an idea what I am talking about, this is a very early
POC branch:
https://github.com/amir73il/linux/commits/fanotify_userns

It will not be very useful to you yet I think.
Userns admin can watch all events on a tmpfs/fuse mounted
inside its userns.
Userns admin can watch open/read/write/close events on an
idmapped mount mapped to its userns.
But I think the more useful feature would be to watch all events on
an idmapped mount mapped to its userns.

Thanks,
Amir.
