Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3F86D3837
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Apr 2023 16:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjDBOID (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 2 Apr 2023 10:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjDBOIC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:08:02 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FC71B7C3;
        Sun,  2 Apr 2023 07:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=XuMf5Jo0uYw0I7+MICSTMm2GbtepDcwAV4O4/g6IH/w=; b=jT/8FRVxVIF04Xf3s7gDPBNX+6
        BXzgh3fH0LN0iowORf0bR1JRZuSq5BunHGjCCGLacuRXi0EwSOgii6gdgdwmPVgBrzzGShLTXTxPu
        HDvUFBkgXKBBxlQk3BhMKlLEFTkyhuLog/dYyySbWXvSvmrLCS2ayLSqybcvEI+qAVgsmqFaul204
        eRBEckEo4oaqeWScw8iPaB5BFybiLC9liYekGxXtdJfK7bziDynzXPUx0V+7dfgzto+OTvWv/WLlH
        2q38F6vMfg2ZgzIdNbCKlZ3Fgcv/5gVgcDPkJ/an5FwxMM9Q+C5/QlOqjdibpUff+TGwVTxnDrtme
        8e4RMigOpRdO0DOGEMeSwn6B8pXOo8NRypNY/mbPYULugofQywZ/zKbC4pG5qxJ/QRWGBO3Ngl+N8
        ckc2kjmIIf8h8pcllsfprpBn6bHUdUVU4XNJKvrav4ab75s5NnDHu2szFqoAFGhpakXm7uyZG7ljS
        ROI1ZraEMjhJMVClPg3e6YL2saxZBQJ5OmWFiJScRMqT5nFXhuekrXXp41VtSltyTHANWPekHta7W
        Bs41+R+ptxwlnmDwqrwfDObFbxQL7O/bOuMycogD3ncOlE4yv2aee6wRMPOveEXuoEIwGMO+6pUHK
        s37P+ijoH2vVORd+M14TmQ2rz0+W9bkVp3K3PGLdk=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Eric Van Hensbergen <ericvh@gmail.com>
Cc:     v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@kernel.org>,
        asmadeus@codewreck.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] fs/9p: Add new options to Documentation
Date:   Sun, 02 Apr 2023 16:07:51 +0200
Message-ID: <5898218.pUKYPoVZaQ@silver>
In-Reply-To: <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com>
References: <ZCEIEKC0s/MFReT0@7e9e31583646> <3443961.DhAEVoPbTG@silver>
 <CAFkjPT=j1esw=q-w5KTyHKDZ42BEKCERy-56TiP+Z7tdC=y05w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+CC: Jeff for experience on this caching issue with NFS ...

On Tuesday, March 28, 2023 5:51:51 PM CEST Eric Van Hensbergen wrote:
> As I work through the documentation rework and to some extent the
> testing matrix -- I am reconsidering some choices and wanted to open
> up the discussion here.
>=20
> TLDR; I'm thinking of reworking the cache options before the merge
> window to keep things simple while setting up for some of the future
> options.

Yeah, revising the 9p cache options highly makes sense!

So what is the plan on this now? I saw you sent a new patch with the "old"
options today? So is this one here deferred?

> While we have a bunch of new options, in practice I expect users to
> probably consolidate around three models: no caching, tight caches,
> and expiring caches with fscache being an orthogonal add-on to the
> last two.

Actually as of today I don't know why somebody would want to use fscache
instead of loose. Does it actually make sense to keep fscache and if yes wh=
y?

> The ultimate goal is to simplify the options based on expected use models:
>=20
> - cache=3D[ none, file, all ] (none is currently default)

dir?

> - write_policy =3D [ *writethrough, writeback ] (writethrough would be de=
fault)
> - cache_validate =3D [ never, *open, x (seconds) ]  (cache_validate
> would default to open)

Jeff came up with the point that NFS uses a slicing time window for NFS. So
the question is, would it make sense to add an option x seconds that might =
be
dropped soon anyway?

> - fscache
>=20
> So, mapping of existing (deprecated) legacy modes:
> - none (obvious) write_policy=3Dwritethrough
> - *readahead -> cache=3Dfile cache_validate_open write_policy=3Dwritethro=
ugh
> - mmap -> cache=3Dfile cache_validate=3Dopen write_policy=3Dwriteback

Mmm, why is that "file"? To me "file" sounds like any access to files is
cached, whereas cache=3Dmmap just uses the cache if mmap() was called, not =
for
any other file access.

> - loose -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback
> - fscache -> cache=3Dall cache_validate=3Dnever write_policy=3Dwriteback &
> fscache enabled
>=20
> Some things I'm less certain of: cache_validation is probably an
> imperfect term as is using 'open' as one of the options, in this case
> I'm envisioning 'open' to mean open-to-close coherency for file
> caching (cache is only validated on open) and validation on lookup for
> dir-cache coherency (using qid.version). Specifying a number here
> expires existing caches and requires validation after a certain number
> of seconds (is that the right granularity)?

Personally I would then really call it open-to-close or opentoclose and was=
te
some more characters in favour of clarity.

> So, I think this is more clear from a documentation standpoint, but
> unfortuantely I haven't reduced the test matrix much - in fact I've
> probably made it worse. I expect the common cases to basically be:
> - cache=3Dnone
> - new default? (cache=3Dall, write_policy=3Dwriteback, cache_validate=3Do=
pen)
> - fscache w/(cache=3Dall, write_policy=3Dwriteback, cache_validate=3D5)
>=20
> Which would give us 3 configurations to test against versus 25
> (assuming testing for one time value for cache-validate=3Dx). Important
> to remember that this is just cache mode tests, the other mount
> options act as multipliers.
>=20
> Thoughts?  Alternatives?
>=20
>         -eric
>=20
> On Mon, Mar 27, 2023 at 10:38=E2=80=AFAM Christian Schoenebeck
> <linux_oss@crudebyte.com> wrote:
> >
> > On Monday, March 27, 2023 5:05:52 AM CEST Eric Van Hensbergen wrote:
> > > Need to update the documentation for new mount flags
> > > and cache modes.
> > >
> > > Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
> > > ---
> > >  Documentation/filesystems/9p.rst | 29 ++++++++++++++++-------------
> > >  1 file changed, 16 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/9p.rst b/Documentation/filesys=
tems/9p.rst
> > > index 0e800b8f73cc..6d257854a02a 100644
> > > --- a/Documentation/filesystems/9p.rst
> > > +++ b/Documentation/filesystems/9p.rst
> > > @@ -78,19 +78,18 @@ Options
> > >               offering several exported file systems.
> > >
> > >    cache=3Dmode specifies a caching policy.  By default, no caches ar=
e used.
> > > -
> > > -                        none
> > > -                             default no cache policy, metadata and d=
ata
> > > -                                alike are synchronous.
> > > -                     loose
> > > -                             no attempts are made at consistency,
> > > -                                intended for exclusive, read-only mo=
unts
> > > -                        fscache
> > > -                             use FS-Cache for a persistent, read-only
> > > -                             cache backend.
> > > -                        mmap
> > > -                             minimal cache that is only used for rea=
d-write
> > > -                                mmap.  Northing else is cached, like=
 cache=3Dnone
> > > +             Modes are progressive and inclusive.  For example, spec=
ifying fscache
> > > +             will use loose caches, writeback, and readahead.  Due t=
o their
> > > +             inclusive nature, only one cache mode can be specified =
per mount.
> >
> > I would highly recommend to rather specify below for each option "this =
option
> > implies writeback, readahead ..." etc., as it is not obvious otherwise =
which
> > option would exactly imply what. It is worth those extra few lines IMO =
to
> > avoid confusion.
> >
> > > +
> > > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +                     none            no cache of file or metadata
> > > +                     readahead       readahead caching of files
> > > +                     writeback       delayed writeback of files
> > > +                     mmap            support mmap operations read/wr=
ite with cache
> > > +                     loose           meta-data and file cache with n=
o coherency
> > > +                     fscache         use FS-Cache for a persistent c=
ache backend
> > > +                     =3D=3D=3D=3D=3D=3D=3D=3D=3D       =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >
> > >    debug=3Dn    specifies debug level.  The debug level is a bitmask.
> > >
> > > @@ -137,6 +136,10 @@ Options
> > >               This can be used to share devices/named pipes/sockets b=
etween
> > >               hosts.  This functionality will be expanded in later ve=
rsions.
> > >
> > > +  directio   bypass page cache on all read/write operations
> > > +
> > > +  ignoreqv   ignore qid.version=3D=3D0 as a marker to ignore cache
> > > +
> > >    noxattr    do not offer xattr functions on this mount.
> > >
> > >    access     there are four access modes.
> > >
> >
> >
> >
> >
>=20




