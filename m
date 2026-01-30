Return-Path: <linux-fsdevel+bounces-75939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOkVLlp9fGkONgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75939-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 10:43:54 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D33EB902A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 10:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A35793023072
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F59354AC0;
	Fri, 30 Jan 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="IFubggh4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033693396E9;
	Fri, 30 Jan 2026 09:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769766217; cv=pass; b=AniO7JNhNONv2k+6KAW03QiaOHkR78Hxku8/YG29tNSmsOkHZp466X0JKWkHbsu97dfbqsql/AklX2R7C9/Jv3j8QxYUVV6GRUZCEHHRQFpwi1zPff3+No/CnkDMkTqT3bSkM7Gb+dOxzQp6fvq8CYfrcQlgzoO3RpFRAFJoYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769766217; c=relaxed/simple;
	bh=AutT8B6BVAbDBsS4imVHJViKbsMUaesCXMnUIK0SpCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jSaIOWVJb8FgQ15H0Y+Vi5xe+7cCtWpVJkZDa9PVWBSrfdJHeIgZpKqsry6aC1d1S6A2g675VNWIbJu0MgArnhaMRLazOZHHjp12M1RzwLOcy0HVmi/JXOq7hakz/Og22VfP3jSKcvh2y6QqCUsT3qN8lxgM/Zw180dkILJxXHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=IFubggh4; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1769766200; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XZ5xUi4zbWNNBTzasx73mV4BcLc0Kdc7KkQUuzGwXFR/uEGDQRwpASmN+By5tOuDnefI9G31jnhd3WZtdd4shzESCumNMMezV1YbSH7qiIO8Pi/gwppLlOBD14cBTfS8rKoY5AbuZXNkOlpDBoqRF4yo+K68u0tVvScAH5MOeUI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769766200; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cz/upfUt0s8y16V0DsbVm3DyM22Z46r9BDfj4mCsdn8=; 
	b=J2OgIoN49HGnp986o6sWeJYiSuIP2uw5EOUNj3M6c5ejTqm8Xb+xRisSmbrCx18iMMyThTYjIZxayMq5HlHTyu2QJ5idiIe99ESUsaRaK2Ld3012wy/tH6DAOD04HNPc+EMyZnJpZpvW0onmy9qqNClzAi5PDo+iiNvMArTxol8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769766200;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=cz/upfUt0s8y16V0DsbVm3DyM22Z46r9BDfj4mCsdn8=;
	b=IFubggh4zJETQE1ZS/Lo7W3GjgIPOJQY7j013FJmmUsPvIVR84ztfA6dfJZliswA
	QYR+C5kDa2lpmc+TuvwjxB2ihN0fdGYMGoO5zWk4fGmPgjaqrM/emBmrGATBR34CGA5
	ymRJOw7Hu09bwmsg0Bx+bY/tRGSj0gGk2KWZcG0s=
Received: by mx.zohomail.com with SMTPS id 17697661970661002.4448851327712;
	Fri, 30 Jan 2026 01:43:17 -0800 (PST)
Message-ID: <2283988f9edee66e648e257c303d5e4d77925402.camel@mpiricsoftware.com>
Subject: Re:  [PATCH v2] hfsplus: validate btree bitmap during mount and
 handle corruption gracefully
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	"glaubitz@physik.fu-berlin.de"
	 <glaubitz@physik.fu-berlin.de>, "frank.li@vivo.com" <frank.li@vivo.com>, 
	"slava@dubeyko.com"
	 <slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Cc: "syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com"
	 <syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com>, 
	"janak@mpiricsoftware.com"
	 <janak@mpiricsoftware.com>, shardulsb08@gmail.com
Date: Fri, 30 Jan 2026 15:13:04 +0530
In-Reply-To: <11c93c90c986ab0bc52d19c0e81463cbba004657.camel@ibm.com>
References: <20260125030733.1384703-1-shardul.b@mpiricsoftware.com>
	 <11c93c90c986ab0bc52d19c0e81463cbba004657.camel@ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[mpiricsoftware.com:s=mpiric];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-75939-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,mpiricsoftware.com,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mpiricsoftware.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,1c8ff72d0cd8a50dfeaa];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7D33EB902A
X-Rspamd-Action: no action

On Mon, 2026-01-26 at 22:42 +0000, Viacheslav Dubeyko wrote:
> On Sun, 2026-01-25 at 08:37 +0530, Shardul Bankar wrote:
> >=20
> > @@ -176,6 +238,13 @@ struct hfs_btree *hfs_btree_open(struct
> > super_block *sb, u32 id)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tree->max_key_len =3D b=
e16_to_cpu(head->max_key_len);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0tree->depth =3D be16_to=
_cpu(head->depth);
> > =C2=A0
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Validate bitmap: node 0 m=
ust be marked allocated */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (hfsplus_validate_btree_b=
itmap(tree, head)) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0sbi->btree_bitmap_corrupted =3D true;
>=20
> Please, see my comment about this field.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > +
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Verify the tree and =
set the correct compare function */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0switch (id) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case HFSPLUS_EXT_CNID:
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index 45fe3a12ecba..b925878333d4 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -154,6 +154,7 @@ struct hfsplus_sb_info {
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int part, session;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0unsigned long flags;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool btree_bitmap_corrupted;=
=C2=A0=C2=A0=C2=A0=C2=A0/* Bitmap corruption
> > detected during btree open */
>=20
> This field is completely unnecessary. The hfs_btree_open() can return
> -EROFS
> error code and hfsplus_fill_super() can process it.
> =C2=A0=20
Hi Slava,

Thanks for the review.

Regarding the suggestion to convert hfs_btree_open() to return
ERR_PTR(-EROFS):

I reviewed this, but I cannot use ERR_PTR for the corruption case
because it would defeat a purpose of the patch (data recovery).

If hfs_btree_open() returns -EROFS, the caller hfsplus_fill_super()
would receive the error code but would have no tree object to work
with. Without the B-tree structure, we cannot mount the filesystem-even
read-only-making data recovery impossible.

To support recovery, hfs_btree_open() must return a valid tree pointer
even when corruption is detected.

Therefore, for v3, I plan to:

    -Keep the return type as-is to avoid scope creep and ensure easy
backporting.

    -Use sb->s_flags |=3D SB_RDONLY inside hfs_btree_open() to flag the
safety issue.

    -Drop the bool flag I added in v2 (as you requested) and simply
check sb_rdonly(sb) in fill_super to print the warning.

I will, of course, address your other comments regarding named
constants and pointer arithmetic in v3.

Does this sound acceptable?

Thanks,
Shardul

