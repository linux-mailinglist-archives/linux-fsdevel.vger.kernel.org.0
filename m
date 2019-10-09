Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC4AD1876
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732141AbfJITOY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:24 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:43013 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731864AbfJITLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N8XgH-1i5Vg21fDl-014SRC; Wed, 09 Oct 2019 21:11:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 26/43] compat_ioctl: remove /dev/raw ioctl translation
Date:   Wed,  9 Oct 2019 21:10:26 +0200
Message-Id: <20191009191044.308087-26-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:HjmQR2MNOTNwefTsjwqXeNcWNZPnuTYPOOSVxTpgnh2+kWgBjbC
 4PWuHL970NpwGIA5s3UWCPN1Omd5A64scatHOWaJ+7yyjqcPRPkZvWoDLJddAUMjHxd8TMe
 WXeF3ct/fl1bR1JpWgoDqTAkj+2/snW5MNxisE5FmgoJXqEydS2hZ5ttp6q4tQ2FOB5KwBS
 iHe3QAPY0UxkgO2/B2w3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:45nQ4/dGAik=:DO1TvolxEo/1OP/A40PdOF
 /3xFLkn2AU8Jita6p/Bhi1wlqnFoQLKfjj7vn8n3Sdr7vYXkDth9RRRdpy0QCh3q1BXD+Lu2H
 UH2xEZYJPdWyqyG+ff9Q8sLDFpk3lU5dQKx/n3gIBEIKDCdhJCIfG0E02cpSZQzwfsBle4Xs7
 3isDDA4le1OHK9nKSG4v9F5tK2XMZp8VqF1PjBSalkAnpMMCOqlJN2QxsJ7M11Nu+kRd4gie6
 gEEWP4cIT1v3Lc4S6F/iirQPJ6wggrmbEon7ADjJvmA0C7eO01O069Jwu/ttz1F0IGiygNa4+
 CjSyGVFpVS7+SE74O32iWZbfvJ3HDzUqR7BZp5Xpm7kzDxFhIyBfVizvTgDcmz5yM5X5GKp72
 6JecmkvjiL/z4Ft8wqFiXGt3+Uk2uxpHtwBjS9nZSKstJyWVCzhbimk+0TkMrzYgLOcHt2oKm
 7k+ybls+YG3uZpb32reCMFTGborhcTYoqm3oE8tsWGtwJnkdpm6yFxTfEwTHbemCyg6yw0mrj
 lZjnpwQTVYECKjjfivVB9kVXdC+voSk7hK1XfKDW5Y6hYXaQNR3PX5QPvO15IJNqlVclop3tu
 jm9gHon0bLnMTcSR7GOYzdqCeHnCya6MqUzfzvJCFQ8c2A+Era9YKNb848GZyRdvB+biQ1SPa
 ABMrB8idWXltDhd2A6LOv4g6Fd53eTOx4wy5NF0Ed0aCTQYZoMG+yE+WL9VY61L6g+jJr14WR
 tsjXFxVuGFzyqVqLp43kLlvNL2S7Vp1vgxxbsY9mZzj5mxudqBiQgGnn2g0bxhLeVbp6oOr4/
 vF2ZBFtgIF2Tmof+ac3Z5lfnJdzKtTFYLM33O8fspWr67Gj5Gj1l5W/4kt0H16qMw1m7H5OQx
 OMBnnNUzm9uE3NzRGNqg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /dev/rawX implementation already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 37f45644528a..6070481f2b6a 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -27,7 +27,6 @@
 #include <linux/if_pppox.h>
 #include <linux/tty.h>
 #include <linux/vt_kern.h>
-#include <linux/raw.h>
 #include <linux/blkdev.h>
 #include <linux/serial.h>
 #include <linux/ctype.h>
@@ -422,9 +421,6 @@ COMPATIBLE_IOCTL(PPPIOCDISCONN)
 COMPATIBLE_IOCTL(PPPIOCATTCHAN)
 COMPATIBLE_IOCTL(PPPIOCGCHAN)
 COMPATIBLE_IOCTL(PPPIOCGL2TPSTATS)
-/* Raw devices */
-COMPATIBLE_IOCTL(RAW_SETBIND)
-COMPATIBLE_IOCTL(RAW_GETBIND)
 /* Watchdog */
 COMPATIBLE_IOCTL(WDIOC_GETSUPPORT)
 COMPATIBLE_IOCTL(WDIOC_GETSTATUS)
-- 
2.20.0

