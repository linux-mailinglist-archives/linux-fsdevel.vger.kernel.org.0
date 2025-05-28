Return-Path: <linux-fsdevel+bounces-49999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1147BAC72C5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 23:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74CA93A701F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 May 2025 21:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFB188006;
	Wed, 28 May 2025 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klv6YtmP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2952DCC07;
	Wed, 28 May 2025 21:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748467893; cv=none; b=ELJEjuHw2Q2Huk1g7zYEYG+E7k3+ocBxGU3FfcDK3sx/P772a/BcsByUrMtNS24rNSa3tFOxaMOHCeVCKhrcvpbkKqrD8+gPvqkSzA6/10XvOWbWf25MWE8yxZbQGT97TuZ6MnpkzeDh/24xfeYbGIwwQlbpkgAS6Jrk3Qr7VjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748467893; c=relaxed/simple;
	bh=ZA5HvC3hy8Qskc4kZk5N8Frhfc23RTxU/kKzGnUmLps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxYU3mJID52os9PQ0krg8zW2a+olI5TcWK7wD6tO/sI8d9Ph4neqIoYZwyHd3P8Zo9a3U08l1AEBGSQKn61jQ074Y75b2xskwJgtKq8RtxLVa/BuMmwUmR3Xwq/NBYoCwntB+ZatA5Qxsr9llb8SzTVIxes5kXmw9YsS55QPZZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klv6YtmP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F1FC4CEE3;
	Wed, 28 May 2025 21:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748467892;
	bh=ZA5HvC3hy8Qskc4kZk5N8Frhfc23RTxU/kKzGnUmLps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=klv6YtmPLUFX91rd9RdzwmbO1/sSi0Yj2Tjyq66t916O62G+xgvbFbFWhwqW4TNUs
	 nweoB+vl0wiUNxy4Hs0ViVZAtHkO+zCeGUGBTn1SIcEUqx1g4yI1Oi8/fHVvcC8RVA
	 9wkr4NaY6gFk0CSEZ+bY6eaRkGzj2T/T1Cp/+fZGJPB6NX7GnQxrVdC1VmQo3njwzV
	 72YuU8ZdXzBPDqgQJ2jBkr8+LnuXgBIF4owWpigNYdv37xK1wYGSLei8VlNvXNsHlG
	 gIX+4lZJuU41Zoo1o4UW70nSOMa7PShaDPQPgVlkfsnud2On0pKa8Kk3mPjFB1eulo
	 c62N14Y+tozWQ==
Date: Wed, 28 May 2025 23:31:29 +0200
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: [RFC v1] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <c27a2d7f80c7824918abe5958be6b5eb2dbe8278.1748467845.git.alx@kernel.org>
X-Mailer: git-send-email 2.49.0
References: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <h7mdd3ecjwbxjlrj2wdmoq4zw4ugwqclzonli5vslh6hob543w@hbay377rxnjd>

Suggested-by: Pali Rohár <pali@kernel.org>
Co-authored-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man/man3/readdir.3      | 22 +++++++++++++++++++++-
 man/man3type/stat.3type | 16 +++++++++++++++-
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
index b9150160b..ad9c76595 100644
--- a/man/man3/readdir.3
+++ b/man/man3/readdir.3
@@ -58,7 +58,27 @@ .SH DESCRIPTION
 structure are as follows:
 .TP
 .I .d_ino
-This is the inode number of the file.
+This is the inode number of the file,
+which belongs to the filesystem
+.I .st_dev
+(see
+.BR stat (3type))
+of the directory on which
+.BR readdir ()
+was called.
+If the directory entry is the mount point,
+then
+.I .d_ino
+differs from
+.IR .st_ino :
+.I .d_ino
+is the inode number of the underlying mount point,
+while
+.I .st_ino
+is the inode number of the mounted file system.
+According to POSIX,
+this Linux behavior is considered to be a bug,
+but is nevertheless conforming.
 .TP
 .I .d_off
 The value returned in
diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
index ee801bcec..835626775 100644
--- a/man/man3type/stat.3type
+++ b/man/man3type/stat.3type
@@ -66,7 +66,21 @@ .SH DESCRIPTION
 macros may be useful to decompose the device ID in this field.)
 .TP
 .I .st_ino
-This field contains the file's inode number.
+This field contains the file's inode number,
+which belongs to the
+.IR .st_dev .
+If
+.BR stat (2)
+was called on the mount point,
+then
+.I .d_ino
+differs from
+.IR .st_ino :
+.I .d_ino
+is the inode number of the underlying mount point,
+while
+.I .st_ino
+is the inode number of the mounted file system.
 .TP
 .I .st_mode
 This field contains the file type and mode.

Range-diff against v0:
-:  --------- > 1:  c27a2d7f8 man/man3/readdir.3, man/man3type/stat.3type: Improve documentation about .d_ino and .st_ino
-- 
2.49.0


