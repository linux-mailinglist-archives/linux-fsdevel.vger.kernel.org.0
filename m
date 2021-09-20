Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 888A7411268
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhITJ7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 05:59:25 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:56407 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235312AbhITJ7L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:59:11 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D8CF232025CE;
        Mon, 20 Sep 2021 05:57:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 20 Sep 2021 05:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canishe.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=gZ88mz0rW7L9h
        2hm6YlM1b+UyvR0muQml9/fmkII5yI=; b=a0CWsQ1fs9Tfzhi2KKrT4c7TfO2Nn
        mu0866qyaweF3e8rHiGIJ4DOJWL3UdegrdrwEjkjXePMtZGiuGUqrHCTXyi5C1um
        Mq1NKp63aRqyC4yrVkMo6/tazKCG8OUNs/sc4CkaRSLUti0iVbU417WON2viy8Y1
        rn3Vjwtnp2qevleQvLmNEV+Z6VdeAsuharbJzsDF5cRgFWD5a7DSWDH6fBCECcAd
        UtzslhY/RgZJ8PJl3W7aC2eUHoNNJd7rhWpiAufdKjsRfDOWkQWlkW43MlXXNVDS
        +AejGCBLjWX0x36K4BezBpHk1oR7vGNn5n3iJ87DMSHhQjVk+ySSk1/9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=gZ88mz0rW7L9h2hm6YlM1b+UyvR0muQml9/fmkII5yI=; b=s6XSY8wM
        nLFqb8CVtEpVYEpXnp7zlBhtpB9lXgmYVmCkBEM81GGHUQeyAt4NQGKnY0jB7ay6
        0EiDIpbzC4CaG/rMaZ/N9UdZ/iXqjvDUNt2L4rQAIBJ1MbkLYEJDSJzT0Uhc7Tb4
        nd5m+unopTE0k8bW87R7UTQmqlbrHr+Bm19mY+WP6Vsk8xJciVufV1iFDBxu0N3s
        U/gHfUmebmIvBy5MhqLUyEW5tNICtLXpulq2uXkBpj3QKlnxYMjPdCLHPxRQM2A4
        Nt2kUwLY2PdzsZ/gITWsHYooCgSLxLWOEP7oArcA5CDaFCGKDRg0RxbGfkXmg4yn
        NRS7Bz9O5VVxxA==
X-ME-Sender: <xms:GFtIYTi6caTFEQrOj_F8LxLWbFHnmg_Gd-pKjOXP1Vx5r1yynOEqPw>
    <xme:GFtIYQC2ULXnFX6zPck6D_hkIONzsDUiwKTULB_r03pc1gd4sbSTBvGvCF9TFaJl9
    Dd41RNHPQB-1KXw1w>
X-ME-Received: <xmr:GFtIYTHWQXa_7a1xtk4PCV5yX2s2eiCGjtxGjIUbkjUqU6u3HTKcIFDk_SD13pukPXvUbfeaKk8U51i4mwRa5jCyyUBsHxw75A-zWrxRJiZCrbE0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudeivddgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefirggvlhgr
    nhcuufhtvggvlhgvuceoghgsshestggrnhhishhhvgdrtghomheqnecuggftrfgrthhtvg
    hrnhepuefhleeuffdulefhteehheffieekuddvleejieeliefhieeujefgudeujeehkedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghgssh
    estggrnhhishhhvgdrtghomh
X-ME-Proxy: <xmx:GFtIYQSlh7iQm9W7SrJ5dGVksKpOGoZnihKDDYhUMvkrk3-zh75eWg>
    <xmx:GFtIYQyf9kMacgIuU5IYxjb4N1O5fBIeVZrXHRhkHt-G4MLwG2ngfg>
    <xmx:GFtIYW4c3Qq9XHNBq4pzjuUwd2OhYCavzUONsL_UzHZ5iiprZe3D4g>
    <xmx:GFtIYas-XItMMzo1CpAwCy1O68XOA9jFoXUOfQkUpyUIg_7mDpx1WA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Sep 2021 05:57:43 -0400 (EDT)
From:   Gaelan Steele <gbs@canishe.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Gaelan Steele <gbs@canishe.com>
Subject: [PATCH 2/2] fs: move dirent.h into uapi
Date:   Mon, 20 Sep 2021 10:56:49 +0100
Message-Id: <20210920095649.28600-2-gbs@canishe.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20210920095649.28600-1-gbs@canishe.com>
References: <20210920095649.28600-1-gbs@canishe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The structures defined in dirent.h are part of Linux's uAPI, but
it was previously necessary for user code to duplicate the struct
definitions themselves. Let's make them public.

Signed-off-by: Gaelan Steele <gbs@canishe.com>
---
 include/{ => uapi}/linux/dirent.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)
 rename include/{ => uapi}/linux/dirent.h (66%)

diff --git a/include/linux/dirent.h b/include/uapi/linux/dirent.h
similarity index 66%
rename from include/linux/dirent.h
rename to include/uapi/linux/dirent.h
index 48e119dd3694..99293c651612 100644
--- a/include/linux/dirent.h
+++ b/include/uapi/linux/dirent.h
@@ -1,6 +1,6 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_DIRENT_H
-#define _LINUX_DIRENT_H
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _UAPI_LINUX_DIRENT_H
+#define _UAPI_LINUX_DIRENT_H
 
 struct linux_dirent {
 	unsigned long	d_ino;
-- 
2.30.1 (Apple Git-130)

