Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C9A24DB5C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728528AbgHUQic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgHUQi3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:38:29 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC2AC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 09:38:29 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so1111058plr.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Aug 2020 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pantacor-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3W9iCgbZK9Cw1buvEJZPkNGO1pB0TJP+IziLsIrcWLQ=;
        b=qWa++oMpGxJ4Bw6on2ysodl/N7exZxt3WocQm4s4PTPWs8wtdP6wADlHcM4rh/koD2
         iHIMLb2lbzoz77N8Su8CIHUPExc+EmRKETVn4/Jao711qUL14VQjc+K5Q1yEHu8hMpat
         /W2Uj7GFSpuI4sFRIom8jhadNvf+HW98mUZ772RTaUme8mTmUIinYRKNOmGYHErAr8BC
         srfHs3E1s2DHCP+iDHNlyxQJFVn+ysFWZii7OrGjTCZGT+/iGGDTT35/3LzM7K3GXMBC
         YdvX+XHasW6jBdCgPYl0Yh5FvQpwFSjxdk3jQUZzsHaeZfnqPi3sWV1vFmbJ5DzSnz+k
         B6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3W9iCgbZK9Cw1buvEJZPkNGO1pB0TJP+IziLsIrcWLQ=;
        b=F9fhTaU7IOhSK8LhxIpVj0hc1Gl9Gx9GLWbGAPK/8PvhKYAJZwcG0oCS8hKklb/gMB
         vFtZHoQqsKb21kvCs1MS5NBk9/2cja+NkqmTk7uydpnuTh3D/GSJv2Usne3PkhlcCljd
         bk2DxLHFSubrDuO74zQAKkWYJYIAd1xkP38v+g0g9VWWZKD2bVKOJEg37Auc0Y3XSeAm
         WJQ2TGpmC/1es5XLWnq6xQ1ybtkUgY3vKUl8TTlg6kPDqp511knYr49CDIzesYgK6aqO
         RTqaoW5vY+E+BrnVqnYTIi71ROxSo6dwMPyO0sJMVNIZsFsEfzV5hkz+ZL7HnzGUW3uD
         KNCA==
X-Gm-Message-State: AOAM533cdfwG1N+VVpejxllksdL9AW4otLHwCeEOjCNGBsQuODEICxui
        t7NIYv1crEIXdgkPgbaRitp9lCwIe71/jn/s1HI3aW8obSLFPg==
X-Google-Smtp-Source: ABdhPJzxPHhy5wstykAk668oz2z0rXxsvRp9cZNcYsd0b6oEwQK0YiuuWTnuBT3qcCTpbLHQI09C+t6ItLQ6HUSmhZ4=
X-Received: by 2002:a17:90a:514a:: with SMTP id k10mr1746257pjm.81.1598027908631;
 Fri, 21 Aug 2020 09:38:28 -0700 (PDT)
MIME-Version: 1.0
References: <CABfyVHc=oQmZG9NuJgu1G92VQqsxkynE+S9DosQzh9r+9G1Jbg@mail.gmail.com>
In-Reply-To: <CABfyVHc=oQmZG9NuJgu1G92VQqsxkynE+S9DosQzh9r+9G1Jbg@mail.gmail.com>
From:   Pranay Srivastava <pranay.srivastava@pantacor.com>
Date:   Fri, 21 Aug 2020 22:08:17 +0530
Message-ID: <CABfyVHcmd0nymzr3M_zxxwbXfMXhJs4HDARy+eMZ+jfLGsy8tw@mail.gmail.com>
Subject: Re: mountinfo contents changed when rootfs is ramfs
To:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     dhowells@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 19, 2020 at 5:20 PM Pranay Srivastava
<pranay.srivastava@pantacor.com> wrote:
>
> Hello,
>
> I'm running a system where rootfs is ramfs. For kernel version 5.2.11
>
> # cat /proc/self/mountinfo
> 0 0 0:1 / / rw - rootfs rootfs rw
> %<---snip>%
>
> while for kernel 5.4.58
> # cat /proc/self/mountinfo
> 0 0 0:1 / / rw - rootfs none rw
> %<---snip>%
>
> The reason for the above difference is because for kernel 5.2.11 the
> parse_param for
> rootfs was set to legacy_parse_param which handled the "source" param
> instead of
> ignoring it.
>
> With kernel 5.4.58 this is set to ramfs_parse_param which ignores any
> parameters not
> recognized and also returns 0 instead of -ENOPARAM. This causes
> vfs_parse_fs_param
> to not set the file context  source(fc->source) which results in "none" from
> alloc_vfs_mount(fc->source ? : "none")
>
> The commit which introduced the above change was
>
> commit f32356261d44d580649a7abce1156d15d49cf20f
> Author: David Howells <dhowells@redhat.com>
> Date:   Mon Mar 25 16:38:31 2019 +0000
>
>     vfs: Convert ramfs, shmem, tmpfs, devtmpfs, rootfs to use the new mount API
>
> I'm not sure if this is a regression? But if it is, do we handle it like
>
> diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
> index ee179a81b3da..47a39baa0535 100644
> --- a/fs/ramfs/inode.c
> +++ b/fs/ramfs/inode.c
>
> @@ -200,7 +200,7 @@ static int ramfs_parse_param(struct fs_context
> *fc, struct fs_parameter *param)
>                  * and as it is used as a !CONFIG_SHMEM simple substitute
>                  * for tmpfs, better continue to ignore other mount options.
>                  */
> -               if (opt == -ENOPARAM)
> +               if (opt == -ENOPARAM && strcmp(param->key, "source"))
>                         opt = 0;
>                 return opt;
>         }
>
> so that mountinfo gives the same information as for earlier kernels.
>
> Thanks!
> --
> Regards,
> Pranay Srivastava

Kindly let me know if the above is a regression and needs to be fixed?

-- 
Regards,
Pranay Srivastava
