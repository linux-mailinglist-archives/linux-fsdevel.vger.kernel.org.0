Return-Path: <linux-fsdevel+bounces-59123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C963B34A08
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 20:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D6713A21AA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F16E309DB0;
	Mon, 25 Aug 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="SK233mkq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF6B30AAD7;
	Mon, 25 Aug 2025 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145732; cv=pass; b=Wkvn6YiXzFbNsog7eRI4eWrT7VmfW2yoDdFOtyR/OJ7ThnJyeaNOlqOcNVskRmH2zT+TxVx183tvFZOPIHMCw/EGD+MgHmgtwna5FZ3Q3VzBou6oRmsclWQk2ZJqbRVgzi8OzhiQ+1AejRnRswtfjBmV9poonx7kR+F36g26hvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145732; c=relaxed/simple;
	bh=QSuJFG9WEOu7hrAhCZO92w8PGwNMTMIRZ431SGwMOyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDHVvb3OgApAK1I6AzoW9/EVVEvnR4dfa0V1f7Ar4/N06ZPOTEXcLibHQ6CeZOAJSVYkqizioQlepcNS0ZwewdfrCJaOdHkrwi6ZPtIdZW3/JaOSPOF+YYgLO2XXiG3zoL0+giUrpfO6vJdGkFLJ07NvznTmnJr31vJZSoz2XcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=SK233mkq; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145584; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Agb4Disii1aOKD0QGJCGIclW1/jOqIjvnNQNrV9qM+Sbtg2OzjrJ/WxKNdXlDZ+xqmzONfgu6stZdICovFFOp6e981e8tKSwbgpEQkMGDty7V/jBABphOs5dKCcRkSbCPl4GzNpUWLsPFtSCOMEhULjW/Bv0D31il4QTjVHbFNQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145584; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JlC3DgQSXz1hIeG6AMRPoFdwWbDvOMu8QglF3XjZpik=; 
	b=B4s1FuS2sCQr9kXH6/7aG4wUbxH3nVgxEGZsl2xjQPPq6BPOLmJdlCjjHojb8Dc5dqLLKstRPJPHgNCEjwgdpb2hjILZE2/NlcVoBkiYVluCBSUNf9c6oCeaWUVM210xRXRT2BF/GgUjSkkEjzR8ICYyo9WzWsOeDZoldjy6pUs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145584;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=JlC3DgQSXz1hIeG6AMRPoFdwWbDvOMu8QglF3XjZpik=;
	b=SK233mkqloN9Bb6HdpCjwQFBWnXiXjDpDhGpvyg6QEOeyz7yXaOYDiztrSE4kuwa
	arc9mf0qEpUQWzxbwAVyD9ftMxi54tstCv9B8ZP+yu/umzF6+eoqYHm4e61PNSbuewb
	ANJPWgrBLuWlhJHEbHHQCCDUpNN5SEFUvlnk8WJA=
Received: by mx.zohomail.com with SMTPS id 1756145580669449.3528756808671;
	Mon, 25 Aug 2025 11:13:00 -0700 (PDT)
From: Askar Safin <safinaskar@zohomail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	cyphar@cyphar.com,
	Ian Kent <raven@themaw.net>,
	autofs mailing list <autofs@vger.kernel.org>,
	patches@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] openat2: don't trigger automounts with RESOLVE_NO_XDEV
Date: Mon, 25 Aug 2025 18:12:33 +0000
Message-ID: <20250825181233.2464822-5-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250825181233.2464822-1-safinaskar@zohomail.com>
References: <20250825181233.2464822-1-safinaskar@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227bb229794dc1e7f0bd79612fe000065eefe797c6f42aaa0d3a50188bf1faf0d872d330211ac8a8f:zu0801122788997f44b63b81177147c6b5000074ee63011c9a870dc19350f050d68c8a5d87dd474dd09f7aba:rf0801122c949435d49ef9dfd721dd97ed00005c4e911c980755f326c1ade71c02278950f69665d2f53edaa7f93762540b:ZohoMail
X-ZohoMailClient: External

openat2 had a bug: if we pass RESOLVE_NO_XDEV, then openat2
doesn't traverse through automounts, but may still trigger them.
(See the link for full bug report with reproducer.)

This commit fixes this bug.

Link: https://lore.kernel.org/linux-fsdevel/20250817075252.4137628-1-safinaskar@zohomail.com/
Fixes: fddb5d430ad9fa91b49b1 ("open: introduce openat2(2) syscall")
Reviewed-by: Aleksa Sarai <cyphar@cyphar.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Askar Safin <safinaskar@zohomail.com>
---
 fs/namei.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index c23e5a076ab3..bfa8232b94dc 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1449,6 +1449,10 @@ static int follow_automount(struct path *path, int *count, unsigned lookup_flags
 	    dentry->d_inode)
 		return -EISDIR;
 
+	/* No need to trigger automounts if mountpoint crossing is disabled. */
+	if (lookup_flags & LOOKUP_NO_XDEV)
+		return -EXDEV;
+
 	if (count && (*count)++ >= MAXSYMLINKS)
 		return -ELOOP;
 
@@ -1472,6 +1476,10 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 		/* Allow the filesystem to manage the transit without i_rwsem
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
+			if (lookup_flags & LOOKUP_NO_XDEV) {
+				ret = -EXDEV;
+				break;
+			}
 			ret = path->dentry->d_op->d_manage(path, false);
 			flags = smp_load_acquire(&path->dentry->d_flags);
 			if (ret < 0)
-- 
2.47.2


