Return-Path: <linux-fsdevel+bounces-33904-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F08829C06F7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70D71F217BB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 13:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584BA20FAB0;
	Thu,  7 Nov 2024 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="qdVUQqi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4034120EA3B
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 13:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984961; cv=none; b=Oi4RYZfr6OA49lgV+f3d48lmfzsAJdXen7cgnpLFHVd7b8TMwnTMu3vq9b1vwIGUp2Eawdt3hpOKT80KZjo3d5Fj4rQ4MpoPkfW5fk/cd5Y7LsjKHb8Lw0ez6B6TlARkGES2peHH/A3RBgLqT5p48HHIVrh1GQWqhHAm0YE+n0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984961; c=relaxed/simple;
	bh=dhtxfJh1FLPzvT4jT0S+jmUarJJ1hUeU8sCCjAP29B0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kt5BA8BB3QHU48t6rdq3z7RHemAiQlhkmuYJIxkghceW/Pn2zNnNCnsEgIm0CWzQ5Plmjjs/WBIx1squpHnyDFoxrpsJ2HkgKLZtWfhp+WVgdO7lFOamjh5UvSpthxkfBP4n5tGXfU3TgBVWMnjkrBHyBB1QjlZ2rzb0wrPLGsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=qdVUQqi2; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=dhtxfJh1FLPzvT4jT0S+jmUarJJ1hUeU8sCCjAP29B0=;
	t=1730984960; x=1732194560; b=qdVUQqi23Eda4aO8sxCkqcpwWNtuVRJ8qQkqdGo3P+W0OZH
	h9QWQvCpMpK9LJzKtjs/gRFbbLmOxUufr86ZaqfPDd67C76WDtueC0mWexutO1fkgxPlACD/NTsHL
	f62fg3iJoCI7sXS86xMGD/GlJTcUmdqZ3XEVDIAhSAuHKCxk8K05+HChJ6QnuYAets6QLMf5xAD3f
	jX6ZqnU++AmbxvQZ1VExIqeaEmfxv++/ndopLzR6jdFIzr8bIjO476I0u0kYpe2gHqek9U6hbNCMw
	ZR4A/50mYBXQsbkGLi4pb9N+c26tTKmNTCikZy2P7+KFdcXLgm1s9NkT5uP/FmSA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t92GA-0000000GQ5w-1n2O;
	Thu, 07 Nov 2024 14:09:14 +0100
Message-ID: <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, rrs@debian.org, Benjamin Berg
	 <benjamin@sipsolutions.net>
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>
Date: Thu, 07 Nov 2024 14:09:13 +0100
In-Reply-To: <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
	 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
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

Hi,

So took me a while to grok the context, and to understand why it was
working for me, and broken on another machine...


> I have read the context in [1]. It seems your tool has already used new=
=20
> mount api to mount the hostfs.

Yes, however, that's a default that's entirely transparent to the user.
This is why I wasn't seeing the errors, depending on the machine I'm
running this on, because the 'mount' tool either uses the old or new
style and the user can never know.

> It now rejects unknown mount options as=20
> many other filesystems do regardless of its earlier behavior (which=20
> treats any option as the root directory in hostfs).

And that's clearly the root cause of this regression.

You can't even argue it's not a regression, because before cd140ce9f611
("hostfs: convert hostfs to use the new mount API") it still worked with
the new fsconfig() API, but with the old mount options...

> I'm not sure it is reasonable in this way. If we accept unknown option=
=20
> in the hostfs, it will be treated as root directory. But which one=20
> should be used (like mount -t hostfs -o unknown,/root/directory none=20
> /mnt). So in the conversion, we introduce the `hostfs` key to mark the=
=20
> root directory. May be we need more discussion about use case.

There's only one option anyway, so I'd think we just need to fix this
and not require the hostfs=3D key. Perhaps if and only if it starts with
hostfs=3D we can treat it as a key, otherwise treat it all as a dir? But I
guess the API wouldn't make that easy.

Anyway, I dunno, but it seems like a regression to me and we should try
to find a way to fix it.

johannes

