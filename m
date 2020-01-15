Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCC713C0C4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 13:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgAOMZg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 07:25:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57379 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725999AbgAOMZg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:25:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579091135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PI0QRbr/5VKrwHwE93jKdI5pwAAjlZX4i/K/trVsUfI=;
        b=KgftPVg9o9dTICXw6HU9uQa3Mr2d55N2UsSSSu+ke/ZMbmTFWurGO5zLelKpv2cwQ3U1xf
        cAijVsMsg9JOTqmfb4qTuSN61L1XZ6RNIUgFq/d9yQUB5UN9ODKt/zqNMLTvQIYOtW3mYX
        543nDEFhqtqK+6GRl3HkRW33yxiBZFY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-vQzU-JGYMDytEpCEOmgltA-1; Wed, 15 Jan 2020 07:25:29 -0500
X-MC-Unique: vQzU-JGYMDytEpCEOmgltA-1
Received: by mail-qv1-f71.google.com with SMTP id v5so10881296qvn.21
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2020 04:25:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PI0QRbr/5VKrwHwE93jKdI5pwAAjlZX4i/K/trVsUfI=;
        b=ZR/WGhiMmENeXPQYu3HSySwiDFXA+v00TRWr1neqYrPvXGufccyflN+XXkC9TuSDq7
         38OfEikEjN4KgFvxFVnvG9kVTAaUw7i3XMbIYdDxiRjqIo2ou4/5wjMG1RfXr10bwURR
         1ho8qgu1gp4WAN+sv235I7OeWXQJ2gXoItZGTgkpks6eO7qebOEpwOqL/C/gLPEi4+mN
         yOlGGLgm7hJp8c8hl5nSAbBIIMK0m9jIUchmctoNgcJcRyNyJ77BL+Iaf6ee6bQIN2tX
         qohMYVs7req0Zso++e1lnkQUD4/7XlkVAdUgG9YovrXm0Iezyxzy/UIquJ42BPZe2C01
         INTg==
X-Gm-Message-State: APjAAAVJYPCEuf11BJ034oJk6iAqBzR8ZkbAMSTwHD8U9bdkplrwoNpC
        RLny+9LfdSza1nCXMPTzu4s/EmWDwObPHhhCnQU0v7aeLrDqMKEQu2NZYATKQBJ/w+vz1/mFyOT
        NMY2aHRp41x4jnW27+foPVe1+tBE30ekTCvPl+j96mg==
X-Received: by 2002:a0c:ebcf:: with SMTP id k15mr21816663qvq.217.1579091129201;
        Wed, 15 Jan 2020 04:25:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqywg4Dwk6LSH+pCUFRInEpp5m+ZKTnMon819OPgB204hdyu/8nXMjCah5hpZdkB9mKU8NcvSepeR2cVd4D83w4=
X-Received: by 2002:a0c:ebcf:: with SMTP id k15mr21816639qvq.217.1579091128879;
 Wed, 15 Jan 2020 04:25:28 -0800 (PST)
MIME-Version: 1.0
References: <CA+wuGHCr2zJKFkHyRECOLAXsijLAcQgHVoACcNbvLbXnqarOtg@mail.gmail.com>
 <CAJfpegsECDNeL0FmaB=BsYdYrmZSLpG5etvwhW5uQWGJJjODeg@mail.gmail.com>
In-Reply-To: <CAJfpegsECDNeL0FmaB=BsYdYrmZSLpG5etvwhW5uQWGJJjODeg@mail.gmail.com>
From:   Ondrej Holy <oholy@redhat.com>
Date:   Wed, 15 Jan 2020 13:24:52 +0100
Message-ID: <CA+wuGHBV=YH5-bnNZvZSMzB+Tt0VyuEKFUZV8d_Htptxp3=_eQ@mail.gmail.com>
Subject: Re: Weird fuse_operations.read calls with Linux 5.4
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

st 15. 1. 2020 v 12:41 odes=C3=ADlatel Miklos Szeredi <miklos@szeredi.hu> n=
apsal:
>
> On Wed, Jan 15, 2020 at 9:28 AM Ondrej Holy <oholy@redhat.com> wrote:
> >
> > Hi,
> >
> > I have been directed here from https://github.com/libfuse/libfuse/issue=
s/488.
> >
> > My issue is that with Linux Kernel 5.4, one read kernel call (e.g.
> > made by cat tool) triggers two fuse_operations.read executions and in
> > both cases with 0 offset even though that first read successfully
> > returned some bytes.
> >
> > For gvfs, it leads to redundant I/O operations, or to "Operation not
> > supported" errors if seeking is not supported. This doesn't happen
> > with Linux 5.3. Any idea what is wrong here?
> >
> > $ strace cat /run/user/1000/gvfs/ftp\:host\=3Dserver\,user\=3Duser/foo
> > ...
> > openat(AT_FDCWD, "/run/user/1000/gvfs/ftp:host=3Dserver,user=3Duser/foo=
",
>
> Hi, I'm trying to reproduce this on fedora30, but even failing to get
> that "cat" to work.  I've  replaced "server" with a public ftp server,
> but it's not even getting to the ftp backend.  Is there a trick to
> enable the ftp backend?  Haven't found the answer by googling...

Hi Miklos,

you need gvfs and gvfs-fuse packages installed. Then it should be
enough to mount some share, e.g. over Nautilus, or using just "gio
mount ftp://user@server/". Once some share is mounted, then you should
see it in /run/user/$UID/gvfs. I can reproduce on Fedora 31 with
kernel-5.4.10-200.fc31.x86_64, whereas kernel-5.3.16-300.fc31.x86_64
works without any issues.

Thanks

Ondrej

>
> Thanks,
> Miklos
>
>
> > O_RDONLY) =3D 3
> > fstat(3, {st_mode=3DS_IFREG|0644, st_size=3D20, ...}) =3D 0
> > fadvise64(3, 0, 0, POSIX_FADV_SEQUENTIAL) =3D 0
> > mmap(NULL, 139264, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
> > -1, 0) =3D 0x7fbc42b92000
> > read(3, 0x7fbc42b93000, 131072)         =3D -1 EOPNOTSUPP (Operation no=
t
> > supported)
> > ...
> >
> > $ /usr/libexec/gvfsd-fuse /run/user/1000/gvfs -d
> > ...
> > open flags: 0x8000 /ftp:host=3Dserver,user=3Duser/foo
> >    open[139679517117488] flags: 0x8000 /ftp:host=3Dserver,user=3Duser/f=
oo
> >    unique: 8, success, outsize: 32
> > unique: 10, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
> > read[139679517117488] 4096 bytes from 0 flags: 0x8000
> >    read[139679517117488] 20 bytes from 0
> >    unique: 10, success, outsize: 36
> > unique: 12, opcode: READ (15), nodeid: 3, insize: 80, pid: 5053
> > read[139679517117488] 4096 bytes from 0 flags: 0x8000
> >    unique: 12, error: -95 (Operation not supported), outsize: 16
> > ...
> >
> > See for other information: https://gitlab.gnome.org/GNOME/gvfs/issues/4=
41
> >
> > Regards
> >
> > Ondrej
> > --
> > Ondrej Holy
> > Software Engineer, Core Desktop Development
> > Red Hat Czech s.r.o
> >
>

