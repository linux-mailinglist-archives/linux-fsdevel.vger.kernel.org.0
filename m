Return-Path: <linux-fsdevel+bounces-57143-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC92B1EFA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:41:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34ACBA07042
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D5E2571BF;
	Fri,  8 Aug 2025 20:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="dMb/3ZWo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3D238140;
	Fri,  8 Aug 2025 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685626; cv=none; b=BVwQYT7K1KnUmTrF0a9+zxmbBQSzRmNbKpY3UEDwnlRJgVaD+GMIgsXN+gsHhnah9Ebt6Mi/bOmChIvf9uI10jl3l2EO3uPnygxbADIMNsqDZ7x5hyEfPlBAR/2WApwhdS449SQXPBUzz/jE82OqOz0QdL0otBeAe5jSvxRSdmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685626; c=relaxed/simple;
	bh=Z0ahNEqyA/p0KIi1+RUs+g7EmhCzzIhViEgG1bc8zT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVImsC0msGlIo/oEl9t+Tx7/7p+aeecuWQM87+s0inkkuJjtip9/IDHYYQnHoO7fCDShJvSc8fg++vwVzfkvzeBsxtkbo9c9uotXnmBxrFhlxMAxiCMWqzeXmNSWwSctZw5hSS/008j3oMVdETj2CBpO1lmRaTcxRXUQ+9+4DoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=dMb/3ZWo; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4bzGBF27dwz9sWL;
	Fri,  8 Aug 2025 22:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3j7YGgwASF38f4KymAjjKnczDrv6XHH/zK1kP19isC8=;
	b=dMb/3ZWoI9DOft41XlEC6RQd+qSrg8S2lDoDsWvmWPsp6kEpCL07z9cU8L2iYYudrVbROL
	KONvnYNsvRMOn4TSfx7mmPdv87vTRWHbNpczBYsuKNgQjYPOLi2O29A5PDjQVq3pmYySxc
	TmScWAi6DWIRbVZmLeeON3smexBQnBvNyHgWCE8R+Vj4iTUTW/0/CUNcWFzAYZA+nldJNs
	wxGfYpHOYifGOZt73wgTxklDH8zEMSWq/wxaOzAIxS1U5ikKAe3fQ3BTqSF8MhUz67ueCh
	dj0CwTu8QKhBRV293LZGdkMsKdxF9JFZo8+88E8l8ncCbWzIsKG0Q5gsULRzLg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:47 +1000
Subject: [PATCH v3 03/12] man/man2/mount_setattr.2: move mount_attr struct
 to mount_attr(2type)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-3-f61405c80f34@cyphar.com>
References: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
In-Reply-To: <20250809-new-mount-api-v3-0-f61405c80f34@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3215; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Z0ahNEqyA/p0KIi1+RUs+g7EmhCzzIhViEgG1bc8zT8=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5ieJml97u2dkI7ThXlOlVOvrFg155nsGcEFjKZeL
 Pmci713d5SyMIhxMciKKbJs8/MM3TR/8ZXkTyvZYOawMoEMYeDiFICJ7LVn+Gdxdt0R23zOs/vW
 JIodiLJ6YJ+numj388UKvyfv0ZPmPijM8D9DbuOl9oWT1Q6nmq5YNPlwtVTH+c+f9kqa3D34bNq
 fJF5GAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bzGBF27dwz9sWL

As with open_how(2type), it makes sense to move this to a separate man
page.  In addition, future man pages added in this patchset will want to
reference mount_attr(2type).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2      | 17 ++++--------
 man/man2type/mount_attr.2type | 61 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index e1a975dcc8e2b263f68d18dc0492e8ecc518459e..46fcba927dd8c0959c898b9ba790ae298f514398 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -114,18 +114,11 @@ .SH DESCRIPTION
 .I attr
 argument of
 .BR mount_setattr ()
-is a structure of the following form:
-.P
-.in +4n
-.EX
-struct mount_attr {
-    __u64 attr_set;     /* Mount properties to set */
-    __u64 attr_clr;     /* Mount properties to clear */
-    __u64 propagation;  /* Mount propagation type */
-    __u64 userns_fd;    /* User namespace file descriptor */
-};
-.EE
-.in
+is a pointer to a
+.I mount_attr
+structure,
+described in
+.BR mount_attr (2type).
 .P
 The
 .I attr_set
diff --git a/man/man2type/mount_attr.2type b/man/man2type/mount_attr.2type
new file mode 100644
index 0000000000000000000000000000000000000000..f5c4f48be46ec1e6c0d3a211b6724a1e95311a41
--- /dev/null
+++ b/man/man2type/mount_attr.2type
@@ -0,0 +1,61 @@
+.\" Copyright, the authors of the Linux man-pages project
+.\"
+.\" SPDX-License-Identifier: Linux-man-pages-copyleft
+.\"
+.TH mount_attr 2type (date) "Linux man-pages (unreleased)"
+.SH NAME
+mount_attr \- what mount properties to set and clear
+.SH LIBRARY
+Linux kernel headers
+.SH SYNOPSIS
+.EX
+.B #include <sys/mount.h>
+.P
+.B struct mount_attr {
+.BR "    u64 attr_set;" "     /* Mount properties to set */"
+.BR "    u64 attr_clr;" "     /* Mount properties to clear */"
+.BR "    u64 propagation;" "  /* Mount propagation type */"
+.BR "    u64 userns_fd;" "    /* User namespace file descriptor */"
+    /* ... */
+.B };
+.EE
+.SH DESCRIPTION
+Specifies which mount properties should be changed with
+.BR mount_setattr (2).
+.P
+The fields are as follows:
+.TP
+.I .attr_set
+This field specifies which
+.BI MOUNT_ATTR_ *
+attribute flags to set.
+.TP
+.I .attr_clr
+This field specifies which
+.BI MOUNT_ATTR_ *
+attribute flags to clear.
+.TP
+.I .propagation
+This field specifies what mount propagation will be applied.
+The valid values of this field are the same propagation types described in
+.BR mount_namespaces (7).
+.TP
+.I .userns_fd
+This field specifies a file descriptor that indicates which user namespace to
+use as a reference for ID-mapped mounts with
+.BR MOUNT_ATTR_IDMAP .
+.SH STANDARDS
+Linux.
+.SH HISTORY
+Linux 5.12.
+.\" commit 2a1867219c7b27f928e2545782b86daaf9ad50bd
+glibc 2.36.
+.P
+Extra fields may be appended to the structure,
+with a zero value in a new field resulting in
+the kernel behaving as though that extension field was not present.
+Therefore, a user
+.I must
+zero-fill this structure on initialization.
+.SH SEE ALSO
+.BR mount_setattr (2)

-- 
2.50.1


