Return-Path: <linux-fsdevel+bounces-26399-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E93E958EB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9E2AB222C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0AE5157488;
	Tue, 20 Aug 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b="hsUqAq3D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from nov-007-i674.relay.mailchannels.net (nov-007-i674.relay.mailchannels.net [46.232.183.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA4818E344
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.232.183.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724182872; cv=none; b=WP/rDs7A1moaz6jUDsMNsF24xxSIyGFl6CLZ1d5kLPywirzI6CBa1Oe2lgBrNFKKzjV3tjguD35sSe5K61Rk/GXWOptts9Ppf1A+ho79O94MSDUVlAKRvAutcDKC21CWJceUy22k8ZVt8zbZ2qX6Wp28a2wPzVIuHvU1jIJjCm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724182872; c=relaxed/simple;
	bh=R16rU2/2jUzw7hsMxQEPVFBSANsG6uCqEI/fMe006dU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YfV87buG2CqQKn/dYcTHQP2B9vQfexdUb6cDs5pGBxYVqBfB82coWj8xBjc47NwpiUNf+9Up8MWllwDSDDkepjV1+vhCpVl6ZzSjcOlbttQo7IrVlVBRdl97GYf8li7flD0ciEgZFRos+wj/9qUjHXOroFLIheh+sFeUnFJL1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch; spf=pass smtp.mailfrom=bitron.ch; dkim=pass (2048-bit key) header.d=bitron.ch header.i=@bitron.ch header.b=hsUqAq3D; arc=none smtp.client-ip=46.232.183.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitron.ch
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id A85E56C0090;
	Tue, 20 Aug 2024 12:57:09 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Drop-Zesty: 35c074cb1114ae44_1724158628999_1251448083
X-MC-Loop-Signature: 1724158628999:1204312
X-MC-Ingress-Time: 1724158628999
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitron.ch;
	s=default; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=n7zgAnQMqBioxrmxJr5nMa8DsN3lhqmmF/39n5E226M=; b=hsUqAq3DwA4y8veWc5GORBhBc9
	zlYLgKe0okkA89u/HbeLzRiB1LE2+v1Rn6N0kGk7Edf/xFlBBNtKQdZpPN1uAPUa1tY6V8/r8HV9q
	fceh2g4lMhAOFdLjmq+lOoKE6e+9szPM+Qh4ooGXChpQssg+POM3hxiJkiWdnpRCZOFQGEmX/S0tL
	5+VPDY3yzIoph4TgZKRoENJryiOSsvk/MVkNilrSEf8GMSj2tyzm1FI5KKOCZuiM0a1S45gb9H6Py
	eV3e+IURHNYF971fVox+2eQzUFianzxfN0n3NHWV06DUTrFahHLQVW2dQpQk5NOIGyBat7YMYN4IY
	t7lnJecw==;
Message-ID: <2aeca29ce9b17f67e1fac32b49c3c6ec19fdb035.camel@bitron.ch>
Subject: Re: [PATCH 3/3] fuse: use folio_end_read
From: =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org
Date: Tue, 20 Aug 2024 14:57:04 +0200
In-Reply-To: <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
References: <ZrY97Pq9xM-fFhU2@casper.infradead.org>
	 <20240809162221.2582364-3-willy@infradead.org>
	 <d0844e7465a12eef0e2998b5f44b350ee9e185be.camel@bitron.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-AuthUser: juerg@bitron.ch

On Sat, 2024-08-10 at 14:24 +0200, J=C3=BCrg Billeter wrote:
> On Fri, 2024-08-09 at 17:22 +0100, Matthew Wilcox (Oracle) wrote:
> > part three
> >=20
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> > =C2=A0fs/fuse/file.c | 4 +---
> > =C2=A01 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 2b5533e41a62..f39456c65ed7 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -937,9 +937,7 @@ static void fuse_readpages_end(struct
> > fuse_mount
> > *fm, struct fuse_args *args,
> > =C2=A0	for (i =3D 0; i < ap->num_pages; i++) {
> > =C2=A0		struct folio *folio =3D page_folio(ap->pages[i]);
> > =C2=A0
> > -		if (!err)
> > -			folio_mark_uptodate(folio);
> > -		folio_unlock(folio);
> > +		folio_end_read(folio, !err);
> > =C2=A0		folio_put(folio);
> > =C2=A0	}
> > =C2=A0	if (ia->ff)
>=20
> Reverting this part is sufficient to fix the issue for me.

Would it make sense to get a revert of this part (or a full revert of
commit 413e8f014c8b) into mainline and also 6.10 stable if a proper fix
will take more time?

Cheers,
J=C3=BCrg

