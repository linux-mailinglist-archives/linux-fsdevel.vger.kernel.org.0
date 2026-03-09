Return-Path: <linux-fsdevel+bounces-79871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ME1ZFQ4mr2kTOwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79871-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:57:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0761C24072E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 20:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F1DC300E2A7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF33641324D;
	Mon,  9 Mar 2026 19:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="SWOrk88Q"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o55.zoho.com (sender4-of-o55.zoho.com [136.143.188.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDCA411615;
	Mon,  9 Mar 2026 19:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773086210; cv=pass; b=PVMD8wsJaZuMWaeRjwFgykF8W8axBcXjo6iGwwpFK9xs+VIZ/uMhngsQ/ea1wXKcY2xyuzyK7eXauiD7Q9F30UYCJcxR19/hTn60y2EO+q1MvugkfFbZSgHn+D6V62c9Eho3tMgdR4IoATjGEw5cJunQo81zmEgSLoPvjaJoy70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773086210; c=relaxed/simple;
	bh=TQrUpgLT8ThagOwxPSzJNHUp+NgmKxfzJfLXRZK7zvc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SUVuMSdI4lkQ3yLgXNv23w9PHOnIMayhuAk1Uj0EEqZnH04IFLSC1zSiVCUC/OIc3FZ/ItsLFxZsfr27o/QSxijQcCVYQ2ovwb5KxOkcVd73/DXFoOky5v9rx6VSqOYFZk28qMfmRLZIndUf9Zg1yO6NpNjHY4oErtI00i8N1xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=SWOrk88Q; arc=pass smtp.client-ip=136.143.188.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1773086180; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dIudtl5BnEC9b5Myfn88TDNLZce17ur62gFRtoOdoA3xpk5yA7I9jP9qS6X9pLmV18wberEI+8PxMcCKJbMc+vgLW2ypN2HvWGkKJHuMEv41Xl/iOjBHd/z2W/frjPT0RHEIoVKcdgE50vn/iJH1rB1mBFJmHNPTV7Nai2L39cE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773086180; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TQrUpgLT8ThagOwxPSzJNHUp+NgmKxfzJfLXRZK7zvc=; 
	b=DJaIvEWTGNfWk3TmcC2YyZI7XVlAi/a2DZH+F4zecS+TsuNg0OR+AyAz9TdHFTi51bxkjTXH6qIF3YNG7JQ/acuBqwkhJf5MeLuRIPCPUtmkRu22+P0QEDbzOmv/pEHIRdVTSLA3sk1cusNwEWe5RCG2cQ4hIvA2oHOtw8226RM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773086180;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=TQrUpgLT8ThagOwxPSzJNHUp+NgmKxfzJfLXRZK7zvc=;
	b=SWOrk88QNBOABPRKpSGS3yJAqjJqlzQpFdyiGL6L+c1Npg4zH4t6eTHygUUZPYkW
	3DJROMdEkrMbHqmxC0cQxYSheUeop4+daJR8kVX5RCMBhpxzNqYACAhhYZA7jSoD8E8
	ibNw7CmmJUL8/kDDDKurSFck5Cjd5k4AXCQLqEoQ=
Received: by mx.zohomail.com with SMTPS id 1773086177381294.23264475659005;
	Mon, 9 Mar 2026 12:56:17 -0700 (PDT)
Message-ID: <2f9006ca3b8b9ac8312a0a71214eb02165838202.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v5 2/2] hfsplus: validate b-tree node 0 bitmap at mount
 time
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "janak@mpiric.us" <janak@mpiric.us>, "janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, 
	"syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	shardulsb08@gmail.com
Date: Tue, 10 Mar 2026 01:26:04 +0530
In-Reply-To: <777135e49c8f44f1f9a023d88be9a55b7acf2426.camel@ibm.com>
References: <20260228122305.1406308-1-shardul.b@mpiricsoftware.com>
	 <20260228122305.1406308-3-shardul.b@mpiricsoftware.com>
	 <4442aca3ca4745748a7f181189bd16b2b345428e.camel@ibm.com>
	 <66104cc5521c69a4745b894be307eec25333eb09.camel@mpiricsoftware.com>
	 <777135e49c8f44f1f9a023d88be9a55b7acf2426.camel@ibm.com>
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
X-Rspamd-Queue-Id: 0761C24072E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-79871-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_CC(0.00)[mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[mpiricsoftware.com:?];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : SPF/DKIM temp error,quarantine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.075];
	R_DKIM_TEMPFAIL(0.00)[mpiricsoftware.com:s=mpiric];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mpiricsoftware.com:mid]
X-Rspamd-Action: no action

On Mon, 2026-03-09 at 19:39 +0000, Viacheslav Dubeyko wrote:
> On Mon, 2026-03-09 at 17:16 +0530, Shardul Bankar wrote:
> > On Mon, 2026-03-02 at 23:45 +0000, Viacheslav Dubeyko wrote:
> > > On Sat, 2026-02-28 at 17:53 +0530, Shardul Bankar wrote:
> > > > diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> > > > index 87650e23cd65..ee1edb03a38e 100644
> > > > --- a/fs/hfsplus/btree.c
> > > > +++ b/fs/hfsplus/btree.c
> > > > @@ -239,15 +239,31 @@ static int hfs_bmap_clear_bit(struct
> > > > hfs_bnode *node, u32 bit_idx)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +static const char *hfs_btree_name(u32 cnid)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0static const char * cons=
t tree_names[] =3D {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0[HFSPLUS_EXT_CNID] =3D "Extents",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0[HFSPLUS_CAT_CNID] =3D "Catalog",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0[HFSPLUS_ATTR_CNID] =3D "Attributes",
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0};
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (cnid < ARRAY_SIZE(tr=
ee_names) && tree_names[cnid])
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return tree_names[cnid];
> > > > +
> > >=20
> > > #define HFS_POR_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A01=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Paren=
t Of the Root */
> > > #define HFSPLUS_POR_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0HFS_POR_CNID
> > > #define HFS_ROOT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A02=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* ROOT direct=
ory */
> > > #define HFSPLUS_ROOT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HF=
S_ROOT_CNID
> > > #define HFS_EXT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A03=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* EXTen=
ts B-tree */
> > > #define HFSPLUS_EXT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0HFS_EXT_CNID
> > > #define HFS_CAT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A04=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* CATal=
og B-tree */
> > > #define HFSPLUS_CAT_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0HFS_CAT_CNID
> > > #define HFS_BAD_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A05=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* BAD b=
locks file */
> > > #define HFSPLUS_BAD_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0HFS_BAD_CNID
> > > #define HFS_ALLOC_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A06=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* ALLOCation fil=
e (HFS+)
> > > */
> > > #define HFSPLUS_ALLOC_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HFS_ALL=
OC_CNID
> > > #define HFS_START_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A07=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* STARTup file (=
HFS+) */
> > > #define HFSPLUS_START_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HFS_STA=
RT_CNID
> > > #define HFS_ATTR_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A08=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* ATTRibutes =
file (HFS+)
> > > */
> > > #define HFSPLUS_ATTR_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HF=
S_ATTR_CNID
> > > #define HFS_EXCH_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A015=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* ExchangeFiles te=
mp id
> > > */
> > > #define HFSPLUS_EXCH_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0HF=
S_EXCH_CNID
> > > #define HFS_FIRSTUSER_CNID=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A016=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* first available user
> > > id */
> > > #define HFSPLUS_FIRSTUSER_CNID=C2=A0=C2=A0HFS_FIRSTUSER_CNID
> > >=20
> > > What if cnid will be 1, 2, 5? How correctly will logic works? For
> > > may
> > > taste, the
> > > declaration looks slightly dangerous.
> > >=20
> > > It will much easier simply introduce the string constants:
> > >=20
> > > #define HFS_EXTENT_TREE_NAME=C2=A0 "Extents"
> > > ...
> > > #define HFS_UNKNOWN_BTREE_NAME=C2=A0 "Unknown"
> > >=20
> > > Probably, simple switch will be simpler implementation here:
> > >=20
> > > switch (cnid) {
> > > case HFSPLUS_EXT_CNID:
> > > =C2=A0=C2=A0=C2=A0 return HFS_EXTENT_TREE_NAME;
> > > ...
> > > default:
> > > =C2=A0=C2=A0=C2=A0 return HFS_UNKNOWN_BTREE_NAME;
> > > }
> > >=20
> > > Or it needs to introduce array that will initialize all items
> > > from 0
> > > - 15.
> > >=20
> > > Maybe, I am too picky here. This logic should work. But I prefer
> > > to
> > > have string
> > > declarations outside of function.
> > >=20
> >=20
> > I originally used the array based on your feedback from the v4
> > review,
> > where you mentioned preferring an array of constant strings over a
> > switch statement.
> >=20
> > To address your concern about unlisted indices like 1, 2, and 5: I
> > tested this case locally to be absolutely sure. Because of how the
> > compiler initializes arrays, any index not explicitly defined is
> > set to
> > NULL (0). For example, I temporarily removed HFSPLUS_CAT_CNID from
> > the
> > array and triggered the bug. The if (tree_names[cnid]) condition
> > successfully caught the NULL and the kernel safely logged:
> > hfsplus: (loop0): Unknown Btree (cnid 0x4) bitmap corruption
> > detected...
> >=20
> > That being said, I agree that defining the strings as macros
> > outside
> > the function combined with a standard switch statement makes the
> > definitions much more visible to the rest of the subsystem. I am
> > more
> > than happy to rewrite it using the #define and switch approach
> > exactly
> > as you suggested for v6. Let me know which approach you prefer.
> >=20
> >=20
>=20
> I think we need to declare the strings outside of the method. I
> recommended the
> strings array because it's nice to have. But I missed the point that
> we don't
> have the contiguous sequence of indexes. Because, we have only three
> strings to
> distinguish, then solution based on switch looks like more clean and
> simple one.
> Do you agree? :)
>=20

Agreed.

I will get v6 prepared with all of these discussed changes.

Thank you for all the feedback!

Regards,
Shardul

