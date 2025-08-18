Return-Path: <linux-fsdevel+bounces-58201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22629B2B0A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 20:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04BF6845E1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 18:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFAE270577;
	Mon, 18 Aug 2025 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hjjs97Rw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924FE2594BE;
	Mon, 18 Aug 2025 18:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755542471; cv=none; b=CYBSE7fkclgS1QVhxA141SY3fLd5YoCJ4cdUPWBWaDdgv8kYsU8kfjKzKOC3tW5NCSZlvvwh2mee5kbyo8CVd63XdIv3OzS8mHOzzuu+qomfu/K4lb8/QDZCd8GPsL3i0mzONMRECpgbzCXeVp6wkp5vK42m4+4wQ86SMVxd0Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755542471; c=relaxed/simple;
	bh=00jJjtQgwxgQYc0vYn1fSx5RCac3GGXo8k5yfg3ZyBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hDZ9+jf1hUoRSz0JEugKnXd26kWQii6T+apm1OI+CSWPpwK8aI8AiNymSQOc+M5J51CwxF/eH42Vp4LRQWh4J9qycvp8yt31h0pweRneQPBUQQeFn6IfJ16l+OMIRtCUY2IKkM0avL+TIb0owWOCrDBsyAMcFhYiyxNVWoC2U1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hjjs97Rw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06ABC4CEEB;
	Mon, 18 Aug 2025 18:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755542471;
	bh=00jJjtQgwxgQYc0vYn1fSx5RCac3GGXo8k5yfg3ZyBQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hjjs97RwCoyJS+jrSYYKqzhr9A7RRgWdp/k+4jWP/XOxoFEP/WfaWosrhWoq04ehg
	 ZkQoqhsEoe7/Zo14YTwsl0dinWCA7X/+Fg8nNg8Zk2cqQ6ojjgrxdSgOof/CofVHIX
	 YQqwHTN1ZzQv9S2LtNFSJ/Hev21qmEqk4t38MuJKaVoLnLTtw06AceUQf8zjDNuaF+
	 rReoKt0Tidw0p9LbzDYmEK1YagAW44gkvFEBZpSdrIbVQE9g0h0EXlaJ1Zd0+ulkG2
	 9PU48rS0zr5dq0gKsOyb+T9J2wsAD/Yr4dxFhVNRZePlRuOQahx+yIpLJ83lkVja7o
	 OzkeqoU0desVQ==
Date: Mon, 18 Aug 2025 20:40:23 +0200
From: Nicolas Schier <nsc@kernel.org>
To: David Disseldorp <ddiss@suse.de>
Cc: linux-kbuild@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-next@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gen_init_cpio: add copy_file_range / reflink
 support
Message-ID: <aKNzl1Oo2zzPYGQP@levanger>
References: <20250814054818.7266-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TvJB5GczmYFhf6cP"
Content-Disposition: inline
In-Reply-To: <20250814054818.7266-1-ddiss@suse.de>


--TvJB5GczmYFhf6cP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 14, 2025 at 03:17:58PM +1000, David Disseldorp wrote:
> This patchset adds copy_file_range() support to gen_init_cpio. When
> combined with data segment alignment, large-file archiving performance
> is improved on Btrfs and XFS due to reflinks (see 7/7 benchmarks).
>=20
> cpio data segment alignment is provided by "bending" the newc spec
> to zero-pad the filename field. GNU cpio and Linux initramfs extractors
> handle this fine as long as PATH_MAX isn't exceeded.
>=20
> Changes since v1 RFC
> - add alignment patches 6-7
> - slightly rework commit and error messages
> - rename l->len to avoid 1/i confusion
>=20
> David Disseldorp (7):
>       gen_init_cpio: write to fd instead of stdout stream
>       gen_init_cpio: support -o <output_path> parameter
>       gen_init_cpio: attempt copy_file_range for file data
>       gen_init_cpio: avoid duplicate strlen calls
>       gen_initramfs.sh: use gen_init_cpio -o parameter
>       docs: initramfs: file data alignment via name padding
>       gen_init_cpio: add -a <data_align> as reflink optimization
>=20
>  .../driver-api/early-userspace/buffer-format.rst   |   5 +
>  usr/gen_init_cpio.c                                | 234 ++++++++++++++-=
------
>  usr/gen_initramfs.sh                               |   7 +-
>  3 files changed, 166 insertions(+), 80 deletions(-)
>=20
>=20

Thanks for the series!  I have found only a minor nick pick and some few
bike-shedding things.

Reviewed-by: Nicolas Schier <nsc@kernel.org>

Kind regards,
Nicolas

--TvJB5GczmYFhf6cP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmijc5IACgkQB1IKcBYm
Emnfpw/+LnSnZraMATj6DEcbSZSNQls5OfXXPLBEy+MTIbHCKirNdUuF9Ql8Ee3Z
g5XzyjvYvoocN4fhJrbs1kkwHyN8erwtPdD29pLsAVobHdVROBPH9QibE2bsnf79
HoOoMucHvi7CnvdNOwm5Hyk/n1nKuAc6+ZLRsFOv7Ki/2cDJog5duwpmIXaYnSo9
9HCegIlW8WEBcfyTpmO0RNf2GzBIiSzn7WTOOLkf/9tkj6I+EeByeY56awyEI0t+
QhgR0DhF2aJ8DYZpriWH6ZsQG3Sg3WSPIcKCgIlD0PrjCYhYQyyH2lMZZts5f2nl
d0JwK+pjNJtUBjeQz65gmjzHsaXBpAzPAeMOlbxZZsQmLyD3NpTgNkhENLDh4C+q
yARM3blndryvDRt1201C2TgE+HzKqRi/PPctn2BErlBqBt0lKcvk+mZVMgpiGhYx
ix6XAxZPzGCtST7Xd5K3fiIHkg/r6LAyHd6oTvWXokID4RUVUJX0nA8xhg5Gwqxs
KvpR1CU1tzBMjxfh7vhpy6BbKPz68ryI26gQGl2sCkiOjiujthq95GNVd06pmMYc
oJmd0HGNakPpxpbeiuIB8oRwQ+Q8I92fbOkK80nibWAwee9iKBkZv5jHtpccCJZk
9uEJw17fkET7z4GXRvwYvNrbKHdEV2FdNS/CkNAfjSNsCVrjfj0=
=saYz
-----END PGP SIGNATURE-----

--TvJB5GczmYFhf6cP--

