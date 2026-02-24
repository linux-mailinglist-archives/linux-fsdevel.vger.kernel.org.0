Return-Path: <linux-fsdevel+bounces-78244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULoWB6iJnWnBQQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:21:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E2D1861A7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 12:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 049E7319FB61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6203A37C107;
	Tue, 24 Feb 2026 11:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOu8qMmm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCC737BE83;
	Tue, 24 Feb 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771931941; cv=none; b=t5o8OaIDKMXLEBCMp1wNSkRy6kzU11k4Xg8hL8gpeYAlowMjfmfk1DZYiA6RsFiHrBkgTj8Ly4AANeKNG77YKQ0kes2CjNdrz2vIqNEEHZjQHiOsVAWDSQ1lGihpO0uZ8IpxThapQ3BaP34iN07CZMtbU2AMBMDA4Gxu6Op3H3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771931941; c=relaxed/simple;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC4xSsnQLuZhNraIQxkolHaQLFuNCzjK462fNet7Fck8P6tBY6Q9uOzOh26IlOss5jBtGbI7O3n0/LXCdDiPVS9m/FXSQKMveSuggMofcN1kOdq/qtC8os+11cmG0O1Y9cbMIi9vlewaJdWJBpetGnDvPu4UxkCF30y8ndgfPsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOu8qMmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB733C116D0;
	Tue, 24 Feb 2026 11:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771931941;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MOu8qMmmrykyBB4CVhwqsAo8Gs8bS7U6AafB15auu2pLImpGtcvmUXOPslyfKs2el
	 cA6Tgr0KiCNDlclglU7X5nBYMurMj/c4b5jgIPllHvoz8I5zv55L8nL/QYuioiqNz0
	 bFHwNBCzqEwNzza99Dotcw3hy2WSMt1k4v0Nu1ObFnuzzPCJTaZJR09VKnQPVNu0Ie
	 YiaCR0DXwqb5L1MTAH33VJOtane4KNMsI/15XTFxxb0XWg50vHeumHbafF+RW87C0o
	 zS7G0Yc9SFTSe1i5chVbdD//SENR7XS47MSpwMtFs06smyoMu66VTyAuEoDPiztBuc
	 FG8EIBIcIDBog==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Tue, 24 Feb 2026 12:18:02 +0100
Subject: [PATCH v16 07/10] rust: page: update formatting of `use`
 statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260224-unique-ref-v16-7-c21afcb118d3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpnYj5ytywbjKxCmfhmUDrIuCRIXch3CamTuuGv
 j824oj6dJyJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZ2I+QAKCRDhuBo+eShj
 d33LD/4tIWyZ+fNIywG0iGTvb2DorpPWbOHBNN9ywRijqdgN4kCYPMclfyWq5jb0IYw6fO5XvGS
 n3w8ZMsfLfCWPUxLJdLXezRidEemIyeulj0g1sXIMUJtJCTE5KGLt1cF2TlmAqfIGDb1Hxva9+n
 a17hvt6TxHT6vtxd6YhnJcIRECoOoIi6t163hqhNU+3Hy46/GrL+c+nTkA/ZlnfxLgaXP1+VGB7
 I5d4mn9T5xF6HdI3RAI44jmR25J4E5AypWhSJtFg83rD1WbnwAcDa+Ow11Emd7UpvLdl7IYKorJ
 VNJ5BCcmWvA7Uv5SbU6NqZ46lpaYD0303kqPl4SzHPc9ZgGpj1itJTcAZZg+7N11zMJ6N5UNtgL
 55lUMrNsD4c2ho5ywzGrZm+g8TjNVjqpCx+CcfiRj100RVyVJxpUoJsKKhElKn7CNCCvKJQk37C
 ckI1Utyd486+FYBxr0xjySMGhSl+kuUkGVSs7o4WGXtaGlBup26dnSeAkV0hwb7PIJTnVEqhNG9
 kkzffHhBC7rgSMVm/7JPpUvyMDnshDU2+oBO08eew7B5Exm7GXhrbIxkwxtnS8isIL6D8vMXvdR
 1M7UgSTMkNpZejv8PvjASBdsv1PFNoFB4h/GbJw5gpvV2ud0ebXXQu7h+wVO6KP4Jt9TmyvfoVj
 JnTkk1uh31vgExw==
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
	TAGGED_FROM(0.00)[bounces-78244-lists,linux-fsdevel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74E2D1861A7
X-Rspamd-Action: no action

Update formatting in preparation for next patch

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/page.rs | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
index 432fc0297d4a8..bf3bed7e2d3fe 100644
--- a/rust/kernel/page.rs
+++ b/rust/kernel/page.rs
@@ -3,17 +3,23 @@
 //! Kernel page allocation and management.
 
 use crate::{
-    alloc::{AllocError, Flags},
+    alloc::{
+        AllocError,
+        Flags, //
+    },
     bindings,
     error::code::*,
     error::Result,
-    uaccess::UserSliceReader,
+    uaccess::UserSliceReader, //
 };
 use core::{
     marker::PhantomData,
     mem::ManuallyDrop,
     ops::Deref,
-    ptr::{self, NonNull},
+    ptr::{
+        self,
+        NonNull, //
+    }, //
 };
 
 /// A bitwise shift for the page size.

-- 
2.51.2



