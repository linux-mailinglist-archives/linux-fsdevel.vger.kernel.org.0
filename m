Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80860D186E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732242AbfJITOH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:14:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbfJITLR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:17 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MRn0U-1ifyMT40R0-00TCk1; Wed, 09 Oct 2019 21:11:16 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 28/43] compat_ioctl: remove unused convert_in_user macro
Date:   Wed,  9 Oct 2019 21:10:28 +0200
Message-Id: <20191009191044.308087-28-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dxM3Jam6TjHHvCF48LVo6gIfXiFPc6pem5dnhWv8FdfWs/yzMLy
 yFeFJW+IziOK7Os4wZmRjmYkpkYL4VLvBYQeuhabIMTi5fe6jmiJQ9YoJsQmsyoStwlZnYa
 +vLbKCn5FXBGJ7dQy6KV8rxhA+WIy+6uoPLGC9bhwKuR/wsCegm9o6KdoyFhbYnrZCzlSPv
 IgMu5fqbTkuzblCrLmFfw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNKsKDDFZ/E=:pSkQDFwu4n0WOuakXlt/jd
 ykqiJT3eFWg05XP76lBbAaLwiBF/CzorjHaWEyxJALsvEqCBTMLd5LivOaF/20QTC0bHVpdTt
 S+YF4ik1L0l5Vhmj6EL6PgJ6jJIFZWbrc7DUWsv+yKSr4e+u82bnDSpAbAGnyJ0jydkb8trpS
 5Ot8XQzAwdPxVcPOXQTHWJXzc2yKZcaApYZqOFWSzxTSxPUkcM0RLzypv0o/kiUx0vhUwMPHW
 vrGq7E4NZjitDeKJnJMkWqv2PeYrVvl0MYQiiRoDoaiPkKe0TXuO+jeZ+shbhMd6M82x34ARG
 w27t2+bzvhqc+4mCBPVxOxFokGZlue8+aF+r2BVBBaWp/h2fC3pSXsdn4rRSGgsWdxt5rdJop
 72iyPGVWuuFz20i0Phrj+Jzec41AMQgeqZCCbwoBI7yW1XMZmyYEFVtNMRJ0lHQTw0Xe82NuM
 /EbeV4xAysemTtY2+Ud/R4yAehV1v+0KBBr7tT3tMi6X1QSiqFHOkNx2TAgXbspy+h52yN6ID
 jCL9S3iX0TbRdAniN7ITxIqlZIFv/XXDwKDLNkFwjeMT2yWdzMnPaVJFWXEZEuZYStHv5Q+Il
 IWwrj1m3s6VX3UEH9/15iXtuF0s0ilB/+MuXhE6uOHl9sYmSZ45CXo5k1GlSCrU1sFswPUmsv
 qeO5w0juMXKyNIJiUC87WqCVbEiDXS4Iz+8J9WPnT89KJQZAag7Z5Kug2TrtVqRducVN/vkyg
 Sntb+4M6vOKl8i+DwtGPkeuC5W6G/J3tuij/YTLToGOc5jqLuwCqYFdcfeljwqfcQgaXP95Su
 WT1u1L8cv8N1972cO7ATrlpGTXEMiO9t1+y+YNRhWxNuSch0UG8EmXXldm50v6FTkyPiXNzR8
 j3ShWvO4LTToGT0dw9zw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The last users are all gone, so let's remove the macro as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 1ed32cca2176..1e740f4406d3 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -52,13 +52,6 @@
 
 #include <linux/sort.h>
 
-#define convert_in_user(srcptr, dstptr)			\
-({							\
-	typeof(*srcptr) val;				\
-							\
-	get_user(val, srcptr) || put_user(val, dstptr);	\
-})
-
 static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	int err;
-- 
2.20.0

