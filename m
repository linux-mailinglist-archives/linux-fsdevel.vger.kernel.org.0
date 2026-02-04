Return-Path: <linux-fsdevel+bounces-76310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIs9H6I1g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:03:46 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C0E5839
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB15303E2FD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8C83EDAB8;
	Wed,  4 Feb 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESN8nuz2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC03ECBED;
	Wed,  4 Feb 2026 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206294; cv=none; b=D7OmmhgCcRbf7rTp6bRWgmAZE3Gv2HkxqO+lrDV5Ix9ovyXQdGqT2PAzyW5eQ77GlhHXQDEIafXikNzIz6HLFeFXVitJwt2utznvKkrDit3IuXjeYrhI4Dfr3jAOsw2ZjD7HI/CiFlNTBaQKfjVZdqPe5t8sb0oQ88AWHydrkkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206294; c=relaxed/simple;
	bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hezJ6UOCzdNCD9z8SBVuvb37UvLToRnrd3bN2YPVc3QvkmgQQoIZaTtZe82l4LWeo6jqLFYhVINK2lW4l0vw/jvuTPyjExet35LDMkaG7rdcVIdUpz0gPrCeSW0ygtxnLH2IAzHLS1LE/5Mjut6IZ/2XrWgrOkTW+KQJl0/XPC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESN8nuz2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78FEC2BCB1;
	Wed,  4 Feb 2026 11:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206293;
	bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ESN8nuz2S87uQ84h21rrTo5WOEHsLs4F/sXyU5GGND+4N+g6BhMrcVYsicUjk8cGD
	 xHqIhAIoD+Qe6eEWHfC6tcbLJYTrWASs3XNZ9GL5g8G7HkJEd/9MeXdDlkgEyncwBp
	 xViltxhwMzKVxH9JWNNVCZiHwfpczGFiJlypHFhpSTKrxqW9W85Elz/RSLB8oe87JR
	 K2yZTbj8s16zLvUCpu5x4utzXyoLKz0dDcQKoT+fEKIDoPHD2QS62uUBvaN8+yXKbr
	 ssOC/AuvsbiwhuzTNktYS7JzTL7cTfH2eIy7TJN1Ynv+wCm3HsXSEs3RKnFIcq5wfx
	 hzWtW6SDAGX2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:48 +0100
Subject: [PATCH v14 4/9] rust: aref: update formatting of use statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-4-17cb29ebacbb@kernel.org>
References: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
In-Reply-To: <20260204-unique-ref-v14-0-17cb29ebacbb@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
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
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQC8WXId3BB6udifTdGRxtPZJjj8e9hx+zAu
 QOTwRyR6O+JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0AgAKCRDhuBo+eShj
 d52WD/9JR/g98fdUOY2A8g+rGpmdLfgzdygQocbFPvSVXyFv38q6LeptynGRXH328+Llt9FMs7W
 W2Yyp39eVHkhsA2sBR+RmPm0kLhpQyTlCas32QiZ3BVU0HAS+NeoBelq6HB5MpyCIBG5hNt69lI
 YMymMT9+vQZB7AC1uaReCxdkqSDFxmT+vIZ4589KpZWzbHR4M6JY6XAd57pdg1k1tYuzYInaS/o
 Gr7kW3zIy9YG3zEpodF1SmwQWaf///Uzfi2SZRvn0dq0HcEpzpd4mSF1VuJ1796efe/UpjBFDoz
 YXaGCJTZwHy9B+sFzu82whCwF3hi8cPX2I67pGhDU4vkQf4u9sqX7uHYf2pz7/SY5dbqEF2gi0C
 QOcESpEP05JCslZh3vtiZybsPtBB3KF/fj3nOisEL0YBmhgfK9hcAjkzuS5NX1VnclZPiFtSEtd
 aZi8BWjWrIk/xl90Dv/dtp2EQpiFJc6RGeXXkUJDRwNeeIDCbtcyIQrHTT//IwlK+ab8RpATME5
 GScNPXhVoGC2dPGlmtZ79a4nn5XS2smcQfmrUySufpWh8FpTCnjZrOt/fWdUlobSnPHfXe643ws
 KYu8SkPindocqSr854POQ9gNtOXnfk8cjiAszpDKMwENo5OhLW60YELBH9dPsw4iG3BiKQ346bx
 7t8YyWd6wkWbBeA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76310-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 148C0E5839
X-Rspamd-Action: no action

Update formatting if use statements in preparation for next commit.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index efe16a7fdfa5d..3c63c9a5fb9be 100644
--- a/rust/kernel/sync/aref.rs
+++ b/rust/kernel/sync/aref.rs
@@ -17,7 +17,12 @@
 //! [`Arc`]: crate::sync::Arc
 //! [`Arc<T>`]: crate::sync::Arc
 
-use core::{marker::PhantomData, mem::ManuallyDrop, ops::Deref, ptr::NonNull};
+use core::{
+    marker::PhantomData,
+    mem::ManuallyDrop,
+    ops::Deref,
+    ptr::NonNull, //
+};
 
 /// Types that are internally reference counted.
 ///

-- 
2.51.2



