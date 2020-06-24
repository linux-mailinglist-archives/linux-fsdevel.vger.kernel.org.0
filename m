Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307AB20775C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 17:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404167AbgFXP0I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 11:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403831AbgFXP0H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:26:07 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C30C061573
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:26:07 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id j16so2418581ili.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2020 08:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P6vFYfQctY8kt5RgNmWbxdv59n9jFppCIc/LyroNeoQ=;
        b=Hb1gKYi0AcR68gaSWxox6Q/ZjSItcMD95pTIPTFR5p9vPLLqFd9pnz7Y/xzMy6hrMe
         2AsXO1yzKSxfYcnUDGIL6q6h/OS+cScbYY4eu566exQcjUYJ6MDZU9cFnoKoLtHCdJSV
         EToSShbjx0vzRkWBubmuF3RcV1Wc2dD3/5BfJetJarDVYbk3SZqP0Wvraznw/vtjIjZl
         hLG5IZmL3Gr7FlGlRKdg/hgLW+Dh85KsY9814GgxEyoFFwsjT6WfSy/ze4FI9cMJbW/+
         vw3aWnL96BgNLfXLzIVzbeidVr8j32MI09Wo9fE3XlEAa+ZUUr+Bbtymgd9cu4ILrKxY
         mq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P6vFYfQctY8kt5RgNmWbxdv59n9jFppCIc/LyroNeoQ=;
        b=UIWKsjn8+NXPwlDKgF605XjVgNXYBrbJzad/EYFJdGQnaTs76dDuXlLQA5YHdA4lHt
         aLbVG12j4DV05z31BPvXfYRVgqJiNzDvSc85wt1NQmwbY/BlXx5XOGoR0+aXcZi9n/1l
         RralM/oyBVWcRD4CJCtaw5dzBIw7rimpa5qSTcwf/3WSEspm8/IgKXY3WhgHp4vturPl
         WyeAkMiExH7A81LxWodH+booHtQl8hKoawB4i1RCtQic/pHjf43x0c0zyZAQmlxEXlUh
         ISTfrZU0LlC+j63EydsOBq3JCPt7erh7IX9+PZXNXEa/uBLaZEChrDTCa7ZfEg1rSngQ
         4Hbw==
X-Gm-Message-State: AOAM5311V+E8bNyJJ2Uu/SUH92Jk9uqI8gYVjbsShvJnv5srTQEf1kTv
        CNd7HpcE4o/sHUVCpjjBGcuzUyJ+YW5CQ1hPSKo=
X-Google-Smtp-Source: ABdhPJwip2rV4ltxOqRZgO9jeaDVbdM2V6oB5bCnd+9yOQNToGa9a89eNFogZc9XSDafM6jnAUYTtuoP6miQlDO+7mo=
X-Received: by 2002:a92:b6d4:: with SMTP id m81mr5691444ill.72.1593012366564;
 Wed, 24 Jun 2020 08:26:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
In-Reply-To: <20200624144846.jtpolkxiqmery3uy@wittgenstein>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Jun 2020 18:25:55 +0300
Message-ID: <CAOQ4uxhkiWKt2As5kMWt6PNrRwY8QbqXKiHkz_1UFb0Za+BEuw@mail.gmail.com>
Subject: Re: overlayfs regression
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 24, 2020 at 5:48 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Hey Miklosz,
> hey Amir,
>
> We've been observing regressions in our containers test-suite with
> commit:
>
> Author: Miklos Szeredi <mszeredi@redhat.com>
> Date:   Tue Mar 17 15:04:22 2020 +0100
>
>     ovl: separate detection of remote upper layer from stacked overlay
>
>     Following patch will allow remote as upper layer, but not overlay sta=
cked
>     on upper layer.  Separate the two concepts.
>
>     This patch is doesn't change behavior.
>
>     Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>

Are you sure this is the offending commit?
Look at it. It is really moving a bit of code around and should not
change logic.
There are several other commits in 5.7 that could have gone wrong...

> It suddenly consistently reports:
> [2422.695340] overlayfs: filesystem on '/home/lxcunpriv/.local/share/lxc/=
c2/overlay/delta' not supported as upperdir
> in dmesg where it used to work fine for basically 6 years when we added
> that test. The test creates a container c2 that uses the rootfs of
> another container c1 (normal directory on an ext4 filesystem). Here you
> can see the full mount options:
>
> Invalid argument - Failed to mount "/home/lxcunpriv/.local/share/lxc/c1/r=
ootfs" on "/usr/lib/x86_64-linux-gnu/lxc" with options "upperdir=3D/home/lx=
cunpriv/.local/share/lxc/c2/overlay/delta,lowerdir=3D/home/lxcunpriv/.local=
/share/lxc/c1/rootfs,workdir=3D/home/lxcunpriv/.local/share/lxc/c2/overlay/=
work"
>

/home/lxcunpriv/.local/share/lxc/c2/overlay/delta' is ext4?

and it fails the test because (path->dentry->d_flags & DCACHE_OP_REAL)?
It the only thing special about that path is that it is not in root mount n=
s?

That is strange...

Thanks,
Amir.
