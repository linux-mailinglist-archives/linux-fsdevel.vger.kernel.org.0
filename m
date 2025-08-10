Return-Path: <linux-fsdevel+bounces-57230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D605B1F9A5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 12:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9621A173FCE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 10:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E068F246781;
	Sun, 10 Aug 2025 10:32:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597C8198E9B;
	Sun, 10 Aug 2025 10:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754821963; cv=none; b=m6jPh5leNObINCxga0b9vCbucCtsc/1bEVMlBOs3H/fdpfpjKRVL4zf3Y/P2eOdIGSvAU9bamjjT0kZWfUUm9xFfY8yylV1wS/5F+kO5jg3Qrx9dpWo91ivJi9qBCl6Y5F4NGAAv7sTkMwHjBJw40LpWUVCRTDv9ZCe9g7SB3kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754821963; c=relaxed/simple;
	bh=8D9WEyhPPhhVKH+WCxVVbKm/SDCaoqn/KutdHv9zxqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YRHeh+m0QyDx19gWe1Yl/wFJpvu3RReAqXlzG+9wqpVt1rqlJd1iAZUXEUxRi6XZmOtOm08JdkoE+AywfSITUeHd4pNIzVzgsnzfRmhekf+UmbgriCMR28n/twfoxxc8FPZNStctwpHmrCyrhQ1EZKf08VAmHmSeKfbAS/nOGvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id E7DC912E133;
	Sun, 10 Aug 2025 10:32:38 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Gerhard Wiesinger <lists@wiesinger.com>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Sun, 10 Aug 2025 12:32:38 +0200
Message-ID: <22799288.EfDdHjke4D@lichtvoll.de>
In-Reply-To: <e19849f2-4a39-4a09-b19e-cb4f291a2dc2@wiesinger.com>
References:
 <22ib5scviwwa7bqeln22w2xm3dlywc4yuactrddhmsntixnghr@wjmmbpxjvipv>
 <e19849f2-4a39-4a09-b19e-cb4f291a2dc2@wiesinger.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Gerhard, hi.

Gerhard Wiesinger - 10.08.25, 08:20:43 CEST:
> On 28.07.2025 17:14, Kent Overstreet wrote:
> > Schedule notes for users:
> >=20
> > I've been digging through the bug tracker and polling users to see
> > what bugs are still outstanding, and - it's not much.
> >=20
> > So, the experimental label is coming off in 6.18.
> >=20
> > As always, if you do hit a bug, please report it.
>=20
> I can now confirm that bcachefs is getting stable and the test cases
> with intentionally data corruption (simulation of a real world case I
> had) gets bcachefs back to a consistent state (after 2 runs of: bcachefs
> fsck -f -y ${DEV}). That's a base requirement for a stable filesystem.
> Version of bcachefs-tools is git
> 530e8ade4e6af7d152f4f79bf9f2b9dec6441f2b and kernel is
> 6.16.0-200.fc42.x86_64.
>=20
> See for details, I made data corruption even worser with running the
> destroy script 5x:
>=20
> https://lore.kernel.org/linux-bcachefs/aa613c37-153c-43e4-b68e-9d50744be
> 7de@wiesinger.com/
>=20
> Great work Kent and the other contributors.
>=20
> Unfortunately btrfs can't be repaired to a consistent state with the
> same testcase. I'd like to be that testcase fixed also for BTRFS as a
> stable filesystem (versions: 6.16.0-200.fc42.x86_64, btrfs-progs v6.15,
> -EXPERIMENTAL -INJECT -STATIC +LZO +ZSTD +UDEV +FSVERITY +ZONED
> CRYPTO=3Dlibgcrypt).
>=20
> (I reported that already far in the past on the mailing list, see here:
> https://lore.kernel.org/linux-btrfs/63f8866f-ceda-4228-b595-e37b016e7b1f
> @wiesinger.com/).

Thanks for this great find and these test results.

On a technical perspective I still think the Linux kernel is a better=20
kernel with BCacheFS included.

And write this without having had any issues =E2=80=93 except for bad perfo=
rmance=20
especially on hard disks, but partly also on flash =E2=80=93 with BTRFS. An=
d I use=20
it on a couple laptops, some virtual machines and a lot of external disks.=
=20
But not on a multi device setup. I had a BTRFS RAID 1 for a long time.=20
This also has been stable since kernel 4.6 up to the time I still used it.

So I did not really have much of a need to fsck BTRFS.

Best,
=2D-=20
Martin



