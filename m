Return-Path: <linux-fsdevel+bounces-66576-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCA5C2492F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 11:47:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38E025629FA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Oct 2025 10:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDE4340A51;
	Fri, 31 Oct 2025 10:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ksb83KW1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF71F2C34;
	Fri, 31 Oct 2025 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907457; cv=none; b=ivQ8QN1jboBdc2EQRJLiKcNGdZ9+nz86ntIW1YYN7q4uTVje3NzoglePOoe5haXam0Lp9t2F4YCqzl7tyuCbCStN59xU/IFrziKR/WU9Xz4eEdxSTyjjDODM7sChzCwdSyyNvm7KJjerYz0Z5umXsHSb4f3uuxqr1+KX4fS8xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907457; c=relaxed/simple;
	bh=BOTABqyQPYcWiLb75ejnbbz1/8lvEOtc3qM7xAltJZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekB19MAMc0RbKpVRNCCjCvws1QPCb6hi1bWXLHheGB5r3LONZG86YWGUR7DzYKTo8wusJKyyRwONlnJbhSSE37PQ+s+IsITYQY/CLgad0yQsCHIhQA0fY7USb7tgJ2jobljU2Q+1Rh9DG3z6DfSZ0OjIcXbpusA2BcLTAJWmdTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ksb83KW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AFDC4CEFB;
	Fri, 31 Oct 2025 10:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761907457;
	bh=BOTABqyQPYcWiLb75ejnbbz1/8lvEOtc3qM7xAltJZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ksb83KW1/hEj0UpQBuKXDAUDXGg1TIIAngFxXJkJGmJFW3VZBDrzgcVhFIELM5xEn
	 6As9kAsH0O/sSpWYlPRF4iuwt/7qj2ZrnQm0VTPbRxAjZSqqVZVuz5n4r78R6mYbTY
	 fkBMTTHUOe2t8i7NjpJZCsJ0BLXpHelAIKUZJ4NXtmfpqe3DXS/qRb+/6mC+NKv9Ro
	 Fp5hAyfR5Ch8+6VSJ6JS6OhcD7UvfL/cZmwdntmLSX/7guDHtHYzhu/VIXaUGEw62K
	 qzTki1W8jMLpms4ycrzXMQkk0JQlXbNFnrezqTkcHx7uKUp7Cvay+g0WqYvpVnYCrV
	 dDImrETy4ekHA==
Date: Fri, 31 Oct 2025 11:44:14 +0100
From: Alejandro Colomar <alx@kernel.org>
To: linux-man@vger.kernel.org
Cc: Alejandro Colomar <alx@kernel.org>, 
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>, Jan Kara <jack@suse.cz>, 
	"G. Branden Robinson" <branden@debian.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH v3] man/man3/readdir.3, man/man3type/stat.3type: Improve
 documentation about .d_ino and .st_ino
Message-ID: <bfa7e72ea17ed369a1cf7589675c35728bb53ae4.1761907223.git.alx@kernel.org>
X-Mailer: git-send-email 2.51.0
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
Co-authored-by: Jan Kara <jack@suse.cz>
Cc: "G. Branden Robinson" <branden@debian.org>
Cc: <linux-fsdevel@vger.kernel.org>
Signed-off-by: Alejandro Colomar <alx@kernel.org>
---

Hi Jan,

I've put your suggestions into the patch.  I've also removed the
sentence about POSIX, as Pali discussed with Branden.

At the bottom of the email is the range-diff against the previous
version.


Have a lovely day!
Alex

 man/man3/readdir.3      | 19 ++++++++++++++++++-
 man/man3type/stat.3type | 20 +++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/man/man3/readdir.3 b/man/man3/readdir.3
index e1c7d2a6a..220643795 100644
--- a/man/man3/readdir.3
+++ b/man/man3/readdir.3
@@ -58,7 +58,24 @@ .SH DESCRIPTION
 structure are as follows:
 .TP
 .I .d_ino
-This is the inode number of the file.
+This is the inode number of the file
+in the filesystem containing
+the directory on which
+.BR readdir ()
+was called.
+If the directory entry is the mount point,
+then
+.I .d_ino
+differs from
+.I .st_ino
+returned by
+.BR stat (2)
+on this file:
+.I .d_ino
+is the inode number of the mount point,
+while
+.I .st_ino
+is the inode number of the root directory of the mounted filesystem.
 .TP
 .I .d_off
 The value returned in
diff --git a/man/man3type/stat.3type b/man/man3type/stat.3type
index 76ee3765d..ea9acc5ec 100644
--- a/man/man3type/stat.3type
+++ b/man/man3type/stat.3type
@@ -66,7 +66,25 @@ .SH DESCRIPTION
 macros may be useful to decompose the device ID in this field.)
 .TP
 .I .st_ino
-This field contains the file's inode number.
+This field contains the file's inode number
+in the filesystem on
+.IR .st_dev .
+If
+.BR stat (2)
+was called on the mount point,
+then
+.I .st_ino
+differs from
+.I .d_ino
+returned by
+.BR readdir (3)
+for the corresponding directory entry in the parent directory.
+In this case,
+.I .st_ino
+is the inode number of the root directory of the mounted filesystem,
+while
+.I .d_ino
+is the inode number of the mount point in the parent filesystem.
 .TP
 .I .st_mode
 This field contains the file type and mode.

Range-diff against v2:
1:  d3eeebe81 ! 1:  bfa7e72ea man/man3/readdir.3, man/man3type/stat.3type: Improve documentation about .d_ino and .st_ino
    @@ Commit message
     
         Suggested-by: Pali Rohár <pali@kernel.org>
         Co-authored-by: Pali Rohár <pali@kernel.org>
    +    Co-authored-by: Jan Kara <jack@suse.cz>
         Cc: "G. Branden Robinson" <branden@debian.org>
         Cc: <linux-fsdevel@vger.kernel.org>
         Signed-off-by: Alejandro Colomar <alx@kernel.org>
    @@ man/man3/readdir.3: .SH DESCRIPTION
      .TP
      .I .d_ino
     -This is the inode number of the file.
    -+This is the inode number of the file,
    -+which belongs to the filesystem
    -+.I .st_dev
    -+(see
    -+.BR stat (3type))
    -+of the directory on which
    ++This is the inode number of the file
    ++in the filesystem containing
    ++the directory on which
     +.BR readdir ()
     +was called.
     +If the directory entry is the mount point,
     +then
     +.I .d_ino
     +differs from
    -+.IR .st_ino :
    ++.I .st_ino
    ++returned by
    ++.BR stat (2)
    ++on this file:
     +.I .d_ino
    -+is the inode number of the underlying mount point,
    ++is the inode number of the mount point,
     +while
     +.I .st_ino
    -+is the inode number of the mounted file system.
    -+According to POSIX,
    -+this Linux behavior is considered to be a bug,
    -+but is nevertheless conforming.
    ++is the inode number of the root directory of the mounted filesystem.
      .TP
      .I .d_off
      The value returned in
    @@ man/man3type/stat.3type: .SH DESCRIPTION
      .TP
      .I .st_ino
     -This field contains the file's inode number.
    -+This field contains the file's inode number,
    -+which belongs to the
    ++This field contains the file's inode number
    ++in the filesystem on
     +.IR .st_dev .
     +If
     +.BR stat (2)
     +was called on the mount point,
     +then
    -+.I .d_ino
    -+differs from
    -+.IR .st_ino :
    -+.I .d_ino
    -+is the inode number of the underlying mount point,
    -+while
     +.I .st_ino
    -+is the inode number of the mounted file system.
    ++differs from
    ++.I .d_ino
    ++returned by
    ++.BR readdir (3)
    ++for the corresponding directory entry in the parent directory.
    ++In this case,
    ++.I .st_ino
    ++is the inode number of the root directory of the mounted filesystem,
    ++while
    ++.I .d_ino
    ++is the inode number of the mount point in the parent filesystem.
      .TP
      .I .st_mode
      This field contains the file type and mode.

base-commit: f305f7647d5cf62e7e764fb7a25c4926160c594f
-- 
2.51.0


