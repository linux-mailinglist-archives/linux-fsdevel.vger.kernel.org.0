Return-Path: <linux-fsdevel+bounces-62194-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4F6B87AE2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8454C565DA6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE02737FB;
	Fri, 19 Sep 2025 02:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="aZWr2Oje"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16C127145F;
	Fri, 19 Sep 2025 02:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247258; cv=none; b=EkJzTPWHNYG0+EI4uJtDZqIuza3nP9aVF+Opb1WF/auxX6bzkp8HGhMOjb2bdS2kH1IfIpnsrXVuVWGB4TqG5pzFOcAXV+7Gp+AT94VKAckOsAWx4s51FmZQ+vszMXvf3L7gFrs4diL/kYdWgZpgvg394Kd7/bl5wlJQfpXu68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247258; c=relaxed/simple;
	bh=Q4hSoiAb/K2mL5SLnNoky1JXH917wZ2SexMlx1jzyuE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PGfNE5IDI+KCm/eLvEKFLgOyN8B3yNMnVpsuocu+3AoRnL7XfuuXQ5+yC6vg5GwudpouBjdJbYj8kdZYC+iXbu4+72K024giyBSPN4+LByHsgR8QU1X1wAYrFNuKixSFVgm0evuJ5MxV04k+x6Ov0zQw7R3W/k2WG8ZBjiUZPnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=aZWr2Oje; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cSbM91vDKz9trP;
	Fri, 19 Sep 2025 04:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=26uKr0RIVJgFAWLRhEGDW585pCyl1M382u0FfPwNJNQ=;
	b=aZWr2OjeT7/VPK2cirmIy/xf8k/TGAkoaOY2SAQH7LrQnxTO0lTU5iyDU2luhOpka6tbCC
	taBLmvbFtGbnmusOLHeUzFqS1I8k8XpYmxouX+xFTpYwQfCHdEfshwwMtJlwrCF0YWwQVd
	UeydeOh85k1tkKteMB0yy2en3ToRPl3nXHsGnmwZ+IbCiNn371Q7sLQ3EgxkQHaF9wLxia
	hf2o5i6CGcadUBWYkwXZ4nBVZtBJPOZquh5yNcwA5qBZ4AAbeg6M0SrLwBNsLlKDkI/VqJ
	it/B3UxKi2lM2o8WOvToOriarpNGY02yIWBlQ4QpnHIIt1T/gDTx6yukUFoNLQ==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:50 +1000
Subject: [PATCH v4 09/10] man/man2/open_tree{,_attr}.2: document new
 open_tree_attr() API
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-9-1261201ab562@cyphar.com>
References: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
In-Reply-To: <20250919-new-mount-api-v4-0-1261201ab562@cyphar.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: "Michael T. Kerrisk" <mtk.manpages@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Askar Safin <safinaskar@zohomail.com>, 
 "G. Branden Robinson" <g.branden.robinson@gmail.com>, 
 linux-man@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Howells <dhowells@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5720; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=Q4hSoiAb/K2mL5SLnNoky1JXH917wZ2SexMlx1jzyuE=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2SlukTFzp7qNtEtPmaHJ7BNuO1IFfv54wfdX5o2HB
 NuiVw33OyayMIhxMViKKbJs8/MM3TR/8ZXkTyvZYOawMoEMkRZpYGBgYGBh4MtNzCs10jHSM9U2
 1DM01DHSMWLg4hSAqU7fxPA/b3Fn3sN6zdk6P+Onrsnw3d4azZ52rfzTq+pzv/IZru65zvBXYIW
 /0joZ0ZKTYqK/FXKqs/6sd22MMBZ85/x0jcWfK+4MAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cSbM91vDKz9trP

This is a new API added in Linux 6.15, and is effectively just a minor
expansion of open_tree(2) in order to allow for MOUNT_ATTR_IDMAP to be
changed for an existing ID-mapped mount.  glibc does not yet have a
wrapper for this.

While working on this man-page, I discovered a bug in open_tree_attr(2)
that accidentally permitted changing MOUNT_ATTR_IDMAP for extant
detached ID-mapped mount objects.  This is definitely a bug, but there
is no need to add this to BUGS because the patch to fix this has already
been accepted (slated for 6.18, and will be backported to 6.15+).

Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/open_tree.2      | 140 ++++++++++++++++++++++++++++++++++++++++++++++
 man/man2/open_tree_attr.2 |   1 +
 2 files changed, 141 insertions(+)

diff --git a/man/man2/open_tree.2 b/man/man2/open_tree.2
index 7f85df08b43c7b48a9d021dbbeb2c60092a2b2d4..60de4313a9d5be4ef3ff1217051f252506a2ade9 100644
--- a/man/man2/open_tree.2
+++ b/man/man2/open_tree.2
@@ -15,7 +15,19 @@ .SH SYNOPSIS
 .B #include <sys/mount.h>
 .P
 .BI "int open_tree(int " dirfd ", const char *" path ", unsigned int " flags );
+.P
+.BR "#include <sys/syscall.h>" "    /* Definition of " SYS_* " constants */"
+.P
+.BI "int syscall(SYS_open_tree_attr, int " dirfd ", const char *" path ,
+.BI "            unsigned int " flags ", struct mount_attr *_Nullable " attr ", \
+size_t " size );
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
@@ -246,6 +258,129 @@ .SH DESCRIPTION
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
+.BR open_tree_attr ()
+will apply the mount attribute changes described in
+.I attr
+to the file descriptor before it is returned.
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
+If
+.I attr
+is NULL,
+or has
+.IR attr.attr_clr ,
+.IR attr.attr_set ,
+and
+.I attr.propagation
+all set to zero,
+then
+.BR open_tree_attr ()
+has identical behaviour to
+.BR open_tree ().
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
+.\" Aleksa Sarai
+.\"  At time of writing, this is not actually true because of a bug where
+.\"  open_tree_attr() would accidentally permit changing MOUNT_ATTR_IDMAP for
+.\"  existing detached mount objects without setting OPEN_TREE_CLONE, but a
+.\"  patch to fix it has been slated for 6.18 and will be backported to 6.15+.
+.\"  <https://lore.kernel.org/r/20250808-open_tree_attr-bugfix-idmap-v1-0-0ec7bc05646c@cyphar.com/>
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
+.BR \%OPEN_TREE_CLONE .
+.P
+Note that if
+.I flags
+does not contain
+.BR \%OPEN_TREE_CLONE ,
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
@@ -339,10 +474,15 @@ .SH ERRORS
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
 .SS Mount propagation
 The bind-mount mount objects created by
diff --git a/man/man2/open_tree_attr.2 b/man/man2/open_tree_attr.2
new file mode 100644
index 0000000000000000000000000000000000000000..e57269bbd269bcce0b0a974425644ba75e379f2f
--- /dev/null
+++ b/man/man2/open_tree_attr.2
@@ -0,0 +1 @@
+.so man2/open_tree.2

-- 
2.51.0


