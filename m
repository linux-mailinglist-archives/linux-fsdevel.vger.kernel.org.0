Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27DD6D186B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732024AbfJITOB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60635 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731771AbfJITLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MLAF0-1iZOmA1c70-00IBAz; Wed, 09 Oct 2019 21:11:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v6 15/43] compat_ioctl: move ATYFB_CLK handling to atyfb driver
Date:   Wed,  9 Oct 2019 21:10:15 +0200
Message-Id: <20191009191044.308087-15-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wR2NlVbiBb91Qld9p1E8SVGpgQSa/PNuWiWhAMD/fev06KiD/uN
 7xAh8aX5DntNGju6RDV5on88/k6k0s3fIq+ab8ZleNgBUbADW3nutlhIlBOb/0TTD4E/0qv
 ZzA5n6ipyhv6KcGlE9eCcjyQdEQ/b7ByFb+HGKsJI2+RvYjK4HKWRPsdD2fcT7GKIg7+kDu
 ydGEUoRl4MUB7ItgTSCsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:TCHutZOkv2g=:k7QecOAP0I00T1ZLxJ5d9v
 h47N6yxL/3wzF5sFbBGQ/K4UZvEokUYYSIm2HQfHF2kchCzxYnUUf5IwSMROQu1n2MjvSokxc
 iMsQcmI3qoOhPC1YI5BeA2eHZ+D2UjqAq0jOygB7xPLUQZSWnV7xzci7SLhiAzq29N5gINODk
 iT9JjSXFtW0W7WhqKjcLcuxf9Mk1xyqrEkspRsthq5eDbaO12WzdzTTkjq6FoGe6UWwyWqBKo
 Igwe8BiTqf296IT1+a2amF/MRtZiH90JEix4iOx1CeUTS1g1h3ROTw91SAyVnC75oFOpal5Sy
 x8manfs1I+2de5PXszzd4oZjFVKLAcm8koWAivK9SV5A+UQIE+06Pw2S7YZ4lRoNVqQzQcgTV
 f0tNu5UdGfRkYZM2N4F0KcuH5ZHRgL4n+7kbfnlArbvLPJ1gp+oQNUOFTC7C+rJD1+/XpXJmY
 4M8Bfl64nrqRcJMaYyuFWDJGZzqGXbdGgI9MsGgSZXb8sZZwAiMAp+kMIidj2+jLBQdZ5wHq9
 PhDpvpV7T4yVVM23XaoAuS08Hs64vdP1CyHsPBpSRksMMe/K24VEI9gx8Nhlk9qJZc5whUISR
 il/M1CF2X/cMe5OE99Clnp5qPuP9bqXZPajTpFpbOHnKYGW6ne6G1mYP8SULp+M041cPUC4fO
 LStac9VL/rUoEIQjjgp5n5Y8oHBxx65A1siXnaVX+DgUBeX0KE+cus4P/NhOcpPLrNljWWI9p
 qYMqsfX26hU4iRMcZQxUTuvKK1fDWAiIl6hf61DGg6JheUG3NkC+QeP3m2pVRju6e4zBWZSbn
 gVtlswksuGBtS8F9bihMEEWYgozi+Gm9F0xr1CYmMNxfsPdmQxXqr7qPsi/knipf/d5A5IhQ8
 XXPCM2upXsi4/zq/l/Ow==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These are two obscure ioctl commands, in a driver that only
has compatible commands, so just let the driver handle this
itself.

Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 12 +++++++++++-
 fs/compat_ioctl.c                    |  2 --
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 6dda5d885a03..79d548746efd 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -48,7 +48,7 @@
 
 ******************************************************************************/
 
-
+#include <linux/compat.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/kernel.h>
@@ -235,6 +235,13 @@ static int atyfb_pan_display(struct fb_var_screeninfo *var,
 			     struct fb_info *info);
 static int atyfb_blank(int blank, struct fb_info *info);
 static int atyfb_ioctl(struct fb_info *info, u_int cmd, u_long arg);
+#ifdef CONFIG_COMPAT
+static int atyfb_compat_ioctl(struct fb_info *info, u_int cmd, u_long arg)
+{
+	return atyfb_ioctl(info, cmd, (u_long)compat_ptr(arg));
+}
+#endif
+
 #ifdef __sparc__
 static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma);
 #endif
@@ -290,6 +297,9 @@ static struct fb_ops atyfb_ops = {
 	.fb_pan_display	= atyfb_pan_display,
 	.fb_blank	= atyfb_blank,
 	.fb_ioctl	= atyfb_ioctl,
+#ifdef CONFIG_COMPAT
+	.fb_compat_ioctl = atyfb_compat_ioctl,
+#endif
 	.fb_fillrect	= atyfb_fillrect,
 	.fb_copyarea	= atyfb_copyarea,
 	.fb_imageblit	= atyfb_imageblit,
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index b65eef3d4787..a4e8fb7da968 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -696,8 +696,6 @@ COMPATIBLE_IOCTL(CAPI_CLR_FLAGS)
 COMPATIBLE_IOCTL(CAPI_NCCI_OPENCOUNT)
 COMPATIBLE_IOCTL(CAPI_NCCI_GETUNIT)
 /* Misc. */
-COMPATIBLE_IOCTL(0x41545900)		/* ATYIO_CLKR */
-COMPATIBLE_IOCTL(0x41545901)		/* ATYIO_CLKW */
 COMPATIBLE_IOCTL(PCIIOC_CONTROLLER)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_IO)
 COMPATIBLE_IOCTL(PCIIOC_MMAP_IS_MEM)
-- 
2.20.0

