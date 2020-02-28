Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6F173705
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 13:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgB1MPd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Feb 2020 07:15:33 -0500
Received: from relay.sw.ru ([185.231.240.75]:49986 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725796AbgB1MPd (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:15:33 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j7eY8-0004k1-BP; Fri, 28 Feb 2020 15:15:24 +0300
Subject: [PATCH] fuse: Update stale comment in queue_interrupt()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     miklos@szeredi.hu, linux-fsdevel@vger.kernel.org,
        stefanha@redhat.com, ktkhai@virtuozzo.com
Date:   Fri, 28 Feb 2020 15:15:24 +0300
Message-ID: <158289211567.437388.9236618474068379496.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes: 04ec5af0776e "fuse: export fuse_end_request()"
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 fs/fuse/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 97eec7522bf2..188318a1d82b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -342,7 +342,7 @@ static int queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
 		 * Pairs with smp_mb() implied by test_and_set_bit()
-		 * from request_end().
+		 * from fuse_request_end().
 		 */
 		smp_mb();
 		if (test_bit(FR_FINISHED, &req->flags)) {


