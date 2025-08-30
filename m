Return-Path: <linux-fsdevel+bounces-59699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E976FB3C7C5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 06:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D14C5E744F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Aug 2025 04:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE06277C9B;
	Sat, 30 Aug 2025 04:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="m3XAC7J8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward203a.mail.yandex.net (forward203a.mail.yandex.net [178.154.239.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0017D128395;
	Sat, 30 Aug 2025 04:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756526951; cv=none; b=Jrz/hzl5pDKWkZDzwrCLSYmu5kPVa7QhHzXWxRI8DncZClhiaE5KKrzMlG7nGzFydO+tSYKcZ6IzH+eObvCmguQEP4Pvi1nbf5sqECmnX/+Qdrv9qcWwMtpfoXHP7qCM/7r10M5M7EapzcPHgt291mrl3BJuEO6J0XVkOwY0Khc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756526951; c=relaxed/simple;
	bh=tXVBuMBRsn31FgFFbnfzGu6YLCNh6ILOFZfEm70i4LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g6L3C7XGKrbtqEmXj4sGtp5rs4nkMlEMJiYYOZ/0nvWBQd2PoH++39FS2n0Tt6wiMZ3Ch2JxKechAIbG6W4ElPScWws6io/EJJ0SrfxQbHeiTgm6fG3HJoSosPH+QNdjdfQ+PlLWIEmTx1jo3aQXxptzmEqt29bi7o99HF/VurU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=m3XAC7J8; arc=none smtp.client-ip=178.154.239.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d103])
	by forward203a.mail.yandex.net (Yandex) with ESMTPS id 3634784EC4;
	Sat, 30 Aug 2025 07:02:28 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:1301:0:640:3ccf:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id B0D9B8061B;
	Sat, 30 Aug 2025 07:02:19 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 02T5I54MOqM0-accypsTC;
	Sat, 30 Aug 2025 07:02:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1756526538;
	bh=vXdsUvHvBuZ7rwjKMn5ZXTnSa05JJTbcKQsxVBjhv08=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=m3XAC7J8K2+BV3ogVhSaY7rfQKe2mzcGY1GHEP40ThgoZGD/S9baFoQSjresWI3HI
	 FPDV5mlOUxg//G7yqPNs20J5Ht/SFbL9XM7CujCv3v80a1dXxiPqJn9SmHg3e8+LyM
	 O5ymk+Pt5wM5RIGYY/J+Rs2sj6ebLpV7rJYLjvGI=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] rust: file: fix build error
Date: Sat, 30 Aug 2025 07:01:59 +0300
Message-ID: <20250830040159.25214-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixes an obvious error most likely caused while
resolving a merge conflict from other patches.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508291740.MyzqNwyg-lkp@intel.com/
Signed-off-by: Onur Özkan <work@onurozkan.dev>
---
 rust/kernel/fs/file.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/kernel/fs/file.rs b/rust/kernel/fs/file.rs
index f9cf6239916a..f1a3fa698745 100644
--- a/rust/kernel/fs/file.rs
+++ b/rust/kernel/fs/file.rs
@@ -10,7 +10,7 @@
 use crate::{
     bindings,
     cred::Credential,
-    error::{code::*, Error, Result},
+    error::{code::*, to_result, Error, Result},
     sync::aref::{ARef, AlwaysRefCounted},
     types::{NotThreadSafe, Opaque},
 };
--
2.50.0


