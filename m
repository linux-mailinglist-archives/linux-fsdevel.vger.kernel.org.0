Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696C2288AA8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Oct 2020 16:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388733AbgJIOXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Oct 2020 10:23:22 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:42946 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388705AbgJIOXN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:23:13 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id A4FBC82381;
        Fri,  9 Oct 2020 17:23:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1602253390;
        bh=S8gDeoTCBo2l6VTbgmUNJMuSPx/Uom3dBfUMBREzyWI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=A+uLJYgjRYVmi/ChdFBYbzFHJ0j8TUeAiuDyTOZORaEA3yhJaPvZpn3jQzuk0LYIN
         NABsAuqfTKQuBRMy/5jZbr1g9QnyKAAxkLKWGXfLppaK09xRDfMYQkKrtoTOBuC8FQ
         mshhZjX/RaWe2Iv5/rCb4KXf54woB/FOucxRFWAQ=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 9 Oct 2020 17:23:10 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v8 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
Date:   Fri, 9 Oct 2020 17:23:00 +0300
Message-ID: <20201009142301.412454-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201009142301.412454-1-almaz.alexandrovich@paragon-software.com>
References: <20201009142301.412454-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds NTFS3 in fs/Kconfig and fs/Makefile

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 fs/Kconfig  | 1 +
 fs/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index aa4c12282301..eae96d55ab67 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -145,6 +145,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
+source "fs/ntfs3/Kconfig"
 
 endmenu
 endif # BLOCK
diff --git a/fs/Makefile b/fs/Makefile
index 1c7b0e3f6daa..b0b4ad8affa0 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SYSV_FS)		+= sysv/
 obj-$(CONFIG_CIFS)		+= cifs/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
+obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
-- 
2.25.4

