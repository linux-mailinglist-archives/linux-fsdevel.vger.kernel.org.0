Return-Path: <linux-fsdevel+bounces-78858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBDVEdSapGnamAUAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78858-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:00:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF451D16C7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Mar 2026 21:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37A683017507
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Mar 2026 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25CF335BA8;
	Sun,  1 Mar 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu1SLlPE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695431E5B64;
	Sun,  1 Mar 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772395191; cv=none; b=P1pRDfaZPpaTxX6VbsHe+61c0dS/3JeRHCzv/HOLUoYwXQkhTW2MNbXV4J9bbI6rS0NUmNQCwyQsFNSwbkmBtaHP0Hp5YodK8lvYpJ/6Qqobvnes9jgbMPG3taRnNAZl/Bp7sVkgBrEjfuVjcA2MxR7mT8E87rPj9DY+If344sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772395191; c=relaxed/simple;
	bh=c7Lf0pg//jvb+3j7ibNw1PDnDJENzEb1R7UG7EkUWBo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DTG20OkN5GQJOGWw8iRr4vNdaA+nkz/sPVCtS9t2U6OiLHr+3JU7XSi04VQ6sw6YAFhYPPJkSIOagD7ace4pXvah7Ad8cnf0rKpFHTJ6VdP3bz6hwr3sNr05PZ42pfkh+/3MmmR6cibArpmBFttt7JTfvT2kBoywhnXZyNwJaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu1SLlPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A73C116C6;
	Sun,  1 Mar 2026 19:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772395191;
	bh=c7Lf0pg//jvb+3j7ibNw1PDnDJENzEb1R7UG7EkUWBo=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Bu1SLlPExanZzJBk/3KZ/KJEQNSweZ38bl1tkZtVFxhnq0oJlUvJegoCFn4bRC5Uz
	 8JDJaAmHXk5dhybtqUAV/W3yC/U52oInYwdv69V1GK+nnTYouG94WW/x7Xw8lxDOZW
	 NLQl7cIpj6VKUwwEwSu3f2J+rajFU7zgPKfetnELrePj1Nlrv58tgQA8w7IEJTypc8
	 IkJhPuewEYoACBnMZr2n7CuzKUSdrgsOeKZ16KgdW5hPuSMIlSi+farv4EpkH6PCj9
	 YYCQdHxF61C67tz1eYO2FCji1QDBfhLkU34F5H3EpcsZm3OxSXvAcfEcGrmjaGYIaG
	 zXQ1ANgq2n3QQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 01 Mar 2026 20:59:41 +0100
Message-Id: <DGRPNLWTEQJG.27A17T7HREAF4@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v16 01/10] rust: alloc: add `KBox::into_nonnull`
From: "Benno Lossin" <lossin@kernel.org>
To: "Gary Guo" <gary@garyguo.net>, "Andreas Hindborg"
 <a.hindborg@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Ira Weiny" <ira.weiny@intel.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Paul Moore" <paul@paul-moore.com>, "Serge Hallyn" <sergeh@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Christian Brauner" <brauner@kernel.org>, "Jan
 Kara" <jack@suse.cz>, "Igor Korotin" <igor.korotin.linux@gmail.com>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Vlastimil Babka" <vbabka@suse.cz>, "Uladzislau
 Rezki" <urezki@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
 <20260224-unique-ref-v16-1-c21afcb118d3@kernel.org>
 <eeDADnWQGSX9PG7jNOEyh9Z-iXlTEy6eK8CZ-KE7UWlWo-TJy15t_R1SkLj-Zway00qMRKkb0xBdxADLH766dA==@protonmail.internalid> <DGRHAEM7OFBD.27RUUCHCRHI6K@garyguo.net> <87ldgbbjal.fsf@t14s.mail-host-address-is-not-set> <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net>
In-Reply-To: <DGROXQD756OU.T2CRAPKA2HCB@garyguo.net>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78858-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[garyguo.net,kernel.org,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lossin@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DFF451D16C7
X-Rspamd-Action: no action

On Sun Mar 1, 2026 at 8:25 PM CET, Gary Guo wrote:
> `#[inline]` is a hint to make it more likely for compilers to inline. Wit=
hout
> them, you're relying on compiler heurstics only. There're cases (especial=
ly with
> abstractions) where the function may look complex as it contains lots of
> function calls (so compiler heurstics avoid inlining them), but they're a=
ll
> zero-cost abstractions so eventually things get optimized away.
>
> For non-generic functions, there is additional issue where only very smal=
l
> functions get automatically inlined, otherwise a single copy is generated=
 at the
> defining crate and compiler run on a dependant crate has no chance to eve=
n peek
> what's in the function.
>
> If you know a function should be inlined, it's better to just mark them a=
s such,
> so there're no surprises.

Should we set clippy::missing_inline_in_public_items [1] to "warn"?

[1]: https://rust-lang.github.io/rust-clippy/master/index.html?search=3Dmis=
sing_inline_in_public_items

Cheers,
Benno

