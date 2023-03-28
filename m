Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8696CC719
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Mar 2023 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbjC1PwG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Mar 2023 11:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjC1PwF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:52:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9666F1B3;
        Tue, 28 Mar 2023 08:52:03 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id n125so15639377ybg.7;
        Tue, 28 Mar 2023 08:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3G5lMN0QEUYC4Qox2hs9k7l4ZdTOZOuw9tIXiq/0Fg=;
        b=DPPJhfzTip0i0zk2bPuZuLckRa2iJVTpAHAnPvYVJp5dAFt4JERB8z7Mho/gcph0IV
         lgIgOW0VTQdrHNgQ0+OkoFcVDywTJku3c31KHPVHctSzJLWqZzRXPMuYf9piRBhlIlt0
         tLrTRlZHaz7CjEKgvjFyCdZu0MAfONMKRhxonCo5ST8w/OEU9LArkGtF4YKUh9W5MOYR
         e9jhZEKpa+WMihQMl9hi1kvgfgJRPhEcDvqmrtP/3/OJ3GUbtQ/SSbEtc5vYfeugulIv
         E1UxrQ/NmhGrUoJAnNU56HUoRU7xZ7WPiKXJcw1WqGZiIK3D+2VtIKsD1MhNPSvqs38B
         cKXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3G5lMN0QEUYC4Qox2hs9k7l4ZdTOZOuw9tIXiq/0Fg=;
        b=NdDwiYOlx0GdzHD9yjWoJum6hFhn9MiOtaU4HhkVM/PeuU1/rMBTjMMomxs5fJcWNR
         tztDi8fzGY2TKpym/AC5n5HRi/7bo0z/eL3H0SDWP2UnM6adtOFp0babedkbSN/K+TyM
         CYyHHZExJwMbk/HgHKiynupplActzhqRGWs4PVN4y6IhYjA0EfYgIPd1wJPutShqMAXe
         xgFzEWAG+BWA89fimo8KdC+/t2PFWTaEng08YLpmUv+b1mp36HA8XlTbRVor30y34+PI
         euEgg0l8sE4nPBRmyocRQyxWy/3mc2dXf3ApU2vksJzSRlCZLhUF9LoU5/Gk/wdyMxeX
         5YYQ==
X-Gm-Message-State: AAQBX9cn5ZRzNJMJDiUvAQDgqE/iEIEDqz0XipDY4f7aJQB6II9B4dWX
        W9nDw+yWevgEOA6V4icJjhxqDCKy4B9spdzvNt3de6UQHTfL/CEb
X-Google-Smtp-Source: AKy350ZfTgUeEwFQTG2UMGEsb0KpsteEhATGz400mc3KzrBJRXixMW1G6R2KRNzU29dD9BMfwWo93zONg0vVXS+TKD4=
X-Received: by 2002:a05:6902:18d5:b0:b75:3fd4:1b31 with SMTP id
 ck21-20020a05690218d500b00b753fd41b31mr10707743ybb.1.1680018722397; Tue, 28
 Mar 2023 08:52:02 -0700 (PDT)
MIME-Version: 1.0
References: <ZCEIEKC0s/MFReT0@7e9e31583646> <3443961.DhAEVoPbTG@silver>
In-Reply-To: <3443961.DhAEVoPbTG@silver>
From:   Eric Van Hensbergen <ericvh@gmail.com>
Date:   Tue, 28 Mar 2023 10:51:51 -0500
Message-ID: <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com>
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

As I work through the documentation rework and to some extent the
testing matrix -- I am reconsidering some choices and wanted to open
up the discussion here.

TLDR; I'm thinking of reworking the cache options before the merge
window to keep things simple while setting up for some of the future
options.

While we have a bunch of new options, in practice I expect users to
probably consolidate around three models: no caching, tight caches,
and expiring caches with fscache being an orthogonal add-on to the
last two.

The ultimate goal is to simplify the options based on expected use models:

- cache=3D[ none, file, all ] (none is currently default)
- write_policy =3D [ *writethrough, writeback ] (writethrough would be defa=
ult)
- cache_validate =3D [ never, *open, x (seconds) ]  (cache_validate
would default to open)
- fscache

So, mapping of existing (deprecated) legacy modes:
- none (obvious) write_policy=3Dwritethrough
- *readahead -> cache=3Dfile cache_validate_open write_policy=3Dwritethroug=
h
- mmap -> cache=3Dfile cache_validate=3Dopen write_policy=3Dwriteback
- loose -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback
- fscache -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback &
fscache enabled

Some things I'm less certain of: cache_validation is probably an
imperfect term as is using 'open' as one of the options, in this case
I'm envisioning 'open' to mean open-to-close coherency for file
caching (cache is only validated on open) and validation on lookup for
dir-cache coherency (using qid.version). Specifying a number here
expires existing caches and requires validation after a certain number
of seconds (is that the right granularity)?

So, I think this is more clear from a documentation standpoint, but
unfortuantely I haven't reduced the test matrix much - in fact I've
probably made it worse. I expect the common cases to basically be:
- cache=3Dnone
- new default? (cache=3Dall, write_policy=3Dwriteback, cache_validate=3Dope=
n)
- fscache w/(cache=3Dall, write_policy=3Dwriteback, cache_validate=3D5)

Which would give us 3 configurations to test against versus 25
(assuming testing for one time value for cache-validate=3Dx). Important
to remember that this is just cache mode tests, the other mount
options act as multipliers.

Thoughts?  Alternatives?

        -eric

On Mon, Mar 27, 2023 at 10:38=E2=80=AFAM Christian Schoenebeck
<linux_oss@crudebyte.com> wrote:
>
> On Monday, March 27, 2023 5:05:52 AM CEST Eric Van Hensbergen wrote:
> > Need to update the documentation for new mount flags
> > and cache modes.
> >
> > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > ---
> >  Documentation/filesystems/9p.rst | 29 ++++++++++++++++-------------
> >  1 file changed, 16 insertions(+), 13 deletions(-)
> >
> > diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesyste=
ms/9p.rst
> > index 0e800b8f73cc..6d257854a02a 100644
> > --- a/Documentation/filesystems/9p.rst
> > +++ b/Documentation/filesystems/9p.rst
> > @@ -78,19 +78,18 @@ Options
> >               offering several exported file systems.
> >
> >    cache=3Dmode specifies a caching policy.  By default, no caches are =
used.
> > -
> > -                        none
> > -                             default no cache policy, metadata and dat=
a
> > -                                alike are synchronous.
> > -                     loose
> > -                             no attempts are made at consistency,
> > -                                intended for exclusive, read-only moun=
ts
> > -                        fscache
> > -                             use FS-Cache for a persistent, read-only
> > -                             cache backend.
> > -                        mmap
> > -                             minimal cache that is only used for read-=
write
> > -                                mmap.  Northing else is cached, like c=
ache=3Dnone
> > +             Modes are progressive and inclusive.  For example, specif=
ying fscache
> > +             will use loose caches, writeback, and readahead.  Due to =
their
> > +             inclusive nature, only one cache mode can be specified pe=
r mount.
>
> I would highly recommend to rather specify below for each option "this op=
tion
> implies writeback, readahead ..." etc., as it is not obvious otherwise wh=
ich
> option would exactly imply what. It is worth those extra few lines IMO to
> avoid confusion.
>
> > +
> > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +                     none            no cache of file or metadata
> > +                     readahead       readahead caching of files
> > +                     writeback       delayed writeback of files
> > +                     mmap            support mmap operations read/writ=
e with cache
> > +                     loose           meta-data and file cache with no =
coherency
> > +                     fscache         use FS-Cache for a persistent cac=
he backend
> > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> >    debug=3Dn    specifies debug level.  The debug level is a bitmask.
> >
> > @@ -137,6 +136,10 @@ Options
> >               This can be used to share devices/named pipes/sockets bet=
ween
> >               hosts.  This functionality will be expanded in later vers=
ions.
> >
> > +  directio   bypass page cache on all read/write operations
> > +
> > +  ignoreqv   ignore qid.version=3D=3D0 as a marker to ignore cache
> > +
> >    noxattr    do not offer xattr functions on this mount.
> >
> >    access     there are four access modes.
> >
>
>
>
>
