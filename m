Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 845487B3F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 22:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfG3UDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 16:03:23 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:55617 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbfG3UDX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 16:03:23 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Md6V3-1iSR7j2KDT-00aHcj; Tue, 30 Jul 2019 22:03:20 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 25/29] compat_ioctl: remove joystick ioctl translation
Date:   Tue, 30 Jul 2019 22:01:30 +0200
Message-Id: <20190730200145.1081541-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730200145.1081541-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
 <20190730200145.1081541-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:PBzVUTDgE7wJQfrGtSAz4FWJFxvfeGVLHgVspKugDuJpPNyNSg6
 aIb8z4u8Dl6N7U1LCbSPLatvjYO6m5KxqclHjqfHHpGX7qPhe4axSPrfdXiqTs3VeNscQfW
 suvKMgoaHrqpW9oAQQRf4rl85ALpc/fOJySaR2Zu074UfT8sJoIP+1siQt67/jaT4bimNjK
 9lh/CIalQFhIKqK21ZjZw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LwtAdHe03ms=:lgEEPBv8Dq2M3w4aUoQbPY
 fqOrImQzso9XGFHU+lEB9R7R0sOxb87x7XhzMHViJG/PjuFIyNBBJG2RdXJ6OaBH5Rh4dFCra
 8V+C2XaDk+401ej/37bH3TdnsmvOPgIjFZbBPfKMgE3E9SVN+ioUb/06gWnuxYN19hLvojavm
 u1XrLp7A/J5GcKFQL/y83gfagv0KaSJI2wPteprezJVYKkxW209s4mdtbCvk3QUYngqGD73+o
 LmPtQyN3+PsVyY7Q5v+rV0Y1hNjab7iSAR2qq33nSKmAEhKErSgiAV2/6DQLz0aL/evFOBRDs
 22Y10jsudGba8ac91APLwUhwWPy8ML4EDVUmJ3xedqsZGBrOU1mmi3T9xVKOOcVyRt8QLfkr5
 Iq5u0kDgXKqt1Wq32/quhBYRasrnmUOGLs9FkWbJvFhjqVzv74N5ki5vyHYaSqihv079m+e7U
 iJsn4+B6hDuqTKHMsy4vin5lM9G8tLVWRSqKqHzBmPOhJHB/O+rMqiO96ECc9V0A8d2hd9jgM
 7ymBta+aPm8wUwB5GyYR7Hpw9/whFFztMS4gJCGR9xGsjHmDBtANTvmLhLSWruZyPqk58piB2
 AtWFNglDr7U1pA3zd4pK4cn6UiSxXHrLBSHbW0F2/9VDpkrr5y8cdvtcFcqL1qgfxBmu9MCOI
 cta/fZ48fS5s2VrJ1MqapcriN1CKPiYIhE6KxmV9CgzbplXr5D/S3hpLvAeLas69Swn8CdyFb
 vX0MoJFYXfAn13h0l7TEGQWq8HnBNL5kaWfCdQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 398268604ab7..a214ae052596 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -11,8 +11,6 @@
  * ioctls.
  */
 
-#include <linux/joystick.h>
-
 #include <linux/types.h>
 #include <linux/compat.h>
 #include <linux/kernel.h>
@@ -444,11 +442,6 @@ COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
 COMPATIBLE_IOCTL(PCIIOC_WRITE_COMBINE)
-/* joystick */
-COMPATIBLE_IOCTL(JSIOCGVERSION)
-COMPATIBLE_IOCTL(JSIOCGAXES)
-COMPATIBLE_IOCTL(JSIOCGBUTTONS)
-COMPATIBLE_IOCTL(JSIOCGNAME(0))
 };
 
 /*
-- 
2.20.0

