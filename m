Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64574A36E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jul 2023 19:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjGFRtT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Jul 2023 13:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjGFRtS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:49:18 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1C41994;
        Thu,  6 Jul 2023 10:49:17 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-44523d9fd18so240874137.0;
        Thu, 06 Jul 2023 10:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688665756; x=1691257756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r7YVAvRgBwLU7VNNwMWt+QDw4y422q60OVOAo7u9pOs=;
        b=scReaXK2EFyHrPuAAGDOm6MpiHph8fwS+r4Ddbll9B3Qni8YRGy393VlY7N/3oOKgh
         EVcOBP/S0joD0zd16zBAGjd0dql8H/yUsBRW7FTZgozQLFowEskbufCIbjgBOg5a2bqE
         eJfUlvkOU9u8+/TNvXJeRHf0A5MokHGkdRXB0eaWsgUnHpP9uFAKB2qEfNdoBHnUfWPp
         GmEPZEZG+pq5dDqnsTGMlS5R9qmABAc9rIAHo0jXA9sB4GHzhTs+cN+RlLgb6V/IOVGw
         EMNZDBUolZmRghKHMoxLMMfGtiURW7B633Xjtff9pgt6ynAbg4DwuuQ6/5B9O0eLXTas
         nbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665756; x=1691257756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7YVAvRgBwLU7VNNwMWt+QDw4y422q60OVOAo7u9pOs=;
        b=euD11F1ACDQykFUVHemkSM7RlZ23rDO+8gLkXFlbSFKHYu2xe9QOGnbtvoqX+4cNFZ
         TabHgO52WMaT+6FCCeWfgIx0GsL/fr7M4B0pKV2Fq6qoWeYI8gR54UUOMGNUh9g42CDI
         fsOq7rCJRUZzyNBKISj7LJ637kT3DQg6pCtNE3L9VBWXcUk+ywnUUnPQ1aSAq3gMprEC
         gWPTsH1PoPJ7c+GTcumkk5yIogX3Ub6kwDSOCjt3Sl96FPZYZGTvwrReKKfNwVeYuBU/
         zipV0/h6yDR7W8KSW0LJJT6BuvRYi9avEiAs8tCkO/UZuVJUy23YBnPCoADi8R33Rgmm
         RACQ==
X-Gm-Message-State: ABy/qLZ7ofZ8OFRXGElmB7SMzlhwifeyb3qHM6eqdc12EVGDVWuCcV52
        2bahdhoYgLXSzAUvVeFlEuskKSZPpywzxQjlUPg=
X-Google-Smtp-Source: APBJJlFemOouqmN0uw4a9jmKiaVfqXFICB31VE/qNSt1sixAY+4Gc3eKenyPpqGoElIzTAxRfJp5bBHsgvgz/Ia+2EM=
X-Received: by 2002:a67:e889:0:b0:445:110:acce with SMTP id
 x9-20020a67e889000000b004450110accemr1253493vsn.14.1688665756578; Thu, 06 Jul
 2023 10:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230425132223.2608226-1-amir73il@gmail.com> <20230425132223.2608226-4-amir73il@gmail.com>
 <CAOQ4uxgX0Tx07q2gAzsB2kPsUm+MjsYw9BG4W7-h8ODNnqH_1A@mail.gmail.com> <CAOQ4uxhh6fh8spdBSxaPQCMK8OKGLjvi=JvwAM0J9vZaEeAgZg@mail.gmail.com>
In-Reply-To: <CAOQ4uxhh6fh8spdBSxaPQCMK8OKGLjvi=JvwAM0J9vZaEeAgZg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 6 Jul 2023 20:49:05 +0300
Message-ID: <CAOQ4uxgfTTQ5VAYTrQw0jkFVhiBRvTZ7hL9HU1MoPSCDCd_p6g@mail.gmail.com>
Subject: Re: [RFC][PATCH 3/3] ovl: use persistent s_uuid with index=on
To:     Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <brauner@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
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

On Thu, Jul 6, 2023 at 1:14=E2=80=AFPM Amir Goldstein <amir73il@gmail.com> =
wrote:
>
> On Thu, Jul 6, 2023 at 10:19=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Tue, Apr 25, 2023 at 4:22=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > With index=3Don, overlayfs instances are non-migratable, meaning that
> > > the layers cannot be copied without breaking the index.
> > >
> > > So when indexdir exists, store a persistent uuid in xattr on the
> > > indexdir to give the overlayfs instance a persistent identifier.
> > >
> > > This also makes f_fsid persistent and more reliable for reporting
> > > fid info in fanotify events.
> > >
> > > With mount option uuid=3Dnogen, a persistent uuid is not be initializ=
ed
> > > on indexdir, but if a persistent uuid already exists, it will be used=
.
> > >
> >
> > This behavior (along with the grammatical mistakes) was changed in
> > https://github.com/amir73il/linux/commits/ovl_encode_fid
> >
> > uuid=3Doff or uuid=3Dnull both set ovl fsid to null regardless of persi=
stent
> > uuid xattr.
> >
>
> Sorry, that was meant to say "set ovl uuid to null..."
> when ovl uuid is null then ovl fsid is not null, it is the fsid of the
> uppermost fs.
>
> This creates a dilemma wrt backward compat.
>
> With index=3Doff, the mounter has a choice between two sub-optimal option=
s:
> 1. persistent ovl fsid (of upper fs)
> 2. unique ovl fsid (from random uuid)
>
> If we change the default from legacy (1) to unique (2), that
> could also break systems that rely on the persistent ovl fsid
> of existing overlayfs layers.
>
> With index=3Don, the choice is between:
> 1. persistent ovl fsid (of upper fs)
> 2. persistent and unique ovl fsid (from uuid xattr)
>
> option (2) is superior, but still could break existing systems
> that rely on (1) being persistent.
>
> The decision to tie uuid xattr to the index dir and index=3Don
> was rationalized in the commit message, but persistent and
> unique fsid could also be implemented regardless of index=3Don.
>
> I think I may have found a dignified way out of this mess:
> - In ovl_fill_super(), check impure xattr on upper root dir
> - If impure xattr does not exist (very likely new overlay),
>   uuid_gen() and write the persistent uuid xattr on upper fs root
> - If uuid xattr is written or already exists, use that to initialize
>   s_uuid otherwise, leave it null
> - in ovl_statfs(), override the upper fs fsid, only if ovl uuid is non-nu=
ll
>
> This gives:
> 1. Old overlayfs deployments retain old behavior wrt null uuid
>     and upper fsid, as long as they have had at least one subdir
>     of root copied up or looked up to trigger ovl_fix_origin()
> 2. New overlayfs deployments always generate and use a unique
>     and persistent uuid/fsid
> 3. mount option uuid=3Doff/null (*) can be used to retain legacy behavior
>     on old/new overlayfs deployments (for whatever reason) and ignore
>     existing persistent uuid xattr
> 4. mount option uuid=3Don can be used to force new behavior on an
>     existing overlayfs with impure xattr and without uuid xattr
>
> (*) uuid=3Doff was originally introduced for the use case of copied layer=
s.
>      That is similar to the use case of copying disk images and dropping
>      the old persistent ovl uuid makes sense in that case.
>
> I will try to write this up.
>

OK, this is what I got in overlayfs.rst:

UUID and fsid
-------------

The UUID of overlayfs instance itself and the fsid reported by statfs(2) ar=
e
controlled by the "uuid" mount option, which supports these values:

- "null":
    UUID of overlayfs in null, fsid is taken from upper most fs.
- "off":
    UUID of overlayfs in null, fsid is taken from upper most fs
    and UUID of underlying layers not checked.
- "on":
    UUID of overlayfs in generated on first mount used to report a unique f=
sid.
    If upper filesystem supports xattrs, the UUID is stored in xattr
    "trusted.overlay.uuid", making the fsid unique and persistent.
- "auto": (default)
    Upgrade to "uuid=3Don" on first time mount of new overlay filesystem.
    Downgrade to "uuid=3Dnull" for existing overlay filesystems that were n=
ever
    mounted with "uuid=3Don".

Pushed to:
https://github.com/amir73il/linux/commits/ovl_encode_fid

Will post next week.

Thanks,
Amir.
