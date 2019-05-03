Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 236621270F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 07:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfECFUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 01:20:01 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45832 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbfECFUB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 01:20:01 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so3386425ywa.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 22:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fkhRwXX5VvF4TygeZMoOxCa8yLo6jNah2uGHNM0OfHw=;
        b=RkIocCnNk7Pl2zdEnqkp5wDYZ+ifM/luRvwNa/AVqqY7LDJFQmwn0fVrUDpPL5af2q
         PYeFYcM9u7ibjR0rPx9AfYXzOTC8JQNMcFGsRLcor94EMZc9j7v80y7BXaAyVLJVVc25
         6pRZtfOX8B0/XkyAorAtxp0cURpzNnO4/JME4BrvKInDirTt78arb7dFysU//2Hm2bUC
         36uOcp5z6+0TUcH+ZE8jTFKYYKDT2OZvtuXGwyUfXR+nvtFolLqM9+ph/eHgcwTDubes
         PY9397oGQlI1clXp61btxwfDyxo0Fv0N1Ifa3rN1FZPQd3NGdvsgTGsh0QO699BsBXuT
         UN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fkhRwXX5VvF4TygeZMoOxCa8yLo6jNah2uGHNM0OfHw=;
        b=Vn/2zdWuNKQWQUx1WkByUgPSj++MedxWo3U+JKqN0A/p2ZAauIUeeApmLsl1QeZ36/
         4yrUmUBwfZjYw95iz7Vu6e3kkudrfUcoDXwP7RS8hHEJ2N4t1Nq7WOi0j7Iq/DPcAO+s
         lio0XfjZa0TNshqF6RgeMAu7IhouJb8JBLjWp6J+cvvpXfggBjXOBWIj6Drj0CZLF4Ts
         58Od5clEowRcaaIv7cJIoeGm/5Xe1Zl6e27Y/6dLP0h1SuMvC2qMWoTZnn2iDtDqmVMg
         Nd5T0oDPdnlOq5JPaR3GlXlhuVGfbUlKpQq18LsPXKBuS2hms51fRQ+Xb4Qt/f++9N0D
         hQqQ==
X-Gm-Message-State: APjAAAUUNnaf+K5aB9fL4ruoGWCsegDDoupEkQ3W8wd5cm2K2ZnonC7r
        W9xuOtzHHELWX7VdUU0CcEwJMoIDJykeI8hNvbzUOvPS
X-Google-Smtp-Source: APXvYqw0lNiQSHhZjo2+zuw79wwB92voenTYqxPEZl/HOo/zLwnLlTjPv/GBvlrfM5F1ucAHPiGUhAm9/kMlFmIdgm8=
X-Received: by 2002:a0d:ff82:: with SMTP id p124mr6685317ywf.409.1556860800145;
 Thu, 02 May 2019 22:20:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk> <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
In-Reply-To: <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 3 May 2019 01:19:48 -0400
Message-ID: <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Eugene Zemtsov <ezemtsov@google.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Tso <tytso@mit.edu>,
        Miklos Szeredi <miklos@szeredi.hu>,
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

This really sounds to me like the properties of a network filesystem
with local cache. It seems that you did a thorough research, but
I am not sure that you examined the fscache option properly.
Remember, if an existing module does not meet your needs,
it does not mean that creating a new module is the right answer.
It may be that extending an existing module is something that
everyone, including yourself will benefit from.

> I=E2=80=99d like to comment on proposed alternative solutions:
>
> FUSE
> We have a FUSE based prototype and though functional it turned out to be =
battery
> hungry and read performance leaving much to be desired.
> Our measurements were roughly corresponding to results in the article
> I link in PATCH 1 incrementalfs.rst
>
> In this thread Amir Goldstein absolutely correctly pointed out that FUSE=
=E2=80=99s
> constant overhead keeps hurting app=E2=80=99s performance even when all b=
locks are
> available locally. But not only that, FUSE needs to be involved with each
> readdir() and stat() call. And to our surprise we learned that many apps =
do
> directory traversals and stat()-s much more often that it seems reasonabl=
e.
>

That is a real problem. Alas readdir cache, recently added probably solves
your problem since your directory changes are infrequent.
stat cache also exists, but will be used depending on policy of mount optio=
ns.
I am sure you can come up with caching policy that will meet your needs
and AFAIK FUSE protocol supports invalidating cache entries from server
(i.e. on "external" changes).

> Moreover, Android has a bit of a recent history with FUSE. A big chunk of
> Android directory tree (=E2=80=9Cexternal storage=E2=80=9D) use to be mou=
nted via FUSE.
> It didn=E2=80=99t turn out to be a great approach and it was eventually r=
eplaced by
> a kernel module.
>

I am aware of that history.
I suspect the decision to write sdcardfs followed similar logic to the one
that has lead you to write incfs.

> I reckon the amount of changes that we=E2=80=99d need to introduce to FUS=
E in order
> to make it support things mentioned above will be, to put it mildly,
> very substantial. And having to be as generic as FUSE (i.e. support write=
s etc)
> will make the task much more complicated than it is now.
>

Maybe. We won't know until you explore this option. Will we?

Thanks,
Amir.
