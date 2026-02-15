Return-Path: <linux-fsdevel+bounces-77253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDSgNyIJkmk4pwEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 18:57:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D969113F4F2
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 18:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49443301C88A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Feb 2026 17:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E122DC35F;
	Sun, 15 Feb 2026 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="FouV3pSd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DA223BCED;
	Sun, 15 Feb 2026 17:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771178268; cv=pass; b=U2YWk5rJZ7QHvs+x3Aktikqf3IXg4wFk/DavM7D5l4Tkfn77JiSpFtNwW+JruT53YwGDKjW4qD9sWXMDhwdVgotp/0k5Is7xRcHjX1QRbsfUWD9lsa/R+jBEUDu0e/WHsJj5vmn/5XA94YCEpePJNxJV7hTSoojRWLqcr5PEUg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771178268; c=relaxed/simple;
	bh=rGpULnqXErZ3Mwey6t1w0bEzalG2xJ0yeQsNlLeRyR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fa3n/axJbNQueGXBZdsPcCFG8EcgQ0Y4I/dCbr6N+6xUitwf1/AslE6+gtRvm7sg5kAeilbTDMnCxgAPfxnNFZ11T56W2/unB53R0OhSw62S1VAN8PvQQZIYqcewyL7CA98z85JzbYZW2vo4x8WcY3aWmH95eaVftod5wHnFTHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=FouV3pSd; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1771178251; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Elm6rM1KEDxXqCBFRF9I6y1FDEZZ0PLzx5vB/g7Zxc7k+2WxWtaysEmqqEJbyPExvvnQGCRwA4H7y5f5ff6Ql1ANVJpXVBqZAYBp/hzfktYl/dMhX/IHt9WAetJwuUsKDJgF1hUUqYaY+fPfiyYFUK+btUZ3h0UvHLzwT1MeLo0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771178251; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=o2ufeDH50r06oqDieu7bHJP4Jzs42N07AhmFMPxluko=; 
	b=KDf9KmqrUPr6aRD2ZZ3CO3y/BWNqbAjyd3RxJBLRcVULyx8QvjL5c2CkvX/wj/U2VPk06UwZW6C2Ob/4w/8C674M8yjqvscuayiyipDp03Oe85NBVgqoQyaHixMtR9SN8XY6f+ci0lfPPKaoPOQt4djovns8ap1v6/1rOSceQ8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771178250;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=o2ufeDH50r06oqDieu7bHJP4Jzs42N07AhmFMPxluko=;
	b=FouV3pSdcT24ZTtuwzz9MQo6/tcMw4/CpdgzT5MGbwzCmafDfujodiV7NgzHt+38
	no01Se1K/geE7hbLbTbWsAo3CSsjFQrIers/6dEGlCDVVQ99UK04LLbCswjH3+eLDVb
	TztHiA+9yd5khKZ+qdJiPyvs36vNJ5qYG8wcoBns=
Received: by mx.zohomail.com with SMTPS id 17711782489380.7800935373936682;
	Sun, 15 Feb 2026 09:57:28 -0800 (PST)
Message-ID: <de25fb7718e226a55dbc012374a22b7b474f0a0a.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v3] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Cc: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	"janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Sun, 15 Feb 2026 23:27:22 +0530
In-Reply-To: <c755dddccae01155eb2aa72d6935a4db939d2cd7.camel@ibm.com>
References: <20260131140438.2296273-1-shardul.b@mpiricsoftware.com>
	 <85f6521bf179942b12363acbe641efa5c360865f.camel@ibm.com>
	 <ec19e0e22401f2e372dde0aa81061401ebb4bedc.camel@mpiricsoftware.com>
	 <c755dddccae01155eb2aa72d6935a4db939d2cd7.camel@ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-77253-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D969113F4F2
X-Rspamd-Action: no action

On Tue, 2026-02-03 at 23:12 +0000, Viacheslav Dubeyko wrote:
> On Tue, 2026-02-03 at 14:28 +0530, Shardul Bankar wrote:
> > On Mon, 2026-02-02 at 20:52 +0000, Viacheslav Dubeyko wrote:
> > > On Sat, 2026-01-31 at 19:34 +0530, Shardul Bankar wrote:
> > >=20
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0len =3D hfs_brec_lenoff(=
node,
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HFS=
PLUS_BTREE_HDR_MAP_REC,
> > > > &bitmap_off);
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (len !=3D 0 && bitmap=
_off >=3D sizeof(struct
> > > > hfs_bnode_desc)) {
> > >=20
> > > If we read incorrect len and/or bitmap_off, then it sounds like
> > > corruption too.
> > > We need to process this issue somehow but you ignore this,
> > > currently.
> > > ;)
>=20
> I am not suggesting to check everything. But because you are using
> these values
> and you can detect that these value is incorrect, then it makes sense
> to report
> the error if something is wrong.

Hi Slava,

Ah, I misunderstood you previously!

You are right. I will add an explicit error log and force SB_RDONLY for
this invalid offset/length case in v4 as well.

>=20
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0hfs_bnode_read(node, &bitmap_byte, bitmap_off,
> > > > 1);
> > >=20
> > > I assume that 1 is the size of byte, then sizeof(u8) or
> > > sizeof(bitmap_byte)
> > > could look much better than hardcoded value.
> >=20
> > Ack'ed. Changing to sizeof(bitmap_byte).
> >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (!(bitmap_byte & HFSPLUS_BTREE_NODE0_BIT)) {
> > >=20
> > > Why don't use the test_bit() [1] here? I believe that code will
> > > be
> > > more simple
> > > in such case.
> >=20
> >=20
>=20
> Correct me if I am wrong, but I suspect that I am right. :) The
> endianness is
> about bytes not bits. I am googled this: "Endianness defines the
> order in which
> bytes, constituting multibyte data (like 16, 32, or 64-bit integers),
> are stored
> in memory or transmitted over a network.". So, if you need manage
> endianness of
> of values, then you can use cpu_to_bexx()/bexx_to_cpu() family of
> methods. But
> it's not about bits. If you take byte only, then the representation
> of byte is
> the same in Big-Endian (BE) or Little-Endian (LE). Am I right here?
> :)

You are right that a single byte's representation is the same in memory
regardless of CPU endianness. To be completely transparent, the precise
interplay between cross-architecture kernel bitops, memory alignment,
and on-disk format endianness has always been a bit of a conceptual
blind spot for me.

My initial hesitation with `test_bit()` was also that it strictly
requires an `unsigned long *`. Reading a 1-byte on-disk requirement
directly into an `unsigned long` buffer felt sub-optimal and could risk
out-of-bounds stack reads if not handled carefully.

However, I want to follow your recommendation to standardize on kernel
bitops. To safely use `test_bit()`, I propose reading the byte safely
into a `u8`, and then promoting it to an `unsigned long` before
testing; something like this on top of the patch:

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 4bd0d18ac6c6..7ce1708e423c 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -135,6 +135,7 @@ struct hfs_btree *hfs_btree_open(struct super_block
*sb, u32 id)
        struct hfs_btree *tree;
        struct hfs_btree_header_rec *head;
        struct address_space *mapping;
+       unsigned long bitmap_word;
        struct hfs_bnode *node;
        u16 len, bitmap_off;
        struct inode *inode;
@@ -255,7 +256,8 @@ struct hfs_btree *hfs_btree_open(struct super_block
*sb, u32 id)
=20
        if (len !=3D 0 && bitmap_off >=3D sizeof(struct hfs_bnode_desc)) {
                hfs_bnode_read(node, &bitmap_byte, bitmap_off,
sizeof(bitmap_byte));
-               if (!(bitmap_byte & HFSPLUS_BTREE_NODE0_BIT)) {
+               bitmap_word =3D bitmap_byte;
+               if (!test_bit(HFSPLUS_BTREE_NODE0_BIT, &bitmap_word)) {
                        const char *tree_name;
=20
                        switch (id) {
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index f2f70975727c..52e9b8969406 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -512,7 +512,7 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT      3
 #define HFSPLUS_BTREE_HDR_MAP_REC_INDEX        2       /* Map (bitmap)
record in header node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES           128
-#define HFSPLUS_BTREE_NODE0_BIT                0x80
+#define HFSPLUS_BTREE_NODE0_BIT                7
=20
 /* btree key type */
 #define HFSPLUS_KEY_CASEFOLDING                0xCF    /* case-
insensitive */


> > > > =C2=A0#define HFSPLUS_BTREE_HDR_USER_BYTES=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0128
> > > > +#define HFSPLUS_BTREE_NODE0_BIT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x80
> > >=20
> > > Maybe, (1 << something) instead of 0x80? I am OK with constant
> > > too.
> >=20
> > Ack'ed, will use (1 << 7). Can also use BIT(7) if you prefer.
>=20
> OK. So, are you sure that node #0 corresponds to bit #7 but not bit
> #0? :) I am
> started to doubt that we are correct here.

According to Apple's Tech Note TN1150 [1], HFS+ maps Node 0 to the Most
Significant Bit (MSB).

Specifically, TN1150 states:

1. Under "Map Record": "The bits are interpreted in the same way as the
bits in the allocation file."
2. Under "Allocation File": "Within each byte, the most significant bit
holds information about the allocation block with the lowest number..."

Apple also provides a C code snippet in the document (Listing 1)
demonstrating this:
`return (thisByte & (1 << (7 - (thisAllocationBlock % 8)))) !=3D 0;`

If we evaluate this for Node 0 (`thisAllocationBlock =3D 0`), it resolves
to `1 << 7` (or bit 7). Therefore, checking bit 7 is mathematically
required to target Node 0.

If these changes look proper to you, I will add them to my code along
with the rest of your feedback and send out v4 shortly.

Thanks again for the guidance, continued review and for bearing with me
on this!

Regards,
Shardul

[1] Apple Tech Note TN1150:
https://developer.apple.com/library/archive/technotes/tn/tn1150.html#Alloca=
tionFile

