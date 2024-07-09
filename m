Return-Path: <linux-fsdevel+bounces-23401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8E92BCC5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 16:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883421F22006
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 14:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AAE1922D8;
	Tue,  9 Jul 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2ry0i/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81E1591F1;
	Tue,  9 Jul 2024 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535003; cv=none; b=JX3ei341pqwIroGpdYkNpQg4AFzzwBRVjtgwTiacR3CD8XMLhMPH51Wi99Mk3h+048Elpd+aLU4HOympMDeDJjVWHJ0sQS56LeYw/G33QIQgmsn3T+DVXO16DWGYu9qYgPWPBiiSFiDNHTd2tu5xoR0leoJ9XivqUjOyus+MH90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535003; c=relaxed/simple;
	bh=eXgJ4wYdqysY/qkd6HNpgdu1snkkrsiOyckPHx7KNYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WjHn9aVUg+FUyetGJsJaV6Z564SZmBSItGNlDv38nFK3r0S7/wrX2AbctuyNPt4d0Rq8ALlc84F4u1cU61nuxMt4qOg3tzRIW0m17trJGbp+336OPJKjqnNqkOeE0l2HCGFp8zPQyq0mxTYs0/QML7l60lLY+EdvfWreT0Pe7NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2ry0i/l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AACDC4AF0A;
	Tue,  9 Jul 2024 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720535002;
	bh=eXgJ4wYdqysY/qkd6HNpgdu1snkkrsiOyckPHx7KNYo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=d2ry0i/l8a/eH2+9Te6S1AqQwFentP4VCejtrS86kNwcFtlXGjO7nxQpUEMDW3j/F
	 2cdgFoPxLj59UVDNJwoE+hYz3QDQoIQCpOGYhHosnP3j9EZLFoOg1En1TSPHR8q+5G
	 UjHYPC7P/cT24GfMJhJKyC8xPzwXRBwRCgCTyQUCY5+EzJIUu66Bob60NIRhsZMG8i
	 tiBIgYlkQt2+JzFgoKrgadgclkTS2wN2gg98NPdmKqoo3qxhvZ+nI3DP6gfR3TUc9f
	 9VnaDFXirCQOnF/U8mHzL+cBKXJu27MiPWwn4TH51v4a+r1C3zYFbxrd3S0MIC1wID
	 umt4z5W2gVRzw==
Message-ID: <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
From: Jeff Layton <jlayton@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 09 Jul 2024 10:23:21 -0400
In-Reply-To: <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
References: <202407091931.mztaeJHw-lkp@intel.com>
	 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
	 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
	 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
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

On Tue, 2024-07-09 at 16:16 +0200, Arnd Bergmann wrote:
> On Tue, Jul 9, 2024, at 15:45, Geert Uytterhoeven wrote:
> > On Tue, Jul 9, 2024 at 1:58=E2=80=AFPM Jeff Layton <jlayton@kernel.org>
> > wrote:
> > > I've been getting some of these warning emails from the KTR. I
> > > think
> > > this is in reference to this patch, which adds a 64-bit
> > > try_cmpxchg in
> > > the timestamp handling code:
> > >=20
> > > =C2=A0=C2=A0=C2=A0
> > > https://lore.kernel.org/linux-fsdevel/20240708-mgtime-v4-0-a0f3c6fb57=
f3@kernel.org/
> > >=20
> > > On m68k, there is a prototype for __invalid_cmpxchg_size, but no
> > > actual
> > > function, AFAICT. Should that be defined somewhere, or is this a
> > > deliberate way to force a build break in this case?
> >=20
> > It's a deliberate way to break the build.
> >=20
> > > More to the point though: do I need to do anything special for
> > > m86k
> > > here (or for other arches that can't do a native 64-bit cmpxchg)?
> >=20
> > 64-bit cmpxchg() is only guaranteed to exist on 64-bit platforms.
> > See also
> > https://elixir.bootlin.com/linux/latest/source/include/asm-generic/cmpx=
chg.h#L62
> >=20
> > I think you can use arch_cmpxchg64(), though.
>=20
> arch_cmpxchg64() is an internal helper provided by some
> architectures. Driver code should use cmpxchg64() for
> the explicitly 64-bit sized atomic operation.
>=20
> I'm fairly sure we still don't provide this across all
> 32-bit architectures though: on architectures that have
> 64-bit atomics (i686, armv6k, ...) these can be provided
> architecture specific code, and on non-SMP kernels they
> can use the generic fallback through
> generic_cmpxchg64_local(), but on SMP architectures without
> native atomics you need a Kconfig dependency to turn off
> the particular code.
>=20

I think the simplest solution is to make the floor value I'm tracking
be an atomic64_t. That looks like it should smooth over the differences
between arches. I'm testing a patch to do that now.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>

