Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A02B347A0E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhCXN5q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 09:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbhCXN5Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:57:25 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8B6C061763;
        Wed, 24 Mar 2021 06:57:25 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id e8so21584897iok.5;
        Wed, 24 Mar 2021 06:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xkbzeC14r4m6BOO8t3d1DzbvZcgtkmxrCkVMJuJbLRY=;
        b=WDcXAjJB+pBb4389YmEggP+GBuYHvD/vXXl5B9FEDHzzuBnL/ysHSJhnYbXWOiEXKT
         NacSI0PMhIUZhJy5WgJXh2QSqLlN13KQtoOnBA4Sv7WbxQPNhGHKsps5wgzpVvSuZ//o
         a5wyU9v20lOuO5L0Og+DJGgxqH7lwVEipy/dsOKUGrQzvyYEYAto7cJfLDZWho5kfF7X
         RWiFlFNFuWfETaBU1UWTAgP7iAhJZe2Y1oz6t2jcGme026MOkl7NEZ8q3feURdcReffS
         Rkts+js/uXWDLJ1LZGMT33H1fYPpMPwSsdMo2zZqTqOmXMKqb+9/TteKtQ9dYAZiOr0v
         /1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xkbzeC14r4m6BOO8t3d1DzbvZcgtkmxrCkVMJuJbLRY=;
        b=cJHeSOboZS9vxx6+5tIyCo3dmiHXfA3/H5RUjAIiL0VX/mQGYQZ5irYSnjTZywy+X6
         OQjAwzObjrbZo+gCxLm4J/5itY8T3MDqIE2dR2N4D/tFDFdTxoFibVrfC9QfaMh3+o/u
         H1UJHRYI8eQoDDpOLnsPUtJCf4BXRn/8vIuWbyVie12HaYYvciYlXiuDt2JkpsDBpjpB
         DRGfB60ZlcXYn0Qi6w1yvknrzFTJXqhANAsOpeVq2ChGrcqAjl0GpJWYaaOUUHpJqiwb
         ZMrGQ+CsZA0jWNyEl8RmEi4809pt8PWv3TVZYHRRqFZLJ+yzeCy6LUGZAoKJM/SScWtI
         KtXA==
X-Gm-Message-State: AOAM531L8fERkDiFf00H5uNN/MR8ANPud/KULHQ4+RrTOb3n9VPvQV4Q
        AwNMdm2+lohUAaxD/jAkFx/vnuD4g1nhcC4s5CrcOcMmBuQ=
X-Google-Smtp-Source: ABdhPJzv+QcQ/N77X0YdT4SO8+h5IY4kGavgIlCR80xGPn7+PQgtrdzVrEMvQBkGFbN2zcXkv4D45OAcjGI4Yd8Qr3w=
X-Received: by 2002:a02:605d:: with SMTP id d29mr2951084jaf.81.1616594244987;
 Wed, 24 Mar 2021 06:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210304112921.3996419-1-amir73il@gmail.com> <20210316155524.GD23532@quack2.suse.cz>
 <CAOQ4uxgCv42_xkKpRH-ApMOeFCWfQGGc11CKxUkHJq-Xf=HnYg@mail.gmail.com>
 <20210317114207.GB2541@quack2.suse.cz> <CAOQ4uxi7ZXJW3_6SN=vw_XJC+wy4eMTayN6X5yRy_HOV6323MA@mail.gmail.com>
 <20210317174532.cllfsiagoudoz42m@wittgenstein> <CAOQ4uxjCjapuAHbYuP8Q_k0XD59UmURbmkGC1qcPkPAgQbQ8DA@mail.gmail.com>
 <20210318143140.jxycfn3fpqntq34z@wittgenstein> <CAOQ4uxiRHwmxTKsLteH_sBW_dSPshVE8SohJYEmpszxaAwjEyg@mail.gmail.com>
 <20210319134043.c2wcpn4lbefrkhkg@wittgenstein> <CAOQ4uxhLYdWOUmpWP+c_JzVeGDbkJ5eUM+1-hhq7zFq23g5J1g@mail.gmail.com>
 <CAOQ4uxhetKeEZX=_iAcREjibaR0ZcOdeZyR8mFEoHM+WRsuVtg@mail.gmail.com> <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhfx012GtvXMfiaHSk1M7+gTqkz3LsT0i_cHLnZLMk8nw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Mar 2021 15:57:12 +0200
Message-ID: <CAOQ4uxhFU=H8db35JMhfR+A5qDkmohQ01AWH995xeBAKuuPhzA@mail.gmail.com>
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

> > Now tested FAN_MARK_FILESYSTEM watch on tmpfs mounted
> > inside userns and works fine, with two wrinkles I needed to iron:
> >
> > 1. FAN_REPORT_FID not supported on tmpfs because tmpfs has
> >     zero f_fsid (easy to fix)
> > 2. open_by_handle_at() is not userns aware (can relax for
> >     FS_USERNS_MOUNT fs)
> >
> > Pushed these two fixes to branch fanotify_userns.
>
> Pushed another fix to mnt refcount bug in WIP and another commit to
> add the last piece that could make fanotify usable for systemd-homed
> setup - a filesystem watch filtered by mnt_userns (not tested yet).
>

Now I used mount-idmapped (from xfstest) to test that last piece.
Found a minor bug and pushed a fix.

It is working as expected, that is filtering only the events generated via
the idmapped mount. However, because the listener I tested is capable in
the mapped userns and not in the sb userns, the listener cannot
open_ny_handle_at(), so the result is not as useful as one might hope.

I guess we will also need to make open_by_handle_at() idmapped aware
and use a variant of vfs_dentry_acceptable() that validates that the opened
path is legitimately accessible via the idmapped mount.

I think I will leave this complexity to you should you think the userns filtered
watch is something worth the effort.

Thanks,
Amir.
