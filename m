Return-Path: <linux-fsdevel+bounces-23412-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E9992BE47
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 17:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B8121F24578
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0FC19D097;
	Tue,  9 Jul 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C4Ywpoy6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D05D43147;
	Tue,  9 Jul 2024 15:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720538862; cv=none; b=CgWvAqKRK3YVpK+m2fgvEsLqGO2Ra3aDbdygqnMN7FritRqybB6xjJZ8wWt07uOb/ewFkDrHBgYFNbuwndt6AyeAxpl8Obr6FdE7rv9dr/eCjdasUOOS49vharyiBk3mGohMWdhZl4S6CYAOycR0ip2ENImV5Py5fXP6goCRFto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720538862; c=relaxed/simple;
	bh=O0o3i35g9yIYq7V1d5PS5NTZJHLF+8SpUYDRPKu7OO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U4bJLZROZPdG88+8/ed3ps6DaQZGy33qZVt0ZwqR1hrY4xPjvg8XC/G7MEn/UdrzVKsXYBRSph83JENm67YYvFidHjw1PEB3TCoSqrcZpJHuyp8f6K2EqOSk798NIdf8AJmX8ofi+YmNYbISPJrhEQ60vq8DlucMWTqLN+0LmbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C4Ywpoy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E471C32782;
	Tue,  9 Jul 2024 15:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720538861;
	bh=O0o3i35g9yIYq7V1d5PS5NTZJHLF+8SpUYDRPKu7OO4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=C4Ywpoy6K5wIoIRwcQNFUBcFBSm+8LwYLbaOFn62U9hkqPOC3Xnp3SAClvusoEu/4
	 t8PRG95A7Jh+FvPMm+Wsh/PIwjOyavjD16xowvdOXr+ZkLNrEHc7NywXAwTlaW2/84
	 L5fDlxJ52lV97hEa9XAM4Z0Qn2BpkbqwHaFsng0dM/I4u1TZonELVmo2XR8U+U0B3a
	 OOT8Bs6m8EwF+G50dpIP0OET5Njsa9AL7rC7aYIW9MFRSdAuCsBQbhydmmhr0V3nGn
	 4lY3OsaqdOEJr7kMH/5OHPjt68AtrtYmRHdbQBGPxGYhV1KMQgfd1sqBPlQuuLkj/A
	 qg+N0VUr5wxWQ==
Message-ID: <edd2d831320fb14333e605e77d4b284b1123eb86.camel@kernel.org>
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
From: Jeff Layton <jlayton@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 09 Jul 2024 11:27:40 -0400
In-Reply-To: <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
References: <202407091931.mztaeJHw-lkp@intel.com>
	 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
	 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
	 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
	 <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
	 <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-09 at 17:07 +0200, Arnd Bergmann wrote:
> On Tue, Jul 9, 2024, at 16:23, Jeff Layton wrote:
> > On Tue, 2024-07-09 at 16:16 +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 9, 2024, at 15:45, Geert Uytterhoeven wrote:
> >=20
> > I think the simplest solution is to make the floor value I'm
> > tracking
> > be an atomic64_t. That looks like it should smooth over the
> > differences
> > between arches. I'm testing a patch to do that now.
>=20
> Yes, atomic64_t should work, but be careful about using this
> in a fast path since it can turn into a global spinlock
> in lib/atomic64.c on architectures that don't support it
> natively.
>=20
> I'm still reading through the rest of your series, but
> it appears that you pass the time value into=20
> ktime_to_timespec64() directly afterwards, so I guess
> that is already a fairly large overhead on 32-bit
> architectures and an extra spinlock doesn't hurt too
> much.
>=20

Thanks Arnd.

The context for this is generally a write or other change to an inode,
so I too am hoping the overhead won't be too bad. It does take great
pains to avoid changing the ctime_floor value whenever possible.


> Two more things I noticed in your patch:
>=20
> - smp_load_acquire() on a 64-bit variable seems problematic
> =C2=A0 as well, maybe this needs a spinlock on 32-bit
> =C2=A0 architectures?
>=20

That should go away with the conversion of ctime_floor to atomic64_t.
AFAICT, arches that don't have native a 64-bit cmpxchg op usually
emulate that with hashed spinlocks.=20

> - for the coarse_ctime function, I think you should be
> =C2=A0 able to avoid the conversion to timespec by just calling
> =C2=A0 ktime_get_coarse_real_ts64() again instead of converting
> =C2=A0 monotonic to real and then to timespec.
>=20

Note that we might get different values for the coarse timestamps, but
if we do then the second fetch will just be a little later (which is
OK). I'll plan to make this change.


> - inode_set_ctime_current() seems to now store a fine-grained
> =C2=A0 timespec in the inode even for the !is_mgtime case, skipping
> =C2=A0 the timestamp_truncate() step. This appears to potentially
> =C2=A0 leak a non-truncated value to userspace, which would be
> =C2=A0 inconsistent with the value read back from disk.

Oof, you're right. I'll fix that up for the next version.

Thanks for the review!
--=20
Jeff Layton <jlayton@kernel.org>

