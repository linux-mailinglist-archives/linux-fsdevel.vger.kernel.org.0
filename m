Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882515F8AB0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 12:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJIKid (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 06:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJIKib (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:38:31 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301F3B36;
        Sun,  9 Oct 2022 03:38:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id g130so10110170oia.13;
        Sun, 09 Oct 2022 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nWvhnVzPYFvs5pSg57txecq8CLlBbSop8yXnsSTys3A=;
        b=ZC2PllSsRBAEa7KzF+tHhQsTHPlV7cJsXuqY/c3gleLpbTXesyWSVHnQKwCGnL9+xj
         +8cEodhhpQ+6og0w7xtcM9Qv3SXllRSaPRaTkO6UackfVw9uB9I8qVtAl5zCBmDrJY74
         NEy6qd7sEtPvfjJ+oPLBU1KFeZvAYiJIxFamPUikCdkHVuTGdanxMfM0efVneere5NRD
         snCymbzEZ0jqP4ONGOXOC0KBdAaKnlmiUCfh+vwcEMVEmlugLuYHGguew5YuB8EQGD9X
         QmRQJiyE5nBJQEQjUuiSFNF2yRomy+Q/8yf2xPdMT3H5zbHBvcPwdzfDhoP0NPlRy39t
         aUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nWvhnVzPYFvs5pSg57txecq8CLlBbSop8yXnsSTys3A=;
        b=JkkQ5+SXBP5xsYwDO5GO0lvrTMI9sD/SPs3CQUt+2gONamz7WEA53r14J6CvxOKCR+
         zx6osdgwgbKelVJhNe7M+z11uJWObehmsZpch3NEAU9+dkj6zzaVExEFf3iWm2/rJ0hv
         TRpoXe2ollsgm3sDst02jsBQ/7AoYP+r4LCwKm6Oi6uSuwFSgp9wD8FcyWwyA44APR42
         7J3TEEWzujB+UmycgMIyAxBiM33lSGlDnrwS8kESxLS9HBdExtrcKpELyc02qeucKcLq
         oLQaPo89+6fBoUfAO+AeZ6RdEVORQDGgHrOIdgRonbphdqXEP0OlvyV/anZwtJRPXiXD
         epLA==
X-Gm-Message-State: ACrzQf1Bkql5VHAwTOld8tfCnAkVdE1YB5DumIw9abH+iP5LM3+E7Rvy
        v5lPdQ6bcF1ZrYXh7SbE9dP7XNxcEMVSPXLoDq8=
X-Google-Smtp-Source: AMsMyM7UKkIQ/57B7LP5SutSXYYsVj/iDA3foIuY201VGVWeO5D7kx7nsQYaitzvNyd20/CPCf69RXCxFK3XZIZGk88=
X-Received: by 2002:a05:6808:e8e:b0:34d:7829:135 with SMTP id
 k14-20020a0568080e8e00b0034d78290135mr6499786oil.252.1665311910417; Sun, 09
 Oct 2022 03:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <YzN+ZYLjK6HI1P1C@ZenIV> <YzSSl1ItVlARDvG3@ZenIV>
 <YzpcXU2WO8e22Cmi@iweiny-desk3> <7714.1664794108@jrobl> <Yzs4mL3zrrC0/vN+@iweiny-mobl>
 <YztfvaAFOe2kGvDz@ZenIV> <4011.1664837894@jrobl> <YztyLFZJKKTWcMdO@ZenIV>
 <CAHk-=whsOyuRhjmUQ5c1dBQYt1E4ANhObAbEspWtUyt+Pq=Kmw@mail.gmail.com> <CA+icZUVXvMM-sK41oz_Ne4HyRGxXHNz=fPqy+1AYXmXPiE_=Rw@mail.gmail.com>
In-Reply-To: <CA+icZUVXvMM-sK41oz_Ne4HyRGxXHNz=fPqy+1AYXmXPiE_=Rw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 9 Oct 2022 12:37:54 +0200
Message-ID: <CA+icZUVBFo3v6L8Y4HNMR3XxsBb9YoMw9j+ehXpkWov9EeM59A@mail.gmail.com>
Subject: Re: [PATCH][CFT] [coredump] don't use __kernel_write() on kmap_local_page()
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        "J. R. Okajima" <hooanon05g@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ren Zhijie <renzhijie2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 4, 2022 at 8:18 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, Oct 4, 2022 at 2:51 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, Oct 3, 2022 at 4:37 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > One variant would be to revert the original patch, put its
> > > (hopefully) fixed variant into -next and let it sit there for
> > > a while.  Another is to put this incremental into -next and
> > > merge it into mainline once it gets a sane amount of testing.
> >
> > Just do the incremental fix. It looks obvious enough ("oops, we need
> > to get the pos _after_ we've done any skip-lseeks on the core file")
> > that I think it would be just harder to follow a "revert and follow up
> > with a fix".
> >
> > I don't think it needs a ton of extra testing, with Okajima having
> > already confirmed it fixes his problem case..
> >
> >                 Linus
>
> [ CC Geert ]
>
> There was another patch from Geert concerning the same coredump changes:
>
> [PATCH] coredump: Move dump_emit_page() to kill unused warning
>
> If CONFIG_ELF_CORE is not set:
>
>     fs/coredump.c:835:12: error: =E2=80=98dump_emit_page=E2=80=99 defined=
 but not used
> [-Werror=3Dunused-function]
>       835 | static int dump_emit_page(struct coredump_params *cprm,
> struct page *page)
>           |            ^~~~~~~~~~~~~~
>
> Fix this by moving dump_emit_page() inside the existing section
> protected by #ifdef CONFIG_ELF_CORE.
>
> Fixes: 06bbaa6dc53cb720 ("[coredump] don't use __kernel_write() on
> kmap_local_page()")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> Please, check yourself!
>
> Best regards,
> -Sedat-
>
> [1] https://lore.kernel.org/all/20221003090657.2053236-1-geert@linux-m68k=
.org/

[ CC Ren Zhijie <renzhijie2@huawei.com> ]

Looks like the same patch as of Geert.

-Sedat-

[1] https://lore.kernel.org/all/20221009092420.32850-1-renzhijie2@huawei.co=
m/
