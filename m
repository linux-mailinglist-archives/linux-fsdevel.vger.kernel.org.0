Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BEFBAD9D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2019 07:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391935AbfIWFxm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Sep 2019 01:53:42 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2706 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387519AbfIWFxm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Sep 2019 01:53:42 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1AFA97CF542F51D455A4;
        Mon, 23 Sep 2019 13:53:40 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 13:53:30 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <miklos@szeredi.hu>, <mszeredi@redhat.com>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] fuse: Make fuse_args_to_req static
Date:   Mon, 23 Sep 2019 13:52:31 +0800
Message-ID: <20190923055231.19728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix sparse warning:

fs/fuse/dev.c:468:6: warning: symbol 'fuse_args_to_req' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/fuse/dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 46d68d4..7844d35 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -465,7 +465,7 @@ static void fuse_force_creds(struct fuse_conn *fc, struct fuse_req *req)
 	req->in.h.pid = pid_nr_ns(task_pid(current), fc->pid_ns);
 }
 
-void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
+static void fuse_args_to_req(struct fuse_req *req, struct fuse_args *args)
 {
 	req->in.h.opcode = args->opcode;
 	req->in.h.nodeid = args->nodeid;
-- 
2.7.4


