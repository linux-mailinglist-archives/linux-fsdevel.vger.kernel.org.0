Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D183063FC2D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Dec 2022 00:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbiLAXm4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Dec 2022 18:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbiLAXmw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Dec 2022 18:42:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448F321E20
        for <linux-fsdevel@vger.kernel.org>; Thu,  1 Dec 2022 15:42:50 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i81-20020a1c3b54000000b003d070274a61so4822218wma.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Dec 2022 15:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1BLYwZY5bN3vN/ic/ptPGLS2PPXZuxHx6fXaHe8QR0=;
        b=dmCf3lPhz6Btg5yVeFhWhov2J0EQqLJkDGPXTDytBHHVUcx5x6NhD9Stvt/1l0dHsN
         wxxY420AHgaSh4/w0+xSPe13fHayNW3J68lMwpPj2DIffCL+rWanaLlislEYBPCSr0yG
         Vm78/XGGHrUi1T/kn6uhtu1ED9pWVsiUfgPQ8h+D06v3VzvcYZaCj16+2hF7gBOt0UMe
         Z+4fHjbu1vfAO6J/Mh0xOkP0PUFKbfZnbw/+ZG3AbXRhy/ChMFx4QcYEGxV7orlsSG9P
         YkhMzMEy6T/Y/fvW2No/a+8wx2aKq8uFcwoKjIRaAenSjDxBHYDlKXiCiNUJX4qj4znL
         NM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u1BLYwZY5bN3vN/ic/ptPGLS2PPXZuxHx6fXaHe8QR0=;
        b=DS81l//uoQLbez5jgNyoUndi8a7dpB6BTzopwr8NS26Oxi1VlqkrZBUwcci2qBXJWs
         Vu6qLVvW4Hjrcmql+o9j5HeFt3Q9j+qqIGlT72uuZKcgvH/V+2F3xe1KL6CNjuRn29Rd
         iJpO91S1ff6QEHUs6N4AARi+AEgdj3ASHIsUoicQm9A6eJ/2+3jQ8NMvdgmJvPzkQYht
         G4FaCACN1j7nwOBRyQigEc+Ioa0Tt/a2QJcijI2O3komnyd2yJKNC/O50lWQfe7XJhH9
         EVBKCWcpFbTiulMuAIve3R9Jj0hnf79/c8gEYAQp2jZaxAvd0XeeUdTPj5fTzMLlZ2qY
         O9Ww==
X-Gm-Message-State: ANoB5pkcS1MnPJYO7xSRUlOna1toMpUSeKGRSkTqcW/illQDbqEPgUPk
        88FAH91YZfFoOXS/6ZcIg9rx9YBkE0xoMrFBetpaww==
X-Google-Smtp-Source: AA0mqf7VajGpoGBZ4xg9b6825l8cjMfES8HHBJP3GkS3HSaplese1PNiHOiYM2HCdMSJ/GEEWhjGWyeI4tovImT4Xb4=
X-Received: by 2002:a1c:f616:0:b0:3cf:b1c2:c911 with SMTP id
 w22-20020a1cf616000000b003cfb1c2c911mr42263037wmc.16.1669938168621; Thu, 01
 Dec 2022 15:42:48 -0800 (PST)
MIME-Version: 1.0
References: <D3AF9D1E-12E1-434F-AEA4-5892E8BC66AB@gmail.com>
 <CAFCauYOuVrSFmeckMi+2xteCcuuCfsuNtdMB0spo2afcGOxSeg@mail.gmail.com> <8242669C-B41F-4310-A244-973D9793E652@gmail.com>
In-Reply-To: <8242669C-B41F-4310-A244-973D9793E652@gmail.com>
From:   Victor Hsieh <victorhsieh@google.com>
Date:   Thu, 1 Dec 2022 15:42:35 -0800
Message-ID: <CAFCauYPGtUHyu+hjET97YnG+a3hraeGTaMeR=wUm8duKu=w7fw@mail.gmail.com>
Subject: Re: Feature proposal: support file content integrity verification
 based on fs-verity
To:     Gerry Liu <liuj97@gmail.com>
Cc:     Eric Biggers <ebiggers@google.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, fuse-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 1, 2022 at 1:51 AM Gerry Liu <liuj97@gmail.com> wrote:
>
>
>
> > 2022=E5=B9=B411=E6=9C=8829=E6=97=A5 08:44=EF=BC=8CVictor Hsieh <victorh=
sieh@google.com> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Thu, Nov 17, 2022 at 9:19 PM Gmail <liuj97@gmail.com> wrote:
> >>
> >> Hello fuse-devel,
> >>
> >> The fs-verity framework provides file content integrity verification s=
ervices for filesystems. Currently ext4/btrfs/f2fs has enabled support for =
fs-verity. Here I would like to propose implementing FUSE file content inte=
grity verification based on fs-verity.
> >>
> >> Our current main use case is to support integrity verification for con=
fidential containers using virtio-fs. With the new integrity verification f=
eature, we can ensure that files from virtio-fs are trusted and fs-verity r=
oot digests are available for remote attestation. The integrity verificatio=
n feature can also be used to support other FUSE based solutions.
> > I'd argue FUSE isn't the right layer for supporting fs-verity
> > verification.  The verification can happen in the read path of
> > virtio-fs (or any FUSE-based filesystem).  In fact, Android is already
> > doing this in "authfs" fully in userspace.
> Hi Victor,
> Thanks for your comments:)
>
> There=E2=80=99s a trust boundary problem here. There are two possible way=
s to verify data integrity:
> 1) verify data integrity in fuse kernel driver
> 2) verify data integrity in fuse server.
>
> For hardware TEE(Trusted Execution Environment) based confidential vm/con=
tainer with virtio-fs, the fuse server running on the host side is outside =
of trust domain, and the fuse driver is inside of trust domain. It is there=
fore recommended to verify data integrity in the fuse driver. The same situ=
ation may exist for fuse device based fuse server. The application trusts k=
ernel but doesn=E2=80=99t trust the fuse server.

It sounded like your case is similar to ours: the storage isn't
considered trusted (across the VM boundary).  Note that fs-verity can
only give you the consistent (and efficient) file measurement over the
file content.  If your storage is not trusted, you do have to ensure
the measurement of the *file paths* are the expected values, otherwise
the attacker can replace/rename one file with another.  For example,
the trusted process would have to know a mapping from file name to the
measurement, and check the measurement of the fs-verity-enabled files
before every open.   I can see how supporting fs-verity in virtio-fs
can be a stepping stone to solving your problem, but I'm not in a good
position to suggest whether it's a good idea or not.  But we did solve
our problem purely in userspace also using FUSE.

>
> Thanks,
> Gerry
>
> >
> > Although FUSE lacks the support of "unrestricted" ioctl, which makes
> > it impossible for the filesystem to receive the fs-verity ioctls.
> > Same to statx.  I think that's where we'd need a change in FUSE
> > protocol.
> >
> >>
> >> Fs-verity supports generating and verifying file content hash values. =
For the sake of simplicity, we may only support hash value verification of =
file content in the first stage, and enable support for hash value generati=
on in the later stage.
> >>
> >> The following FUSE protocol changes are therefore proposed to support =
fs-verity:
> >> 1) add flag =E2=80=9CFUSE_FS_VERITY=E2=80=9D to negotiate fs-verity su=
pport
> >> 2) add flag =E2=80=9CFUSE_ATTR_FSVERITY=E2=80=9D for fuse servers to m=
ark that inodes have associated fs-verity meta data.
> >> 3) add op =E2=80=9CFUSE_FSVERITY=E2=80=9D to get/set fs-verity descrip=
tor and hash values.
> >
> >>
> >> The FUSE protocol does not specify how fuse servers store fs-verity me=
tadata. The fuse server can store fs-verity metadata in its own ways.
> >>
> >> I did a quick prototype and the changes seems moderate, about 250 line=
s of code changes.
> >>
> >> Would love to hear about your feedback:)
> >>
> >> Thanks,
> >> Gerry
> >>
>
