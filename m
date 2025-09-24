Return-Path: <linux-fsdevel+bounces-62608-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8667B9AB2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 17:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16BD188B3B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Sep 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67D330DD08;
	Wed, 24 Sep 2025 15:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="abeV+F54"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B40313545;
	Wed, 24 Sep 2025 15:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758727970; cv=none; b=NEPJ3hZAvIVgK8gKBq3q9ZeYlxd9NAwGVJmbm5oQz4tiqKgOd4qrkQEFfbq2Wa4kZ2sHcYhnlC4+x3dxR65+07CycVmPbSRTBkvh77fKVS6hAzyFPea9Hv8lbHzzuVXkGWlnrl2/52+ndBlloHLjpNMf49+W0Y+PTiD/yqgdm80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758727970; c=relaxed/simple;
	bh=CjXX2QK5JsRjG6mf5chm3pFhzMwRmtPUDlCuGyRsRG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uFxc/i9OzDPJJg1JdXwpTZ8k6EeMcblW9rQosodWKnHdtWwdtkOYPOj6leNB71SivelFHTLzhDcbia47m9mn6dXdB4H8/YOZrsE9nKbm7Ig2ZtoOerJW/y8Yr1hfA8/wrjmTRJik68A4tmOSuKr3A7CtCHYbSkblGqUwLBZoeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=abeV+F54; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cX17c6QNtz9srM;
	Wed, 24 Sep 2025 17:32:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758727964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6jp4RJnTh4Wq1Bn9YKF4KFTuTOWruSTCYzzraQL9wO0=;
	b=abeV+F540RaU80zgXJ5ihU7P0PAypTF3OFFUhZOq2VaQL1VYwQfxzSvns+KOrdiIJNp6Gd
	+sy6nqB1Zos0n+QusqTjlR0KrwgdaZ/ejd0nkso1AhI4b79wHN81PwhKtrafgS6tMW2f5W
	+oUZP+Hyp6MxiLagErbfcdzNH7PQlnnriYbiwjOjObMXLt3Ro5KyRzxZwkVd/n+fkzjjGs
	NEOvlG8p1uZd70S86sERvoHSiKHs15jY2I6jjsdIiApFtkINIbHFVsafius2jrlZdXMh61
	YQGmvipXXSv6obsJMpsgXj26Qjn4CV8E+fDx55ztZoPvC4FKJFZZBixpbxRx2g==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 25 Sep 2025 01:31:30 +1000
Subject: [PATCH v5 8/8] man/man2/{fsconfig,mount_setattr}.2: add note about
 attribute-parameter distinction
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-new-mount-api-v5-8-028fb88023f2@cyphar.com>
References: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
In-Reply-To: <20250925-new-mount-api-v5-0-028fb88023f2@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2984; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=CjXX2QK5JsRjG6mf5chm3pFhzMwRmtPUDlCuGyRsRG8=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRc4bv3MtMk7L9h0qlG/6ZiOUZGv+BH6fyb9qc+/Pjir
 RW/IP/vjoksDGJcDJZiiizb/DxDN81ffCX500o2mDmsTCBDpEUaGBgYGFgY+HIT80qNdIz0TLUN
 9QwNdYx0jBi4OAVgqu0rGBmuXWc1y/dOZT/n33U/isWybrGa9gTh80IMNRU3fq34dsiS4X9Y6dX
 6UsfOefWOV3MmhW1tMv/UUtK4XJkp9X2Q74Q38bwA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cX17c6QNtz9srM

This was not particularly well documented in mount(8) nor mount(2), and
since this is a fairly notable aspect of the new mount API, we should
probably add some words about it.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsconfig.2      | 12 ++++++++++++
 man/man2/mount_setattr.2 | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
index a2d844a105c74f17af640d6991046dbd5fa69cf0..3b972761196b9c1577a6f324a2f4135471dd0ab3 100644
--- a/man/man2/fsconfig.2
+++ b/man/man2/fsconfig.2
@@ -580,6 +580,18 @@ .SS Generic filesystem parameters
 Linux Security Modules (LSMs)
 are also generic with respect to the underlying filesystem.
 See the documentation for the LSM you wish to configure for more details.
+.SS Mount attributes and filesystem parameters
+Some filesystem parameters
+(traditionally associated with
+.BR mount (8)-style
+options)
+have a sibling mount attribute
+with superficially similar user-facing behaviour.
+.P
+For a description of the distinction between
+mount attributes and filesystem parameters,
+see the "Mount attributes and filesystem parameters" subsection of
+.BR mount_setattr (2).
 .SH CAVEATS
 .SS Filesystem parameter types
 As a result of
diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 2f8a79dfde722b7b58b80797d89798076af94f55..efe22496be95383b986d9a3623324d472a76c189 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -792,6 +792,45 @@ .SS ID-mapped mounts
 .BR chown (2)
 system call changes the ownership globally and permanently.
 .\"
+.SS Mount attributes and filesystem parameters
+Some mount attributes
+(traditionally associated with
+.BR mount (8)-style
+options)
+have a sibling filesystem parameter
+with superficially similar user-facing behaviour.
+For example, the
+.I \-o\~ro
+option to
+.BR mount (8)
+can refer to the
+"read-only" filesystem parameter,
+or the "read-only" mount attribute.
+Both of these result in mount objects becoming read-only,
+but they do have different behaviour.
+.P
+The distinction between these two kinds of option is that
+mount object attributes are applied per-mount-object
+(allowing different mount objects
+derived from a given filesystem instance
+to have different attributes),
+while filesystem instance parameters
+("superblock flags" in kernel-developer parlance)
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
+while filesystem parameters are configured using
+.BR fsconfig (2).
 .SS Extensibility
 In order to allow for future extensibility,
 .BR mount_setattr ()

-- 
2.51.0


