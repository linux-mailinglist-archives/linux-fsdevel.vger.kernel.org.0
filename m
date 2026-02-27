Return-Path: <linux-fsdevel+bounces-78754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LznG9rPoWkfwgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78754-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:09:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5E1BB3EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D770302D5DF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F135B645;
	Fri, 27 Feb 2026 17:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="J97D6RNk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E96528D8D1;
	Fri, 27 Feb 2026 17:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211922; cv=pass; b=OjPc5fzWFemVhseSKN/fYi7E3rfENikfnxIaMpRqqKqrLN+PseURn8QFSrSR4LvIImuI2rg8XRjvc0RKycwmtwewekA0Qe0Tb/hEXMAbeB0NidErM9eY+/uUbTH1DjMT7d+1Qqoe8VyOYyQrb3PfAAYfTNUsuUYK51HdbU+3bXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211922; c=relaxed/simple;
	bh=kfWRfTIDSqg2B9hu2YEcIB/q+pJ2owEpsdr20hpyOM0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KaZUb3WMjs5isCr83qR2Cj81Hq4oPXAt6MFQ0/oUKtrZYUqekr/L69QifyN+etkg8Xg0oaG+ODl44i84DByw3EhILYkCPaE+vvKBWi4IYs7l9chFehXdWUbkecB5qIevdN0XKDksVLImhA3fEHC1Y/MlQLnkBrIiuA1qQsB3QqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=J97D6RNk; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1772211883; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OR4nnIffeMpvg6jOqAF4pPFew4NbI4r02rwaK0MeVYR3v+EkrEha2Dv9xMMtP/OourZdFY8V/yCYMbzBKgMUa99NfhM6li/RoFKJW1WvrT7py7fHkC8BVHqV5/JPE+ymTNHbY+lkpGiMMpBUMcylsEbQeN2H72uFtjxlSXq+Tmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772211883; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=kfWRfTIDSqg2B9hu2YEcIB/q+pJ2owEpsdr20hpyOM0=; 
	b=F1fNOBaaQU77ydhZXvTaVAfp3B55ceHrZGTFoI0L6xjQ7hnBKiNNuoI6U2es2Cmv6qo0m2fpZ0RxsxBduuDdX6ssqkirPGwh/2m3p49EdgI9Vsbt8mSD/ahMmtTlEtj8naA75kMZYd91aaFxanJUT2R4SGjtjoIuyazpcnvRNws=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772211883;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=kfWRfTIDSqg2B9hu2YEcIB/q+pJ2owEpsdr20hpyOM0=;
	b=J97D6RNkqxXm/CVG5YpSaMAAlitOQ3NnZWJgRIj+J0vGVXiYicL9gy4ZUAQ5hJQd
	iV9p7zt+6EMao7yGQR04kWMT+25UCSJU9+662QDN3zFgKKg8HUXIMsnl+dIdXGAjE5L
	ve51XYfFUyZn5sPxEaySQlbUTROs5sXCRP0IXlas=
Received: by mx.zohomail.com with SMTPS id 17722118812471002.445276395772;
	Fri, 27 Feb 2026 09:04:41 -0800 (PST)
Message-ID: <ddbe6849175101b586519a138b0bc50f19b79ce5.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v4 1/2] hfsplus: refactor b-tree map page access and
 add node-type validation
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"frank.li@vivo.com"
	 <frank.li@vivo.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Fri, 27 Feb 2026 22:34:35 +0530
In-Reply-To: <66941e77b76d1930a759a843783f1c68bb3089a8.camel@ibm.com>
References: <20260226091235.927749-1-shardul.b@mpiricsoftware.com>
	 <20260226091235.927749-2-shardul.b@mpiricsoftware.com>
	 <66941e77b76d1930a759a843783f1c68bb3089a8.camel@ibm.com>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[mpiricsoftware.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-78754-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[9];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mpiricsoftware.com:mid,mpiricsoftware.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C6B5E1BB3EA
X-Rspamd-Action: no action

On Thu, 2026-02-26 at 23:50 +0000, Viacheslav Dubeyko wrote:
> On Thu, 2026-02-26 at 14:42 +0530, Shardul Bankar wrote:
> >=20
> > +/*
> > + * Maps the page containing the b-tree map record and calculates
> > offsets.
> > + * Automatically handles the difference between header and map
> > nodes.
> > + * Returns the mapped data pointer, or an ERR_PTR on failure.
> > + * Note: The caller is responsible for calling kunmap_local(data).
> > + */
> > +static u8 *hfs_bmap_get_map_page(struct hfs_bnode *node, u16 *off,
> > u16 *len,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned int *page_idx)
>=20
> I think we don't need in off, len, page_idx arguments here. I suggest
> slightly
> different interface:
>=20
> u8 hfs_bmap_get_map_byte(struct hfs_bnode *node, u32 bit_index);
> int hfs_bmap_set_map_byte(struct hfs_bnode *node, u32 bit_index, u8
> byte);
>=20
> In this case memory operations will be atomic ones and all
> kmap_local()/kunmap_local() will be hidden inside these methods.=20

Hi Slava,

Regarding the get_map_byte/set_map_byte interface: there would be a
severe performance regression if we force
kmap_local_page()/kunmap_local() on a per-byte basis inside the
hfs_bmap_alloc() linear scan. I am providing a detailed breakdown of
this overhead and a proposed alternative in my reply to your review on
Patch 2/2.


> However, I am
> slightly worried that I don't see any locking mechanisms in
> hfs_bmap_alloc(). At
> minimum, I believe we can use lock_page()/unlock_page() here.
> However, it will
> be not enough. It is good for accessing only one page. But we need
> some lock for
> the whole bitmap. Maybe, I am missing something. But if I am not,
> then we have a
> huge room for race conditions in b-tree operations.

Regarding the locking, concurrent access to the allocator is already
prevented by the per-tree tree->tree_lock mutex. Operations that reach
hfs_bmap_alloc() (e.g., node splits via hfs_brec_insert) are executed
within a search context initialized by hfs_find_init(), which holds
mutex_lock(&tree->tree_lock). Therefore, the map nodes are safely
serialized without needing individual lock_page() calls during the
scan.

>=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (;;) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0while (len) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
byte =3D data[off];
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
if (byte !=3D 0xff) {
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (m =3D 0x80, i =3D 0; i < 8; =
m >>=3D
> > 1, i++) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0for (m =3D HFSPLUS_BTREE_NODE0_BI=
T, i
> > =3D 0; i < 8; m >>=3D 1, i++) {
>=20
> You are not right here. The 0x80 is simply pattern and it's not
> HFSPLUS_BTREE_NODE0_BIT. Because, it could be any byte of the map.
>=20

Ack'ed. Good catch, I will retain the original 0x80 pattern in the
allocation loop.

Thanks,
Shardul

