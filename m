Return-Path: <linux-fsdevel+bounces-58779-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DFB31691
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 13:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B4C1C8217A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 11:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110442FABF5;
	Fri, 22 Aug 2025 11:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="YfL982FM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00052F1FDC;
	Fri, 22 Aug 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755863058; cv=pass; b=WItlJ/nM8kdVN3jpZnPF2KlIiwm32oq2CgFp+gTMtXXynopZ7U7bgnIk3WF7XVzJ7A3C0ZyJHzMoxsir05xk0NSUW/X8nAtbBXfHuxqH4UXxfosAYUx7qGXTtP/abTOnmRumHlkEvzPnIeXPd2O/hA1Osz+9zJBtJUTwzpdD2us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755863058; c=relaxed/simple;
	bh=Ah05NbakYnTrH9sUyf5i5B971J3wLz/LDdLfKhHC9ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAxY66Sh/E1D/5/yd+w/ZUCuXf6D8dmUOQ3Eja3jNuVpyKe84oxkOdlSuEmH9+FW9l2Kz36VIJjhu3k9kZkfCTX+a//2MtdCIA8LnPAMV5At7ENTCkkQkNu67WCMg63SVkH3znficym/0RKNAupBsJuKNHhTIkhiOsweZye4VHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=YfL982FM; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1755863011; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bZwi6x/eDPPA9CJfJ5kHvfnnli5V8M/P4qlScxRPCna8w93iRiRvLompd4IF9EJrCKha1ky+ZCiHWxgx1+2lZuCgTBbGyvVhdg18LxLWWju2vmRlexsiS3u0CiMz9aeKodJLR8Sh3fBC8T1hzr99ZQq3Ga04x90wWaX7Sc250f4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755863011; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=84gsaoAK59zwHk6lsn8hH1pS6rz9CnXQioYvr8hDPQQ=; 
	b=mhXkklC5n3jeFnc5TrPqmlFAkX6nZRJGsh5I6PEt9DpXK40B3L/qOzDV38xqAnvXtkeDZ8ynIdngI+FH+4h3OBamFg7tVUwr/nobkL5tWU9RvLxBQPuwDLahGMsgn+30NfTfsumTFhYKUA/kTtQMKb0JfPKp7CPghmPvH4vJpGk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755863011;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=84gsaoAK59zwHk6lsn8hH1pS6rz9CnXQioYvr8hDPQQ=;
	b=YfL982FMWqxgjUBAs+6XDMnTu6xvPei26eOTspAY0e4InwNqxmKdIyUJFwkmPuxm
	e2qWnaOo0rU61WYF2mG9OFDJx3s4GvheH3BbOaul4ZGnkoGZ3l8aaaF2FjciMd2lGdr
	sqrL5kdH+yVYWc3eYABE0eO/J6qzNPWcMbn1OMEY=
Received: by mx.zohomail.com with SMTPS id 1755863010337997.0412095639103;
	Fri, 22 Aug 2025 04:43:30 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Fri, 22 Aug 2025 11:43:15 +0000
Message-ID: <20250822114315.1571537-2-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822114315.1571537-1-safinaskar@zohomail.com>
References: <20250822114315.1571537-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112275ae4d4e853c16de646e5679b000072d7a300cf7391adbfe813e6eb576b6240afc0233cb4423a01:zu080112270dc3158680bb886a1e8a2635000063b2f5b47f1fee1b6883707a61af0ea53a093facba6845128a:rf0801122c765b5f6308ea7505a3e406c40000e4133be3fd3520c8e3429379ad33741f20e2e1db96d7f26b55ac28d926fd:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 man/man2/mount.2 | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/man/man2/mount.2 b/man/man2/mount.2
index 5d83231f9..909b82e88 100644
--- a/man/man2/mount.2
+++ b/man/man2/mount.2
@@ -405,7 +405,19 @@ flag can be used with
 to modify only the per-mount-point flags.
 .\" See https://lwn.net/Articles/281157/
 This is particularly useful for setting or clearing the "read-only"
-flag on a mount without changing the underlying filesystem.
+flag on a mount without changing flags of the underlying filesystem.
+The
+.I data
+argument is ignored if
+.B MS_REMOUNT
+and
+.B MS_BIND
+are specified.
+The
+.I mountflags
+should specify existing per-mount-point flags,
+except for those parameters
+that are deliberately changed.
 Specifying
 .I mountflags
 as:
@@ -416,8 +428,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
 .EE
 .in
 .P
-will make access through this mountpoint read-only, without affecting
-other mounts.
+will make access through this mountpoint read-only
+(and clear all other per-mount-point flags),
+without affecting
+other mounts
+of this filesystem.
 .\"
 .SS Creating a bind mount
 If
-- 
2.47.2


