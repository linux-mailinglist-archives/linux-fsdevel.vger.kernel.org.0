Return-Path: <linux-fsdevel+bounces-77368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBqhKaJ5lGkfFAIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77368-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 15:22:26 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5299714D19D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BC11303828A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Feb 2026 14:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E51536C0BD;
	Tue, 17 Feb 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8svIcDT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E2361DC9
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Feb 2026 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338106; cv=none; b=AWfPj8LIRsYjf16O6U8p0oEHhISaJaI4Qnb0Zrv7nLGwV48RNMsjzq++22dWiN80KHh0zcuvDpjq0pv7cNSzfwk8TuVV0xodgNRkKavyD1SzYTomSoSm2GYwbJ51pach5k5i1YwqIlpyw31WYCrbfp5iexDMDABQ+qRqId9Ks6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338106; c=relaxed/simple;
	bh=b4YXp4Doy/1JvSdAtQaHXNMAj7nhowBDstvdnJgDnRU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uN5TUsOdD/nqnq2cfat1FSHot4b/vKNgRy8CSJMZaPynSGdtZYJu467LFlzX97dBz7Xc2kWEfV+Qj86ubFjckqb67FceccEoRvOrNUcgT/FfOXyZFt4sZTLXZj5coljyyUas7Ke9L2YToWbQ8NWV4YtI7Rrrl77qzESrWveUbQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8svIcDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B6BC19423;
	Tue, 17 Feb 2026 14:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771338105;
	bh=b4YXp4Doy/1JvSdAtQaHXNMAj7nhowBDstvdnJgDnRU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=B8svIcDTSEa5yWDTuiwxmJ2luP6QEn1JuMb0L+LKTMGIS/+voSxEqm4KqW6fHd6i9
	 DXi76QB1O+3kd8asd2ZmfWZvMtKbzROWRKvQ503r9Bbm03xtqusdVv5FnfCGoof5Jm
	 5WdeloR4EgWJaV1cWmURNv9HrAcpsJsN24z1urSy2IIoCw7cXLOe05P0IHb8KI9XB9
	 37AoPU/uy5nHa+gcuszUi5tBXkdYdohrFganzv5dDBuv9Ca7g0B7cOZBF42TyINukY
	 h4q7EI7g6/Gp6VgZ/MLr8CA5+8Zlegu3G0+Y9hcUXuyHu+RfHkDs/EKzUG+B82XwNc
	 iKUv+birv9YlA==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 89597F40068;
	Tue, 17 Feb 2026 09:21:44 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Tue, 17 Feb 2026 09:21:44 -0500
X-ME-Sender: <xms:eHmUac5-kpBcU512In2Gd_-S3_JOV_sacFz4auPvatRgklveCVqnIA>
    <xme:eHmUaYvlw5EMa3RAd9ais2CqXLo-qaXJEAFz3F5EvV6NhRvLAErSR7EZIU78BRAp-
    lC9jkqr0Dw3elaxVqZmj4AGcTWHLCi9Ukp_oryQ9PdrXq8PXCvNoZ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudelleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeejleeftdetjeellefgtdelfffhueefhfejgfehtddvkeefgeevffevudefveeuieen
    ucffohhmrghinhepphhlrghnvgdrnhgvthdpghhithhhuhgsrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghhuhgtkhhlvghvvghr
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieefgeelleelheelqdefvd
    elkeeggedvfedqtggvlheppehkvghrnhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhm
    pdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnsh
    hpmhgrnhhgrghlohhrvgesghhmrghilhdrtghomhdprhgtphhtthhopegsrhgruhhnvghr
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlshhfqdhptgeslhhishhtshdrlhhinh
    hugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepughhohifvghllhhssehr
    vgguhhgrthdrtghomhdprhgtphhtthhopehkvgihrhhinhhgshesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdgtihhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqnhhfshesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:eHmUaQJTFBaxA55MSGdoV1LGZik03Iv_bsP7HUiGO4dfcVE7b8x6IA>
    <xmx:eHmUaQnatPz4snrriLH1CAW3LEUZPhEXkCSkvwWpN59eyyYhs6-GKw>
    <xmx:eHmUaRboN6yNperUCfb-FbVrdTVKYeQiheQAU9Nxk-y6nfgadHslbA>
    <xmx:eHmUaU98ZQ42Jah3AnOQaaaCuS2H5G8gcVS0IPtxZmmdtCIcoUKRdg>
    <xmx:eHmUaYYgX93v66rSNGfGAPff1dBs9b_LDQDIzFA28uilTjy5ig7ajXmy>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5D4F278007A; Tue, 17 Feb 2026 09:21:44 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-xRDuNKAwPJ
Date: Tue, 17 Feb 2026 09:21:23 -0500
From: "Chuck Lever" <cel@kernel.org>
To: "Shyam Prasad N" <nspmangalore@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org,
 CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org,
 "Christian Brauner" <brauner@kernel.org>,
 "David Howells" <dhowells@redhat.com>
Message-Id: <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
In-Reply-To: 
 <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
References: 
 <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com>
 <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77368-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5299714D19D
X-Rspamd-Action: no action



On Mon, Feb 16, 2026, at 11:14 PM, Shyam Prasad N wrote:
> On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> w=
rote:
>>
>>
>> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
>> > Kernel filesystems sometimes need to upcall to userspace to get some
>> > work done, which cannot be achieved in kernel code (or rather it is
>> > better to be done in userspace). Some examples are DNS resolutions,
>> > user authentication, ID mapping etc.
>> >
>> > Filesystems like SMB and NFS clients use the kernel keys subsystem =
for
>> > some of these, which has an upcall facility that can exec a binary =
in
>> > userspace. However, this upcall mechanism is not namespace aware and
>> > upcalls to the host namespaces (namespaces of the init process).
>>
>> Hello Shyam, we've been introducing netlink control interfaces, which
>> are namespace-aware. The kernel TLS handshake mechanism now uses
>> this approach, as does the new NFSD netlink protocol.
>>
>>
>> --
>> Chuck Lever
>
> Hi Chuck,
>
> Interesting. Let me explore this a bit more.
> I'm assuming that this is the file that I should be looking into:
> fs/nfsd/nfsctl.c

Yes, clustered towards the end of the file. NFSD's use of netlink
is as a downcall-style administrative control plane.

net/handshake/netlink.c uses netlink as an upcall for driving
kernel-initiated TLS handshake requests up to a user daemon. This
mechanism has been adopted by NFSD, the NFS client, and the NVMe
over TCP drivers. An in-kernel QUIC implementation is planned and
will also be using this.


> And that there would be a corresponding handler in nfs-utils?

For NFSD, nfs-utils has a new tool called nfsdctl.

The TLS handshake user space components are in ktls-utils. See:
https://github.com/oracle/ktls-utils

--=20
Chuck Lever

