Return-Path: <linux-fsdevel+bounces-73365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDB7D163BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 02:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E37D1307BF6B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 01:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F61C5F1B;
	Tue, 13 Jan 2026 01:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g0Z+Ukbd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8EB27CCF2;
	Tue, 13 Jan 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768269121; cv=none; b=dHbq+oeVH+nXq79ApOsXnjLztwujwL/gcjNukAOSu0o7xzLGu5YFJ6bAas6/cH5rqcC+kbPDi557eIWz625qW1oQEPm9yFMRi+E3NLex9bULDtxCQ80ivudYMKc5PYTxlvVQamCWXvW0cvL9MG1XM3rRKXQapvH7hT6g4Mg9pY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768269121; c=relaxed/simple;
	bh=P+Ywq5FPG2ciipy3AswaEWw+bKqhkt6uNsUnMuwTwvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gS4kSddLFA3/iXVmm9fmkHeiM1/jy2PiI3nazUmjcHsd4UjAdYWmh4JVwmWznBGZ+o+1MyVMYUboDDju3xAYDFjeyCFu2cDpLzCKehoL89+wHlmhb2tbR5nQ3sr8c62OpE9T4CVogbNF7NNlsx3k+CAG+zdhsAc4RQk5SuCFNFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g0Z+Ukbd; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rxW6eXQVHrIStPv9+cmpoyg9W8dPuOTMMa1waxZTs3w=; b=g0Z+UkbdfFwRMxM73YGiHDr4xi
	O57XyNnp4KShYNTCzZVOmaz+uLUuUayz0RlfGB3RcQ7SyiZQv+kzzwv6mDylAhLHW6Jubwpjkcngx
	AHUEhCeauDZeR2LjZfu1SrbrAmRsv+F2icuAoXW4NRJ5Mza9jvcVx8aNyx3p5nJzThUSWTFO+44Po
	zWazVFQKY9At+3UpxI9z+f19PsSzXvoYrN2R2kf2Fvx68s3tqImrlXEy4IV5DfHKUMz2gg5XeG3VK
	uGU/6Ilyy6uxeSKUIMgazBXnnHPDdjeY2X8vmHUi9DWosKI0HjxZ7puktkO7TNU53w9CDUcBtf69e
	J+eJQXzw==;
Received: from [179.118.187.16] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vfTZX-004eIK-2S; Tue, 13 Jan 2026 02:51:51 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Mon, 12 Jan 2026 22:51:26 -0300
Subject: [PATCH 3/4] exportfs: Complete kernel-doc for struct
 export_operations
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260112-tonyk-fs_uuid-v1-3-acc1889de772@igalia.com>
References: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
In-Reply-To: <20260112-tonyk-fs_uuid-v1-0-acc1889de772@igalia.com>
To: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Write down the missing members definitions for struct export_operations,
using as a reference the commit messages that created the members.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/exportfs.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index bed370b9f906..262e24d83313 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -201,7 +201,7 @@ struct handle_to_path_ctx {
  * @commit_metadata: commit metadata changes to stable storage
  *
  * See Documentation/filesystems/nfs/exporting.rst for details on how to use
- * this interface correctly.
+ * this interface correctly and the definition of the flags.
  *
  * @encode_fh:
  *    @encode_fh should store in the file handle fragment @fh (using at most
@@ -252,6 +252,19 @@ struct handle_to_path_ctx {
  * @commit_metadata:
  *    @commit_metadata should commit metadata changes to stable storage.
  *
+ * @get_uuid:
+ *    Get a filesystem unique signature exposed to clients.
+ *
+ * @map_blocks:
+ *    Map and, if necessary, allocate blocks for a layout.
+ *
+ * @commit_blocks:
+ *    Commit blocks in a layout once the client is done with them.
+ *
+ * @flags:
+ *    Allows the filesystem to communicate to nfsd that it may want to do things
+ *    differently when dealing with it.
+ *
  * Locking rules:
  *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)

-- 
2.52.0


