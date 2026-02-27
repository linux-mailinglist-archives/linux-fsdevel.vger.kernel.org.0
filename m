Return-Path: <linux-fsdevel+bounces-78798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uF7cG80Uomk0zAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78798-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:03:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB791BE674
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 23:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0646A3040FCB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 22:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12165478E30;
	Fri, 27 Feb 2026 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Pk7pQspl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7F147A0B0;
	Fri, 27 Feb 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772229819; cv=pass; b=cYewfRLwF8kRMj7eejlkCRR+hSI0+JBl2sZ3BhDHpxBuHvZ0umUkaBCyK02oimdKfNehW+9ED/sueerd7PCrXukVu9evMsgK8LGR0uRfIyN5Ha910fpfv4BKSrFbL5y6zxyoNdwxZ7noV9+zqKYRrWWu+AZX6WpvAej3HvsXQ4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772229819; c=relaxed/simple;
	bh=LDYTj5OxbyuwKsyUE+6i3Bfr4+E0CrRDPBarTd4c+/k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cYnZ0JpHAct40OwAiyS1NcebqYefqTfU56+Zsg2SfAUNmWHG4brLw+4elMPB6H5gCVWoWUYl6P+MX0n2fpNlZNoEZYdpEs1lKcEqHak05peGweGbISorR7gpc14mfw4RrF0wan1RP6/pbHrpinKY3jmJo1GWcSzcM6yysu1Legw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Pk7pQspl; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772229787; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hbVu7DkeFSy8/9xcMKPmTIVznPvm4uCkTM7qFPk5wIt4HE5LYuQe7Rt/N3MSsW9e0+YDp8mggp1vziU9CZ/GASBv5AHdwDgXN9eo1SbX2EgKMzgqJehdECB4XpetDl4fH/giJ502f8iPEAfv5fY29lPez7SqUedgGj8qSHnGoF0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772229787; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LDYTj5OxbyuwKsyUE+6i3Bfr4+E0CrRDPBarTd4c+/k=; 
	b=lWKsxJS6DS9k5a0MQVhh8udCw1U+3/wR17jTa6LcdgN6WyDce7WW4s1f6pRGrlM/FsAcBVVMY8n7Wb14aMqr35ska6BbsI8labDl9+pEz4eeKeoVd0VvOHtQblw581xzW16MefMgPTDm3mljA4zYI+TGnN6HC6qFAUHAhQKoFwY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772229787;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=LDYTj5OxbyuwKsyUE+6i3Bfr4+E0CrRDPBarTd4c+/k=;
	b=Pk7pQspl7SqZ4pPikGi2jdSY6steskcHJ4v51gJWAmDxZnTEJbvTc4Ofd3lwq/jT
	HRO82bnDAbsYUiUQkNQ0uV05dG93rGOA6Goy/JTdhxKQqUBEjNcmVFaQdfIlrmDz1Oa
	CqmNKsVFTrxb57R8MXYdKy0PgizNVUfEZX805XyE=
Received: by mx.zohomail.com with SMTPS id 177222978431497.34944592459851;
	Fri, 27 Feb 2026 14:03:04 -0800 (PST)
Message-ID: <7194aa49efdb85c7cfc9578f1460aaa9a1c67095.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v4 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Sat, 28 Feb 2026 03:32:58 +0530
In-Reply-To: <9f6e83c657586caa86483db77df401a67f903361.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
	 <20260226091235.927749-3-shardul.b@mpiricsoftware.com>
	 <5deb0aa2971a6385091c121e65f0798de357befd.camel@ibm.com>
	 <7d3c9221cc49a47779606d8c67667544f27de2df.camel@mpiricsoftware.com>
	 <9f6e83c657586caa86483db77df401a67f903361.camel@ibm.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-78798-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CB791BE674
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 20:11 +0000, Viacheslav Dubeyko wrote:
> On Fri, 2026-02-27 at 22:34 +0530, Shardul Bankar wrote:
> > On Thu, 2026-02-26 at 23:29 +0000, Viacheslav Dubeyko wrote:
> > > On Thu, 2026-02-26 at 14:42 +0530, Shardul Bankar wrote:
> > >=20
> > >=20
> >=20
> > While this byte-level interface is perfect for the mount-time
> > validation in hfs_btree_open() where we only need to check a single
> > bit, using it inside hfs_bmap_alloc() introduces a significant
> > performance regression.
> >=20
> > Because hfs_bmap_alloc() performs a linear scan to find a free
> > node,
> > using hfs_bmap_get_map_byte() inside the while (len) loop would
> > force
> > the kernel to execute kmap_local_page() and kunmap_local() for
> > every
> > single byte evaluated (potentially thousands of times per page).
> > The
> > current logic maps the page once, scans memory linearly, and only
> > unmaps when crossing a PAGE_SIZE boundary.
> >=20
> > To address your request for a generalized map access method without
> > sacrificing the allocator's O(N) scanning performance, how about
> > this
> > for v5?
> >=20
> > =C2=A0=C2=A0=C2=A0 -We introduce the hfs_bmap_get_map_byte() specifical=
ly for
> > single-
> > bit reads (like the mount-time check). This can internally call
> > hfs_bmap_get_map_page() from Patch 1/2 to avoid duplicating the
> > offset
> > math.
> >=20
> > =C2=A0=C2=A0=C2=A0 -We retain the page-level helper (hfs_bmap_get_map_p=
age) for
> > hfs_bmap_alloc() to preserve its fast linear scanning.
> >=20
> > Let me know if this dual-helper approach sounds acceptable, and I
> > will
> > prepare v5.
> >=20
> >=20
>=20
> I think your point makes sense. I missed this. However, we need to
> keep the
> methods simple and understandable. First of all, if we need to return
> multiple
> items from the method, then we definitely need some structure
> declarations that
> can be used.
>=20

Agreed. To clean up the method signature for hfs_bmap_get_map_page(), I
will introduce a small structure (e.g., struct hfs_bmap_loc) to hold
the off, len, and page_idx variables instead of passing multiple
pointers.

> As far as I can see, we never had method for bit state check in the
> b-tree map
> before. However, we have hfs_bmap_free() method that is one bit
> change
> operation. So, we could have one bit check (hfs_bmap_test_bit()) and
> one bit
> change (hfs_bmap_set_bit()) pair of methods that could hide all of
> these memory
> pages operations.

This sounds like a good API improvement. I will introduce
hfs_bmap_test_bit() for the mount-time Node 0 check in v5. It can
internally call hfs_bmap_get_map_page() to avoid duplicating the offset
math, while safely encapsulating the kmap_local/kunmap_local for
single-bit reads.

>=20
> However, hfs_bmap_alloc() is slightly special one. Probably, we could
> not make
> significant changes in core logic of this method. However, your
> vision of
> auxiliary method can be useful here. Yes, we need to execute
> kmap_local_page()
> for the page, then do the search/allocation, and execute
> kunmap_local(). You are
> right here. But, for my taste, the whole logic of linear search looks
> like not
> very efficient. Do you see any ways of optimizations here? Could we
> employ tree-
> > node_count? Or, maybe, introduce some in-core variable(s) that will
> > keep
> knowledge about last allocation/free? And we can use this knowledge
> to start
> from the most beneficial region of search?
>=20

I like the idea of introducing an in-core allocation hint (a roving
pointer) to struct hfs_btree to convert this into a next-fit allocator,
and reusing the map-chain seek logic currently in hfs_bmap_free() to
jump directly to the beneficial region. Bounding the inner scan loop
with tree->node_count also seems like a good correctness optimization
to avoid scanning padding bytes.

However, the current patch series is targeted at the mount-time bitmap
corruption vulnerability. To keep the scope aligned, would it be
acceptable to finalize this current 2-patch series (the map access
refactoring + the Node 0 mount-time validation) in v5, and I will open
a separate thread/patchset afterward to pursue this alloc_hint and
node_count optimization?

Thanks,
Shardul

