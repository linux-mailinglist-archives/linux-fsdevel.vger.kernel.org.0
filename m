Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30FF4F00DE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 12:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352934AbiDBK7p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 06:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbiDBK7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:59:43 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D89C17869B;
        Sat,  2 Apr 2022 03:57:52 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 62EC51C0B79; Sat,  2 Apr 2022 12:57:51 +0200 (CEST)
Date:   Sat, 2 Apr 2022 12:57:49 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220402105749.GB16346@amd>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
 <20220222221614.GC3061737@dread.disaster.area>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gj572EiMnwbLXET9"
Content-Disposition: inline
In-Reply-To: <20220222221614.GC3061737@dread.disaster.area>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--gj572EiMnwbLXET9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> > So from my distro experience installed userbase of reiserfs is pretty s=
mall
> > and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
> > for enterprise offerings it is unsupported (for like 3-4 years) and the=
 module
> > is not in the default kernel rpm anymore.
> >=20
> > So clearly the filesystem is on the deprecation path, the question is
> > whether it is far enough to remove it from the kernel completely. Maybe
> > time to start deprecation by printing warnings when reiserfs gets mount=
ed
> > and then if nobody yells for year or two, we'll go ahead and remove it?
>=20
> Yup, I'd say we should deprecate it and add it to the removal
> schedule. The less poorly tested legacy filesystem code we have to
> maintain the better.
>=20
> Along those lines, I think we really need to be more aggressive
> about deprecating and removing filesystems that cannot (or will not)
> be made y2038k compliant in the new future. We're getting to close
> to the point where long term distro and/or product development life
> cycles will overlap with y2038k, so we should be thinking of
> deprecating and removing such filesystems before they end up in
> products that will still be in use in 15 years time.
>=20
> And just so everyone in the discussion is aware: XFS already has a
> deprecation and removal schedule for the non-y2038k-compliant v4
> filesystem format. It's officially deprecated right now, we'll stop
> building kernels with v4 support enabled by default in 2025, and
> we're removing the code that supports the v4 format entirely in
> 2030.

Haha.

It is not up to you. You can't remove feature people are
using. Sorry. Talk to Linus about that.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--gj572EiMnwbLXET9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJILCwACgkQMOfwapXb+vL+cwCeKoWjLgQyQtZxSVPyZ3fSK+va
2y4AnRvT6XFyi/Bb7fAtHmBi382Irkrc
=Kv/y
-----END PGP SIGNATURE-----

--gj572EiMnwbLXET9--
