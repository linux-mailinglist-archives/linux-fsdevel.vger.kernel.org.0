Return-Path: <linux-fsdevel+bounces-56963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AEEB1D325
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 09:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C3116694C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 07:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6E2238D5A;
	Thu,  7 Aug 2025 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Z12glsS8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2A88F48;
	Thu,  7 Aug 2025 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551101; cv=none; b=n6v0Aw8lDf4o4DkwgaGCuI/qz7ZOD8epbAYkap1/tt4cbPc7uMM9E7UdI0frKjEZ6sreTgk7pb9IBti2OekuxNTYQP2ofFJPy1KYJqMMGPd6UtZIB+5i2FNuWoRn7QdLNI1hoVagLT7cdSt1HxsjAYMStmnHNNRXzg6Ac90GAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551101; c=relaxed/simple;
	bh=+ULjuenwEzpGC8UAzxKw+UpGPt4UQhh+CmIbbChlejc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOegH35pPA0fBDuiYTIHycRlyED/uJq5KXc3pcr9/2esp+VyIr5MK/x6wwICoVHlaQ8xxihuwqz5BfyKYJYzP9wPHNbc1Xtftsd0JjnaXv7SoD9C0zqlzEMqIznsJa+7K564GY1GzpJdJrG3RU02g8sqcOzToYymiWX9qVLfTyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Z12glsS8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4byJR86h77z9syY;
	Thu,  7 Aug 2025 09:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754551093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+ULjuenwEzpGC8UAzxKw+UpGPt4UQhh+CmIbbChlejc=;
	b=Z12glsS8h5ztkydn7KCjBvp8B2d4sQhdHS+zy0dBp50B4bgFRDwn3iKX+ukysgEeH7ycmD
	1fP2zrfNK/iq3ueO00R3iE2YKrjtes55OO0CveBD/oGdVpTy96/28NQ8kUCRzmZMVvthiy
	dAg7+PnZWnPO2F5WEkaSm/UH6N2xgIFqwZ+iWAWqHu6ZrQwfCuBHcGWU297wOxsZuKti0w
	VVnB8Big+Y08L+WWrbOfnEKIuT7mCorfJIns+4CO7po8sDf4+8z/vE/QNGqW0B+zSi5a6G
	W0+mZ4fsBKK2h3Prvu5AvLppI7QfJmZ79OG7TVDvAkWDHA4alRtg3F/8vOrCow==
Date: Thu, 7 Aug 2025 17:17:56 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: amir73il@gmail.com, brauner@kernel.org, corbet@lwn.net, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, luto@amacapital.net, 
	shuah@kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
Message-ID: <2025-08-07.1754550206-glad-sneeze-upstate-sorts-swank-courts-YKmj7E@cyphar.com>
References: <2025-08-05.1754378656-steep-harps-muscled-mailroom-lively-gosling-VVGNTP@cyphar.com>
 <20250806102501.75104-1-safinaskar@zohomail.com>
 <2025-08-06.1754489257-elated-baubles-defiant-growls-beloved-jewelry-9Ofm2b@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s5bgiurac7jxabhb"
Content-Disposition: inline
In-Reply-To: <2025-08-06.1754489257-elated-baubles-defiant-growls-beloved-jewelry-9Ofm2b@cyphar.com>


--s5bgiurac7jxabhb
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 2/4] procfs: add "pidns" mount option
MIME-Version: 1.0

On 2025-08-07, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2025-08-06, Askar Safin <safinaskar@zohomail.com> wrote:
> > > I just realised that we probably also want to support FSCONFIG_SET_PA=
TH
> >=20
> > I just checked kernel code. Indeed nobody uses FSCONFIG_SET_PATH.
> > Moreover, fsparam_path macro is present since 5.1. And for all this
> > time nobody used it. So, let's just remove FSCONFIG_SET_PATH. Nobody
> > used it, so this will not break anything.
> >=20
> > If you okay with that, I can submit patch, removing it.
>=20
> I would prefer you didn't -- "*at()" semantics are very useful to a lot
> of programs (*especially* AT_EMPTY_PATH). I would like the pidns=3D stuff
> to support it, and probably also overlayfs...
>=20
> I suspect the primary issue is that when migrating to the new mount API,
> filesystem devs just went with the easiest thing to use
> (FSCONFIG_SET_STRING) even though FSCONFIG_SET_PATH would be better. I
> suspect the lack of documentation around fsconfig(2) played a part too.
>=20
> My impression is that interest in the minutia about fsconfig(2) is quite
> low on the list of priorities for most filesystem devs, and so the neat
> aspects of fsconfig(2) haven't been fully utilised. (In LPC last year,
> we struggled to come to an agreement on how filesystems should use the
> read(2)-based error interface.)
>=20
> We can very easily move fsparam_string() or fsparam_file_or_string()
> parameters to fsparam_path() and a future fsparam_file_or_path(). I
> would much prefer that as a user.

Actually, fsparam_bdev() accepts FSCONFIG_SET_PATH in a very roundabout
way (and the checker doesn't verify anything...?). So there is at least
one user (ext4's "journal_path"), it's just not well-documented (which
I'm trying to fix ;]).

My plan is to update fs_lookup_param() to be more useful for the (fairly
common) use-case of wanting to support paths and file descriptors, and
going through to clean up some of these unused fsparam_* helpers (or
fsparam_* helpers being abused to implement stuff that the fs_parser
core already supports).

At the very least, overlayfs, ext4, and this procfs patchset can make
use of it.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--s5bgiurac7jxabhb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJRTJAAKCRAol/rSt+lE
b8vQAP4i3lUz0raHzBGHmCX+UhlLhpD2d850DSh9njsFS7RknQEArL1ac/38BwlE
Qey3BzoNaEAAXVm8ZejpG1aKW6NoJAQ=
=Xy1s
-----END PGP SIGNATURE-----

--s5bgiurac7jxabhb--

