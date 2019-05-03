Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8144D12B65
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfECKWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 06:22:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:53967 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfECKWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 06:22:35 -0400
Received: by mail-it1-f196.google.com with SMTP id l10so8273075iti.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 May 2019 03:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VjUhbGYdk5HyD+TPNbe1DDJt7WebT22zMXkQpphMRFk=;
        b=W/YbZTHUl6PWQNJ/7s4tJzivtGtC4JQ/8BJ38NTbrorrQdlfDtCOCg7jJ4J3mwcSH7
         WzWwC4ssuZlwnKbmhylxRK6XckgjI98hkUajMQtbUDlDouzAEo9Ply96AtFDTiMp/3DT
         4cpMGBTquCLhj8+tkSUIJUj6miMN1YUrep+UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VjUhbGYdk5HyD+TPNbe1DDJt7WebT22zMXkQpphMRFk=;
        b=Yio9rishfUS0ZugMP3P57pHNo90B09dVVREXnNE9HWRqXuDRWcubsdrywYHaLtezsX
         /ayaE1wjG6zId62bjbZQGaF7BRzb0H3CPr86WTiXi4X7NqcdM8rq60X3u42XvIMb8r5B
         1w3C3Jf0Qlg89GvmCakyBmH0vL+hZAunLocc7f2EkWB9tinbnFPeoHa7Rmeaw5HCK7xO
         DX9rgj1CMR67Oab7CsciVezG6s2ycp0GM6KhDPKRmfnE69dnTEJf4FQHOxzKKZrUGgUu
         rQlQH2SlBnHo0R2fpboV5Yb5xp4LdLJcURJRYnEYLZkJNwGNtNKncZozpHzdHFMspM2K
         PQmw==
X-Gm-Message-State: APjAAAWFcuPXsih/iwdtyVK62m8YSdCLkybXUNbdaxNa+MsoInNyvrx0
        xFgIDJvwbWj3Fm9Vdf4PN+DfVIDTy+3TrLFAKYLZjQ==
X-Google-Smtp-Source: APXvYqzSYmJJWfSAs/VdOy679mHDicjy3333s64nPOIl3QimprPBJ7WhMSDtvC76ZHPuhU7t8gSXPa35d7RaWxYhRBA=
X-Received: by 2002:a02:c043:: with SMTP id u3mr6319174jam.35.1556878954376;
 Fri, 03 May 2019 03:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk> <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
In-Reply-To: <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 3 May 2019 06:22:23 -0400
Message-ID: <CAJfpeguyajzHwhae=4PWLF4CUBorwFWeybO-xX6UBD2Ekg81fg@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Eugene Zemtsov <ezemtsov@google.com>
Cc:     linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Amir Goldstein <amir73il@gmail.com>,
        Richard Weinberger <richard.weinberger@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 3, 2019 at 12:23 AM Eugene Zemtsov <ezemtsov@google.com> wrote:
>
> On Thu, May 2, 2019 at 6:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > Why not CODA, though, with local fs as cache?
>
> On Thu, May 2, 2019 at 4:20 AM Amir Goldstein <amir73il@gmail.com> wrote:
> >
> > This sounds very useful.
> >
> > Why does it have to be a new special-purpose Linux virtual file?
> > Why not FUSE, which is meant for this purpose?
> > Those are things that you should explain when you are proposing a new
> > filesystem,
> > but I will answer for you - because FUSE page fault will incur high
> > latency also after
> > blocks are locally available in your backend store. Right?
> >
> > How about fscache support for FUSE then?
> > You can even write your own fscache backend if the existing ones don't
> > fit your needs for some reason.
> >
> > Piling logic into the kernel is not the answer.
> > Adding the missing interfaces to the kernel is the answer.
> >
>
> Thanks for the interest and feedback. What I dreaded most was silence.
>
> Probably I should have given a bit more details in the introductory email=
.
> Important features we=E2=80=99re aiming for:
>
> 1. An attempt to read a missing data block gives a userspace data loader =
a
> chance to fetch it. Once a block is loaded (in advance or after a page fa=
ult)
> it is saved into a local backing storage and following reads of the same =
block
> are done directly by the kernel. [Implemented]
>
> 2. Block level compression. It saves space on a device, while still allow=
ing
> very granular loading and mapping. Less granular compression would trigge=
r
> loading of more data than absolutely necessary, and that=E2=80=99s the th=
ing we
> want to avoid. [Implemented]
>
> 3. Block level integrity verification. The signature scheme is similar to
> DMverity or fs-verity. In other words, each file has a Merkle tree with
> crypto-digests of 4KB blocks. The root digest is signed with RSASSA or EC=
DSA.
> Each time a data block is read digest is calculated and checked with the
> Merkle tree, if the signature check fails the read operation fails as wel=
l.
> Ideally I=E2=80=99d like to use fs-verity API for that. [Not implemented =
yet.]
>
> 4. New files can be pushed into incremental-fs =E2=80=9Cexternally=E2=80=
=9D when an app needs
> a new resource or a binary. This is needed for situations when a new reso=
urce
> or a new version of code is available, e.g. a user just changed the syste=
m
> language to Spanish, or a developer rolled out an app update.
> Things change over time and this means that we can=E2=80=99t just increme=
ntally
> load a precooked ext4 image and mount it via a loopback device.   [Implem=
ented]
>
> 5. No need to support writes or file resizing. It eliminates a lot of
> complexity.
>
> Currently not all of these features are implemented yet, but they all wil=
l be
> needed to achieve our goals:
>  - Apps can be delivered incrementally without having to wait for extra d=
ata.
>    At the same time given enough time the app can be downloaded fully wit=
hout
>    having to keep a connection open after that.
> - App=E2=80=99s integrity should be verifiable without having to read all=
 its blocks.
> - Local storage and battery need to be conserved.
> - Apps binaries and resources can change over time.
>    Such changes are triggered by external events.
>

Good summary.  I understand the requirements better now.

I still have issues with this design, because it looks very android
specific.  For example I know that lazy download  is something
actually being heavily used by distributed computing (see cernvm-fs)
so it's not a specific requirement of android.   By bundling these
features together into a kernel module you are basically limiting the
user base and hence possibly missing out on some of the advantages of
having a more varied user base.

I wonder how much of the performance issues with the fuse prototype
was because of 4k reads/disabling re adahead?   I know you require
that for the data loading part, but it would be trivial to turn that
behavior off once everything is in place.   Does the prototype do
that?  Have you tried doing that?  Is the prototype in a good enough
shape to perhaps move it to a public repository for review?

I'm also wondering about some of the features you describle above.
Why a new block fs?  A normal fs (ext4) provides most of those things:
you can add files to it, etc...  The one thing it doesn't provide is
compression, and that's because it's hard for the non-incremental
case.   So do we really need a new disk format for this?  Or can the
missing compression feature (perhaps with limits) be implemented in
ext4/f2fs?  In that case we even can take that work off of fuse and
just leave the loading to the fuse part. Cernvm-fs does that with a
fuse fs on the lower layer that does  lazy downloading, and putting
already downloaded files in an upper layer of overlayfs for faster
access, but it's possible that there's a better way of doing that not
involving even overlayfs.

Thanks,
Miklos
