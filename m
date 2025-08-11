Return-Path: <linux-fsdevel+bounces-57427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A16C5B215C4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 21:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 63DD34E0589
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 19:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D932D8DD1;
	Mon, 11 Aug 2025 19:42:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail.lichtvoll.de (lichtvoll.de [37.120.160.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C21311C25;
	Mon, 11 Aug 2025 19:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.120.160.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754941350; cv=none; b=O6NUZj3ODZJUq7ATlExfQR9EFwnRoyNyfo/UzE3sd5fVv0Ud4JSNAo0DDWZnCIByEDK65al4eYBjtAUTQB4RnE9mar0BIjc7sIZAmC9OfDFAs6DFtgEWNFfkGE/+z72uvp5+CFyc3KOPSdZ0V9FW9cJX6AcpaprkHNH3K3LWp3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754941350; c=relaxed/simple;
	bh=nA08QLFisT9ctYCXLGQoB2+RCj9ZIa7mE6Xts4i/6kQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f3HnPFNjI1q6/pJMMuFgqRqG5Yc6HXGjYQYqEoh6XQdJOzUrqVly0EDaxI/g39iHa7SCdTqFmUsnjS8/An/fhoEU5FjalAeuASF8z8XwzQKsuP/W9FhRl7XLWOMJ0e4oRRhGqpRydKc8tgQrys1yxsy0xWpYgD+zoDw4v8C8vE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de; spf=pass smtp.mailfrom=lichtvoll.de; arc=none smtp.client-ip=37.120.160.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(No client certificate requested)
	by mail.lichtvoll.de (Postfix) with ESMTPSA id 6D97E12F029;
	Mon, 11 Aug 2025 19:42:18 +0000 (UTC)
Authentication-Results: mail.lichtvoll.de;
	auth=pass smtp.auth=martin@lichtvoll.de smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Konstantin Shelekhin <k.shelekhin@ftml.net>,
 "Carl E. Thompson" <list-bcachefs@carlthompson.net>
Cc: admin@aquinas.su, linux-bcachefs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 malte.schroeder@tnxip.de, torvalds@linux-foundation.org
Subject: Re: [GIT PULL] bcachefs changes for 6.17
Date: Mon, 11 Aug 2025 21:42:15 +0200
Message-ID: <6189598.lOV4Wx5bFT@lichtvoll.de>
In-Reply-To: <514556110.413.1754936038265@mail.carlthompson.net>
References:
 <3ik3h6hfm4v2y3rtpjshk5y4wlm5n366overw2lp72qk5izizw@k6vxp22uwnwa>
 <iktaz2phgjvhixpb5a226ebar7hq6elw6l4evcrkeu3wwm2vs7@fsdav6kbz4og>
 <514556110.413.1754936038265@mail.carlthompson.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi.

Carl E. Thompson - 11.08.25, 20:13:58 CEST:
> Kent's perplexing behavior [=E2=80=A6 ad hominen attack =E2=80=A6]

Please, stop those ad hominem attacks.

Everyone.

It is not doing any good.


How about starting from a place of assuming good intentions instead? And=20
then try to understand where everyone is coming from? That would be much=20
more in line with a good code of conduct.

Best,
=2D-=20
Martin



