Return-Path: <linux-fsdevel+bounces-76322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNOYFFFYg2mJlQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:31:45 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A835E7229
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 15:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E53E83013EF2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 14:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9401E9B3F;
	Wed,  4 Feb 2026 14:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMly7MJq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288D913B293;
	Wed,  4 Feb 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215471; cv=none; b=Hx7cYx6f81Y4HFypH8LL4gSRjsq6AcEBQeS0t95tdsqLP+dCw6cgxBsNzs0pLAiqCPBWwoYPoz6I7wRZT4awGMlfVSjC2hV8Uu89ufGU3Go4StupE8wuZ7KpHeGl6tj8FK02HB9qZo2vFmtw0LwKriEqyySfO/6VI1+SJXEVCkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215471; c=relaxed/simple;
	bh=I9eRiGvOfSoXxU63sDVC9HA6MuyWy+NAP7YTRMlyWYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/T97nR9JpinuffkzU8rnBM25KVxi4eF0EG/3YHex8Q77t3BdQb2+B78nCRohjnXJJBCnXF6HUVaGUkL+T43xij0o4ELDwhZmW1gt8Dic5bmP6Gqc1noATpmjx5nYARhH9pplfGib4FOmhdObn8J8RZT0pMW0sWBJeIBuejFWxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMly7MJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69D1C4CEF7;
	Wed,  4 Feb 2026 14:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770215470;
	bh=I9eRiGvOfSoXxU63sDVC9HA6MuyWy+NAP7YTRMlyWYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMly7MJqVQZ+Rc+ecDzjx3SKnadsBN/Z82a50KwVXaJG/TkhYMa7OcMCa8+SmfGL3
	 HqNpFqdram1Qw+EHTzlW5Ydg1Iy+vZowI5wHfIpPYPHOIZBOJVC+j/b71QYCewz0cb
	 VbAEOlmNzn/yUah8ARcacwMlKDG0+CWfs7ys88NoXFmB81q3LY5J4PiwsWHLTWz4Vu
	 wEto52pV2KHBwILTQAOepk+Lf7o7WtsWWBAUhy+uN/izk6hPR4NrTavOuCTtZ4ki+5
	 0zOyTDFAmFo0EgjuFboXsvoSyMHT4WxY2zw3efYUSnW7HD1UAS5QHPZUam9c8PlVa/
	 re8dcfY2m+zPQ==
Date: Wed, 4 Feb 2026 14:31:06 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <ef58e561-b366-4eb8-bad6-9d0e748f49c1@sirena.org.uk>
References: <aXilaLSzB1xsGWCb@sirena.org.uk>
 <f9afaed3-9db5-4725-a0e5-cb6d6873b3c6@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sCS5F8kU5fnMaysT"
Content-Disposition: inline
In-Reply-To: <f9afaed3-9db5-4725-a0e5-cb6d6873b3c6@sirena.org.uk>
X-Cookie: Are you having fun yet?
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76322-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A835E7229
X-Rspamd-Action: no action


--sCS5F8kU5fnMaysT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2026 at 02:58:35PM +0000, Mark Brown wrote:
> On Tue, Jan 27, 2026 at 11:45:44AM +0000, Mark Brown wrote:
> > Hi all,
> >=20
> > After merging the vfs-brauner tree, today's linux-next build
> > (arm64 kselftest) failed like this:
>=20
> This issue is still present in today's -next.

This means that vfs-brauner is still held at the version from
next-20260126 and none of the below commits have been in -next:

Amir Goldstein (4):
      fs: add helpers name_is_dot{,dot,_dotdot}
      ovl: use name_is_dot* helpers in readdir code
      exportfs: clarify the documentation of open()/permission() expotrfs o=
ps
      nfsd: do not allow exporting of special kernel filesystems

Andrey Albershteyn (3):
      fs: reset read-only fsflags together with xflags
      fs: add FS_XFLAG_VERITY for fs-verity files
      fsverity: add tracepoints

Chelsy Ratnawat (1):
      fs: dcache: fix typo in enum d_walk_ret comment

Christian Brauner (6):
      mount: start iterating from start of rbtree
      mount: simplify __do_loopback()
      mount: add FSMOUNT_NAMESPACE
      tools: update mount.h header
      selftests/statmount: add statmount_alloc() helper
      selftests: add FSMOUNT_NAMESPACE tests

Joanne Koong (1):
      iomap: fix invalid folio access after folio_end_read()

Qiliang Yuan (1):
      fs/file: optimize close_range() complexity from O(N) to O(Sparse)

Qing Wang (1):
      ovl: Fix uninit-value in ovl_fill_real

Tamir Duberstein (1):
      rust: seq_file: replace `kernel::c_str!` with C-Strings


--sCS5F8kU5fnMaysT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmDWCoACgkQJNaLcl1U
h9AAPwf+ITWvAN7AzIeHR7ZenRYTrfReVstgfxbB3r1uuJ6YUMDeQvzHWWr7HW7l
CGf7cXliqEVnGPbzZM+8khsA1p8s0HqGOGtavATXOYm0n6i6/ozeTg77DSGF5EMH
pAynndInl6qTCENPHMdzJQrdPeJn6zhnoW9pTH4hu0gJ47M64BDL02pc6KaWVYIc
UeqtCW1SeuW3WyYbq2bmtLISwi9UkkzD9oPD1Fc8jTG0qAk4Gk5YdIo87UtR8Ywc
WV67sFPGSFF7M3GnNfGN5MUYrnhW3d4kISoGsb5N254tTzcrtuHnn1OhR8nRHnZr
1LcXLJAGxA6UkqwBgiufClsLbTrZSw==
=Yjta
-----END PGP SIGNATURE-----

--sCS5F8kU5fnMaysT--

