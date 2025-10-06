Return-Path: <linux-fsdevel+bounces-63457-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21ADBBBD489
	for <lists+linux-fsdevel@lfdr.de>; Mon, 06 Oct 2025 09:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B792E3B5553
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Oct 2025 07:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C328258EF0;
	Mon,  6 Oct 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b="OG5zLNIV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71659EAF9;
	Mon,  6 Oct 2025 07:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759737351; cv=none; b=YeJVMqA/oXerDwZ0ExYeWi+FQtYTAfjKXYSRVQmqza8h+kYIsktTvr6Eqv9sAGhSTGjH8yB5sLsWlgBdEXglnDK9zixYCMrOsBM4sKwwsAMYe+qFC2FxB8dyl+uW38tgks1uOXGW196Q+3JK44fjme3CJCzvEemitvxcZfGBVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759737351; c=relaxed/simple;
	bh=Ktdz2Nqp6UoPcqlyxcLK1Ee7+26G14yq/e9uIpoJm0c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Eb2qq/cL8xDUv7uUx5cAvtEFVogjUETVKT3NABP8ztnTQsTgQRuWVWPRsCgAHJpaka86foqSoVlmN6M/akG6pjDOCQPU3LWVBCXLUqkNnra7y1rPWLHwTdukkKzy5k+KgrEKxeVU9sCO5u9g47puFZP2E3tn+eASdQmvKXFuMbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com; spf=fail smtp.mailfrom=mssola.com; dkim=pass (2048-bit key) header.d=mssola.com header.i=@mssola.com header.b=OG5zLNIV; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mssola.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mssola.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4cgBQk1zbszB0QK;
	Mon,  6 Oct 2025 09:55:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mssola.com; s=MBO0001;
	t=1759737342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b0tcld6rmtt1ShxEEfBZcHxGj9PBrrizUG55fWUcquc=;
	b=OG5zLNIVgCQf+pPxR8lmDn1gevuWIXm1Sl/2nVisw5tR+1j3/VmB0D6H88XyTJUR61h914
	a1UOiRDyxrkzksltS8y/iMXTdZ8vQ+mOgJd5KhLUdI06tSnJWoAv0ern12C4qkpQUfK40w
	1jCjqHhjFr5Mp5dw6ItHagRCY+N6ZpmCIGTYwLNDWgvr4WXi+oEM78l14EPoU9mVlh5qMB
	TVl0XXnZRNctmsBlkDhOQ9ssHx0iAEtLncppl6eDqZbxx71Bmv3ayjzrW+KXiJnptFjZ6m
	4E3FxuQ2V41l7+/D49EfSeixVN+m9BPo6O5tOa78Vamx7EWG8N4qX7uNvf0B8w==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=softfail (outgoing_mbo_mout: 2001:67c:2050:b231:465::2 is neither permitted nor denied by domain of mssola@mssola.com) smtp.mailfrom=mssola@mssola.com
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mssola@mssola.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,  brauner@kernel.org,
  linux-kernel@vger.kernel.org,  jack@suse.cz
Subject: Re: [PATCH] fs: Use a cleanup attribute in copy_fdtable()
In-Reply-To: <20251005213007.GG2441659@ZenIV> (Al Viro's message of "Sun, 5
	Oct 2025 22:30:07 +0100")
References: <20251004210340.193748-1-mssola@mssola.com>
	<20251004211908.GD2441659@ZenIV> <20251005090152.GE2441659@ZenIV>
	<20251005213007.GG2441659@ZenIV>
Date: Mon, 06 Oct 2025 09:55:38 +0200
Message-ID: <87a524jwg5.fsf@>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 4cgBQk1zbszB0QK

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Al Viro @ 2025-10-05 22:30 +01:

> On Sun, Oct 05, 2025 at 07:41:47PM +0200, Miquel Sabat=C3=A9 Sol=C3=A0 wr=
ote:
>> Al Viro @ 2025-10-05 10:01 +01:
>>
>> > On Sun, Oct 05, 2025 at 07:37:50AM +0200, Miquel Sabat=C3=A9 Sol=C3=A0=
 wrote:
>> >> Al Viro @ 2025-10-04 22:19 +01:
>> >>
>> >> > On Sat, Oct 04, 2025 at 11:03:40PM +0200, Miquel Sabat=C3=A9 Sol=C3=
=A0 wrote:
>> >> >> This is a small cleanup in which by using the __free(kfree) cleanup
>> >> >> attribute we can avoid three labels to go to, and the code turns t=
o be
>> >> >> more concise and easier to follow.
>> >> >
>> >> > Have you tried to build and boot that?
>> >>
>> >> Yes, and it worked on my machine...
>> >
>> > Unfortunately, it ends up calling that kfree() on success as well as o=
n failure.
>> > Idiomatic way to avoid that would be
>> > 	return no_free_ptr(fdt);
>> > but you've left bare
>> > 	return fdt;
>> > in there, ending up with returning dangling pointers to the caller.  S=
o as
>> > soon as you get more than BITS_PER_LONG descriptors used by a process,
>> > you'll get trouble.  In particular, bash(1) running as an interactive =
shell
>> > would hit that - it has descriptor 255 opened...
>>
>> Ugh, this is just silly from my end...
>>
>> You are absolutely right. I don't know what the hell I was doing while
>> testing that prevented me from realizing this before, but as you say
>> it's quite obvious and I was just blind or something.
>>
>> Sorry for the noise and thanks for your patience...
>
> FWIW, the real low-level destructor (__free_fdtable()) *does* cope with -=
>fd
> or ->open_fds left NULL, so theoretically we could replace kmalloc with
> kzalloc in alloc_fdtable(), add use that thing via DEFINE_FREE()/__free(.=
..);
> I'm not sure if it's a good idea, though - at the very least, that proper=
ty
> of destructor would have to be spelled out with explanations, both in
> __free_fdtable() and in alloc_fdtable().
>
> Matter of taste, but IMO it's not worth bothering with - figuring out why
> the damn thing is correct would take at least as much time and attention
> from readers as the current variant does.

Agreed.

>
> BTW, there's a chance to kill struct fdtable off - a project that got sta=
lled
> about a year ago (see https://lore.kernel.org/all/20240806010217.GL5334@Z=
enIV/
> and subthread from there on for details) that just might end up eliminati=
ng
> that double indirect.  I'm not saying that it's a reason not to do cleanu=
ps in
> what exists right now, just a tangentially related thing that might be in=
teresting
> to resurrect...

That looks interesting indeed, I'll take a look at this topic whenever I
have some spare time.

Thanks!
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJiBAEBCgBMFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjjdfobFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyEhxtc3NvbGFAbXNzb2xhLmNvbQAKCRCWvoxv2J1l
ZS5YD/953CLXZRqnckq1w3kLpTAIx+QWd8Bznf0fOsaDIyu+HiVTj6qDrKvBYbaN
aY1c8QQNzmpuA3rSVxI79MXMJGGnA69gtefb+LXFW++l3Ov6a53xWHsWe8Hs6xxR
rl9CfvTMheVMa0ZUqFIGkWdcx3u1CmyjC7/Tghs1z1bYnOd/qFsZbVJLT8y/OqN4
TV7x8w/JfFoGw05DZ/tdCiH+wplVe6x9EGzIG1CxNj1iO3pI5l7Hu/eVOoc0iYw+
CJAZ/oGeEe6xESDa7/70cR35rHMv5sytq0Ww3N7nC69R8XD/BChhW05rMIEOOc37
CvD2EWskSipgS2RfvyoGZp+bJkL5HzNsXCYPcBxhxj/1t+rWM/NZ+OJwH3bigrkA
AkY/Uu9K2jkVF3y6pfHC3KjjLzeAjETxSgjXy93xbnxEOUChHsh2/TPrpIyfNauS
Rx2lb0a70Xzvechcp2XROmwVijPEqpHDlQyvOb5zY+buEJ0dcWY7G6TlLPecV4UB
fkbTpaQi7SvgDBiyJnu/kOsla+s2gI5cs4CuR/HB7nv1bODr533F90xIXCUhXVBr
4KlOTdLgAA1A5RprWEcpM+jYDpCFR+4g6VXIJY46cpZaO9TtJi7t9wC/R6+rhXVQ
gkwR9yrBWC3a7lJm7swszCMYCdrtdgs03cNjqQkO4ZyUSMZq+g==
=2Lc2
-----END PGP SIGNATURE-----
--=-=-=--

