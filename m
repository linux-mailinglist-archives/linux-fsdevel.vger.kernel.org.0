Return-Path: <linux-fsdevel+bounces-78250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DwmHBOKnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:22:59 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BB79B186243
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD75C30723CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138B37C11E;
	Tue, 24 Feb 2026 11:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdqzLYlm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C5F37B3F1;
	Tue, 24 Feb 2026 11:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932000; cv=none; b=LiS3yTA435sRCp8M4ggbR4sE1VH/X0WtrtYNDAph/Xoo1HXwTs4WHQ5O8204P/e0jmT8CysindzEp4492WIqs+yWIt9OWZvCAt6/NT7KFL2Ux68t+wh7IUfJLKm+PbHwdUwJxUMU0yfKn1EP4lIbA1C6Yfsr8hhrscH/GM7gE7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932000; c=relaxed/simple;
	bh=Cv+ro0rgKKTNndu1LXkpKQFAsbhVDrLwsjlr+g88uog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IuS8V5LqCf3GOYBfBY8xfJHt9i3AP5wMH/xSK8FVMEHzoxIUuLUvSOkMst72+P+tZu7yv2tEHZOpK0fMeEXFPDBL0eumg/5VJLcVqx049uZX3R31n9cTWLtW7rdbU38tRkQ8mfszAGEGKI7Zlr/zr4LHhCy5IXxgb3Spf3WRa8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdqzLYlm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D8BC116D0;
	Tue, 24 Feb 2026 11:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931999;
	bh=Cv+ro0rgKKTNndu1LXkpKQFAsbhVDrLwsjlr+g88uog=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HdqzLYlmRb3TVe2hLfyaAeT0QbXfs78M3TRb3E0NDn89wwEK4fRY5WmX/jrbvQDL1
	 5efYY+T10vBU1kIR5uTfVO3tiDrUgzG3MA9Lrwtrwz4HKPEbbPB8bDxQMstX90wLNe
	 7/caSsxNgBpZvhZeSictKOSRKfaRaTFAzeDwXGE31oo+tEmVF9c+kKOlzDasQD/O/g
	 Df5fKMfSAXTsGZ4+ZBGt1VgcrMx5lTp1WYHN1ovyzgjrqrFdWR6h/nW9T9Pwkz4Uzs
	 +Ypjx0M41BhOmxFpplST2zMxs7sA+EpkwwuD0XjHB8jvF8sgOKiS/IjVU2yAdOvgPp
	 l2F1QjiQtEcHA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:18:00 +0100
Subject: [PATCH v16 05/10] rust: aref: update formatting of use statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-5-c21afcb118d3@kernel.org>
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
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=753; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=Cv+ro0rgKKTNndu1LXkpKQFAsbhVDrLwsjlr+g88uog=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj3SgJinL4mzNCGJB/VLOiKjYIotpZTAeQ5d
 eiujQ/x9mmJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I9wAKCRDhuBo+eShj
 d3ysD/0XSb30S75V7XwmTKiRWjUL3YRT0n+cqNFGirejC2hDTAlc45ifHqn5BqDHPpxlN4259sn
 JL858hlbzJzoatv7LAvF11urCZjNWN6J+hdE6QOW4BHuyJ2yLNgGV676GOzDcToOmfPOKBOgNav
 tClWhpadwI3oyrs+v8v+kuwlOCEl+P2GCkpjQ6T8UsDk36ZDMF37vBtR1JG1J/hUUx0ZWQzewXq
 rUs0v6+QsxeaIe0GKCi4tT5p7avyJU1e7T0WAorLYzLb4jidXod3lnSQxQqZosDciGhCkn2iUpf
 Kp2xH+AWuSEyVLUdMOUp6pAc4hS3QfB05dKeQCbTXd7XTaF98QhLuW9F1R1JDwk5lzrl/n6ifHW
 a4iHIRVLfU6EleuG6f5MBh8/SKyj+faoS9mKgJbkfoD4kW8Hr8YRBrKrsFqsDE/2lKCzUudOupA
 oFpnOowIQqCm7iXRyVGnIxaKDMd+HqJ6KhuH1QJDojEgMZsLHZrpLcQYKAETyk0MOR2xhCmSmpN
 OMxoqfGwnO8Xwzk7fNHWAXezkISwJ6wFPmkG4Wb2vz6E0QPkHEtAjA6pNZwjtmarcSBnlX3axhb
 h1srotfFPhfGHOeu86lBShAiJD4EDSb9IoWPjgEh4imYv7anzzgS1wA5qJtX6rSLm9DxpJHzFfy
 Pqz7QVN5g1wyAIA==
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
	TAGGED_FROM(0.00)[bounces-78250-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[42];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a.hindborg@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BB79B186243
X-Rspamd-Action: no action

Update formatting if use statements in preparation for next commit.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/sync/aref.rs | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
index 76deab0cb225e..8c23662a7e6a1 100644
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



