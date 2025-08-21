Return-Path: <linux-fsdevel+bounces-58604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF523B2F71E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6495A27301
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35A630BF6E;
	Thu, 21 Aug 2025 11:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="gaK1lMu2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0373A28850B;
	Thu, 21 Aug 2025 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776853; cv=none; b=aTLR+BPesVz+PjvGVTiP888KMiezbQy5DGGFub2m3/9W72quyU0srcbC2ZLT8Dv5tpzgNZVgPcsgzua1wo9mDSKX361o9U0e7tKi2ZzlM8gGIP1Cx+ALsGmxYToYq08fzkPcO1jP1O45XeigZUJSqdwhc1m9g0MlkyF/QOwxD5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776853; c=relaxed/simple;
	bh=nB+ATKIsYq7SgOgpe9JFJ9iZ+Kn/zPxfjmzpITUU9ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6bWE2a449ULTMRbD3mf4jYfcIqQcmTtVXdZukrMyanU31cT2VMs2LvltG0BiIwRkMOGpnmPiyF0D67wwZ/ya2zmv95r/qRRTk9JyrK4Kf5KJTy4Y1Ay+ZRfe7IqY5OZjr/us9WIUfFLz99HyihHFYcGitjAoDYnsXf7aejJPqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=gaK1lMu2; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4c71lL6GGtz9tVh;
	Thu, 21 Aug 2025 13:47:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755776846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nB+ATKIsYq7SgOgpe9JFJ9iZ+Kn/zPxfjmzpITUU9ks=;
	b=gaK1lMu25/4Ohv/XeUjp1PM1eVfIgVguyAH0C+nrmLmzSy01LhckBE+sybt20pc0CqAiPW
	eDQOPFkwLSCaHFzK7JtFPgJkGlKobFvdmmL3ko3gGeFxOhoxFU2btVYOnK46h2JIJKHhHS
	vH39OEeUQTla/otCVlVacaEXBGUqhvkyne/zDmoI6IA1e8AaDFoTU4eK6vCH9mn6B6oMAO
	E2xKp9YjVPfBSVvNrXIu+lkAsB/G6sHGIYFozhzdAI8R0bm3nBj100MK1MlunDJ//ThCaE
	XrneDFnAlDwqMz+AYsOeVAjeGeJUjP8ilFjQhJJPoU9s8wowO7UiVBkWv373uA==
Date: Thu, 21 Aug 2025 21:47:17 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
Message-ID: <2025-08-21.1755776734-magenta-shaved-atrium-spacebar-n0zDCn@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250809-new-mount-api-v3-6-f61405c80f34@cyphar.com>
 <198cc299cd9.eec1817f85794.4679093070969175955@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ixnxzpvxygwsjat"
Content-Disposition: inline
In-Reply-To: <198cc299cd9.eec1817f85794.4679093070969175955@zohomail.com>


--7ixnxzpvxygwsjat
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 06/12] man/man2/fsconfig.2: document "new" mount API
MIME-Version: 1.0

On 2025-08-21, Askar Safin <safinaskar@zohomail.com> wrote:
> There is a convention: you can pass invalid fd (such as -1) as dfd to *at=
-syscalls to enforce that the path is absolute.
> This is documented. "man openat" says: "Specifying an invalid file descri=
ptor number in dirfd can be used as a means to ensure that pathname is abso=
lute".
> But fsconfig with FSCONFIG_SET_PATH breaks this convention due to this li=
ne: https://elixir.bootlin.com/linux/v6.16/source/fs/fsopen.c#L377 .
> I think this is a bug, and it should be fixed in kernel. Also, it is poss=
ible there are a lot of similarly buggy syscalls. All of them should be fix=
ed,
> and moreover a warning should be added to https://docs.kernel.org/process=
/adding-syscalls.html . And then new fsconfig behavior should be documented.
> (Of course, I'm not saying that *you* should do all these. I'm just sayin=
g that this bug exists.) (I tested this.)

Indeed, good catch! I think we discussed this before --
FSCONFIG_SET_PATH actually doesn't work with any parameters today so
it's not very surprising nobody has noticed this until now. I'll include
it in the set of fixes I have for fscontext.

(FWIW, the convention I see more commonly is -EBADF but that's just a
stylistic I suppose.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--7ixnxzpvxygwsjat
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKcHRBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+bOwEAtiZOgy2wL1XHTEHcdKvh
QWCwK51hfBt9OuM9DCIl+6YBAIlVGA+rQIFTOcd1a5ZeG9gFXByfKCGcnHexmwN/
kkcJ
=EOPu
-----END PGP SIGNATURE-----

--7ixnxzpvxygwsjat--

