Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 985F72E2BAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Dec 2020 14:55:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgLYNy5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Dec 2020 08:54:57 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:47354 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726322AbgLYNyv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Dec 2020 08:54:51 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 554E11D74;
        Fri, 25 Dec 2020 16:53:28 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1608904408;
        bh=5edRUcHcrLDkIb9EPFaEZwgjmGaBWS5lAiZUoMbv+LY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q/mEawAf+TMQVd2AtMO+e+IXI+iHdgiMQOaoFfBlgXhS+7z7llmsOAwHnsexQ9TWH
         q92Oh527oiuCFW1wNCmnQYZI9K85gCUAM/mpmGJ9e9DROW9ldDAXz94FBxAQdE1pIG
         YqUAtwMsnWPdBWgNvHKxWu0SMTA7IJbygqukfy04=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 25 Dec 2020 16:53:27 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v16 10/10] fs/ntfs3: Add MAINTAINERS
Date:   Fri, 25 Dec 2020 16:51:19 +0300
Message-ID: <20201225135119.3666763-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201225135119.3666763-1-almaz.alexandrovich@paragon-software.com>
References: <20201225135119.3666763-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.30.114.105]
X-ClientProxiedBy: vdlg-exch-02.paragon-software.com (172.30.1.105) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds MAINTAINERS

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32944ecc5733..5260e1939798 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12674,6 +12674,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
 
+NTFS3 FILESYSTEM
+M:	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
+S:	Supported
+W:	http://www.paragon-software.com/
+F:	Documentation/filesystems/ntfs3.rst
+F:	fs/ntfs3/
+
 NUBUS SUBSYSTEM
 M:	Finn Thain <fthain@telegraphics.com.au>
 L:	linux-m68k@lists.linux-m68k.org
-- 
2.25.4

