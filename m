Return-Path: <linux-fsdevel+bounces-52092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 466B3ADF601
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097D17AF66A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 18:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C9B2F5462;
	Wed, 18 Jun 2025 18:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Su8aQpXx"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5542EBDD7;
	Wed, 18 Jun 2025 18:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750271690; cv=none; b=silYxpA616EYGctaikV8zSPdC3fN97xwjplhONLUMpPvIwcPLL7GUGCyiXLLYGw+oKM+nWvxEwdjOrru9NPbzE6HVKbepJu+cnYfKCu9jNco3KDfYDu+73eSptcU4WbDWZYyHnWIz0sC0u5b58FRDvZLotoJtXJoMizXCvOFDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750271690; c=relaxed/simple;
	bh=QsmHtOajxMn7MMxuoT9BwNlEIKWybOGo3RLTKVlG6wQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UESIVM7g2apmsKfdcGKIgK0Ay9mkOgvTTRVscDZs3+CAlghvQA/ggxhMwLUlLAxeBWhk9l8HIUCP8Dh26PviC0/Hj0E7pUEtJ0djN4ygk4mh+PZfM16L5od8JV0JQn/N0j1QKDMTMvGqdVqGmCzJungPF8YP1hYi3IXscT1b/xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Su8aQpXx; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bMspr2Zqmz9t2h;
	Wed, 18 Jun 2025 20:34:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1750271684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jxje2HaS1Lf1uTJxtLD4/x7wOmSJoAnmIauCcE9rONo=;
	b=Su8aQpXx9WwdCgXnJiHaoEQY44SRQrsE+8IEeDRn4oUZvo1wDlVZXU6ScSvDCBhcCXVQAS
	RXxNsGsqmtoq2L+bQwxSUgTbp0MQLTrnoQDDvom+2tupvCy3WITbueP896h1Wirz0pcsVx
	2gHxGUsYk/Xk6rLqmxV44EawOCOpFv+1SYuw7HfAMCDh+zxOlAZHtjh2Db8Vd/mD6BioBw
	YcyJvYs3jX+0kOETopnctrCaMXMlE9Q+UfrQKnG7RO7fV6/pNES5MDqTS9khkfcIEAFAp/
	c91Hv+d2ru1q5/qmasHs8sC4hzPVj+bJZAjy/Otf7NibNE3TRT2Pi/6dYwznig==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 19 Jun 2025 04:34:30 +1000
Subject: [PATCH] chmod.2: document fchmodat(AT_EMPTY_PATH)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-fchmod-empty-path-v1-1-feff2c63abe4@cyphar.com>
X-B4-Tracking: v=1; b=H4sIALYGU2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDM0NL3bTkjNz8FN3U3IKSSt2CxJIMXXMzC4NUi6QkUxMLQyWgvoKi1LT
 MCrCZ0bG1tQBT4xexYwAAAA==
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, Alexey Gladkov <legion@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1528; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=QsmHtOajxMn7MMxuoT9BwNlEIKWybOGo3RLTKVlG6wQ=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWQEs+0zUKmPPyLne/zq4WVq6izOgl9f+24MKPhqt+9TW
 5Zjg61yRykLgxgXg6yYIss2P8/QTfMXX0n+tJINZg4rE8gQBi5OAZjIhXyG/xU1tYbGZ6fZ6Sx9
 b7HQJfWudlXUavVPy/0/tr36WaYWr8HIMOGjoLRzQmlkwty9jcaJql/vLBcqyFeu/HxfK6xN4YM
 xIwA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4bMspr2Zqmz9t2h

The documentation and behaviour is indentical to the equivalent flag for
fchownat(2).

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
This was added back in 2023, but I forgot to send the documentation
patch for this and only noticed when I was trying to use it and realised
it wasn't in the man page -- mea culpa!
---
 man/man2/chmod.2 | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/man/man2/chmod.2 b/man/man2/chmod.2
index 307589481593..671e256ba525 100644
--- a/man/man2/chmod.2
+++ b/man/man2/chmod.2
@@ -190,7 +190,30 @@ is absolute, then
 is ignored.
 .P
 .I flags
-can either be 0, or include the following flag:
+can either be 0, or include the following flags:
+.TP
+.BR AT_EMPTY_PATH " (since Linux 6.6)"
+.\" commit 5daeb41a6fc9d0d81cb2291884b7410e062d8fa1
+If
+.I path
+is an empty string, operate on the file referred to by
+.I dirfd
+(which may have been obtained using the
+.BR open (2)
+.B O_PATH
+flag).
+In this case,
+.I dirfd
+can refer to any type of file, not just a directory.
+If
+.I dirfd
+is
+.BR AT_FDCWD ,
+the call operates on the current working directory.
+This flag is Linux-specific; define
+.B _GNU_SOURCE
+.\" Before glibc 2.16, defining _ATFILE_SOURCE sufficed
+to obtain its definition.
 .TP
 .B AT_SYMLINK_NOFOLLOW
 If

---
base-commit: 471c38fb3c5c53c6df2fad4a7353559b330c1323
change-id: 20250619-fchmod-empty-path-7680e8bb5481

Best regards,
-- 
Aleksa Sarai <cyphar@cyphar.com>


