Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54771853E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Mar 2020 02:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgCNBeq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 21:34:46 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:61217 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNBeq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:34:46 -0400
Received: from lcc-VirtualBox.vivo.xyz (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id E747D2615F4;
        Sat, 14 Mar 2020 09:34:37 +0800 (CST)
From:   Chucheng Luo <luochucheng@vivo.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kernel@vivo.com, trivial@kernel.org,
        Chucheng Luo <luochucheng@vivo.com>
Subject: [PATCH] fs: Fix missing 'bit' in comment
Date:   Sat, 14 Mar 2020 09:34:24 +0800
Message-Id: <20200314013424.32575-1-luochucheng@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVNQ0JLS0tKSUJNQkJMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NBA6OBw6EzgwSzAZSUoeKDAy
        Lz8wCRRVSlVKTkNPSk9CTUxDSU1JVTMWGhIXVRcOFBgTDhgTHhUcOw0SDRRVGBQWRVlXWRILWUFZ
        TkNVSU5KVUxPVUlJTFlXWQgBWUFKTUpONwY+
X-HM-Tid: 0a70d6adc8509375kuwse747d2615f4
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
 fs/vboxsf/dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index dd147b490982..be4f72625d36 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -134,7 +134,7 @@ static bool vboxsf_dir_emit(struct file *dir, struct dir_context *ctx)
 		d_type = vboxsf_get_d_type(info->info.attr.mode);
 
 		/*
-		 * On 32 bit systems pos is 64 signed, while ino is 32 bit
+		 * On 32 bit systems pos is 64 bit signed, while ino is 32 bit
 		 * unsigned so fake_ino may overflow, check for this.
 		 */
 		if ((ino_t)(ctx->pos + 1) != (u64)(ctx->pos + 1)) {
-- 
2.17.1

