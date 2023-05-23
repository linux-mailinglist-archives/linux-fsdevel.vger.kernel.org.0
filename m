Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0163770E3E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 19:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbjEWR03 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 13:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238142AbjEWR0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 13:26:20 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB31A1;
        Tue, 23 May 2023 10:25:56 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-50be17a1eceso203177a12.2;
        Tue, 23 May 2023 10:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684862753; x=1687454753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tO87sKCmcsAUlv/lz9FjYVTAI78yMPfjudo+/sHY1y8=;
        b=ef0PcDwgp3Pe0ajJXKZ4t8bx+oZrNJRthJ7hSBVRX9iIg+qeMPdLXiJQXHTyrLRc+e
         ANI9T/G3YUwWUNIX0ff+Y4GmWVSrD9o73aSGKH6KfznoHOizrU2OjDSPP9UV6nagYIE/
         53oVTyLCMgKrvPv3t5bwZBUhB0MUuc4jahY6II+ubh6sByeS147JWUI2m32N4vOy/ewu
         F4EZApAgJlVAyZ9ORsEOsRTEM9wBug4V/Z0lT84BEe2AbQ9jzUZZhrgsQ+C8laPMqS8S
         eeZNP7A9dT2dITmpSa62P+QxsFsFdi2OUtJSuE71v2Cp+hFjrP6KuTKuTn94kA6/gO9J
         M5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862753; x=1687454753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tO87sKCmcsAUlv/lz9FjYVTAI78yMPfjudo+/sHY1y8=;
        b=hJx0HDQYGMhFgY9xZQrOMfFpdctHhWVzKWdlsrsv192Z4sRJdXjxqTMWY/0YnhyHsA
         SuoVpLasqxgfzLAEEW+o9OmFXt882LOPr7fYj4Jvw5hyG7RoClzmEcAtZBSTeyoILC8H
         tO/r+6PnZwYvLcTcVATIQISvKYYluLhGAc3U7ukEeIYvNtxY4dwIY2QLIjhwPQdlK6vX
         S2uk3nEO3fA6BTchIT9oeCsAYFDGYb46331ivL9JlOIjR3U4Kc1ggksTBmJ6Hf+YUvdy
         vzNYUpv2bH3NKNlNAC1brlGvbUoIIyy6uqgm3P6K6+/HkfD9myzjIbnfApfhrjpy/g/t
         CwRQ==
X-Gm-Message-State: AC+VfDw0BBP1beQAPhH3WrdJMkEDUBfkI7f50zZ2AvTcaHwPa4Mme1yG
        5zkTQdCCGEH9ymxF2CxwRMHEqh5nIDkd/rZewlA=
X-Google-Smtp-Source: ACHHUZ4xbu+WovfwpMM5TWLvwqkB3SKmPycltTIRXJY8Y6kj5XnqZlnD5MgrwhVBbFoR7BRitNb0kHIcOFaZiuYzMEE=
X-Received: by 2002:a05:6402:7c8:b0:50d:8aaf:7ad9 with SMTP id
 u8-20020a05640207c800b0050d8aaf7ad9mr12858446edy.12.1684862752871; Tue, 23
 May 2023 10:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
 <20230518-erdkugel-komprimieren-16548ca2a39c@brauner> <20230518162508.odupqkndqmpdfqnr@MacBook-Pro-8.local>
 <20230518-tierzucht-modewelt-eb6aaf60037e@brauner> <20230518182635.na7vgyysd7fk7eu4@MacBook-Pro-8.local>
 <CAHk-=whg-ygwrxm3GZ_aNXO=srH9sZ3NmFqu0KkyWw+wgEsi6g@mail.gmail.com>
 <20230519044433.2chdcze3qg2eho77@MacBook-Pro-8.local> <ZGxwHO2MRNK9gYxB@gardel-login>
In-Reply-To: <ZGxwHO2MRNK9gYxB@gardel-login>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 23 May 2023 10:25:40 -0700
Message-ID: <CAEf4Bzaqju3iMgjbm2a+_Z2GgNzs-Atj0UH303VaxK65YoC8sA@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 23, 2023 at 12:49=E2=80=AFAM Lennart Poettering
<lennart@poettering.net> wrote:
>
> On Do, 18.05.23 21:44, Alexei Starovoitov (alexei.starovoitov@gmail.com) =
wrote:
>
> > > The 0/1/2 file descriptors are not at all special. They are a shell
> > > pipeline default, nothing more. They are not the argument your think =
they
> > > are, and you should stop trying to make them an argument.
> >
> > I'm well aware that any file type is allowed to be in FDs 0,1,2 and
> > some user space is using it that way, like old inetd:
> > https://github.com/guillemj/inetutils/blob/master/src/inetd.c#L428
> > That puts the same socket into 0,1,2 before exec-ing new process.
> >
> > My point that the kernel has to assist user space instead of
> > stubbornly sticking to POSIX and saying all FDs are equal.
> >
> > Most user space developers know that care should be taken with FDs 0,1,=
2,
> > but it's still easy to make a mistake.
>
> If I look at libbpf, which supposedly gets the fd handling right I
> can't find any hint it actually moves the fds it gets from open() to
> an fd > 2, though?
>
> i.e. the code that invokes open() calls in the libbpf codebase happily
> just accepts an fd < 2, including fd =3D=3D 0, and this is then later
> passed back into the kernel in various bpf() syscall invocations,
> which should refuse it, no? So what's going on there?

libbpf's attempt to ensure that fd>2 applies mostly to BPF objects:
maps, progs, btfs, links, which are always returned from bpf()
syscall. That's where we use ensure_good_fd(). The snippet you found
in bpf_map__reuse_fd() is problematic and slipped through the cracks,
I'll fix it, thanks for bringing this to my attention. I'll also check
if there are any other places where we should use ensure_good_fd() as
well.

>
> I did find this though:
>
> <snip>
>         new_fd =3D open("/", O_RDONLY | O_CLOEXEC);
>         if (new_fd < 0) {
>                 err =3D -errno;
>                 goto err_free_new_name;
>         }
>
>         new_fd =3D dup3(fd, new_fd, O_CLOEXEC);
>         if (new_fd < 0) {
>                 err =3D -errno;
>                 goto err_close_new_fd;
>         }
> </snip>
>
> (This is from libbpf.c, bpf_map__reuse_fd(), i.e. https://github.com/libb=
pf/libbpf/blob/master/src/libbpf.c)
>
> Not sure what's going on here, what is this about? you allocate an fd
> you then immediately replace? Is this done to move the fd away from
> fd=3D0?  but that doesn't work that way, in case fd 0 is closed when
> entering this function.
>
> Or is this about dup'ping with O_CLOEXEC?


This code predates me, so I don't know the exact reasons why it's
implemented exactly like this. It seems like instead of doing
open()+dup3() we should do dup3()+ensure_good_fd(). I need to look at
this carefully, this is not the code I work with regularly.

>
> Please be aware that F_DUPFD_CLOEXEC exists, which allows you to
> easily move some fd above some treshold, *and* set O_CLOEXEC at the
> same time. In the systemd codebase we call this frequently for code
> that ends up being loaded in arbitrary processes (glibc NSS modules,
> PAM modules), in order to ensure we get out of the fd < 3 territory
> quickly.

nice, thanks

>
> (btw, if you do care about O_CLOEXEC =E2=80=93 which is great =E2=80=93 t=
hen you also
> want to replace a bunch of fopen(=E2=80=A6, "r") with fopen(=E2=80=A6, "r=
e") in your
> codebase)

I will check this as well, thanks for the hints :)

>
> Lennart
