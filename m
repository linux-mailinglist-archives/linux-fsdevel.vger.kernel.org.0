Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0C3611E0D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 10:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbfLMJdg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 04:33:36 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39856 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLMJdg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 04:33:36 -0500
Received: by mail-il1-f196.google.com with SMTP id n1so1533166ilm.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 01:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKwPmAEnoo7ceOKcimyUtM1fEq6aSPFGrEZp99ZAMNc=;
        b=Av9Qcfa203vxJVZMAOroGZwQqWopbwZzmAEIECN99fuboTWQ2d4mIQ1YYmttZXXf/M
         +aL6wcyUzlp3jHQObWauaaJmK2xR+DDDkLEZEAGFrrd+pp8Tn10Xa0uncb5Xoqe/NpPJ
         h/YUu9zAdIqAujUQ7U+YhF3h3KYBMVJO2RkMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKwPmAEnoo7ceOKcimyUtM1fEq6aSPFGrEZp99ZAMNc=;
        b=dWY7I/kE1q8Z8LZtCKfqWIZpPs+wcOwCQzBCljXZBxpR76sBUWuWvOIS3YkVu6O7PZ
         jQDwluwomydr6EodJNFjiRkaKORYi2SunthDeAYuc5eajfwVKbqvaPDuKbRZUPxJqKLn
         SdtLCMZMpkPGnVv4o6ilUP7/D/t3G52/193YJG+54RHH/yO4atWUB4hB5PUGOohl7/gT
         6knSLnWsdm/0TEjUxHntmGgOhB17ld3xegsH3J3iYoaIpvKEgyKda247Fs0A0dJrvXzq
         jtf+QcUextL7ErIZeTZ8cmx8dzBU2j44bwjwyCatfIkUaj2B/RDJQDDLiFeeNF2EAaM5
         jocg==
X-Gm-Message-State: APjAAAV9+iROnTWuzQaGsn5HJMfmss2ZLS4Y6gbj/AVNWvtgHY8Dw+3x
        4eufGiGozmIUb/vWMWK/S87urljKbvsWpsynXJNcwg==
X-Google-Smtp-Source: APXvYqzvqX96U6h3JX6SIdquB4Fv65kxJu6AYqKfuw0agBc2Ijd2vJHtdD6rz9zRU+NGOB6OutCxqVwr2W2/d8DAD2s=
X-Received: by 2002:a92:507:: with SMTP id q7mr11489383ile.63.1576229615847;
 Fri, 13 Dec 2019 01:33:35 -0800 (PST)
MIME-Version: 1.0
References: <20191128155940.17530-1-mszeredi@redhat.com>
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 13 Dec 2019 10:33:25 +0100
Message-ID: <CAJfpegt9iotxfRH68=8xiWkbyT1E9ZJh1W2hZ8VshNJ83=H82A@mail.gmail.com>
Subject: Re: [PATCH 00/12] various vfs patches
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al,

Could you please review/apply these patches?

Thanks,
Miklos

On Thu, Nov 28, 2019 at 4:59 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Hi Al,
>
> This is a dump of my current vfs patch queue, all have been posted in one
> form or another.
>
> Also available as a git branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git#for-viro
>
> Please apply.
>
> Thanks,
> Miklos
> ---
>
> Miklos Szeredi (12):
>   aio: fix async fsync creds
>   fs_parse: fix fs_param_v_optional handling
>   vfs: verify param type in vfs_parse_sb_flag()
>   uapi: deprecate STATX_ALL
>   statx: don't clear STATX_ATIME on SB_RDONLY
>   utimensat: AT_EMPTY_PATH support
>   f*xattr: allow O_PATH descriptors
>   vfs: allow unprivileged whiteout creation
>   fs_parser: "string" with missing value is a "flag"
>   vfs: don't parse forbidden flags
>   vfs: don't parse "posixacl" option
>   vfs: don't parse "silent" option
>
>  fs/aio.c                        |  8 ++++
>  fs/char_dev.c                   |  3 ++
>  fs/fs_context.c                 | 72 ++++++++++++---------------------
>  fs/fs_parser.c                  | 19 ++++-----
>  fs/namei.c                      | 17 ++------
>  fs/stat.c                       |  4 +-
>  fs/utimes.c                     |  6 ++-
>  fs/xattr.c                      |  8 ++--
>  include/linux/device_cgroup.h   |  3 ++
>  include/linux/fs_parser.h       |  1 -
>  include/uapi/linux/stat.h       | 11 ++++-
>  samples/vfs/test-statx.c        |  2 +-
>  tools/include/uapi/linux/stat.h | 11 ++++-
>  13 files changed, 82 insertions(+), 83 deletions(-)
>
> --
> 2.21.0
>
