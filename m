Return-Path: <linux-fsdevel+bounces-24919-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189EF94698E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 13:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B717C1F2174A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Aug 2024 11:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DFA14D712;
	Sat,  3 Aug 2024 11:52:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B16C14E2F1;
	Sat,  3 Aug 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722685923; cv=none; b=Jbk14k6AZ/R/fLnbaW7crHzUUzkEJuhnGzGod+4qKAjEwyu01y+G4rYuWpJshRS4jbItVyTfY6NxHEPKwsAOZTdt5NyhZP2sEPtx9S2TmH/6wbutkuKqZSfUscvoTN2EETmGJEMecvpfEmfDYuS9wShOSwlOv+vYEUqkW+fjlXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722685923; c=relaxed/simple;
	bh=YnIM0WebRsXwlgleTouTWyauzysBBRQHK7MDVisp/Wo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qQwJysy8/OZk/vFZFO5FzHYdfrdGNVw/Dt/GMnj5cKXvXMZBz5o7tOIHFxECZewLeoriwZyf1wKV617asVnrP8KrUEVnZfBCtgKU0xMZ7MFT45+4dxJ+nTAnpVZkr7Estb0baH3F9VAOfCAIkx/PdhA5VYf0NUMhYyqetcjo4uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WbgzG3sbyzcd5Q;
	Sat,  3 Aug 2024 19:51:54 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D9B91800A1;
	Sat,  3 Aug 2024 19:51:57 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 3 Aug
 2024 19:51:56 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <jack@suse.cz>,
	<mszeredi@redhat.com>
CC: <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH -next] fs: mounts: Remove unused declaration mnt_cursor_del()
Date: Sat, 3 Aug 2024 19:50:00 +0800
Message-ID: <20240803115000.589872-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf500002.china.huawei.com (7.185.36.57)

Commit 2eea9ce4310d ("mounts: keep list of mounts in an rbtree")
removed the implementation but leave declaration.

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 fs/mount.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/mount.h b/fs/mount.h
index c1db0c709c6a..185fc56afc13 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -153,7 +153,6 @@ static inline void move_from_ns(struct mount *mnt, struct list_head *dt_list)
 	list_add_tail(&mnt->mnt_list, dt_list);
 }
 
-extern void mnt_cursor_del(struct mnt_namespace *ns, struct mount *cursor);
 bool has_locked_children(struct mount *mnt, struct dentry *dentry);
 struct mnt_namespace *__lookup_next_mnt_ns(struct mnt_namespace *mnt_ns, bool previous);
 static inline struct mnt_namespace *lookup_next_mnt_ns(struct mnt_namespace *mntns)
-- 
2.34.1


