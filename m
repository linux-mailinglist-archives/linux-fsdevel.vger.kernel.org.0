Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7726F7B3F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbfG3UDd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:03:33 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:37767 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M3DBb-1hw8qa2rcL-003hxj; Tue, 30 Jul 2019 22:03:29 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 26/29] compat_ioctl: remove PCI ioctl translation
Date:   Tue, 30 Jul 2019 22:01:31 +0200
Message-Id: <20190730200145.1081541-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v9FZV+VakiX60OB46V7uJhxqDwWJDs0ZF0/AuEeS9ByrDiL0T/N
 e2sim3m0z8WK8x/eFiNMq9rj0AznnULlv7fo84ZSn2NmiIMMIccwRjhvT0rzpq7hiHkJsWg
 /ufuB6FUgYzdUYLya+SRPXDGppz2g2D34X2JcDiGpxe49qF7Q/krOGVHB9946yug/T+/LD1
 6Lr8CmmY2qksX4coh2epQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2JlqnoLxaj0=:1QvYHx9ZmLRsNnJrZj9nh7
 6drR+9DyW77oFWEP4HzC41pn8HXR0LzMy4NVMcVLcdQEJ/qUFL/qMNbx6ZSYqm30J1r5s42ru
 yi+UJa2fGQRJDFuhtyb/4yicJgygTQipevbaccleZX/Ek5LFvykBCb89LV+iJRLOpAhgpCj9t
 BWrEfv3m+DyfccoZb60HkJCMggK6qNw+SiZ2d5Ia3NzbDsBJZsgr0IeCgJR2OnOUpxU25mhSp
 F9rd9OQ/MoKQ1J5zTvaYt2UoPCkOEC+FuGYp34WGcKnnDn0OC/+czUTdNmQTcOdAE5VsLTDNM
 DU/NTAGHlOCulyY5HqLH9fDR0qyOaxDsS+m2Ti265090Vfz7T5Jxzc2JO0ys1py5eO1wWI6Lf
 bRGKXKEX6AKVRzYuqKidEGW2ctip+YJo0JwNJu+QPzeeHC1n7ty+8TYps8/Y2aI9kDyIYp0XP
 CJLuleagsVT0l7Q8QBqriELnFosKXAh302cdMpuiPZxVstV9zOuNrzUp0mBev1jo6hOan5ikK
 pJGXSspR1HnPkn7leXCWyBnAr6G/OxHSC8h1lGzyMYHUmS5PG96bE25CdzyazcMvklwSCyObo
 yoy8I2RlcbBBQCLJJnvhMduvhllm0knHaYP9XpeYucs/wUp6fG5nU5QuBRzkfzgwHuzxmoF2j
 Q6fdVYwBNxPPZeB5Ay5/MpHd/3Ec/YSnuQROs29IG2kBbr5lY21Hn/NYDBxJCWi5gIp+ISMbM
 uLr4Xs83OMkc7T4RNwHS7MlZALC38UGYlTcwIA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The /proc/pci/ implementation already handles these just fine, so
the entries in the table are not needed any more.

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

