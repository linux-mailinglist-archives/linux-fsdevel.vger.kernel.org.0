Return-Path: <linux-fsdevel+bounces-79375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKQqGXI4qGkTqgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:49:38 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA62200B19
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Mar 2026 14:49:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3B613020FC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2026 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECAB539FCC0;
	Wed,  4 Mar 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZaS3RWOT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B629D27A;
	Wed,  4 Mar 2026 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772632139; cv=none; b=idqOmuTXPOUz8DivAi+JPQ025paRRPbMx5C/oxA3y+8YgLqJwbvJZ/VTHBHa7zUoZA2LDWUJxV3ZA3iRHPD+f6cpwwXfUNeLopUGWfShrMV6Uvolm6gChr0FhTetE1AIBwqRSs64iTJj6Bn71ulqVrAt+H4svWsj0urqwuWNBDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772632139; c=relaxed/simple;
	bh=Jr6DsopwGUBqcray5BvRdrHJDVFD0HbviFZXBvRLfRw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LIt7IaJ4R/zM+6i21ZFVe4zX9oPSNyJAhauFbNzf0QPMEDpAkcGzrsGBLyzI4xG7gc6jwhKqMM6OgdAYnLtKJnzF728LvZVhXNdUqQCIh43M4mL1t9Z5vzG7eyEqstsnBLEtGKAdEiUNBiZw0hdEIwNZuu76cvQRDjNC5lq3X2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZaS3RWOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B571BC2BC9E;
	Wed,  4 Mar 2026 13:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772632139;
	bh=Jr6DsopwGUBqcray5BvRdrHJDVFD0HbviFZXBvRLfRw=;
	h=Date:From:To:Cc:Subject:From;
	b=ZaS3RWOTG/2NwRXE3IsOIGOGunsXPK7shhvQDxaQmHv8LvmXmgVcpy4WFT/IRlrHL
	 YhvHQtzoQSUikiBBehbawbBUo/b5Ftrb8gu4BSEJXeHRkhFK5rSZJlpRvP6RPogLlX
	 EO0UNtFCgD7voJ03sZwr2m14nGVCN4q07b3nmB4BFOaHSUoKmXFTe0nLZtTOzA9Xwo
	 UuyXbP7eug7Ci1ZexMlrJe8FJUFdzX2LFED2m/GAud7th93ScbCQboKBl+8zDpbHxR
	 ykcyzmbqTaMf9ho36LveYfqK8JACVkulOx9Ri+ROcobLywP8TxGFmPQ9U8cJIMSrRY
	 tA44QGQrh7Icg==
Date: Wed, 4 Mar 2026 14:48:52 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, 
	Colm Harrington <colm.harrington@oracle.com>, Gerd Rausch <gerd.rausch@oracle.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] sysctl fixes for v7.00-rc3
Message-ID: <nya2yy22oifvepb4g7q3kukfq7f3s5zoab4yb7ahkcn6t7qdfv@eknh6exiog26>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7qmzvoet4kzde34f"
Content-Disposition: inline
X-Rspamd-Queue-Id: EBA62200B19
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79375-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joel.granados@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action


--7qmzvoet4kzde34f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Linus

Please pull very small fix for sysctl

Best

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git tags/sysc=
tl-7.00-fixes-rc3

for you to fetch changes up to 6932256d3a3764f3a5e06e2cb8603be45b6a9fef:

  time/jiffies: Fix sysctl file error on configurations where USER_HZ < HZ =
(2026-03-04 13:48:31 +0100)

----------------------------------------------------------------
Summary

* Fix error when reporting jiffies converted values back to user space

  Return the converted value instead of "Invalid argument" error.

* Testing

  Spent around a week in linux-next -enough for this small fix-

----------------------------------------------------------------
Gerd Rausch (1):
      time/jiffies: Fix sysctl file error on configurations where USER_HZ <=
 HZ

 kernel/time/jiffies.c | 2 --
 1 file changed, 2 deletions(-)

--=20

Joel Granados

--7qmzvoet4kzde34f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmmoOEMACgkQupfNUreW
QU9ymwwAk5NgP4FUi47/nYzXAgJfY61pyQOtS43JeiJZ+85jSgH7OPh0PGdbcsjL
484ohrMp0UnYNme4aYel0P8Xh2ql3pm+4YiMd1UYFCKvqDFr/FuKWeosEqAw9U0c
i/oOeT7tsr3FxMM0/mnGocMqRlceIC+PzkFZst5cnKflX38dj2zDTFZwpV0BaIJH
E2zEAC4XZy5H+MMUZtHo0l+TWx0OgVIDn/cKbpUBF7XKGXXQ06L+BfPKP0/ecuat
o2Xz/A8/yeutI3UlHl3d/Bun6Twm2D6P6scyLbfq5QblTE4pHtem09cU7VGbREQm
5LOHuuEpFxHBsw0weiiUTABz4Uz0XOxv9OMI6gE/glVQy1PFoVH831twIEVOh4uH
JDVJQ2EUC1fXiqWl2MBGxizcW6k4rwFkDCF2jrTSg8n7T8XRj8/uWnSc5Etroc7M
hvujB41au1G6VxA5ccv8FR6ZynKb/VnQSIXHKq7NxLOQnGELlk5tRVsS+oCE5J/N
xCYQHMQE
=rs6/
-----END PGP SIGNATURE-----

--7qmzvoet4kzde34f--

