Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9413619BACA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Apr 2020 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387431AbgDBD6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Apr 2020 23:58:17 -0400
Received: from m177134.mail.qiye.163.com ([123.58.177.134]:58074 "EHLO
        m177134.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgDBD6R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Apr 2020 23:58:17 -0400
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.227])
        by mail-m127101.qiye.163.com (Hmail) with ESMTPA id CD28148B13;
        Thu,  2 Apr 2020 11:58:12 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH v2] fs: Fix missing 'bit' in comment
Date:   Thu,  2 Apr 2020 11:58:07 +0800
Message-Id: <20200402035807.10611-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVOSkxLS0tKQkNITU9JTVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pi46Agw4OTg#LB0rEikeCRkX
        HhQaCjZVSlVKTkNOTEJCQ0JISktPVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTFlXWQgBWUFKTEtCNwY+
X-HM-Tid: 0a71390a10109865kuuucd28148b13
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The missing word may make it hard for other developers to
understand it.

Signed-off-by: Chucheng Luo <luochucheng@vivo.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Andreas Dilger <adilger@dilger.ca>
---
Changelog:
 - fix missing word 'bit'
 - change '32 bit' to '32-bit'
 - change '64 bit' to '64-bit'
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

