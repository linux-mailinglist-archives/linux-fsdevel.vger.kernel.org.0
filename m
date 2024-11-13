Return-Path: <linux-fsdevel+bounces-34598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FAE9C6A9E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 09:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE90A1F24436
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 08:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D27218A6D7;
	Wed, 13 Nov 2024 08:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="psvOLqbJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3618A6B6
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 Nov 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731486981; cv=none; b=Kk4uX8eSOC0hhClDYcKQp7Gyj30+nvQJ0Yv1YuamLXmmI07ipNMNGT3zI49oJMhHgQhoTQb6s0fDILojqY6f00EDVA9aGAH2XhdBIP0t3qTtBkJzclViu25TDNxISi1Vv4NwVKHabQ5dtlvndQ9AQzWW/m8JYMegeHAQ/WFutAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731486981; c=relaxed/simple;
	bh=Xo+bo1dqrcZUyMo0p4J8LjfskdKCsmaVq1fXC7cNLJA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EO9XujP8CQhcgV7nMya7qYv7f0uhJ9oZIcZqFE6C725MD39Chs53oLlaFS0DTuj84fdrQOZu6Nv5KMTZhvhf0gPAT1Lbya9CvU57zAPcsTMm62cqP+wsyHDf3L+qXAmc2D0EuV8UnnDmCG4M8ygV4HF4wGw3jRqWdNGW9QaMG84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=psvOLqbJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QYh4HiRg/u8aVibDhRGMBXFvHABp1YG7/ORYPm3vBNE=;
	t=1731486980; x=1732696580; b=psvOLqbJrnWRLFFSivHqwvy0IyGjfVxgfBP6WZ93un9wZeC
	o1iqzQ4f7O8R+1TK8ccZnzo8c5WEo740TfOgXRb/HyS27NX156WWZM95sMUZy6QkqLlB+V9iw2Ta0
	SHvXeXZSjZxlcje49s/byv37iv7YO5CaAf3jtCnGZSdN6yvUffgVVJPk2KjYltoCPW+fA9LvCQAeb
	caZi5fWNIy0mZhvVh9wwYYSt/J2tPxwKBjU8jhkKI/joXCyD6omdsXG/8Aw6P6UOegLeK40sbYK87
	hW1opk5HcaXG/QB6rLCuMsSLxtub5bDm90H3LBv5C8u+GVevictuGBYsf3C+OI8w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tB8r6-00000003mN8-26Et;
	Wed, 13 Nov 2024 09:36:04 +0100
Message-ID: <8bbfe73f7f1ef9f1a4674d963d1c4e8181f33341.camel@sipsolutions.net>
Subject: Re: [RFC PATCH v2 02/13] x86/um: nommu: elf loader for fdpic
From: Johannes Berg <johannes@sipsolutions.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Hajime Tazaki
	 <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, ricarkol@google.com,
 Liam.Howlett@oracle.com,  ebiederm@xmission.com, kees@kernel.org,
 viro@zeniv.linux.org.uk,  brauner@kernel.org, jack@suse.cz,
 linux-mm@kvack.org,  linux-fsdevel@vger.kernel.org
Date: Wed, 13 Nov 2024 09:36:02 +0100
In-Reply-To: <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
References: <cover.1731290567.git.thehajime@gmail.com>
	 <ea2a3fb86915664d54ba174e043046f684e7cf8c.1731290567.git.thehajime@gmail.com>
	 <CAMuHMdU+Lyj3C-P3kQMd6WfyjBY+YXZSx3Vv6C2y9k__pK45vg@mail.gmail.com>
	 <m2pln0f6mm.wl-thehajime@gmail.com>
	 <CAMuHMdXC0BbiOjWsiN1Mg8Jkm03_H6_-fERSnFEB2pkW_VWmaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-11-13 at 09:19 +0100, Geert Uytterhoeven wrote:
>=20
> > > > -       depends on ARM || ((M68K || RISCV || SUPERH || XTENSA) && !=
MMU)
> > > > +       depends on ARM || ((M68K || RISCV || SUPERH || UML || XTENS=
A) && !MMU)
> > >=20
> > > s/UML/X86/?
> >=20
> > I guess the fdpic loader can be used to X86, but this patchset only
> > adds UML to be able to select it.  I intended to add UML into nommu
> > family.
>=20
> While currently x86-nommu is supported for UML only, this is really
> x86-specific. I still hope UML will get support for other architectures
> one day, at which point a dependency on UML here will become wrong...
>=20

X86 isn't set for UML, X64_32 and X64_64 are though.

Given that the no-MMU UM support even is 64-bit only, that probably
should then really be (UML && X86_64).

But it already has !MMU, so can't be selected otherwise, and it seems
that non-X86 UML=20

johannes

