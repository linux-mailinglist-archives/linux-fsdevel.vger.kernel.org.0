Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20F4F43DCE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Oct 2021 10:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbhJ1IZD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Oct 2021 04:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbhJ1IZC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Oct 2021 04:25:02 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE9FC061570
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 01:22:35 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id ba32so10029469uab.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Oct 2021 01:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFQUl5lQF75lAZY622NXTFhZE7M87GvtIA7Xxf4Z/3A=;
        b=PEi2o4TK81RcOdu3081y781tOgPnE+qlHNbhOxV4gZ72uIETbXfvk6EciIuOouGps7
         6RpeYscJAGLO1Am97lSLm/WKz2LNSpZ83zRZGkiNnXRZ2Z7FjrMzaWofR98Z8EXuFaQ2
         g/PCgh1y5bG/LlfZJOV21Kdbim5oYLsEu1wEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFQUl5lQF75lAZY622NXTFhZE7M87GvtIA7Xxf4Z/3A=;
        b=XyuCuyEFCd7zoQdvPl32JhQ+L3EvSr0U5aH4qNloYAMda4Y+UMVCZybf9pN/IftBy2
         iUw6ss9rsCn5uR/0w2S4sjLI9H9xHNb72n+dnM5+uJtD0s69Fb/OnLSz9oI85kOvOsvu
         zazRt53hlCfjk0fMlBopjyerkRpb2OUFFyFc3jEXTKWx7vHRh7NdLIGgr8YR5ZQoLL3S
         e0mlpYrEWhpHXKq+3Bbe+mbD4d+Xp94Oznq8QBcaYNVzDOYMClG2iXjqCuS3NITZ5oEe
         xNoL7+3v8YnUe/3Td+dEcahbH/fdkvD1Dw8M0W1FzXZUkd+3DgbXDWa0Elw2NLsIQv2G
         Uw9A==
X-Gm-Message-State: AOAM533SQuTObHch6vbF7agc6eUOBY6g6jzJEcY0YkZ1ggZbscdUu9sj
        0Hh2GjYTljewqKOE/FTRrBRRo3TM7RKVFI7W1/83XA==
X-Google-Smtp-Source: ABdhPJy7KU9YUyCn3gnaxPMYUm4BOZHDxPW3xzFGmpO+ApLSDI5qoQocrqUcKTVroOxOtiNl66vdNWZvk/uKt/lsqVI=
X-Received: by 2002:a9f:21b7:: with SMTP id 52mr2809084uac.9.1635409355005;
 Thu, 28 Oct 2021 01:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211024132607.1636952-1-amir73il@gmail.com> <YXVltvcDKNCqodJz@lpc>
 <CAOQ4uxjV2LXvu0kiLuDR_kvgHxLcwPCT1Y5NyD6aaMWrwg1EiQ@mail.gmail.com>
 <YXV4/u4iryv/sXFX@lpc> <CAOQ4uxjq-HBRQ8DFNTnRobtmAOi6kKs-1WTXeoik_x=_=QDa2g@mail.gmail.com>
In-Reply-To: <CAOQ4uxjq-HBRQ8DFNTnRobtmAOi6kKs-1WTXeoik_x=_=QDa2g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 28 Oct 2021 10:22:24 +0200
Message-ID: <CAJfpegumbz+v4CA7_+cSCKyj2ayhXyGru-oJ07pzKoMtfPbNOw@mail.gmail.com>
Subject: Re: [PATCH] fuse: add FOPEN_NOFLUSH
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Shachar Sharon <synarete@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 24 Oct 2021 at 17:30, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Sun, Oct 24, 2021 at 6:17 PM Shachar Sharon <synarete@gmail.com> wrote:
> >
> > On Sun, Oct 24, 2021 at 05:21:55PM +0300, Amir Goldstein wrote:
> > >On Sun, Oct 24, 2021 at 4:55 PM Shachar Sharon <synarete@gmail.com> wrote:
> > >>
> > >> On Sun, Oct 24, 2021 at 04:26:07PM +0300, Amir Goldstein wrote:
> > >> >Add flag returned by OPENDIR request to avoid flushing data cache
> > >> >on close.
> > >> >
> > >> I believe this holds not only for FUSE_OPENDIR but also to FUSE_OPEN and
> > >> FUSE_CREATE (see 'struct fuse_open_out').
> > >>
> > >
> > >Oops that was a copy&paste typo.
> > >Of course this is only relevant for FUSE_OPEN and FUSE_CREATE.

Fixed up.

> > >> > fs/fuse/file.c            | 3 +++
> > >> > include/uapi/linux/fuse.h | 3 +++
> > >> > 2 files changed, 6 insertions(+)
> > >> >
> > >> >diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > >> >index 11404f8c21c7..6f502a76f9ac 100644
> > >> >--- a/fs/fuse/file.c
> > >> >+++ b/fs/fuse/file.c
> > >> >@@ -483,6 +483,9 @@ static int fuse_flush(struct file *file, fl_owner_t id)
> > >> >       if (fuse_is_bad(inode))
> > >> >               return -EIO;
> > >> >
> > >> >+      if (ff->open_flags & FOPEN_NOFLUSH)

This needs to check for !fc->writeback_cache.  Fixed up.

Without this dirty pages could persist after the file is finally
closed, which is undesirable for several reasons.  One is that a
writably open file is no longer guaranteed to exist (needed for
filling fuse_write_in::fh).  Another is that writing out pages from
memory reclaim is deadlock prone.  So even if we could omit the fh
field we'd need to make sure that reclaim doesn't wait for fuse
writeback.  So while having dirty pages beyond last close(2) could be
really useful, it's not something we can currently do.

Note: while mainline currently does flush pages from ->release(),
that's wrong, and removed in fuse.git#for_next.

> > >> >--- a/include/uapi/linux/fuse.h
> > >> >+++ b/include/uapi/linux/fuse.h
> > >> >@@ -184,6 +184,7 @@
> > >> >  *
> > >> >  *  7.34
> > >> >  *  - add FUSE_SYNCFS
> > >> Most likely you want to bump to 7.35; 7.34 is already out in the wild
> > >> (e.g., on my Fedora33 workstation)
> > >>
> > >
> > >Possibly. I wasn't sure what was the rationale behind when the version
> > >should be bumped.
> > >One argument against bumping the version is that there is not much
> > >harm is passing this flag to an old kernel - it just ignored the flag
> > >and sends the flush requests anyway.
>
> Miklos, do I need to bump the protocol version?

We've historically done that.   But the last minor version that is
actually checked by the kernel or libfuse was 23 (the fuse_init_out
expansion), so nothing bad would happen if for some reason the bump
was forgotten.

I've fixed this up too and pushed out to #for-next.

Thanks,
Miklos
