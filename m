Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8224359A5C1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 20:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350064AbiHSSvL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 14:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350229AbiHSSvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 14:51:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8D6D758B
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 11:51:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q184so5711943oif.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Aug 2022 11:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7wUgB1dRjU6/+eFjwFHTANQu+ic7Dy7EWy3+cTOIz0Y=;
        b=YA8lduBFsw7+V7kZTDB3G6gYa9HAlS3UjQdrISezZ02nmKmRjX8o+zRPyTx/PHiYBZ
         rX95UYX6pa787HSJFyX48N66z5sdS4xAuGadWGodDH9DtcoCZURHsEo/l//aN07ydqa8
         g+1wDe62RvoZ6Gwv+nSIfZquiGYctEGwl6VfR8d8ZKZSKy+qIQhOqh/QAXHuYHm9xtZA
         hwJEbVmrnbJhzna0LzhuX2bApaTmhDg6PmYQYpweixbKasPqO4mO64qdsXreZTA7ZHyL
         yvMBdpBTpssQ3iVv4QJGcm22hssFCi5sh3/N5rOi7ZtgEGsLC2RbPFdKo4HPCQDfa0D4
         LA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7wUgB1dRjU6/+eFjwFHTANQu+ic7Dy7EWy3+cTOIz0Y=;
        b=GfbcA+gY5PzPumdUbipGoZx1sz1miDZwwK+TPKaxidKOCizDLlgUbX3vYQ1i3Je2a5
         vLUB4CRKpGFpb8spHdNdV3FCH+tw+R1xwx9Rl5CRTfgFmiunv2n16/+j/cBJKXKgHdLR
         Z+Ou4BMELYaAs5FzfUWqHjZc4szNYRLYShFMAt09dir91V2V5RaRxAbwCy4BV9Y8ZhzX
         UTsInEfCWYkxVStGqpNP9Z/htdkw+iu6vFTYoOA0H1mbIq//t7JW6naYM0/ZY128kqu0
         l+N0yJuxjRvQkBo6GaftG3Qw0m0awEeQ4Rw+oBWOSl9OqxCvI6MhObwMuVXwWaSypjWb
         nKtg==
X-Gm-Message-State: ACgBeo2wCcdGlLkIO1Cikcos2HNYBLWH0t+Y0G2nF72TntLajKkefZbj
        L0ImRwZoveYiFm9aIuUqwgBPIYPeipS9r1bTs+4C
X-Google-Smtp-Source: AA6agR6AxsfZpdcBXlrKQIpyKWJZdaiNH1nuBz29aeBvGBp77p+jqo+BBEdP58dCAql7NNzw8Zch6kTiW0lJ65Yi4B8=
X-Received: by 2002:aca:b7d5:0:b0:343:c478:91c6 with SMTP id
 h204-20020acab7d5000000b00343c47891c6mr4062449oif.136.1660935068420; Fri, 19
 Aug 2022 11:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220708093451.472870-1-omosnace@redhat.com> <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
In-Reply-To: <CAHC9VhSFUJ6J4_wt1SKAoLourNGVkxu0Tbd9NPDbYqjjrs-qoQ@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 19 Aug 2022 14:50:57 -0400
Message-ID: <CAHC9VhRtLEg-xR5q33bVNOBi=54uJuix2QCZuCiKX2Qm6CaLzw@mail.gmail.com>
Subject: Re: [RFC PATCH RESEND] userfaultfd: open userfaultfds with O_RDONLY
To:     Ondrej Mosnacek <omosnace@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Lokesh Gidra <lokeshgidra@google.com>, linux-mm@kvack.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Robert O'Callahan" <roc@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 16, 2022 at 6:12 PM Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jul 8, 2022 at 5:35 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> >
> > Since userfaultfd doesn't implement a write operation, it is more
> > appropriate to open it read-only.
> >
> > When userfaultfds are opened read-write like it is now, and such fd is
> > passed from one process to another, SELinux will check both read and
> > write permissions for the target process, even though it can't actually
> > do any write operation on the fd later.
> >
> > Inspired by the following bug report, which has hit the SELinux scenario
> > described above:
> > https://bugzilla.redhat.com/show_bug.cgi?id=1974559
> >
> > Reported-by: Robert O'Callahan <roc@ocallahan.org>
> > Fixes: 86039bd3b4e6 ("userfaultfd: add new syscall to provide memory externalization")
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >
> > Resending as the last submission was ignored for over a year...
> >
> > https://lore.kernel.org/lkml/20210624152515.1844133-1-omosnace@redhat.com/T/
> >
> > I marked this as RFC, because I'm not sure if this has any unwanted side
> > effects. I only ran this patch through selinux-testsuite, which has a
> > simple userfaultfd subtest, and a reproducer from the Bugzilla report.
> >
> > Please tell me whether this makes sense and/or if it passes any
> > userfaultfd tests you guys might have.
> >
> >  fs/userfaultfd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> VFS folks, any objection to this patch?  It seems reasonable to me and
> I'd really prefer this to go in via the vfs tree, but I'm not above
> merging this via the lsm/next tree to get someone in vfs land to pay
> attention to this ...

Okay, final warning, if I don't see any objections to this when I make
my patch sweep next week I'm going to go ahead and merge this via the
LSM tree.

> > diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
> > index e943370107d0..8ccf00be63e1 100644
> > --- a/fs/userfaultfd.c
> > +++ b/fs/userfaultfd.c
> > @@ -989,7 +989,7 @@ static int resolve_userfault_fork(struct userfaultfd_ctx *new,
> >         int fd;
> >
> >         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, new,
> > -                       O_RDWR | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> > +                       O_RDONLY | (new->flags & UFFD_SHARED_FCNTL_FLAGS), inode);
> >         if (fd < 0)
> >                 return fd;
> >
> > @@ -2090,7 +2090,7 @@ SYSCALL_DEFINE1(userfaultfd, int, flags)
> >         mmgrab(ctx->mm);
> >
> >         fd = anon_inode_getfd_secure("[userfaultfd]", &userfaultfd_fops, ctx,
> > -                       O_RDWR | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> > +                       O_RDONLY | (flags & UFFD_SHARED_FCNTL_FLAGS), NULL);
> >         if (fd < 0) {
> >                 mmdrop(ctx->mm);
> >                 kmem_cache_free(userfaultfd_ctx_cachep, ctx);
> > --
> > 2.36.1
>
> --
> paul-moore.com



-- 
paul-moore.com
