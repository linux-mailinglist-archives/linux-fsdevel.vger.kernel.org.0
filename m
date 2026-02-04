Return-Path: <linux-fsdevel+bounces-76305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDXnEP00g2kwjAMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:01:01 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 97020E5769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 04 Feb 2026 13:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 180F4307CE97
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Feb 2026 11:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FCE3ECBE8;
	Wed,  4 Feb 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1z4hd8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B46538E5FC;
	Wed,  4 Feb 2026 11:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770206249; cv=none; b=oUr+EIuronQ7tl5+xiO/PCQ5fUd6HfRZeW/A2k5bBYoF7+d1rX2lzdB+L7nVCdGx1ZVvIKfeSNQfeQ1HmnLLisRSr++Dm1Atgus0qcc6Y7GJkn3a+jD2sfgbp0Qbg3Yy3gwher9D/3Z8u5KHp06eN9QfK+xGOXqCjak6jm0dApk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770206249; c=relaxed/simple;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l5b9Vc6tZrcllckWGpcEhB5AKdBbqzduq4N4mOwKjIxcAXYH/gUOOeXoFX9VRLPZIB5zoMrW6y1D9BXCyILopJs87F/djGS2o60pUH0bh+hZ9ProAvZU0zHjDLYklAX7u1tDhHtyg0inqPGH40FMqMw0QE26G/AG+MCLwkm5uFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1z4hd8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FA58C4CEF7;
	Wed,  4 Feb 2026 11:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770206248;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U1z4hd8I9kQJXi+itfVCtBC/FJtdo2Xi6Hj5LG7Il46OSLQ5DO7odXAJQzuiGUVB9
	 y66NQAOTu/0zTht1ZG+1+0xfQrb/FK8Gsvg2u8K4nXwCMmruBdMryWUVu/Ke1V9Kme
	 3t7qGdIVVtqWomrqTvfYzqPT1NpmCR4sPkUGH6HvdVqjIk1X/N89RXCKtnM0k7mLbu
	 sX++DsdP+7oU5+XkQltsUCTzmKerLx0o2DlPZbfS7stbQAuWIXAtEyOpD3b8urHWos
	 KB4CPi0IHJOMEDpygqIycM4kw+hSQgpH6l7SEQfDfbr1G1BV0FuK/cLeeocfaR5MZ7
	 5Ij8FiV9mwLpg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Wed, 04 Feb 2026 12:56:50 +0100
Subject: [PATCH v14 6/9] rust: page: update formatting of `use` statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-unique-ref-v14-6-17cb29ebacbb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpgzQEkl7+qS/pt2PP2yRFmTxhtfnLZn6ju1Ow3
 d+rvWLm0O+JAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaYM0BAAKCRDhuBo+eShj
 d5BSEACm0N3lVUujUIiTwHFQB9gQm6GbVAkcN4LYjjgO1GeYPWWOvf27M0+aa9z0nRKy+7M65UF
 Giz1RqgkzOM314neS17zLgsDjdI5kPPOTMhK/GyJNpIEhrH6rXqlNCzGkWMgujQlfxFKs+BAVLy
 6OzWhYe0fDuOge2p1iSf0E1tqd5QMkCkNqnT0AqykgZM1sqpfxxRLzuCiQpz9Aw06yTAHBxPZnG
 a0A/TtIqMGW/LoOzictWoS0XkKAsUWJD1tiRv3lyUT4Oo5kIq23hhauCPm7zNteDMtvG+cE9nuc
 /ZmLqafExr2i73qSNPiFE9VBc4l/BXtD1oOItFhBGkPO+wUMlOO49i0SEnnFl5tZWOWnAHK0vmq
 bdGHaHK2iwk0OOJwNzZApHaR0REnw2aaXj6jhZ3zdQeWXrrBUw55EqQ+GRE28fNjAws0TRwaZP6
 vK+HxGW8/oXsfZCQZqaLtANQH78uVaje6mQ0LnZhMwGL8idzhD/CIUyqC3KINhmexm082Wf7zt3
 js8NmNvlM7UqPBkJl3xQqIuWarXHarAW6DoQGIO8NxY1TD6Om8raMLIVuhHd4jGgeywzV6/p/To
 tJ8hg2aQqagFEHO/Hv/BUMeEn4bWIUfZIzCpOaweXuqqv+SUZFAwm4tcP/0YoMDaoNQv9XqPYrx
 l2xeXy/luHQB1TQ==
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
	TAGGED_FROM(0.00)[bounces-76305-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[39];
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
X-Rspamd-Queue-Id: 97020E5769
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



