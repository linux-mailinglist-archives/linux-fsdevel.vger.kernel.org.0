Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77030F3DC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Feb 2021 14:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhBDN11 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Feb 2021 08:27:27 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:41588 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236311AbhBDN1R (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:27:17 -0500
X-UUID: 1e28ea95ab33423aaa971d97ffaad201-20210204
X-UUID: 1e28ea95ab33423aaa971d97ffaad201-20210204
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ed.tsai@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 319922277; Thu, 04 Feb 2021 21:26:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 4 Feb 2021 21:25:58 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 4 Feb 2021 21:25:58 +0800
From:   Ed Tsai <ed.tsai@mediatek.com>
To:     <linux-f2fs-devel@lists.sourceforge.net>
CC:     <linux-doc@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ed.tsai@mediatek.com>
Subject: [PATCH] Documentation: f2fs: fix typo s/automaic/automatic
Date:   Thu, 4 Feb 2021 21:25:56 +0800
Message-ID: <20210204132556.14934-1-ed.tsai@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 264E744759CDFE8E1FA7B7EB4E35E7CEFEA19D310B34A1FB30C8694CD75E32962000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fix typo in f2fs documentation.

Signed-off-by: Ed Tsai <ed.tsai@mediatek.com>
---
 Documentation/filesystems/f2fs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index dae15c96e659..e1cda214058e 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -831,7 +831,7 @@ This is the default option. f2fs does automatic compression in the writeback of
 compression enabled files.
 
 2) compress_mode=user
-This disables the automaic compression and gives the user discretion of choosing the
+This disables the automatic compression and gives the user discretion of choosing the
 target file and the timing. The user can do manual compression/decompression on the
 compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
 ioctls like the below.
-- 
2.18.0

