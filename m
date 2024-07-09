Return-Path: <linux-fsdevel+bounces-23436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B941C92C375
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D25371C22A1C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 18:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD5C17B049;
	Tue,  9 Jul 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmPeKdgQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7013C1B86C2;
	Tue,  9 Jul 2024 18:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720550741; cv=none; b=UH11jUptjvH4GT2B/w3f3dmaitXG9qxJpkAd3qC7CC+hATc3npQQZmTpFcqPhdbRaKRnUhVVkVk9pg4jynvZZUvN81Jtlh0ASbAGIhaRbrWVq8tmeXJOSNlgJ3fLedv1J1QyZCT92X3C548fTzVEiyHNW/yXNPBBUX5wsTElWUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720550741; c=relaxed/simple;
	bh=EKO2IicO2ycBhWc0qjpq15RR+yI0SxcIPuFZqRFJT04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jaal6bJrxpS01WDZv5qtCdrcGbic/Rt6NPzs+ERVtayHGXGlWb0FJ3YzZ9tm4RbLVZpVqofmCnirPSVvFsWradjRO9ZQY+TbXcEpX0DNKOvnIUitCopwjyrgdlSXHl3w4u26vmMbnXEDWpQUxkAMo7lZhKK4zYOf9aooA8WA/WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmPeKdgQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A087BC3277B;
	Tue,  9 Jul 2024 18:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720550740;
	bh=EKO2IicO2ycBhWc0qjpq15RR+yI0SxcIPuFZqRFJT04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmPeKdgQafpQHgEiGxkH4lwxZDPNJ4ADLXZQ9PpvI0p+RsjnjJoXoFKXAI2/3pnS9
	 tMqT/nSyOYY0Y1FWhzp8fQv8Bj7LazThDAZqThSLDdFrM0amljYfwAQ3XpUMgHsQRk
	 FbC2B4MCVquGNMvH6KYc+wTt5yytNZFesrgX1uOPyV5HU2MX8er4PC4RiWlY60qisw
	 LeVNgZkHgVxzVi0kEC70tYVVQZciRyXFg3eljC7RS/x2b3TCOydMwN2BCdZbqKrel1
	 8Xw409dYXNrq0U0vdy96a52CduCpJNcogdjGCkU2iTcX36BvzIIPX8Hpmo/KB1qMvT
	 19GrxWDjGPjqQ==
Date: Tue, 9 Jul 2024 20:45:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] statmount.2: New page describing the statmount
 syscall
Message-ID: <x2banrgmwnvbyvyybdgpuslvkzdj2sno5q325abtji7ct2c3zq@vbec5kh5eln4>
References: <cover.1720545710.git.josef@toxicpanda.com>
 <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
 <fx5grrvxxxjx3cu5dej5uit6qsaownahwc644ku52vxcuzhhn3@dqjkofvlsopn>
 <20240709183724.GB1045536@perftesting>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gu2yr3nnb2wadcno"
Content-Disposition: inline
In-Reply-To: <20240709183724.GB1045536@perftesting>


--gu2yr3nnb2wadcno
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, mszeredi@redhat.com, kernel-team@fb.com
Subject: Re: [PATCH v5 1/2] statmount.2: New page describing the statmount
 syscall
References: <cover.1720545710.git.josef@toxicpanda.com>
 <009928cf579a38577f8d6cc644c115556f9a3576.1720545710.git.josef@toxicpanda.com>
 <fx5grrvxxxjx3cu5dej5uit6qsaownahwc644ku52vxcuzhhn3@dqjkofvlsopn>
 <20240709183724.GB1045536@perftesting>
MIME-Version: 1.0
In-Reply-To: <20240709183724.GB1045536@perftesting>

On Tue, Jul 09, 2024 at 02:37:24PM GMT, Josef Bacik wrote:
> > s/NULL terminated/null-terminated/
> >=20
> > NULL is the null pointer constant.
> > NUL is the ASCII name for the null byte.
> > We say null-terminated, because someone (probably Michael Kerrisk)
> > thought NULL and NUL were confusing.  :)
> >=20
>=20
> This is probably worth adding to 'make check' to save you time from telli=
ng me
> to do that when I screw it up again in the future.  Thanks,

Hmmmm, interesting.  Maybe I can come up with some rules for common
mistakes.

Cheers,
Alex

>=20
> Josef
>=20

--=20
<https://www.alejandro-colomar.es/>

--gu2yr3nnb2wadcno
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmaNhVEACgkQnowa+77/
2zJglQ//f4RLZHzcxpt8GGhMl4d2EoYFCA1VxVR4yhIkr26RzmURHIhL1HZBMnUc
Y1likdVTytZhAMVRzImTGt9REXb55NyYfpyBv0HIGJVvKI8DbNW5cS8NiMymbhHo
v0IaeZA8JOQWg42euVnrxmQMLPo8GeufgYRCZHYtx9U0qY6TCXCx8SoyRnC6pNnk
EDvAQmfAAEqcwL8HNX2akET9Qo73wTzV4FeFpjiesWRsvFXRBeVqmaZxen7ItT+g
poSF3PAxdf4FagcN6yuAQM7asqv6ID3ppF9UJnhJgEBtCZowGgrtEdO4X7D7nUhm
N3Oy9ijlrV1IlaQnI319xtp2rtYW6w49YfnKVcK6PQK+0If5KCdH0VnY6ENbe0kN
nbseVGTYVTfwrMuIqCqVnsVbuJJl70J6bPsbGgVvVgDL7lBHS8AWk/zwH/SskEYk
KhFSpdq+S++hwtz/P0roHB31rFd18TCQIHOZ3AnKP1OpNLYkgokgLzsxZviQP4kq
Gip/8M2cXeAmJSMYK9JWcjRrBN8ZTezWsHrkFbdiuOpCLRyeekYUI41PajiKTjaW
sj+hNQ112QAS89ZKHzaf4/JaB8soO7lheMxK2jetFqN7PsclQOVLfwhB7YB3FuKO
9cYDHC/ExhoBgh48EctfPavMIHB+OVGzuZD+EJJn7d/uwuosAfs=
=q0br
-----END PGP SIGNATURE-----

--gu2yr3nnb2wadcno--

