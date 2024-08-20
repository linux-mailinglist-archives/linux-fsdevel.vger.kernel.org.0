Return-Path: <linux-fsdevel+bounces-26401-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 764CB958ED5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 21:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F9B51F23149
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 19:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCFE615B999;
	Tue, 20 Aug 2024 19:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QojfYDyN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4818C1547F5
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 19:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724183504; cv=none; b=uta1t3z9wK7u/ZpPT1rHNwneOt76zqRTEreoNZkTbXtfcP1kP3iq3wjTlHKaLZ/8r52ckD8pM7XMF8MT8URZzUxro83bN1rmjl6G//Ey9maBYhKFhm4tKQbID4nUO6pYNO/O8QcQHOFO+dcuzzrydC14zLJicoVmZC5BZU7jVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724183504; c=relaxed/simple;
	bh=NcfeFMlgLdBbWeSO1ryIVSNaOeXNiF992WJWr8bT0vw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BSY4ljtXtpdaRdoL8bny59r4u5kOC9MYQDjfcQzIrs1TV8owBrOiQAiytiUIB5o31fU5gCnQwjShx/QJ/mA/T+TzmX2l7gXZSMZCgpZBMJjF2jVE2CihCYtu4Zsi4qNUb+dEijXrCAC/MxASJLBaCB8OtZY0237fqCG2Tmpf424=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QojfYDyN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C793C4AF0C;
	Tue, 20 Aug 2024 19:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724183503;
	bh=NcfeFMlgLdBbWeSO1ryIVSNaOeXNiF992WJWr8bT0vw=;
	h=From:To:Cc:Subject:Date:From;
	b=QojfYDyNzXQujOWF1FzJGikf9/e3+IyuZoj70zA35Yg3FUPwchm0xBa7AXY7WZS6V
	 WrIDKxor4xB58svxXLeGQ38wNAJx/PeD/XBZp9QkvVKIkVaRgKzWnh7Qm83koDF5at
	 ZxCu+6GZOfMEyauJ6G/p9IstbRz64RS/vvyGksWq5jGZO5XRr+PXttSCnV0l1r2Urw
	 nM//YkzcfnIuofbQ39ZkvuGXcYPQuvwo6JDiWZFQAwf4BsZAKiXnnT4lFf86Ma4h0p
	 gCX2mFcPC2EylzAj+Y7a62X4M7H1ol5+/IMUcFtTJEGMDFX0wA2fT8lDuaLTLe4z6L
	 Dio3En5OL0kAQ==
From: Eric Biggers <ebiggers@kernel.org>
To: Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] MAINTAINERS: add the VFS git tree
Date: Tue, 20 Aug 2024 12:51:09 -0700
Message-ID: <20240820195109.38906-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

The VFS git tree is missing from MAINTAINERS.  Add it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..c63e588e87dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8595,10 +8595,11 @@ FILESYSTEMS (VFS and infrastructure)
 M:	Alexander Viro <viro@zeniv.linux.org.uk>
 M:	Christian Brauner <brauner@kernel.org>
 R:	Jan Kara <jack@suse.cz>
 L:	linux-fsdevel@vger.kernel.org
 S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
 F:	fs/*
 F:	include/linux/fs.h
 F:	include/linux/fs_types.h
 F:	include/uapi/linux/fs.h
 F:	include/uapi/linux/openat2.h

base-commit: 521b1e7f4cf0b05a47995b103596978224b380a8
-- 
2.46.0


