Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12ECE3486CA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Mar 2021 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbhCYCGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 22:06:21 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:31338 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbhCYCGI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 22:06:08 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Mar 2021 22:06:08 EDT
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id D9C5C980290;
        Thu, 25 Mar 2021 10:00:07 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: fs: Remove duplicate declaration
Date:   Thu, 25 Mar 2021 09:59:46 +0800
Message-Id: <20210325015946.839032-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT01OGktNT00aSxgZVkpNSk1NSExNS0NLQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OD46USo6Ej8LDj82NUwCUStL
        Vi9PCTVVSlVKTUpNTUhMTUtCS0tCVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKSE9JNwY+
X-HM-Tid: 0a78671c403dd992kuwsd9c5c980290
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

struct iov_iter has been declared at 66th line. 
Remove the duplicate.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/fs.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index ec8f3ddf4a6a..7f3cbd47670a 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1883,7 +1883,6 @@ struct dir_context {
  */
 #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
 
-struct iov_iter;
 
 struct file_operations {
 	struct module *owner;
-- 
2.25.1

