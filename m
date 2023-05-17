Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A845E706DEC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 May 2023 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjEQQSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 May 2023 12:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjEQQSR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 May 2023 12:18:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F411F9EED;
        Wed, 17 May 2023 09:17:51 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f24cfb8539so1192904e87.3;
        Wed, 17 May 2023 09:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684340268; x=1686932268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXp6wZ3/YatrjomeI6y5aG9ufgQf3HxpLAm1RnoMQ9k=;
        b=bS1z82BnKfj9t7PxsXYBOCYXkdOHbAgiCpY8JBxIRh2+SEwZ0KtH4R8J6xz+OXI2g8
         7CTaxvITcYbbOMpIfSph4cjhSXYbq5fXFquX1vkq/9pT9/f/ILPuU6DRyJqvAUnYluke
         3ktSbwkSkMjBxTDLnGOy/6lQ7nFK9CWZeY88j+tZp8HYbnk1TaR2aWIpRqji2Me5hs4v
         b/y1VKyI/4WBrELrrXNp48hwL7D4GCd3YWeBucukjTOqiO6/6SAc+iPqQUpFGtfHfhL9
         B2vS67/4g38RySthosGIhvftTEXvD9luQcIsQm7L6i8jwJ5KI5q1VyWRUBaEVS5lcycK
         AHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684340268; x=1686932268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXp6wZ3/YatrjomeI6y5aG9ufgQf3HxpLAm1RnoMQ9k=;
        b=gIrtox/JMrhW+SIErBv4ORqJFhNLe9Uw9O0z1y7Wdx4un1qqXzCE5wLpKoDbC7FcQR
         MaJmeK+7+YoUmr7ySyLe03jm+bYQcCR4QthvVj9JKGrRtvsjXNlTjRbYF+CqfW8s7Nvs
         iArZWVlYY4RUr3Gil0am2DVZd1sePJtCIRofjSYgdE5jaiItMX5OTF6wzbHbWOX/iETv
         VgRtiujKVC7EmDzdqq1ApJdPM1eN2wuNhp9muOITvtfeGhRve8SGQL1L3GVFhFFqNSv4
         z02lJo97k1Lx6kks1EdgVyrsjesqCTztItGoRGBbw0fogzMoW64ERK8ddwB+1dtljAEu
         hecA==
X-Gm-Message-State: AC+VfDzliMPPTZtaJtNyZa4V1ijG+kqqyN/XvjQ2vEIwboczyKDT2nEM
        ViKQoC8tIKaAyGMIlI01zP6f6NoNk8DTxIKw8f7nwHr8sIQ=
X-Google-Smtp-Source: ACHHUZ4BGdtQTp3SrxRQVNUz1pumol587Q55YEEwoWk+M1ChsEYnhaQM/kMIeLpwekljYOZIhV2+OgHADTKBOolaX10=
X-Received: by 2002:a05:6512:408:b0:4db:4fe8:fd0f with SMTP id
 u8-20020a056512040800b004db4fe8fd0fmr387016lfk.25.1684340267815; Wed, 17 May
 2023 09:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230516001348.286414-1-andrii@kernel.org> <20230516001348.286414-2-andrii@kernel.org>
 <20230516-briefe-blutzellen-0432957bdd15@brauner> <CAEf4BzafCCeRm9M8pPzpwexadKy5OAEmrYcnVpKmqNJ2tnSVuw@mail.gmail.com>
 <20230517-allabendlich-umgekehrt-8cc81f8313ac@brauner> <20230517120528.GA17087@lst.de>
In-Reply-To: <20230517120528.GA17087@lst.de>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 17 May 2023 09:17:36 -0700
Message-ID: <CAADnVQLitLUc1SozzKjBgq6HGTchE1cO+e4j8eDgtE0zFn5VEw@mail.gmail.com>
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

On Wed, May 17, 2023 at 5:05=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, May 17, 2023 at 11:11:24AM +0200, Christian Brauner wrote:
> > Adding fsdevel so we're aware of this quirk.
> >
> > So I'm not sure whether this was ever discussed on fsdevel when you too=
k
> > the decision to treat fd 0 as AT_FDCWD or in general treat fd 0 as an
> > invalid value.
>
> I've never heard of this before, and I think it is compltely
> unacceptable. 0 ist just a normal FD, although one that happens to
> have specific meaning in userspace as stdin.
>
> >
> > If it was discussed then great but if not then I would like to make it
> > very clear that if in the future you decide to introduce custom
> > semantics for vfs provided infrastructure - especially when exposed to
> > userspace - that you please Cc us.
>
> I don't think it's just the future.  We really need to undo this ASAP.

Christian is not correct in stating that treatment of fd=3D=3D0 as invalid
bpf object applies to vfs fd-s.
The path_fd addition in this patch is really the very first one of this kin=
d.
At the same time bpf anon fd-s (progs, maps, links, btfs) with fd =3D=3D 0
are invalid and this is not going to change. It's been uapi for a long time=
.

More so fd-s 0,1,2 are not "normal FDs".
Unix has made two mistakes:
1. fd=3D=3D0 being valid fd
2. establishing convention that fd-s 0,1,2 are stdin, stdout, stderr.

The first mistake makes it hard to pass FD without an extra flag.
The 2nd mistake is just awful.
We've seen plenty of severe datacenter wide issues because some
library or piece of software assumes stdin/out/err.
Various services have been hurt badly by this "convention".
In libbpf we added ensure_good_fd() to make sure none of bpf objects
(progs, maps, etc) are ever seen with fd=3D0,1,2.
Other pieces of datacenter software enforce the same.

In other words fds=3D0,1,2 are taken. They must not be anything but
stdin/out/err or gutted to /dev/null.
Otherwise expect horrible bugs and multi day debugging.

Because of that, several years ago, we've decided to fix unix mistake #1
when it comes to bpf objects and started reserving fd=3D0 as invalid.
This patch is proposing to do the same for path_fd (normal vfs fd) when
it is passed to bpf syscall. I think it's a good trade-off and fits
the rest of bpf uapi.

Everyone who's hiding behind statements: but POSIX is a standard..
or this is how we've been doing things... are ignoring the practical
situation at hand. fd-s 0,1,2 are taken. Make sure your sw never produces t=
hem.
