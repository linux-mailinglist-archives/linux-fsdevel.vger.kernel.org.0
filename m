Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8724DAC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Aug 2020 18:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgHUQ0h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Aug 2020 12:26:37 -0400
Received: from relaydlg-01.paragon-software.com ([81.5.88.159]:59085 "EHLO
        relaydlg-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728482AbgHUQZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:25:59 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relaydlg-01.paragon-software.com (Postfix) with ESMTPS id 4C42F8221B;
        Fri, 21 Aug 2020 19:25:50 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598027150;
        bh=bdiuRaddL1qh2Dbt4gYmcg3C+nR6kLGAyfYYipie7lc=;
        h=From:To:CC:Subject:Date;
        b=RrS1F7UTSJhSPUL7efWbN9iOgZfQ+0DQ7JOdhFCCjhbVPT6ZVrbRahWAZ+a9SWf7F
         xbaYkTfhKbIIZJGJMI5Fi/F6ro4EAX6pBCqfJWLHdjbXronx1JQB1tdVFAqzGYQssK
         LX6w0cTq0i8Vl337hLzBAlIXyMVKg3cwXbQtwES0=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 21 Aug 2020 19:25:49 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 21 Aug 2020 19:25:49 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?iso-8859-1?Q?Pali_Roh=E1r?= <pali@kernel.org>
Subject: [PATCH v2 10/10] fs/ntfs3: Add MAINTAINERS
Thread-Topic: [PATCH v2 10/10] fs/ntfs3: Add MAINTAINERS
Thread-Index: AdZ3047+o//2/kjARjiwpjsa2mG6fg==
Date:   Fri, 21 Aug 2020 16:25:49 +0000
Message-ID: <480fae2412784df8b92249ef12328f46@paragon-software.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

MAINTAINERS update

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com=
>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index deaafb617361..5629fb0421f6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12353,6 +12353,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/g=
it/aia21/ntfs.git
 F:	Documentation/filesystems/ntfs.rst
 F:	fs/ntfs/
=20
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
--=20
2.25.2

