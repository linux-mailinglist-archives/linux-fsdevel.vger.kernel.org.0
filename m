Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80D32270238
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Sep 2020 18:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgIRQbB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Sep 2020 12:31:01 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:53563 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726417AbgIRQbB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:31:01 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id AEC44822E5;
        Fri, 18 Sep 2020 19:24:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1600446254;
        bh=llcndn+HkNuWrrqNsfswt1wWNPXvoCOsxtER9hDXkeI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YpA2JMBg/OItWTofPybTIBUen0fVWg0G4D/utqEBkIFj9P4V7lGN28x1SGW4zMCek
         NF4YyS/fbl7i4ttSvkpQLR6ii3SqAeDCzWP6ImQfHp+MZnBVZ0svqbiETfBvhEgIEH
         nKOcVvjU1onXM5cV2oh5kuX5YvPzVMBv4D+WIwGY=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 18 Sep 2020 19:24:14 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v6 09/10] fs/ntfs3: Add NTFS3 in fs/Kconfig and fs/Makefile
Date:   Fri, 18 Sep 2020 19:22:03 +0300
Message-ID: <20200918162204.3706029-10-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200918162204.3706029-1-almaz.alexandrovich@paragon-software.com>
References: <20200918162204.3706029-1-almaz.alexandrovich@paragon-software.com>
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
 fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

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
-- 
2.25.4

