Return-Path: <linux-fsdevel+bounces-57151-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62B6B1EFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 22:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820A7AA0A29
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 20:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D51E25F994;
	Fri,  8 Aug 2025 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="AUKfhm1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE992652B2;
	Fri,  8 Aug 2025 20:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754685678; cv=none; b=l5F9tdOlN0ZKEJ2RlnnKMuVjDJ7wGS4pYzBw+ePdQ87i4F3F1NeV9ZxZd6nmcxeDxG8H/BkYD9c8Fgfoq504gl8jSryBo4ftYsjMROmtH/NGvvtlp44NP1Lcj9e+OIsndW5NLS/P8dm2fbmW4u2KPMN47WUBPFIxHcmDn4CovzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754685678; c=relaxed/simple;
	bh=NP75VawEkzAgS/qXsHKXpVi1UK/CmFLR4v+haPnvJCc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t3qEhbuYBHpIf26Kh+gwwZEOf8y8LbJKGvFt7lUtN2g9hqulUZYTRP0p6Dt1ppXuNrJXtUUN2M2qSk6/hlZ/reiP+AE0iB2HZNZSYNjeDv96gVJE/77OQXnoCjxbr9FGJcqaQMbRADN5NvWrHUye/L71XONmapg/ka75nNUhyvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=AUKfhm1e; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bzGCD5ZqPz9scY;
	Fri,  8 Aug 2025 22:41:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754685672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A9z+81sauD1HLEDehH9FDzS5KmuUleH5DfgttFdp/xc=;
	b=AUKfhm1erdqe3EibSeKROo+zsHe7f6le1kP1vimcmhw/vHTZBXc8ogPv36RlqlKnTwelVb
	cwdhX9PsmHf9Y2IuRa0CSKpc6cnjg1JcRNMJIXRAuDiZLvX/XG18ZRmNXVmBrDCBL2/2UH
	JhT1RPMGqLXilJDjUAWO5ZUF6kHT2oSCMmzHyFV3bVIOlvtLP9If8GoYUprTKUu6gf8znQ
	fkTQJRpbM3u0hgRMo9cZxF8CS9AkANpOelrBfo0+ySl3wcHs/uZJpL94Yj3Twy2gshs6eu
	TIZnr/busIothw8OiIeGJHLVAiyxgbZfOaU9+F3/XkXMiRn4JAC1A7wr4o4gtA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::1 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Sat, 09 Aug 2025 06:39:55 +1000
Subject: [PATCH v3 11/12] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250809-new-mount-api-v3-11-f61405c80f34@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4769; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=NP75VawEkzAgS/qXsHKXpVi1UK/CmFLR4v+haPnvJCc=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMS5gRqx0g4BNf8Xf7bam2D6X9P83YCt2v8+yqfxKiY
 iD4+lRuRykLgxgXg6yYIss2P8/QTfMXX0n+tJINZg4rE8gQBi5OAZgIWzHDb3Zr7vNtcRmaE29u
 XXRhmcaEBlkZ6wftxyaKxiZfVeHKuMfIcDEys/DCmcPTS+7wSM/O2tX4Oe3p6w17+qRTZJ2yll4
 vYgEA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bzGCD5ZqPz9scY

This is a new API added in Linux 6.15, and is effectively just a minor
expansion of open_tree(2) in order to allow for MOUNT_ATTR_IDMAP to be
changed for an existing ID-mapped mount.  glibc does not yet have a
wrapper for this.

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/open_tree.2      | 122 ++++++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2 |   1 +
 2 files changed, 123 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
index 07aac7616107d16d05cc71ba7db6aee35f3a9cc6..f671c401b1f1e2926f7948d6fe5041b7848125ac 100644
--- a/man/man2/open_tree.2
+++ b/man/man2/open_tree.2
@@ -14,7 +14,19 @@ .SH SYNOPSIS
 .B #include <sys/mount.h>
 .P
 .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags ");"
+.P
+.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constants */"
+.P
+.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" path ","
+.BI "            unsigned int " flags ", struct mount_attr *" attr ", \
+size_t " size ");"
 .fi
+.P
+.IR Note :
+glibc provides no wrapper for
+.BR open_tree_attr (),
+necessitating the use of
+.BR syscall (2).
 .SH DESCRIPTION
 The
 .BR open_tree ()
@@ -228,6 +240,111 @@ .SH DESCRIPTION
 as a detached mount object.
 This flag is only permitted in conjunction with
 .BR \%OPEN_TREE_CLONE .
+.SS open_tree_attr()
+The
+.BR open_tree_attr ()
+system call operates in exactly the same way as
+.BR open_tree (),
+except for the differences described here.
+.P
+After performing the same operation as with
+.BR open_tree (),
+(before returning the resulting file descriptor)
+.BR open_tree_attr ()
+will apply the mount attribute changes described in
+.I attr
+to the returned file descriptor.
+(See
+.BR mount_attr (2type)
+for a description of the
+.I mount_attr
+structure.
+As described in
+.BR mount_setattr (2),
+.I size
+must be set to
+.I sizeof(struct mount_attr)
+in order to support future extensions.)
+.P
+The application of
+.I attr
+to the resultant file descriptor
+has identical semantics to
+.BR mount_setattr (2),
+except for the following extensions and general caveats:
+.IP \[bu] 3
+Unlike
+.BR mount_setattr (2)
+called with a regular
+.B OPEN_TREE_CLONE
+detached mount object from
+.BR open_tree (),
+.BR open_tree_attr ()
+can specify a different setting for
+.B \%MOUNT_ATTR_IDMAP
+to the original mount object cloned with
+.BR OPEN_TREE_CLONE .
+.IP
+Adding
+.B \%MOUNT_ATTR_IDMAP
+to
+.I attr.attr_clr
+will disable ID-mapping for the new mount object;
+adding
+.B \%MOUNT_ATTR_IDMAP
+to
+.I attr.attr_set
+will configure the mount object to have the ID-mapping defined by
+the user namespace referenced by the file descriptor
+.IR attr.userns_fd .
+(The semantics of which are identical to when
+.BR mount_setattr (2)
+is used to configure
+.BR \%MOUNT_ATTR_IDMAP .)
+.IP
+Changing or removing the mapping
+of an ID-mapped mount is only permitted
+if a new detached mount object is being created with
+.I flags
+including
+.BR \%OPEN_TREE_CLONE .
+.IP \[bu]
+If
+.I flags
+contains
+.BR \%AT_RECURSIVE ,
+then the attributes described in
+.I attr
+are applied recursively
+(just as when
+.BR mount_setattr (2)
+is called with
+.BR \%AT_RECURSIVE ).
+However, this applies in addition to the
+.BR open_tree ()-specific
+behaviour regarding
+.BR \%AT_RECURSIVE ,
+and thus
+.I flags
+must also contain
+.BR \% OPEN_TREE_CLONE .
+.P
+Note that if
+.I flags
+does not contain
+.BR \% OPEN_TREE_CLONE ,
+.BR open_tree_attr ()
+will attempt to modify the mount attributes of
+the mount object attached at
+the path described by
+.I dirfd
+and
+.IR path .
+As with
+.BR mount_setattr (2),
+if said path is not a mount point,
+.BR open_tree_attr ()
+will return an error.
 .SH RETURN VALUE
 On success, a new file descriptor is returned.
 On error, \-1 is returned, and
@@ -321,10 +438,15 @@ .SH ERRORS
 .SH STANDARDS
 Linux.
 .SH HISTORY
+.SS open_tree()
 Linux 5.2.
 .\" commit a07b20004793d8926f78d63eb5980559f7813404
 .\" commit 400913252d09f9cfb8cce33daee43167921fc343
 glibc 2.36.
+.SS open_tree_attr()
+Linux 6.15.
+.\" commit c4a16820d90199409c9bf01c4f794e1e9e8d8fd8
+.\" commit 7a54947e727b6df840780a66c970395ed9734ebe
 .SH NOTES
 .SS Anonymous mount namespaces
 The bind-mount mount objects created by
diff --git a/man/man2/open_tree_attr.2 b/man/man2/open_tree_attr.2
new file mode 100644
index 0000000000000000000000000000000000000000..e57269bbd269bcce0b0a974425644ba75e379f2f
--- /dev/null
+++ b/man/man2/open_tree_attr.2
@@ -0,0 +1 @@
+.so man2/open_tree.2

-- 
2.50.1


