Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5802F6D39E0
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Apr 2023 20:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDBSoF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Apr 2023 14:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbjDBSnw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:43:52 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C01718;
        Sun,  2 Apr 2023 11:43:26 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-54184571389so513448597b3.4;
        Sun, 02 Apr 2023 11:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680461006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUW9fSfZ9WSxLfrodIgM+aOE7jHgfxvaZXXJmIaxf8g=;
        b=ptflmDGIVSxSjntbxtd8TUNVb0kGjb1LlCnZnl5mMNzHc44nN8aepzjh1JDNfhVZvX
         vTDeOKs4E9J99oGfn9AXiN/EEXH8VS5kRcJtuNBiP3CfXHfgw3cMwz6/5yD1FxcsX4Ns
         5jXnLG1MKqMt65DCJ4DjkV4FRvqiScI773Q4+SSECTuvRaiELHsD3E02JuysfpYmfGJN
         xba9OxlWSi6Cp+t9Yy0MTxXj+yDCTTD8IH4iZUSlqwqsulkOlAGznXClcPMiQIiiz256
         IX0nesjbJQ6yF0OYfuAAYUoPLWNBbuskZYhpj/JBbAU396I/CXqqaacsI0NG4jPvPozx
         Zerw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680461006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUW9fSfZ9WSxLfrodIgM+aOE7jHgfxvaZXXJmIaxf8g=;
        b=ENVTUBSHHmODQQU+TsV/xGXTJ6FzJ5HeHRLWBswyXxV4tfvX9fxBOLv6Wo2buB6KF5
         CMLO6Q1yYLw6KO4H/FLBj90tJU97ZZJLUkeBqVSStDm3TDCkVvGKv0ITIjnBCox6wiME
         mg42jhpK1kS7GzFUlUUyJdy7sQ6QSAqvvs0duWv3LgjnqpTXgyPJsdKyLDPf2tL2mLHn
         HSp/tHxCllFTvHx0Vl2Tff9ODV4iG5Zb2RF0KhvqHEmqYiw9wJrXhO/syEU/+8lCqcCE
         7jH7O0ZyBQwI7+m5Oo2LqitgS1KgpWCOq1pI9JKjoA+Pkl96dYL5RvEeML1lrUh7NO0/
         7Yrg==
X-Gm-Message-State: AAQBX9cHSLhHnfQaepdx9xy+j+QV/kQYIUyCFqkEoy4Yx3r7Tf4oslck
        wwR4FM0w9vbWrfecxRk5WbQSCfVCmxblFaUKx12YtwUk
X-Google-Smtp-Source: AKy350bEMmEd30W+V6mQNUMFBXrO4+YVMjC//cSozDEfHpe32PMMT7xldWA+YEFW5ZOhOQpEdX04L1ne8Dbikl0bh0w=
X-Received: by 2002:a81:b617:0:b0:541:7f69:aa8b with SMTP id
 u23-20020a81b617000000b005417f69aa8bmr16184588ywh.5.1680461005529; Sun, 02
 Apr 2023 11:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <ZCEIEKC0s/MFReT0@7e9e31583646> <3443961.DhAEVoPbTG@silver>
 <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com> <5898218.pUKYPoVZaQ@silver>
In-Reply-To: <5898218.pUKYPoVZaQ@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Sun, 2 Apr 2023 13:43:14 -0500
Message-ID: <CAFkjPTm-6D=OzF7J-1eEb=UVst7L2gjb07oA2hfv7Ayf5QuOvg@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net, asmadeus@codewreck.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Apr 2, 2023 at 9:07=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> +CC: Jeff for experience on this caching issue with NFS ...
>
> On Tuesday, March 28, 2023 5:51:51 PM CEST Eric Van Hensbergen wrote:
> > As I work through the documentation rework and to some extent the
> > testing matrix -- I am reconsidering some choices and wanted to open
> > up the discussion here.
> >
> > TLDR; I'm thinking of reworking the cache options before the merge
> > window to keep things simple while setting up for some of the future
> > options.
>
> Yeah, revising the 9p cache options highly makes sense!
>
> So what is the plan on this now? I saw you sent a new patch with the "old=
"
> options today? So is this one here deferred?
>

Yes - I decided to just bite the bullet and try and have a new
approach to things that was less confusing and try and reduce the test
matrix.
Unfortunately, I was also switching over to trying to use b4 to manage
these things and didn't see a way to relate the patch to the original
one.
I figured the increase in scope justified a new thread.

> > While we have a bunch of new options, in practice I expect users to
> > probably consolidate around three models: no caching, tight caches,
> > and expiring caches with fscache being an orthogonal add-on to the
> > last two.
>
> Actually as of today I don't know why somebody would want to use fscache
> instead of loose. Does it actually make sense to keep fscache and if yes =
why?
>

Persistent caches make sense in certain scenarios, it basically gives
a way to lazy populate a local cache of the remote server.  I wouldn't
use it in qemu
or a VM, but I'd definitely use it in cluster scenarios.  Its also
potentially useful for unstable connections -- but this is more
challenging to deal with in 9p although solutions have been proposed
in the past.

> > The ultimate goal is to simplify the options based on expected use mode=
ls:
> >
> > - cache=3D[ none, file, all ] (none is currently default)
>
> dir?
>

That was what I was originally going to do, but 'all' makes the
inclusivity of file explicit.   The more I thought about it, the less
I saw a use case for caching meta data and not file data.  Of course,
in the new patch series I have a bit for meta-data (which is a bit
more accurate than just saying dir) at least in the current
implementation.  However, if I did a shortcut, it probably
would be all and not dir (there isn't one yet in the new patch as I'm
holding off until I fix consistency for meta-data -- which is in
progress and I think imperfect but closer than loose).  And actually
once we are convinced this is working, the shortcut for all may be
better represented as 'default' (hopefully).

> > - write_policy =3D [ *writethrough, writeback ] (writethrough would be =
default)
> > - cache_validate =3D [ never, *open, x (seconds) ]  (cache_validate
> > would default to open)
>
> Jeff came up with the point that NFS uses a slicing time window for NFS. =
So
> the question is, would it make sense to add an option x seconds that migh=
t be
> dropped soon anyway?
>

I had thought about that, and in fact in the new patch series I
haven't implemented either yet.  In the bitmask version I could used
one of the reserved bits to specify adaptive timeouts like Jeff said
NFS does and then the high bits to specify the base timeout or 0 if
you never want to validate (current loose).  Loose mode itself
specifies look at the base timeout for how much temporal consistency
to apply.

Looking ahead at implementing this there is going to be ripple effects
through the code, probably changing the way we use the cache_validity
field in inode.  But seems straightforward enough.

> > - fscache
> >
> > So, mapping of existing (deprecated) legacy modes:
> > - none (obvious) write_policy=3Dwritethrough
> > - *readahead -> cache=3Dfile cache_validate_open write_policy=3Dwriteth=
rough
> > - mmap -> cache=3Dfile cache_validate=3Dopen write_policy=3Dwriteback
>
> Mmm, why is that "file"? To me "file" sounds like any access to files is
> cached, whereas cache=3Dmmap just uses the cache if mmap() was called, no=
t for
> any other file access.
>

Well, not technically true -- because if the file is mmaped and it is
accessed another way other than the mmap then we need to basically
treat it as cached or we'll get inconsistencies between the mmap
version and the uncached read/write version.  So the code ends up
using open-to-close file caching for everything.  In any case, mmap
was there for compatibility reasons before we had a non-loose caching
option.  With tight caches, its better to just incorporate mmap with
it (given the above concerns on behavior).  Otherwise we'd have to
enforce a non-posix semantic of the only way to access an mmaped file
is with mmap and force invalidations of others that might already have
a file open when someonebody else mmaps it...would be messy.

> > - loose -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback
> > - fscache -> cache=3Dall cache_validate=3Dnever write_policy=3Dwritebac=
k &
> > fscache enabled
> >
> > Some things I'm less certain of: cache_validation is probably an
> > imperfect term as is using 'open' as one of the options, in this case
> > I'm envisioning 'open' to mean open-to-close coherency for file
> > caching (cache is only validated on open) and validation on lookup for
> > dir-cache coherency (using qid.version). Specifying a number here
> > expires existing caches and requires validation after a certain number
> > of seconds (is that the right granularity)?
>
> Personally I would then really call it open-to-close or opentoclose and w=
aste
> some more characters in favour of clarity.
>

I had open2close in the new version and then reverted it to the
inverse of loose because it made checking the bit pattern much easier.
But the plan is for loose to cover no-consistency (when
cache-timeout=3D=3D0, and temporal consistency when cache-timeout > 0, and
then augment that with Jeff's suggestion of an adaptive bit).
Perhaps the new loose shortcut will cover NFS-like semantics with a
base-timeout of 5s and adaptivity bit set.

      -eric
