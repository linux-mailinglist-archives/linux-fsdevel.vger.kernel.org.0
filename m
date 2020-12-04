Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1595E2CF129
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Dec 2020 16:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730883AbgLDPt2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Dec 2020 10:49:28 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:55286 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730727AbgLDPsv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Dec 2020 10:48:51 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 95FFA1D47;
        Fri,  4 Dec 2020 18:48:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1607096888;
        bh=ryC1O+KjPCuBYVk17xa91BOxLPmINLD4FPXxdPXSapU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=PP6/eDhU8d4w6CoOPhsTiBYgdVwKq0Y3tIy7vMftv1xXYhjtfn2WuBMgGQ5LOTDDE
         HWddeM3W8t5XZ1D5Vflh/Q5JA+ZxSNgEsjmm1efJD9YB937NUDAWRsZhEDLkMudT1V
         ZlQPVdD8D8v8OVErUquEUoC0QkpUPWmtiu1Ui+v0=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Dec 2020 18:48:08 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v14 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
Date:   Fri, 4 Dec 2020 18:45:59 +0300
Message-ID: <20201204154600.1546096-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
References: <20201204154600.1546096-1-almaz.alexandrovich@paragon-software.com>
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
index 999d1a23f036..4f5242cdaee2 100644
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

