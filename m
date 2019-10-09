Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57CF2D1808
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731909AbfJITLR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:17 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:33525 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbfJITLQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:16 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MUY9w-1iiiBO3dmy-00QSut; Wed, 09 Oct 2019 21:11:14 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-input@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v6 24/43] compat_ioctl: remove joystick ioctl translation
Date:   Wed,  9 Oct 2019 21:10:24 +0200
Message-Id: <20191009191044.308087-24-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:x2cKbCWiwvtTu0Qle1GTAXaofujFu4TqPOSrzfs49dxShM/dHOg
 AM8+FdkHPUNbbcajz9XAKdK/00jXiMqsA7QxZ7e5Elfsjj/JgJHiRfQpUiydME6xnaHzZFE
 DICT07/ckpbdTm8x6zSAJ7ENEf5ADRKW4Hzfzb0uCmZhtzEFqUgBNACJf1folSnv14Ykzwa
 uLzFp/WEybLIr+pcSNFzg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3WaeOwFJhJc=:nuObE3Ol7NblOV2/MWCAkC
 xS4Mgc2fhrU4MUe0GtkE61H5snv7FwEBJsrBMARTxrQ1txWFb5+jhksnjxb9pzXvgtHYoXm3C
 yH+bOdbsD7kqWzFzzeHZZaKlKuWtx2HuWP0mhVvTgQGuVY4TSSjleq20X6bZOfOU9opdffRir
 T8/drHeM1JKBUMfsM5iT/JMrtmappIQ2kUea89pFUNVRTDplxOZqdQZYbbEttsejmtLL9f20B
 h4cegT7gWt0L2WfK1d4VrXqU+ITwBYdNh8VVVCV2Wzk6seGnEzdZgt0Oym8AUP0ShNLv9gMid
 ACCVpUU89VV3h6sT+mAQ8WfWq4mHBvnVMfojL9NiQvN8E8k6f0PTp9BnIh38xCxiLy/hy9y2e
 ABmCVY/m7tMwgyTm57UAg514liHZ45SAxnJxu3Vt/3iwrS4dyDiPofBKlWxuVi8C+S7KSIw6y
 RzL4L6lyQnIvBvMvvlZjXC0FJo5a99j43r2IT88DkGIyvCI57Li2+hCrPg/Dg1E7gtk4sQnnF
 zYQzkOylD9/IosZV4QxXgS3CQic3e68j23wUHvyd8CbfL0t8MeNB869d9q4jYKBQz74tOpRkv
 tUHX+uvgRdTG/d3csFoFAUT2DYOuKUyru+Y/52KOXJZsZZLB6OKJF4nwnZWjVTANxC1UG6rFR
 D+vPkiBVz2icsVJiyw9H6qpoQtvwmMmTzAR84wY6yWhp9v+uTI5ibhcdi1QzQasynrsAmMRx7
 JSG7gnWJLTjuBSNfEGz/qAzZ9meKQeivQi18CLzyv5q4zMQ9PXsM4iL7oGbT8jgUuWrCPfbFf
 Flp1lEd5dd4RKIkV2cBqTDt62t4eYcrFaQez+alalTIGHvZSOxOZGUiIoamsDeP8F0htoga76
 uVLyPKoiSKplEYNIawfg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The joystick driver already handles these just fine, so
the entries in the table are not needed any more.

Cc: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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

