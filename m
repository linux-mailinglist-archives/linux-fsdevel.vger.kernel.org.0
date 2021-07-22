Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35E03D1FB7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 10:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhGVHev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 03:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhGVHev (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 03:34:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62556C061575;
        Thu, 22 Jul 2021 01:15:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id n1so4918753wri.10;
        Thu, 22 Jul 2021 01:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CB1DhhoIrWZ2u4W7LFw9hU1lA3h0TX8k9+TK23TIXls=;
        b=NKSGar6024S8fjlqKdxqo7uetI0k/el2vdVuKUbYIqQkIx7epBvdv69wqTtivfh3cc
         +k4CgoFsQ3AZts6oEcz6oYbdWprwsyXShzxtDfZNO/+7TJuRcV1bXIvo+AD1/zO0xm35
         x/8I2+GAxigfX1hM6XTSyZj3+WAofCP+9K1pXTbQ36qOmEr4KOwI2+Cb64N/51h+DNgn
         EeLETWVsffqljiFuNQKR5korTSWclghsbdhCoc8g742RSxCvbSVfkCtnXXuMh0fwMmdb
         JHZoa/noWDC2iC5XD2WwTOz/CnvxNvxFMazLk9T294q/eSxWr+G0cmzVBCtFPfIzGXiK
         nRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CB1DhhoIrWZ2u4W7LFw9hU1lA3h0TX8k9+TK23TIXls=;
        b=t6RbFDddLg7uV7okjccLJ+Q9tVmqyN3BIDMdMV+600xJl83zeRnRYWUZrTQhA9lSgV
         v2Jmq2gYTpF0452VMDOwUz2301tTjO1SC0FHObPh4f1zvLJBJQ32gZh6kPJbiHmIqYVf
         q52lvbh+EsMl3DjP8VCDSYtrnGj2fZQ51JSG3Ph7CKVSqkRq9GJAfm0fMpwnNVAibaDm
         oCCysIHsBaA7lvwoFeCTA9VhU0y22v6qmSWTkYHgqmL7bmJkTOWWGUqcwFHH8u+reyI0
         9Vok0H1QLcFVpgh/0Dbp9XZdMqK+Qd85IBD6wXSerXtB5cV+HWh3URDw+qd2u5j6ePON
         Tejw==
X-Gm-Message-State: AOAM530mtWYIIE8AnQHhEhV1ehCxGvTL33V2GTZody/Rhv1KtVbLZ5T4
        MrYunsizXACsY4zmqg7R+4z3m0FyAzYeirYRV11XcbIsBbg=
X-Google-Smtp-Source: ABdhPJyFh4EkKq2jcgqpXacFax1D4snzJyjJDqXuDSQpcR3EzS/pP2Yv2bHfRjXl6gTFPkjEOSvauSeYcCHHSWqhXWQ=
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr47833962wra.291.1626941724710;
 Thu, 22 Jul 2021 01:15:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210710143959.58077-1-wangshilong1991@gmail.com>
In-Reply-To: <20210710143959.58077-1-wangshilong1991@gmail.com>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Thu, 22 Jul 2021 16:15:13 +0800
Message-ID: <CAP9B-QnTvphddfafS310RD41Jc_tNM1Wvm34eWhZVe6VT5g3Kw@mail.gmail.com>
Subject: Re: [PATCH v4] fs: forbid invalid project ID
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Anyone take this patch to the tree? maybe Al Viro?

On Sat, Jul 10, 2021 at 10:40 PM Wang Shilong <wangshilong1991@gmail.com> wrote:
>
> From: Wang Shilong <wshilong@ddn.com>
>
> fileattr_set_prepare() should check if project ID
> is valid, otherwise dqget() will return NULL for
> such project ID quota.
>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> ---
> v3->v3:
> only check project Id if caller is allowed
> to change and being changed.
>
> v2->v3: move check before @fsx_projid is accessed
> and use make_kprojid() helper.
>
> v1->v2: try to fix in the VFS
>  fs/ioctl.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..d4fabb5421cd 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -817,6 +817,14 @@ static int fileattr_set_prepare(struct inode *inode,
>                 if ((old_ma->fsx_xflags ^ fa->fsx_xflags) &
>                                 FS_XFLAG_PROJINHERIT)
>                         return -EINVAL;
> +       } else {
> +               /*
> +                * Caller is allowed to change the project ID. If it is being
> +                * changed, make sure that the new value is valid.
> +                */
> +               if (old_ma->fsx_projid != fa->fsx_projid &&
> +                   !projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> +                       return -EINVAL;
>         }
>
>         /* Check extent size hints. */
> --
> 2.27.0
>
