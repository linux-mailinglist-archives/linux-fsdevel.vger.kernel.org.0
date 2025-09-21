Return-Path: <linux-fsdevel+bounces-62328-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCD4B8D7D0
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 10:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E806189CD19
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Sep 2025 08:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D132451F0;
	Sun, 21 Sep 2025 08:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tStHYV+F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197522FE10;
	Sun, 21 Sep 2025 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758444004; cv=none; b=ZCgwUeeg2/d2I0JM69KT58jIeANgPTDsCf81IN89t53/Jv1WoAwMnFSsYrd5jhw6Cp3jN09l9CJnk0Rxho9g04aJMyXumbesNc1W4l3uSJNW47OWawuSYujRBxoRtgbrGYqjfyKzAKaWpSny9Z7yDDH7LOOnBHX0Yul/rSwxbng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758444004; c=relaxed/simple;
	bh=7Mg1A2em5QuLOTyRBbjxOysqGsEgru9LbUeLXQ2/i/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeiY8bTEHWBBU6MyG/qSXoPXJY6cTHjWOgjQ/Cvj7Wi7twxE3BH5sdupW4eYxdfOHj4b6rsRYD7rdTqVRcvY6vtrb35K6Oy6cnso495qEGrkTGdbwDb0PbhGsVTgQE0NgnxHAcQ/xuFXG4ZnqXhF8VdtZ9c4ewQBBInbZUstK2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tStHYV+F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D136EC4CEE7;
	Sun, 21 Sep 2025 08:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758444003;
	bh=7Mg1A2em5QuLOTyRBbjxOysqGsEgru9LbUeLXQ2/i/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tStHYV+FTE5mdS0U9g36hb5hc0zdO8yrvenlKghNbKgbayynKSRI+2p6GvfhqX1h8
	 iEjRoyIVs+++f/OdQ36CbZ75dWcwSgmX1Y5vaU/hCPpmGraH3Y6Qu5ZCbLnEbPSWf3
	 thZcVRkMdpdgtoNwjKlvP1gJnXPbw7N2GfFuT3WroWPV6gr5zeiH3fMliDyA392uoN
	 nJpoqejHHlwFVOSnDUD5VpRK3XJZb8L6tDH7hqNE0VsSCF+pjYo8HBvnCeh7mPlfwO
	 bal/tNWcShca03Am8g9kY63eLaZLUp6pFex/vufdTiWg6uO8fED1TRH5TeU/k2MGc8
	 vyyl5unmpvsEQ==
Date: Sun, 21 Sep 2025 10:39:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
Message-ID: <s7pu5gr4w4pztdlzs4m2kigthny72kkwzap53nftt4lfgsqff4@ipz5l45r7xen>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
 <zrifsd6vqj6ve25uipyeteuztncgwtzfmfnfsxhcjwcnxf2wen@xjx3y2g77uin>
 <2025-09-19-movable-minty-stopper-posse-7AufW3@cyphar.com>
 <2025-09-21-washed-creative-tenure-nibs-hssPyL@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qbqsuuobjsbxjbi2"
Content-Disposition: inline
In-Reply-To: <2025-09-21-washed-creative-tenure-nibs-hssPyL@cyphar.com>


--qbqsuuobjsbxjbi2
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v4 02/10] man/man2/fsopen.2: document "new" mount API
Message-ID: <s7pu5gr4w4pztdlzs4m2kigthny72kkwzap53nftt4lfgsqff4@ipz5l45r7xen>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
 <20250919-new-mount-api-v4-2-1261201ab562@cyphar.com>
 <zrifsd6vqj6ve25uipyeteuztncgwtzfmfnfsxhcjwcnxf2wen@xjx3y2g77uin>
 <2025-09-19-movable-minty-stopper-posse-7AufW3@cyphar.com>
 <2025-09-21-washed-creative-tenure-nibs-hssPyL@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-09-21-washed-creative-tenure-nibs-hssPyL@cyphar.com>

Hi Aleksa,

On Sun, Sep 21, 2025 at 11:33:34AM +1000, Aleksa Sarai wrote:
> By the way, I'll wait for your review of all of the remaining man-pages
> before sending v5. Thanks!

Okay.


Have a lovely day!
Alex

--=20
<https://www.alejandro-colomar.es>
Use port 80 (that is, <...:80/>).

--qbqsuuobjsbxjbi2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmjPudsACgkQ64mZXMKQ
wqmaQQ/+J3mtnGHI9f8LXfNdo4HIOQIqOyJA+YhbvCg48STVcaCoui83fQ4SB8dn
eoOfEPx1QKcIwndwk1+oGzhX5QwKCrLh8kVyRszd9kaIG6vo6f/zss27pQJSLXbf
U1orTuZHn6PBLSy27/mqLuoKICpGjDn1EnnmVKtOg3biPSt/40dRqH5+HDvINFNq
kPF770fWjulb4UGN7H9mDDsLVrtCaO042nqGoVxZysWCvhFNxtiPJnFwpcoGBvM6
mM9emVPTmnWNtC7YcI5Ocr5DMg+tPZXxz7UQKfGbnEa9KXZ9CuY4C0bH+TlpniZn
a7zEHxfcTHD4XHN9xs5qomQzWwisqZD+qCvMXRA7nae3gn+XU2+hazm6udu70nFM
dTCLW1SPm2JS9lMbpXzo8QPuO/6G6OWtlojRCfjQlFqwwES3LhE9Fd03YZl2zTbz
IuOydhjxYBPaD8D7T5qRWg77lTH+x+o6izbNZeqgnqMYVWbUoZtuDmYvs/l0yQYy
1lwn7dclVnfZU402WqMeRMIiadIUBfgKY0s8LMRKCCVA7HaYK1CIZIlzfOryp+tg
Q/DAT6pGqnS/c5kSIQ0RykphwgA69UMp45iz81/Gszb/EyNPNx0rkxjrF/ln/Nsd
8Mbvjieemk/3ryji+s6sYiZFwdSFuvGQvXoM/UFWaItcuN8Q+i0=
=PDoE
-----END PGP SIGNATURE-----

--qbqsuuobjsbxjbi2--

