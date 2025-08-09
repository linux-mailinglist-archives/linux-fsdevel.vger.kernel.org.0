Return-Path: <linux-fsdevel+bounces-57176-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F2B1F51F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 17:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542BC72348F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 15:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DEC2BE642;
	Sat,  9 Aug 2025 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2/19yAt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454D17BBF;
	Sat,  9 Aug 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754752282; cv=none; b=iytLXb2mIAvaZ2B8cNt/QYQWgHZbYJ3JVjsaRtNcsl7irKSbJ03E60XCE5JJW9rEnRo3+DyMmx12RA04Sd2G5+fr5lGreKuDKgdmDR2S1g3kc2HGFaHpFymtEBVIKdMVfO5z5YOO5gxsUOCTphpvwboVJPyQQ7/mkJtZQGvVlNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754752282; c=relaxed/simple;
	bh=BhS3HRXxT+sx1bATKCLtXSnUt9sLxxwixSdD9UdlhhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdTjdYP7QW8pidu0vl3iGrgAsKKrt/S9Ep8R/5WWCDDkghpvOvk98p9OXEBDt7s/+64pe3H2vt1HgGDfM8tS9QGdgRjdlJO3xaoiglVKTxNHSxakmtszUHc7TIWM8GfOPYFMg5FDwQ7HaDY1ig7LYjDhBe40lXGZQ9jiJFXwpU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2/19yAt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CCFC4CEE7;
	Sat,  9 Aug 2025 15:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754752281;
	bh=BhS3HRXxT+sx1bATKCLtXSnUt9sLxxwixSdD9UdlhhQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2/19yAtPI2ZJlhHMqnY0xVvGfeEC9fA1PYKWa2q8NOQ/47tTkY6SW75vHJBuWT8L
	 W0UIAv64Z7Zf9nFho5qGjQa8yOPMrTaSyOCpSVlD2SWnCN893d7ELvkO2BBH/Yud/O
	 QniRcmbj3z/8YFJU9xqE2+wyGxiOGwpxSucgCu4oAwcwlvBW0UfWnj1G4YweUqqCvX
	 k6eeq1KHc+XCwFpE1yNC4yQ2wJV3uOxBMIri4B7FSK+6sI+PnGq8JeQ+giUhIuDJYH
	 pQ1T28CU+BH5WHCTlFTW3kl1tQzasUTNA7Ow6KtrrtQmYEl8+DDeB16W7KEPh+vT0Q
	 7i2ziVvr90M6Q==
Date: Sat, 9 Aug 2025 17:11:16 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <3eloi47kuihnyaodnyssgzfrvkajlfy24ud6p2iushzftegvt3@elrhgezyil73>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5efhn6cvh2flbds6"
Content-Disposition: inline
In-Reply-To: <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>


--5efhn6cvh2flbds6
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
MIME-Version: 1.0
In-Reply-To: <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>

Hi Askar,

On Sat, Aug 09, 2025 at 07:04:06PM +0400, Askar Safin wrote:
> I plan to do a lot of testing of "new" mount API on my computer.
> It is quiet possible that I will find some bugs in these manpages during =
testing.
> (I already found some, but I'm not sure.)
> I think this will take 3-7 days.
> So, Alejandro Colomar, please, don't merge this patchset until then.

Sure, thanks!


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--5efhn6cvh2flbds6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiXZRMACgkQ64mZXMKQ
wqmQSQ//SYbf3wAmR5ZwnIBDwwtwwO/VzmasvrgLx4/JyyCNBPEnUwNfjPPPXBer
utn81VfWgmnvPrUV5v7ANsOh2CC1kLf2sE5jQdLIjTRfiCOTO8OM1N++fjdY9Rl8
E6d3qVbD42sQuIKyBOzFjFVV8TDwLM59VqaeZNEA/62yMcNu3A53WulL9tBUN6TU
nDQfmFSmMposD6wjPuMR/9bwb+F+GWJJCIxGLlpPKPm5xKeHHc2JspkkZYNb0Gr8
hWYR/IwdmiMEO1JHAWeUZZoFBVWyGAhM8yCbrsXGJDcGYCKvQqDSdo1SWVrLFKz4
c6x6DoXLC7NLdbSgtWojooNJXMsUf+zn6xDyCJfskhF7BbcrVkkag1VJC5Xu/QI7
ZVEJL54jeVxhThJjhKfCa6lgKgxJASBt6CQNWBCjzMMd9j/1MIBv6ZodIqnVcamj
6XgR59eLjCtExRbdlVqpFlLDvGGr5qtDLVdS1ml/tcOIVuQDKJG823QN13XyvBYv
JE5Gg/icDRGvzLC2fDcxhQKlLlr381n5bloN4HH36olfuptONgA3IVSDXFgTB0Vj
24WViJj5V9CzauFZ4Tp9iCJ76BVAtlyq+P52brMM5in6hflVu5CCuylCjmtLmChk
0LbymB31HdXdDyXW5Hx4w6fgCGoHRi+BWeo36KvQ1DWFKKyQOj4=
=oiyK
-----END PGP SIGNATURE-----

--5efhn6cvh2flbds6--

