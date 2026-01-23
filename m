Return-Path: <linux-fsdevel+bounces-75303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aM1LAZeVc2lgxQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75303-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:36:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7246577D79
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 16:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E64301A282
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jan 2026 15:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5262D0C9A;
	Fri, 23 Jan 2026 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="On112vW2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0830288C2F;
	Fri, 23 Jan 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769182612; cv=none; b=nfVA8/P8sZF69wX3DP7r1pZd4QYN16RezpPD1m2Jr92dHoYybIGHpkGVvvqho1B2sVoLej5xejLgRst8mf26PD+K35uyxmRGnjdnuUi5NAWiK4tB0+fT6Mep0beZfbmPlQZnkOIeGI3EKqeMit6lIfBbmI14pUXY/UKtBLGUFko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769182612; c=relaxed/simple;
	bh=FIyRTpLsYX0HHTqmADg1q5K8xt4d0B03h27w4prkvU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCj6FEm8lEocxSpVH11tJqV9Pn46ei5hhqDKN8tOeqQieSgcvLn2R6nPFs31axruweHUzBA2ChuEMsm17es+pZntAnj7mBkIBC0y44mqOUdC4bGUI9BBQvPk9J5BXpCnmZzymrESqJY4pzJNnYhHXwuhYP8T7H3MIRPsgqvWi3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=On112vW2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB82C4CEF1;
	Fri, 23 Jan 2026 15:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769182611;
	bh=FIyRTpLsYX0HHTqmADg1q5K8xt4d0B03h27w4prkvU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=On112vW2vhyv5UUjjuE+aqnzucV2cSQsh8hVhwboo0HeM0dvPLODfozatCldNg0E3
	 GTUbqeTLXM4Ju0AqODReZf2SFTFBQqc3PGOgpt+KgayjOfGGsPWJ2cl3PZqyZkplaX
	 8TnzcPSA7+QqfboX6/Xn6keXmAZUeD20eU/486j/5uqTo1+cSmvRsLz52SrLfgVT6R
	 6MTR7t5ayRD0SgVD8aP797QrJZA2Fa+ZdXQ3/oaBpUXAYvv+PtUODRhswsYDYV2BJz
	 olZ2GlHOj1FElS1ta/drdYjtyIqoGe2IGWhFWbL/Bqz6OQ6azia4uKTcZ5UvRDdkQY
	 zJqSFf/wgRyLQ==
Date: Fri, 23 Jan 2026 16:36:48 +0100
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aXOUw8qNtw29CBWf@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
 <aW-awBnQ6RU8o19b@devuan>
 <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>
 <aW-k3ml5kwHnLkM7@devuan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ysjbe2plbz37d6nw"
Content-Disposition: inline
In-Reply-To: <aW-k3ml5kwHnLkM7@devuan>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75303-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alx@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alejandro-colomar.es:url]
X-Rspamd-Queue-Id: 7246577D79
X-Rspamd-Action: no action


--ysjbe2plbz37d6nw
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3] man/man2const/F_[SG]ETDELEG.2const, man/man2/fcntl.2:
 Document F_SETDELEG and F_GETDELEG
Message-ID: <aXOUw8qNtw29CBWf@devuan>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
 <5b283a25dbe2ab9ed78719c132885d9d3157f2bb.1768750908.git.alx@kernel.org>
 <a0916b361406fa52771cf3dd507521fa1cc31d7c.camel@kernel.org>
 <aW-awBnQ6RU8o19b@devuan>
 <1fa92006626f975663c53d903d363e260c0c7ae1.camel@kernel.org>
 <aW-k3ml5kwHnLkM7@devuan>
MIME-Version: 1.0
In-Reply-To: <aW-k3ml5kwHnLkM7@devuan>

Hi Jeff,

On Tue, Jan 20, 2026 at 04:58:09PM +0100, Alejandro Colomar wrote:
> I'll tweak that and push this evening.  Thank you!

I've pushed now; sorry for the delay.  Thanks!


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>

--ysjbe2plbz37d6nw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmlzlZAACgkQ64mZXMKQ
wqm2qA/9GaKwx2h7ReKcHTS49whFBNMyqtr/V3W+wHVnN7srgzQ4Lo3n0fuJrIQN
YvhOkQ3JJ67b8R48crunqN3qwmAimBlz/49Ivgkbwte1liHUoSukkcoc8p/k2S/G
noZYonVQ6C3Dg/7u0PM9ddmGsmlrYTIgQoXbIzrElBoFzXnjJc+b40xuh5C7dUwb
ST+kngbONM4A44JgU/+sU+ql2YrHu+6OBf3cHRZj+8asKOZWTGDg3AR1r6nPplus
KZFJ5Yg7owFXbZjt5jpx4sc5CYSzlZVjBuy7fOEj8NUkRjqCdvPM5q7gxC2cWmeF
zUJ3JGY+G13RTBX4REJrvQNio6FoOu1EXM8OtSijaGh1upgcJW2JqfF6sffF6cqL
IApkcF0JeBEdPlIgn1Yi9gZeqa4q6dR5TaoiKxMQFsJ6gsWzcIOiUErwaiyIJkSZ
mVMQnUImRD4CzvodfmPBxvW0wtMs8d7pMl+70sKhjOkxoIOWGKN4aDg9o/IKW8bH
7N1s9Z9QbrCMVtGiDZ7oLc3eE2Wp4VskRm+JhMGVD+T5k3uC2VELww70feAoRDv8
bqvgEGsf/5eoK8+3iqEmIBpsuWLao6MrUS+9OIYm+87SIKwDvUkSQ74pcPgv/NK1
gHayuy/v+PlD8EB2tewarrb70ENgiaR/FlNeoKk0JlRAub7O2k4=
=yoKI
-----END PGP SIGNATURE-----

--ysjbe2plbz37d6nw--

