Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53000180D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 22:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfEHUKJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 16:10:09 -0400
Received: from mail-it1-f178.google.com ([209.85.166.178]:51350 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfEHUKJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 16:10:09 -0400
Received: by mail-it1-f178.google.com with SMTP id s3so6241799itk.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 May 2019 13:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vx8Ow06kq29IlKUgtcX/TbYg2KMhAxUkXiBjxkCvUeg=;
        b=PpErFxB7TnTclCLCVzWY6V6Fx2wmr0USRSvTi9VzKXuXdFNW1530XYlXtiQC9UDnfy
         jPOnaTSR07YWLghR3XeSRF2bKDMkyfPoaF1V8A/cCeek5jbyu2ufU3xq3NBjpLrlskew
         j0+NpmL1lKdnJd867tcxk+AzanK/dCnB0KksqF05U/fTsxBPUgy5zHvbE0DHYxslv4iV
         EqxdoXi2N7jStgh/a0cCgYLsa3lholEaQoUt/r/5h+gmuCIZTxyu8A+aq1AprJvlI8mD
         y/YSxDLDf/U6jQCmI0Rnlc3JotFrCxhfmHTQiuz3vJkFL+CsVhQj9gBXZwvyl4GcM5wa
         vYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vx8Ow06kq29IlKUgtcX/TbYg2KMhAxUkXiBjxkCvUeg=;
        b=B/fxe9dfoetIoBP2KmMaB1P+qA7OEsHdG19DSakqTL6jalOjyZ01UC3FJMI0sz4+um
         3PUUkCULLgpeKpdhnzqOOfPYGIOsTBuNZlfQAxBgmdksNJx+CwfuAO86yrKJ+9kC5SpZ
         ae0tWDoOOR++jThP2I/MDPaKYpBZDYxojSQa5imQ2fEckRvZek9K8zHkh8G+HcXiAW7S
         cre0zkPLsarIz9HglTd1oICSM+2cxqF8kg3IE0nCufxJ+zqRatHopPFsT1mh+eXtvxn8
         o3PO96nNH9HOhKZ48mPKmJxC+4osAgP73dwsszkULMpmsxmDvgscWWReEwilYk0CKPUj
         kwzA==
X-Gm-Message-State: APjAAAW294IJ3q8tmThPvkaUSYOBH3W2kcx9dsvmJbRmAZTSrNUG45L9
        kA4yAyhza0KaIkpiZbmGJtiUsph2szDZ98pp4Vf2
X-Google-Smtp-Source: APXvYqzaTRdxrVcnUjee2nV403JUqIlr8cnQC8HK75JUJYyp9TpQlUf/FAuc5UldLUfnINFjYN23PHBssyLX8/CbBfQ=
X-Received: by 2002:a24:f584:: with SMTP id k126mr5260248ith.31.1557346207755;
 Wed, 08 May 2019 13:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com> <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
From:   Eugene Zemtsov <ezemtsov@google.com>
Date:   Wed, 8 May 2019 13:09:56 -0700
Message-ID: <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Amir Goldstein <amir73il@gmail.com>
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

> This really sounds to me like the properties of a network filesystem
> with local cache. It seems that you did a thorough research, but
> I am not sure that you examined the fscache option properly.
> Remember, if an existing module does not meet your needs,
> it does not mean that creating a new module is the right answer.
> It may be that extending an existing module is something that
> everyone, including yourself will benefit from.

> I am sure you can come up with caching policy that will meet your needs
> and AFAIK FUSE protocol supports invalidating cache entries from server
> (i.e. on "external" changes).

You=E2=80=99re right. On a very high level it looks quite plausible that in=
cfs can be
replaced by a combination of
1. fscache interface change to accomodate compression, hashes etc
2. a new fscache backend
3. a FUSE change, that would allow FUSE to load data to fscache and server =
data
    from directly fscache.

After it is all done, FUSE and fscache will have more features and support =
more
use cases for years to come. But this approach is not without
tradeoffs, features
increase support burden and FUSE interface changes are almost
impossible to deprecate.

On the other hand we have a simple self-contained module, which handles
incremental app loading for Android. All in all, incfs currently has
about 6KLOC,
where only 3.5KLOC is actual kernel code. It is not likely to be used =E2=
=80=9Cas is=E2=80=9D
for other purposes, but it doesn=E2=80=99t increase already significant com=
plexity of
fscache, FUSE, and VFS. People working with those components won=E2=80=99t =
need to fret
about extra hooks and corner cases created for incremental app loading.
If for some reason incfs doesn=E2=80=99t gain wide adoption, it can be rela=
tively
painlessly removed from the kernel.

Having a standalone module is very important for me on a yet another level.
It helps in porting it to older kernels. Patches scattered across fs/ subst=
ree
will be less portable and self contained. (BTW this is the reason to have
a version file in sysfs - new versions of incfs can be backported to
older kernels.)

Hopefully this will clarify why I think that VFS interface is the right bou=
ndary
for incremental-fs. It is sufficiently low-level to achieve all
goals of incremental app loading, but at the same time sufficiently isolate=
d
not to meddle with the rest of the kernel.

Thoughts?

Thanks,
Eugene.
