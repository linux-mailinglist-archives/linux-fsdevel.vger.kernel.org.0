Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC195454A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jun 2022 21:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232358AbiFITKm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jun 2022 15:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiFITKl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:10:41 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1012C7E55
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jun 2022 12:10:41 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id p69so4348838iod.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jun 2022 12:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=d6Y/MDcLFVbY7Nqz4btNoj815x/n/vuizLUGANlo0+s=;
        b=oiM6z/iPZyNDM7fSpmYYSAAHDig3De4l6eEkiUADNJBgWX7hOiktfBT/L+Hy8ziQOp
         UFQ0x74Mdw7UQBXW2qPEsvMPEfyx9k5QXbjj+eYx3FrkChKftmWSOmtUqKpzNWOc/Zpr
         FcR21nH+XecgZKGidoKnr/Ruo+YvPAzcDoCOGjhwu8iR8pdI/PuYmTLfDFLw0voF2DXh
         fzYE9AZ4qVCEsB2yxc9kU3M1IXt8E2hYz84ngcH5uXFE42wKlIV/DrdXwDn6qAPd8BO8
         tcw0eWWeAFSVFVWYqgcPqPPkl1nkYcTgQSjuRf11VEX1T6VO23vMQx1KzhhfgCTQmgJ3
         86cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=d6Y/MDcLFVbY7Nqz4btNoj815x/n/vuizLUGANlo0+s=;
        b=H2HAGdpmulzgboG0qn3qnC0+QvN3RQ6XmzhT4thUiS1Hgbno8QDbMKyvC/hTHaDyff
         bjAEKmuW5AIoXSLWTRokeiSVJ+obtUeHJKLbKBJCv4HQbJJXmnxDsbi73jVDi4BZh83j
         0o8CyD7byib9QWv9Pm4ROupDMsmzAkLTgGtXDkP/W1N7I44RAWpczmNob4sIOtUBl6lu
         nm+/rbbxrrH1llD78IVnkOnMKOQv28swZL4YYvZPJRdBYV+eNicwrXf/ICGNKVQp+Ilg
         PwT0DHw+rDjF4A6HP2rFi0ZQruLY6pzuD1J7bb3V8X/QZG9ZbZbB1lYI4jsIDGbnWyxp
         TysA==
X-Gm-Message-State: AOAM533ouighP4rPy8ZlJ9jF/rFKbbXj0JiKsEHQydxwgy5qgNXo2vgL
        oOOJFboElkDrjbkQo7MfyLJl/AnxhFOUDkwDQSI=
X-Google-Smtp-Source: ABdhPJwbt2t2DshQCrvx9bSV1rtVic4SEevBngvZILZ4xZ8FA7/JpzLCy3Nd480R1N5fItDI36SYzJdWuxbb//lP8Cs=
X-Received: by 2002:a05:6602:168d:b0:669:8613:abd0 with SMTP id
 s13-20020a056602168d00b006698613abd0mr5987244iow.48.1654801840612; Thu, 09
 Jun 2022 12:10:40 -0700 (PDT)
MIME-Version: 1.0
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk> <CA+icZUV_kJcwtFK2aACAfKAkx6EdW62u46Qa7kkPXtRhMYCcsw@mail.gmail.com>
 <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
In-Reply-To: <YqEJEWWfxbNA6AcC@zeniv-ca.linux.org.uk>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 9 Jun 2022 21:10:04 +0200
Message-ID: <CA+icZUU_Lzo918raOtEXvMtEoUhZp9e+8Xd0_bxA=1_aZ=ZBTQ@mail.gmail.com>
Subject: Re: [RFC][PATCHES] iov_iter stuff
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 8, 2022 at 10:39 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Wed, Jun 08, 2022 at 09:28:18PM +0200, Sedat Dilek wrote:
>
> > I have pulled this on top of Linux v5.19-rc1... plus assorted patches
> > to fix issues with LLVM/Clang version 14.
> > No (new) warnings in my build-log.
> > Boots fine on bare metal on my Debian/unstable AMD64 system.
> >
> > Any hints for testing - to see improvements?
>
> Profiling, basically...  A somewhat artificial microbenchmark would be
> to remove read_null()/write_null()/read_zero()/write_zero(), along with
> the corresponding .read and .write initializers in drivers/char/mem.c
> and see how dd to/from /dev/zero and friends behaves.  On the mainline
> it gives a noticable regression, due to overhead in new_sync_{read,write}().
> With this series it should get better; pipe reads/writes also should see
> reduction of overhead.
>
>         There'd been a thread regarding /dev/random stuff; look for
> "random: convert to using iters" and things nearby...

Hmm, I did not find it...

I bookmarked Ingo's reply on Boris x86-usercopy patch.
There is a vague description without (for me at least) concrete instructions.

> So Mel gave me the idea to simply measure how fast the function becomes.
> ...

My SandyBridge-CPU has no FSRM feature, so I'm unsure if I really
benefit from your changes.

My test-cases:

1. LC_ALL=C dd if=/dev/zero of=/dev/null bs=1M count=1M status=progress

2. perf bench mem memcpy (with Debian's perf v5.18 and a selfmade v5.19-rc1)

First test-case shows no measurable/noticable differences.
The 2nd one I ran for the first time with your changes and did not
compare with a kernel without them.
Link to the 2nd test-case and comments see [1].

In a later version you may add some notes/comments about benchmarking.
"Numbers talk - bullshit walks." Linus T.

-Sedat-

[1] https://lore.kernel.org/all/YpCxt31TKxV5zS3l@gmail.com/
