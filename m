Return-Path: <linux-fsdevel+bounces-7675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5452382930A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 05:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB3731F25A4F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jan 2024 04:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7DDC6FB8;
	Wed, 10 Jan 2024 04:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Awwk7A2T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CE363A0;
	Wed, 10 Jan 2024 04:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704861692; bh=wjCMeyJPmdmkcN4hbqi6emvp6R0v43JLk24xb1h44Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Awwk7A2T4PzATkIkg6KwLHhAQqxm4XQMobVT7EFyJ+Xw5grOEfSXUpHNeqivg6gCl
	 29eeez/yPkpT3YYR3hBi5Fp/XyiJz1MtzXAtM070ORmHE1C049xYXBGKjVDBdQW/uV
	 BIluLEfzd9Bz50N+4IwJo2zB72Id/GRsyPeW5epc=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszc5-1.qq.com (NewEsmtp) with SMTP
	id A5F0C6B3; Wed, 10 Jan 2024 12:41:31 +0800
X-QQ-mid: xmsmtpt1704861691tlezr7gms
Message-ID: <tencent_64ED1B1C2576BA24BB29337D9EC41B454B08@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6SFt+zmNyHqZ+98z5/Sl6tJh+uAFU3n/CCrp1ZxWj3pw3W5MnrV
	 ZSWzA3IGY1gHqDuqcXB6CWYh1HO2WgC9bjwwsUQMcENCiF2yiVXRq537wpEoWHZbYPlQnbIuOubX
	 RxKmhKwfWqESoVEN7aeVThYoRM5XCLf7Tv/dW3YmaD9fjkQbKr+5QKFawmQKyz68L4DaBkAl/ErD
	 6gGB3OCN1qLMz3I4MbIkq6Fyw6Whzx4sDlxqk6peIhHd8Jo7BIkwhccdJNJPzXf6Cbc7HoWbuYe7
	 sK6QJS8itlMd1sg0q6ms/cbyqpYHp6RpAhccZsr+Gc4rFN51x1v1yP+ZcSCh0C2iLPnHua4Vk5Pc
	 qgzj8R4Z5MH3LjknHk3weX6Fz64XSnFqO7uPp/5jaVRogwgtae4Lhex41b5T7D9NLsck1Qfv9Zw0
	 QficAWHhJrMlWSHhOKlIjFl/Yf5rDn6EPDDVaOd3TEXHp5qEOgTihWmK8tUeBYQxMOjrBejL0atG
	 RAWnKtRnDzwC3Ese03fh6tZksjPjchVrR4X7k9zBwstFM0QZNj3bAXlJkW7/dDH1yHlXU8ZoBT9A
	 dhms9CUobb3sBhonJGROo8cvTHXQ7KDAMn6MHBp6xXkWQO82sFi8DWztd/1hjXSbR5iNdLlHh+El
	 ELDhsq67NQlu8Q5p4WrLdnuWfqlKuM9o7zk6MoJq6HDCApemHY4Y22TWcbqsxTnYzAgtjFUZU4k+
	 98FZFB6OWYk/sTzCiJJiBJtkhS0jzhjN8N46EVHgJZqiRhZ+BMl7i0nJ1RN8iQG/e7MHiFfhe8TS
	 YIpnnuWvLs17S/ih3LTc+ijb52VJ4MG4juz/dwBhSfjuuEf2v1YW5axkJepij5EYYcNIKIJgeTi0
	 EQiaZEG758Ojuhi7q/BvDLHcysj6mgmv4EJokrRqkjaNrfP8JByGE3C+WPF5nCUA==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] fs/hfsplus: fix uninit-value in hfsplus_lookup
Date: Wed, 10 Jan 2024 12:41:31 +0800
X-OQ-MSGID: <20240110044130.1484750-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000212ec9060e8754e2@google.com>
References: <000000000000212ec9060e8754e2@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add created_date initialization in hfsplus_iget().

Reported-and-tested-by: syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/hfsplus/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 1986b4f18a90..a95a6a2246a3 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -73,6 +73,7 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	HFSPLUS_I(inode)->flags = 0;
 	HFSPLUS_I(inode)->extent_state = 0;
 	HFSPLUS_I(inode)->rsrc_inode = NULL;
+	HFSPLUS_I(inode)->create_date = 0;
 	atomic_set(&HFSPLUS_I(inode)->opencnt, 0);
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
-- 
2.43.0



