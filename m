Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15681B89A4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 25 Apr 2020 23:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgDYVmv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 25 Apr 2020 17:42:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:60137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgDYVmu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 25 Apr 2020 17:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1587850968;
        bh=90DKm7dy3WqWMYgQ2eqHWwqp6FkxbBhEmccEhmdQmQw=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=CCa/g8PoXGNOzd7i67kVn5L3z4jS+dNtVaaLu2AD/SNNp512942F/Ned3yN+O+vak
         s7+EkKk73/RXR+qWY+VqNu70f6fpEihdsND8K8F7ZYSQmNDxyGsGa98VsarwY0mwck
         BkCTyMCXWMLLEh2VrnAvxb2c9Kod9psxm9FsSV3k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.179.136]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mxm3Q-1jGqKk26r0-00zBQ2; Sat, 25
 Apr 2020 23:42:48 +0200
Date:   Sat, 25 Apr 2020 23:42:47 +0200
From:   Helge Deller <deller@gmx.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Laurent Vivier <laurent@vivier.eu>
Subject: [RFC][PATCH] fs/signalfd.c: Fix inconsistent return codes for
 signalfd4
Message-ID: <20200425214247.GA9651@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:+Ok7YXcplUInscS6eKhkONGqVj8fwqJQdPPBcYVAYsBEmmFpZw5
 GYRasY1YfLaSHLtBXQHqsfZ+re539w6T3n2/7H+krwGFG/aJF5X4C0mTdorLS0ayfyr1SMQ
 IGRmRMXGz1Xgc2iV76pTggNMDyfUfIIOrhFASUBK4Zl9NbKq9n72NX2X5OGL6/5s6rqPG/s
 NE8UV1xxjmd8s0LkqnJog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ymJxjS2622Y=:ejLq4NWmz1/isi33KgYnSD
 prKQDql7c0AXeC7pxeZf0BvR4D1YoRbjeG1jEx4bN6NSY48Akx0J7es6ikII6CcV6+q0Olm9h
 X1TS8m0/sVwdFq2qY9fY8x0nbWJBhFPrVicN0CBGYUyJR+EmROOQr7okDKHokQisuPeFUL15O
 vXWjI7zOtJzytrsVzQu72i2tWG+kISmFFwbdZe2INyUSTIJW2B6xw1JanbZFM+Rj2kz9HfJR+
 uLRa2UJfn0nJVYyFv8SytCkWwjf1oP1ae3PT90pi1mcafTyG4b9PNiI7CZdGYzzBX5RvEBItA
 D7/EjHQafBpMC74TNjoDFkGF+Y41YPO6hr/1W4Ea+JQIfjLDlWtm2/rOkSKb6F6Nkra7HIE5o
 +PwiN3Z3j3rv26bg2W967zc9az3ZLN/ILyp+o84ZKk2y10alPXfL79ETrJyXlBtIMhxG1r7gi
 q+b/Y9M+2D53/C/BtDJgp4S3GO2VyKd1oswf2RHiyndeosBWZjcBm3gzYWjXd/Kfd192qKBVL
 WMTYlI7ZZoaZSJ+pf9GnFQhKfaFDy+e1JmQzceF+J8FJq5Eag8hCSBn2Czge48PRdlOfWyCh2
 QE0Ogeq3/WkI7JqIbHDm5DCrYvCjZZTxZPV9HWQ0LXxvu3Ng4xnydq9fXGr079USfd4zaQ5CM
 asii+kE5898NkFkFha37grTbIGgQmwosuv15YEcqQY6RNdkJ+1rKoGuXiuINLNXfMtzHaYY7i
 kMsqLS6e/IdD8qeUyXjt+KJ8w7Su+zyUVWPMNH0/l2Po1Hh9pfCm8APhJFBc3GQusaj45Y9Di
 ExhaAusGh9QGCPd4i/q9GcFJebU0yS8BqnayxDNJbryBb1JQt6x+rnFtM3Ne8fRSMkAYozgo9
 mGz6cgkcnt1aC6aJUVxg7ZptPwavnwsdqJoqc3/HBtngk0Sb2XerMcu+2R5e0SL9ym2+m6yl/
 n5ApMVdpArzIucwkKsjDyQAAk6celKU5gUmY2qnN5cOxasRMGNPo5etM1iVFPY9cJhh4SbBnA
 FuAHA6pUaSMvQbasA18urI63k1qSd5K47XsA9ycjADo9BROBsBdPjCpvsDKxqIibOBTJ07kw8
 KF/xrV+R1QQI024dQNWnjMl8NliD9JlFNyt/AVclWT7hFUMPuh05pyDqj3kMVV1qzSiOrCjJu
 aA6j4f/PQ8Tp4JhdQsY4EbjtpeOIl9M134I9OnT5WdsXkUbkWFUePKQrWdhipRK4PMhs/ry1F
 c7ULWh6S3Oo6esfQX
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel provides a native and a compat implementation for the
signalfd4() syscall.

While looking into the qemu user emulation code, I noticed that in the
kernel compat case, EFAULT is returned if the given user mask can't be
accessed, while the native path returns EINVAL on such failure.

For the sake of consistency, this patch adjusts the native path to
return the same error code (EFAULT) as the compat case.

Signed-off-by: Helge Deller <deller@gmx.de>

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

