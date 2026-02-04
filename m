Return-Path: <linux-fsdevel+bounces-76331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id INEuDSx4g2mFmwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:47:40 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA57FEA7A0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7074D30101E1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 16:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FB2339B34;
	Wed,  4 Feb 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZHj8q1Uc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1E13033EC;
	Wed,  4 Feb 2026 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223620; cv=none; b=ox08H25JRFw8N9euMqED2JnSx0NhOmyell6dpVdIKUTfCGFsFqVqKPGp79e2B05VsvOa5K3RKvurrECtOsvV4KnalXP3INnzmWubZ7zKWxN2PdiOAaaRJ1xUZtr1/SzZ3YqhQG/0JcGUrU2DeMws3wLd2fu6jm6b9jqUVTZxGow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223620; c=relaxed/simple;
	bh=dy73/9OQI/HuBvsd+ptSVtFrF/SFQ/zEvH4RIO0j4i4=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=lJeBf6qZ0mZnnXmkTJWUxamZjm8G2ZET1S1TiGOEFK0khtCKwEzHyiMglAA3emjRbp+9QAhQ9ehSPsGOU2kQbpupQ83FmvJ474gXIBvcqVihBO6oJv8xgZVIa+KEEVljjyLnvZxiNqjFmUvaKVlfm1tV4TtFjoOvcBj5+j0MBMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZHj8q1Uc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF418C4CEF7;
	Wed,  4 Feb 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223620;
	bh=dy73/9OQI/HuBvsd+ptSVtFrF/SFQ/zEvH4RIO0j4i4=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ZHj8q1Ucvt7QcaZcn9QuPYACGDPfU/YL82+e6kQIaszjDn8/K3Lk25/ytj8Malksx
	 QTrROJpGVUsMkMWTzjQvp0wcUGKl69dlGdw+uM4ZXkcku66CUCCFf+JntNkoa9XeFK
	 UBAoEJloaJHzf8XjFtFKSgZDr+rjjdpxj021cT2FEEhwdvxmV1QnS69elAgBlCG2S1
	 5VpdKtuK+x95jkiRP0Q0olnVlaCNxNMiWvM9N5rJSdpQVInfdYkjh/kMwVzxggH0vt
	 xi4ko64jYM5R0Fh8vdICZWmXXV6iTywKSpHzFCGMppUp7E+ZJ8jy9VLrS1L5oDN6Sy
	 z8aQSzU00WK2A==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Feb 2026 17:46:51 +0100
Message-Id: <DG6BWC5SOHUG.2K1ZXGYNVB69V@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v14 1/9] rust: types: Add Ownable/Owned types
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Dave Ertman"
 <david.m.ertman@intel.com>, "Ira Weiny" <ira.weiny@intel.com>, "Leon
 Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 Hallyn" <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner"
 <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin.linux@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Viresh Kumar" <vireshk@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Stephen
 Boyd" <sboyd@kernel.org>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-pm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, "Asahi Lina" <lina+kernel@asahilina.net>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>
 <7uftlTZxNVxMw7VNqETbf9dBIWLrQ1Px16pM3qnAcc6FPgQj-ERdWfAACc5aDSAdeHM5lLTdSBZYkcOIgu7mWA==@protonmail.internalid> <DG6AIA0QK77C.EKG7X4NBEJ00@kernel.org> <87fr7gpk6d.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87fr7gpk6d.fsf@t14s.mail-host-address-is-not-set>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-76331-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org,asahilina.net];
	RCPT_COUNT_TWELVE(0.00)[39];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA57FEA7A0
X-Rspamd-Action: no action

On Wed Feb 4, 2026 at 5:06 PM CET, Andreas Hindborg wrote:
> It is my understanding that the SoB needs confirmation from the author
> if the code was changed. I changed the code and did not want to bother
> the original author, because it is my understanding they do not wish to
> be contacted. I did not want to misrepresent the original author, and so
> I did not change the "From:" line.

Frankly, I don't know what's the correct thing to do in this case; maybe th=
e
correct thing is to just keep the SoB, but list all the changes that have b=
een
made.

Technically, the same thing is common practice when maintainers (including
myself) apply (minor) changes to a patch when applying them to their tree.

> How would you prefer to account for the work by Abdiel and Boqun?

I mean, I don't have a preference and if I would have one, it wouldn't be
relevant. :) I just wanted to bring it up since the very first version was =
sent
by the two of them. So, I think we should just ask.

