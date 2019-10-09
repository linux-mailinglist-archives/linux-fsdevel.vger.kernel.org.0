Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA7BD1870
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732480AbfJITOI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:08 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53061 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731879AbfJITLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N79hs-1i1wmF0d9o-017TFD; Wed, 09 Oct 2019 21:11:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v6 25/43] compat_ioctl: remove PCI ioctl translation
Date:   Wed,  9 Oct 2019 21:10:25 +0200
Message-Id: <20191009191044.308087-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:A90z5qH3xuPEjD4JyPp3z+Nx3vYUYPAv74/jTKDarhYH9Ubga2o
 tDJ31p/Pflrla1qflW4JN1R01F4hWVjTdt6qDXFL0I2ae/P3yovVK//bT2AumB4jhaSSdKw
 A71F5hj00vYezGngiMh1wCFtzXM+vvbd+4P/7g21owwJqvwf9Y49gbdpslFJaXX6cwa2o3o
 oM5Dkwev3RZHEndKV/5tw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YVgb4nM+fyU=:/C0Cg3j3BiaQHBhgm5/Nbd
 0SMKT/pjwKkle2mq4YCy2rrGNBhQJmWR8se4qCM0VVsz8u6Umtki/Qe9vQrV3RGFkLhCmrc5c
 yM8RoEk/D0n4ufbSHIs/RuS+tE0RFO0j+83bxqLiEcX3giTswTqGvZDbpUe7oi7EX2Don9AEL
 Djru6rVJdMBhCQjMTDyPcVXVEMkxnZdz17S/dQcqhk2NDP63iWsyXrXfZmky+O5J13ExugnI2
 OHJsZM9EU6UlNkUfJ82a7BZiK1IH9+PdJBq5i/28yrd6mAmIpO+7KSWyJSt9TOsnh0dH74tfC
 8fMszqsIkGoyn7W3zgSQcy0SoeTKBeJs4kKvFkmDhWdwwjtPxpAmyQ4wL/PVFd/WHEF8KSPLq
 0+ISTd+Hhhtb83MyYskSQKdsCl10bQMdxsdxRwiUrGPx2mFMvjI7aCU+u9mHlYKm85CGskIy5
 nNvP/E00n4D5vi5+F3ptIikIMMnLH81Xj2St74TkmvGlInjczcrzMi6A1Zln0KgtD/2a8SFcu
 SBMyI26LzXQJieDdVS2DP68GnYufiLa+eM46vwLchxDMBo6cOjPQfhV4eY5nNZdT7/lnebxrF
 QC3oXrax6wT1Y+QPRMN5ptZU8g6m8pGQRePYJX9pwdzL2Ge7GyqBBW4gSzpNqIDdd7c5cJkDL
 dJWwsQ7AhaxuLW2xBAH4eST8H3igq8mTppshQ9IGaQ8oXnWtrrDwE6k/EtwcB4DtRQfq1V9l3
 pDQktmDDBzOyWwFxVgE2nsV0I+ioTBpkb+/qFipXzgnyf3lK16Xe5yfcynTL8dZwGKOL6Sg+y
 +gyUOzv3gbup4ML2aOCYgTVDKV0QPn1VZNvooe53S+HH5z8NXXyJAxnmmy4nMQnRSVgmVY1DV
 pQQGm/27Zf2dP8QMETgQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /proc/pci/ implementation already handles these just fine, so
the entries in the table are not needed any more.

Cc: linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a214ae052596..37f45644528a 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -29,7 +29,6 @@
 #include <linux/vt_kern.h>
 #include <linux/raw.h>
 #include <linux/blkdev.h>
-#include <linux/pci.h>
 #include <linux/serial.h>
 #include <linux/ctype.h>
 #include <linux/syscalls.h>
@@ -437,11 +436,6 @@ COMPATIBLE_IOCTL(WDIOC_SETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETTIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_SETPRETIMEOUT)
 COMPATIBLE_IOCTL(WDIOC_GETPRETIMEOUT)
-/* Misc. */
-COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
-COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
 };
 
 /*
-- 
2.20.0

