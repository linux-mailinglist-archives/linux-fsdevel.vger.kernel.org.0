Return-Path: <linux-fsdevel+bounces-59173-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3272B3571C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D5D118869DB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD492FE04B;
	Tue, 26 Aug 2025 08:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="O3QIqkh2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761AE2FD1D4;
	Tue, 26 Aug 2025 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197251; cv=pass; b=Z6mt+tJ1Op6fjSWi35KT+rgte6zxSuZnFRzP/7pngOTWZvldeFG50LdPnqHZ31yJi8O+pbIQnhPm7ZcPkMv/suofsDWT2YmYq/onHI8PcFINAYb0UGXNXROCwADRl07T2EZbWW9t4OkfeWxhOFo9mITinUNHVrmDZUiCYBAe2uE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197251; c=relaxed/simple;
	bh=q4ndzyxhUF5l6fPbvd/AKCAzACcm2t6u5pKtM+BhrqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgtwWPlIzi6p7b/9/Vu51J2KB2DyDE1p2440RlT+Oyig/uqL+hp95ta6MQ8DPRNO6xzTsebs8cm8vCsqKk/liY/wmyjASto3dFw2UtMGBxYFdSbZXCPj9FAKim6kEr9ao1pyTIQzt5EUcf9jVCOrCXSJmXpOrr1t17fR+AcqEHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=O3QIqkh2; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756197164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=c5iDnGgD9+Yij/CbhwUDOL34Sh5md8sbkWKqEOYXYmdWtlnPPyxe5SFQJgkUp9jKjZ14NGF3xeqKRfczHlpnXUzIK/IsiT8df4Cv+O1AmQ1KqX0eAf+C4u8tK2vIr7F5NOqJbFS+6MJfl7K6Vk4JMip8cRW8JoYGy6+GDTlTIxQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756197164; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EEReEOpUYg547M91X3wRzQRlEZq+oZLdpK1o/kGAzug=; 
	b=AqHJAQ0amlVmGNeMGZYxgQ5ApZDVQ+w1kGqakxSQjA3cpyz6B0BTWz2bgBRsqWXJvBhKygHipVcq10XLy5d2VQLwDjDz0fQhcHxpo71JYQBo02PVrp7yLjYxLLoBCJsovRzfJkQ7fHzUXwLXKrMYKIlDK1mNRJtjNeiIh/Q0hQA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756197164;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=EEReEOpUYg547M91X3wRzQRlEZq+oZLdpK1o/kGAzug=;
	b=O3QIqkh2fQUlea/KDdhPXVPCQkj9SnIlrfLnxUldbxw9tacGdLF0Z4DaSok7aLoi
	wMIpPhvWvAjx05x41xjR7DwyH3X+kqCI+vZof9JKI+NcpRM5fm2CG1J9VW6vMMzDmFG
	ucphGKQMUl+VwGAlqmmuoLHjBg4e+btfDEeyTquk=
Received: by mx.zohomail.com with SMTPS id 1756197162197929.6548697975837;
	Tue, 26 Aug 2025 01:32:42 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH v3 2/2] man2/mount.2: tfix (mountpoint => mount point)
Date: Tue, 26 Aug 2025 08:32:27 +0000
Message-ID: <20250826083227.2611457-3-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250826083227.2611457-1-safinaskar@zohomail.com>
References: <20250826083227.2611457-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227b476ff446254aef2d516f48a0000372540d6e8e2f47e9f8d09fc79b4dc300d634acf0c5d372aa6:zu0801122712f96c9bfac7724a94a052560000029a61fa85bcb02c56943ab6f71bc0b7e2af77e58b028070c5:rf0801122c6b2bf042b6ad5c0979fb0ace0000d8e4daed34ef493133763b34d1acb8dd6ded1a4e805d00303251bb19b37e:ZohoMail
X-ZohoMailClient: External

Here we fix the only remaining mention of "mountpoint"
in all man pages

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 man/man2/mount.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man2/mount.2 b/man/man2/mount.2
index 599c2d6fa..9b11fff51 100644
--- a/man/man2/mount.2
+++ b/man/man2/mount.2
@@ -311,7 +311,7 @@ Since Linux 2.6.16,
 can be set or cleared on a per-mount-point basis as well as on
 the underlying filesystem superblock.
 The mounted filesystem will be writable only if neither the filesystem
-nor the mountpoint are flagged as read-only.
+nor the mount point are flagged as read-only.
 .\"
 .SS Remounting an existing mount
 An existing mount may be remounted by specifying
-- 
2.47.2


