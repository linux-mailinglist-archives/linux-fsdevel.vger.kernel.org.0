Return-Path: <linux-fsdevel+bounces-22273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1530A91576A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 21:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C8CB1C22CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Jun 2024 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A9C1A01D4;
	Mon, 24 Jun 2024 19:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qk/SDH+W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377091EB56
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Jun 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719258795; cv=none; b=fDfaZyKlZllNEldqCYrHctkNrviKQTRGuChGbkGG5I7Y+aJXuv+LFF7HX30AHS7vfdq7pjRO7GdDePTznNqaFEQn1FrKTFPmBfnrYubm93pjpeWKXo7GYpjCphFFIJMY/x3ljbxpg/nudVFvL4PN90ta0T54LN4UZQ3yR4XLFUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719258795; c=relaxed/simple;
	bh=KDvXeHMWTvvNavRA61R0Bz8RX6FcNwwcylYt+2Eommw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iRoKiBWDy2qsUU0yeKyrUL3f2l33LA3kaWL9TCkunKaJhGa38LPIXJiLFNpBIHRk0oiQ00NPzZot3ngPXWN+Q0JttORAtv/6srFcmONafb+JzkMrzRSrPAu0q5KPigL1IVzC4ObEzes+LASX1ldmJiWUEeReXowuApFiOxemOA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qk/SDH+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19158C2BBFC;
	Mon, 24 Jun 2024 19:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719258794;
	bh=KDvXeHMWTvvNavRA61R0Bz8RX6FcNwwcylYt+2Eommw=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=Qk/SDH+WOVZxKez1rmCy6+pfeia4f8+Yd5tQilfaS9ljsCaX8ympc277ajvylG2Xf
	 6aaIYyObDe0SIMJiwR7PrLhuwtYIdAJoEPGmjx897M7gdgP4h37k71lU0v+5DOJ5fQ
	 UBc/7ZpdSrwACN45FENZJ16mCgr1PkMfoDiouXLq4e3HXTzOaUru1eCo9kzXBPFDM1
	 TRfx8Xk32Yrn/lGEmheSDkqCs5fVE3FAKITy2xmkmLK2utSftp/uzFB+wgfuI7Lu8j
	 nUmLgdCnmXCRGkea9xTrOAVNHxN43jSHuEWEx7DE91FuHuaFozdQtze6XiYe6h37R8
	 xvaigM0V4MDDw==
Message-ID: <9d050f18004a075fb09178d75960e9f52588bd70.camel@kernel.org>
Subject: Re: [PATCH 0/4] Add the ability to query mount options in statmount
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, kernel-team@fb.com
Date: Mon, 24 Jun 2024 15:53:12 -0400
In-Reply-To: <cover.1719257716.git.josef@toxicpanda.com>
References: <cover.1719257716.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 15:40 -0400, Josef Bacik wrote:
> Hello,
>=20
> Currently if you want to get mount options for a mount and you're
> using
> statmount(), you still have to open /proc/mounts to parse the mount
> options.
> statmount() does have the ability to store an arbitrary string
> however,
> additionally the way we do that is with a seq_file, which is also how
> we use
> ->show_options for the individual file systems.
>=20
> Extent statmount() to have a flag for fetching the mount options of a
> mount.
> This allows users to not have to parse /proc mount for anything
> related to a
> mount.=C2=A0 I've extended the existing statmount() test to validate this
> feature
> works as expected.=C2=A0 As you can tell from the ridiculous amount of
> silly string
> parsing, this is a huge win for users and climate change as we will
> no longer
> have to waste several cycles parsing strings anymore.
>=20
> This is based on my branch that extends listmount/statmount to walk
> into foreign
> namespaces.=C2=A0 Below are links to that posting, that branch, and this
> branch to
> make it easier to review.
>=20
> https://lore.kernel.org/linux-fsdevel/cover.1719243756.git.josef@toxicpan=
da.com/
> https://github.com/josefbacik/linux/tree/listmount.combined
> https://github.com/josefbacik/linux/tree/statmount-opts
>=20
> Thanks,
>=20
> Josef
>=20
> Josef Bacik (4):
> =C2=A0 fs: rename show_mnt_opts -> show_vfsmnt_opts
> =C2=A0 fs: add a helper to show all the options for a mount
> =C2=A0 fs: export mount options via statmount()
> =C2=A0 sefltests: extend the statmount test for mount options
>=20
> =C2=A0fs/internal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 5 +
> =C2=A0fs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
7 +
> =C2=A0fs/proc_namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 29 ++--
> =C2=A0include/uapi/linux/mount.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 3 +-
> =C2=A0.../filesystems/statmount/statmount_test.c=C2=A0=C2=A0=C2=A0 | 131
> +++++++++++++++++-
> =C2=A05 files changed, 164 insertions(+), 11 deletions(-)
>=20

Nice work. I especially like that there is a selftest now.

Reviewed-by: Jeff Layton <jlayton@kernel.org>

