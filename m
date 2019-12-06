Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE29114F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 11:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfLFK3k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 05:29:40 -0500
Received: from sender3-of-o52.zoho.com.cn ([124.251.121.247]:21975 "EHLO
        sender3-of-o52.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726070AbfLFK3k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575628158; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=IZEy3QZ3J47fpW+qbqfI1LOttkrGY4QobvgiWNAsWkcSfysL3DnO3iEFuYIv14WygbDsmdj/pSHdaJ9PkkjOgzFEWvPKkIWrdsE2Sx+oHUrYF+NoMhH5rM9kOJnv5OSMxqpxCxpqjYtLyuADxqVCmHNTjeiIbFeEAzR9fX4c9WE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1575628158; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=CkddfBUZ2zqTXn+3P06cHvItR6pF/RM8ZPOsJF9opfQ=; 
        b=WBmPVWeMCefmDAk2pwCqIVQkkpURzsOLb+HcsPw3elJ3rLt1sxeOEstZtCeK3C3AjrJaFO+sWxUbhfYJYmizsbZuqoplSaqj6LVEHiqJrPnm12b/+ByNNMieKFQlJQm4PRf4Nk/YSl/xV7EWvtL9mMIveo1aiYOsN0x0gm7/b1A=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1575628158;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
        l=728; bh=CkddfBUZ2zqTXn+3P06cHvItR6pF/RM8ZPOsJF9opfQ=;
        b=RDbz2wjNailC6swYRIV7GRE0Sm1A/G4MZnp/Lmlq9SywtHHk4GmjSsIfJBHfT3cg
        kn4flD6HbctK/K12ze/4VLp0TrEqH8g9mTuS5hqZkFA3KN9vTS2abIS9We2mYIsJVUC
        wmLyeoxA6RMsvSm/Sk5XJ/czfzwtE3nebmMFRtEE=
Received: from localhost.localdomain (218.18.229.179 [218.18.229.179]) by mx.zoho.com.cn
        with SMTPS id 1575628157028159.99300615517643; Fri, 6 Dec 2019 18:29:17 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     willy@infradead.org
Cc:     linux-fsdevel@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Message-ID: <20191206102903.9492-1-cgxu519@mykernel.net>
Subject: [PATCH] xarray: Fix incorrect comment in header file
Date:   Fri,  6 Dec 2019 18:29:03 +0800
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

256 means Retry entry and 257 means Zero entry,
so fix it.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 include/linux/xarray.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/xarray.h b/include/linux/xarray.h
index 86eecbd98e84..c443840a1cae 100644
--- a/include/linux/xarray.h
+++ b/include/linux/xarray.h
@@ -32,8 +32,8 @@
  * The following internal entries have a special meaning:
  *
  * 0-62: Sibling entries
- * 256: Zero entry
- * 257: Retry entry
+ * 256: Retry entry
+ * 257: Zero entry
  *
  * Errors are also represented as internal entries, but use the negative
  * space (-4094 to -2).  They're never stored in the slots array; only
--=20
2.20.1



