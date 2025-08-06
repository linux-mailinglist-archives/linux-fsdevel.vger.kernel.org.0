Return-Path: <linux-fsdevel+bounces-56870-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EAA6B1CB65
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 19:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AD9C18C512D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 17:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6852C08AF;
	Wed,  6 Aug 2025 17:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="vfoKcSgz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D532BFC9B;
	Wed,  6 Aug 2025 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754502362; cv=none; b=QYwFByM0ZdIdRBtZASNXDJop/IMHFQgLrjgXXfV1rS3ghCSX231j5WdG7jOwfq78DW69LOoW9tQ8DxtBD+xlqb+al570RSeQiEtG26io/6hPAWL24in1nf8MvI4EYBM352qanBJgekJ4x4rGmbfWA998q8vIELbfGo+VuEO4ZYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754502362; c=relaxed/simple;
	bh=PA7loxIPBLGOhG+xaEAeoYFr7UKxY5keNiex8tkAodM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iqQYyAXdd2ODyGcFXeQkXxplcXBD2IM29ATDdLephOpahD69cq6bbZ4YyywuGGFCvRxWJZ+CfK2dkM8j7ncHp4j505ke80YO6989qSVtRJJQOU+QGbeoioeRzqabnRDAzYXZEQt4Ad0W8xc35h7CfNikV58U5pbXhTdvTtqv8XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=vfoKcSgz; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxyPw1FZhz9snx;
	Wed,  6 Aug 2025 19:45:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754502356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2YYCu5R1XiGIudL58R408XKwHqQ+bXkM+6ufvf1daHo=;
	b=vfoKcSgzG6rLa0oQk5oIFzsv/K/YkgPlfIhc5iZKQ43Doy2DR91KiJtbyDN0tKnwdjUjbt
	QkH+E3cGpcefF3pIEKKBRhn2nLRIzcMQH2gF5rhD99T0ZB8XjetqtjMAkvyu7/WBDiHtHQ
	Egw5eFq1g12a79/rdtYACxRkEiwMIwkg+Ojcn/wlB03zZS9Ztxt+3rFNFd7lavuR6ChS+t
	2s3Z5F8Y1mMxmJOUvA4Cchln8SUQ4rdLMrpCJe5VtXnkT71EKZsj7CFihodVL8Y0mlXeQd
	UFkVrFQJSn1gxjIfi1SakBDbbqtmcxzDTkqnHOdPL+lPvsFAGZVCbj0rMGvv7g==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 07 Aug 2025 03:44:45 +1000
Subject: [PATCH v2 11/11] fsconfig.2, mount_setattr.2: add note about
 attribute-parameter distinction
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-new-mount-api-v2-11-558a27b8068c@cyphar.com>
References: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
In-Reply-To: <20250807-new-mount-api-v2-0-558a27b8068c@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2475; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=PA7loxIPBLGOhG+xaEAeoYFr7UKxY5keNiex8tkAodM=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMntKxe6X44h89CyT2NLpaf9kTt+BQ6cL8H5sjrL3+s
 fzOXy8g3lHKwiDGxSArpsiyzc8zdNP8xVeSP61kg5nDygQyhIGLUwAm0tnP8Ifb2m9NzMTFEd+E
 d6y4/ELkS4SjctPn1S67t3y5enBC1/d5jAyP+U1YK34tkpKfl1+sfuMP16SjivO5FS1WJqYZLne
 ZxsgCAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

This was not particularly well documented in mount(8) nor mount(2), and
since this is a fairly notable aspect of the new mount API, we should
probably add some words about it.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsconfig.2      |  7 +++++++
 man/man2/mount_setattr.2 | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
index e2121b7a6b68..9e0e25acff3b 100644
--- a/man/man2/fsconfig.2
+++ b/man/man2/fsconfig.2
@@ -448,6 +448,13 @@ .SH HISTORY
 Linux 5.2.
 .\" commit ecdab150fddb42fe6a739335257949220033b782
 glibc 2.36.
+.SH NOTES
+.SS Mount attributes and filesystem parameters
+For a description of the distinction between
+mount attributes and filesystem parameters,
+see the "Mount attributes and filesystem paramers" subsection
+of
+.BR mount_setattr (2).
 .SH EXAMPLES
 To illustrate the different kinds of flags that can be configured with
 .BR fsconfig (),
diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index b9afc21035b8..3e6b59e5b57a 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -790,6 +790,43 @@ .SS ID-mapped mounts
 .BR chown (2)
 system call changes the ownership globally and permanently.
 .\"
+.SS Mount attributes and filesystem parameters
+Some mount attributes
+(traditionally associated with
+.BR mount (8)-style
+options)
+are also filesystem parameters.
+For example, the
+.I -o ro
+option to
+.BR mount (8)
+can refer to the
+"read-only" filesystem parameter,
+or the "read-only" mount attribute.
+.P
+The distinction between these two kinds of option is that
+mount object attributes are applied per-mount-object
+(allowing different mount objects
+derived from a given filesystem instance
+to have different attributes),
+while filesystem instance parameters
+("superblock flags" in kernel developer parlance)
+apply to all mount objects
+derived from the same filesystem instance.
+.P
+When using
+.BR mount (2),
+the line between these two types of mount options was blurred.
+However, with
+.BR mount_setattr ()
+and
+.BR fsconfig (2),
+the distinction is made much clearer.
+Mount attributes are configured with
+.BR mount_setattr (),
+while filesystem parameters can be configured using
+.BR fsconfig (2).
+.\"
 .SS Extensibility
 In order to allow for future extensibility,
 .BR mount_setattr ()

-- 
2.50.1


