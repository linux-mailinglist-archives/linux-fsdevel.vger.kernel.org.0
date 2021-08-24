Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6980F3F5E7F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Aug 2021 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbhHXNBR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Aug 2021 09:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbhHXNBQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:01:16 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0E7C061757;
        Tue, 24 Aug 2021 06:00:32 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i8so40889714ybt.7;
        Tue, 24 Aug 2021 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MZFUpZltKxy0Oq1xKGH1YlOtguKs0D9HrZQ81WYExmI=;
        b=gPmUjmIygKAX3voYvS3urmtJQ9uA9KmbKFoVFcM/TkBAZStX/SIIcnqV1CfI/W2Mi1
         Pf3y/06uV+mGX92uqmvWaelzmU1H5dRb08hl7Ac5pC54frYIFSwKfa5Un1d2Q7DIcW9/
         LVmhGjGx8pyaVn26TVXp8EzmPGVZjqzvM4RiSV7XiDXow61LV3nc3vPLuYz6yVTdiU8n
         d2I1gv29eNPl95Pjy6oVkITBO8GLIukT/eagofVY5vvox4ijCkA1mjgDVskbJDJynH4A
         TIayRsxMcbz3T5NCf1gKl20xriy2hUJqXvgHi88lLjZD2EW7yEtcoJAMz36PeUJGNXdh
         5Fsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MZFUpZltKxy0Oq1xKGH1YlOtguKs0D9HrZQ81WYExmI=;
        b=VltRLbYJ8MuLJ44SUtEc2C+J5b7sgW9zucayM2gHqV4UkCifS2Dn57v3gCdTuzDyK8
         bpNL7TMeTGp6OEdo0voXTO6SqwyNFjqV35cNiijJXEteM8KliA7GhAeXKpc6K0DwwiYH
         5EBEtuhb8C+2aVkZMH0xDaU2VuQuimmtqUs94tdcW0h07BXWEDdX8rZa/GQLX3K0mc70
         RDfktCB66viSYcP4yQiTraqJCXW9XbV4zUWFgs+T6MSJoP1a07TggSqkhSFvgEpaW39Z
         NzcRAyYGCX9o2S38XYTuB0gK8uhhOClFfjzqHGdhIaX29kgl/1fW4GWg6qMTjvRSFUnn
         13gA==
X-Gm-Message-State: AOAM532MQcNViioAU/teFBxBfnEULsGnDQL6vrxcp4pgaTqp1f5fBUCx
        u0QGPqRF+YR1uMCVE2X6/pnOHBH973regfhGgzU=
X-Google-Smtp-Source: ABdhPJwdZh4d5X9RCx/zi5Sx2S1EBiRaRNnJstu1eHC5zpE4OfXjiHqzz1SXUWbZXX4cPxcy8Np82f2+EZavxIcFogY=
X-Received: by 2002:a25:3046:: with SMTP id w67mr53120456ybw.134.1629810031660;
 Tue, 24 Aug 2021 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210824111259.13077-1-lukas.bulwahn@gmail.com> <552bb9bedfb1c36ea6aa5f7bdd3ab162b81f73d9.camel@kernel.org>
In-Reply-To: <552bb9bedfb1c36ea6aa5f7bdd3ab162b81f73d9.camel@kernel.org>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 24 Aug 2021 15:00:32 +0200
Message-ID: <CAKXUXMz99n0ixBQaM2HJxpHQ9ywYJ-yUAa0+WAmjczGhe4JQRQ@mail.gmail.com>
Subject: Re: [PATCH] fs: clean up after mandatory file locking support removal
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 24, 2021 at 1:56 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On Tue, 2021-08-24 at 13:12 +0200, Lukas Bulwahn wrote:
> > Commit 3efee0567b4a ("fs: remove mandatory file locking support") removes
> > some operations in functions rw_verify_area() and remap_verify_area().
> >
> > As these functions are now simplified, do some syntactic clean-up as
> > follow-up to the removal as well, which was pointed out by compiler
> > warnings and static analysis.
> >
> > No functional change.
> >
> > Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> > ---
> > Jeff, please pick this clean-up patch on top of the commit above.
> >
> >  fs/read_write.c  | 10 +++-------
> >  fs/remap_range.c |  2 --
> >  2 files changed, 3 insertions(+), 9 deletions(-)
> >
> > diff --git a/fs/read_write.c b/fs/read_write.c
> > index ffe821b8588e..af057c57bdc6 100644
> > --- a/fs/read_write.c
> > +++ b/fs/read_write.c
> > @@ -365,12 +365,8 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
> >
> >  int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
> >  {
> > -     struct inode *inode;
> > -     int retval = -EINVAL;
> > -
> > -     inode = file_inode(file);
> >       if (unlikely((ssize_t) count < 0))
> > -             return retval;
> > +             return -EINVAL;
> >
> >       /*
> >        * ranged mandatory locking does not apply to streams - it makes sense
> > @@ -381,12 +377,12 @@ int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t
> >
> >               if (unlikely(pos < 0)) {
> >                       if (!unsigned_offsets(file))
> > -                             return retval;
> > +                             return -EINVAL;
> >                       if (count >= -pos) /* both values are in 0..LLONG_MAX */
> >                               return -EOVERFLOW;
> >               } else if (unlikely((loff_t) (pos + count) < 0)) {
> >                       if (!unsigned_offsets(file))
> > -                             return retval;
> > +                             return -EINVAL;
> >               }
> >       }
> >
> > diff --git a/fs/remap_range.c b/fs/remap_range.c
> > index ec6d26c526b3..6d4a9beaa097 100644
> > --- a/fs/remap_range.c
> > +++ b/fs/remap_range.c
> > @@ -99,8 +99,6 @@ static int generic_remap_checks(struct file *file_in, loff_t pos_in,
> >  static int remap_verify_area(struct file *file, loff_t pos, loff_t len,
> >                            bool write)
> >  {
> > -     struct inode *inode = file_inode(file);
> > -
> >       if (unlikely(pos < 0 || len < 0))
> >               return -EINVAL;
> >
>
> Thanks Lukas,
>
> I had already removed the second hunk, but I merged read_write.c part
> into my queue for v5.15. It should show up in linux-next soon.

Yeah, I guess the issue on the second hunk caused a compiler warning
(so more obvious) and was reported otherwise; the issue around the
first hunk is only discovered with a bit more involved static
analysis, done by clang-analyzer, coccinelle scripts and friends.

Lukas
