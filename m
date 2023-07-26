Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929C2763885
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjGZOIz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234452AbjGZOH6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:58 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D9A30E2
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:17 -0700 (PDT)
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7767E3F71D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380435;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=W9RafNjLtZHBshHNd8IwAz/rNKL3aviPaFpsmi+8p8w61DiMv2rqkjtKJ5TeHDBlK
         M5VVfVMNkak9KYzdtUbo3vvzbRPOUb8KtKsp/9oga3AgSTPTpiqGst9q3TI7FDKXUk
         uR5+WEJIL+3AbFy0W/mNs/ppkUO8xTjGrJUPjA5BFz8Ldfc6l94Qgzy9RSrQdEU7TX
         NHuZVPwIhhaTc1p5WWOnXeJ0lz5dptWTwsMRqlkQgYbe73/b7k0V+mygBh0vXziZ8R
         sixJ/P8ni8LVek28Td0RYKoAnC1zQ27QlYotDLjRagaWL3VqoPorHH6ehgrRb+BE/H
         Th3g7AW65olig==
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b9b00a80e9so11011491fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380435; x=1690985235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Srcpafr6A4NJGaRIaUNnfkHMnBPsuuDlnOMtOvEnSSA=;
        b=UV6yskdiMBYe4C5OVnMAxGiQhGXpHH1vCvVO30I39KewE2FAKeoqZOVRfo/LnyZpwg
         7a6ZX+uSBuut8Mn3YIz6gC5YPIzImw497N/8yVuA81TZRWQxBgZ/7jiMAu1IDvjhi8TI
         g1ja4PhWaFwBTzPwrmdobSAAlNlz7dHXyguH9gN4HNMVsF2j1iA+01d7vrLU6auoH6tu
         yYPGPrzcgO0grwqdvFvydQspnYELaMqQFMrDl7Pt4RbmD0xli24tVATYeNo/6MpgIcdH
         0KVXnrHv8rht6Y7Tmxz3s/sgX5p/df2zeFa2z9UFvCoKyak4eQZAxcPM+ZpfdZt4JqRW
         mYNQ==
X-Gm-Message-State: ABy/qLYSaxxSoK0hnn6fmSU96N4TVm+At2L/SLd9PQjwCur7pypR5Ziy
        hH6ndojHkARnGIArilbDdwu7L7YIAfHOXtbNy+fEysO2ShaV/TPzOFnVw5UrAZ+PFTt7F3zG8of
        n+pFsv2NbrEOsKX4romk4Av6ROYf86W/L1ldNQ2ZHogk=
X-Received: by 2002:a2e:870c:0:b0:2b9:ad7d:a144 with SMTP id m12-20020a2e870c000000b002b9ad7da144mr1606212lji.11.1690380434952;
        Wed, 26 Jul 2023 07:07:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlELN9wiOUFPtGodTSSZ6rvp1SSx3S8CKT0CLTUuKvw0zAiBuftUjg/Yc9M0F52IiPn2QiGo6w==
X-Received: by 2002:a2e:870c:0:b0:2b9:ad7d:a144 with SMTP id m12-20020a2e870c000000b002b9ad7da144mr1606197lji.11.1690380434696;
        Wed, 26 Jul 2023 07:07:14 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id o22-20020a170906289600b00977c7566ccbsm9572931ejd.164.2023.07.26.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:07:14 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 06/11] ceph: allow idmapped permission inode op
Date:   Wed, 26 Jul 2023 16:06:44 +0200
Message-Id: <20230726140649.307158-7-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726140649.307158-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 136b68ccdbef..9b50861bd2b5 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -2977,7 +2977,7 @@ int ceph_permission(struct mnt_idmap *idmap, struct inode *inode,
 	err = ceph_do_getattr(inode, CEPH_CAP_AUTH_SHARED, false);
 
 	if (!err)
-		err = generic_permission(&nop_mnt_idmap, inode, mask);
+		err = generic_permission(idmap, inode, mask);
 	return err;
 }
 
-- 
2.34.1

