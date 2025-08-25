Return-Path: <linux-fsdevel+bounces-59095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D9B34648
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61C9D3A3656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 15:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3A22FC008;
	Mon, 25 Aug 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="M7zvo4UJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F8128507F;
	Mon, 25 Aug 2025 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756136988; cv=pass; b=ds6nvzP64z9YFMjApeIwo53asKd1iwi2NF0zJVV9fEeGCm4dfHkteYwov6Pc+ocg6x6DqpbOYH66GCM2P6JHswnp1ZwuZ61AZWERpNwYm1Ld0QrRr8A8dChXGvcwNDLXfmaJRtbqgXf2kFEuD4GAOj8vu471ZQKinmymJhwuFqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756136988; c=relaxed/simple;
	bh=I+q1BthxYCk8fgELwI4xkFWQWOTltTq/SzZ3t96PRlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ODSJBEcpec5lB6an5gCm5lo0CZrgXZ/UeikzGJJ0yR/gTe5kE9Iy1nmYUOSBp4K6qeuvOrpBy5OdoB5k5Y8Dy8P7GTJp7R7sLkWMOVt8aqtzJv2Dz96AQEKHFL7UMDJahTRg9jUlXpw224eIhAEbd5xSfZXRo74x2D6qee7QQ1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=M7zvo4UJ; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756136938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ie+n+ZdNIFMSL3ga44UVMraww8zW9ehGjuHX1jCTNShkG9ey13mrkR0kLhG2h3nzxpJg66SmEgeuvM1O5JTL/5Gm0xpcjAuKZmUwQo4KLjtBlSAe40Im84jKhGRn6KQhB1ScEtRmRhSsU5WrcsTbaLvyd/Ya5ER87P2htU1byGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756136938; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UPV8+E4P3p9RhFaxu0y3FWNJCHVVwszDOOXCHLEHtos=; 
	b=npcqi3Xd/kehHHW1QtIKstDfmSX7TyfxCEQuz0nMc882g8c+uv/KAKDlYGM+o/Xd6eZJn0rAW9gOCMANcN4f5sz2/5Ui8Ib3dDERMWY7UpUIZauyKA02of0CMBDlNJ7vkizmGWFO9Lobz3kpQX5A9qPjukCIgRHKapUgWmsb50k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756136938;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=UPV8+E4P3p9RhFaxu0y3FWNJCHVVwszDOOXCHLEHtos=;
	b=M7zvo4UJB+0A1pMR3y4hiL+6FN+uwfzo+oDyillAhAmSQw85D71hJ0g+9roAVs3P
	41MizvyNwRIfLkzwhyRKKAkOUsAyRI0n9e1hLiCTs/qCJbMIFh8zejeOIpgMDDeW4B6
	qeCnGx3rs1O3Gt1+FRqoh20YIDSZ2q7fP8pjyh+I=
Received: by mx.zohomail.com with SMTPS id 1756136932963249.35841563530198;
	Mon, 25 Aug 2025 08:48:52 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH v2 1/1] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Mon, 25 Aug 2025 15:48:39 +0000
Message-ID: <20250825154839.2422856-2-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825154839.2422856-1-safinaskar@zohomail.com>
References: <20250825154839.2422856-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227f0fd73cea18eb987789a3de5000052122010156806263eed801299d1ae0e3666c20e45588fe1f4:zu08011227463164dd7fe0a38ceb3917aa000098b4a2dfa54ac34c32b486ad829c8765f4758c9338424edbb2:rf0801122c622da22d229d1c9d3e7f0dfd000062624541cd281dc38de84889689d84d58ca110541451fb174fc3c3c41102:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 man/man2/mount.2 | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/man/man2/mount.2 b/man/man2/mount.2
index 5d83231f9..47fc2d21f 100644
--- a/man/man2/mount.2
+++ b/man/man2/mount.2
@@ -405,7 +405,30 @@ flag can be used with
 to modify only the per-mount-point flags.
 .\" See https://lwn.net/Articles/281157/
 This is particularly useful for setting or clearing the "read-only"
-flag on a mount without changing the underlying filesystem.
+flag on a mount without changing the underlying filesystem parameters.
+The
+.I data
+argument is ignored if
+.B MS_REMOUNT
+and
+.B MS_BIND
+are specified.
+Note that the mountpoint will
+have its existing per-mount-point flags
+cleared and replaced with those in
+.I mountflags
+when
+.B MS_REMOUNT
+and
+.B MS_BIND
+are specified.
+This means that if
+you wish to preserve
+any existing per-mount-point flags,
+you need to include them in
+.IR mountflags ,
+along with the per-mount-point flags you wish to set
+(or with the flags you wish to clear missing).
 Specifying
 .I mountflags
 as:
@@ -416,8 +439,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
 .EE
 .in
 .P
-will make access through this mountpoint read-only, without affecting
-other mounts.
+will make access through this mountpoint read-only
+(clearing all other per-mount-point flags),
+without affecting
+other mounts
+of this filesystem.
 .\"
 .SS Creating a bind mount
 If
-- 
2.47.2


