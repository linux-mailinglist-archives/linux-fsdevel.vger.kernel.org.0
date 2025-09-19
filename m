Return-Path: <linux-fsdevel+bounces-62193-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DCB87AA1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 04:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 707E81C86E05
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Sep 2025 02:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA51D262FC5;
	Fri, 19 Sep 2025 02:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="tFT97XWC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863C41E5B7B;
	Fri, 19 Sep 2025 02:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758247254; cv=none; b=kcoJtbbrWBrf+pJwSGuIm1BY2mzzYDmh8tX2/4nAsTWDiucvkdaarswybFWLf9AjOF1XHWkYAG4q9ydqdaT+3Fz0Wq9hI5lHouZv6Ibq+sTIHwIlOz0za6iuOG+NIa7rv23BFC/usmapUDwUJUxygI5ch9+WW9TcuMcz35Lx/yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758247254; c=relaxed/simple;
	bh=xtWZXUuEoGedg7jF5ZMY70agUr5S23SYJpUH91uXjPQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A0eWAqtL2/cfAxwV+ePj6fz+xdSJ4oTfn0NuspgHawIW06SSQM0CSlIb5hiFFZxW2DSOdxWbjRdWjyKjWj6MCdBxlBTRwyRRApZ4PITE8d7gTbsSXL2Y6n+nbFixyTjKI7hLLruu3kuF8NUgoFAogDcf5tz+QRS20oCDaVnltA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=tFT97XWC; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cSbM35YMRz9sy4;
	Fri, 19 Sep 2025 04:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1758247247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NOFD29nYgylZR4y6lrNSHBTMAjtJSZxxyA8MWra0xHY=;
	b=tFT97XWCqbRzLQgFcFkPN+vv0ykrRB9WPUIRTya4/sBtZ/SkYxKIw6U+cpOYCibMhRee81
	j2Fr2vfRQhHEtFP5Jyz0Pl0n9AtzxwrUCXfX3QhIHMHMmu/HUIOPh4aLXzEEzGeSxFvz9x
	ZAZ1dgjI1aqfv/McLgm1jGgO3H4PKifkoK1pofhhq1/OfqPLlKLTk3nNRjkxaCNiCjQh6Y
	IJew3E+e1wXOzXM6tpg69LR1AoVKMaXDVQFeg+VmNOyN8TeRGkUFZCcs8+ra577/UO3jXj
	RaSPvpj5ZETEoxDLk/4njB7f52c2dWvyAkyKMtNOsF9PPBn1fvAZ7JbbZUnR1g==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Fri, 19 Sep 2025 11:59:49 +1000
Subject: [PATCH v4 08/10] man/man2/mount_setattr.2: mirror opening sentence
 from fsopen(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250919-new-mount-api-v4-8-1261201ab562@cyphar.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1026; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=xtWZXUuEoGedg7jF5ZMY70agUr5S23SYJpUH91uXjPQ=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWSc2Sk+8WesWcfbRcWd99eYMzryB4qxqm/RmsoZ1y3W+
 PzZV62ojoksDGJcDJZiiizb/DxDN81ffCX500o2mDmsTCBDpEUaGBgYGFgY+HIT80qNdIz0TLUN
 9QwNdYx0jBi4OAVgqvWVGP4nP450WWvwIcTQpbOGt5Rzx/WNTa8LZqYxzAqWm9AYPk2E4Q/f0Q9
 +Zy/nfrnfW7ml/bDSXN6e65bXl87b/FHh8Nr0W47MAA==
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

All of the other new mount API docs have this lead-in sentence in order
to make this set of APIs feel a little bit more cohesive.  Despite being
a bit of a latecomer, mount_setattr(2) is definitely part of this family
of APIs and so deserves the same treatment.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 man/man2/mount_setattr.2 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/man/man2/mount_setattr.2 b/man/man2/mount_setattr.2
index 4b55f6d2e09d00d9bc4b3a085f310b1b459f34e8..b27db5b96665cfb0c387bf5b60776d45e0139956 100644
--- a/man/man2/mount_setattr.2
+++ b/man/man2/mount_setattr.2
@@ -19,7 +19,11 @@ .SH SYNOPSIS
 .SH DESCRIPTION
 The
 .BR mount_setattr ()
-system call changes the mount properties of a mount or an entire mount tree.
+system call is part of
+the suite of file descriptor based mount facilities in Linux.
+.P
+.BR mount_setattr ()
+changes the mount properties of a mount or an entire mount tree.
 If
 .I path
 is relative,

-- 
2.51.0


