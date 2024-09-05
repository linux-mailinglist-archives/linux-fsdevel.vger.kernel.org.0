Return-Path: <linux-fsdevel+bounces-28731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421496D904
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 14:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7EEE28D20F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 12:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A90619FA7A;
	Thu,  5 Sep 2024 12:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQaWluBO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C632A19F489;
	Thu,  5 Sep 2024 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725540128; cv=none; b=PqHOSiOwVfm/AgSDzQsZonm6+YaV1HfUP1XJfx9RHdV/uVeuruerJwn6gIPMmyTDnwvh9RC/uOs4WjOMOt8jWWSJtfTeHhCQqhM8SojnjZSnY5qeP+tmML6Q9/A59rBtdf3UdqVZQ2P4SY6KgLPjzeIStHaAOL6adziOiDTfOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725540128; c=relaxed/simple;
	bh=Bn9/DidrtPQAS60NFDloJmzniywAlNDr2BLuh/aSHD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EUOuxwUWs3QK+cps8nhniu5yfQIaQFUuY/3w9RL5lDeorT06sMSkuhr94lFLNrfdmKmtDs+FihP5QXLHnxBdsSFBT4HZUu6ieCDY2AizvOdB7HxDvm1c62qWESZVT8cx7Udhc2G3c4ftmRF1al5G0h2LOdqwMSv0kgi/P+yjiuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQaWluBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 253E5C4CECA;
	Thu,  5 Sep 2024 12:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725540128;
	bh=Bn9/DidrtPQAS60NFDloJmzniywAlNDr2BLuh/aSHD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=XQaWluBO3WT8tafHrdk0IhYVzqH8+1lIBhIQphRcOc24kOBaoqilSXn3f7czA+mxG
	 rrQC3K661p+/qCh5VWCfYoizDODC3t9sQEur8RXdBeE1ZI08uTgunfy9QwDf1njKL3
	 BpQPKYTMT4pFQFDz1TgdZn5EM5ZQBDetcmxSJMlXxEM5nUQ+W6BBYOAfMZ3DEes3kP
	 L+mtqBKrZti5D75H4ZAcr/09C4OHrfugC5XnGINGc3HR21uCI+9ntNxmRVW9hXPUcP
	 zOM6+BT9m8Km/KSDAnzanrdkfcwxGmB4kJFRktIOLqnmv3q7x2v8oWXpIHAVisgNUm
	 P8yk4CuFMtCDw==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 05 Sep 2024 08:41:50 -0400
Subject: [PATCH v4 06/11] nfs_common: make include/linux/nfs4.h include
 generated nfs4.h
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240905-delstid-v4-6-d3e5fd34d107@kernel.org>
References: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
In-Reply-To: <20240905-delstid-v4-0-d3e5fd34d107@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: Tom Haynes <loghyr@gmail.com>, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Bn9/DidrtPQAS60NFDloJmzniywAlNDr2BLuh/aSHD8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBm2acVCzods9TF2abYmLrqcQeLr31NRqxYN+o77
 RqckLFdppyJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZtmnFQAKCRAADmhBGVaC
 FVH0D/4mJ2IqJBk+7PrujthZrAwN98BP8d/fr8276fs6h3ezY8P68O1vgFpdsqTvpIG4LbtlGwF
 BmnnB+0qnIcBipVByhx3dHdxQMHIl8Jy3Qh+4qTdChpmGh0LxNCFRkKA/LPCJ/Rd9L4QIHvn/zA
 A51kHUwjgR/im6/N54/m+6KLp4Q9++PF8IW0P0UwaAMU7Mt3Tb5UJ4OeH6pDRrTzYqU9GM0B6k/
 J6VvmONBUjUstADtyywNIb/SDWzglQFe7Z1ciEfhy1+wh+lk/c8uJn00BHVpn6IjkiyzBam9UPf
 v+OFa21mv8mkizk4grcL4NmkQFUdsp9FpjtscLW/4HNxMRk+0tPpwi5Ftt/0ej1OvLSfqRY3iCd
 0f5VwTE62VO3Fd67hMIfUfVj48yMPFXTzcXEYau6flaspWII9bRrAndlNcxJopYaCjqnPLqVTde
 Y7THVbSUaQC8kyuCJ7XX4jXAfcoZ6I8RRfPIFbZDxheYmhI/I1sC3Baa7wjfz/wiIIHYFqvCglc
 mJbeanLSByZkabxtSeS6jXlFQjo1Rr3v7yazYZMtqqav8kn/C5O9w7cuBKDgwr4wRM4QmnXiOe/
 SF9jjqJPE/ll75VpF8/gTMdsxPVLKInj6hudLeJrxAM+0lCoXtSZkcCnTjYDwyY15ykNFVt48R5
 Bc8Za8CkIynNkSw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Long term, we'd like to move to autogenerating a lot of our XDR code.
Both the client and server include include/linux/nfs4.h. That file is
hand-rolled, and some of the symbols in it conflict with the
autogenerated symbols from xdrgen.

Have include/linux/nfs4.h include the generated
include/linux/sunrpc/xdrgen/nfs4.h and remove the conflicting
definitions from it and nfs_xdr.h.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/nfs4.h    | 7 +------
 include/linux/nfs_xdr.h | 5 -----
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/include/linux/nfs4.h b/include/linux/nfs4.h
index 8d7430d9f218..87454d5d3365 100644
--- a/include/linux/nfs4.h
+++ b/include/linux/nfs4.h
@@ -17,6 +17,7 @@
 #include <linux/uidgid.h>
 #include <uapi/linux/nfs4.h>
 #include <linux/sunrpc/msg_prot.h>
+#include <linux/sunrpc/xdrgen/nfs4.h>
 
 enum nfs4_acl_whotype {
 	NFS4_ACL_WHO_NAMED = 0,
@@ -512,12 +513,6 @@ enum {
 	FATTR4_XATTR_SUPPORT		= 82,
 };
 
-enum {
-	FATTR4_TIME_DELEG_ACCESS	= 84,
-	FATTR4_TIME_DELEG_MODIFY	= 85,
-	FATTR4_OPEN_ARGUMENTS		= 86,
-};
-
 /*
  * The following internal definitions enable processing the above
  * attribute bits within 32-bit word boundaries.
diff --git a/include/linux/nfs_xdr.h b/include/linux/nfs_xdr.h
index 45623af3e7b8..d3fe47baf110 100644
--- a/include/linux/nfs_xdr.h
+++ b/include/linux/nfs_xdr.h
@@ -1315,11 +1315,6 @@ struct nfs4_fsid_present_res {
 
 #endif /* CONFIG_NFS_V4 */
 
-struct nfstime4 {
-	u64	seconds;
-	u32	nseconds;
-};
-
 #ifdef CONFIG_NFS_V4_1
 
 struct pnfs_commit_bucket {

-- 
2.46.0


