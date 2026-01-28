Return-Path: <linux-fsdevel+bounces-75725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDKVJmUeemlS2QEAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75725-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:34:13 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAD4A2D2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 15:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5757300B9B5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jan 2026 14:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003AA359716;
	Wed, 28 Jan 2026 14:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="ObAwkIE6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MhyHtP2u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from a11-123.smtp-out.amazonses.com (a11-123.smtp-out.amazonses.com [54.240.11.123])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1720E35295A;
	Wed, 28 Jan 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.11.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769610839; cv=none; b=ghUUGK9knNNzkeKEtSuDr6j67v3OHC4KrTG25OA66UmHlj8KxC7a9IlPHxpZmXqOcav0WDI9EV+MBkMWTazLGd6FGMU5wnP7lcYMxeGw34XECaYiYCEW1n6sEZU0wpF32q+R1oZVgptZkKIhfToBwbmTwETBG4KkIITyodBzumM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769610839; c=relaxed/simple;
	bh=xRGPaAr54jDjRFgrc+J/GGo+pj1c4nxJ5YePrHIqqEU=;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:In-Reply-To:
	 References:Message-ID; b=ESp+D6hqLU7UzP7NBH/Zm0R3NITBQPmn5o6Xz65Pff4PVNNXWpWDJv7pQqlva2Xrafb555o0OYuIuHWVl1rCwnXPXh37Qqqm+df6ICfDBXOHZBZ97+sj2S7dmCD+hKTrwp0hwIb1iM20sGVgwuR84WpslQjSprH1KsjqEd6QVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com; spf=pass smtp.mailfrom=amazonses.com; dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b=ObAwkIE6; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=MhyHtP2u; arc=none smtp.client-ip=54.240.11.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jagalactic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq; d=jagalactic.com; t=1769610837;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id;
	bh=xRGPaAr54jDjRFgrc+J/GGo+pj1c4nxJ5YePrHIqqEU=;
	b=ObAwkIE6Mww77yndX3Isk+jVf8Zw8d/lNL3XlFbM/kX1daDCD5R+X3fVL1akxhvv
	ylSC3qzp0dSFiWc/wknzZvTPO2iqm4+niOQ859gbL0+tnQ3NuL/sgW19kRV4ImjbtkZ
	fEADtQqvzYUfXc/gDBswLlQEoJKpBEdWdSu1hrqk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1769610837;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Reply-To:Message-Id:Feedback-ID;
	bh=xRGPaAr54jDjRFgrc+J/GGo+pj1c4nxJ5YePrHIqqEU=;
	b=MhyHtP2uPPf4OS+NYQeFWUKO2Fi1KGom+CLgkGjJ9MupyMMQR+NML8iLo64wwPGH
	zx7P5Xote5NNWpGcnTvnDzV9UheSfePgFa6HJlEMcWa7ihgovfbzXU7DKxZM7+zlrPM
	55PniaSsRX5CRwdpj/1l8Fkicv9mt6b6UWIgQDTU=
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Joanne_Koong?= <joannelkoong@gmail.com>
Cc: =?UTF-8?Q?John_Groves?= <John@groves.net>, 
	=?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>, 
	=?UTF-8?Q?Dan_Williams?= <dan.j.williams@intel.com>, 
	=?UTF-8?Q?Bernd_Schubert?= <bschubert@ddn.com>, 
	=?UTF-8?Q?Alison_Schofiel?= =?UTF-8?Q?d?= <alison.schofield@intel.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@micron.com>, 
	=?UTF-8?Q?John_Groves?= <jgroves@fastmail.com>, 
	=?UTF-8?Q?Jonathan_Corbet?= <corbet@lwn.net>, 
	=?UTF-8?Q?Vishal_Verma?= <vishal.l.verma@intel.com>, 
	=?UTF-8?Q?Dave_Jiang?= <dave.jiang@intel.com>, 
	=?UTF-8?Q?Matthew_Wilcox?= <willy@infradead.org>, 
	=?UTF-8?Q?Jan_Kara?= <jack@suse.cz>, 
	=?UTF-8?Q?Alexander_Viro?= <viro@zeniv.linux.org.uk>, 
	=?UTF-8?Q?David_Hildenbrand?= <david@kernel.org>, 
	=?UTF-8?Q?Christian_Bra?= =?UTF-8?Q?uner?= <brauner@kernel.org>, 
	=?UTF-8?Q?Darrick_J_=2E_Wong?= <djwong@kernel.org>, 
	=?UTF-8?Q?Randy_Dunlap?= <rdunlap@infradead.org>, 
	=?UTF-8?Q?Jeff_Layton?= <jlayton@kernel.org>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?Jonathan_Cameron?= <Jonathan.Cameron@huawei.com>, 
	=?UTF-8?Q?Stefan_Hajnoczi?= <shajnocz@redhat.com>, 
	=?UTF-8?Q?Josef_Bacik?= <josef@toxicpanda.com>, 
	=?UTF-8?Q?Bagas_Sanjaya?= <bagasdotme@gmail.com>, 
	=?UTF-8?Q?James_Morse?= <james.morse@arm.com>, 
	=?UTF-8?Q?Fuad_Tabba?= <tabba@google.com>, 
	=?UTF-8?Q?Sean_Christopherson?= <seanjc@google.com>, 
	=?UTF-8?Q?Shivank_Garg?= <shivankg@amd.com>, 
	=?UTF-8?Q?Ackerley_Tng?= <ackerleytng@google.com>, 
	=?UTF-8?Q?Gregory_Price?= <gourry@gourry.net>, 
	=?UTF-8?Q?Aravind_Ramesh?= <arramesh@micron.com>, 
	=?UTF-8?Q?Ajay_Joshi?= <ajayjoshi@micron.com>, 
	=?UTF-8?Q?venkataravis=40micron=2Ecom?= <venkataravis@micron.com>, 
	=?UTF-8?Q?linux-doc=40vger=2Ekernel=2Eorg?= <linux-doc@vger.kernel.org>, 
	=?UTF-8?Q?linux-kernel=40vger=2Ekernel=2E?= =?UTF-8?Q?org?= <linux-kernel@vger.kernel.org>, 
	=?UTF-8?Q?nvdimm=40lists=2E?= =?UTF-8?Q?linux=2Edev?= <nvdimm@lists.linux.dev>, 
	=?UTF-8?Q?linux-cxl=40v?= =?UTF-8?Q?ger=2Ekernel=2Eorg?= <linux-cxl@vger.kernel.org>, 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>
Date: Wed, 28 Jan 2026 14:33:56 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
References: <20260116125831.953.compound@groves.net> 
 <20260116185911.1005-10-john@jagalactic.com> 
 <20260116185911.1005-1-john@jagalactic.com> 
 <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com> 
 <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com> 
 <aXoarMgfbL6rh6xi@groves.net>
X-Mailer: Amazon WorkMail
Thread-Index: AQHchxoe1VAe00deR0Sw2d725QhurgAABexrAAAzqQgCL2dWIgJSQNF2
Thread-Topic: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
Reply-To: john@groves.net
X-Wm-Sent-Timestamp: 1769610835
Message-ID: <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
Feedback-ID: ::1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2026.01.28-54.240.11.123
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.75 / 15.00];
	TO_EXCESS_QP(1.20)[];
	CC_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jagalactic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[jagalactic.com:s=o25mqk5iffcfzgc3wo2zjhkohcyjzsoq,amazonses.com:s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-75725-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[38];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[jagalactic.com:+,amazonses.com:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[john@jagalactic.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[groves.net,szeredi.hu,intel.com,ddn.com,micron.com,fastmail.com,lwn.net,infradead.org,suse.cz,zeniv.linux.org.uk,kernel.org,gmail.com,huawei.com,redhat.com,toxicpanda.com,arm.com,google.com,amd.com,gourry.net,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FROM_EXCESS_QP(0.00)[];
	HAS_REPLYTO(0.00)[john@groves.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[jagalactic.com:email,jagalactic.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,groves.net:replyto,groves.net:email,amazonses.com:dkim,email.amazonses.com:mid]
X-Rspamd-Queue-Id: 4EAD4A2D2E
X-Rspamd-Action: no action

On 26/01/27 01:55PM, Joanne Koong wrote:=0D=0A> On Fri, Jan 16, 2026 at 1=
1:52=E2=80=AFAM John Groves <john@jagalactic.com> wrote:=0D=0A> >=0D=0A> =
> From: John Groves <john@groves.net>=0D=0A> >=0D=0A> > Famfs distinguish=
es between its on-media and in-memory superblocks. This=0D=0A> > reserves=
 the numbers, but they are only used by the user space=0D=0A> > component=
s of famfs.=0D=0A> >=0D=0A> > Signed-off-by: John Groves <john@groves.net=
>=0D=0A> > ---=0D=0A> >  include/uapi/linux/magic.h | 2 ++=0D=0A> >  1 fi=
le changed, 2 insertions(+)=0D=0A> >=0D=0A> > diff --git a/include/uapi/l=
inux/magic.h b/include/uapi/linux/magic.h=0D=0A> > index 638ca21b7a90..71=
2b097bf2a5 100644=0D=0A> > --- a/include/uapi/linux/magic.h=0D=0A> > +++ =
b/include/uapi/linux/magic.h=0D=0A> > @@ -38,6 +38,8 @@=0D=0A> >  #define=
 OVERLAYFS_SUPER_MAGIC  0x794c7630=0D=0A> >  #define FUSE_SUPER_MAGIC    =
   0x65735546=0D=0A> >  #define BCACHEFS_SUPER_MAGIC   0xca451a4e=0D=0A> =
> +#define FAMFS_SUPER_MAGIC      0x87b282ff=0D=0A> > +#define FAMFS_STAT=
FS_MAGIC      0x87b282fd=0D=0A>=20=0D=0A> Could you explain why this need=
s to be added to uapi=3F If they are used=0D=0A> only by userspace, does =
it make more sense for these constants to live=0D=0A> in the userspace co=
de instead=3F=0D=0A>=20=0D=0A> Thanks,=0D=0A> Joanne=0D=0A=0D=0AHi Joanne=
,=0D=0A=0D=0AI think this is where it belongs; one function of uapi/linux=
/magic.h is as=0D=0Aa "registry" of magic numbers, which do need to be un=
ique because they're=0D=0Athe first step of recognizing what is on a devi=
ce.=0D=0A=0D=0AThis is a well-established ecosystem with block devices. B=
lkid / libblkid=0D=0Ascan block devices and keep a database of what devic=
es exist and what=0D=0Aappears to be on them. When one adds a magic numbe=
r that applies to block=0D=0Adevices, one sends a patch to util-linux (wh=
ere blkid lives) to add ability=0D=0Ato recognize your media format (whic=
h IIRC includes the second recognition=0D=0Astep - if the magic # matches=
, verify the superblock checksum).=0D=0A=0D=0AFor character dax devices t=
he ecosystem isn't really there yet, but the=20=0D=0Apattern is the same =
- and still makes sense.=0D=0A=0D=0AAlso, 2 years ago in the very first p=
ublic famfs patch set (pre-fuse),=0D=0AChristian Brauner told me they bel=
ong here [1].=0D=0A=0D=0ABut if the consensus happens to have moved since=
 then, NP...=0D=0A=0D=0ARegards,=0D=0AJohn=0D=0A=0D=0A[1] https://lore.ke=
rnel.org/linux-fsdevel/20240227-kiesgrube-couch-77ee2f6917c7@brauner/=0D=0A=
=0D=0A

