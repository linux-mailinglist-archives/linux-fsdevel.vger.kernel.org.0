Return-Path: <linux-fsdevel+bounces-77779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMpYOAYvmGlaCQMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:10 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C723516677E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4698A30185E6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4138336EC3;
	Fri, 20 Feb 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPkoJgHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EF131D36B;
	Fri, 20 Feb 2026 09:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771581158; cv=none; b=PVv1MFrmhoLCPAySm8Hccbs6fV/qS2mhK9TD2NM5bhoa7oGWu0P8KdnHDrWjED1ihjXJqumMcV6tR6mr9wjReCMN0yYkrsGqOHYCrDzBfOQ84meGsBk4bi+b9goUQWmoMdpvr9sO0wCHEIvOUcB/zXqg9NHgKJ6u8sVgesJYQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771581158; c=relaxed/simple;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MegYNEdIWg8ck5duvli9r8oC9OWVnzg7AXPvqs2YU5XAP0LL5RCt/Ar/9uPWHlD87r9LnIrZWcyFJPIZ5qCVbhHcaVay+rvjWKDx5H32kziTSSr75Np4KSg+kCKDmhIQDJC/lgK1fPbt5z9wryPlRYMOkfrEuOVZH4Az+y42K5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPkoJgHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1BCC116C6;
	Fri, 20 Feb 2026 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771581158;
	bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cPkoJgHzjTOK4adLqKvtWOk0lV5xxjHFhFd25u0lCbutgaak9HaBvj5iIti9G5zzW
	 t5vdRzwJCLIKRG+RRSwnAgaRKFt8OQCM5Bsl53NinxBG8sVCTF4QNaeLdH9UxPUy38
	 SnApW6PeCr6R83MsQ4DvuDxOcpHt19YUEVb8MoxXaiN0eIPQECQ/Mvy2ooVEw6Susy
	 EaQEmFLvxd1MwRXs2wqSCWeHSLIcYvdOQxH7HmLfJLbN8RM7dhkJKZWm6wOC3jReXI
	 d2uxnfQYxQPohdutcdThilJmAB86H/L0DvpS2d8rLyBBWYMWfuezR7qHlVEqzMZcsA
	 g8ACwDxkQlGnQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Fri, 20 Feb 2026 10:51:15 +0100
Subject: [PATCH v15 6/9] rust: page: update formatting of `use` statements
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-unique-ref-v15-6-893ed86b06cc@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=a.hindborg@kernel.org;
 h=from:subject:message-id; bh=TzCUGpEDUTKD6tcoKokHDlQAGVLw4XXksTwjbV99rHQ=;
 b=owEBbQKS/ZANAwAKAeG4Gj55KGN3AcsmYgBpmC6j7xMqrOaWhqb9sz3GGfZ0fqISUkN5QKA93
 RZup+H7tAiJAjMEAAEKAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaZguowAKCRDhuBo+eShj
 d0DZD/0dTBrrqUbBOcxFA2tD+zDIiI+fVqhQyXpWOHZTJ14cd+6Va4NBWr4jjedyZ060dAaM1sA
 Femvxpu86flN8RTIjT1fu/C1Xs2xhYXBJFk5pYbKzIzYG18wMgunFXxKnF8fzwQj5Q55A0x6dSX
 d4sn/PolHwlhr/GJeDpRZbrCiypzkXj4a4yuOdjQNdooFyEfvj+8NbUSFgbidam5i/qUWNQCy2d
 5iGDU7RejE+DaQPyVc7RRenEMGW0GkVZqQIEcFj4QpDcCqUBduVmeMKJTAq4Hey9md/SCJ1RiPu
 CYiacAclAAKm9n0ybuxbdSJxi0PTvf+fzWIA6n95kw67kRWiUY8YtQvAd+IN3vL64EW5L1uib+H
 RyPos2pTret4c2ZrRxYKFRRWWTZpDs2Ar6HDMojnmuJ+5+74601NEJqBPN9Xk0AYTrR2TglyTjd
 Z/2T9Aex4ZOhAl3GsayG4AEAIJ14DcEej1m+GxHfGKpvmAU4FjhP2JkEKPlWbTdmeZO702b17nw
 ZBIdWaLXJx3pPL4ZrTHqGfdpWlSYag7OkRTNCKhDn0JGyNU85S3MWU7JwuBf0oStMiFrR352hs3
 eH+ufisPMWgHK5PriCQ5BN9Wrjq/QaF7Y/kQaK5SfsooyRg3R42rIYY7jf5WnRUHCZCREvdgm5P
 RQI1LGOLLZoKTjw==
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
	TAGGED_FROM(0.00)[bounces-77779-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,linuxfoundation.org,intel.com,paul-moore.com,gmail.com,ffwll.ch,zeniv.linux.org.uk,suse.cz,collabora.com,oracle.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[40];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C723516677E
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



