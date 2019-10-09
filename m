Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDABD185B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731942AbfJITLU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:20 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44075 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731925AbfJITLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Ml6Zo-1hohFn2sKC-00lYdf; Wed, 09 Oct 2019 21:11:15 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-raid@vger.kernel.org, Song Liu <song@kernel.org>
Subject: [PATCH v6 27/43] compat_ioctl: remove last RAID handling code
Date:   Wed,  9 Oct 2019 21:10:27 +0200
Message-Id: <20191009191044.308087-27-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3CRT9Z12XUAyRUQyiP/Ny9jsvP99Xt3bB4wOaOH4lYcwl+MCQmr
 4ny/SJ3flpq9XK569lBll1lT+ZebWGdnOOHMhvGO3qCwoz3R1rpUDMrZlo3M/drYoWDwS97
 fHvSUA8p0sJNSXSBi2aKEM5iDl0xiG4oz9jUNO3T4N9PHEyZTyWhwc5eOnRcJolaM34C1Cw
 +qLzsqgP6uZJnGqvz02Tg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Q7U5lfH9wpw=:NS4oi3Rk6pVuu5vooRritq
 cps6Gej39jDT2cTqPxuf34ErLBzJwUGbB9MHBLGdxFjlZ/BTru2GpXZI1bTfCCCuZ+0rUTasl
 xW6GAbhakr3dpYLVvCIcRfAoC/W7nOo4muDIL6OrOt8LRkhBQszFs7KInwH2hwZs2FS+cHQU8
 N0NJuAQn1l4YAvTkkUPHnxDtUKEnx1Znl9aNbVSXwL5WA2jrcS0Nl5mXBamrkbfbLEhaOyw4C
 hqKkI96iPLmGYNwJGA4JC9S1uSIza7xXW+aYpZq3uasQAEEDgMuhXNXbN2/DHnyiM4uXdgwoB
 VTCUMQBCZIQDSca7ZyanfcjhQfGWxWiqAVqhDSQEppX/ZmxU+TJzHDcXg2gjzBU1BnHIEmAVH
 GdLqDg4mrT7dkULbGuvDiwhKlbnpdzYYyts0e9HmXsD7m4U04tW7USN1szd1Pqn1xercATVMv
 P+NkntIgTyWqM2Y/WTtdmUoIXqLvYP5r/DgXUwf6uKRqWMM9uu5sqgDfE39d0Vn1pRxL49bQm
 Q/dTVVHR+6M8f8ltlaI/aXDeMpWOuH4O1/QBVTCOfb1QSjULoid4X+Suh/pYR/9O6kGSdcP41
 7S/8IBIHfDS1XJQmSEMB06ZlPF5egvAADFn+pEdw5nGlyt5PKKSy4sRXwUyndJ1eKsCCP1FDo
 pto1YyLZmQxa3Of/gudfvp4mGSNUKISXxtBUlu5CYQZHRFx5YO/wkWXAZOC89Pa8ZLiYLXyFi
 BXEerVpyU1zR5QL3cKpidsyN6Cn6zCags5Exsxglfn+3h7+l/r7MnkqH5KFFx2RzIO2X8Z2Jt
 CWZS8ZdZVV275ynQNraysjmfCUP6dXdE2oXnTjzwdLThEuOlPtFLS1zXl+UTd03zc59oNqV6m
 pyOKfuVdbxzihoVzqPDA==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit aa98aa31987a ("md: move compat_ioctl handling into md.c")
already removed the COMPATIBLE_IOCTL() table entries and added
a complete implementation, but a few lines got left behind and
should also be removed here.

Cc: linux-raid@vger.kernel.org
Cc: Song Liu <song@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 6070481f2b6a..1ed32cca2176 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -462,19 +462,6 @@ static long do_ioctl_trans(unsigned int cmd,
 #endif
 	}
 
-	/*
-	 * These take an integer instead of a pointer as 'arg',
-	 * so we must not do a compat_ptr() translation.
-	 */
-	switch (cmd) {
-	/* RAID */
-	case HOT_REMOVE_DISK:
-	case HOT_ADD_DISK:
-	case SET_DISK_FAULTY:
-	case SET_BITMAP_FILE:
-		return vfs_ioctl(file, cmd, arg);
-	}
-
 	return -ENOIOCTLCMD;
 }
 
-- 
2.20.0

