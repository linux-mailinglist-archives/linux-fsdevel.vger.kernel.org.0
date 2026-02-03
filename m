Return-Path: <linux-fsdevel+bounces-76228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANE/CKN2gmm+UwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76228-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:28:51 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A03DF3E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Feb 2026 23:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E64330A1A2C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Feb 2026 22:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5908537104B;
	Tue,  3 Feb 2026 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=spawn.link header.i=@spawn.link header.b="suGtKba0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-244119.protonmail.ch (mail-244119.protonmail.ch [109.224.244.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0125FA29
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Feb 2026 22:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770157721; cv=none; b=faTrcqIMKpuFAIJRo81mCLx573I8r+SrMxfminnnzFz1Zuk1La1G9HlDrl/JM/nxJrfOZzLTZLDJh2haRjwPsGHz6Vk3srcqZM0/eJyKWPSFXJHxxw5q+j/fT+DR+RhVIcybhZ9sYwXUUNtN4mkzWI+To2BIiGboOPRnrkpEN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770157721; c=relaxed/simple;
	bh=Jh9ztnWsKu+U7v06QhOFem5PeYDKspiN2lF63UzjKy8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub28yr5/P65UOcnohKoh21iACt1GvDQRZgOpPikcz6w01ThNYMwDGEqEps/tTZq4Hle7erwiZuwi18xnLNt/PFXOLYL/i5TGIaI/t3oScOZ0Viwxkzf23IoVUWtCka0MAcAohDxGDP/a/hhuL2UbhUaknaKU8vdpZsa/JOBKb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link; spf=pass smtp.mailfrom=spawn.link; dkim=fail (0-bit key) header.d=spawn.link header.i=@spawn.link header.b=suGtKba0 reason="key not found in DNS"; arc=none smtp.client-ip=109.224.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=spawn.link
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spawn.link
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawn.link;
	s=protonmail; t=1770157711; x=1770416911;
	bh=Jh9ztnWsKu+U7v06QhOFem5PeYDKspiN2lF63UzjKy8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=suGtKba095nGxkw6wKB45jpKN5iD+SjmB5ZrvjkOleP7Ox+J3b59yAAQ5J1+lCSFe
	 mNvYJShEv8k1nkIGTDFuJvVCPfF76wUV3exgAIe5LD0SopBraL8hbj18ClB4MBRb7o
	 xRyte3PmRy51G7bw3lLEQ1tLNl6mrPfmEoVWQxb4iLPs7djHf1384T2z43+WNcSiUH
	 GwaMiKIlzBz+An51Y3PEU7ReQxulVd+I/3J87Wm0agKqeQtd4KKfs3F0JpdQdS/fDD
	 kU1sSVlLEOz86Ph5b+cl+kG/k34y8TIyO83leSwW3haph9SYkmhcJ6PBgNQXLnAR1p
	 x+VG7GdT+qI3w==
Date: Tue, 03 Feb 2026 22:28:26 +0000
To: Bernd Schubert <bernd.schubert@fastmail.fm>
From: Antonio SJ Musumeci <trapexit@spawn.link>
Cc: =?utf-8?Q?Johannes_Sch=C3=BCth?= <j.schueth@jotschi.de>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trondmy@kernel.org>, linux-fsdevel@vger.kernel.org, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: NFSv4 + FUSE xattr user namespace regression/change?
Message-ID: <9m_144uWvz0R0iJytTOxiKiWXDhrHE8Ao8HgXdatpTnGCDYQbMSAUbkm8vOev66D6GDq4uzTppIRnDEC7FJybXMq_12IjosFxo2RUWgvSPU=@spawn.link>
In-Reply-To: <3cc4d93f-a0ad-4069-a6fd-348b11125afc@fastmail.fm>
References: <32Xtx4IaYj8nhPIXtt0gPimTRQy4RNjzmsqI1vQB1YBpRes0TEgu6zVzWbBEcn2U6ZxB14BD9vakmezNyhdXDt3CVGO8WYGxHSZZ1qtQVy8=@spawn.link> <8f5bb04853073dc620b5a6ebc116942a9b0a2b5c.camel@kernel.org> <e5-exnk0NS5Bsw0Ir_wplkePzOzCUPSsez9oqF7OVAAq3DASvNJ62B9EuQbvIqHitDgxtVnu74QYDYVEQ8rCCU74p4YupWxaKZNN34EPKUY=@spawn.link> <9ceb6cbcef39f8e82ab979b3d617b521aa0fcf83.camel@kernel.org> <CA+zj3DKAraQASpyVfkcDyGXu_oaR9SnYY18pDkN+jDgi54kRMQ@mail.gmail.com> <998f6d6819c2e0c3745599d61d8452c3bc478765.camel@kernel.org> <3DMb18lL2VzwORom5oMGlQizKpO_Na6Rhmv5GDA9GpN3ELrsA5plqhzezDxDs_UcXaqFQ9qUHb9y4cY4JRy7TjQ108_dVkZH9D2Yj48ABH0=@spawn.link> <CAJfpegu5tAFr3+sEQGi6YWGHMEVpVByFoVxzCONERGvJJdk5vg@mail.gmail.com> <CA+zj3DLwu20Q-1qUU-o8fSvnz9V_us35uQ5nqi7AEPNwZ=DAbA@mail.gmail.com> <3cc4d93f-a0ad-4069-a6fd-348b11125afc@fastmail.fm>
Feedback-ID: 55718373:user:proton
X-Pm-Message-ID: dde732c279e8c98eb5bf940d33c382fa1f0a8e2f
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[spawn.link:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fastmail.fm];
	TAGGED_FROM(0.00)[bounces-76228-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[trapexit@spawn.link,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[spawn.link:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 64A03DF3E5
X-Rspamd-Action: no action

On Tuesday, February 3rd, 2026 at 4:14 PM, Bernd Schubert <bernd.schubert@f=
astmail.fm> wrote:

>=20
>=20
> [Would be ideal to keep kernel style and to post below quotes]
>=20
> On 2/3/26 19:29, Johannes Sch=C3=BCth wrote:
>=20
> > Thank you for the patch. I applied it to 6.18.8 and 6.15.11.
> > Unfortunately the xattr operations still fail in the same way.
> > Note that 6.15.10 was still working for me.
> > I included the wireshark dumps [0] [1] from the mount process. The
> > access rights show up as:
> > Access Denied: MD XT DL XAW, [Allowed RD LU XAR XAL] in 6.18.8
>=20
>=20
>=20
> @Antonio, is there a way to get libfuse debug option output from
> mergerfs? I.e. to log fuse requests?
>=20
> I guess that should be simple to reproduce with libfuse (too late for to
> try it now).
>=20
>=20
> Thanks,
> Bernd

Not at the moment. I have a branch I can finish up that would do the same b=
ut from the traces Johannes shared with me it looked like I simply wasn't r=
eceiving requests.

