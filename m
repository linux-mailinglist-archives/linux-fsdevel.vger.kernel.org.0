Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A53A6183EE5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgCMB4B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 21:56:01 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:27839 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgCMB4B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:56:01 -0400
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 21:55:59 EDT
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.226])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 22393261536;
        Fri, 13 Mar 2020 09:47:04 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     wenhu.wang@vivo.com, trivial@kernel.org,
        Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH] fs: Fix missing 'bit' in comment
Date:   Fri, 13 Mar 2020 09:46:55 +0800
Message-Id: <20200313014655.28967-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVISk9LS0tKSUJNQkJMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCo6Qyo*NTgwKDETCxQtCRwN
        FDdPFBhVSlVKTkNPS01PS0lPT0NJVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTVlXWQgBWUFKTkhLNwY+
X-HM-Tid: 0a70d192cf389375kuws22393261536
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The missing word may make it hard for other developers to
understand it.

Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
---
 fs/vboxsf/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index dd147b490982..4d569f14a8d8 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
 		d_type = vboxsf_get_d_type(info->info.attr.mode);
 
 		/*
-		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * On 32-bit systems pos is 64-bit signed, while ino is 32-bit
 		 * unsigned so fake_ino may overflow, check for this.
 		 */
 		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
-- 
2.17.1

