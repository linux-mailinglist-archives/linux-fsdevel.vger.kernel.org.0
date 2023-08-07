Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088607725B7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Aug 2023 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjHGN3m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjHGN3P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:15 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE232111
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:53 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 078A1417BF
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414902;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=m3LMpvpYs8ZihyLzm+ZJNnErAyh/wDlEPA7Dibpn8TtSMaY3N2BRoTTss5YQ2tKOy
         RVV8BZXFm076z3vLY/AWWsWnzrYsiL3dE29mmJF+R3/uejyjcwmxXPWLtl+/PDE+Qh
         wC6ZJmdRh3OQfosT3lXY6AtKdpHLU4V+ap3pF6XYRGmf9mpiA9XdCU6eAcBBchUnDx
         uN3JxwAJsyC2C9O8k37cx1rKkyOGrhLvnszTQH1m+KOTW3fMIPUkZ/qvAgAag1K7hG
         fnIPz9Qtc6b6UY336aYBAeZ5a3vkShaR1lkwFDUfUKpxC0q2Vsqj0nn4vdJwb9PiGg
         2cyUm6NShyQJw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-99c01c680beso314956866b.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414901; x=1692019701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dyWOzKMsgYqMEu72C+uRJxx6NqzlAitmeRu8HoKY4M0=;
        b=VVaZ3KBVHzeE9y4bweeDpVfZT/LcpUE8Ma7jDHPFwbkkKXk3+nQ3xHCMFLivJ0y12A
         WwFW1S5VfBtXnmM26JIPiFDbhixLDNCv8Vov4Kp1kDCG9mkvZ7RftCo1ty2lG6iYzXNz
         nJFwie9baUtOJKLjmoMfYLXqWKT4s0Oh1o76Z76VVl3zjun3dJ7tD21KZdLSQEeUT0Jg
         HO0gwsj1ppxBj12x6uO+u4FQcR9bjnfP5Ok2i/3GJ/HQgpYv1oZxUjyLM5i1OiYQEuYV
         Au8Zt/VG1aotXU0pT46+sqWTOaSrt2z8vJudK8gjukVYgo3eQTCvbfj4wfg/xNRNkOhH
         OZfA==
X-Gm-Message-State: AOJu0Yx2boQ++R+WFm8rPdneRb3a3j5fcqxO/RH4rGLWh7RCNFtHURic
        vnUu55M7i7frPymaFiITQGLkQGglRZCzXiNIbgWgqsrBOK3lg/Uj3HCOuE6sqUtJmw0QIgoxlci
        iTEqZqf4nn5+tLQhK5xrXFWosaAw7P3O4MaKVBD5R3Nw=
X-Received: by 2002:a17:906:1011:b0:99c:3b4:940c with SMTP id 17-20020a170906101100b0099c03b4940cmr9039179ejm.7.1691414900866;
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3ADA4o2cJQwyFlv49UMgDsjmvjuXfeU1vTiwFnYE1XpiRQKXsUX4t+Epk7AEPPGhbvKUbow==
X-Received: by 2002:a17:906:1011:b0:99c:3b4:940c with SMTP id 17-20020a170906101100b0099c03b4940cmr9039165ejm.7.1691414900716;
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:20 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 07/12] ceph: allow idmapped permission inode op
Date:   Mon,  7 Aug 2023 15:26:21 +0200
Message-Id: <20230807132626.182101-8-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable ceph_permission() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

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

