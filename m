Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEDA52E695
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 09:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346651AbiETHwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 03:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346644AbiETHwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 03:52:16 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDCC8D699;
        Fri, 20 May 2022 00:52:13 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id k8so6198266qvm.9;
        Fri, 20 May 2022 00:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VdY72I8mhybRFUOICLOWp/6ONouuzQkRYkpcV7tXB4w=;
        b=mGtVG3cF/RRc+1WhMh3mRAJ2N1LM1iGv/ZXcsBkmGC1k8ojddIl/5C4HQYiwX6jAlH
         nIXG29SF2V7iL1SWaBWxpE8tSZjZusqUdtINbRGhvVcyCH4mqNbZpXKHbXL9uYdagP/G
         LJaK1rrD2r509upJCzPSuxzVmkIlLFgIuXRYeLg4lgZjn9UU2bKSukMn5F5tMjUHU4yQ
         v2MfBeW3BKiFQGlFQ6KQ/KjgD/3+lo6iRZsXpBvXXKjH601G3gnMpMujalfx3K+Iqj9S
         C9JuDOP1vshda5kwnn0hX4D9CBNiRNGh8LAOGMHmE/dsFsa1OtV9yObeSAgdDWi5UvNW
         e2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VdY72I8mhybRFUOICLOWp/6ONouuzQkRYkpcV7tXB4w=;
        b=rdnpynLZzwiTzEySeDP9Q7EAHtCeZabJLBUEMmDrdV2WmZMwTDNzDM6oqTPVPmlozQ
         In8l+Tc7IUsbKg9KXpjsCIs7XeIzNtxlqowyzickdp4nlgC4v7SP7hOmUmV4N4AGHeC2
         bVMu7EMXlRzKNJoWXkqMyagR6f0NtTaE86meNu+Uli3GYESdrlh93bdsl71pIYghOLxC
         0WFdeYnkWkhwhXeE+zOgx2X32hE+twhLrjA1+fMqlBM2LpuKyrl03dwHkvGCgBGi4aXJ
         kBkpcXZhE4irl2tLHWkQezBzjjs6az7Bs8Eug2x0nxXzclZEVEJr5LqhlNsWgft7/FCx
         000Q==
X-Gm-Message-State: AOAM530Nkh5TxrqV/aVlAuL9tPZNdVyilayssmOmO6czk6gGDRJVBJoB
        XP658qWk6WXc7X0/UNt8cMBTMwlzekW/pJfV+7k=
X-Google-Smtp-Source: ABdhPJw8mc4Z1ZNfr3ozcCBCCHD10JZaV1gQehEHnBL/ac8vMhBFmG1SdEbCwkMNxndpXoDSo/5q9pIeCWviRb1yERU=
X-Received: by 2002:a05:6214:5296:b0:461:d3bb:ba01 with SMTP id
 kj22-20020a056214529600b00461d3bbba01mr6872345qvb.12.1653033133008; Fri, 20
 May 2022 00:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com>
 <YocRWLtlbokO0jsi@zeniv-ca.linux.org.uk> <CAOQ4uxizvWk-=JW=s-WXw0OGR3Wjm2YYkpwQqXHc27U=iRtQDg@mail.gmail.com>
In-Reply-To: <CAOQ4uxizvWk-=JW=s-WXw0OGR3Wjm2YYkpwQqXHc27U=iRtQDg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 May 2022 10:52:01 +0300
Message-ID: <CAOQ4uxj+YSbywkKC8c6qRW55Ujcwxcjkf9sFg=e8m0xp8JLq9g@mail.gmail.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     He Zhe <zhe.he@windriver.com>, Dave Chinner <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
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

On Fri, May 20, 2022 at 7:39 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Fri, May 20, 2022 at 6:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Thu, May 19, 2022 at 04:53:15PM +0300, Amir Goldstein wrote:
> >
> > > Luis gave up on it, because no maintainer stepped up to take
> > > the patch, but I think that is the right way to go.
> > >
> > > Maybe this bug report can raise awareness to that old patch.
> > >
> > > Al, could you have a look?
> >
> > IIRC, you had objections to that variant back then...
>
> Right. But not about the "main" patch.
> The patch had an "also" part:
>
> The short-circuit code for the case where the copy length is zero has also
> been dropped from the VFS code.  This is because a zero size copy between
> two files shall provide a clear indication on whether or not the
> filesystem supports non-zero copies.
>
> -     if (len == 0)
> -         return 0;
> -
>
> Which would have been a regression for nfs client, because
> nfs protocol treats length 0 from ->copy_file_range() as "copy everything":
>
> https://lore.kernel.org/linux-fsdevel/CAOQ4uxgwcNwWEqYKBg3fMHD3aXOsYUmPeexBe9EVP9Nb53b-Hw@mail.gmail.com/
>
> This api impedance should be fixed in the nfs client, but I'm
> not sure if that was already done.
>
> I will test and re-post Luis' patch without removing the short-circuit
> unless Luis gets to it first.
>

Urgh! That old patch passes the fstests -g copy_range group
on nfs, but fails almost all of them on xfs/btrfs.

The reason is that when we allow to perform copy_range
with remap_file_range() it fails for sizes smaller than block size
and returning short read of 0 from copy_range is not an option.

So what I am going to do is to keep the basic restriction in this patch of:
"copy_range allowed for fs that implement either ->copy_file_range()
or ->remap_file_range() (for same sb copy)"

But will change the logic of:
"try clone and then copy then fail"
to:
- try ->copy_file_range()
- try ->remap_file_range()
- fall back to kernel copy

Patch coming shortly.

Thanks,
Amir.
