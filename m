Return-Path: <linux-fsdevel+bounces-78246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFlOOU2KnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:23:57 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B39C1862AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553A531EBC3C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F32C37D104;
	Tue, 24 Feb 2026 11:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFUvOs9g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF7137C0E6;
	Tue, 24 Feb 2026 11:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931961; cv=none; b=VvAyoXtfGRpwCnJRQ99NzYh1AoHZb9k09xJtDS2syqzS2U+Z5xboPX1I2iExIKzHljHhW2iyCwpa4ZvS+TK+I/Wx+Wktyj6qe426IrSwj4xnGhGHCWDXyEy5kocCNedmqoaf53+fx8hynd1WcAIpTfFSQussfEle42biiOjbMpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931961; c=relaxed/simple;
	bh=fnHuKwO7YKsiBEzcJ4WSpUwI9pJ1E1um3MRGk7ZK9EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pdUednw5llYB2X4zs9gUpZjFds1Ek9dilpJhpmSeyqzftsPg6ws/KvwbpIFfEpYpxLBTzC91o1Y1LGcq0RkXJzrHUWOH4bn2wW5t5wnbhBXUNRm7UtNfA6JHmRiVYsaDSyZgYp5fEFZZTUw5iyz/nY11pNrip1ylFNkiViYv6uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFUvOs9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3475C2BCB2;
	Tue, 24 Feb 2026 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931961;
	bh=fnHuKwO7YKsiBEzcJ4WSpUwI9pJ1E1um3MRGk7ZK9EA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tFUvOs9gyzy7Ba7ekjjypN2kAfFvNhFK6Ym27l7W170CaSEHNkLV7YYAlGJ5DY17V
	 owZdqMEDEr5KFkPWDencHzpnD6natiZrnAmC/FLAi4Z9Lz9zfRJbd1sxhstw3Hl1qy
	 u3TmQQtb1p0mU4qoPVMfcuGSdi/6NzTWthDZ8/25H8RJLWbJ/6pT30wRAygqhzSOXc
	 POq8PYVHC3gY7LnkY5G1YFdreQr6i4ir+kQ0NPvmhP8liRwLK0+oaicE1UhUTsYKpW
	 VCO6Y+I1ha5MuldT5BNfYVtKlVWFlcwhaRF0Ial+V7749Z0vgjvOQ47+NKhdP80WIe
	 oTCMnGg6JKtEQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:17:59 +0100
Subject: [PATCH v16 04/10] rust: Add missing SAFETY documentation for
 `ARef` example
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-4-c21afcb118d3@kernel.org>
References: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
In-Reply-To: <20260224-unique-ref-v16-0-c21afcb118d3@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin.linux@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
 Uladzislau Rezki <urezki@gmail.com>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=hSYEjFGzugCDI1W/rekaqf2DA13xvb84HHFFaBF1/aI=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj39reO0a7D2MQbsv0XqEQumCgi03QYrtHI/
 ZYn1cQw0UOJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I9wAKCRDhuBo+eShj
 d918D/0dNadTGYW4J53gaqBX2Pq2oWBZGwS79C0CdceTypFO5fLqCVqxcqXPCooqVOZ11C6YMVf
 nMG3oUX/TxD3GSgCMT32HQCYprMppcd53Pt4ne9SNDH001yDQwxMLHtNTKcpRyRCyvPkSn61Ot7
 vx4Rx/e7RRI1FkWXDubxT9H0137dXGskODt5t9Asv4KyYOrxv3ulMIDkJLQowoKQOF5s92uqIoJ
 xNbZr7Cbui2WcPA3z4Dv8hBkHETBbOiI9ZWyX/vzBhf9FVBTLhRq15q63fsDd2YSOhGsYcE0Kaw
 cxbfsyFqBCEmYKLrPq0/LCZBV2szgX041hacce/RW4TaXwcLNA8OqKFfDi4nyc9aWdzP0ZDo52u
 Y3S3xvgTa0o/JNmM0+RHewjsPyAuXGTZ9qDhKv4T0ZBVi3WBBJRL8tMGAz4NNmBm2xCWAeGh5JN
 JLBXN0Mzj+uh0wtXz1/YIW41PFoS8isp3E0P6XlRIQOe1/Bh6TvPXSeAk5mKDYpSyP8aQRAOoqM
 aIbdQNjcoDaMVPrUz6IKm/FAi9LvWEI55GbXkoXGV+VkvL5MamXv9diHQKLqnMGH8yQ2QuG9zaK
 PpvAvvEKSA2iT7kc50MybsG6wBDt9DwvNXXuJgSCkdHVO8ISQKjqIjAonQP04V0i/0C64vwIodc
 nSi+sCMbQh0moHA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78246-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[43];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pm.me:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,collabora.com:email]
X-Rspamd-Queue-Id: 4B39C1862AD
X-Rspamd-Action: no action

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 61caddfd89619..76deab0cb225e 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -134,7 +134,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// struct Empty {}
     ///
-    /// # // SAFETY: TODO.
+    /// // SAFETY: The `RefCounted` implementation for `Empty` does not count references and never
+    /// // frees the underlying object. Thus we can act as owning an increment on the refcount for
+    /// // the object that we pass to the newly created `ARef`.
     /// unsafe impl RefCounted for Empty {
     ///     fn inc_ref(&self) {}
     ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}
@@ -142,7 +144,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     ///
     /// let mut data = Empty {};
     /// let ptr = NonNull::<Empty>::new(&mut data).unwrap();
-    /// # // SAFETY: TODO.
+    /// // SAFETY: We keep `data` around longer than the `ARef`.
     /// let data_ref: ARef<Empty> = unsafe { ARef::from_raw(ptr) };
     /// let raw_ptr: NonNull<Empty> = ARef::into_raw(data_ref);
     ///

-- 
2.51.2



