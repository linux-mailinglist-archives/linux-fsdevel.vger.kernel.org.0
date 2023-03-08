Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA8B6AFB24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Mar 2023 01:31:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCHAbt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Mar 2023 19:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjCHAbr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:31:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC68CB04BC;
        Tue,  7 Mar 2023 16:31:41 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id ec29so28612874edb.6;
        Tue, 07 Mar 2023 16:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678235500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8DWyxZLwz0osrzYUjjj+Q0PWcCb5xGom73+y4XCUag=;
        b=CMl2Qemmziw/e5oRKfvTMmICqZiTcuts6A0+1gO6EtGLAZSyeG6hC1F2jpmgqnuHCi
         9R44T4/cTr5QflfIkBYXsV36jE3BdPM+vDyT2DgE5Qku5adiF+9H3TFAGBnWCup3nwFy
         ZkauYEsWDQ4MHj+vY2fBRcHHYxoKQoDpiXpPjWSNcU840D++A2lmTEOFuf4WMloYRaHg
         Ak/Ge3lPxtKqkuiDdeAg8oLtNF4gr1SUImSCLPedwUfEZg4D0Jn4aR9xNzkqOiqQ8er6
         GSj3zqjtYKQuLi8w37fcToRPRNLYiXGnbiBH2MSRvCUwvaqwtUOQteCifiPUVsr2ouKR
         /a4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678235500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P8DWyxZLwz0osrzYUjjj+Q0PWcCb5xGom73+y4XCUag=;
        b=GyQGrJBMZnho5+6jmG5YBU4A9jXfjC1ZgbXKyv9sxgrJmlYl0LklZfH2ANsL6gF4T1
         hIIwUNgs24/IEj71Yz30Q9reu5+KdZzRzDJXZ3bmkK3ypspEPgzoAwDi3TCF5B/s7qtB
         fVXFq5E+gb1Wn86AAjrAHNjoyy1OIQg3lFs1Q4xvv24nOBSBOR4+3C7kCZNgFDWVDp8z
         Ff/4XsJB16UfYpRSsiqcA3INx3oNJcCbjOeFhsfMRDRIFpNmRRFzNHyAQU7lNOWp868R
         Ijd1oycFfKEoA3wZgl+M1vmFtbMOLi1qQeNmmjxhYdcAa9oQYhT1K3FEjlTSe662HDNh
         g79w==
X-Gm-Message-State: AO0yUKWTqYBajJFUGP/zRj4SmxSfNwggY2arHZDp1GlWjWB9shqECekL
        OoohvWs2l8QI9rAtn4ohkaTj7kHwYmae4OU846Y=
X-Google-Smtp-Source: AK7set/isvjfpk9L7++ojTmD2MedPIioIjEyje2YVbRt5Mxdd1x/zVxoo60oOmS54QWAPrLb5Sb1UfW0CrYyYe7Md8A=
X-Received: by 2002:a17:906:24da:b0:8a5:c8bd:4ac4 with SMTP id
 f26-20020a17090624da00b008a5c8bd4ac4mr7515351ejb.15.1678235500017; Tue, 07
 Mar 2023 16:31:40 -0800 (PST)
MIME-Version: 1.0
References: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
In-Reply-To: <0a6f0513-b4b3-9349-cee5-b0ad38c81d2e@huaweicloud.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Mar 2023 16:31:28 -0800
Message-ID: <CAEf4Bza98fCnVRhxfxBOgqLuvB3c7Zh7A9yO8gtgVaNxGmZ4Pg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] bpf iterator for file-system
To:     Hou Tao <houtao@huaweicloud.com>
Cc:     lsf-pc@lists.linux-foundation.org, bpf <bpf@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
        Nhat Pham <nphamcs@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>, Yonghong Song <yhs@fb.com>
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

On Mon, Feb 27, 2023 at 7:42=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From time to time, new syscalls have been proposed to gain more observabi=
lity
> for file-system:
>
> (1) getvalues() [0]. It uses a hierarchical namespace API to gather and r=
eturn
> multiple values in single syscall.
> (2) cachestat() [1].  It returns the cache status (e.g., number of dirty =
pages)
> of a given file in a scalable way.
>
> All these proposals requires adding a new syscall. Here I would like to p=
ropose
> another solution for file system observability: bpf iterator for file sys=
tem
> object. The initial idea came when I was trying to implement a filefrag-l=
ike
> page cache tool with support for multi-order folio, so that we can know t=
he
> number of multi-order folios and the orders of those folios in page cache=
. After
> developing a demo for it, I realized that we could use it to provide more
> observability for file system objects. e.g., dumping the per-cpu iostat f=
or a
> super block [2],  iterating all inodes in a super-block to dump info for
> specific inodes (e.g., unlinked but pinned inode), or displaying the flag=
s of a
> specific mount.
>
> The BPF iterator was introduced in v5.8 [3] to support flexible content d=
umping
> for kernel objects. It works by creating bpf iterator file [4], which is =
a
> seq-like read-only file, and the content of the bpf iterator file is dete=
rmined
> by a previously loaded bpf program, so userspace can read the bpf iterato=
r file
> to get the information it needs. However there are some unresolved issues=
:
> (1) The privilege.
> Loading the bpf program requires CAP_ADMIN or CAP_BPF. This means that th=
e
> observability will be available to the privileged process. Maybe we can l=
oad the
> bpf program through a privileged process and make the bpf iterator file b=
eing
> readable for normal users.

That's possible today. Once you load BPF iter program and pin it in
BPF FS, you can chown/chmod pinned file to give access to it to
unprivileged processes.

> (2) Prevent pinning the super-block
> In the current naive implementation, the bpf iterator simply pins the
> super-block of the passed fd and prevents the super-block from being dest=
royed.
> Perhaps fs-pin is a better choice, so the bpf iterator can be deactivated=
 after
> the filesystem is umounted.
>
> I hope to send out an RFC soon before LSF/MM/BPF for further discussion.
>
> [0]:
> https://lore.kernel.org/linux-fsdevel/YnEeuw6fd1A8usjj@miu.piliscsaba.red=
hat.com/
> [1]: https://lore.kernel.org/linux-mm/20230219073318.366189-1-nphamcs@gma=
il.com/
> [2]:
> https://lore.kernel.org/linux-fsdevel/CAJfpegsCKEx41KA1S2QJ9gX9BEBG4_d8ig=
A0DT66GFH2ZanspA@mail.gmail.com/
> [3]: https://lore.kernel.org/bpf/20200509175859.2474608-1-yhs@fb.com/
> [4]: https://docs.kernel.org/bpf/bpf_iterators.html
>
