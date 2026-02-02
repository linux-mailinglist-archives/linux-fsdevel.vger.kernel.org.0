Return-Path: <linux-fsdevel+bounces-76030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOofObx5gGne8gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76030-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:17:32 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A730CABCE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Feb 2026 11:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DE6D30480DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Feb 2026 10:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F8C356A17;
	Mon,  2 Feb 2026 10:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3Zk2JPt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259762D63F6;
	Mon,  2 Feb 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026798; cv=none; b=s8YJ2vUbpVR30HyHR0OaXb9yR5LgWFy9ScYKrkd4OLly1UBN4fmrvZaNQrslK0hZuoy+JyNolXpkANinmxDQC+GpJ9qxU/fs9qXKuXrLBlqV5rY1X4IVuQse5fS4GsUiOWQyStelg4XRTwflC6dFkE/Cwa/1tHpAgM1J9vJsEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026798; c=relaxed/simple;
	bh=AR8WJZlCheylxeYBIiVxCcxzyOcuAsM0oQ9x69QBGeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KoHEXogpBdZKkvBYA+pPiwaDHeOlL2ueBOt+rkrWF54gxMjNu3LWybSybTntLInLKdpD3rr9cG8JgJNILo+XhwnKlqI7kw0XJlLBZk7/8lpaUaAPLl/GchBD8lelSA/NzISP3F/viz588M2fS8Mz0xsd76++3MH+NEVHzfsBvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3Zk2JPt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4988CC116C6;
	Mon,  2 Feb 2026 10:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026797;
	bh=AR8WJZlCheylxeYBIiVxCcxzyOcuAsM0oQ9x69QBGeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F3Zk2JPtX9BKsOfGhozTjtxp24jGgOGKlChNCS+jg88F1hIocpFuLVSYIR18rCyVU
	 Moue0o90AkrrRNWLZsD3Ivul0Ujd6NRdOLRfS4mbYhd+jIgh3WaUTu37sqLhjoVDDM
	 ZgNKC4CQQbziV9McP8h+/UTn9ywlHI2QkvLZ2ar9yc3YlJ8hR3SruAEiAa6yi0It27
	 BEnKNuFE3HNDel0CDsOIk6P757sPTcTgYwWOtVRxtchr0rBPAWQmmqwkgUZckaznQa
	 zih68OgLAg6wb4fCu8Re3XEGr9fp/N7elqd9Vgxj/bLH1xzTBTaowCfXgw4AOXcm0E
	 o6qWmBVO6NSqg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin
 <lossin@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Viresh Kumar <vireshk@kernel.org>, Nishanth
 Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Paul
 Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Asahi Lina
 <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH v13 2/4] rust: `AlwaysRefCounted` is renamed to
 `RefCounted`.
In-Reply-To: <20251201160030.6956a834.gary@garyguo.net>
References: <20251117-unique-ref-v13-0-b5b243df1250@pm.me>
 <20251117-unique-ref-v13-2-b5b243df1250@pm.me>
 <20251201160030.6956a834.gary@garyguo.net>
Date: Mon, 02 Feb 2026 10:48:39 +0100
Message-ID: <87wm0vpjbc.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[42];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,linux.intel.com,suse.de,ffwll.ch,zeniv.linux.org.uk,suse.cz,oracle.com,ti.com,paul-moore.com,asahilina.net,vger.kernel.org,lists.freedesktop.org,kvack.org];
	TAGGED_FROM(0.00)[bounces-76030-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel,kernel];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pm.me:email,garyguo.net:email,t14s.mail-host-address-is-not-set:mid]
X-Rspamd-Queue-Id: 4A730CABCE
X-Rspamd-Action: no action

Gary Guo <gary@garyguo.net> writes:

> On Mon, 17 Nov 2025 10:07:57 +0000
> Oliver Mangold <oliver.mangold@pm.me> wrote:
>
>> `AlwaysRefCounted` will become a marker trait to indicate that it is
>> allowed to obtain an `ARef<T>` from a `&T`, which cannot be allowed for
>> types which are also Ownable.
>
> The message needs a rationale for making the change rather than relying
> on the reader to deduce so.
>
> For example:
>
> 	There are types where it may both be referenced counted in some
> 	cases and owned in other. In such cases, obtaining `ARef<T>`
> 	from `&T` would be unsound as it allows creation of `ARef<T>`
> 	copy from `&Owned<T>`.
>
> 	Therefore, we split `AlwaysRefCounted` into `RefCounted` (which
> 	`ARef<T>` would require) and a marker trait to indicate that
> 	the type is always reference counted (and not `Ownable`) so the
> 	`&T` -> `ARef<T>` conversion is possible.

Thanks, I'll mix this in with the one I sent to Daniel.


Best regards,
Andreas Hindborg




