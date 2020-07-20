Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 634BE225659
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 05:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgGTD6F (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 19 Jul 2020 23:58:05 -0400
Received: from smtpbgau1.qq.com ([54.206.16.166]:45099 "EHLO smtpbgau1.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgGTD6F (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 19 Jul 2020 23:58:05 -0400
X-QQ-mid: bizesmtp25t1595217442t2pbg09a
Received: from xr-hulk-k8s-node1933.gh.sankuai (unknown [101.236.11.3])
        by esmtp10.qq.com (ESMTP) with 
        id ; Mon, 20 Jul 2020 11:57:17 +0800 (CST)
X-QQ-SSF: 01100000002000E0ZJ10000A0000000
X-QQ-FEAT: vRxJyNZKtn574sXzuhb6JrTe0DRGm8uxxzRSy1WoSNmNOCe0I/8uvZQqwavGy
        x49DMVUtyOan8jTTeoWuiS3ozZgnyBv05AlikisLTh6KhXkDNE4z+P06OwsJ1igh4FW270E
        tWFIvXwKXpRIsoJc88mF66dgYKj4thfS1XBxsm+rdlXff0Zyr45uXQzAgGfa8dU8g7cQ5Tr
        vkzgH002srJY+Z3L5pg6lhaTtaA5ZqCV8tfvKBDx9b7ResMWkpkZ5iwiCWtwanuNoWwsRcw
        JJjEw5pJQM1r1NrQzVhAWikfQ8ATXgq+yVtdqX6VdBK/R42XW5AJAgUkorT5ZdyHt7JnVih
        G1OQQEu
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     willy@infradead.org
Cc:     w@laoqinren.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] xarray: update document for error space returned by xarray normal API
Date:   Mon, 20 Jul 2020 11:57:17 +0800
Message-Id: <1595217437-48158-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the current xarray code, the negative value -1 and -4095 represented
as an error.

xa_is_error(xa_mk_internal(-4095)) and xa_is_error(xa_mk_internal(-1))
are all return true.

This patch update the document.

Signed-off-by: Wang Long <w@laoqinren.net>
---
 include/linux/xarray.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index b4d70e7..0588fb9 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -36,7 +36,7 @@
  * 257: Zero entry
  *
  * Errors are also represented as internal entries, but use the negative
- * space (-4094 to -2).  They're never stored in the slots array; only
+ * space (-4095 to -1).  They're never stored in the slots array; only
  * returned by the normal API.
  */
 
-- 
1.8.3.1




