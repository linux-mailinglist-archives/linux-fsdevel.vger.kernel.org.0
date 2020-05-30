Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D081E9068
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 12:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgE3KHM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 May 2020 06:07:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:49985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgE3KHM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 May 2020 06:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590833230;
        bh=D2JrPHXwDEJuElh5m0kYfBwMDJGswMtPK54BKXIUpMg=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=hYUQkGmgJ2CXvt/gFj6K1pX3UOHcONB6etBui/SAo/6Vh7Vd91L9rDnlsolTHLJdB
         0xD4bGmXZTPtnIMTonEmA5z9vZLBAfPgqy6nnYIgltJ+6CgZaprwYJ2Cwvm9jLLp0k
         V1baakosYHvGj6t/1v74zIueOElTqy6k67X87W4I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.167.47]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MDQeU-1joIKh3LrK-00AYKx; Sat, 30
 May 2020 12:07:09 +0200
Date:   Sat, 30 May 2020 12:07:07 +0200
From:   Helge Deller <deller@gmx.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2] fs/signalfd.c: Fix inconsistent return codes for signalfd4
Message-ID: <20200530100707.GA10159@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:8O2glHu0d01VKLhpLooltHX2Ri6pSGmEWHFdSzrSx+4xlXHns7S
 I0xeRdVUOHNMgoBeAd8BBGIYvDhZU+nXnEcBPKcUKDNsth0QP2T2Do6UztrW0Fj8oyLR+I3
 4SCQLmWr1RWwTaE9tpnMLdW4GsxgEifDw9PagCJY1I3sDnKSZWrRvJjqmlYNnWkeQf5uruz
 cvAFAxZhgSjTD1jlxVZlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:/VMxzfcx4hI=:jDPWzc+4UW73v8w8mAuGLf
 F2MVWYuRp5MKlqgoFMCpJQMXNzlcooEiyKk0+xyNjD1UjPaoZphNixNUeP5+lgXzP4UVNLTps
 LZ8IAPXCJSxkUJlNwN7swuHMvcSzMtScKKP9K27IC2sgSJCLqvPCQqsfztMZh1CyG0Ojgb1in
 Hu4f3Lu8HifWM2v/93zbMZul5t8V8JIejqezkzytWrNEVii+Hn8YGMoRwlLZCIrHKr6pjT2T+
 UYYVv3B7Afx7N1KBRNOzZAq5Cq43B2WYxOMxD0j8B3Y/OBXb26KTJsvvsvuiiRls68k9JEbVS
 dzi3Y6aPJwfTKuECCxOrNxtQUOuS5RaRyJP9UDf2pnq8xh94AvxuP+/IXAUXzkh0wbUlC+Eaw
 QpPTGobDVCfGIcO9+MKwQbTRMl+0qtKmsM0qGoGxrVE0H+JBf2tRjxQxULZfj+AZNurDrZJUX
 s67pk44/JE7y7NdwlRTopbGIb82vyBluFaNytz2mnNyKWWM8kK101cuyYEzYtGDKobylt6AOz
 UoxpsQmeeB1R3l3ynLKp1CxmqFGyBNpn27HUSrT/LzyvmrGvWiu/D423bf8nAR/OII6QT7spJ
 xXPzZNqgSScnjmBJmxQA8wkSjJ9O8gIB0GmYYPxNBbKBIPgExHJPGBmJbpvRxbwPbBmlPipfX
 8e4R7pXqbuOSGF6Ovc/GjVOIWpbTvvhJdvQ6qKo02YeEa4Irjp6/gt+v0TiIOXfPO3AwDya1Z
 /ZOkp3CmmT8IUhU/P3eaVeIX5qvVdyKDOPPVIW6z9uj2eBc6caAhVQa9pPTBY1e1Oxnhm4fSv
 mao1/rIEdK2gjXWI3IkjX3RyxkBrmHgvHzqDHgmn9jfFMfVTHow9CVcW0wjtm/blRj/JTogeA
 6COLW7x2DvtUd5Lk1ScZfBi6/bKmYIaleOHEwfwuhYMlTunMnk1UrzteUC2XanuLnKTJcsxu7
 muHH6uiNQRTnvEmJttEVKs75AaYllyT8vUfE17k9P+YnqZbMTMS0TkFZL8g4U6jiBrFR/GZs9
 X6rsWJK4vVYCqcgWdQ8JoYubDZ9esTNJ/pZ88v4Qd6YVwJf2oIib8/9Yn7pr6XAQfVSD9l/rx
 CJKCci3vSI8t4Qxbha6HZcwaBKc6xbuUA6pP9BEkB4F8LZEpUp0szHH8s2WPU1yLemefyLM9i
 2djr5urDrk6zjU6nIjshXTEWK7tA1v9Fn6pttEAVcIYi24jTMWkWYHpwYGNXfBBRtknfwX2j4
 WAQGZ0jNVkEliDGNU
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel signalfd4() syscall returns different error codes when called
either in compat or native mode. This behaviour makes correct emulation in=
 qemu
and testing programs like LTP more complicated.

Fix the code to always return -in both modes- EFAULT for unaccessible user
memory, and EINVAL when called with an invalid signal mask.

Signed-off-by: Helge Deller <deller@gmx.de>

=2D--
Changelog v2:
- Rephrased commit message.

diff --git a/fs/signalfd.c b/fs/signalfd.c
index 44b6845b071c..5b78719be445 100644
=2D-- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -314,9 +314,10 @@ SYSCALL_DEFINE4(signalfd4, int, ufd, sigset_t __user =
*, user_mask,
 {
 	sigset_t mask;

-	if (sizemask !=3D sizeof(sigset_t) ||
-	    copy_from_user(&mask, user_mask, sizeof(mask)))
+	if (sizemask !=3D sizeof(sigset_t))
 		return -EINVAL;
+	if (copy_from_user(&mask, user_mask, sizeof(mask)))
+		return -EFAULT;
 	return do_signalfd4(ufd, &mask, flags);
 }

@@ -325,9 +326,10 @@ SYSCALL_DEFINE3(signalfd, int, ufd, sigset_t __user *=
, user_mask,
 {
 	sigset_t mask;

-	if (sizemask !=3D sizeof(sigset_t) ||
-	    copy_from_user(&mask, user_mask, sizeof(mask)))
+	if (sizemask !=3D sizeof(sigset_t))
 		return -EINVAL;
+	if (copy_from_user(&mask, user_mask, sizeof(mask)))
+		return -EFAULT;
 	return do_signalfd4(ufd, &mask, 0);
 }

