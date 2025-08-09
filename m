Return-Path: <linux-fsdevel+bounces-57179-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C39B1F5A7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 19:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7FBA624E6C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Aug 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515072BF000;
	Sat,  9 Aug 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="VX6Bma1I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E712D24728C;
	Sat,  9 Aug 2025 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754760765; cv=none; b=o7pF20sN+uvTx5Nx+rDS4FXFZARC0DkZkFUox6bhfTQm097A/s7Xbp2Mzb0GiqygQZVwsYhPprojz9a/aE40F2Jw6L5n/OcaDPUuqD/nAF86uj12GYNQk/OtSkpfvV+8b2XDKi9YLiiRI3dbPseID3ZrkkDHGczYiU274NhNBuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754760765; c=relaxed/simple;
	bh=kP/J6dc5UQ2tJiEMSuWAfFTCklbsx5KCW70FjT+a/u0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbkF84SwRuUseV6AYpCJ3ybr0rS+55UIc+npJ4QjzLLzDrF0kmGm/qKWUc8Kjh3x1NS9FU9R0tA4aeQmCdl531LDA6uJWQxMnynxwHzg6pVU3f9mRje5tdB6PqWB8oAbY75kriPWMjvBQdPcpUhyi5s7I07U04RMzC1HjOuudZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=VX6Bma1I; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bznzC6qwKz9stg;
	Sat,  9 Aug 2025 19:32:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754760760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kP/J6dc5UQ2tJiEMSuWAfFTCklbsx5KCW70FjT+a/u0=;
	b=VX6Bma1IBx4ug8hkRPZe7cdvcW0YEaqMVkpKQBKZAEb/KUsLkkIKZNyKtTh1QUooYlJn1s
	pi+zrBBghzqMJntFkZy5uFSm/WinP/UCAFob4iuGXYsvGYkRa5PVOZRY7cgkA4/uRcAeHO
	C6RNVcvlMTew/zao5AMa+kCpdN3k/tWcp366DHgWNjF1DBqqSybGxA91GtUqW2mAl6ID22
	01LnVflUsrojkd7PdXlFM+WIRE/renLynwjNRA/o7SzpcoHwMfR2UHO6rBsZ+CMFU+cCrH
	Rl6I4mB0UM/zTLSoPjx7/P6RsF3su419KQryyxaXlfEreKRQOdCL40mE5ulBmg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Sun, 10 Aug 2025 03:32:25 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Askar Safin <safinaskar@zohomail.com>
Cc: Alejandro Colomar <alx@kernel.org>, 
	"Michael T. Kerrisk" <mtk.manpages@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
	linux-man <linux-man@vger.kernel.org>, linux-api <linux-api@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
Message-ID: <2025-08-09.1754760145-silky-magic-obituary-sting-3OnpC7@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
 <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yfw6iade575frhla"
Content-Disposition: inline
In-Reply-To: <1988f5c48ef.e4a6fe4950444.5375980219736330538@zohomail.com>
X-Rspamd-Queue-Id: 4bznzC6qwKz9stg


--yfw6iade575frhla
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 00/12] man2: document "new" mount API
MIME-Version: 1.0

On 2025-08-09, Askar Safin <safinaskar@zohomail.com> wrote:
> I plan to do a lot of testing of "new" mount API on my computer.
> It is quiet possible that I will find some bugs in these manpages during =
testing.
> (I already found some, but I'm not sure.)
> I think this will take 3-7 days.
> So, Alejandro Colomar, please, don't merge this patchset until then.

I don't plan to work on this again for the next week at least (I've
already spent over a week on these docs -- writing, rewriting, and then
rewriting once more for good measure; I've started seeing groff in my
nightmares...), so I will go through review comments after you're done.

There are some rough edges on these APIs I found while writing these
docs, so I plan to fix those this cycle if possible (hopefully those
aren't the bugs you said you found in the docs). Two of the fixes have
already been merged in the vfs tree for 6.18 (the -ENODATA handling bug,
as well as a bug in open_tree_attr() that would've let userspace trigger
UAFs). (Once 6.18 is out, I will send a follow-up patchset to document
the fixes.)

FYI, I've already fixed the few ".BR \% FOO" typos. (My terminal font
doesn't have a bold typeface, so when reviewing the rendered man-pages,
mistakes involving .B are hard to spot.)

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
https://www.cyphar.com/

--yfw6iade575frhla
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCaJeGKQAKCRAol/rSt+lE
b+/XAQCK8HwtD6JpUiaORCrGprHu9pstb/CQ7XKzFG4j2laqbQD+OYm2okSCqq/+
MB9+U84vJuUdkAreA+36Wsn3t6aBhwU=
=5iQM
-----END PGP SIGNATURE-----

--yfw6iade575frhla--

