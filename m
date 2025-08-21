Return-Path: <linux-fsdevel+bounces-58605-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD0B2F720
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991BD60452C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 11:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2367D2DFA2D;
	Thu, 21 Aug 2025 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="2AlFnXuu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55C020C47C;
	Thu, 21 Aug 2025 11:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755776982; cv=none; b=foSGN8xwwZ+osrNIFQFoqR4nheNxoUbk+QsZ7X7srJ+V6W0ewgopKVa+gTtCgaVfGovqKxToZtnwf/3Cb5bi++vMjaSK/aJGr6JmAi7LlD7zaPQPQUXvzlY1xPuFb+2mQLFjiOkTWEF1gMmRhGsLsskChMk/EfEg3DNEhE6ljQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755776982; c=relaxed/simple;
	bh=tfZrXbfc4oq1S3cVt2v2d1owIpM4+3slLwHaRwR4LrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OgYVzNCn6zjaSvuTeZPo93tweaCjk9B2DmMzxnby/u4ojMX+m08/VSA7/fBa0kCQp4GU/bslDllN2mvcyG/8lNGetVUYEuIiQ0Ax3MZsWHJSFN/uL1t17o7jkItQlrscWsMgpEYuQQ15ixYpTmYs9ot3twf6fEFh0bw7JhZYuQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=2AlFnXuu; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c71nl1glTz9tKb;
	Thu, 21 Aug 2025 13:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1755776971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EFlH+VJnfrLLvhDqPUsmhgOah2IOEJ+syE2BNTTu8Pc=;
	b=2AlFnXuuuvTyN1LrBkJ82MvdtZ3oGos2Kjqc1UlNstcLZKzt+Zi4wd3BOm2flmbE6XeB/P
	Z8r7oeKgN2rF+3QYrrjg3l7AuWwXYUUldsLlrV+OaqhpIIU1Enw9wgxb6axATEoxzAFLAm
	dLTnebeROZI30n5dTBiBRYoGWQYvovijTT3+4QrI/K5Cz8Hg6UopN9HO1hiJbrGZTNa6Ye
	A8JMJG2m2k47N2XjOb5RshVVsGIR9e3WtmTH1Hy72m5m1yGBNm4pyFrvRMAK8EhUJlDI8M
	M7RdlZMdA3YeYjlws6X0JcAx24gN6E3TLf4tgas1qhDpxVtRn4yliL84yGYdKg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Thu, 21 Aug 2025 21:49:18 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: alx <alx@kernel.org>, brauner <brauner@kernel.org>, 
	dhowells <dhowells@redhat.com>, "g.branden.robinson" <g.branden.robinson@gmail.com>, 
	jack <jack@suse.cz>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-man <linux-man@vger.kernel.org>, "mtk.manpages" <mtk.manpages@gmail.com>, 
	viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>, 
	autofs mailing list <autofs@vger.kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-21.1755776865-swank-rusted-doorbell-brads-U3HJFf@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <20250817075252.4137628-1-safinaskar@zohomail.com>
 <2025-08-17.1755446479-rotten-curled-charms-robe-vWOBH5@cyphar.com>
 <198c74541c8.c835b65275081.1338200284666207736@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ecr4qyhlla7cietw"
Content-Disposition: inline
In-Reply-To: <198c74541c8.c835b65275081.1338200284666207736@zohomail.com>
X-Rspamd-Queue-Id: 4c71nl1glTz9tKb


--ecr4qyhlla7cietw
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-20, Askar Safin <safinaskar@zohomail.com> wrote:
>  ---- On Sun, 17 Aug 2025 20:16:04 +0400  Aleksa Sarai <cyphar@cyphar.com=
> wrote ---=20
>  > They are not tested by fstests AFAICS, but that's more of a flaw in
>  > fstests (automount requires you to have a running autofs daemon, which
>  > probably makes testing it in fstests or selftests impractical) not the
>  > feature itself.
>=20
> I suggest testing automounts in fstests/selftests using "tracing" automou=
nt.
> This is what I do in my reproducers.
>=20
>  > The automount behaviour of tracefs is different to the general automou=
nt
>  > mechanism which is managed by userspace with the autofs daemon.
>=20
> Yes. But I still was able to write reproducers using "tracing", so this
> automount point is totally okay for tests. (At least for some tests,
> such as RESOLVE_NO_XDEV.)

Sure, but I don't think people use allyesconfig when running selftests.
I wonder if the automated test runners even enable deprecated features
like that.

In any case, you can definitely write some tests for it. :D

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--ecr4qyhlla7cietw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaKcHvRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQKJf60rfpRG+GeAEAwCxqWJ6XP3XwGopXed+M
svbRnf0/cL/a4UUPHvcBzH0BAPDSaOqMP2tkb8R201zdSZfnOP0PAD9/nnceTG96
QpgL
=xu3t
-----END PGP SIGNATURE-----

--ecr4qyhlla7cietw--

