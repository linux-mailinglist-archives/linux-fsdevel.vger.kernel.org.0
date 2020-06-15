Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C701F951E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 13:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgFOLRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 07:17:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:40102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOLRw (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:17:52 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 896B52067B;
        Mon, 15 Jun 2020 11:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592219872;
        bh=vGp30WGjqpi6hQnqDxaA4BomUK/DJXnaGz4+haXr+vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPcfwXsIfB0tpAjRRF/lIoOIITmNm46a2Esg1C2o2xVcNAMeA8uRLemu5FfJW+psU
         b00Wi33bQiR8+d3wq2W190ShBwgzl62ErdbC3hkH1wET61vVpjtJE9aHG+ry7upsUl
         7fFnnHtRDdiKxw7MVU1j/ounFW6mL3dHaLnaJ5oo=
Date:   Mon, 15 Jun 2020 12:17:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 28/29] docs: fs: proc.rst: fix a warning due to a merge
 conflict
Message-ID: <20200615111749.GA4447@sirena.org.uk>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <7d46aec2cb7a5328d260c7c815b9be9737b43ee1.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline
In-Reply-To: <7d46aec2cb7a5328d260c7c815b9be9737b43ee1.1592203542.git.mchehab+huawei@kernel.org>
X-Cookie: Offer may end without notice.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 08:47:07AM +0200, Mauro Carvalho Chehab wrote:
> 	...
> 	bt  - arm64 BTI guarded page
> 	=3D=3D    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> Fixes: c33e97efa9d9 ("docs: filesystems: convert proc.txt to ReST")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---

I acked this when you sent it previously but you've dropped my ack - I'm
not clear what's changed?  The prior ack was in
20200603095428.GA5327@sirena.org.uk.

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl7nWNwACgkQJNaLcl1U
h9D6Cgf/S+rl9IwipzkJkMBWWgPo961oXqYZmsADl/6GLjjgaohqh5Ayl1p4KDnk
cRzkI8+FgIk5FJ+84PxKHem4MSquTyU1blEiNccPDQ63ZXT1TjgR+GI/D28JhHNR
5TUbUOYjfutIK3wx/bum0DgindQuQTJf+cnMy+TEkCc1WQTcRGj2RVrHkKXnpbjg
wu/J/xttoFBgPIoutP1nJG2ZLIP/uwo1DoWzNdDjvgKUh/7TmsXxWUv6TX8zzeXw
xQDZQQQDYifmqsXCdvbwab3NLYFp0kjFIwxXiNAG0bWK6/hjnkxBhal1sJ5WP/Hs
0M+m9WltBHxZ3AZOBDaFJ/QYGmugMA==
=InTp
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
