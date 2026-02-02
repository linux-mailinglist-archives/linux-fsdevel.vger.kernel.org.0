Return-Path: <linux-fsdevel+bounces-76088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DlAEgMBgWlyDgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:54:43 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D30CAD0D81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 20:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3AD5530071C9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 19:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE8630648A;
	Mon,  2 Feb 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b="afE8850W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF01305E32
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Feb 2026 19:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770062078; cv=none; b=Cjd+c4tDoFVHtet26/IsZYNPQZJufpTxlXbCO1HNuAsOFL+q6Rge62PeB87/OUoVs69KEL3FZGgC6TpJV3/Q0fKIJ3pgS295ZtFl27aCQs8WK7LBVQmrGOA6iL6JrJ9aEUhv2bG6NWU5+LNUH1kdJU7u1RlzzQTyXS4hZkW46gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770062078; c=relaxed/simple;
	bh=Z52zhiTDtDi1FKy+m0xZ+u+Ml0395yRGO6Svo4hV6CI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfsurE4Xnjqve83KO0jVgFiS5+ewELTqDCDdDFN/S7hSg0/lZohvn4Lv+f5EvTzywQnN2nmFnHLtuilxVqLNlXJ6sTtGyMmx6gn3NQbfx7K+Vhr/RkhHfXMhYNEKixeFgXtuzeyG9TUM43OcKtKdUNxGcFMGfXfVpHkG1WYYbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=pass (2048-bit key) header.d=spawn.link header.i=@spawn.link header.b=afE8850W; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1770062059; x=1770321259;
	bh=Z52zhiTDtDi1FKy+m0xZ+u+Ml0395yRGO6Svo4hV6CI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=afE8850WWA8r+MHHeWj/1VwUgaHDjwOd14o0i/t4XKR/26nuUTqyDJrZ5rVViaiP5
	 ftiQTZb2Pk0OBYP3776bQWcFlWTQhG3hkaI6IOR6HK3lTBCETZYs9GLpFMOKLKlXkN
	 zFxjQIjs/S3lm6cCUl75fJWIHNvvR+yM3FvaYboikrww0bE7F9x+KHO4M4WULKO8Ls
	 iiXR0t9J+KC+Qv1Eydm0yAX8wzUdMweeq/Fn2tlj9alAVD1yfkUZ5PxDu2hjmTG7wt
	 KHljdCGNY6IfpMlRyR5wPXspplDiuZNCKAcXNhgDXL3myw6hq6P3KuwHWUscCiqPJt
	 ORJQYIJyIuc+w==
Date: Mon, 02 Feb 2026 19:54:16 +0000
To: Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trondmy@kernel.org>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: =?utf-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>, linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd.schubert@fastmail.fm>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
Message-ID: <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link>
In-Reply-To: <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org>
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link> <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org> <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link> <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org> <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com> <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: 35045d81b388499f3315b52992f74e6dd6221fc2
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[spawn.link,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[spawn.link:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76088-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[jotschi.de,vger.kernel.org,fastmail.fm,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trapexit@spawn.link,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[spawn.link:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,jotschi.de:url,spawn.link:mid,spawn.link:dkim]
X-Rspamd-Queue-Id: D30CAD0D81
X-Rspamd-Action: no action

On Thursday, January 15th, 2026 at 1:20 PM, Trond Myklebust <trondmy@kernel=
.org> wrote:

>
>
> On Thu, 2026-01-15 at 17:18 +0100, Johannes Sch=C3=BCth wrote:
>
> > Here are the two requested dumps:
> > https://www.jotschi.de/files/fuse_nfs_mount_6_18_5.pcap
> > https://www.jotschi.de/files/fuse_nfs_setfattr_6_18_5.pcap
> >
> > I see XAW (xattr write?) being denied on nfs mount:
> > Opcode: ACCESS (3), [Access Denied: MD XT DL XAW], [Allowed: RD LU
> > XAR XAL]
> >
> > Testing system/security xattr was just a test. My userland code only
> > uses user.* xattr.
>
>
> If you look at frame #103, when the client is querying the properties
> of the filesystem mounted under "merged": it asks for the value of the
> attribute "Xattr_support", and the server responds with a value "0"
> (i.e. "No").
>
> So as far as I can see, the client behaviour you are observing is the
> correct one, given the response from the server.
>
> Now as to the question about why the server is reporting "No", it looks
> as if it bases that information on the reply from the VFS call to
> xattr_supports_user_prefix() on the root inode for that filesystem. I
> guess in this case, FUSE is disallowing setting a "user" xattr on that
> inode.
>
> So this is not a regression from the point of view of the NFS client,
> but rather that commit a8ffee4abd8e ("NFS: Fix the setting of
> capabilities when automounting a new filesystem") fixed the bug that
> was masking the actual server response for this FUSE filesystem.

So where do we go from here? Bring in NFS server folks? Miklos?

