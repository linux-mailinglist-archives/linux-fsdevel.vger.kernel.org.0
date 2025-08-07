Return-Path: <linux-fsdevel+bounces-57011-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E6CB1DCB6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 19:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404A61AA01D5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Aug 2025 17:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B15E217F53;
	Thu,  7 Aug 2025 17:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="yXdzj7D+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CCF20FA81;
	Thu,  7 Aug 2025 17:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754589329; cv=none; b=Gb9pJWb9xMk80nCQoDG2i5M2TzlGttMb6nuvd9Udx2NTMjMJrcZYg2k8/cRVZIQZrZ5wAvNYwQf3kOAQkusONMDw/zKZ1ye8uT5N6FC8vcNW+6MnTp1ffJZMKtOQQX98bGb1rcdhdKHqdONqTVsshKPfyPiS+6zHKcJOA7do5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754589329; c=relaxed/simple;
	bh=+QEWGiv8l3M9oIgqLkQar3zS6Rw1OmQ/brz3Qfd/Yrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dP3zOq4+pB6Oi7mH6pKSAGYqOUmK8zAOEgLjtsh+SjAVygAa44Gb83WR0x4ez20aYLYCFn6TntXCPbBnncZ9NVUOkiXoxzDCtnLSzuyiEswV8FdfVzlIRhNwF+EQYjVVEdW6o6crB8J87uAEqo67F8LcpH4XSTOvSxZc6dEKJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=yXdzj7D+; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4byZZN5Nktz9v57;
	Thu,  7 Aug 2025 19:55:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754589324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nPSe3q1UuRjtf3920YQVGD4OWn8ImFqh4BUQwMIGXI0=;
	b=yXdzj7D+sAxFwYInSiwH+14/NiRE+zS49hZ7KnrZzsO6Lu8nM93ESIFkZ5PtHZ7z4UbFIf
	ep58MO9GMfc+hta9DXtWtqwiTL/CkF5fGjwjLL8yjMzLdJ+u7IAL05dcF4RzpfpDIF2Qve
	tpvOyK5AZRS7Z1VPCsSBxpyw8Lvd4oNXwKoHO+7p8NFXtb/CKQNDLAreGmuInR3XUnR7TX
	0oUgLSeAmICEYS5b3dpzBMuoXUKnW8RYw07efjCV/xhjKSHj1aumQhExG8TK+MmniHTCP6
	w14MLygUKbclW2UtYZI1zWDme2+QAT8rSIjdaasiy5Io43sB0kz2kgFX2VSEXg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 08 Aug 2025 03:55:05 +1000
Subject: [PATCH 1/2] open_tree_attr: do not allow id-mapping changes
 without OPEN_TREE_CLONE
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-open_tree_attr-bugfix-idmap-v1-1-0ec7bc05646c@cyphar.com>
References: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
In-Reply-To: <20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1615; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=+QEWGiv8l3M9oIgqLkQar3zS6Rw1OmQ/brz3Qfd/Yrs=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMedHwvNGssHHBrlPZrt99mEo6Io10HjtvZPDTkn14K
 aNj740/HaUsDGJcDLJiiizb/DxDN81ffCX500o2mDmsTCBDGLg4BWAiMQsZGc5u3fKnK2Zu7JL4
 SdsZvpvEPjzEzWVXpb6bhXGijpxxkjjD/2i73R8rNhseDt2U+Sbv1Vr+bLMrlpbasQwzFzfqf73
 ZwgoA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4byZZN5Nktz9v57

As described in commit 7a54947e727b ('Merge patch series "fs: allow
changing idmappings"'), open_tree_attr(2) was necessary in order to
allow for a detached mount to be created and have its idmappings changed
without the risk of any racing threads operating on it. For this reason,
mount_setattr(2) still does not allow for id-mappings to be changed.

However, there was a bug in commit 2462651ffa76 ("fs: allow changing
idmappings") which allowed users to bypass this restriction by calling
open_tree_attr(2) *without* OPEN_TREE_CLONE.

can_idmap_mount() prevented this bug from allowing an attached
mountpoint's id-mapping from being modified (thanks to an is_anon_ns()
check), but this still allows for detached (but visible) mounts to have
their be id-mapping changed. This risks the same UAF and locking issues
as described in the merge commit, and was likely unintentional.

Fixes: 2462651ffa76 ("fs: allow changing idmappings")
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 55f28cebbe7d..196a7873897b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -5302,7 +5302,8 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 		int ret;
 		struct mount_kattr kattr = {};
 
-		kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
+		if (flags & OPEN_TREE_CLONE)
+			kattr.kflags = MOUNT_KATTR_IDMAP_REPLACE;
 		if (flags & AT_RECURSIVE)
 			kattr.kflags |= MOUNT_KATTR_RECURSE;
 

-- 
2.50.1


