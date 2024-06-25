Return-Path: <linux-fsdevel+bounces-22355-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AC91691F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 15:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68F428B4C7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1480116EC03;
	Tue, 25 Jun 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pF9RzBJZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3F16B72B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322636; cv=none; b=N3Fw9RalrYKjCmUhtPt2vbOEzgvVGZajNrFbEyc03nw4wpqsC+Fh4oYL58SmZR5wJJ6PpuGnnjZWK/oN0+LTxwDxrzslVi+qc6gljRBBPJZjFnn+4XbP0BObf1cZrgdElbN0llipsSmEcYR+ObP4NCEiAn/LzD3snhSRrG9vDqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322636; c=relaxed/simple;
	bh=ehQbUp2SvIpTy3UXyBEVIeoQKrvThLfAWLHWwVSXj2s=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b10n4mNVJA225p3s/QMd3clMwj5Srw8MxzeYtiDJYLLpxfDTk/PyyBijdrY0CfYHqunTJeLA0+4a1KFe0N3C4flOdUtatzk/quILjbock/jZ2laodci6qTGt/qCvluKlIy2dJ5HMboBLbq5v9rAQv48ien+VYx/DFgERCGPs3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pF9RzBJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA8E4C32781;
	Tue, 25 Jun 2024 13:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322636;
	bh=ehQbUp2SvIpTy3UXyBEVIeoQKrvThLfAWLHWwVSXj2s=;
	h=Subject:From:To:Date:In-Reply-To:References:From;
	b=pF9RzBJZEmvA2T3CWIq+7Tls5XprvOLj8LrA05KLXpWMxmQBbEL8z2yXmBy5aJN8h
	 M77kOxY9vncyR4MLHaO8Vr8Pzl6W0DbOV3+7ZzlhqqiFO8s1YVJmR9SLXk1M8Lji7a
	 syaYSEMyb+eoFVOigwQIDewMCKFnHPvk8HGAvf1VOzUiSoCuCqVAHhRJJ4ZdXROk8a
	 HPgK8LmS1C6QDt9wvZnc0NyqUDw8PLIDs+jeptvQebkgiW+kkfxMhq74/QHnhCa0pl
	 AQwmgdgrVEkJ0yP+TVHDK84vtLhUyYhQ8nZ767bFGDqGq2SUr8sKiQHMXCZhtrcjjK
	 eliA3jIHoCUxQ==
Message-ID: <c524f7f9546407c912d053e2fe516877fb41aec7.camel@kernel.org>
Subject: Re: [PATCH 0/8] Support foreign mount namespace with
 statmount/listmount
From: Jeff Layton <jlayton@kernel.org>
To: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, 
	brauner@kernel.org, kernel-team@fb.com
Date: Tue, 25 Jun 2024 09:37:14 -0400
In-Reply-To: <cover.1719243756.git.josef@toxicpanda.com>
References: <cover.1719243756.git.josef@toxicpanda.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-06-24 at 11:49 -0400, Josef Bacik wrote:
> Hello,
>=20
> Currently the only way to iterate over mount entries in mount namespaces =
that
> aren't your own is to trawl through /proc in order to find /proc/$PID/mou=
ntinfo
> for the mount namespace that you want.=C2=A0 This is hugely inefficient, =
so extend
> both statmount() and listmount() to allow specifying a mount namespace id=
 in
> order to get to mounts in other mount namespaces.
>=20
> There are a few components to this
>=20
> 1. Having a global index of the mount namespace based on the ->seq value =
in the
> =C2=A0=C2=A0 mount namespace.=C2=A0 This gives us a unique identifier tha=
t isn't re-used.
> 2. Support looking up mount namespaces based on that unique identifier, a=
nd
> =C2=A0=C2=A0 validating the user has permission to access the given mount=
 namespace.
> 3. Provide a new ioctl() on nsfs in order to extract the unique identifie=
r we
> =C2=A0=C2=A0 can use for statmount() and listmount().
>=20
> The code is relatively straightforward, and there is a selftest provided =
to
> validate everything works properly.
>=20
> This is based on vfs.all as of last week, so must be applied onto a tree =
that
> has Christians error handling rework in this area.=C2=A0 If you wish you =
can pull the
> tree directly here
>=20
> https://github.com/josefbacik/linux/tree/listmount.combined
>=20
> Christian and I collaborated on this series, which is why there's patches=
 from
> both of us in this series.
>=20
> Josef
>=20
> Christian Brauner (4):
> =C2=A0 fs: relax permissions for listmount()
> =C2=A0 fs: relax permissions for statmount()
> =C2=A0 fs: Allow listmount() in foreign mount namespace
> =C2=A0 fs: Allow statmount() in foreign mount namespace
>=20
> Josef Bacik (4):
> =C2=A0 fs: keep an index of current mount namespaces
> =C2=A0 fs: export the mount ns id via statmount
> =C2=A0 fs: add an ioctl to get the mnt ns id from nsfs
> =C2=A0 selftests: add a test for the foreign mnt ns extensions
>=20
> =C2=A0fs/mount.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +
> =C2=A0fs/namespace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 240 ++++++++=
++--
> =C2=A0fs/nsfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 14 +
> =C2=A0include/uapi/linux/mount.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 6 +-
> =C2=A0include/uapi/linux/nsfs.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +
> =C2=A0.../selftests/filesystems/statmount/Makefile=C2=A0 |=C2=A0=C2=A0 2 =
+-
> =C2=A0.../filesystems/statmount/statmount.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 46 +++
> =C2=A0.../filesystems/statmount/statmount_test.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 53 +--
> =C2=A0.../filesystems/statmount/statmount_test_ns.c | 360 +++++++++++++++=
+++
> =C2=A09 files changed, 659 insertions(+), 66 deletions(-)
> =C2=A0create mode 100644 tools/testing/selftests/filesystems/statmount/st=
atmount.h
> =C2=A0create mode 100644 tools/testing/selftests/filesystems/statmount/st=
atmount_test_ns.c
>=20


Nice work! I had a minor question about the locking, but this all looks
pretty straightfoward.

As a side question. Is there any progress on adding proper glibc
bindings for the new syscalls? We'll want to make sure they incorporate
this change, if that's being done.

Extending listmount() and statmount() via struct mnt_id_req turns out
to be pretty painless. Kudos to whoever designed that part of the
original interfaces!

Reviewed-by: Jeff Layton <jlayton@kernel.org>

