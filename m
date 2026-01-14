Return-Path: <linux-fsdevel+bounces-73790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4C3D20928
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 18:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 217C8302E30F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 17:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26DC30B527;
	Wed, 14 Jan 2026 17:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHdLZvum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240673033F1;
	Wed, 14 Jan 2026 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768412145; cv=none; b=sLhPgswAdfhk4GIH5sR/ZtbCbQiXWI9KJI+1ygG1Of6tEa1Zljs74G2Tn7/gU2xI1z7LmwpcxW7br/H36x9oPLUJx/3+hKA6C4oPmnzA9Br8UxxkC6+p6e3gwmYy3TqjQqwa0Z84qyXXT1to/m7UQUUrZnYm823qA/9QsYFlUtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768412145; c=relaxed/simple;
	bh=keTbcQdGaBPEh0rD0E9o/NIZZW2dTCXvbS17oGc3BGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VVoD9zOYULeijavX/LmSTEmqsyFZPcL18+ZBGxAtryUHwPmmg90mIMh8ncNT5hD0XfSsPuOn7GaSPNtJ6iZuSyHgmTrx34L4rBjriZJNCVOW71nG0iDEKyRiaNjGcbcC//Zt3+yYyW/TiqczM/jM6ML06jAWJFM2MiMxlFmLviU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHdLZvum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F01C4CEF7;
	Wed, 14 Jan 2026 17:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768412144;
	bh=keTbcQdGaBPEh0rD0E9o/NIZZW2dTCXvbS17oGc3BGg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MHdLZvumfNpRYDY/owAP2VJP7dCI9O/3W+1/O8M4p4NZ7H19C5lrXady7k9glTuhY
	 fWldlKuOWiyDc2Jy2B1X5JLBJNMo3rNuEvvxBLe5+kQk2nDra1sIHFyHiCilhfFbch
	 sCEh5rrNOxe8Mz+01KxESpStVUZOo2rZZGNpavU+j6t7ytzOWqZRgVxPRZ0/Wdo1UW
	 hJ7Bphte7M8eiqFoW8+h0Y8+Z8vkBXF+LQljiKL31UbMExtx/I3XuQBKrpFOxSVjWS
	 n+6yUoGkvY7GM9aZRGRiFepLXAHVamgPIg2xdVpgUL2vDQurm+kfSLJ7WkkRGlG6Bo
	 FwgRkZOHcrNcA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 14 Jan 2026 12:35:25 -0500
Subject: [PATCH man-pages v2 2/2] man/man2const: clean up the F_GETLEASE
 manpage
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260114-master-v2-2-719f5b47dfe2@kernel.org>
References: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
In-Reply-To: <20260114-master-v2-0-719f5b47dfe2@kernel.org>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2263; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=keTbcQdGaBPEh0rD0E9o/NIZZW2dTCXvbS17oGc3BGg=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpZ9Pu2WN/TOOOXjppkaLst77ulVFzmTs9ZftG7
 r1uL3Kzs2WJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaWfT7gAKCRAADmhBGVaC
 FdTVD/9zb2tmJLi52pX5H1QscuzEr68dzTTFlo6EdvvqQe51dJtUIcjedlSaDlYxRVmur6+OMzS
 LQoBgNqZMibljbMzmct8u0Kb0+6XqYXs/3mkcEJe5kc/OaFgEPQOHdzFsq4kA6zs15M/bNLExtO
 UDB/Oqr0VEoA7LnqzSwdcUbtH0lyHDF8qGAA1tJefJ7b4dyFvybcrBTIDXStcyeN6xA17nlgX7v
 lyDPgZd8id/lNHBd5joB214U03ghGhNaSqhtdqtIpJF8aRJ+YL2dFyxHd1kCbxukUJccYIJ7hn1
 96gYlHN/CFjueNYZ09eHazf0NNPHPCxTb6Rouao/aUJ25s42PdkcdjfIQTZpfYcTy7M9UPXCtsj
 gj2m+m2Gs1CZy6C4R9VHnPVEPaxCm4esF4mzLCrT+XVvv9stHHK4Xv80JpqbfznSdQIvAmekwER
 Gh/jCWM8IsoLUp5kpQgbliZx+M82eIOSzQmOzIDQJwv5NLZsgBVqslBqXk/vMsYLGDxBoT/Hxc2
 dSG5SumqCN5M9cFTwrsOFdHmBEvZRBSbZP86GBI4K4LmDLJS9TanHF2H5ZFx9yeQ/MpNK63U6KQ
 1583tN3XJduOel5IZExciocfcOoHcfIb3S3pjSr1rqkDQAFoarLC1oPvx4D8IEXww3iZioDvCtf
 Va4DjqZbsFj219g==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

- Remove a redundant subsection heading
- Add in the lease-specific error codes
- Clean up some semantic newline warts

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 man/man2const/F_GETLEASE.2const | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/man/man2const/F_GETLEASE.2const b/man/man2const/F_GETLEASE.2const
index 10f7ac7a89a70b83be10a381462d879cff813471..e841f7f8c7c64ba8c6868e68d493716040e3dec2 100644
--- a/man/man2const/F_GETLEASE.2const
+++ b/man/man2const/F_GETLEASE.2const
@@ -20,7 +20,6 @@ Standard C library
 .BI "int fcntl(int " fd ", F_GETLEASE);"
 .fi
 .SH DESCRIPTION
-.SS Leases
 .B F_SETLEASE
 and
 .B F_GETLEASE
@@ -43,7 +42,7 @@ values is specified in the integer
 .RS
 .TP
 .B F_RDLCK
-Take out a read lease.
+Establish a read lease.
 This will cause the calling process to be notified when
 the file is opened for writing or is truncated.
 .\" The following became true in Linux 2.6.10:
@@ -52,7 +51,7 @@ A read lease can be placed only on a file descriptor that
 is opened read-only.
 .TP
 .B F_WRLCK
-Take out a write lease.
+Establish a write lease.
 This will cause the caller to be notified when
 the file is opened for reading or writing or is truncated.
 A write lease may be placed on a file only if there are no
@@ -86,8 +85,11 @@ capability may take out leases on arbitrary files.
 Indicates what type of lease is associated with the file descriptor
 .I fd
 by returning either
-.BR F_RDLCK ", " F_WRLCK ", or " F_UNLCK ,
-indicating, respectively, a read lease , a write lease, or no lease.
+.BR F_RDLCK,
+.BR F_WRLCK,
+or
+.BR F_UNLCK,
+indicating, respectively, a read lease, a write lease, or no lease.
 .I arg
 is ignored.
 .P
@@ -196,6 +198,16 @@ is set to indicate the error.
 .SH ERRORS
 See
 .BR fcntl (2).
+These operations can also fail with the following error codes:
+.TP
+.B EAGAIN
+The operation is prohibited because the file is open in a way that conflicts with the requested lease.
+.TP
+.B EINVAL
+The operation is prohibited because the underlying filesystem doesn't support leases,
+or because
+.I fd
+does not represent a regular file.
 .SH STANDARDS
 Linux.
 .SH HISTORY

-- 
2.52.0


