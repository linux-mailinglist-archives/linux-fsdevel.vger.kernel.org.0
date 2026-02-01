Return-Path: <linux-fsdevel+bounces-76007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGYmMOE7f2lcmAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76007-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 12:41:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2505AC5CD1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 12:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60CEB303AF28
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15D432D7FB;
	Sun,  1 Feb 2026 11:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="dCsnd9+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699B932D0EF;
	Sun,  1 Feb 2026 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769946033; cv=pass; b=X+n1frPvWekecCNepYn3r6/fBhg114Hd7zTIAmhEA7aSC5U8V164nuC+1VqXi1Z6aMC3h69Ubz713Cdkgd9HTTIyyW/6lbCrZVAO11AXKNI58dDJKarEXZ3OXjOTMkWHQJWvFJ0BvXH37HkUG7fBFiJ6yBrlJw8TnpSt2baIj7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769946033; c=relaxed/simple;
	bh=aAWXH3zNYZU1254YpQNC4vS2Iwh7uaBV81vvI706B0Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6T+ioMcV/Xt5HNV9wRAM83Lc+RLRYz7JJ6/Ea8lo++9ovPBlyoCzWwWYBEFjBLj3dPw8pAoaxqC25IOVsEKvTvaMsV0xRsOKvYEiybDqOq0yenkxFOZcsy2gSwPLTbfiNtGu6dpPcTD3PRkupD4aTxnq3JLzydGmVyoQViVsxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=dCsnd9+r; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1769945992; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=k/OPefl+vawyeSE5kOtUHkF1p102atE3MLuRk0c2Q56ie8x8nuXXkuUlWka422ZWmiMkgyxGA9e+vUVRsTp8UCXO/ZvkZpm0t3u7Np/Lf77CgwNjj51vdkpFkK8cH71XPPgzUELpNnj7He4P5HSCcNg13gnf4aOurl6q0wDbdYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769945992; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aAWXH3zNYZU1254YpQNC4vS2Iwh7uaBV81vvI706B0Y=; 
	b=bEguex5iGoJVA2iCIjgQu/1d3mfaUHQUdJYRYneru9KwcyYJB7qqY43ImcFAwQzKPUZhKoNR22KAU2yPrs8dLDCHD/gJgkH62bm9+DxvP9dRyRMEMuARtkUkzIZObrbsDmRmM0EMzuwDuzhm3GT4Bkpi4t0d5KbWRwqr+r3/Ruo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769945992;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=aAWXH3zNYZU1254YpQNC4vS2Iwh7uaBV81vvI706B0Y=;
	b=dCsnd9+rHtIyj0RpHxTn/Jv8nAiBgr8f7tP2g5qQGtU/xcAE11sG6Re79GUX2M4T
	mp/AqJgZz2hqMT7rkFfvf02IiUns/mhvTxVGvqWP3AvtWapsxQPnfbkvo71LwDP2gsI
	QZIyKhzwgcvyDVCqLtNfawqP4XkQoEJND3xPlyog=
Received: by mx.zohomail.com with SMTPS id 176994598961662.700723594105966;
	Sun, 1 Feb 2026 03:39:49 -0800 (PST)
Message-ID: <5edc62f11796c116fb499fe2934c487f087a2cdd.camel@mpiricsoftware.com>
Subject: Re: [PATCH] fs/super: fix s_fs_info leak when setup_bdev_super()
 fails
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, janak@mpiricsoftware.com, slava@dubeyko.com, 
 syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com, shardulsb08@gmail.com
Date: Sun, 01 Feb 2026 17:09:44 +0530
In-Reply-To: <20260201082724.GC3183987@ZenIV>
References: <20260201073226.3445853-1-shardul.b@mpiricsoftware.com>
	 <20260201082724.GC3183987@ZenIV>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76007-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,vger.kernel.org,mpiricsoftware.com,dubeyko.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2505AC5CD1
X-Rspamd-Action: no action

On Sun, 2026-02-01 at 08:27 +0000, Al Viro wrote:
> On Sun, Feb 01, 2026 at 01:02:26PM +0530, Shardul Bankar wrote:
>=20
>=20
> First of all, _what_ ->put_super()?=C2=A0 Forget ->s_root, ->s_op is
> not going to be set there, so there's nowhere to get ->put_super()
> from.=C2=A0 Relevant thing here is ->kill_sb().
>=20
Right, good catch- at that point ->s_op isn=E2=80=99t set yet, so ->put_sup=
er()
isn=E2=80=99t even a thing to rely on. Thanks for pointing that out.

The leak here is actually originating from hfsplus
(hfsplus_init_fs_context()).

> Freeing ->s_fs_info is better done there anyway - makes for simpler
> handling of foo_fill_super() failure exits, exactly because you don't
> need to free the damn thing there - just let your ->kill_sb() deal
> with
> it.
>=20
> The thing is, there are ->kill_sb() instances that do just that and
> I'm not at all sure they won't be broken by this patch.
>=20
> Note that right now it's either "deactivate_locked_super() done, -
> >free()
> is told to bugger off" or "->free() is called,
> deactivate_locked_super()
> and ->kill_sb() isn't"; you are introducing a new situation here.

I see your concern about introducing a new ownership state for
s_fs_info (handing it back to fc while still going through
deactivate_locked_super() / ->kill_sb()), which could break filesystems
that already free s_fs_info from ->kill_sb().

I'll drop this patch and raise a new one by fixing the leak in the
filesystem side instead (HFS+), making sure its ->kill_sb() path
reliably frees s_fs_info even when we fail before fill_super() runs,
and I=E2=80=99ll add the HFS+ maintainer(s) on that patch.

Thanks,
Shardul

