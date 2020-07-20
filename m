Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78DD225679
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 06:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgGTESI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 00:18:08 -0400
Received: from smtpbgbr2.qq.com ([54.207.22.56]:50987 "EHLO smtpbgbr2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbgGTESI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:18:08 -0400
X-QQ-mid: bizesmtp13t1595218663tzhoomcv
Received: from xr-hulk-k8s-node1933.gh.sankuai (unknown [101.236.11.3])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 20 Jul 2020 12:17:38 +0800 (CST)
X-QQ-SSF: 01100000002000E0ZJ10B00A0000000
X-QQ-FEAT: ApWHnP2uAbDrPqhz4t8peVyuKrevRO0rmzPpxGwUILfB1QiweeWb2lohcBunj
        3Ti0bsnizRMwYzX+RdtDJFuTcYMOkDypr+XnJZLoVvAvk257AhjHy9Wv+qtB3fopbC9yaRq
        QO5+AuQ8uque5ARK2Zus6vbjhSRGBAWrDwKEagYKx6WzM/jHvGs21//CmlVzAFTwZhTxSaO
        2PUMDd8cQtwEnZ2mvgxoK6h09cIQsRidSYefNkW7S7QkZbpzFQaAfhoKX99XZfH2mg8IGE4
        KGb7Tkv8dABY8O77K3naCLjfCsLsIGQP+npNIbEaz+iEalWkheF28bveJc4LUdd4EKhSjuW
        7Zyr+9k
X-QQ-GoodBg: 0
From:   Wang Long <w@laoqinren.net>
To:     willy@infradead.org
Cc:     w@laoqinren.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v1] xarray: update document for error space returned by xarray normal API
Date:   Mon, 20 Jul 2020 12:17:38 +0800
Message-Id: <1595218658-53727-1-git-send-email-w@laoqinren.net>
X-Mailer: git-send-email 1.8.3.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:laoqinren.net:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In the current xarray code, the negative value -1 and -4095 represented
as an error.

xa_is_err(xa_mk_internal(-4095)) and xa_is_err(xa_mk_internal(-1))
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




