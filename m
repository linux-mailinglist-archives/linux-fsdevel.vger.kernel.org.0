Return-Path: <linux-fsdevel+bounces-76699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g400JfTaiWnfCgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:02:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C5A10F560
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Feb 2026 14:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03826302A51B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Feb 2026 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE05A371063;
	Mon,  9 Feb 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b="V6tttwc+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relayaws-01.paragon-software.com (relayaws-01.paragon-software.com [35.157.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4340C36E493;
	Mon,  9 Feb 2026 11:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.157.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770637338; cv=none; b=WeBIp4kKUby5QhOrvhhNFtDTgM64+P4F0KEPvBn2eytLkAX6WiqhZmcDHuK1H+GWSo0JtT/h7gvYAVfwfQOxA8UbX2xfO9fyq8dLEQboebhm93H1BNDlukSJQkruMbtM0u7liK656mccJSh6wNqvucnp1WfovmPQrfDN+3Tgxbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770637338; c=relaxed/simple;
	bh=W1R5Lkr6OGyN62fatEgVQPoTJAaLT7msIvlxnFtSc9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W2FzNR+zrW0Kra4EI9ZFhlT7sxyMiKtwwTuuBRq3GR8qVxX5cyaaGk+6oAtuSUC+gvONR80IjU7mHr7cLZstErApdOWZBQ7qbXSIC/blqny+N67iSAb9NCmvbj3tIWKaRsAKLC65j71u49F3k9qFLFB3/0NPimacFOBpSgHXcoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com; spf=pass smtp.mailfrom=paragon-software.com; dkim=pass (1024-bit key) header.d=paragon-software.com header.i=@paragon-software.com header.b=V6tttwc+; arc=none smtp.client-ip=35.157.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=paragon-software.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paragon-software.com
Received: from relayfre-01.paragon-software.com (unknown [176.12.100.13])
	by relayaws-01.paragon-software.com (Postfix) with ESMTPS id 4E3D5C4;
	Mon,  9 Feb 2026 11:40:09 +0000 (UTC)
Authentication-Results: relayaws-01.paragon-software.com;
	dkim=pass (1024-bit key; unprotected) header.d=paragon-software.com header.i=@paragon-software.com header.b=V6tttwc+;
	dkim-atps=neutral
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
	by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 731C02092;
	Mon,  9 Feb 2026 11:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=paragon-software.com; s=mail; t=1770637336;
	bh=QgKnAXijeBPuKt32yy+dSdxLtU6sC2BbK9xQGGUVPyU=;
	h=From:To:CC:Subject:Date;
	b=V6tttwc+twm8rpPHVkEMrZmc1oYTmk0Strbn+V8gaSNfwxjRG53iiRSf2WjCVnlYK
	 ynodzFbM8em8P/vUjdEzgbNQ/Bc2ZonRD//Gr9YzNd0KfzX3FE32Q3cE9EwqJ4F89f
	 A39Zx7+fOUblN7TIRbWqLZFN1VGtjS7ipvCSGd0k=
Received: from localhost.localdomain (172.30.20.167) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 9 Feb 2026 14:42:14 +0300
From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To: <ntfs3@lists.linux.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, kernel test
 robot <lkp@intel.com>
Subject: [PATCH] fs/ntfs3: add fall-through between switch labels
Date: Mon, 9 Feb 2026 12:42:06 +0100
Message-ID: <20260209114206.7307-1-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[paragon-software.com,quarantine];
	R_DKIM_ALLOW(-0.20)[paragon-software.com:s=mail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-76699-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[almaz.alexandrovich@paragon-software.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[paragon-software.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 55C5A10F560
X-Rspamd-Action: no action

Add fall-through to fix the warning in ntfs_fs_parse_param().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602041402.uojBz5QY-lkp@intel.com/
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/ntfs3/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 4f423d3a248c..a3c07f2b604f 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -385,6 +385,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 		break;
 	case Opt_acl_bool:
 		if (result.boolean) {
+			fallthrough;
 		case Opt_acl:
 #ifdef CONFIG_NTFS3_FS_POSIX_ACL
 			fc->sb_flags |= SB_POSIXACL;
-- 
2.43.0


