Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661703A7ABD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jun 2021 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFOJhu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Jun 2021 05:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhFOJhi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Jun 2021 05:37:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DBDC0617AF
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 02:35:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id nd37so13723434ejc.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jun 2021 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/wUc2OfdjdbqnjL6W8FMiwr8yZ9/oxUaW69sqUYNuKM=;
        b=kNFfY93yyM1OSr4ACCCk1RSsFVhJXWC1MfeZ/3ASEmu5JYM6r+oD/0AT8FYuuOZp3e
         Z8qLnCYtJiNwPTuT0ipSTL6GWLVciFocanwPijZfqyIaD+yTIrGlutD0qmKWNsTosETJ
         ZXWxRR+HfQ9bd2jRuElwI9C5LQ8cDz/1J/fAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/wUc2OfdjdbqnjL6W8FMiwr8yZ9/oxUaW69sqUYNuKM=;
        b=oYfqdur3S/rc5UoB1+3Y9QA/W7+NrBoskMuws+edafCu6/UMjQOFJX6InhGeeV7iKI
         LXo4zkjYv3aqDqjdAAuJkiZ5xBFBkaKWvgXXAyy7ORQfxBuOaSH6qTKRKZ2Bu+3mmOHh
         Tcs1Dn0Pg9vuCkX4VtjiJCEbNXR5IMasq++iPkSkhkEsUrsJ17CnsOUGtDzPJPH0sCmW
         IDpHL0xg6berhPY9o676wV9goMdRoM67UcsnUqPtQaEgivCI/5YjKhXrM8/Ty/6L3A+I
         ji5N5Y+Rw56COIftg5aPdcrTy3AGwkInpJqQGO6A0/x6jpIcqdQMQqU1Bwz7huF7r64V
         O0GQ==
X-Gm-Message-State: AOAM533l8M7EYorbZYdd+ZYycczKSCWFWrey7i+o1Jrendy5/IkGuVA6
        wDDdr78/+JK2UP1NLUjeY8ySZchaKqdwZtOT8bNKsw==
X-Google-Smtp-Source: ABdhPJx7fh9LOmwCnFieYYThc9zENem+W4yQBvIwptCjcrQ/iz53nv9g6de5F6QmUpPuE4r+whaklEr/9RvGVhPC8Ao=
X-Received: by 2002:a17:907:20ee:: with SMTP id rh14mr19926420ejb.461.1623749732894;
 Tue, 15 Jun 2021 02:35:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200722090758.3221812-1-chirantan@chromium.org> <20210614212808.GD869400@redhat.com>
In-Reply-To: <20210614212808.GD869400@redhat.com>
From:   Chirantan Ekbote <chirantan@chromium.org>
Date:   Tue, 15 Jun 2021 18:35:21 +0900
Message-ID: <CAJFHJrpu9vewcD2er6oB_xwtF4Pc-njkRaA7rfJwsTvw5Fi2og@mail.gmail.com>
Subject: Re: [RESEND] [PATCHv4 1/2] uapi: fuse: Add FUSE_SECURITY_CTX
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        virtio-fs-list <virtio-fs@redhat.com>,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel <fuse-devel@lists.sourceforge.net>,
        SElinux list <selinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Vivek,

On Tue, Jun 15, 2021 at 6:28 AM Vivek Goyal <vgoyal@redhat.com> wrote:
>
> On Wed, Jul 22, 2020 at 06:07:57PM +0900, Chirantan Ekbote wrote:
> > Add the FUSE_SECURITY_CTX flag for the `flags` field of the
> > fuse_init_out struct.  When this flag is set the kernel will append the
> > security context for a newly created inode to the request (create,
> > mkdir, mknod, and symlink).  The server is responsible for ensuring that
> > the inode appears atomically with the requested security context.
> >
> > For example, if the server is backed by a "real" linux file system then
> > it can write the security context value to
> > /proc/thread-self/attr/fscreate before making the syscall to create the
> > inode.
> >
> > Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
>
> Hi Chirantan,
>
> I am wondering what's the status of this work now. Looks like it
> was not merged.
>
> We also need the capability to set selinux security xattrs on newly
> created files in virtiofs.
>
> Will you be interested in reviving this work and send patches again
> and copy the selinux as well as linux security module list
> (linux-security-module@vger.kernel.org) as suggested by casey.
>

Not really.  We have our own local solution for this (see below) so if
you or someone else wants to pick it up, please go ahead.

> How are you managing in the meantime. Carrying patches in your own
> kernel?
>

Kind of. This patch series changes the protocol and the feature bit we
were using was claimed by FUSE_SUBMOUNTS instead so carrying it
locally is not really viable long term.  Instead we're carrying a
patch similar to the original RFC patch that doesn't change the
protocol [1].

Chirantan

[1]: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2581172
