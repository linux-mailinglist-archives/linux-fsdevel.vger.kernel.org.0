Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 005F62BAFAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Nov 2020 17:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgKTQJ4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 Nov 2020 11:09:56 -0500
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:59496 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728041AbgKTQJz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 Nov 2020 11:09:55 -0500
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 067C01D70;
        Fri, 20 Nov 2020 19:09:53 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1605888593;
        bh=nuxsA96Gr7XdCPoXEZaW4gikHnYVlWDUcVx/u5zV40g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U8LVZ28a73BzJOKu0eEpvWOtdeg2phhSd0qrmwLznqSWyOFTWeaqpu3cg73DEMmUn
         fJ8Bx8pO14+c5uo867znvlNtlxzRawV3eGx7VM72iD278coNtdOs7V9V0c5NtMUHwu
         r2UWaaVZhoUdlufqIPEpyxTm4hMTBQ7bhIzqZfGE=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 20 Nov 2020 19:09:52 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        <dan.carpenter@oracle.com>, <hch@lst.de>, <ebiggers@kernel.org>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v13 10/10] fs/ntfs3: Add MAINTAINERS
Date:   Fri, 20 Nov 2020 19:09:44 +0300
Message-ID: <20201120160944.1629091-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120160944.1629091-1-almaz.alexandrovich@paragon-software.com>
References: <20201120160944.1629091-1-almaz.alexandrovich@paragon-software.com>
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
index c7f6924d34c7..2dc2437ba8ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12458,6 +12458,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
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

