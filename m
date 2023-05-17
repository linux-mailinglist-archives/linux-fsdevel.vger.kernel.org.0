Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24110707482
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 23:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjEQVtO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 17:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjEQVtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 17:49:09 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749F559D;
        Wed, 17 May 2023 14:49:08 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f26f437b30so1615111e87.1;
        Wed, 17 May 2023 14:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684360146; x=1686952146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElmYzbqzVIV/+olV4j+GHcwY8MzhXl7cO3I0B5Wyxlo=;
        b=HrC+UQ6LNnl1yoLwndSSE5kA4sak6BzaOIOoMwfXfUPZyinon8hFfF9UVQjakJpIVs
         WtclSNprHoS99w5S5IIl2RXWqUmVs10TOgSpu2aefSsyLaADSMK41dkfyQinUckEBhfz
         EYfP/eVa7eMtlEVxY3dU0dfYENmHv+u5TVYhB82TUJ/blnM+Z+peeBldPPQZQ5QFxrEn
         yLSXpHRqe81BnhR0hcancZIidpjt38mMQYoMULA+bcujmulgpjgnt7zcvv6eVCBd3C3T
         4TBQWf91rC2n1SKqdYfJvFwNRQq8WXQOlVZYIe3vefxN93LamdkKpTjNGDxmCWPEpWvh
         VLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360146; x=1686952146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ElmYzbqzVIV/+olV4j+GHcwY8MzhXl7cO3I0B5Wyxlo=;
        b=JKZQM6GsjzV4BXgcT8Pj8EO0rn2ioR0nSDNacDkz9/bL2WGDNDH7cHgKl2KyHN4YvY
         CkfNgMv1QSxu1HotLUbnOwjowX4pbRYAmMVtSxA0YYRRiZHeTt8BYOkA2DAJgb3lZP6V
         oL5u0Z5NNlDRCvqSUJIMkrjM1qu86dhx1cr+Qi/HZsFESXb2I2aXi2Wt/J/kv3EkXVVl
         dzmTVreHk0z65l+4hHDXDZIWf8pzOD6GVxBI0nMOLZRsJmexKk5aB82HhOs7TdKH1RoN
         zOyL8XqIsCHVulARWMr7cKvAIwWWTLee8tbBk+cztZ4exWtmoGqVifq040aXED59Flpf
         OLlQ==
X-Gm-Message-State: AC+VfDx+rqHbFrm/tH+kkDFnsY2esja0D/grdcxrlsobBWBX0tOdIMRj
        M7JZ6SjI6Aw6jO4YXnyHwuGh1vio9Sk2RTkvGdA=
X-Google-Smtp-Source: ACHHUZ7XUeWq/ugm8gGWiV5EwwpQUwd7J1+jItYCgi6oT5WIbJ6HJsxrngbvL2GXMrxO7Ls6l8TxWgRLtlUCEM1TZ4E=
X-Received: by 2002:ac2:5a47:0:b0:4dd:a212:e3ca with SMTP id
 r7-20020ac25a47000000b004dda212e3camr648561lfn.11.1684360145968; Wed, 17 May
 2023 14:49:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
 <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
In-Reply-To: <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 May 2023 14:48:54 -0700
Message-ID: <CAADnVQKM3Jh7Sj7o9pz79Dme=kjinjsDPipE6MBUY-f=UfA+Tw@mail.gmail.com>
Subject: Re: fd == 0 means AT_FDCWD BPF_OBJ_GET commands
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Lennart Poettering <lennart@poettering.net>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 17, 2023 at 9:17=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 17, 2023 at 5:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wr=
ote:
> >
> > On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > > Adding fsdevel so we're aware of this quirk.
> > >
> > > So I'm not sure whether this was ever discussed on fsdevel when you t=
ook
> > > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > > invalid value.
> >
> > I've never heard of this before, and I think it is compltely
> > unacceptable. 0 ist just a normal FD, although one that happens to
> > have specific meaning in userspace as stdin.
> >
> > >
> > > If it was discussed then great but if not then I would like to make i=
t
> > > very clear that if in the future you decide to introduce custom
> > > semantics for vfs provided infrastructure - especially when exposed t=
o
> > > userspace - that you please Cc us.
> >
> > I don't think it's just the future.  We really need to undo this ASAP.
>
> Christian is not correct in stating that treatment of fd=3D=3D0 as invali=
d
> bpf object applies to vfs fd-s.
> The path_fd addition in this patch is really the very first one of this k=
ind.
> At the same time bpf anon fd-s (progs, maps, links, btfs) with fd =3D=3D =
0
> are invalid and this is not going to change. It's been uapi for a long ti=
me.
>
> More so fd-s 0,1,2 are not "normal FDs".
> Unix has made two mistakes:
> 1. fd=3D=3D0 being valid fd
> 2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.
>
> The first mistake makes it hard to pass FD without an extra flag.
> The 2nd mistake is just awful.
> We've seen plenty of severe datacenter wide issues because some
> library or piece of software assumes stdin/out/err.
> Various services have been hurt badly by this "convention".
> In libbpf we added ensure_good_fd() to make sure none of bpf objects
> (progs, maps, etc) are ever seen with fd=3D0,1,2.
> Other pieces of datacenter software enforce the same.
>
> In other words fds=3D0,1,2 are taken. They must not be anything but
> stdin/out/err or gutted to /dev/null.
> Otherwise expect horrible bugs and multi day debugging.
>
> Because of that, several years ago, we've decided to fix unix mistake #1
> when it comes to bpf objects and started reserving fd=3D0 as invalid.
> This patch is proposing to do the same for path_fd (normal vfs fd) when
> it is passed to bpf syscall. I think it's a good trade-off and fits
> the rest of bpf uapi.
>
> Everyone who's hiding behind statements: but POSIX is a standard..
> or this is how we've been doing things... are ignoring the practical
> situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces=
 them.

Summarizing an offlist discussion with Christian and Andrii.

The key issue is that fd =3D=3D 0 must not mean AT_FDCWD and that's clear.
We'll respin with an extra flag to indicate that path_fd should be used.
