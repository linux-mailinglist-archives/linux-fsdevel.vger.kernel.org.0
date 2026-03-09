Return-Path: <linux-fsdevel+bounces-79763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PJXJk2zrmkSHwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79763-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:47:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DA259238237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 12:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B375301DD47
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 11:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130603A63F9;
	Mon,  9 Mar 2026 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="Of/BGMVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E193A5E88;
	Mon,  9 Mar 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056833; cv=pass; b=WDqtT67eR56JiJdZmwTQPRBnHHUOkMS4Mq++JUAidJOuG35aCKNA8cXPZAx+krBhBT3WV+aVJWGRzPgpHovLgNbX/4QgmGaz+omlhlx0WKA6QYGER8tS2kjEPsO+3+1IPgO89LqKp2o0SDkpU9GqRAU6MhSIfwwYaT6yOaryF+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056833; c=relaxed/simple;
	bh=Ipl+/yM6I3eAk4SCnrcQ7ZMdV25ap8wBTso2t18eF9c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MwTVJTEyAmAlv9xGm8n9xeLZOyzvCgMlQ81mFlqPLFleGgxVLUMkSOYU/t2FD1Eag5XGxRvWesYrTvgyqehOXIGIhCBmHMUDre4nxxoDaJonfQejwGfRrxWnl+OiOfUtOJTORtXoT/JwCIfBxx+OE7W9evoD4/5rbs+OHj65Gq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=Of/BGMVJ; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1773056810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Y6GpT6NauFmhuzdMi+0FOnIizWrqtb70DaMepSHHarTrGQe0FNUfUNnSAtE3NKgWgmJPE+khANo5AjHskLyLbeyTKG6moaz+RQJ+xdg5YycY3wjsxI7IZhg4fRyPn0eTNP8dmMURs7y6Oqrz8aQPTXWeOQpAwgaYEHr+28C2/uo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773056810; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ipl+/yM6I3eAk4SCnrcQ7ZMdV25ap8wBTso2t18eF9c=; 
	b=X5C6pZIs3cmd7VwNvY81fjXxzZ40gx89+eSnJo1rb9jhJus69FvEBDfBqPTfZxUoesQszsm+EqOmCcDNi/RUKzyQBlOJOjw1I/hYMaCrnQ6JHvs8RYFLqvbPdOcdtLTqbs6oyP1aE28ddNQms2G2xWwobx4ILu1FN3sbdBVRR1w=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773056810;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=Ipl+/yM6I3eAk4SCnrcQ7ZMdV25ap8wBTso2t18eF9c=;
	b=Of/BGMVJfKWumEZlQxRbsVUTI3MEHT6013J3j2alGlE9X8m8g3vskpLN9x7YwIsV
	VOvO/1HTjmYSU3I6U4yJbtc+WhRFymLeh3uOQY/+QaxW/nbX1Ry/qRWskNmBLD8K6sQ
	7woqSimD4++CAW52LM+fPybf0i8Kyxm5/tgeIe/I=
Received: by mx.zohomail.com with SMTPS id 1773056808659808.474338268001;
	Mon, 9 Mar 2026 04:46:48 -0700 (PDT)
Message-ID: <8b2bb4e6d8cff87ace4b0e4d725e4fe573716b80.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v5 1/2] hfsplus: refactor b-tree map page access and
 add node-type validation
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Mon, 09 Mar 2026 17:16:42 +0530
In-Reply-To: <26a565dba487cc1290b9abe5fe54fb068bd475e4.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
	 <20260228122305.1406308-2-shardul.b@mpiricsoftware.com>
	 <26a565dba487cc1290b9abe5fe54fb068bd475e4.camel@ibm.com>
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
X-Rspamd-Queue-Id: DA259238237
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79763-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Mon, 2026-03-02 at 23:25 +0000, Viacheslav Dubeyko wrote:
> On Sat, 2026-02-28 at 17:53 +0530, Shardul Bankar wrote:
> >=20
> >=20
> > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > index 1220a2f22737..87650e23cd65 100644
> > --- a/fs/hfsplus/btree.c
> > +++ b/fs/hfsplus/btree.c
> > @@ -129,6 +129,116 @@ u32 hfsplus_calc_btree_clump_size(u32
> > block_size, u32 node_size,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return clump_size;
> > =C2=A0}
> > =C2=A0
> > +/* Context for iterating b-tree map pages */
>=20
> If we have some comments here, then let's add the description of
> fields.
>=20

Ack'ed.

> > +struct hfs_bmap_ctx {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int page_idx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int off;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 len;
> > +};
> > +
> > +/*
> > + * Maps the specific page containing the requested byte offset
> > within the map
> > + * record.
> > + * Automatically handles the difference between header and map
> > nodes.
> > + * Returns the mapped data pointer, or an ERR_PTR on failure.
> > + * Note: The caller is responsible for calling kunmap_local(data).
> > + */
> > +static u8 *hfs_bmap_get_map_page(struct hfs_bnode *node, struct
> > hfs_bmap_ctx *ctx,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 byte_offset)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u16 rec_idx, off16;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int page_off; /* 32=
-bit math prevents LKP overflow
> > warnings */
>=20
> Do we really need this comment?
>=20

Ack'ed, will remove it.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (node->this =3D=3D HFSPLU=
S_TREE_HEAD) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (node->type !=3D HFS_NODE_HEADER) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err=
("hfsplus: invalid btree header
> > node\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(-EIO);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rec_idx =3D HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0} else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (node->type !=3D HFS_NODE_MAP) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_err=
("hfsplus: invalid btree map
> > node\n");
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return=
 ERR_PTR(-EIO);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0}
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rec_idx =3D HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->len =3D hfs_brec_lenoff=
(node, rec_idx, &off16);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ctx->len)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-ENOENT);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!is_bnode_offset_valid(n=
ode, off16))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EIO);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->len =3D check_and_corre=
ct_requested_length(node, off16,
> > ctx->len);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (byte_offset >=3D ctx->le=
n)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0page_off =3D off16 + node->p=
age_offset + byte_offset;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->page_idx =3D page_off >=
> PAGE_SHIFT;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ctx->off =3D page_off & ~PAG=
E_MASK;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return kmap_local_page(node-=
>page[ctx->page_idx]);
>=20
> This pattern makes me really nervous. :) What if we can calculate the
> struct
> hfs_bmap_ctx *ctx in this function only. And, then, caller will use
> kmap_local_page()/kunmap_local() in one place.
>=20

Good point. Hiding the kmap inside the helper while forcing the caller
to kunmap is a dangerous pattern.
In v6, I will rename the helper to hfs_bmap_compute_ctx(). It will
solely perform the offset math and populate the ctx. The caller will
then explicitly map and unmap the page, ensuring the lifecycle is
perfectly clear.


> > +}
> > +
> > +/**
> > + * hfs_bmap_test_bit - test a bit in the b-tree map
> > + * @node: the b-tree node containing the map record
> > + * @bit_idx: the bit index relative to the start of the map record
>=20
> This sounds slightly confusing. Is it bit starting from the whole map
> or from
> particular map's portion?
>=20

The bit_idx passed to these helpers is strictly relative to the start
of the current map node's record.

> > + *
> > + * Returns 1 if set, 0 if clear, or a negative error code on
> > failure.
> > + */
> > +static int hfs_bmap_test_bit(struct hfs_bnode *node, u32 bit_idx)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_bmap_ctx ctx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *data, byte, m;
>=20
> I think we can use bmap instead of data. The bmap name can show the
> nature of
> data here. Do you agree?
>=20
> I can follow what byte name means. Frankly speaking, I don't know why
> m name is
> used. :)
>=20

Ack'ed. For v6, I will use bmap, mask (instead of m).

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int res;
>=20
> I am not sure that you are really need this variable.
>=20

Ack'ed.

> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data =3D hfs_bmap_get_map_pa=
ge(node, &ctx, bit_idx / 8);
>=20
> What's about BITS_PER_BYTE instead of hardcoded 8?
>=20

Ack'ed.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(data))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(data);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0byte =3D data[ctx.off];
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kunmap_local(data);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* In HFS+ bitmaps, bit 0 is=
 the MSB (0x80) */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0m =3D 1 << (~bit_idx & 7);
>=20
> I am not sure that this calculation is correct. Because bit_idx is
> absolute
> index in the whole map but this operation is inside of particular
> portion of the
> map. Are you sure that this logic will be correct if we have b-tree
> map in
> several nodes?
>=20

I completely understand the concern here, and you are right that if
bit_idx were the absolute index across the entire B-tree, this bitwise
math would break when crossing node boundaries.

However, the architecture here relies on a separation of concerns:
hfs_bmap_free() handles traversing the map chain, while
hfs_bmap_clear_bit() operates strictly on a single node.
In hfs_bmap_free(), the "while (nidx >=3D len * 8)" loop continuously
subtracts the previous nodes' capacities (nidx -=3D len * 8) as it
traverses the chain. By the time it calls hfs_bmap_clear_bit(node,
nidx), the index is strictly relative to the start of that specific
hfs_bnode's map record. Because the index is relative to the node, the
bitwise math safely calculates the correct byte and bit.

To ensure future developers do not mistake this for an absolute index
and misuse the API, I will rename the argument from bit_idx to
node_bit_idx (or relative_idx) in v6 and explicitly document that it
must be bounded by the node's record length.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res =3D (byte & m) ? 1 : 0;
>=20
> You can simply return this statement.

Ack'ed.

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return res;
> > +}
> > +
> > +/**
> > + * hfs_bmap_clear_bit - clear a bit in the b-tree map
> > + * @node: the b-tree node containing the map record
> > + * @bit_idx: the bit index relative to the start of the map record
> > + *
> > + * Returns 0 on success, -EALREADY if already clear, or negative
> > error code.
> > + */
> > +static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 bit_idx)
>=20
> I have the same remarks and concerns for this method too. Please, see
> my remarks
> above.
>=20

Addressed above.

> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct hfs_bmap_ctx ctx;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8 *data, m;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0data =3D hfs_bmap_get_map_pa=
ge(node, &ctx, bit_idx / 8);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(data))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return PTR_ERR(data);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0m =3D 1 << (~bit_idx & 7);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!(data[ctx.off] & m)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0kunmap_local(data);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0return -EALREADY;
>=20
> I am not sure about this error code:
>=20
> #define=C2=A0EALREADY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0114=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Operation already in progress */
>=20
> It sounds more like -EINVAL.
>=20

Agreed, I will change the error code from -EALREADY to -EINVAL in v6.

One additional note for v6: I realized that introducing
hfs_bmap_test_bit() in Patch 1 without calling it until Patch 2
triggers a -Wunused-function compiler warning, which breaks git bisect
cleanliness. To fix this, I will move the introduction of
hfs_bmap_test_bit() into Patch 2 where it is actually consumed by the
mount-time check. hfs_bmap_clear_bit() will remain in Patch 1 since it
is immediately consumed by hfs_bmap_free().


Thanks,
Shardul

