Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7502E245520
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Aug 2020 02:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729302AbgHPAvv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 20:51:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33160 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgHPAvv (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 20:51:51 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 150DBE3DEBCDAD6CE45D;
        Sat, 15 Aug 2020 17:05:19 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Sat, 15 Aug 2020
 17:05:09 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <viro@zeniv.linux.org.uk>
CC:     <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] signalfd: Convert to use the preferred fallthrough macro
Date:   Sat, 15 Aug 2020 05:04:05 -0400
Message-ID: <20200815090405.18672-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert the uses of fallthrough comments to fallthrough macro.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 fs/signalfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 5b78719be445..456046e15873 100644
--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -176,7 +176,7 @@ static ssize_t signalfd_dequeue(struct signalfd_ctx *ctx, kernel_siginfo_t *info
 		if (!nonblock)
 			break;
 		ret = -EAGAIN;
-		/* fall through */
+		fallthrough;
 	default:
 		spin_unlock_irq(&current->sighand->siglock);
 		return ret;
-- 
2.19.1

