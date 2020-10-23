Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6D42972AF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Oct 2020 17:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751033AbgJWPoq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Oct 2020 11:44:46 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:46938 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S465983AbgJWPon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Oct 2020 11:44:43 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id A808A1DF8;
        Fri, 23 Oct 2020 18:44:41 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1603467881;
        bh=qQXGRVDsdKbk9QAqu7DYbb2wwZTPHzDJGSYNUOqb01U=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=CK7E2t9ZRjhg87tZZxYfzdoXQ3Bb14XNHkieD42MexIDgcI811vlUChyYGsRHAeeo
         MZ8HWp2dNgwIAZFHVfQq3t+WOltfyGzILkXC3asXToGKVuysj3ZgqjwxFHhfXWQDTV
         X7gTc3itI5w/sMn3OlXanr0IgKyeJIOhyrTid1Ow=
Received: from fsd-lkpg.ufsd.paragon-software.com (172.30.114.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 23 Oct 2020 18:44:40 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>, <nborisov@suse.com>,
        <linux-ntfs-dev@lists.sourceforge.net>, <anton@tuxera.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v10 10/10] fs/ntfs3: Add MAINTAINERS
Date:   Fri, 23 Oct 2020 18:44:31 +0300
Message-ID: <20201023154431.1853715-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
References: <20201023154431.1853715-1-almaz.alexandrovich@paragon-software.com>
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
index fcb3b83f9c1a..7c968f6a5bba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12473,6 +12473,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
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

