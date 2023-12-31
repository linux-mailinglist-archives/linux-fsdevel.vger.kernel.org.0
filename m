Return-Path: <linux-fsdevel+bounces-7042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7500820972
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 02:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621B5283BAC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 01:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CD4A49;
	Sun, 31 Dec 2023 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="OpP4hxLk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73172658;
	Sun, 31 Dec 2023 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1703985009; bh=mx0sCWNRfBLx3ezGSOMtDchdS/1eDlFrWCt0iQUhKNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OpP4hxLkOmTkVLj3scT2XftWMuhi13YpPQHW6AlgjPV/8za3/fDH6CD5u3XxPMIwt
	 6iVoK0NBUe1eIT3BXi6uunNf8/sEXmCV0woP89eR2/eY7rjZ0JxVLeHB/XlrdjSU+0
	 piP4IftdbHb8KaGUn5P4MqyYR1WptCYe+OS6sAIA=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 10432694; Sun, 31 Dec 2023 09:04:04 +0800
X-QQ-mid: xmsmtpt1703984644twpxpbfs7
Message-ID: <tencent_897491761D662E3D7336B297BA37064A7C09@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70OXQzeMyHWZy5rl5KZS7wqodldixfgh69aF9vkvxWz4muaOD10b
	 aBMQtRPP9MzBwYafBYQ0VvVUaglXQzyppcC9sw9rVrJCjwpAL69X+lxMZ+vIEsx9MCWByj6n5cSk
	 H8K2PPzCvOMjNH0l3Qv7xPs1wu1AANyiHr49kzq/6zfzy/6paTq2Li7vBfwGhXy9nydGvo78d109
	 bXtFFle6CbOOciTvPabkHnIQs8NQRyyyk0MTYI8ggPooGl++k+bDPOlmDpjvftxhe7kKOXaLQMU+
	 REMp3xndVQFZ6xL2vHMvbIRzetb0k+XtHWWCiDWR7heSY8byDz5ohpzvTRxg1FCNhx4CmYyj7e28
	 ReDNLfn5pFYMWyPXY7n6cPn9DVHQLddrULMYf7Lehusysdj6Q1BAvHBNPwrpgD6ML12ZywL/ieK6
	 XoYWwzAASzyEhSq1VXWCqe3z9cqqkXv5FCQgYJUUS0vjJnM0RQnPgikMOksyikmEFISTnwgtloRF
	 PYNCHeOZ+UMugUqsruI1q1cZFrOy+ronPdwjo1Y7sw0irTsUPYN95DBCOUytOq/18UrMJKIWQYGu
	 f1qeM2PHoLBNJsNDqKYCcxaGItIhg0g2WuFt8ybr3rLrSV55IS+c5EMstscBmCwVYpgOh+EA2+Y6
	 aWtTazPiG0vgLL78vrjYox3N6zOi1Q+EdRtC+hWiCY/FIQlwIFvTeYNy/Ml95UKoG5wfeqtqZiRU
	 nIfwKg+xN7biFDnwMDeKZdPa8GnrpVjUxVNsURWbQtkarUG9DBSw3FiSY91vUvcVOTZNsq+vfO8n
	 oSK9tSz5F0GygxI1anrMly265Jq4IHGZJcaJXE8pgs+ip7O9p6YT853Ff/i6gDq+6B9rIfu4CQ5/
	 LVTzKePriwTuVQxZ9NMmrnalZyTtjag304JRKTN2/KOWO/irVLd8Gz+tYmhJtOwg==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+6450929faa7a97cd42d1@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	damien.lemoal@opensource.wdc.com,
	edward.shishkin@gmail.com,
	glider@google.com,
	jack@suse.cz,
	jlayton@kernel.org,
	linuszeng@tencent.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	reiserfs-devel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	willy@infradead.org
Subject: [PATCH] reiserfs: fix uninit-value in reiserfs_new_inode
Date: Sun, 31 Dec 2023 09:04:04 +0800
X-OQ-MSGID: <20231231010403.3061947-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000da757a060d58ebbe@google.com>
References: <000000000000da757a060d58ebbe@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before creating a new inode, it is necessary to initialize the "new packing
locality" tag of the dir.

Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/reiserfs/namei.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/reiserfs/namei.c b/fs/reiserfs/namei.c
index 994d6e6995ab..3a824fb170d5 100644
--- a/fs/reiserfs/namei.c
+++ b/fs/reiserfs/namei.c
@@ -638,6 +638,10 @@ static int reiserfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	if (retval)
 		return retval;
 
+#ifdef DISPLACE_NEW_PACKING_LOCALITIES
+	REISERFS_I(dir)->new_packing_locality = 0;
+#endif
+
 	if (!(inode = new_inode(dir->i_sb))) {
 		return -ENOMEM;
 	}
-- 
2.43.0


