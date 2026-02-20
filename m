Return-Path: <linux-fsdevel+bounces-77773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJF8MLwumGlaCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77773-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:51:56 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB41A1666D5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3109B3010612
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C9A3328F7;
	Fri, 20 Feb 2026 09:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSMnR2VB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05ABB31AAA3;
	Fri, 20 Feb 2026 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581111; cv=none; b=jCm4PUK3j6SlKaWlLflnAhpnXPDC5xXbT4997R7r+QAu62Z6m60bUitduOeOHSh5a7MAZ93QiXKJTtHXPmH4xxqYuad8kUWDxk4Uvl7ZhsPEoIsLfiD2yn24VpzcfdAF8EFXW5rR8i7ANkVB5VNdPNXetMmZ75XFhAEPpfme+Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581111; c=relaxed/simple;
	bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MzMFTRupQRbm+Bros7FocBFH6/IIvqFpzgFWo6d6Bz1RNCkQCv8zh/QEfvdCqU2qciXwzniSCm8omUIm2G4cTFnqBY6n2HR0fhK0KTJvzuPJPqk7hwpWFj7d22f34zziC4tFs74NjerFWZZU4D38lbTeUYEy8efulkRpj8cgIZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSMnR2VB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E18C116D0;
	Fri, 20 Feb 2026 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581110;
	bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oSMnR2VBFiYF7mSjxjkfNVi7njkjNf3PLhFrBmpcM9d4pWK/GXd5fkMSWFUZ6VD2x
	 5eWFNCJJkIsdUzWD77f02RYiEeD4v6skYIt2XW4ao3NA2rgWmQjg+wQhZGtGTM0+Zj
	 QiUHPRguHu8S8fyOflkwjbIMsLyOrB/J3XN0Hx2jcXaSuNOpyqtRqMaEsgaUkyYUeX
	 KxMtJKZRfO/w92vTqQMucveSOe8zWyt3q17hU4n7gBLOq3rKrBHkil4p0WmBHZZPXk
	 G1/C+VImEEajDd/Cp9FfpLnahW7HziI4vghEkK4AbpaRBMnwIhHj6tE38PTOuLCsH6
	 mzUUw11uwWtqQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:13 +0100
Subject: [PATCH v15 4/9] rust: aref: update formatting of use statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-4-893ed86b06cc@kernel.org>
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
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=PBOESvJWRqEQ2bmBI+MqZdyLdwyA7OsD4YPXBLOYQLU=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6hzPFPu7KGUd6cRx7n7GKtIx6VHoVNewyV0
 EXg0W57W8CJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZguoQAKCRDhuBo+eShj
 dxM1EACnIHiAlYn9gPgqZulCKlNlf50uQDXyF9B5lqzxCB4xzKIk29CViLlfREtNEQpmiNQ6TtS
 hzd1FYLf8u5dAvd4QayeNLUYTUptXcQrByNp2EdNsAhuMhgCPbvxv+5XzO7Yb4c2iwvxXZ/GV3F
 Ez583A3k+mRd7YqWWpEj4RFpnKFo5uIsu+8LJckCpHdVp+QBP16CQHoJpF/FjhcEYaulQ62G4kF
 NkTJmahq5F85IlPLQZ9bZfLgDII15NQvFGJDbj6tOPcVDVLOZrSpdw9wHnDj5K7h4UE2FTUpyZ8
 sl8Hk5h+JXj/1GqZbQyHuxIM2mJq3l3W8UusstI+ftPaYNK+cRNg5aEEWt/uP7WYBqUR2R+rFez
 NF32cG5Xgq9fKisyoiE0H808A3G9U4UA8GIZlqilG16eM24JIQWAw/cbRleD8D7YDiPtRb6id5R
 yRJBMLPT83Cz61htPmBosbIHLJX7srwu8C40hy8wXT8NeJvJKVYf2HY8q1ViVS9uaHBWecAHYjJ
 qa0FaiULDIt0mIIUOHhDKnldiiopsOPUz3D+Fz0tJhlLaaw602DiBfp+t8ghomDp+O6GNvrZA5m
 yzaE5kR1WUPNuPs0iFLB5ez3KpIEebt3HS7YpUVYt1xLlkOuC4mg364/IymHXlngTS1mnkrgVVf
 wmnQL4v1G3QBseQ==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-77773-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_TWELVE(0.00)[40];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AB41A1666D5
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



