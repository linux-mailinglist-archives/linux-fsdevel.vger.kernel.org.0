Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC43A59AF69
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiHTSNF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHTSM7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:12:59 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA8440549
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 11:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
        Cc:Content-Type:Content-ID:Content-Description;
        bh=lkrbM13kRxpZk8nawpVeouuB8/HH6PPprSDwKoQ/rnc=; b=GmZgVytf7I1LE4mpSSJobLmac0
        dzMarap+5EkxCXEleFRPH+nHdz/JLAWCidCdHYi9KNylvmwKI2pMSh5hnPvCeFZZcELL4WZQB/vLw
        0fV0OSaok4T8BHOdKwMeUVlUaod/VDYGMx5KP9kletr2X1M4UI8O9hAUTauMQE5dwBs0wh4vzQflt
        KTOIWKa9kZEkKbfazskJic3v4JXxCDN/HhIJErjJg+9+sAD6QX05ZpVPTZq9EsJLM9oIuol+PNde4
        uq8ioc1xfAKKHxBtiIfPeCFhdJ/t79jinBRT8T+3/SHNi/xCVAcn8oTjd6Wxtkv1vRwYMo2/2ElLm
        HtUuyQRg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSxt-006RVt-1s
        for linux-fsdevel@vger.kernel.org;
        Sat, 20 Aug 2022 18:12:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/11] do_proc_readlink(): constify path
Date:   Sat, 20 Aug 2022 19:12:51 +0100
Message-Id: <20220820181256.1535714-5-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
References: <YwEjnoTgi7K6iijN@ZenIV>
 <20220820181256.1535714-1-viro@zeniv.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index e347b8ce140c..2d9429bf51fa 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1761,7 +1761,7 @@ static const char *proc_pid_get_link(struct dentry *dentry,
 	return ERR_PTR(error);
 }
 
-static int do_proc_readlink(struct path *path, char __user *buffer, int buflen)
+static int do_proc_readlink(const struct path *path, char __user *buffer, int buflen)
 {
 	char *tmp = kmalloc(PATH_MAX, GFP_KERNEL);
 	char *pathname;
-- 
2.30.2

