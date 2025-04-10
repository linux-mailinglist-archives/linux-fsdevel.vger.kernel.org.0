Return-Path: <linux-fsdevel+bounces-46198-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCC4A84205
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604683A547F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Apr 2025 11:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356412857C2;
	Thu, 10 Apr 2025 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="OFGIu3Gt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D322285405
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Apr 2025 11:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.23.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744285572; cv=none; b=GS5b9BBdUG+r5Zyssa47oFtLRDjziLjzi50/AxvKK4Uaa2v40L98xP3R3iqxY+gt9KYb16Ty0FNJ2FjucGZXgxNwIAS36aV5LFFiy5CDZ40nZdhTW9qKE4s8CaO0aaNQmFfZ/ltHggY+nNXBwCunFC3QG7z4pTLGFGIYJd0toDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744285572; c=relaxed/simple;
	bh=swxv/69OXoGMQgh78vmQsv5ee1jjhh4aaX6GUHX0zD0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ClhV9KUHw/9TiP6VT7iXmTj+QvKpjlv2tCwbUYQE5qc06BX+gAw41ruOe7tWKTjrtzWqLldwYGM+0DucIk7P2Ngri5vGoTMrNUbE64kf6vqyt4sOFcUDLpV2GTDc28vilkgIKtHIPu2GJUquPrrFBVLlb/pFs1dyOJExUpx/YNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=OFGIu3Gt; arc=none smtp.client-ip=17.58.23.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=7ogrfVUjfpDxF4h8Zei+Mv0WcYgXNX6lZECoUKIoJsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme;
	b=OFGIu3GtVCOg5A+CFVJQN5Qpsfs1qDMCNZlLU2VYFM1KceLSfQyssCZp8kXTeOE0+
	 Ec+b7IW7Avh8V3HnHki/qbOAjdghbySXA43bwxAnCMCHwGL6jwUYrNvu3ZL4vb/b5U
	 nfsFCseXzAU0ehuBL81vvkf5HOlkDotbcm8Ff3oD2CuA3c3pKsW4e2gpg/5kvoya9b
	 J3r28tkwOtme7RlHPRRj/3W0upME644BnDwmu4aQwf9Y6byiWW8fOnaAFEkzM2QzuF
	 sguMS1sgJe3N34fFJ8LcOx51hUQGqMnWQ9kdHXcd2fE0fBcuezXJOmi4MLpfHG6p5q
	 w8ymdTuPMQXtw==
Received: from mr85p00im-zteg06021601.me.com (mr85p00im-zteg06021601.me.com [17.58.23.187])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPS id DC91930585D8;
	Thu, 10 Apr 2025 11:46:09 +0000 (UTC)
Received: from [192.168.1.26] (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
	by mr85p00im-zteg06021601.me.com (Postfix) with ESMTPSA id 9324D30583EB;
	Thu, 10 Apr 2025 11:46:07 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 10 Apr 2025 19:45:31 +0800
Subject: [PATCH 5/5] fs/fs_context: Mark an unlikely if condition with
 unlikely() in vfs_parse_monolithic_sep()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-fix_fs-v1-5-7c14ccc8ebaa@quicinc.com>
References: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
In-Reply-To: <20250410-fix_fs-v1-0-7c14ccc8ebaa@quicinc.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 David Howells <dhowells@redhat.com>
Cc: Zijun Hu <zijun_hu@icloud.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: bh0hhOatG7ST1xaITvng1aKmLh8pS4WA
X-Proofpoint-ORIG-GUID: bh0hhOatG7ST1xaITvng1aKmLh8pS4WA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2504100087
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

There is no mount option with pattern "...,=key_or_value,...", so the if
condition '(value == key)' in while loop of vfs_parse_monolithic_sep() is
is unlikely true.

Mark the condition with unlikely() to improve both performance and
readability.

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 fs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fs_context.c b/fs/fs_context.c
index 582d33e8111739402d38dc9fc268e7d14ced3c49..284301d88bc90ef462a08c9ea893f822075a6d4d 100644
--- a/fs/fs_context.c
+++ b/fs/fs_context.c
@@ -222,7 +222,7 @@ int vfs_parse_monolithic_sep(struct fs_context *fc, void *data,
 			char *value = strchr(key, '=');
 
 			if (value) {
-				if (value == key)
+				if (unlikely(value == key))
 					continue;
 				*value++ = 0;
 				v_len = strlen(value);

-- 
2.34.1


