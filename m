Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12D24D188A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbfJITLH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49027 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731144AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MK3FW-1iW6z83kZq-00LSxt; Wed, 09 Oct 2019 21:11:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 03/43] compat: itanic doesn't have one
Date:   Wed,  9 Oct 2019 21:10:03 +0200
Message-Id: <20191009191044.308087-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:me/MEPlFVpyxtVAUYxu6rBj0XDYCMOw6yYIMMAoP0u+lHXr9Rw8
 HDntE6qFkqRh44fUDhevvaIXcFCCvAlj4ePAixc34Avd7/+Z8MSlEpnRDVXZvfnyNXxqce4
 frZ/aiIXOEwDKzLpZJmMe7gYEToaqkgf41NU3LrB7s5wU8iD031Z5DDuGWuNazl5KHMHaNs
 XNkY49lDHzsJf6YFAqL5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CjsuizXD+es=:R8lkyNKPhuJHl0LetWM2wV
 oct9DZT/umpsZ7M03N7Jf4nci1dyYwQyDr9r7FgKhSiPWvXF7H/mnprZ6khx9db71RS0vD11u
 17Us6mcJTAbAsyXAm0iOMhGr+iAdTV/BsvC+ESgDv3xswJ/CKGza4DuMLZBp18l7xdQmzW1Fy
 OQqCt6edF9gOLNhEF0OjTlR6P/1F2cZOnJ7uoa4cm0yP9+BkWLpYUL23e5Svx49S9WCDqpKYR
 X+odSSinrSmle1xTNLjbnbZTDTf36i8rfW4iSw8f+dz+cv08I0KLtkQQNXPBy5a5UHKtFTGsP
 /mK1JgG2qwu67Aimkf5wuzsQEeiBITcW5bf0mKWH3eOYJr8txGJ7xG8OBeL2WFCW3CykZRou7
 5zUCetvdhXRE+OfvERpPiN82VLpcGZe42WYiAEVm5YP8jN1NcyN0X2mzJBp3+b5mnobgPyYYn
 lxjk/5/TtsK5W3jjvd5bgeJ0dSjNe1jKwlYkTW+AjazMo5iHiwLbj0rOvbNHHXQyij/F7xFgQ
 BvkH0Kq6giwPD0vsYYF8Qyi4/NZ/oY689Q3WgAOZttjeUjB4f16g6Pp8s2QBdMCiQO54TrwQM
 UQOOw3WzgoMu0e7TelQHxTn1I/Cxy4N/CYyAggvfhz938W9GvCFVMVT0tioNZwHMQzHm7D838
 FPxdM9nFc/yU4K7H9CEolxFjuHqHTOwDXzYnZ/a9OMfQG54FHuQbiDkoRalgO+fP7BaVu+NJl
 avRAp1uDjym7wPUraisRpuZxFm84xmx2hx5/2aH4p1vrw1ZzKNueMtVWJsanTzh0Kc0s308xa
 MdxIda3a321xpxM9gxre+nCxhMYxaKd9N086iEi6I2ZSWEsseGI8RYGoG639idqQTz3keYwS2
 E2n8y5p6hccLXcYTJlQg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and hadn't for a long time.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index a979b7d1ed90..46e8a8f8b6f1 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -468,7 +468,7 @@ static int rtc_ioctl(struct file *file,
 }
 
 /* on ia32 l_start is on a 32-bit boundary */
-#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64)
 struct space_resv_32 {
 	__s16		l_type;
 	__s16		l_whence;
@@ -1019,7 +1019,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	case FIOQSIZE:
 		break;
 
-#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64)
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
 		error = compat_ioctl_preallocate(f.file, compat_ptr(arg));
-- 
2.20.0

