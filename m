Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82158DAF5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 17:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244827AbiHIPUX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244835AbiHIPUT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:20:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0E8C66;
        Tue,  9 Aug 2022 08:20:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id j8so22779549ejx.9;
        Tue, 09 Aug 2022 08:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DrjfGz/NaZQxMhh3hlQHeDNyMbOnbKG2/DNRFkKmXb0=;
        b=jCB2IOAdMlXzVuzrxy2Yo2ch/+fbK1OtPXpMRQFeg+nXavwSHWbWZeZbx3ddM4JPF+
         7ETH/5O3LT9aZ7OR9JuNTj07X0I2sbJJ8haeNWHHPAx/aFVLp5y9+UTHLAO8pJmEPURi
         pAV/IhVmfwzIN4t09xfTZft3rtCma4fOnV3i5ED66WAUDV7laRgRyeqKGDMYjj+xJNSq
         TNUaeZjaNZ5Kq0AZMmLfvl+LpbzO5fIh9KV9MbV5h1v95UU+f+M/WUsXqVlGI8EQJyPP
         RfAii03/5qakDnZHfkIqLDzTsoUvfIpV2HQETDuM72jqBJZZ73GV+nunfqGRVleZJX3i
         yHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DrjfGz/NaZQxMhh3hlQHeDNyMbOnbKG2/DNRFkKmXb0=;
        b=t5XEve/DuYCI1L5beDuYHIJSXZAV9wfAuz3Sf9iHAmoaOI1fmc/yxmdEfBnaxLZyDf
         TKAVxyd3XRzWtzJdRE/hCxHgxkKPf9V77wsCnHR40VQDwfnH3Xa2tna6SGzCp7q5QbTi
         BtJ2yPM414RKTvvlPsqp7pdpEf+zSJrHfuPWvkjBNUW4J/X1ILIUMTLejUyjQtrxPj0V
         hq90M+z39Z/HuGeYDN9tWbkWQmAJi/eI113HqE9kqoSXTXD6/gSMeEMfxO/ffFvdI5vO
         1GY875leVSfB76g2bexUxIAxr0pdHsO459WUIrxxGaEtSA7r7ZAWGyPAAzs7f+pYjP+9
         unKQ==
X-Gm-Message-State: ACgBeo1Dx0GyqSzwTqD1dHSOGz4QP2GfS3iPm4imvkdfCnSz4uUIikz2
        pdMQnT9cI27sBsUzgqUNqreaVQFBEko=
X-Google-Smtp-Source: AA6agR5jrBcz3sqlDOfIbd0YJDEr+G9QbyAvfoMR+Ym2M/ZGOUVOuUXypC4nMIYuCEvqavH/3JMOZg==
X-Received: by 2002:a17:907:94ca:b0:731:8395:d526 with SMTP id dn10-20020a17090794ca00b007318395d526mr4112301ejc.389.1660058415920;
        Tue, 09 Aug 2022 08:20:15 -0700 (PDT)
Received: from localhost.localdomain (host-79-27-108-198.retail.telecomitalia.it. [79.27.108.198])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906721500b0073093eaf53esm1222162ejk.131.2022.08.09.08.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 08:20:14 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jeff Layton <jlayton@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Muchun Song <songmuchun@bytedance.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH 1/3] hfs: Unmap the page in the "fail_page" label
Date:   Tue,  9 Aug 2022 17:20:02 +0200
Message-Id: <20220809152004.9223-2-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220809152004.9223-1-fmdefrancesco@gmail.com>
References: <20220809152004.9223-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Several paths within hfs_btree_open() jump to the "fail_page" label
where put_page() is called while the page is still mapped.

Call kunmap() to unmap the page soon before put_page().

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 fs/hfs/btree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 19017d296173..56c6782436e9 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -124,6 +124,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	return tree;
 
 fail_page:
+	kunmap(page);
 	put_page(page);
 free_inode:
 	tree->inode->i_mapping->a_ops = &hfs_aops;
-- 
2.37.1

