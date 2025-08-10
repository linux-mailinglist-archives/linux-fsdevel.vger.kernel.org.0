Return-Path: <linux-fsdevel+bounces-57229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD773B1F9A2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 406857A3579
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE910246787;
	Sun, 10 Aug 2025 10:22:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185CEB663;
	Sun, 10 Aug 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754821359; cv=none; b=dF8ZvCwIdGJsSyOANRXDMplxtZtHOzZwaNSu/AH7E+YliAP/fXPbakqoidgsYGVT9+7IeJmIaW2izkDkaADNyak8yJqJU7aqJQ70zofL7ntarIHPAt03QCRtq0hTVYgCdxKllTwouRKf/zRGLdjWbWSnH09pGkLpQL0OtEG/RQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754821359; c=relaxed/simple;
	bh=0I9+2+UqEr/TPvVHGXFmqel3QSDQnTF6p3y0uqQOGzU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bThPm1W2do0BOoqJtlX3Qpq+Pz4KyfLK/Sp7NoKpGfs7k+mpoD6rAuk9dg+9SgTouRn+voJQk51CgSCiyE/N9YtwR4/mkcgn4Y2Czp68T0yFgqGNgGg286NUybcjEFwko/o1/NzIK9+ev8wj11ol1HUttnwNGIdB+yPegfVlL2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 4418412E120;
	Sun, 10 Aug 2025 10:22:33 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: "Gerald B. Cox" <gbcox@bzb.us>, Theodore Ts'o <tytso@mit.edu>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Sasha Levin <sashal@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 Aquinas Admin <admin@aquinas.su>,
 Malte =?UTF-8?B?U2NocsO2ZGVy?= <malte.schroeder@tnxip.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>,
 linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Sun, 10 Aug 2025 12:22:30 +0200
Message-ID: <3371119.aeNJFYEL58@lichtvoll.de>
In-Reply-To: <20250810055955.GA984814@mit.edu>
References:
 <1869778184.298.1754433695609@mail.carlthompson.net>
 <CACLvpcxmnXFmgfwGCyUJe1chz5vLkxbg3=NzayYOKWi4efHrqQ@mail.gmail.com>
 <20250810055955.GA984814@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Theodore, hi,

Theodore Ts'o - 10.08.25, 07:59:55 CEST:
> On Sat, Aug 09, 2025 at 09:26:16PM -0700, Gerald B. Cox wrote:
> > And really, this whole thread feels beneath what the kernel community
> > should be. If there=E2=80=99s a serious question about bcachefs=E2=80=
=99s future, it
> > ought to be a quiet, direct conversation between Kent and Linus=E2=80=
=94not a
> > public spectacle.
>=20
> There has been private conversations with Kent.  I will note that it
> was *Kent* who started this most recent round of e-mails[1].  In his
> e-mail, He slammed the Linux Kernel's "engineering standards", and
> btrfs in particular.  I won't quote any of it here, because it really
> is quite toxic, but please note that it was Kent who started the
> discussion about btrfs.  This kind of attack is Just Not Helpful, and
> this kind of behavior is, unfortunately, quite common coming from
> Kent.
>=20
> [1]
> https://lore.kernel.org/all/3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72q
> k5izizw@k6vxp22uwnwa/

I kind of agree that this thread would have gone better without this mail=20
from Kent.

Best,
=2D-=20
Martin



