Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA7FA3EB2A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Aug 2021 10:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbhHMIaH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Aug 2021 04:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238673AbhHMIaG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:30:06 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC31C061756;
        Fri, 13 Aug 2021 01:29:40 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id r72so12213715iod.6;
        Fri, 13 Aug 2021 01:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X2HpYlGIY7PCHonwpDYY+gio00UcnIrbODfp/COLs84=;
        b=AA6ACM1n3bPUh86vKPUO+IuD1hLSUmYq6y3KQc6V4M/vspM5qEA0RLlXkc3NtaJCTu
         iahDri+UxWqEva0wH8yx/60/cKwNC39kjoQPMjQID8mGbxyNO6HrKs9PHefApyKDfHeL
         lKWjx0HFretDwVe3C3MC+kCRTIMCYkDXMPzrD2Noe8NpquXZ3NaYqEqN9ozOofgYCaeX
         6jk0NTybPwR9SbVUAQzQwI1/jSyLn9xQ2L7N6CdTVc9pmHw/SILgWnCS+i9bB/DJr3Tt
         lpT5blL5Y7z/aSabgm57F5r+DuISI0Peq0R6d3kCbaOKIxBQpT53rEJu20Y5M1fkeTur
         H8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X2HpYlGIY7PCHonwpDYY+gio00UcnIrbODfp/COLs84=;
        b=cNwwEbvETQziGwIb4Yg9WMEUtzcMoci6FNxQEFl/DgtShZT0LvhB4cB6KgyAfDdthI
         dRyH4YHafMorJIzTiKONLqvVfBwVSHp+vx7ViZ2xTGonptWTJK9qlwtCDLpQI+ShrgIc
         bheQTsLJ2a/0hBuRWE1dkXhmZoxs2mUMkGucHeMb6Uz/P+Fye4gDohhXvyMQk6OkU1lp
         39/sAyaDnzKUGZt7B2ZJ5JsRq823kkyhQpLSRpx5/Nb/5Vudr+9cI2mcZdTbLg0ziWEX
         K7JmqwBC6/vh3dLH/A+JLJyz/XhyK9IKdXW3ZGG5ORUqwLSpREXEX90Cxi46cvLlItFT
         isvg==
X-Gm-Message-State: AOAM533Nqe76lgcx58J4F2uKuuFzowN7DBQtClJSd5i/fo3ujSLrEK5d
        K3TGbKja0t3jPutfYU/X/XWXKBm1LBkjzYn4mZk=
X-Google-Smtp-Source: ABdhPJxuNa8+pr0K/AfBa4uY6cbEmz8ocuR92JVvm8We5LRBvOrgjLv/auvQBBjfZ1nQaYzrGIH9VOLhtsBU/ihL/NY=
X-Received: by 2002:a02:958e:: with SMTP id b14mr1185696jai.123.1628843380077;
 Fri, 13 Aug 2021 01:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210812214010.3197279-1-krisman@collabora.com> <20210812214010.3197279-15-krisman@collabora.com>
In-Reply-To: <20210812214010.3197279-15-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 Aug 2021 11:29:29 +0300
Message-ID: <CAOQ4uxhP6ad+iJyWJqycLB1a9xZ6EHq7V67JqjoB=ORPf-_FYA@mail.gmail.com>
Subject: Re: [PATCH v6 14/21] fanotify: Reserve UAPI bits for FAN_FS_ERROR
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Jan Kara <jack@suse.com>, Linux API <linux-api@vger.kernel.org>,
        Ext4 <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        David Howells <dhowells@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Tso <tytso@mit.edu>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Bobrowski <repnop@google.com>, kernel@collabora.com,
        Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 13, 2021 at 12:41 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> FAN_FS_ERROR allows reporting of event type FS_ERROR to userspace, which
> a mechanism to report file system wide problems via fanotify.  This
> commit preallocate userspace visible bits to match the FS_ERROR event.
>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

> ---
>  fs/notify/fanotify/fanotify.c | 1 +
>  include/uapi/linux/fanotify.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 2b1ab031fbe5..ebb6c557cea1 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -760,6 +760,7 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
>         BUILD_BUG_ON(FAN_ONDIR != FS_ISDIR);
>         BUILD_BUG_ON(FAN_OPEN_EXEC != FS_OPEN_EXEC);
>         BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
> +       BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
>
>         BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 19);
>
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
> index fbf9c5c7dd59..16402037fc7a 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -20,6 +20,7 @@
>  #define FAN_OPEN_EXEC          0x00001000      /* File was opened for exec */
>
>  #define FAN_Q_OVERFLOW         0x00004000      /* Event queued overflowed */
> +#define FAN_FS_ERROR           0x00008000      /* Filesystem error */
>
>  #define FAN_OPEN_PERM          0x00010000      /* File open in perm check */
>  #define FAN_ACCESS_PERM                0x00020000      /* File accessed in perm check */
> --
> 2.32.0
>
