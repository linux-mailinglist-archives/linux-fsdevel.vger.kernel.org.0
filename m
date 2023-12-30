Return-Path: <linux-fsdevel+bounces-7034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DCE820417
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 10:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2185EB21441
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Dec 2023 09:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5E82584;
	Sat, 30 Dec 2023 09:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="s0aYt+I0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7024E23A5;
	Sat, 30 Dec 2023 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703926805; bh=JhwbLXrg9xb5P3kWXzS/FhXW8uVTkvP/c+tNkfreaxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=s0aYt+I01HVG4w0djuk1tDqHKHtrcyh4mERzbmQZkyYFxJ6ntiFYmSxkNMxhlM6xx
	 DOMyQ0BSWfjco7CLbEKjz58v559wg2XTdDct2g5WasZDMooZYuLPBsSqMzi6opeSbt
	 3TiXnBlisrOWHZZEYjyc/fP+gyQLYxFeT01aqjA8=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id 31FA94; Sat, 30 Dec 2023 17:00:03 +0800
X-QQ-mid: xmsmtpt1703926803tjsu7s8b9
Message-ID: <tencent_C51BB525D6BA72BB25338C9EB41B094B3608@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/uQ6d1i0rpisJz8zTDHyh0uBVnwzQKJOiejgXThC3kq8HRO08Q/
	 Qmt22IQ+MQgsr1fl8h8KsdgsZfUS492UvqiuEpDsVXTPWD1XymN+pl66Rn7TK50GVZmKn0oA1lP0
	 0LLMb3XnPd/36Ofh2z2NbNaMPfJH/mlUHzz2ar2Wpy4U8M6ugu/mrZJKZ4Sie7p+6a/BVnfBo7u2
	 23TD05HmGeA7HCfU5BLNCjaAZW79W+BS7DJiZHS/42237LH2dJwRdJ4iDXxM9V8rbOaUlnzbx3qF
	 ZhJc9ZZfRLseunviQSQ7lQelnB7IQNN/GIWYOdezgaLu9KQ2V4R4gE3lojNpd067m2taRS6MyYLX
	 R8yfH2FbJENWPKoHJ2PV+XEvlZQbF6cJdACFkpH3y7Ibd//6JVWioM56t1wkUrCagtByDI8B6R8G
	 /S1ifnrnD+2ANWHEqv+3Wmg3ffdGepdQwj14HMJJu+Iv/1lysO9ws3JnixtsIsnz9P4dMAme3qZi
	 37AM24bZxoy3MnKVzYgM5BYIIt6WeKhpvV4POWq9YJ6t7dmcrGmhULBmwF4RAhAdW5r5Ci/VlMJx
	 DxZAOvniAqeMBS2qm/t4HdCYmzROu0DJKRCVnTVnrUdDjaTk8EjDVzBN18wniUuwbFaVGoZbB1Xl
	 F7whgSmz7khzl0KuST1I5r0vNK9f0f60PswpbQK9D3yj/KEirSC8ttJC5fdL01sa5VZ+4z6sB7V0
	 LaFyN7gL4Jl56tPLIU5ixbeiFFEW1WRXFPmSemiLyDhoo8AnSuNX8mRgEVLAUnHMRcSqM/6nfcCV
	 L64MgraHhVlCWLkyLpWEtkr2bNXHphyNH5V41dRTEVC2DbmTqnHlyswltvPnvzD4Xm+ghyfI+sHy
	 qAelAX8wIrdzngnY7I1rrlwFsm59H9f8Ue1a5ECKC2fhM9W+gHejyc++L7NadbiY0oiPcQMTv0m3
	 aoFtOs9eM=
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com
Cc: almaz.alexandrovich@paragon-software.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ntfs3@lists.linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH arm64] ntfs3: fix oob in ntfs_listxattr
Date: Sat, 30 Dec 2023 17:00:03 +0800
X-OQ-MSGID: <20231230090002.2305989-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000038cf2f060d7170a9@google.com>
References: <00000000000038cf2f060d7170a9@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of name cannot exceed the space occupied by ea.

Reported-and-tested-by: syzbot+65e940cfb8f99a97aca7@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ntfs3/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 4274b6f31cfa..3b97508a7bf2 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -219,6 +219,9 @@ static ssize_t ntfs_list_ea(struct ntfs_inode *ni, char *buffer,
 		if (!ea->name_len)
 			break;
 
+		if (ea->name_len > ea_size)
+			break;
+
 		if (buffer) {
 			/* Check if we can use field ea->name */
 			if (off + ea_size > size)
-- 
2.43.0



