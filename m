Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61D21D0A18
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 May 2020 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbgEMHrU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 May 2020 03:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgEMHrU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 May 2020 03:47:20 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8089C061A0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 00:47:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e2so13370583eje.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2020 00:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58MRQgGtg4UI/y39u/ikVTNbuwCtmXvZ5FzVZJ0DfhE=;
        b=FBKN5G4Bx6Mz6YsXw9DPZc01uXoq94b06DU0OArrdeaad4EvKr/HNsE1iw121CUnts
         ndLorOnkzWXKZT3ByHavqvYLE39E3wVOOhGbMZKU2oBpfkeXT0nntVfx1fNZq5MQ19wt
         Lx2qsNBwb9pxOdCvkGGYZOhixvqXzkBXjnEzc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58MRQgGtg4UI/y39u/ikVTNbuwCtmXvZ5FzVZJ0DfhE=;
        b=XtuyDKKwkD3G2j7KPTlVhWVMeM6vMuaFuKnty5N1gFMCKXvidXwaW1hWGZW4DTqfXI
         KC08zG5z4fTauR6ixc6FVgwtMCrcwkXqS9Ob/lyPH9Z83aIkso81jl82ouXPLSbM7aG3
         tCiQmqSJ8SCel4jW/NbWB/fh8W8MyfpebutwVKjuhYldERTHIcdeSCplegNJ7HI47b3r
         ja0PqW/tLG0dqGuQ3QWx+MuM43LR1gf7Z/3NzmHjnY4/3FmoKY7lzU5D/jRE/rPnBnHr
         ygbkD5b8uDT7aHqJb/zJJIAJCfeROM3QKtrhv37nuz5IbkXMhuklDkWeU58t79ZiulUt
         J6DQ==
X-Gm-Message-State: AGi0Pub5MymNI2/pArmpu3My4J4GC7cQ2trd00SI3MYNt0MTAIWJlx8E
        T2KDOHvxmloDWDkSULAaB4ovwxP+pyBQSSNzowN9L+h3h2g=
X-Google-Smtp-Source: APiQypKsSurPRYHAz6+dR+2TlpWHOMq0JiLEZKG1Go90NXlIH0suCI5L17Qo1+NqUElYiw8GHKahAdv482XsommWanI=
X-Received: by 2002:a17:906:41a:: with SMTP id d26mr12845768eja.217.1589356038457;
 Wed, 13 May 2020 00:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200505095915.11275-1-mszeredi@redhat.com>
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 13 May 2020 09:47:07 +0200
Message-ID: <CAJfpegtNQ8mYRBdRVLgmY8eVwFFdtvOEzWERegtXbLi9T2Ytqw@mail.gmail.com>
Subject: Re: [PATCH 00/12] vfs patch queue
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 5, 2020 at 11:59 AM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Hi Al,
>
> Can you please apply the following patches?

Ping?  Could you please have a look at these patches?

- /proc/mounts cursor is almost half the total lines changed, and that
one was already pretty damn well reviewed by you

- unprivileged whiteout one was approved by the security guys

- aio fsync one is a real bug, please comment on whether the patch is
acceptable or should I work around it in fuse

- STATX_MNT_ID extension is a no brainer, the other one may or may not
be useful, that's arguable...

- the others are not important, but I think useful

- and I missed one (faccess2); amending to patch series

Thanks,
Miklos



>
> All of these have been through the review process, some have been through
> several revisions, some haven't gotten any comments yet.
>
> Git tree is here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git for-viro
>
> Thanks,
> Miklos
>
> Miklos Szeredi (12):
>   vfs: allow unprivileged whiteout creation
>   aio: fix async fsync creds
>   proc/mounts: add cursor
>   utimensat: AT_EMPTY_PATH support
>   f*xattr: allow O_PATH descriptors
>   uapi: deprecate STATX_ALL
>   statx: don't clear STATX_ATIME on SB_RDONLY
>   statx: add mount ID
>   statx: add mount_root
>   vfs: don't parse forbidden flags
>   vfs: don't parse "posixacl" option
>   vfs: don't parse "silent" option
>
>  fs/aio.c                        |  8 +++
>  fs/char_dev.c                   |  3 ++
>  fs/fs_context.c                 | 30 -----------
>  fs/mount.h                      | 12 +++--
>  fs/namei.c                      | 17 ++----
>  fs/namespace.c                  | 91 +++++++++++++++++++++++++++------
>  fs/proc_namespace.c             |  4 +-
>  fs/stat.c                       | 11 +++-
>  fs/utimes.c                     |  6 ++-
>  fs/xattr.c                      |  8 +--
>  include/linux/device_cgroup.h   |  3 ++
>  include/linux/mount.h           |  4 +-
>  include/linux/stat.h            |  1 +
>  include/uapi/linux/stat.h       | 18 ++++++-
>  samples/vfs/test-statx.c        |  2 +-
>  tools/include/uapi/linux/stat.h | 11 +++-
>  16 files changed, 153 insertions(+), 76 deletions(-)
>
> --
> 2.21.1
>
