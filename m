Return-Path: <linux-fsdevel+bounces-69995-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 215CAC8DCC2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 11:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 943653468F0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 10:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699E5329E65;
	Thu, 27 Nov 2025 10:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZiDWamt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADB579DA;
	Thu, 27 Nov 2025 10:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764239763; cv=none; b=FsI0Epru4QR/SjB8hOgr2I1bkyjmHAsanU8o0AyTKdtEKcda7PaTKszjiQ8sJPYa4QnPwFhsP0DTwq15DZWWiKG4Tkdd+tEsGQUaF0jS8RLkkDeJgw8LRDwulUCoPZk38XyToHVt7zIVX1VGag6sQHpYl88fWmwkrJOGqxI3yjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764239763; c=relaxed/simple;
	bh=zL8mz3J9kHqxw7t3BWknBnpVkGzh0V2YgO7SiDU0Pfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFeLSn4WwZ3a7PcJuL0UX/IOUzakThnGCu3Rwph1eICs1415Sc6oq/jCsmmdBIa3U15hchW5rVKhvvEhRoY6QkhMoIxHwvTL3vjXck7r9Dz3hPcjUyVxWGEet5b6bHQNfqvJLJ12u6SAr4QJPzWcdpavGSHdEqeGALRb4QUkWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZiDWamt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B050BC4CEF8;
	Thu, 27 Nov 2025 10:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764239763;
	bh=zL8mz3J9kHqxw7t3BWknBnpVkGzh0V2YgO7SiDU0Pfs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZiDWamtHG7lJ6FaU/w9R1Pb1V1hO6+QYIEUANhAx8K/285IWAQgt8COTkBsGBvsP
	 0RuH0E9DzcScX0TugNFm+ACINbzCzIE00way5YTbug01FzXfPXU/EZguUKlv4RmLrI
	 tSoU9do/HSWH40uDVcZlmWQjEseL1aXeeSFIrxOzzE1mOud6M5XB6XH1VAXzI95lWB
	 1fk0r018PuixmShgbElcPQLTvI+ehLd7+zeL0d9/ZME1pfO/mZf4K7YCgfdVbx1JIi
	 gxvOFqm6ZraKliJh7IgJuuzColnO5CQ/Q9sZR8NEaFZDTHa0oFZVuk5fPvIxgAiiwv
	 LnJyA0iiYVWog==
Date: Thu, 27 Nov 2025 11:35:55 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Cyril Hrubis <chrubis@suse.cz>, lkp@intel.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, oe-lkp@lists.linux.dev, 
	ltp@lists.linux.itccccbjfeunckknjvluceftfithdduijkhkcinjndvek
Subject: Re: [LTP] [linux-next:master] [sysctl]  50b496351d: ltp.proc01.fail
Message-ID: <774fersjoa3ymtmorfoxs7xei3vjdf5h4dohkkjjgxo6qgpz5w@kqn6du5d62m7>
References: <202511251654.9c415e9b-lkp@intel.com>
 <aSWI07xSK9zGsivq@yuki.lan>
 <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ryamdsvedtvawmwp"
Content-Disposition: inline
In-Reply-To: <aSZnS2a4hcHWB6V7@xsang-OptiPlex-9020>


--ryamdsvedtvawmwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 26, 2025 at 10:34:51AM +0800, Oliver Sang wrote:
> hi, Cyril Hrubis,
>=20
> On Tue, Nov 25, 2025 at 11:45:39AM +0100, Cyril Hrubis wrote:
> > Hi!
> > > PATH=3D/lkp/benchmarks/ltp:/usr/local/sbin:/usr/local/bin:/usr/sbin:/=
usr/bin:/lkp/lkp/src/bin
> > > 2025-11-25 05:37:33 cd /lkp/benchmarks/ltp
> > > 2025-11-25 05:37:33 export LTP_RUNTIME_MUL=3D2
> > > 2025-11-25 05:37:33 export LTPROOT=3D/lkp/benchmarks/ltp
> > > 2025-11-25 05:37:33 kirk -U ltp -f fs-00
> >=20
> > Oliver can you please record the test logs with '-o results.json' and
> > include that file in the download directory?
>=20
> I attached one results.json FYI.
I can see the errors and I can reproduce on my side. I'll take a look.
thx.

BTW: I saw this path in the logs
/proc/sys/net/ipv5/neigh/default/anycast_delay

not sure if "ipv5" is part of the suit, but worth mentioning from my
side.

Best

>=20
> it need some code change to upload it to download directory, we will cons=
ider
> to implement it in the future. thanks
>=20
>=20
> >=20
> > --=20
> > Cyril Hrubis
> > chrubis@suse.cz



--=20

Joel Granados

--ryamdsvedtvawmwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmkoKXwACgkQupfNUreW
QU+BoQwAkwC41SRb0XdYola4gkKhmFmXmfgWCSDrg3H0QpcoPIR7dRNCjuKGR/nM
VWAkD9Dhr5ghHAhSPwzKRydLz7VskDqdusnAnaUkJKl7Kjx1e4NjSsDIohwHT6oc
qbqNi8xDTNRoNO7mJnGIJu2tDn99s7U303q8RDIf6kfJ4PN5Cyl1R9T2u7rDN/XO
SXCwjizCPW/shyLBys/B6f2zlIHX629kDMrVM6SwkA02bcqK52IOsvf1JWarJdN1
brZKlSxfh47z+obIcxCOWWXDmsJMVIQQAtasfXfCB6FkG4T5+MS0+BMkFOsNzTIG
1nMwZ75Wo3bCEHTGrBj/uLxNkW/D70ggkhxsHRox3wrSpeneswXsyBwBotXbJdLr
PWMJNV/ZOr096pyosBypCEpVI6M3YE7TarwYzFI/qaApVXTBuGBydVB5BVJjWJ/a
itv4h0P2rQchSpdKun9NUYUgEqi3ylCKD7kyR9+369HyCBICClnCxOHux+LazlGX
4FSKrHm5
=8z8u
-----END PGP SIGNATURE-----

--ryamdsvedtvawmwp--

