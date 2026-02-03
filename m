Return-Path: <linux-fsdevel+bounces-76170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLkQJdu4gWm7JAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 09:59:07 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0805D67D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 09:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9CD553005179
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 08:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2755B396B7E;
	Tue,  3 Feb 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="kdfrrdhU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875FE29BDBA;
	Tue,  3 Feb 2026 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770109138; cv=pass; b=XX5ntqRr2EwpynhNgoUbcCEFZnj+mQ1wFRpQUp3FPi6DKdua4IjRwo7t9BQBZh3dNZS50PEVdbkOeli37gjb1BT0ZzMXB0JXGN/ywAgJGSApShWRK/RpMGYx9BH6kE1urSaU3Y7h2UqNwxrbVRYfGK6Ci/zQQuvv478wmCT89/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770109138; c=relaxed/simple;
	bh=LlDCcuwADaoB+3xceGYerPLIitEpeAu31eqUTMZAwEE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QznTx4uMLmOGY50Hr/QZWbrifgrrt/rDrjdPy3EJVeaqYEIAkpTL1WxV0QOQn9FxYZiXKu/wCwiiofP7nyj7J4IJ9CgMX5k/wB4+FC/PIJv7g9EkfpvZxL6dhI+ED+zWKXlh/V9xokITgPp0mswo4FAxFSwZAi+B95u+9Bhd8K4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=kdfrrdhU; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1770109108; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ElCdHCFHdnL1Qlj2wg9y/+RpFbiFcLNMzE1mLr+oTGn6RsiSPkycqJEmuPu+lNweNLRiHex6/k2vaR/1mi6Ly0fHBsnHMcWnqDDFQp1TXak/oBVs8Xpk5pKHHUc92rPNcXyaNF9C4aQeG7DCOdKWk+PBUxnLGSKDw6qIIjRpQW8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1770109108; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3pdYLWfsDO9TIfg2PLJt+0E/7ayVJHCutB0QAepJ6AE=; 
	b=AmmDqdJu6sLHp3jZnIdx6bEbtG1zJ3VmAcVr6GnQRT/mYKISULaCnHr/U2Jf8xpnoOULWXmy0djSBzGdCEvGsnD6D+54Cdz+R/w1EJMWpqjZgMpZPdDc8VqOXXz0t+fkA6aKfihyREC5uqQW0wyNTCP452s4slmOKqRXLLBB3JI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1770109108;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=3pdYLWfsDO9TIfg2PLJt+0E/7ayVJHCutB0QAepJ6AE=;
	b=kdfrrdhUA0y3bYH66lzy0XvVZ2MSBKkFYO37Hcnb9CJKwkL4Eo2P5saUGOiNnosg
	MXtFGAcveUG6/w8pU/hvlPS71nW+Z0f46ijKSbfW+Ahou3PS58YWlVSwkr6W8ysvwU9
	B3qUB+7bM5SNVM+ji8pJ31mm9lMuUp825Kj8o0yI=
Received: by mx.zohomail.com with SMTPS id 1770109106606845.6673497740397;
	Tue, 3 Feb 2026 00:58:26 -0800 (PST)
Message-ID: <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "slava@dubeyko.com" <slava@dubeyko.com>, 
	"frank.li@vivo.com"
	 <frank.li@vivo.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "janak@mpiricsoftware.com" <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Tue, 03 Feb 2026 14:28:20 +0530
In-Reply-To: <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
	 <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
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
	TAGGED_FROM(0.00)[bounces-76170-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F0805D67D8
X-Rspamd-Action: no action

On Mon, 2026-02-02 at 20:52 +0000, Viacheslav Dubeyko wrote:
> On Sat, 2026-01-31 at 19:34 +0530, Shardul Bankar wrote:
> >=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Validate bitmap: node 0 (=
header node) must be marked
> > allocated.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0node =3D hfs_bnode_find(tree=
, 0);
>=20
> If you introduce named constant for herder node, then you don't need
> add this
> comment. And I don't like hardcoded value, anyway. :)

Hi Slava, thank you for the review.

Ack'ed. I will use HFSPLUS_TREE_HEAD (0) in v4.

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D hfs_brec_lenoff(node=
,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HFSPLU=
S_BTREE_HDR_MAP_REC, &bitmap_off);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len !=3D 0 && bitmap_off=
 >=3D sizeof(struct
> > hfs_bnode_desc)) {
>=20
> If we read incorrect len and/or bitmap_off, then it sounds like
> corruption too.
> We need to process this issue somehow but you ignore this, currently.
> ;)
>=20

I agree that invalid offsets constitute corruption. However, properly
validating the structure of the record table and offsets is a larger
scope change. I prefer to keep this patch focused specifically on the
"unallocated node 0" vulnerability reported by syzbot. I am happy to
submit a follow-up patch to harden hfs_brec_lenoff usage. As per your
suggestion, ignoring this currently. ;)

> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0hfs_bnode_read(node, &bitmap_byte, bitmap_off, 1);
>=20
> I assume that 1 is the size of byte, then sizeof(u8) or
> sizeof(bitmap_byte)
> could look much better than hardcoded value.

Ack'ed. Changing to sizeof(bitmap_byte).

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if (!(bitmap_byte & HFSPLUS_BTREE_NODE0_BIT)) {
>=20
> Why don't use the test_bit() [1] here? I believe that code will be
> more simple
> in such case.

I reviewed test_bit(), but I believe the explicit mask is safer and
more correct here for three reasons:
1. Endianness:
The value we=E2=80=99re checking is an on-disk bitmap byte (MSB of the firs=
t
byte in the header map record). test_bit() is designed for CPU-native
memory bitmaps. HFS+ bitmaps use Big-Endian bit ordering (Node 0 is the
MSB/0x80). On Little-Endian architectures (like x86), test_bit(0, ...)
checks the LSB (0x01). Using it here could introduce bit-numbering
ambiguity.

For example, reading into an unsigned long:
    unsigned long word =3D 0;
    hfs_bnode_read(node, &word, bitmap_off, sizeof(word));
    if (!test_bit(N, &word))
        ...

...but now N is not obviously =E2=80=9CMSB of first on-disk byte=E2=80=9D; =
it depends
on CPU endianness/bit numbering conventions, so it becomes easy to get
wrong.

2. Consistency with Existing HFS+ Bitmap Code:
The existing allocator code already handles on-disk bitmap bytes via
explicit masking (hfs_bmap_alloc uses 0x80, 0x40, ...), so for
consistency with existing on-disk bitmap handling and to avoid the
above ambiguity, I kept the explicit mask check here as well:
    if (!(bitmap_byte & HFSPLUS_BTREE_NODE0_BIT))   (with
HFSPLUS_BTREE_NODE0_BIT =3D BIT(7) (or (1 <<7)))

3. Buffer safety:
Reading exactly 1 byte (u8) guarantees we never read more data than
strictly required, avoiding potential boundary issues.

Am I missing something here or does this make sense?

If there's a strong preference for bitops helpers, I could investigate
the big-endian bit helpers (*_be), but for this single-byte invariant
check, the explicit mask seems clearest and most consistent with
existing code.

>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pr_war=
n("(%s): Btree 0x%x bitmap corruption
> > detected, forcing read-only.\n",
>=20
> I prefer to mention what do we mean by 0x%x. Currently, it looks
> complicated to
> follow.

Ack'ed. I am adding a lookup to print the human-readable tree name
(Catalog, Extents, Attributes) alongside the ID.

>=20
> > =C2=A0#define HFSPLUS_ATTR_TREE_NODE_SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A08192
> > =C2=A0#define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A03
> > +#define HFSPLUS_BTREE_HDR_MAP_REC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0/* Map
> > (bitmap) record in header node */
>=20
> Maybe, HFSPLUS_BTREE_HDR_MAP_REC_INDEX?

Ack'ed.

>=20
> > =C2=A0#define HFSPLUS_BTREE_HDR_USER_BYTES=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0128
> > +#define HFSPLUS_BTREE_NODE0_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x80
>=20
> Maybe, (1 << something) instead of 0x80? I am OK with constant too.

Ack'ed, will use (1 << 7). Can also use BIT(7) if you prefer.

> Thanks,
Shardul


