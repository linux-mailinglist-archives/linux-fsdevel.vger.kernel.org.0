Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6877638A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjGZOMY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232594AbjGZOLz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:55 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37513C0C
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:19 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3946042476
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380651;
        bh=ohgjgBD3cKcnIyJjD+KXey+VVqMnSRq4bkvBBBDC3os=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=njUYy2BKrX7GRjJ8+ItwOGZqi+B0RJYA85xz1oEW1Ik/5FczinJI6pFknjzVp8TZ2
         ocRTdn9qxYcA0oDWDLW3ratUwRMWxiiQQdub7lhebiJDRAcs0tAdbsN9B9BfWTBxnn
         N+FRZB4oVkCCKEGORRZh8JyNnuFtotJISvjruRbb5QAkYnfETPk2FUuRir+LhLDOlP
         Z3FSCF3UKE5YhkybQHrSrrmIqgT8r4Q6xlSyHtWHqVQJU8FKIiYfGTwSjh0+XOgwIn
         b7AKyRpw9QaA8v+zywXDoGg4IR5Yfc8OGp7z7k++m9H1qzuDM4uav4ef6Dy9KuZCFI
         2Xb5gGppNBUnQ==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9aa4db031so19708891fa.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380646; x=1690985446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ohgjgBD3cKcnIyJjD+KXey+VVqMnSRq4bkvBBBDC3os=;
        b=jdyGyIqVLVKlfI3SoShT+1R8Trs+RFFCci0zgfNdlPqb+jWYzv4yJdCEAE0rp6x2jL
         Z2I8VTPZaf3dj/ATd5uqWmOyAQF+ZLzu2Y9HFHylTeCxwak25M3F7p/sCPzZWrvhjl4o
         NElXWLog0liaQfDBVQ92mANaTMpQ2/Q+LG2bmvSq7iGqVBz0XHdIuckKpJ6hEeFsmuhR
         ZvajLGf2aCaGIrqm1Mn4rpcue8i3gC+KMSdcDW+Kz82sdK/cv5fZKT+0rKIbSYyHBCbX
         UySSvXXVtEvm/YjLlH1gJqCJieupC2e3YaZhzrpG62qEhjGvSMA4cXytpITlmoxO8kEl
         +TqQ==
X-Gm-Message-State: ABy/qLZAM6tJnkSPLZi6ExvIgQPV1A0x1xTU4lGfh7jufVxcjP7+3DLi
        Ef0WyLz1WaB39Hi86QfR/p8+nwy1b+PQ3OtdIvczk1UAldHteQi6i5FKiJwBNaSag5tKZ444U+h
        ldFVKDMGSBaSpd1h+NwETGxFNVO4uJ5pBCSEp+bbWvKI=
X-Received: by 2002:a2e:b04c:0:b0:2b6:e292:85ab with SMTP id d12-20020a2eb04c000000b002b6e29285abmr1537994ljl.25.1690380645932;
        Wed, 26 Jul 2023 07:10:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHjzzs2yes8HeiVNPDXX4N2hJrs8Ktc9SJJ6ywzY4b/f8BHmmRmZgH59CuUg0VsaN9+mCvkrA==
X-Received: by 2002:a2e:b04c:0:b0:2b6:e292:85ab with SMTP id d12-20020a2eb04c000000b002b6e29285abmr1537979ljl.25.1690380645680;
        Wed, 26 Jul 2023 07:10:45 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:45 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 05/11] ceph: allow idmapped getattr inode op
Date:   Wed, 26 Jul 2023 16:10:20 +0200
Message-Id: <20230726141026.307690-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

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

