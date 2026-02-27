Return-Path: <linux-fsdevel+bounces-78755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KB44HQ3PoWn3wQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78755-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:06:21 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A61D1BB304
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D2ED7303A883
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6623612FA;
	Fri, 27 Feb 2026 17:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="VMsjgNqr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750F035CBDD;
	Fri, 27 Feb 2026 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211941; cv=pass; b=iQZ2D2e5DJjGdpGpKqSLq3cG7HcISEYsop/b4ujplHD50Bchdjsc6EUnMn7u0CdUBp6HGM30pZKOP4bM2S7CbsfMyeXMaEvAUeNCDgaoIdSwG0iO+05q/s6HX8xctDtRGSYjNjiQ5xJyBjyRVzD6kEGSqO3MvqiMUJzwxTkaUA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211941; c=relaxed/simple;
	bh=H8DyLWsQ7NOgYQlaJ2DWUZ0puthu8F2YnJ4Khk2Slq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjzFwpXqpC/3Jb7ykxEFHkTcim5DQGAhlQ+xBzsWFMvEOV22NWzJVOLuQF+qPzyrloBLesLkuW3XGT7U3PCtR+rtemyCcNv+zXFR1BayEUVJJ/1tH4DAD/3fDOW67yGhko+SVr5KJ2riCEwnzjH7kGdtLNA5+WHa5IaYh4ZmZuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=VMsjgNqr; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772211899; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OXwqiOgoqfZV3ebvRx0WBiE5MeGO/kwXqlqMju8f2CNLyCQ0xQilgzAgmZb40roNrA0oGmGlhsKyWyjEAP8AN+x2HVLnchyJ/MJovXkIVxVqPqunMf7UzKfCfENvC4KG1ZxvJ3dZUweT8xxnnV1VyGkncqjzgs6z7AdRTneBn7w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772211899; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TA3sRHKe0OcNPL6uH6v4W54gyE+1eSoM+HnL7BDXkgw=; 
	b=Evp2hH+1l0k/JRRgroj5qQJ92QEmT5X7EqgfeGhX+kmlsfeVSjIxpoCXPqrsw3RdslnQ4/T09eBaD2zJojepLsUZgxkHVOWQ/GrIUUAXKhcY98R/AEvDCZF5JWyogdPJTsbQCQM5iVWQ7QdOSHhxPKbO/IEi8DbKPRyh+blFCaM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772211899;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=TA3sRHKe0OcNPL6uH6v4W54gyE+1eSoM+HnL7BDXkgw=;
	b=VMsjgNqrapvXynl5X+904d+71TUgsW1ondPbxEaVLMu+RvG0xe1FHVekmTuM6kD2
	uXMW7ATYYFzy6L9ALInGKM/SYDG1ztieHzEU1jamSPL3FB5+F6Y2s03Nc1Ticz3xiTd
	gmB+Bs1QDNsSwlOU6F3YdujWsGlChNrol5/acH1w=
Received: by mx.zohomail.com with SMTPS id 1772211897618310.3022746451577;
	Fri, 27 Feb 2026 09:04:57 -0800 (PST)
Message-ID: <7d3c9221cc49a47779606d8c67667544f27de2df.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"frank.li@vivo.com"
	 <frank.li@vivo.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Fri, 27 Feb 2026 22:34:52 +0530
In-Reply-To: <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
	 <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
	 <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78755-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mpiricsoftware.com:mid,mpiricsoftware.com:dkim]
X-Rspamd-Queue-Id: 9A61D1BB304
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 23:29 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-02-26 at 14:42 +0530, Shardul Bankar wrote:
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (id) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_EXT_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tree_name =3D "Extents";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_CAT_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tree_name =3D "Catalog";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_ATTR_CNID:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tree_name =3D "Attributes";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0tree_name =3D "Unknown";
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
>=20
> Frankly speaking, it could be enough to share only cnid. But if you
> would like
> to be really nice and to share the tree's name, then I prefer to see
> an array of
> constant strings where you can use cnid as an index. And macro or
> static inline
> method that can check cnid as a input argument. At minimum, simply
> move this
> code into the static inline method. But, array of constant strings
> could be much
> compact and elegant solution for my taste. Because, art of
> programming is to
> represent everything as arrays of something and to apply the
> generalized loops.
> :)
>=20

Hi Slava,

Sounds good. :) I will implement an array of constant strings indexed
by cnid in v5.

> I prefer not to have the obligation of using this asynchronous
> paradigm of
> kmap_local()/kunmap_local(). It will be great to keep this inside of
> hfs_bmap_get_map_<something>() method.
>=20
> I prefer not to keep the whole page/folio for complete operation
> locked. And,
> frankly speaking, you don't need in the whole page because you need a
> byte or
> unsigned long portion of bitmap. So, we can consider likewise
> interface:
>=20
> u8 hfs_bmap_get_map_byte(struct hfs_bnode *node, u32 bit_index);
>=20
> Here, you simply need to check the state of bit in byte (READ-ONLY
> operation).
> So, you can atomically copy the state of the byte in local variable
> and to check
> the bit state in local variable.
>=20

While this byte-level interface is perfect for the mount-time
validation in hfs_btree_open() where we only need to check a single
bit, using it inside hfs_bmap_alloc() introduces a significant
performance regression.

Because hfs_bmap_alloc() performs a linear scan to find a free node,
using hfs_bmap_get_map_byte() inside the while (len) loop would force
the kernel to execute kmap_local_page() and kunmap_local() for every
single byte evaluated (potentially thousands of times per page). The
current logic maps the page once, scans memory linearly, and only
unmaps when crossing a PAGE_SIZE boundary.

To address your request for a generalized map access method without
sacrificing the allocator's O(N) scanning performance, how about this
for v5?

    -We introduce the hfs_bmap_get_map_byte() specifically for single-
bit reads (like the mount-time check). This can internally call
hfs_bmap_get_map_page() from Patch 1/2 to avoid duplicating the offset
math.

    -We retain the page-level helper (hfs_bmap_get_map_page) for
hfs_bmap_alloc() to preserve its fast linear scanning.

Let me know if this dual-helper approach sounds acceptable, and I will
prepare v5.

Thanks,
Shardul

