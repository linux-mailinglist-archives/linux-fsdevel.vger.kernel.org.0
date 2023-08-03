Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E9A76EB99
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Aug 2023 16:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbjHCOBf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Aug 2023 10:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbjHCOBV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466C830E9
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:44 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 952B442482
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071228;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=gI5zM2pRwUCwl5VFAatFvkhZX8N4UtTOu9zj0c5rtyzUtKG4RdyIFEkT6L/E5WjTK
         ueMdD02pLPVk+AL2CB0e5SG58JPgVNpCZZOH4tUjxI6vPOhj3u74PaIiFzI/JRlDku
         CezAcq18Y3FRzSh2BEKrM9aY87XNQ6hAheAb0fYJl51er2OCIQ9VDJ2Z0yG6etm5ZS
         o8iFF15lA+NSRbmfFy3gqNrc2FpHgAw2EaLcdd8WgPBB4FBD6ZguH6ZpCX41lz5D3l
         TL14diNa76ARdB3bEDZUIYVLMJwwEdpbhXhN79k/Nwv96lgPoEZYbFo8zlAyIy1f6y
         2eNJa7h+C1lhQ==
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4fe3fb358easo1056101e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071225; x=1691676025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        b=CHnsfg4UMRCXvLlZ7+ZwYRZHTPU0f/8xuxwYQWoe+i2cKqlO3DP+x25MWjSPbkXHgp
         qCcXzF4jiSHCzF4PQwdR683ewW8auFjGag1Mk6dpa2E7T8tlA6nFBU2M8EJfhnCSLuD/
         2ZQU67ho+2YSByTw2LlFSNThm/uZf59kVrSLy4itXMCimRucj+UYPNw30FEu0PHZ5Xlf
         ykP7ibw8EhBDhuVQ6xzz2LB+fOkFWkwzKpV1f6UkTIzi49nMXEwacv50pxvv2mSexDhp
         lxCtorOBh5Eed/wTp26cJve3bT2g6iRnYRMwelL72c0eEbpDSX+x4ndt8oyGEVYTlKe2
         8mLQ==
X-Gm-Message-State: ABy/qLaFUEM4ORqp9JDtfQwU9PTMaC4VvznF+BsBXQ1OIz2vH3ZHERz6
        uxeJBgpMRkkUjE18oGxsyHNfOra1fO28MaXc9MNj4hm/xWblwzoe3IDcndnm8D6i/TvvbGUFTyc
        pXSAGi/expexD2amGmk2VCQMZXAIU1l9f0/h/7vVVPbw=
X-Received: by 2002:a19:504a:0:b0:4fb:94fd:645f with SMTP id z10-20020a19504a000000b004fb94fd645fmr6531919lfj.68.1691071225619;
        Thu, 03 Aug 2023 07:00:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGwj0wtDI8iNxIwzK1IOpeEx1Ty6UrtKDYlpyeVt4cmW1eycKEacTWhMO/37ZGK1a8a68Q6A==
X-Received: by 2002:a19:504a:0:b0:4fb:94fd:645f with SMTP id z10-20020a19504a000000b004fb94fd645fmr6531906lfj.68.1691071225425;
        Thu, 03 Aug 2023 07:00:25 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:25 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 06/12] ceph: allow idmapped getattr inode op
Date:   Thu,  3 Aug 2023 15:59:49 +0200
Message-Id: <20230803135955.230449-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 3ff4f57f223f..136b68ccdbef 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3034,7 +3034,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

