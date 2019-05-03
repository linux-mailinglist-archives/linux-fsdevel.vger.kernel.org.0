Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAB28126B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 May 2019 06:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbfECEXp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 May 2019 00:23:45 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35953 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbfECEXo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 May 2019 00:23:44 -0400
Received: by mail-it1-f195.google.com with SMTP id v143so7194320itc.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 21:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vnLx+uU3nio/BlFRYLNOFf/f4mGQ9taOTqoUXxowcWo=;
        b=uFMdkq0xZEofeNPAcKh9JwaCjN56DXO/LiyJhoNSiaK37S2aj8kLGJJVpDj3s1YfHD
         LgNaf41u2RniKOMrYz6usEeNTsvIJyqEZHe0pXPBBMvRuGZUMVDA8u6QS5JLNO8lsVlU
         m6Ymkqh0wg0fHhV+KPO88cPhDUrOrO5uI8ablcd7S7IhWdpjXORoco6gj3kvSV4DSJRx
         Wdo6VNlW8ZnyzvRt3TyTC5tzSfcD5yoiLUTHTN5JaluyE9+mM8LrW6vuIq1LlFZsKQ6N
         vxqmjD9oVOLyYk+6o/hqh508k9sd1L5GlUyVXzOZKHeV8ajPvQat2TRyD40VFdllVpYo
         XKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vnLx+uU3nio/BlFRYLNOFf/f4mGQ9taOTqoUXxowcWo=;
        b=Y72/zv9LStUPutQtfh3LwUp59h0GWBtPz5vWgVysANadmC1r9kfoCNb8886edLi9aE
         tIJETuNZr8EUtl9+4EHwVAQuhCGDnR817FVNceIWkcCLMjniCgyxuvibxinDaUX86szM
         iO07spDJAk1+l+HpA+PVxEL5LW/ATezUilWZT3opB8QjSjlUlQhOjYCcF0bttnLhQRyP
         saazrPnb0z2uq3+5zWNHwrIg7nVpcu4CL0QtJAi5vKKTpz+g01zcwfgbWmMSBbhUI+Pd
         KfJ2Vrd51jUtR1yH5L6yET4GI3iVZBkBVH9q699XGKzgNT7Haf7pWWCFPNuIm8+qX6YZ
         ggWg==
X-Gm-Message-State: APjAAAXkCdsFGabaOPhiV/MeTfJ7lPPLG/64kR6If4AiUVNbioP2qDRM
        iPCyWs+UMTIEwp0lQh8dg5iPGS5i+QHJdIFojMmubUN/+Zzn
X-Google-Smtp-Source: APXvYqzgIpIkMsIhl0EDrQ5rqavot2LiFFy3UV4mYVs3WZZm6LwZTyDYXjyP/QWHasYh9ptzZg1fZBT7swmESUq7OUY=
X-Received: by 2002:a24:c685:: with SMTP id j127mr5754427itg.21.1556857423248;
 Thu, 02 May 2019 21:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
In-Reply-To: <20190502132623.GU23075@ZenIV.linux.org.uk>
From:   Eugene Zemtsov <ezemtsov@google.com>
Date:   Thu, 2 May 2019 21:23:31 -0700
Message-ID: <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>, tytso@mit.edu,
        Amir Goldstein <amir73il@gmail.com>, miklos@szeredi.hu,
        richard.weinberger@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 6:26 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Why not CODA, though, with local fs as cache?

On Thu, May 2, 2019 at 4:20 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> This sounds very useful.
>
> Why does it have to be a new special-purpose Linux virtual file?
> Why not FUSE, which is meant for this purpose?
> Those are things that you should explain when you are proposing a new
> filesystem,
> but I will answer for you - because FUSE page fault will incur high
> latency also after
> blocks are locally available in your backend store. Right?
>
> How about fscache support for FUSE then?
> You can even write your own fscache backend if the existing ones don't
> fit your needs for some reason.
>
> Piling logic into the kernel is not the answer.
> Adding the missing interfaces to the kernel is the answer.
>

Thanks for the interest and feedback. What I dreaded most was silence.

Probably I should have given a bit more details in the introductory email.
Important features we=E2=80=99re aiming for:

1. An attempt to read a missing data block gives a userspace data loader a
chance to fetch it. Once a block is loaded (in advance or after a page faul=
t)
it is saved into a local backing storage and following reads of the same bl=
ock
are done directly by the kernel. [Implemented]

2. Block level compression. It saves space on a device, while still allowin=
g
very granular loading and mapping. Less granular compression would trigger
loading of more data than absolutely necessary, and that=E2=80=99s the thin=
g we
want to avoid. [Implemented]

3. Block level integrity verification. The signature scheme is similar to
DMverity or fs-verity. In other words, each file has a Merkle tree with
crypto-digests of 4KB blocks. The root digest is signed with RSASSA or ECDS=
A.
Each time a data block is read digest is calculated and checked with the
Merkle tree, if the signature check fails the read operation fails as well.
Ideally I=E2=80=99d like to use fs-verity API for that. [Not implemented ye=
t.]

4. New files can be pushed into incremental-fs =E2=80=9Cexternally=E2=80=9D=
 when an app needs
a new resource or a binary. This is needed for situations when a new resour=
ce
or a new version of code is available, e.g. a user just changed the system
language to Spanish, or a developer rolled out an app update.
Things change over time and this means that we can=E2=80=99t just increment=
ally
load a precooked ext4 image and mount it via a loopback device.   [Implemen=
ted]

5. No need to support writes or file resizing. It eliminates a lot of
complexity.

Currently not all of these features are implemented yet, but they all will =
be
needed to achieve our goals:
 - Apps can be delivered incrementally without having to wait for extra dat=
a.
   At the same time given enough time the app can be downloaded fully witho=
ut
   having to keep a connection open after that.
- App=E2=80=99s integrity should be verifiable without having to read all i=
ts blocks.
- Local storage and battery need to be conserved.
- Apps binaries and resources can change over time.
   Such changes are triggered by external events.

I=E2=80=99d like to comment on proposed alternative solutions:

FUSE
We have a FUSE based prototype and though functional it turned out to be ba=
ttery
hungry and read performance leaving much to be desired.
Our measurements were roughly corresponding to results in the article
I link in PATCH 1 incrementalfs.rst

In this thread Amir Goldstein absolutely correctly pointed out that FUSE=E2=
=80=99s
constant overhead keeps hurting app=E2=80=99s performance even when all blo=
cks are
available locally. But not only that, FUSE needs to be involved with each
readdir() and stat() call. And to our surprise we learned that many apps do
directory traversals and stat()-s much more often that it seems reasonable.

Moreover, Android has a bit of a recent history with FUSE. A big chunk of
Android directory tree (=E2=80=9Cexternal storage=E2=80=9D) use to be mount=
ed via FUSE.
It didn=E2=80=99t turn out to be a great approach and it was eventually rep=
laced by
a kernel module.

I reckon the amount of changes that we=E2=80=99d need to introduce to FUSE =
in order
to make it support things mentioned above will be, to put it mildly,
very substantial. And having to be as generic as FUSE (i.e. support writes =
etc)
will make the task much more complicated than it is now.

Coda
Indeed it is somewhat similar to what we need. But according to Coda=E2=80=
=99s
documentation it fetches a whole file first time it is accessed,
which is opposite of what we need. It is not really obvious that adding all
the things above to Coda would be simpler than creating a separate driver.
Especially if Coda needs to keep supporting all of its existing features.

userfaultfd
As far as I can see this would only work for mmap-ed files.
All read() and readdir() calls would never return right results.




--=20
Thanks,
Eugene Zemtsov.
