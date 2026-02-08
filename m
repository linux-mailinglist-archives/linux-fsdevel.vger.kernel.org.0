Return-Path: <linux-fsdevel+bounces-76677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OlWMy74iGmXzwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76677-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Feb 2026 21:55:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A2610A249
	for <lists+linux-fsdevel@lfdr.de>; Sun, 08 Feb 2026 21:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D222F3002336
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Feb 2026 20:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893C9344029;
	Sun,  8 Feb 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG5X9olp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654923DEB6;
	Sun,  8 Feb 2026 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770584105; cv=none; b=ZZi3iGBGyd+4OE69TtY7Xm5um49hLVNcdXMgM36nILjYvMjz1pCxfs5IFHNHoEGwWxi3NxjLBSlVr2QamABoGcs0W9GbP6eomo+R4jZiKXhHiTX27xluTV3wmOTKKwSU2yZULG1bCwhiGfl91Z7OLpRMbEjR8oVzlvlqb3dPY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770584105; c=relaxed/simple;
	bh=1ibsnJnBFq+C9SAgY4KCPc13PZBD+2+YbljuBe7Coqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaTfkf+EAN0cioXvVR1EvDjeUPXnjDAdsUAZLJxg0L5tLAeQuHQ4wW7W8jiYaOk6WpbNeLebCLIag0IZObQAqKjd2OKGVXNJliPFj9qCVAA5M2cbPnb9Ldlq3cbTXeF+g2vueEbirk9f9vb/ZfKj/XC1nj0sMxu/RdZzP+QXq68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG5X9olp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDE0C4CEF7;
	Sun,  8 Feb 2026 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770584104;
	bh=1ibsnJnBFq+C9SAgY4KCPc13PZBD+2+YbljuBe7Coqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CG5X9olpgApxh5ajpfBIViPvJFrIPidzh4udR8f3zkjFhSmOO+WoIOaPlx+/D0aSy
	 NLdNCM6Dpp98LwVLWRjkQR/EZpfXOTO3qHAK5aLowFfHlEK7b5Eme0PYHomwD3m+wC
	 EUbuPG2fcyhjCZbJ8DcpXrI2RLTWtnnVe/r6ObgxR1hhUNJtQwhLhvsPth51zYRXVs
	 nBotS2VZ+89lMJVhanf40gjoPZpHBm9d537KHToVOHFGuBUmaoCVHF4/zUG2uPN6wb
	 3TUTe10OXy+EuIPHZkiw1Jdg0JsRkNQHHVJgf2KYuUOn1Uy4jHFURVEgkT7YEYLFlD
	 3IB9d4vbitLwA==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id 359D61AC57EF; Sun, 08 Feb 2026 20:55:01 +0000 (GMT)
Date: Sun, 8 Feb 2026 20:55:01 +0000
From: Mark Brown <broonie@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <aYj4JRK023heQnFy@sirena.co.uk>
References: <aXilaLSzB1xsGWCb@sirena.org.uk>
 <f9afaed3-9db5-4725-a0e5-cb6d6873b3c6@sirena.org.uk>
 <ef58e561-b366-4eb8-bad6-9d0e748f49c1@sirena.org.uk>
 <20260206-euter-weilen-610fef8cb79a@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="14qO3GYUpEirAdoT"
Content-Disposition: inline
In-Reply-To: <20260206-euter-weilen-610fef8cb79a@brauner>
X-Cookie: Think big.  Pollute the Mississippi.
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76677-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,linux-fsdevel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sirena.co.uk:mid]
X-Rspamd-Queue-Id: 80A2610A249
X-Rspamd-Action: no action


--14qO3GYUpEirAdoT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2026 at 01:19:12PM +0100, Christian Brauner wrote:
> On Wed, Feb 04, 2026 at 02:31:06PM +0000, Mark Brown wrote:

> > This means that vfs-brauner is still held at the version from
> > next-20260126 and none of the below commits have been in -next:

> This should've been fixed. Not sure what happened.
> I've reassembled vfs.all completely just to be sure.

I am seeing an updated version (I've currently got commit
91dfa1c939f479938d83793389ad7cb9c1faa4de dated 7th Feb) but I'm still
seeing the same build failure:

  CC       statmount_test
statmount_test.c:36:26: error: conflicting types for 'statmount_alloc'; have 'struct statmount *(uint64_t,  int,  uint64_t,  unsigned int)' {aka 'struct statmount *(long unsigned int,  int,  long unsigned int,  unsigned int)'}
   36 | static struct statmount *statmount_alloc(uint64_t mnt_id, int fd, uint64_t mask, unsigned int flags)
      |                          ^~~~~~~~~~~~~~~
In file included from statmount_test.c:15:
statmount.h:91:33: note: previous definition of 'statmount_alloc' with type 'struct statmount *(uint64_t,  uint64_t,  uint64_t)' {aka 'struct statmount *(long unsigned int,  long unsigned int,  long unsigned int)'}
   91 | static inline struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask)
      |                                 ^~~~~~~~~~~~~~~


--14qO3GYUpEirAdoT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmI+CQACgkQJNaLcl1U
h9D+rAf/QOf0NJgZDVLj4NHAIFZ/Cet/7m1LoSXz5EqJWDRz5Ejcan/GYFpb1m8b
SbSgaZ5RUDRLC8q0Qg9fY2zzVJpl2Blb2LMBSb6FKBI3LfQQNG/QDzUELg8oya/j
7Mlt2HqjKIDp7FHdqelWLzjKvq9m6bCH3yR0ocssjPkXKR4icj7trSXPmPbI0gc0
45BJNUeJzESvCx9703ld0MNJN1T26IWwas44CTsZPxo+XNyROWg5bZblbcWIL4rS
d9jnAkbJWa7i8GlEo6Ao8HKxGo/Wt0GSBhZuv4eveF919s54yYeBdpFALC/o1vcS
EGD+21qktKF9pDspF873dYre68chRw==
=tHkF
-----END PGP SIGNATURE-----

--14qO3GYUpEirAdoT--

