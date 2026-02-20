Return-Path: <linux-fsdevel+bounces-77778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIIYNiUvmGkzCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:41 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F071667AA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ABD5C3018E38
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23E43346A7;
	Fri, 20 Feb 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6XvHSje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A4F313555;
	Fri, 20 Feb 2026 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581150; cv=none; b=pJDZKuE1cBMBF8aAnMI3oeaeFymV2tWw5DKTQ2lNQd0qybzOryJ/MwRl4c14HuY+kOURG+gJC2c1cWVaU7/acQaX0BpO02/rYFmgv9DI8wPBeVIGfVHLH6itfHOjYQ+xOVTPaET3FG6WciFUTPoCVZboCiSN3jgBLDFknCt6Sek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581150; c=relaxed/simple;
	bh=p1tAAxGtFcTpyH8kJIKfeUGx7oWCMIhnPZTORNKDSkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i7WkwltfO4W14TRFBxaOgfgMHKHhKr0FTo840VW3C7QdmB0VY0vFQgYdGx1yDa0XkPgQ0kRTV8l/Mxu/6tvk1cCoGgauqY4Cc2BTEMEHJnK5054/iLT/JpnmfSABe8uCyjXVOOhvdXSdf8bk9DLRoG3/PfadZFxC8gKOs9UcuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6XvHSje; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF9CC116C6;
	Fri, 20 Feb 2026 09:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581150;
	bh=p1tAAxGtFcTpyH8kJIKfeUGx7oWCMIhnPZTORNKDSkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=d6XvHSjei+/LwJ6azNn0RPBMuwdHY2AUX0AF3emYW7STF/HogUS8+EUDj3T/d19XL
	 M63tMOohnyibTXmGAA8TjFTHjntaGwGgaWECiP1PdArTlNK6cF+a8rn77fraqEu+l9
	 rn4fJ/3HCn2AgMP6t4ZiM/z1B6w0A1LmozVngj7jLLVZsyjZdW4/HiMQDPyiE6cNMI
	 nfC64/bFJMDvOeTurZ43+8l5zYJaQm2IBou+xxGbOSbBAnkOr723pFGtHUjzOeMbfI
	 a92ibJGQDcq5yHyAYOwdM9XEoJFtH8+0zVarlQ9bdDXdTxUaadxXKkMTGrInY8ibAE
	 X3eDPCS21Z1EA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:12 +0100
Subject: [PATCH v15 3/9] rust: Add missing SAFETY documentation for `ARef`
 example
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-3-893ed86b06cc@kernel.org>
References: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
In-Reply-To: <20260220-unique-ref-v15-0-893ed86b06cc@kernel.org>
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
 Boqun Feng <boqun@kernel.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>, 
 Oliver Mangold <oliver.mangold@pm.me>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=0VuAJevCkYFZAUYzbU/zIm1O124y3qethT0WcgbappU=;
 b=owEBbAKT/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6g+5r9c8hNIwBUmEKkWqrvZg384pxiRXLng
 +3sV++OUXmJAjIEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZguoAAKCRDhuBo+eShj
 d5gpD/jlKR4PuCzBrXKPcsSwhxSkegz1CUJdeYgrGfzZ9wRiOA/5ps4xbsU55RhyGnWoOb0+UvN
 QLyLhxhnDxODib1nUdt+EH74woUiQ1+tSfuwhD/bmb2FztVhX3YKoEIkULGbHAx7bZMUJVOxEKa
 FTaTy3ZNbg3E9hVWN3t0ZptiN7JGgd+inoLuRa9KrdX9z+nRozTCjZvNFqLryaBWUjuFU86k5UB
 ndhZG3zO3CHLHZ3z+qqqDH5U/qFXlhUm5dto71y9MBC57gO+G/fnEPs1340ZkwHrJUrSZ2RRhng
 vOz2ypc4kr7lIgN8Tn7SoifY0uYtm/8mKwDLDehcon3lIy6oZMQalCOO8kvFlSGwHiblbqE/Ibk
 FP+61QHkX7mYrBRbYPsNJqbi25f/rIUbNGNMfHo18A/2rmSA16Ds2/5vlwny+0hxv96/dQXcNXa
 2JpXulj0V+7noIw53LO/jknBTxQuYwd74HeM9KGf5ilIhCgdD9cQBxuvEPa3spLHS4xCVcSKCW5
 ukWuT4E7G7nRnUgSvozkeLAmTJqIWoNZFw2ZCTbmePW9Kbta+NjprXLwLR+a7Jrv1ch2bGyV6dK
 oUFVz73j3T569jm9Nl4Fyf8gsz/VEi/Q1MU5ShzSbfQjtr5+AfgxWjMQb9XxQkSWc4kBeFvYT0a
 wHpjkhcaZd+5z
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77778-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[41];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,pm.me:email,collabora.com:email]
X-Rspamd-Queue-Id: 11F071667AA
X-Rspamd-Action: no action

From: Oliver Mangold <oliver.mangold@pm.me>

SAFETY comment in rustdoc example was just 'TODO'. Fixed.

Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 61caddfd89619..efe16a7fdfa5d 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -129,12 +129,14 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
     /// # Examples
     ///
     /// ```
-    /// use core::ptr::NonNull;
-    /// use kernel::sync::aref::{ARef, RefCounted};
+    /// # use core::ptr::NonNull;
+    /// # use kernel::sync::aref::{ARef, RefCounted};
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



