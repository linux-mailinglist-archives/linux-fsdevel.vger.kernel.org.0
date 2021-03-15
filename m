Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5829533B0D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Mar 2021 12:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCOLU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Mar 2021 07:20:28 -0400
Received: from mail-m17635.qiye.163.com ([59.111.176.35]:36716 "EHLO
        mail-m17635.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbhCOLUV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Mar 2021 07:20:21 -0400
Received: from ubuntu.localdomain (unknown [36.152.145.182])
        by mail-m17635.qiye.163.com (Hmail) with ESMTPA id 91AAB4002C6;
        Mon, 15 Mar 2021 19:20:15 +0800 (CST)
From:   zhouchuangao <zhouchuangao@vivo.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     zhouchuangao <zhouchuangao@vivo.com>
Subject: [PATCH] proc/sysctl: Fix function name error in comments
Date:   Mon, 15 Mar 2021 04:19:54 -0700
Message-Id: <1615807194-79646-1-git-send-email-zhouchuangao@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUIdGktJSU1MQ0sYVkpNSk5DS0xJSk5MQ0pVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6OTo6Nj8ROUssPh4dVi1N
        PiNPCQ1VSlVKTUpOQ0tMSUpNSklOVTMWGhIXVQETFA4YEw4aFRwaFDsNEg0UVRgUFkVZV1kSC1lB
        WUhNVUpOSVVKT05VSkNJWVdZCAFZQUpNQk43Bg++
X-HM-Tid: 0a78359d7862d991kuws91aab4002c6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The function name should be modified to register_sysctl_paths instead
of register_sysctl_table_path.

Signed-off-by: zhouchuangao <zhouchuangao@vivo.com>
---
 fs/proc/proc_sysctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 984e42f..f026a48 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1562,7 +1562,7 @@ struct ctl_table_header *__register_sysctl_paths(
 }
 
 /**
- * register_sysctl_table_path - register a sysctl table hierarchy
+ * register_sysctl_paths - register a sysctl table hierarchy
  * @path: The path to the directory the sysctl table is in.
  * @table: the top-level table structure
  *
-- 
2.7.4

