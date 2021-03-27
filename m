Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9834B99C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Mar 2021 22:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhC0VnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Mar 2021 17:43:05 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:51402 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230474AbhC0Vmi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Mar 2021 17:42:38 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8491D415;
        Sun, 28 Mar 2021 00:42:31 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1616881351;
        bh=Oq8WFdb4Tg/OV1NWCQUvyKyTQ1S3GYc0yK9o11OM53k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=umlpMrxzPDcX0lyBef4adttSVNGASkahPEBSi9stinqIB5V0u3MNNMgD6yJTkIpFa
         Xs2rG4POKpILpg7a6B/a8JrHPa7uqIGNKdlYesGMDiUjacfABuAusRJGc9NQKA4BPT
         7a8asXB+Rfkx7olQ0WgsZWU9tDQ7LY00ey6CTOrc=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 28 Mar 2021 00:42:31 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        <andy.lavr@gmail.com>, <kari.argillander@gmail.com>,
        <oleksandr@natalenko.name>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v25 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
Date:   Sun, 28 Mar 2021 00:40:22 +0300
Message-ID: <20210327214023.3214923-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20210327214023.3214923-1-almaz.alexandrovich@paragon-software.com>
References: <20210327214023.3214923-1-almaz.alexandrovich@paragon-software.com>
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
index 9e7e47933..1bf7b82d5 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -146,6 +146,7 @@ menu "DOS/FAT/EXFAT/NT Filesystems"
 source "fs/fat/Kconfig"
 source "fs/exfat/Kconfig"
 source "fs/ntfs/Kconfig"
+source "fs/ntfs3/Kconfig"
 
 endmenu
 endif # BLOCK
diff --git a/fs/Makefile b/fs/Makefile
index 542a77374..8f199ba5b 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -101,6 +101,7 @@ obj-$(CONFIG_CIFS)		+= cifs/
 obj-$(CONFIG_SMB_SERVER)	+= cifsd/
 obj-$(CONFIG_HPFS_FS)		+= hpfs/
 obj-$(CONFIG_NTFS_FS)		+= ntfs/
+obj-$(CONFIG_NTFS3_FS)		+= ntfs3/
 obj-$(CONFIG_UFS_FS)		+= ufs/
 obj-$(CONFIG_EFS_FS)		+= efs/
 obj-$(CONFIG_JFFS2_FS)		+= jffs2/
-- 
2.25.4

