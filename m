Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AD2255CCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 16:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgH1Olo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 10:41:44 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:57928 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728010AbgH1Ok1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:40:27 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 8911A1D14;
        Fri, 28 Aug 2020 17:40:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598625620;
        bh=6yh9wsXrrUwgAauulN6NDeqzPbS2YfuufHPinxnH05o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lyejLyhpgyq+4nbybQ5+4YTz4psnhMp5br3XVAUIqObaYHOJEAoLtTqOT6XmfQVkG
         ZZbs4rtHYk2gISySQNZCzIOLNmj6MVAMVqFNEWwQda2Ri7hdmBm/ND7ygcE7Retgst
         CtJ5k+eXH2XcLHAp1PwycMxHPoj201lQqNN9ZFw4=
Received: from localhost.localdomain (172.30.8.44) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 28 Aug 2020 17:40:19 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     <linux-fsdevel@vger.kernel.org>
CC:     <viro@zeniv.linux.org.uk>, <linux-kernel@vger.kernel.org>,
        <pali@kernel.org>, <dsterba@suse.cz>, <aaptel@suse.com>,
        <willy@infradead.org>, <rdunlap@infradead.org>, <joe@perches.com>,
        <mark@harmstone.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Subject: [PATCH v3 10/10] fs/ntfs3: Add MAINTAINERS
Date:   Fri, 28 Aug 2020 07:39:38 -0700
Message-ID: <20200828143938.102889-11-almaz.alexandrovich@paragon-software.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
References: <20200828143938.102889-1-almaz.alexandrovich@paragon-software.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.30.8.44]
X-ClientProxiedBy: vobn-exch-01.paragon-software.com (172.30.72.13) To
 vdlg-exch-02.paragon-software.com (172.30.1.105)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds MAINTAINERS

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3b186ade3597..b3db537a8310 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12354,6 +12354,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/aia21/ntfs.git
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
2.25.2

