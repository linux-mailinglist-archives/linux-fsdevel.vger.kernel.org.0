Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896A4F00D3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 12:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiDBK4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 2 Apr 2022 06:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240318AbiDBK4u (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:56:50 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2F990277;
        Sat,  2 Apr 2022 03:54:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 1DC0F1C0B8E; Sat,  2 Apr 2022 12:54:57 +0200 (CEST)
Date:   Sat, 2 Apr 2022 12:54:55 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, reiserfs-devel@vger.kernel.org
Subject: Re: Is it time to remove reiserfs?
Message-ID: <20220402105454.GA16346@amd>
References: <YhIwUEpymVzmytdp@casper.infradead.org>
 <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20220222100408.cyrdjsv5eun5pzij@quack3.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Keeping reiserfs in the tree has certain costs.  For example, I would
> > very much like to remove the 'flags' argument to ->write_begin.  We have
> > the infrastructure in place to handle AOP_FLAG_NOFS differently, but
> > AOP_FLAG_CONT_EXPAND is still around, used only by reiserfs.
> >=20
> > Looking over the patches to reiserfs over the past couple of years, the=
re
> > are fixes for a few syzbot reports and treewide changes.  There don't
> > seem to be any fixes for user-spotted bugs since 2019.  Does reiserfs
> > still have a large install base that is just very happy with an old
> > stable filesystem?  Or have all its users migrated to new and exciting
> > filesystems with active feature development?
> >=20
> > We've removed support for senescent filesystems before (ext, xiafs), so
> > it's not unprecedented.  But while I have a clear idea of the benefits =
to
> > other developers of removing reiserfs, I don't have enough information =
to
> > weigh the costs to users.  Maybe they're happy with having 5.15 support
> > for their reiserfs filesystems and can migrate to another filesystem
> > before they upgrade their kernel after 5.15.
> >=20
> > Another possibility beyond outright removal would be to trim the kernel
> > code down to read-only support for reiserfs.  Most of the quirks of
> > reiserfs have to do with write support, so this could be a useful way
> > forward.  Again, I don't have a clear picture of how people actually
> > use reiserfs, so I don't know whether it is useful or not.
> >=20
> > NB: Please don't discuss the personalities involved.  This is purely a
> > "we have old code using old APIs" discussion.
>=20
> So from my distro experience installed userbase of reiserfs is pretty sma=
ll
> and shrinking. We still do build reiserfs in openSUSE / SLES kernels but
> for enterprise offerings it is unsupported (for like 3-4 years) and the m=
odule
> is not in the default kernel rpm anymore.

I believe I've seen reiserfs in recent Arch Linux ARM installation on
PinePhone. I don't really think you can remove a feature people are
using.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJIK34ACgkQMOfwapXb+vInUwCgiuujgobhudaYxKoul558NwQE
kRcAn1O5/sGxjKK3dKK6b6zT6ydXw++J
=S16w
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
