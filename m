Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 643DE17E753
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2020 19:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbgCISh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Mar 2020 14:37:57 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54799 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727335AbgCISh4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:37:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id CE19222083;
        Mon,  9 Mar 2020 14:37:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 09 Mar 2020 14:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=ehuCKBmU4FSJ1HUdHGVcbBnCNb
        sNAlKRgEWOxW2ISu8=; b=LqRIsbGK/fqUHtlWmXGylUnb2XX/WGtETa+K3dITev
        QOEJ5flkJnT2mPDcenYNc6yHI8YqhDGi3b/i5rSoQ7cHjzIdycfLydqehOQiA3k1
        IGcF2mX9YYIp0R8XGdSjZU2Se44D1T29cI3ri5/qVSYs51+qzVXPLMSUWRgGnJnx
        q+Ho2kod0ySezLUvsGrgaVJ1aQEnu4JhIBI1fdv0VUkJO8MFSA/Cxx9ZfEZm9rT/
        AzCD6loBA+3d4+0WCATVBQNSl1GlCx/xu1UuKXNJm5Fl9tp2gMWypcjwTeK4KZlM
        5hGMuDIc4UsRw3vn7C32fT9JvLHbAzOEKXn0BRCJD0cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ehuCKBmU4FSJ1HUdH
        GVcbBnCNbsNAlKRgEWOxW2ISu8=; b=3nGl4byVGxOnR4b+ErsJIDBf52IEj3Pdp
        AkqMfnKw7u6QEkgGuHAhhDXppXv3lCv6+2T1ZcmX5U33KJd0xv1SktYpZbp6fYBq
        q8//kQkgt+k+yucKkdphwNxDkFDRd4pgENGYeUOp+4AVvO0wHyV13CyURMbtg64j
        vh0liOAljsL/Pqj/uK3zdL9cQoRz+5Td/Vu17j3DsIEo9cjn0LqTror7i3v7ju42
        hVgmyMym2KdWR/Sl4vZHet/Ys3mr5gjfclA8SK6ZKWclOAhjXmF2M0vTTRQoAIJH
        A81P4bM0lffk3WQqupIruFgejpW/9zPgXuXVeh7zXRkDnlv86WDMw==
X-ME-Sender: <xms:A41mXqgwUVx3ptpMuakkH27S7D7kxJDzGp25QwuNns1zfazmrpHWsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceougig
    uhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugiguhhu
    uhdrgiihii
X-ME-Proxy: <xmx:A41mXvScTWz1-Hj-3YCYUvsLEp4dBehTcj78YptsVSsU_CQV2pqUYA>
    <xmx:A41mXtH4qeIoLaO_oTL5nToPA4zLDbt6qEXvPh8_xzj_OrPyx5cvRQ>
    <xmx:A41mXnnAleVRkcAC1RhZgjQHtOTsPzwr11uZvt6F4tvr2BiiLT3vBA>
    <xmx:A41mXlyE45LCt3W-7BVnIwPaUS5l_N4pmn-T3Hzp7W9HRacXn9t0Xw>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB4AC328005E;
        Mon,  9 Mar 2020 14:37:52 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Daniel Xu <dxu@dxuuu.xyz>, joe@perches.com, kernel-team@fb.com
Subject: [PATCH] xattr: NULL initialize name in simple_xattr_alloc
Date:   Mon,  9 Mar 2020 11:37:18 -0700
Message-Id: <20200309183719.3451-1-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It's preferable to initialize structs to a deterministic state.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/xattr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..92b324c265d2 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -821,6 +821,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (!new_xattr)
 		return NULL;
 
+	new_xattr->name = NULL;
 	new_xattr->size = size;
 	memcpy(new_xattr->value, value, size);
 	return new_xattr;
-- 
2.21.1

