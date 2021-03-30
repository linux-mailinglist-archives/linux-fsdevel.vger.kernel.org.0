Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B3534E474
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Mar 2021 11:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhC3JcA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Mar 2021 05:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhC3Jbg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:31:36 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49463C061762;
        Tue, 30 Mar 2021 02:31:36 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id t6so13590303ilp.11;
        Tue, 30 Mar 2021 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sbjEdqRPNo0MVHsycUNVNJoZjnvNpFyms6hSu5MsUns=;
        b=cM3Qv0Ddh1QRwTvHvZKklAz9iiQNdUlbfpiHUNJKBjmDBQpgx6fsD+lQ4BZLY65jiA
         A1ZEmxcIoAaFo5/3bFIzizHCM2vxgHIGfXRjA/vqAdTvXI6wrULzDh66fiUL/lafEo5i
         ue1x1P7gMan4NiDFlclDnPj8+2VRrQG/YK8FLQ+1Y2494fhg0IKYOhtVjCED6q0dJG20
         L7+uXY7CUxw/zzeCcO4xrRwzuGVyBPQxfTXopPrvPP9o+b3DMG8UWoucVe6hZLxi+aq8
         Uw0ks8euguG4IzHTEswu68A6QOx3tRKe9kobZL+P3O8qSUP9+pNSgQ5Y18ZF9m+iMiti
         ayaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sbjEdqRPNo0MVHsycUNVNJoZjnvNpFyms6hSu5MsUns=;
        b=Xq+YiN2qbK5slRZXOjSCkfCRqZACHAHDWMB3oEwN1PsJ+z9deplOmAlh6uS5gTELgP
         RgqIVdEpoWwvCPpXHK52IlI+N//BSVymd3fUWeuq33pVe3y4/oceUMCcwY/N7Q2vfNII
         Jiowab9Hq53E4V0ewUflgA3YZqx4wPBEERxPLSQdmAHVvDkJ6aPTszFjRWJ/QAJ15ei6
         8DI5fnqH8y07r1S1/8jF9T31ZerHHlCXTeE8GaMzxu39DlpBP0rB8WaAp9GX8ZL2ovnf
         NjErSzau5ba50hFsvt8ut5y+ezGJwqGofOEO8J7HmoAsTOy6woto3WOATVu6N+5Tqzh6
         uU0Q==
X-Gm-Message-State: AOAM532lj3IdQWQ+Dund4KXg0eBO10m2v5gi4TZX6V3NqC2EZkU2dwXj
        xKFyrnvMGpENPXugSZLRj75aw1gIB+Cml9fMJRs=
X-Google-Smtp-Source: ABdhPJz9gynqfRsoqDqAeT5ZLmhN2SShSMooaCaMSw72uujAJxaimwgw1mgPVp5+fzx7uCiQI26HlolnXCgwwbbMjpg=
X-Received: by 2002:a92:b74e:: with SMTP id c14mr18639827ilm.275.1617096695708;
 Tue, 30 Mar 2021 02:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210328155624.930558-1-amir73il@gmail.com> <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
In-Reply-To: <20210330073101.5pqvw72fxvyp5kvf@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 30 Mar 2021 12:31:24 +0300
Message-ID: <CAOQ4uxjQFGdT0xH17pm-nSKE_0--z_AapRW70MNrLJLcCB6MAg@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: allow setting FAN_CREATE in mount mark mask
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 30, 2021 at 10:31 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Sun, Mar 28, 2021 at 06:56:24PM +0300, Amir Goldstein wrote:
> > Add a high level hook fsnotify_path_create() which is called from
> > syscall context where mount context is available, so that FAN_CREATE
> > event can be added to a mount mark mask.
> >
> > This high level hook is called in addition to fsnotify_create(),
> > fsnotify_mkdir() and fsnotify_link() hooks in vfs helpers where the mount
> > context is not available.
> >
> > In the context where fsnotify_path_create() will be called, a dentry flag
> > flag is set on the new dentry the suppress the FS_CREATE event in the vfs
> > level hooks.
> >
> > This functionality was requested by Christian Brauner to replace
> > recursive inotify watches for detecting when some path was created under
> > an idmapped mount without having to monitor FAN_CREATE events in the
> > entire filesystem.
> >
> > In combination with more changes to allow unprivileged fanotify listener
> > to watch an idmapped mount, this functionality would be usable also by
> > nested container managers.
> >
> > Link: https://lore.kernel.org/linux-fsdevel/20210318143140.jxycfn3fpqntq34z@wittgenstein/
> > Cc: Christian Brauner <christian.brauner@ubuntu.com>
> > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > ---
>
> Was about to look at this. Does this require preliminary patches since
> it doesn't apply to current master. If so, can you just give me a link
> to a branch so I can pull from that? :)
>

The patch is less useful on its own.
Better take the entire work for the demo which includes this patch:

[1] https://github.com/amir73il/linux/commits/fanotify_userns
[2] https://github.com/amir73il/inotify-tools/commits/fanotify_userns

Thanks,
Amir.
