Return-Path: <linux-fsdevel+bounces-59172-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E35B35712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 10:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A782A12BB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 08:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F9D3002B1;
	Tue, 26 Aug 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="bckR0UY0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A632FFDEE;
	Tue, 26 Aug 2025 08:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197220; cv=pass; b=lnloYK/rEThBig3Ef7rp4z0OEYyH+wARTegnoSUUqTUNLiNsijFYyYb12Xi/1kOXzbkyqi3s9cNyof81C6HClQRxtu/xnRsgodnDmQ/e+zthAIYTHlVhebbOz76AxhtmNAFfDR7xTEaZd7n11Llu+R+QP6/jHihhAk7KUEGTKTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197220; c=relaxed/simple;
	bh=RiO2jmHaWWKTjjVoFwZ5HtoAFvj1RRCaF/c7DpPao6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeEv3FgL+m/V/vV4blQtff5ksfsBYYm/cCzyQ/ybdfpFnqehN1wSHbTAOzPfpkgx10dxwZMEtIjXz7vUjUdDZ2k00PYYXKIu+kctUqn24YpZR8cFH7y/X291WmyR5PIzt1iXc6XFsOwVFEdLqTfPOHOVSy2PaOzszGbANXqtx2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=bckR0UY0; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756197162; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GLghZ2UQrg0MdzNr14kccR0Ca/2EP0gYnexEIcwfbhsgZM0pakU5+6v9fIdVQ3MjZUkoghb/KEnviniqVcWSf+Vzs6LbGPajqLMu952hqB2O/Qo1Rv5Cb0Nz8UZn6Yyn2iUpHm9w3/f1iTnDk5E8LnMPqLwmmudPIEGaO/Qjhmc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756197162; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2yZelqehmBsNN6c6kdP+KyCy+3dG5rVfrI3dS67K4JE=; 
	b=kPmwk88rl1WnGOocPjpprrhuZ/LMcjeqa/JMgn5hDfxOZbWXIs2wfD9pq4mrXEykg3L4jk9v4dyZhIQ8DEMSehCl7k2Nw5Xfa1/z/PZD7Qt3f27tQK4p3i37wmHgpZDvAPXccf7Ven6+qADnc5pDUy8UqlXOwL117A1eUR6LThQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756197162;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=2yZelqehmBsNN6c6kdP+KyCy+3dG5rVfrI3dS67K4JE=;
	b=bckR0UY0jlO/Boeq+lyrha8s9iSuxL8PjjMixbNESy3ajqUP1fxHPe0KdjU/nr9X
	9Dii09c7n2LLwyU9J9YoNyzkh99pjfIQZR8Rz/JGBmYcc99g2pPn2UaBckyjFRHaTR1
	dgN5mwxJ0D8UN0MD61oA+BYpiYM3i1f5NooGjK/s=
Received: by mx.zohomail.com with SMTPS id 1756197159781104.79847002999475;
	Tue, 26 Aug 2025 01:32:39 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	linux-man@vger.kernel.org
Subject: [PATCH v3 1/2] man2/mount.2: expand and clarify docs for MS_REMOUNT | MS_BIND
Date: Tue, 26 Aug 2025 08:32:26 +0000
Message-ID: <20250826083227.2611457-2-safinaskar@zohomail.com>
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
Feedback-ID: rr08011227998c1f1a982d7f6e16a8d04100001ad123baf40a0788d03a1a0556187c35afb69e17706fd820bc:zu080112277efb2128fae43c85eb1aa38a0000f2068260aa23804b70d29f676d06704a6ae3388150f501034a:rf0801122c45cface08b7f8ed633beafde0000daa7ac12ecbb46a4744dfe6984666ef71fe2f6633caa9e585fdb7c0d4fc0:ZohoMail
X-ZohoMailClient: External

My edit is based on experiments and reading Linux code

Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 man/man2/mount.2 | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/man/man2/mount.2 b/man/man2/mount.2
index 5d83231f9..599c2d6fa 100644
--- a/man/man2/mount.2
+++ b/man/man2/mount.2
@@ -405,7 +405,25 @@ flag can be used with
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
+The mount point will
+have its existing per-mount-point flags
+cleared and replaced with those in
+.IR mountflags .
+This means that
+if you wish to preserve
+any existing per-mount-point flags,
+you need to include them in
+.IR mountflags ,
+along with the per-mount-point flags you wish to set
+(or with the flags you wish to clear missing).
 Specifying
 .I mountflags
 as:
@@ -416,8 +434,11 @@ MS_REMOUNT | MS_BIND | MS_RDONLY
 .EE
 .in
 .P
-will make access through this mountpoint read-only, without affecting
-other mounts.
+will make access through this mount point read-only
+(clearing all other per-mount-point flags),
+without affecting
+other mounts
+of this filesystem.
 .\"
 .SS Creating a bind mount
 If
-- 
2.47.2


