Return-Path: <linux-fsdevel+bounces-23431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379892C341
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 20:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CAAFB222C3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 18:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51C618004F;
	Tue,  9 Jul 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lug5FJcO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480B317B045;
	Tue,  9 Jul 2024 18:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720549653; cv=none; b=XZkViYn5XI1nFUKJZnO0gxrHQ2v9m7pgj7nY//oDk2jT4jvuaRE9gGeq+kP9aU+8cvy1kevbvVYQ3Z07rtuOrNwEbdEGD7WJJOi2q+bqXvKGFstbV+vhgaJuT3eMyY87YAZQsugq5LSi3ZmOkAo5jnIMmMktgszvVC64n0zrqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720549653; c=relaxed/simple;
	bh=U8wsKEP1l3sPR2WfGsk6+shaFGOI2MVaDRA+QFdlhxg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rULd9iOn47b3h0pqBJEiMOHitlGlq4EQ8mjEbaK+Oa/sKSUCR5QlfgXXJr5YQn+geaaBYg3RxhgbrXDMcsiw/ziUg8fjm/qCDaRZsbPfS7MeaLu1Tve5XQ5ctmoFF0KKSUne5yfE2AdkmhPketY92+graIbtBE8Cgn1cSEzpZdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lug5FJcO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C7B2C3277B;
	Tue,  9 Jul 2024 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720549652;
	bh=U8wsKEP1l3sPR2WfGsk6+shaFGOI2MVaDRA+QFdlhxg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=lug5FJcOTpj5ynmCj8uI6+D8nL+VwLjCedeuZRPm51mjLeT/Md9pZSYL7R05tUm3s
	 RL67JzQEzYqqghuH4UlyMzIhS2BBQcCeGfYfVjqSYUM4J4grVdXNGX1aEmcrnz6DzA
	 c5xjSEFveh0tNER+pbKdyT3DGvd16CvYeb81pXoXLstHRacD9cvlykPtjuY7FpnzyO
	 9ZfLFlD+n0ysoRWm4I5SoYWXihYfYXzwR+41LAvJOAgTIm35/rtbgCl8dVA1FdNO0/
	 8aN7n0YRTazf1O6JFkChf9d6R9LS85/Ozgzn8dFC7JtHTA0fXJBQ/LNATgw9f/mZjG
	 khF2c/4j01ePQ==
Message-ID: <5c52194a8b449e695a1f22bf525b1fb1674cd2f8.camel@kernel.org>
Subject: Re: [jlayton:mgtime 5/13] inode.c:undefined reference to
 `__invalid_cmpxchg_size'
From: Jeff Layton <jlayton@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Date: Tue, 09 Jul 2024 14:27:30 -0400
In-Reply-To: <c8e44728-6c09-4fbe-9583-1f8298c3ea39@app.fastmail.com>
References: <202407091931.mztaeJHw-lkp@intel.com>
	 <c1d4fcee3098a58625bb03c8461b92af02d93d15.camel@kernel.org>
	 <CAMuHMdVsDSBdz2axqTqrV4XP8UVTsN5pPS4ny9QXMUoxrTOU3w@mail.gmail.com>
	 <c4df5f73-2687-4160-801c-5011193c9046@app.fastmail.com>
	 <6ab599393503a50b4b708767f320a46388aa95f2.camel@kernel.org>
	 <92726965-19a0-433b-9b49-69af84b25081@app.fastmail.com>
	 <edd2d831320fb14333e605e77d4b284b1123eb86.camel@kernel.org>
	 <c8e44728-6c09-4fbe-9583-1f8298c3ea39@app.fastmail.com>
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

On Tue, 2024-07-09 at 19:06 +0200, Arnd Bergmann wrote:
> On Tue, Jul 9, 2024, at 17:27, Jeff Layton wrote:
> > On Tue, 2024-07-09 at 17:07 +0200, Arnd Bergmann wrote:
> > > On Tue, Jul 9, 2024, at 16:23, Jeff Layton wrote:
> >=20
> > The context for this is generally a write or other change to an
> > inode,
> > so I too am hoping the overhead won't be too bad. It does take
> > great
> > pains to avoid changing the ctime_floor value whenever possible.
>=20
> Ok, I see. Have you considered hooking directly into the code
> in kernel/time/timekeeping.c then?=20
>=20
> Since the coarse time is backed by the timekeeper that itself
> is a cache of the current time, this would potentially avoid
> some duplication:
>=20
> - whenever the tk_core code gets updated, you can update
> =C2=A0 the ctime_floor along with it, or integrate ctime_floor
> =C2=A0 itself into the timekeeper
>=20
> - you can use the same sequence count logic, either with the
> =C2=A0 same &tk_core.seq or using a separate counter for the
> =C2=A0 ctime updates
>=20


Yes, I had considered it on an earlier draft, but my attempt was pretty
laughable. You inspired me to take another look though...

If we go that route, what I think we'd want to do is add a new floor
value to the timekeeper and a couple of new functions:

ktime_get_coarse_floor - fetch the max of current coarse time and floor
ktime_get_fine_floor - fetch a fine-grained time and update the floor

The variety of different offsets inside the existing timekeeper code is
a bit bewildering, but I guess we'd want ktime_get_fine_floor to call
timekeeping_get_ns(&tk->tkr_mono) and keep the latest return cached.
When the coarse time is updated we'd zero out that cached floor value.

Updating that value in ktime_get_fine_floor will require locking or
(more likely) some sort of atomic op. timekeeping_get_ns returns u64
though, so I think we're still stuck needing to do a cmpxchg64.

If there is a way to cut down what we'd need to track to 32-bits or
less though, then that might become more appealing.
--=20
Jeff Layton <jlayton@kernel.org>

