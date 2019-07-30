Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50C7B33F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbfG3T1D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:27:03 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:57603 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfG3T1C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:27:02 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M7sUE-1hxTSY19zm-0055Nl; Tue, 30 Jul 2019 21:27:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v5 03/29] compat: itanic doesn't have one
Date:   Tue, 30 Jul 2019 21:25:14 +0200
Message-Id: <20190730192552.4014288-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qaoDHaHD+s46a0f7CuoKPmcS/DsWUB6tQTO63pYVO2pFc9Lk6pw
 YYnbzo9CPSTw7aED9zn5+RGRDdKkvNH2orYMNySDgu/+DtdQjwcJQxeSP9EIvX70gX0J5ZF
 uozFzYSxFxxYjowy+PKfj0Pj5XGsGCQ5wL5CxzAgWE8td96LCcXbHxnnhOJ7lSw04j/nRrA
 36njQCm2lNfGowV6E1FPw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tzkiCjmVjfk=:G3U5T79b/H8a1iqfECjoBH
 Lg3LcXWK1AnnKdYz91XsCpRxsLqTRxnuW/6SJ6fwMwnoHOUtMSIGw6GTOXOoh3xuc5I+/kwQI
 byHHD0PxKHsrtapC0duDNG6h3YcPDd3ujMHXldgPuoB1ZRd8zwKLPXGVCaLTwtY0l2HrqK6Ho
 zQbFqPGETH0wocKzXDRu6wRzSXFM+6e+Uy8mYqRzkq/zXPLskJc58quAJrfKDRcFCfkt8Xcze
 qy5F71aAeiIPazyfHfkpxbiR+kMAtpzQ0WVL1txk/XG/FYiePmHXmj9Btwcp6XmXZM5D6Lm9d
 gNdGyk9b/xuKC5itprkzLPsrb1rfW5bBN72YKue9o80kVSUhvacC972cD60xYflJYyebx6VoB
 nnChjWRNvM8n0n56J7O4MYDIedPUXhGutyN+GXvF976Py8Kszrn+sYrEOgkW90sC81ZU/EDbV
 9/XTjvzPyi1YEkBpvn3I5zuJPo3FGJR+ug7D3huOuA6Hs3+lTIXBTd2CNt+lqDxlp0p3KCikn
 wBNwItf77CpuvMhRaBD44jBMASj7OydGizef2aZrYLp46sCNEjVQJL42ASyyGqURpBOJ/pE+y
 YAwMfubyRg9cyOa7rq2dSmeWVBfkEDctvFAPEKR3ii4A3yzX8TmIH4G9PlWXt+8oVxsI8wjEW
 /ELLu1CA+Cjd0ZPUnNluE2gH2pSCme+bCtFSV1DV+k0iBcHW+5Pr12FeUWBv0pNT9D5+uu8CC
 5LF9MZyvAfucOm404aJmI5gb9YIG61VFImJCWg==
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
index b19edbc57146..3d08817be7b8 100644
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
@@ -1022,7 +1022,7 @@ COMPAT_SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd,
 	case FIOQSIZE:
 		break;
 
-#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#if defined(CONFIG_X86_64)
 	case FS_IOC_RESVSP_32:
 	case FS_IOC_RESVSP64_32:
 		error = compat_ioctl_preallocate(f.file, compat_ptr(arg));
-- 
2.20.0

