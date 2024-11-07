Return-Path: <linux-fsdevel+bounces-33910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37109C090A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 15:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2323EB2102A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Nov 2024 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64815212EF0;
	Thu,  7 Nov 2024 14:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QyJ0Rekw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726111F12E9
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Nov 2024 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730990152; cv=none; b=tnKhA3ca0QDdxGRLUkPdPKEM7YzmUK3AKhcb9fFY+CGml+Jc8wgb4dkrp2KkJ2jj1u24nzzcmAM4TTz3ssZA9/KmES04PSbMLvZmLlGHSnn3sNZCvtYNmSFQ2ejBmZ+KBype/1yCk6gi6EZ9bJDFgFx9seKww/AfQWkao40MBXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730990152; c=relaxed/simple;
	bh=8sJYvbPR3ENy+PnI0ObCarRn8/QmOnSdBCDtO3hJbu4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAF09ySbdqCjMcTKaxBkMG7QWQAqs8Uy4DiYzIRFuCe0spR8DJy8Czt/cNhqg9F+wFglgtA2lpBhyTRW4LWmtqqCDEovScJfR6iKUBSjqCPpzr1FWy+iMq+eDNbephFOYs0HsnDOaR54wr7IabiW/0l3D5YJuRch8qxt8zo+6Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QyJ0Rekw; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=8sJYvbPR3ENy+PnI0ObCarRn8/QmOnSdBCDtO3hJbu4=;
	t=1730990151; x=1732199751; b=QyJ0Rekwy75CBw4Ng2be2WkJebgr1wNHowSB19gDYgG3eGU
	OckMuflGlv9wPF+QpwwzFy5jX17YdFS4GwrutFKDl+XTstUiVjXUtgUsj10WsAIXAByYtPNj29JpD
	/thuwf/CHM6tw9pmruu3b8iM6psDmGd5VCLazlsPkwwZWOtrk7tB+nT4DztIu6+M9bYzBHLgfuZ3R
	FQsA9W8jzMt3zK2CdTcpX7HVBcPJfbh6Js+wwsDx6Ql9JwwNx8WuXCmOOVgKzf9QGiFv8MxG6128z
	DlOavHSlAO5Nam1j7oainWi6pm1jaYrMY0619e+1VIogi5Yb6kQllwJK1XnirXVA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1t93bt-0000000GSI2-3sTO;
	Thu, 07 Nov 2024 15:35:46 +0100
Message-ID: <ac1b8ddd62ab22e6311ddba0c07c65b389a1c5df.camel@sipsolutions.net>
Subject: Re: UML mount failure with Linux 6.11
From: Johannes Berg <johannes@sipsolutions.net>
To: Hongbo Li <lihongbo22@huawei.com>, rrs@debian.org
Cc: linux-um@lists.infradead.org, linux-fsdevel@vger.kernel.org, Christian
 Brauner <brauner@kernel.org>, Benjamin Berg <benjamin@sipsolutions.net>
Date: Thu, 07 Nov 2024 15:35:45 +0100
In-Reply-To: <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
References: <857ff79f52ed50b4de8bbeec59c9820be4968183.camel@debian.org>
	 <2ea3c5c4a1ecaa60414e3ed6485057ea65ca1a6e.camel@sipsolutions.net>
	 <093e261c859cf20eecb04597dc3fd8f168402b5a.camel@debian.org>
	 <3acd79d1111a845aed34ed283f278423d0015be3.camel@sipsolutions.net>
	 <0ce95bbf-5e83-44a3-8d1a-b8c61141c0a7@huawei.com>
	 <420d651a262e62a15d28d9b28a8dbc503fec5677.camel@sipsolutions.net>
	 <f562158e-a113-4272-8be7-69b66a3ac343@huawei.com>
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

On Thu, 2024-11-07 at 22:17 +0800, Hongbo Li wrote:
> > There's only one option anyway, so I'd think we just need to fix this
> > and not require the hostfs=3D key. Perhaps if and only if it starts wit=
h
> > hostfs=3D we can treat it as a key, otherwise treat it all as a dir? Bu=
t I
>=20
> May be we can do that (just record the unknown option in host_root_path=
=20
> when fs_parse failed). But this lead us to consider the case in which we=
=20
> should handle a long option -o unknown1,hostfs=3Dxxx,unknow2, which one=
=20
> should be treated as the root directory? For new mount api, it will call=
=20
> fsconfig three times to set the root directory. For older one, if one=20
> path with that name exactly, may be it can mount successfully.

Technically, comma _is_ valid in a dir name, as you say ... so perhaps
the new mount API handling would need to be modified to have an escape
for this and not split it automatically, if the underlying FS doesn't
want that? Or we just revert cd140ce9f611 too?

I feel like perhaps we just found a corner case - clearly the new mount
API assumes that mount options are always comma-separated, but, well,
turns out that's simply not true since hostfs has only a single option
and treats the whole thing as a single string.

johannes

