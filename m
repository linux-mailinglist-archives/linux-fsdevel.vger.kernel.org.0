Return-Path: <linux-fsdevel+bounces-56993-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E07B1D96D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FEF175172
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 13:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B40A25E814;
	Thu,  7 Aug 2025 13:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mr8mJLNb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFBC221269;
	Thu,  7 Aug 2025 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754574767; cv=none; b=N+cBD+tBRAQDOHPYowYBZqRO4islP9J7c/Z1q11KgwWxSl4N6+aljL+teYzQEI0gbgxEsSRTWdOJ7ko7o2J9StpfaW0rut69t3xNZoWhUK3ZMs2T72sJTtbq4XOuVWPWVVJBwTSyQjjZ/L2tG04PZ8V+sJ5GFKyU5VkPGClWcpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754574767; c=relaxed/simple;
	bh=iV8ZODixFlQQUTPJW6A3MmqFtbVGwaA71qL/Ob3oMA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKQXdmF1SuXEbaAgnLMLuDJZ9IRywpsfCEudRILLfpxSpCWcE7JwIXs5Uyt9OQpXEd8HVc7xAI40l9VKIYoQzEbtzuy1tCNDBOsxv4dZvVv7agp9w0NeSk/OstVCb3pzn+doZKicxrb0jIckVQuQyuHbfI7l3ZfTo2DYw41swy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mr8mJLNb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96235C4CEEB;
	Thu,  7 Aug 2025 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754574767;
	bh=iV8ZODixFlQQUTPJW6A3MmqFtbVGwaA71qL/Ob3oMA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mr8mJLNbrbolDVzFzrYOrZoWNQbNuAign58UCd3XJBSXmg4aLktmmqh963W53fbzE
	 VF6+yra5s5wFoK+G76M5foTv3hyap/MAMCTSbfXxRRQPbQjjV3CHoZM4ioETyrjbqA
	 D+xeMlBkmYXmcMfQ21ZjccJcIRi0CNWkuqZWNuh4EVA35JZtsNCXAJYsbjibkaHRH1
	 KiZhPosneKMQY6qzx0vZ4qt4JXZi/0ZHwTeBTmHal8JGdGcJGCd1UgTw+vZzIRsNs6
	 CdoGC8k52FwNBavnF49hyUJDNRBTpfQgrZjhG4pnqMPcDCTA0REjRX9LtJHCyiRuOu
	 Nut79/rhJEvGg==
Date: Thu, 7 Aug 2025 15:52:37 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Askar Safin <safinaskar@zohomail.com>, 
	"G. Branden Robinson" <g.branden.robinson@gmail.com>, linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
Message-ID: <zax5dst65kektsdjgvktpfxmwppzczzl7t2etciywpkl2ywmib@u57e6fkrddcw>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bsuqqhomyowvpfnz"
Content-Disposition: inline
In-Reply-To: <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>


--bsuqqhomyowvpfnz
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
Subject: Re: [PATCH v2 03/11] fsopen.2: document 'new' mount api
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
 <20250807-new-mount-api-v2-3-558a27b8068c@cyphar.com>
 <afty6mfpowwj3kzzbn3p7s4j4ovmput34dtqfzzwa57ocaita4@2jj4qandbnw3>
 <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>
MIME-Version: 1.0
In-Reply-To: <2025-08-07.1754572878-gory-flags-frail-rant-breezy-habits-pRuwdA@cyphar.com>

Hi Aleksa,

On Thu, Aug 07, 2025 at 11:27:04PM +1000, Aleksa Sarai wrote:
> > I think 'author' is more appropriate than 'developer' for documentation.
> > It is also more consistent with the Copyright notice, which assigns
> > copyright to the authors (documented in AUTHORS).  And ironically, even
> > the kernel documentation about Co-authored-by talks about authorship

(Oops, s/Co-authored-by/Co-developed-by/)

> > instead of development:
> >=20
> > 	Co-developed-by: states that the patch was co-created by
> > 	multiple developers; it is used to give attribution to
> > 	co-authors (in addition to the author attributed by the From:
> > 	tag) when several people work on a single patch.
>=20
> Sure, fixed.
>=20
> Can you also clarify whether CONTRIBUTING.d/patches/range-diff is
> required for submissions? I don't think b4 supports including it (and I
> really would prefer to not have to use raw git-send-email again just for
> man-pages -- b4 has so many benefits over raw git-send-email). Is the
> b4-style changelog I include in the cover-letter sufficient?

Yes, that's sufficient.  As Captain Barbossa would say, "the code is
more what you'd call 'guidelines' than actual rules".  ;)

> I like to think of myself as a fairly prolific git user, but I don't
> think I've ever seen --range-diff=3D output in a git-send-email patch
> before...

Yup, I only learnt about a few years ago.  I have to say it's great as
a reviewer; it changed my efficiency reviewing code when we started
using it at $dayjob-1.

And even as a submitter, it has also saved me a few times, when I
introduced a regression in some revision of a patch set, and I could
easily trace back to the revision where I had introduced it by reading
the range diffs, which are much shorter than the actual code.

Maybe we could ping Konstantin to add this to b4?


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--bsuqqhomyowvpfnz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmiUr6QACgkQ64mZXMKQ
wqlqGw/9H2CSI4snzWFUExNlDa/nGng9n9BuowRW8WA4+wzYrIQM3E242OgZW+BK
QzXqKzJw4mY40yfo1k9+IoEGOG7afvdN7vS5UlTHGyyINUIMcqr//aG1Lk5Hiwew
kBVIQILQUb4lJKuF4ENJhAIBP9zOfhkG75H3pb6k3SDMZp3/BhROloEiqQu8fNQ9
nDDs6iPwv90Qtcm5sWd9fgllpOXu+kVKi2ebzJ2mv9LItpa5AWw2d19IpbVd8rR2
dM6aZWdBtiXRY8T7uRD25YTBIpB2Ji3rDMkICVIaHQU7Nk9OW+79m7E83B5V6nfI
U6mFSH0PlkLfs832OaWJLem5WT+SEhqiIt9vQkC68PtYCWPsYLffSDPdSZ/GZlA7
VOT/SLwdn0IWklWWGm7ALJfr6Mn/sCe6qAvjVTjl+KyJZPk1yecfvCzTPTVBqy06
h/yU4clhj/svFWO2G8sDVlpl+RlugsCcz/agVPFeIWM+W70FBEE4CnsGhWIGEcdP
vnSpYtsjh3ceu3V3dAU4ydMGanjyt+iyjs4cFfEQ9zXPnkFLZQ1J2IQs+LsPiQW4
6QnydM3Hp9WGvhNONPOfp85WzgsUaOEPxElmaWQNXsChSoI4wkyOQ6euoLbK+NaO
h2Mj4PVJ4fAYYEWTO/ThKF/P59lotVbTVuiV3Vt30tF1xUQqpx0=
=uMr7
-----END PGP SIGNATURE-----

--bsuqqhomyowvpfnz--

