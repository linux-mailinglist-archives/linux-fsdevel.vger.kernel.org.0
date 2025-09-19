Return-Path: <linux-fsdevel+bounces-62195-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7123AB87AB6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:02:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA9E21C86965
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33EE2750F6;
	Fri, 19 Sep 2025 02:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="gXi+2/Ap"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCC025A2B5;
	Fri, 19 Sep 2025 02:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247264; cv=none; b=KBr/yAeGCJu8YgozXr0yl+C0sgiQXQpjGUb9lIKxs1tg/JiEdJHSwNx2nYUxwgL+/8r8IZ/sAmwqK0kq97BgtEo1I/m6rjFS6Vdb5SpT3SpPPVGmThICKwv20pakkkD0l4yz4hdbD3Q5TUpVwFt8ZlkPvWw//jpnKi8MIOzafgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247264; c=relaxed/simple;
	bh=k0P5TLKIQcNvPpE/yRue2NqzcDOYWE1LQ0jR8gyJSr0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nz8MCpvGJiKjB+iJJZ5SfSUcZ229gLu+9C5KJiSgT56TKnkBFrnWVw6S0TTyzLEeFLfx7Plv+j9TQYAFdlXRUDYcDwQwwxud5YcpJj+8BkcMTYhrOIV3squsSJXlWIGsFEGARiqmC0Ul88m+4zlaaRfXbCxreMg2SsvZ/Oe6HJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=gXi+2/Ap; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSbMG4lQ2z9sy4;
	Fri, 19 Sep 2025 04:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u+pMwDP1HnUqPZvsXpTH0VTEoRpEk896w42KFmX45ms=;
	b=gXi+2/ApWAL6NrqyDSeQUG3uNM9IqM+0fJKERWEiseZ8fmSJcYfojWilXGv+0ZQ3ffWpnW
	Mltr0xS2+4PNEFuyp/RShMB+37nvIhUJiQaR5Yea8DbBkupn5FZEzRJjBgrF1dSC2OH2wU
	RClxRbnclRCl6KSpNADP5sQDXJ6cgwzetHh3XXCJapD3KK3XT9yZeHbZw/OGMSYQVgguzW
	WEe6blS6wunR+04qT2fAbglbLfSIXY9uoA8OR0YkTi8fymBvAci2OTWhvRS6s327foHPEi
	qRnOGqASClaJy6vtYI2UTtqMPBGKJWNcKAMx5e6Y092LabMLuHJpFYVDZ965OA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:51 +1000
Subject: [PATCH v4 10/10] man/man2/{fsconfig,mount_setattr}.2: add note
 about attribute-parameter distinction
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-10-1261201ab562@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2987; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=k0P5TLKIQcNvPpE/yRue2NqzcDOYWE1LQ0jR8gyJSr0=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2SluknfoWMLrf3KtF/cqrlZzjWS+cyZFieVu9Yzcd
 S4Lftoad0xkYRDjYrAUU2TZ5ucZumn+4ivJn1aywcxhZQIZIi3SwMDAwMDCwJebmFdqpGOkZ6pt
 qGdoqGOkY8TAxSkAU50kwMiwT/b7pUCRTyKLj/KvaeT9Yfj4156O5gex/7IOLj89pc7vMyPD1NR
 djlzbpH67bdq6xIDHoVn0xhaRnd/+xH75ef3jLH9FRgA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4cSbMG4lQ2z9sy4

This was not particularly well documented in mount(8) nor mount(2), and
since this is a fairly notable aspect of the new mount API, we should
probably add some words about it.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/fsconfig.2      | 12 ++++++++++++
 man/man2/mount_setattr.2 | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/man/man2/fsconfig.2 b/man/man2/fsconfig.2
index 5a18e08c700ac93aa22c341b4134944ee3c38d0b..d827a7b96e08284fb025f94c3348a4acc4571b7d 100644
--- a/man/man2/fsconfig.2
+++ b/man/man2/fsconfig.2
@@ -579,6 +579,18 @@ .SS Generic filesystem parameters
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
index b27db5b96665cfb0c387bf5b60776d45e0139956..f7d0b96fddf97698e36cab020f1d695783143025 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -790,6 +790,46 @@ .SS ID-mapped mounts
 .BR chown (2)
 system call changes the ownership globally and permanently.
 .\"
+.SS Mount attributes and filesystem parameters
+Some mount attributes
+(traditionally associated with
+.BR mount (8)-style
+options)
+have a sibling mount attribute
+with superficially similar user-facing behaviour.
+For example, the
+.I -o ro
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
+while filesystem parameters can be configured using
+.BR fsconfig (2).
+.\"
 .SS Extensibility
 In order to allow for future extensibility,
 .BR mount_setattr ()

-- 
2.51.0


