Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64194D188F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732218AbfJITPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:15:09 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:50007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MysmQ-1hvvA00PA2-00vtiP; Wed, 09 Oct 2019 21:11:06 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 08/43] compat_ioctl: drop FIOQSIZE table entry
Date:   Wed,  9 Oct 2019 21:10:08 +0200
Message-Id: <20191009191044.308087-8-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:a7QlAnOV7xXH9snDmC43ohpojU7Cxx5excOFhHsYBcQcOJ9DFCL
 TSPUaQ06MDh+fiJr8p5OLIErYcgJsAdgfmtr/Aio+NrpZEsgkA71CnXiU3CDOr5i4azd1yp
 nNDTMmOYw6uEVYIRmgt4OHganx/2wTzW5IatVrQ4sHQMIpDFEDKdMWfnC4EOQo53Main0Qc
 c8aS0R9d8HZoKrv8CoUcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oZv0b1Rd8Yk=:IlrKvEJW3uzEbJQfclRIm5
 mX/CsGd0nN/QW3G8wrylVxgOwJXtkxLB4BfpwMWFsuHXCHtPksknaQLwWHZRPY41Ol6SwZQDC
 X/1rVGlJ/UwI8dxZLhINM4WsYm77SoVnF2PwS8iVjWWfLSXo6GuIaxv6bNT4sO9CU0mrXAyg4
 k1QlEaF4UtLFt1kvRSrjZIIpKm6ATcMOWYQE4o/MUJl6MS9HG9lQb9QHEqlPcHAKO+p5tsqwp
 TUIa1dGYlXULRRUTu6PrneZ0FiWQJWxRwA97bvR/q5n4XmokfYZtlPWEv6CsAB+Cy08WWzDvP
 rDhhVsyS89r7umsxU3Emmy0RbGdcbJ4+Dzk5nC8jSVcv2YFnY7c/nlbAExm7knBscJM3Bk3wz
 iIOCp1tl99Tc5bwUfXFNDGj+kh4HtMypgeSHqXmC+kXxm1PjiHkLZubjTFMkeIOSEWFkwcJjP
 4NH3zwIzMGMpNLF8HrJKYWnpEszEtOEQ5gpSnEyx+/c3/AXd2BUCizZC2FQPDCi5BNNJVlr8r
 s1vqVELmFfUBMJpTQuEm39IRq3lpDPbFkvJ63xhOAC+utZv3HmW7Ivjw7AVNkENKi9twyATWG
 cY3XyWkDVrVuq8JVQA9UShHoli8M/UFR34Lo2HOrRntwKbgsmHP7BXvK3Nb4BAY+EhVcQ9jPh
 zcFKuF9U0gNcKFgGuRmL8pMyD6Fc33GwgnATKNsVykEhgJlFMy4F1DfKkxTBzntaQ9Ut4IZQM
 LGIda6njS1yiHSpA83wh6Mw9Dd2IPuzGBmm9kAksXY/E7N79oYkMiBD9OSnqV0NP7UYkDtCeU
 t6giKE9Rtz1ljTSZKt/goNm7F1ubjcGGwQyaGNFnBi0nKkMgF0qT7ABL40p9SiDfpPuojb7Rj
 cuTJpHBXVf4eVJ2uUM2w==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is already handled by the compat_ioctl() function itself.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index ecbd5254b547..cec3ec0a1727 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -528,8 +528,6 @@ COMPATIBLE_IOCTL(_IOR('p', 20, int[7])) /* RTCGET */
 COMPATIBLE_IOCTL(_IOW('p', 21, int[7])) /* RTCSET */
 /* Little m */
 COMPATIBLE_IOCTL(MTIOCTOP)
-/* Socket level stuff */
-COMPATIBLE_IOCTL(FIOQSIZE)
 #ifdef CONFIG_BLOCK
 /* md calls this on random blockdevs */
 IGNORE_IOCTL(RAID_VERSION)
-- 
2.20.0

