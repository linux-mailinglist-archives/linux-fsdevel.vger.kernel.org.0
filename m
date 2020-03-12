Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9CC183A6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Mar 2020 21:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCLUNS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 16:13:18 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:50995 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726824AbgCLUNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:13:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 0B1B354C;
        Thu, 12 Mar 2020 16:03:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 12 Mar 2020 16:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=oNeib/zSSc/Ml
        kvsC3EDiuR3sxV3CwZWI/SYjFLvvIM=; b=cIkAcMhS3F04KFXhXECfvihZaf8SY
        lPxqdOqgjYNwFGO9F5UFYat0HY5wgx6OW9YDVKODzOcamBNuRf/kw83vHAvatcnn
        2HmDqZ+OlK3yfReHpgShA/10rN2lvn71rZZ8rjfiVoJHROORqAtZf+opPmyxnUaY
        3fw5n5SZP7/tQHVCy2Vo2aUafyrv4otknmDIUa22Mn1A5bRdRq0ovugHYUodg4wd
        sIoICvzv2uEic/aE9lkSWANZmYgCoygfY3CLbKdJg37+KyNM7wBBnIJ4So9aFuqv
        /H0Pk1edYdg4OwDiZqF2Ui+9iEpqB19qnPaPYtDjmmcn+P5EdQP50ozQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=oNeib/zSSc/MlkvsC3EDiuR3sxV3CwZWI/SYjFLvvIM=; b=vyqXOR93
        COmOhbX1RIN751Q5MG7SCcb03XDg3em6YYUQyr8Kd5M461/4aEC5mJrT2lGFiUtG
        y7FDLsoh4+qQGwsXSKwMKu4KYfsj7slwQ0RdEE1hiTVoQDwVhOu/Z6uD7/Z4nItZ
        6SLYaIU/YliddTr0RbbAocMOOoIparKJCDVvhV70o+2ojBT5PQRIeAeBnzUAp9Xk
        kFSz3Kn6XolT2J0bEywrHa9mN53odhfbcN+sTduAqGfKFUTeIpLWla9vZ2UEIMpp
        rCpo+umVFTPRBYkg2aSTrPcTbi3rDYPUajO83kpUrG/bpECikiTrzDvaDixm33Vi
        k4ySUJvfmisOsw==
X-ME-Sender: <xms:mpVqXjVLoivK4Yc5b0KWtMlTn4XliHCUABnVaIKzYyhAWybL4LtqXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvhedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecukfhppeduieefrdduudegrddufedvrdegnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepugiguhesugig
    uhhuuhdrgiihii
X-ME-Proxy: <xmx:mpVqXimla0zLy3fAs-t2EyUxTsAe69uxYDMtIYSsfqBwJUh1Tli5Ew>
    <xmx:mpVqXq5JZwEybnX1azVIvR5RfU7SCMUFo0PaaCvx8mOhg0TvwlU7yg>
    <xmx:mpVqXoLQWKcEKSKODIwuFLNSjkyUakshfDzpVYzVsrx_z_0P1fzTrA>
    <xmx:mpVqXtj__-sVJ0XrVWJUnnpCfgmCdjrr3zwMRunsDmQO7XzGJMV_04FDSQI>
Received: from dlxu-fedora-R90QNFJV.thefacebook.com (unknown [163.114.132.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4ACDD306130A;
        Thu, 12 Mar 2020 16:03:37 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     cgroups@vger.kernel.org, tj@kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, viro@zeniv.linux.org.uk
Cc:     Daniel Xu <dxu@dxuuu.xyz>, shakeelb@google.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, kernel-team@fb.com
Subject: [PATCH v3 1/4] kernfs: kvmalloc xattr value instead of kmalloc
Date:   Thu, 12 Mar 2020 13:03:14 -0700
Message-Id: <20200312200317.31736-2-dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200312200317.31736-1-dxu@dxuuu.xyz>
References: <20200312200317.31736-1-dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

xattr values have a 64k maximum size. This can result in an order 4
kmalloc request which can be difficult to fulfill. Since xattrs do not
need physically contiguous memory, we can switch to kvmalloc and not
have to worry about higher order allocations failing.

Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 fs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..0d3c9b4d1914 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -817,7 +817,7 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	if (len < sizeof(*new_xattr))
 		return NULL;
 
-	new_xattr = kmalloc(len, GFP_KERNEL);
+	new_xattr = kvmalloc(len, GFP_KERNEL);
 	if (!new_xattr)
 		return NULL;
 
@@ -882,7 +882,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 
 		new_xattr->name = kstrdup(name, GFP_KERNEL);
 		if (!new_xattr->name) {
-			kfree(new_xattr);
+			kvfree(new_xattr);
 			return -ENOMEM;
 		}
 	}
@@ -912,7 +912,7 @@ int simple_xattr_set(struct simple_xattrs *xattrs, const char *name,
 	spin_unlock(&xattrs->lock);
 	if (xattr) {
 		kfree(xattr->name);
-		kfree(xattr);
+		kvfree(xattr);
 	}
 	return err;
 
-- 
2.21.1

