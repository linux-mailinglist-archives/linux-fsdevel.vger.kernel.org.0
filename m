Return-Path: <linux-fsdevel+bounces-76329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLRIGLhug2lNmwMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:07:20 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4157EE9E5C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 17:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8AAD300DECB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 16:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7EDB423A83;
	Wed,  4 Feb 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnzGhoQx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FAF3D9041;
	Wed,  4 Feb 2026 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770221227; cv=none; b=NxLkwWXVLd/d7F0f0e63Q/9Vuzu9AZtNwhYFNWi2KhC5mTjacYAOxNcWCh+c3s3cU3Djh4uDv5i3CpsUSANgpdQ2KrqGov54u2aGUQpC69xGM4g7J/sumqaOsEB9jeyF5YdwB1dsReTmbHkxtgokrDe/epaLbPivLzWVpWWbafg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770221227; c=relaxed/simple;
	bh=zgeg4LpFYkGts44vRDwLwUa+VYSDlRkllv2N4lJEvvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Rmnvxu7X9EM8twIdMN7hJDZF9xHV857es8UHiCGFQz7aHsvtGy7Fz0nurY0VlKDS0TcOjPE1pT/VfrLJsecGDaDn0Z1KO9Wleri6gHa/4imy73tkkQXknl7DJoNFhf3TVBHkKy4WlUOxFlloRs6hyp+KWaerE8ni6Ey9APSmTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnzGhoQx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1A4C19423;
	Wed,  4 Feb 2026 16:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770221226;
	bh=zgeg4LpFYkGts44vRDwLwUa+VYSDlRkllv2N4lJEvvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XnzGhoQxZKf3UQUh2YoZFN9qW8ovu2POoWF9WjU6+PWtF+yVh/x/ub22/QXkV9h+Y
	 xQAB+vpKbZNTxsxvYOGjMKFs+zhQYNcpvhtzg5hwZy7PC72ma7i23uU5zASOCB3d7U
	 JE+DG9j6685I5plBOtUzYIFke4zPfub1mdjahapJr4+/uYqYwArr2iW9Zzh+tL+4i4
	 qocUIrDo/U8co47MA3m34ke+IGQfRBAohAjf5uTGNfYgwIiciKP9K7vnqOWNzL2cSf
	 u0QkyK6DDvaohsw0x3RfqmciFoHurjoxlEfTbDT+pLK5v/6DvUWtiQU+mKsVxN/335
	 +mgP920c5zjTg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, Leon
 Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, Serge
 Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Alexander
 Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin.linux@gmail.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen
 Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org,
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, Asahi Lina
 <lina+kernel@asahilina.net>
Subject: Re: [PATCH v14 1/9] rust: types: Add Ownable/Owned types
In-Reply-To: <DG6AIA0QK77C.EKG7X4NBEJ00@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
 <20260204-unique-ref-v14-1-17cb29ebacbb@kernel.org>
 <7uftlTZxNVxMw7VNqETbf9dBIWLrQ1Px16pM3qnAcc6FPgQj-ERdWfAACc5aDSAdeHM5lLTdSBZYkcOIgu7mWA==@protonmail.internalid>
 <DG6AIA0QK77C.EKG7X4NBEJ00@kernel.org>
Date: Wed, 04 Feb 2026 17:06:50 +0100
Message-ID: <87fr7gpk6d.fsf@t14s.mail-host-address-is-not-set>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[39];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com,vger.kernel.org,lists.freedesktop.org,kvack.org,asahilina.net];
	TAGGED_FROM(0.00)[bounces-76329-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[t14s.mail-host-address-is-not-set:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,asahilina.net:email,pm.me:email]
X-Rspamd-Queue-Id: 4157EE9E5C
X-Rspamd-Action: no action

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Wed Feb 4, 2026 at 12:56 PM CET, Andreas Hindborg wrote:
>> From: Asahi Lina <lina+kernel@asahilina.net>
>>
>> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
>> (typically C FFI) type that *may* be owned by Rust, but need not be. Unlike
>> `AlwaysRefCounted`, this mechanism expects the reference to be unique
>> within Rust, and does not allow cloning.
>>
>> Conceptually, this is similar to a `KBox<T>`, except that it delegates
>> resource management to the `T` instead of using a generic allocator.
>>
>> This change is a derived work based on work by Asahi Lina
>> <lina+kernel@asahilina.net> [1] and Oliver Mangold <oliver.mangold@pm.me>.
>>
>> Link: https://lore.kernel.org/rust-for-linux/20250202-rust-page-v1-1-e3170d7fe55e@asahilina.net/ [1]
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> Given the From: line above, this needs Lina's SoB.
>
> This patch was also originally posted by Abdiel and Boqun and I think we should
> account for this. I mentioned this in a couple of previous versions already,
> e.g. in [1]. I think we should account for this.
>
> [1] https://lore.kernel.org/all/cc28d048-5e0f-4f0e-b0f2-1b9e240f639b@kernel.org/

I had a question about this in the cover letter.

It is my understanding that the SoB needs confirmation from the author
if the code was changed. I changed the code and did not want to bother
the original author, because it is my understanding they do not wish to
be contacted. I did not want to misrepresent the original author, and so
I did not change the "From:" line.

I want to be clear that I want to submit this patch the correct way,
whatever that is. I will happily take all the guidance I can get to find
the correct way to represent the work of the original author(s).

How would you prefer to account for the work by Abdiel and Boqun?

Please advise about SoB and I will correct the series.


Best regards,
Andreas Hindborg



